rm(list = ls())

# setwd("C:/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Econometría/10. Microeconometría II/Examen/Datos")
setwd("D:/Box/Maestria_en_Econometria_UTDT/10. Microeconometría II/Examen/Datos")

# install.packages(c("fixest", "did", "didimputation", "etwfe", "marginaleffects"))
library(fixest)
library(did)
library(didimputation)
library(etwfe)

seed <- 2205

################################################################################
#                         DATA-GENERATING PROCESSES                            #
################################################################################

# Globales
reps    <- 100                      # repeticiones por celda (N, T, ATT)
models  <- c("hom", "het")
estims  <- c("twfe", "cs", "bjs", "jw")
samples <- c(50, 500)
periods <- seq(2, 30, by = 2)
ATTs    <- c(0.2, 0.5, 0.8)
results <- c("figure3", "figure5", "table3", "figure11")

correr_simulaciones <- TRUE         # FALSE: usa los .rds guardados de una corrida previa

conf  <- 0.95
alpha <- 1 - conf
z     <- qnorm(1 - alpha / 2)

# Stata: round(x) redondea .5 hacia arriba
redondear <- function(x) floor(x + 0.5)


################################################################################
#                                 PROGRAMA                                     #
################################################################################

# Una réplica: genera los datos y devuelve ATT y EE de cada modelo/estimador
simulation <- function(N, T, att) {
  NT <- N * T
  d <- data.frame(id = rep(1:N, each = T), t = rep(1:T, times = N))

  # Efectos fijos por id y por t, y error
  d$alpha   <- d$id / 10
  d$gamma   <- rnorm(T)[d$t]
  d$epsilon <- rnorm(NT)

  # Modelo homogéneo
  d$Treated <- as.numeric(d$id > N / 2)
  g_id <- ifelse(1:N > N / 2, 1 + ceiling(runif(N) * (T - 1)), 0)
  d$g_hom <- g_id[d$id]
  d$g_hom_m <- ifelse(d$g_hom == 0, NA, d$g_hom)
  d$D_hom <- d$Treated * as.numeric(d$t >= d$g_hom)

  # Modelo heterogéneo
  delta <- redondear((N / 2) / (T - 1))
  d$g_het <- ifelse(d$Treated == 1, 2 + trunc((d$id - (N / 2 + 1)) / delta), 0)
  d$g_het_m <- ifelse(d$g_het == 0, NA, d$g_het)
  mean_effect <- mean(d$id[d$g_het > 0] - N / 2)
  d$tau <- 0
  d$tau[d$Treated == 1] <- (d$id[d$Treated == 1] - N / 2) * (att / mean_effect)
  en_rango <- d$id >= N / 2 + 1 & d$id <= N / 2 * 1.2
  d$tau[en_rango] <- d$tau[en_rango] - 10 * att
  d$tau[d$id > N * 0.98] <- d$tau[d$id > N * 0.98] + 5 * 10 * att
  d$D_het <- d$Treated * as.numeric(d$t >= d$g_het)

  # Variable dependiente
  d$y_hom <- att * d$D_hom + d$alpha + d$gamma + d$epsilon
  d$y_het <- d$tau * d$D_het + d$alpha + d$gamma + d$epsilon

  out <- c()
  seguro <- function(expr) tryCatch(suppressWarnings(suppressMessages(expr)),
                                    error = function(e) c(NA_real_, NA_real_))

  for (model in models) {
    dd <- d
    dd$y  <- dd[[paste0("y_", model)]]
    dd$D  <- dd[[paste0("D_", model)]]
    dd$g  <- dd[[paste0("g_", model)]]
    dd$gm <- dd[[paste0("g_", model, "_m")]]

    # TWFE
    r <- seguro({
      m <- feols(y ~ D | id + t, data = dd, cluster = ~id)
      c(coef(m)[["D"]], se(m)[["D"]])
    })
    out[paste0("att_", model, "_twfe")] <- r[1]; out[paste0("se_", model, "_twfe")] <- r[2]

    # CS (Callaway-Sant'Anna, método regresión, grupo de control nunca tratados)
    r <- seguro({
      res <- att_gt(yname = "y", tname = "t", idname = "id", gname = "g", data = dd,
                    est_method = "reg", control_group = "nevertreated",
                    bstrap = FALSE, cband = FALSE)
      ag <- aggte(res, type = "simple", na.rm = TRUE, bstrap = FALSE, cband = FALSE)
      c(ag$overall.att, ag$overall.se)
    })
    out[paste0("att_", model, "_cs")] <- r[1]; out[paste0("se_", model, "_cs")] <- r[2]

    # BJS (Borusyak-Jaravel-Spiess, imputación)
    r <- seguro({
      m <- did_imputation(data = dd, yname = "y", gname = "gm", tname = "t", idname = "id")
      c(m$estimate[1], m$std.error[1])
    })
    out[paste0("att_", model, "_bjs")] <- r[1]; out[paste0("se_", model, "_bjs")] <- r[2]

    # JW (Wooldridge, ETWFE, grupo de control nunca tratados, efectos fijos de grupo)
    r <- seguro({
      m <- etwfe(fml = y ~ 0, tvar = t, gvar = g, data = dd, cgroup = "never")
      e <- emfx(m, type = "simple")
      c(e$estimate[1], e$std.error[1])
    })
    out[paste0("att_", model, "_jw")] <- r[1]; out[paste0("se_", model, "_jw")] <- r[2]
  }
  out
}


################################################################################
#                               SIMULACIONES                                   #
################################################################################

# Filas en el mismo orden que el .do: modelo > estimador > ATT
filas <- unlist(lapply(models, function(m)
  unlist(lapply(estims, function(e)
    paste0("att", round(ATTs * 10), "_", m, "_", e)))))

nombre_res <- c(figure3 = "ATT_Bias", figure5 = "SE_Bias",
                table3 = "Coverage_Proba", figure11 = "Statistical_Power")

for (N in samples) {

  archivo_rds <- sprintf("results_N%d_simulaciones_R.rds", N)

  if (correr_simulaciones) {

    # Matrices de resultados (filas = modelo/estimador/ATT, columnas = T)
    mats <- list()
    for (r in results) {
      mats[[r]] <- matrix(NA_real_, nrow = length(filas), ncol = length(periods),
                          dimnames = list(paste0(nombre_res[r], "_", filas),
                                          paste0("T_", periods)))
    }
    base <- list()

    for (i in seq_along(periods)) {
      T <- periods[i]
      for (att in ATTs) {
        att_aux <- round(att * 10)
        cat(sprintf("Simulación: N=%d - T=%d - ATT=%s\n", N, T, att))

        set.seed(seed)
        sims <- t(replicate(reps, simulation(N, T, att)))
        base[[sprintf("T%d_att%d", T, att_aux)]] <- sims

        for (m in models) for (e in estims) {
          fila <- paste0("att", att_aux, "_", m, "_", e)
          a <- sims[, paste0("att_", m, "_", e)]
          s <- sims[, paste0("se_", m, "_", e)]
          sd_att <- sd(a, na.rm = TRUE)

          # Figure 3 (ATT Bias)
          mats$figure3[paste0("ATT_Bias_", fila), i] <- mean(a, na.rm = TRUE) - att
          # Figure 5 (SE Bias)
          mats$figure5[paste0("SE_Bias_", fila), i] <- mean(s, na.rm = TRUE) - sd_att
          # Table 3 (Coverage Probability)
          ic_inf <- a - z * s; ic_sup <- a + z * s
          mats$table3[paste0("Coverage_Proba_", fila), i] <-
            sum(att >= ic_inf & att <= ic_sup, na.rm = TRUE) / reps
          # Figure 11 (Statistical Power): el estadístico t usa el desvío de las
          # estimaciones simuladas, como en el .do
          p <- 2 * pt(abs(a / sd_att), df = N - 1, lower.tail = FALSE)
          mats$figure11[paste0("Statistical_Power_", fila), i] <-
            sum(p < alpha, na.rm = TRUE) / reps
        }
      }
    }

    saveRDS(list(mats = mats, base = base), archivo_rds)

    # Guardar bases y matrices (con sufijo _R para no pisar los .dta de Stata)
    write.csv(do.call(cbind, lapply(names(base), function(n) {
      b <- base[[n]]; colnames(b) <- paste0(colnames(b), "_", n); b
    })), sprintf("results_N%d_base_R.csv", N), row.names = FALSE)
    for (r in results) {
      mt <- data.frame(T = periods, t(mats[[r]]), check.names = FALSE)
      write.csv(mt, sprintf("results_N%d_matriz_%s_R.csv", N, r), row.names = FALSE)
    }
  }
}


################################################################################
#                                EJERCICIOS                                    #
################################################################################

dir.create("../Figuras", showWarnings = FALSE, recursive = TRUE)

colores <- c(twfe = "black", cs = "blue", bjs = "green", jw = "orange")

for (N in samples) {

  mats <- readRDS(sprintf("results_N%d_simulaciones_R.rds", N))$mats

  for (r in results) {

    cat(sprintf("Corriendo: N=%d - result=%s\n", N, r))

    if (r != "table3") {

      var <- nombre_res[[r]]
      yline <- if (r == "figure11") 0.8 else 0

      for (att in ATTs) {
        att_aux <- round(att * 10)
        for (model in models) {

          # Límites del eje Y (idénticos a los del .do): c(mínimo, máximo, paso)
          if (r == "figure11") {
            lim <- c(0, 1, 0.2)
          } else if (model == "hom") {
            lim <- if (r == "figure3") c(-0.2, 0.2, 0.1) else c(-0.1, 0.1, 0.05)
          } else {
            lim <- if (r == "figure3" && N == 50)       c(-4.0, 0.5, 0.5)
                   else if (r == "figure5" && N == 50)  c(-0.3, 1.5, 0.3)
                   else if (r == "figure3" && N == 500) c(-3.0, 0.5, 0.5)
                   else                                  c(-0.1, 0.5, 0.1)
          }
          m_titulo <- if (model == "hom") "Constant Effects" else "Heterogeneous Effects"
          # sufijo _R para no pisar los .png generados por Stata
          arch <- sprintf("../Figuras/%s_N%d_att%d_%s_R.png", r, N, att_aux, model)

          png(arch, width = 800, height = 600)
          plot(NA, xlim = c(2, 30), ylim = lim[1:2], xaxt = "n", yaxt = "n",
               xlab = "Time Periods", ylab = gsub("_", " ", var),
               main = sprintf("ATT=%s - %s", att, m_titulo))
          axis(1, at = seq(2, 30, by = 4))
          axis(2, at = seq(lim[1], lim[2], by = lim[3]), las = 1)
          abline(h = yline, col = "red")
          for (e in estims) {
            fila <- sprintf("%s_att%d_%s_%s", var, att_aux, model, e)
            lines(periods, mats[[r]][fila, ], col = colores[[e]])
          }
          legend("top", legend = c("TWFE", "CS", "BJS", "JW"), col = colores,
                 lty = 1, horiz = TRUE, bty = "n")
          dev.off()
        }
      }

    } else {

      # TABLE 3 (ATT = 0.5; T = 2, 10, 20, 30)
      var <- "Coverage_Proba"
      att_aux <- 5
      per <- c(2, 10, 20, 30)
      tabla <- matrix(NA_real_, nrow = length(per), ncol = length(models) * length(estims),
                      dimnames = list(paste0("T_", per),
                                      as.vector(sapply(models, function(m)
                                        paste0(toupper(estims), "_", m)))))
      for (i in seq_along(per)) {
        k <- 1
        for (m in models) for (e in estims) {
          fila <- sprintf("%s_att%d_%s_%s", var, att_aux, m, e)
          tabla[i, k] <- round(mats$table3[fila, paste0("T_", per[i])], 3)
          k <- k + 1
        }
      }
      cat(sprintf("\nTable 3 (N = %d)\n", N))
      print(tabla)
    }
  }
}
