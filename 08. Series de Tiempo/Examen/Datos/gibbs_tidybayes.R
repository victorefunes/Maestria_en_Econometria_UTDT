# =============================================================================
# Replica de TODOS los resultados de Gibbs sampling en un solo archivo,
# usando tidybayes / posterior / ggdist para resumir y graficar los draws.
#
# Nota: tidybayes NO genera draws; ordena, resume y grafica draws posteriores.
# Los samplers (Albert y Chib 1993; Chang-Jin Kim) siguen siendo los de los
# programas GAUSS originales, escritos aca en R. Cada modelo usa la misma
# semilla que su script individual, asi que los numeros coinciden con ellos.
#
# Modelos:
#   1. AR(4) sobre crecimiento del PBI de EEUU        (gbs_ar4)
#   2. Demanda de dinero en niveles                    (gbs_ar4_ej5ab)
#   3. Demanda de dinero en tasas de crecimiento       (gbs_ar4_ej5c1)
#   4. Idem con d(i_t)                                 (gbs_ar4_ej5c2)
#   5. 3 regimenes de varianza, Merval                 (gibs_s3_modify)
#   6. 3 regimenes de varianza, CRSP                   (gibs_s3)
#
# Salidas: gibbs_tidybayes_resumenes.csv, gibbs_tidybayes_graficos.pdf
# =============================================================================

library(dplyr)
library(tidyr)
library(ggplot2)
library(posterior)
library(tidybayes)
library(ggdist)

ruta <- "D:/Box/Maestria_en_Econometria_UTDT/08. Series de Tiempo/Examen/Datos"
if (dir.exists(ruta)) setwd(ruta)

# Muestra para los modelos 2-4: "completa" (1962q1-2014q4),
# "sub1" (1962q1-1979q3) o "sub2" (1982q4-2014q4)
muestra <- "completa"


# =============================================================================
# 1. SAMPLERS
# =============================================================================

# --- Regresion lineal bayesiana: Y = X beta + e, e ~ N(0, sig2) -----------------
# Prior beta ~ N(beta0, R0); sig2 ~ inv-gamma(nu0, d0).
# estacionario = TRUE rechaza draws de beta con raices AR de modulo < 1.0001.
gibbs_lm <- function(Y, X, R0, beta0, nu0 = 0, d0 = 0, sig2 = 0.5,
                     N0 = 500, MM = 1500, estacionario = FALSE) {
  Y <- as.matrix(Y); X <- as.matrix(X)
  k <- ncol(X); T <- nrow(Y)
  R0inv <- solve(R0); XtX <- crossprod(X); XtY <- crossprod(X, Y)
  beta0 <- matrix(beta0, ncol = 1)

  betamm <- matrix(NA_real_, MM, k); sig2mm <- numeric(MM)
  for (itr in seq_len(N0 + MM)) {
    V     <- solve(R0inv + XtX / sig2)
    beta1 <- V %*% (R0inv %*% beta0 + XtY / sig2)
    C     <- chol(V)
    repeat {
      beta <- beta1 + t(C) %*% rnorm(k)
      if (!estacionario) break
      if (min(Mod(polyroot(c(1, -beta[2:k])))) >= 1.0001) break
    }
    sig2 <- (d0 + sum((Y - X %*% beta)^2)) / rchisq(1, T + nu0)
    if (itr > N0) { betamm[itr - N0, ] <- beta; sig2mm[itr - N0] <- sig2 }
  }
  cbind(betamm, sig2mm)
}

# --- 3 regimenes de varianza con cambio markoviano (Kim) ------------------------
# P[a, b] = Pr(s_t = b | s_{t-1} = a); estados 1/2/3 = varianza baja/media/alta
gibbs_ms3 <- function(yy, N0 = 100, MM = 1000,
                      P_ini = c(p11 = 0.9, p12 = 0.05, p21 = 0.05, p22 = 0.9,
                                p31 = 0.1, p32 = 0.1),
                      sig1 = 0.001, h2 = 0.9, h3 = 2.5, mu = 0) {
  T <- length(yy)
  U <- 1                                  # todos los priors de transicion valen 1
  P <- rbind(c(P_ini["p11"], P_ini["p12"], 1 - P_ini["p11"] - P_ini["p12"]),
             c(P_ini["p21"], P_ini["p22"], 1 - P_ini["p21"] - P_ini["p22"]),
             c(P_ini["p31"], P_ini["p32"], 1 - P_ini["p31"] - P_ini["p32"]))
  sig2 <- sig1 * (1 + h2); sig3 <- sig2 * (1 + h3)

  fnl <- matrix(NA_real_, N0 + MM, 9,
                dimnames = list(NULL, c("P1_1", "P1_2", "P2_1", "P2_2",
                                        "P3_1", "P3_2", "SIG1", "SIG2", "SIG3")))
  s1mm <- s2mm <- s3mm <- sigmamm <- stetmm <- numeric(T)

  # draw de (1 + h): inversa-gamma truncada a (1, cota); 100 intentos y luego 1.01
  gen_h <- function(ehat, cota) {
    nn <- length(ehat); d <- sum(ehat^2); jj <- 1
    repeat {
      s2 <- d / rchisq(1, nn)
      if (s2 > 1 && s2 < cota) break
      if (jj > 100) { s2 <- 1.01; break }
      jj <- jj + 1
    }
    s2
  }

  # estados: filtro de Hamilton hacia adelante + muestreo hacia atras
  gen_st <- function(P, sig) {
    Q <- t(P)                             # Q[i, j] = Pr(s_t = i | s_{t-1} = j)
    A <- rbind(diag(3) - Q, rep(1, 3))
    steady <- drop(solve(crossprod(A), crossprod(A, c(0, 0, 0, 1))))
    flt <- matrix(0, 3, T)
    for (t in seq_len(T)) {
      dens <- exp(-0.5 * (yy[t] - mu)^2 / sig) / sqrt(2 * pi * sig)
      pv   <- dens * Q * matrix(steady, 3, 3, byrow = TRUE)
      steady <- rowSums(pv / sum(pv))
      flt[, t] <- steady
    }
    s <- integer(T)
    s[T] <- sample.int(3, 1, prob = flt[, T])
    for (t in (T - 1):1) s[t] <- sample.int(3, 1, prob = P[, s[t + 1]] * flt[, t])
    s
  }

  for (itr in seq_len(N0 + MM)) {
    s  <- gen_st(P, c(sig1, sig2, sig3))
    S1 <- as.numeric(s == 1); S2 <- as.numeric(s == 2); S3 <- as.numeric(s == 3)

    e    <- (yy - mu) / sqrt(1 + S2 * h2) / sqrt((1 + S3 * h2) * (1 + S3 * h3))
    sig1 <- sum(e^2) / rchisq(1, length(e))
    eh   <- (yy - mu) / sqrt(sig1) / sqrt(1 + S3 * h3)
    h2   <- gen_h(eh[(S2 + S3) != 0], cota = 4) - 1
    eh   <- (yy - mu) / sqrt(sig1 * (1 + S3 * h2))
    h3   <- gen_h(eh[S3 != 0], cota = Inf) - 1

    sig2 <- sig1 * (1 + h2); sig3 <- sig1 * (1 + h2) * (1 + h3)
    sigmatt <- S1 * sig1 + S2 * sig2 + S3 * sig3

    tm <- matrix(0, 3, 3)
    for (t in 2:T) tm[s[t - 1], s[t]] <- tm[s[t - 1], s[t]] + 1
    p11 <- rbeta(1, tm[1, 1] + U, tm[1, 2] + tm[1, 3] + U)
    p12 <- rbeta(1, tm[1, 2] + U, tm[1, 3] + U) * (1 - p11)
    p22 <- rbeta(1, tm[2, 2] + U, tm[2, 1] + tm[2, 3] + U)
    p21 <- rbeta(1, tm[2, 1] + U, tm[2, 3] + U) * (1 - p22)
    p33 <- rbeta(1, tm[3, 3] + U, tm[3, 2] + tm[3, 1] + U)
    p32 <- rbeta(1, tm[3, 2] + U, tm[3, 1] + U) * (1 - p33)
    P <- rbind(c(p11, p12, 1 - p11 - p12), c(p21, p22, 1 - p21 - p22),
               c(1 - p32 - p33, p32, p33))

    fnl[itr, ] <- c(p11, p12, p21, p22, 1 - p32 - p33, p32, sig1, sig2, sig3)
    if (itr > N0) {
      s1mm <- s1mm + S1; s2mm <- s2mm + S2; s3mm <- s3mm + S3
      sigmamm <- sigmamm + sigmatt
      stetmm  <- stetmm + (yy - mu) / sqrt(sigmatt)
    }
  }
  list(draws = fnl[(N0 + 1):(N0 + MM), ],
       aux = tibble(t = seq_len(T), S1 = s1mm / MM, S2 = s2mm / MM, S3 = s3mm / MM,
                    sigma = sigmamm / MM, stdret = stetmm / MM, retorno = yy))
}


# =============================================================================
# 2. TIDYBAYES: resumenes y graficos
# =============================================================================

# Matriz de draws -> draws_df (formato que entiende tidybayes)
a_draws <- function(mat, nombres = colnames(mat)) {
  colnames(mat) <- nombres
  as_draws_df(as.data.frame(mat))
}

# Resumen posterior con thinning (1 de cada 5 draws, empezando por el 1ro).
# Columnas: media, sd, mediana y, si con_qi, extremos de intervalos 80/90/95%
# (equivalen a los cuantiles 0.10/0.90, 0.05/0.95, 0.025/0.975).
resumen_tidy <- function(draws, thin = 5, con_qi = FALSE) {
  vars <- variables(draws)
  largo <- draws |> thin_draws(thin) |> tidy_draws() |> gather_variables() |>
    mutate(.variable = factor(.variable, levels = vars))
  res <- largo |> group_by(.variable) |>
    summarise(mean = mean(.value), sd = sd(.value), mediana = median(.value),
              .groups = "drop")
  if (con_qi) {
    qi <- largo |> group_by(.variable) |>
      median_qi(.value, .width = c(0.80, 0.90, 0.95)) |>
      mutate(.width = .width * 100) |>
      pivot_wider(id_cols = .variable, names_from = .width,
                  values_from = c(.lower, .upper), names_sep = "_")
    res <- left_join(res, qi, by = ".variable")
  }
  res
}

# Traza + densidad posterior (stat_halfeye) de cada parametro
graficos_cadena <- function(draws, titulo) {
  largo <- draws |> tidy_draws() |> gather_variables() |>
    mutate(.variable = factor(.variable, levels = variables(draws)))
  print(ggplot(largo, aes(.iteration, .value)) + geom_line(linewidth = 0.2) +
          facet_wrap(~.variable, scales = "free_y") +
          labs(title = paste(titulo, "- trazas"), x = "iteracion", y = NULL) +
          theme_minimal())
  print(ggplot(largo, aes(x = .value)) + stat_halfeye(.width = c(0.80, 0.95)) +
          facet_wrap(~.variable, scales = "free") +
          labs(title = paste(titulo, "- distribucion posterior"), x = NULL, y = NULL) +
          theme_minimal())
}

# Graficos del modelo de 3 regimenes
graficos_ms3 <- function(aux, titulo) {
  print(aux |> select(t, S1, S2, S3) |>
          pivot_longer(-t, names_to = "estado", values_to = "prob") |>
          ggplot(aes(t, prob, colour = estado)) + geom_line() +
          labs(title = paste(titulo, "- probabilidades filtradas"), x = NULL, y = NULL) +
          theme_minimal())
  print(aux |> transmute(t, Volatility = sigma, `Returns (x0.1)` = 0.1 * retorno) |>
          pivot_longer(-t, names_to = "serie", values_to = "valor") |>
          ggplot(aes(t, valor, colour = serie)) + geom_line(linewidth = 0.3) +
          labs(title = paste(titulo, "- volatilidad y retornos"), x = NULL, y = NULL) +
          theme_minimal())
}


# =============================================================================
# 3. DATOS
# =============================================================================
datos <- read.table("datos_modify.dat", header = TRUE, sep = "\t", na.strings = "NA")
filas <- switch(muestra, completa = 1:212, sub1 = 1:71, sub2 = 84:212)
d <- datos[filas, ]

gdp  <- scan("gdp4795.prn", quiet = TRUE)
yy_g <- diff(log(gdp[20:195])) * 100                  # 1952.II - 1995.3
T1   <- length(yy_g)

merval <- read.table("merval_modify.dat", header = TRUE, na.strings = "NA")$returns_merval
yy0_m  <- merval[2:399]                               # se descarta el NA inicial

yyy_c <- as.matrix(read.table("crspd.prn"))[, 3]      # exceso de retorno equiponderado
yy0_c <- log(1 + yyy_c)


# =============================================================================
# 4. ESTIMACION
# =============================================================================
reg <- function(y, X, estac = FALSE) {                # prior N(0, 4000 I), nu0 = d0 = 0
  gibbs_lm(y, X, R0 = diag(ncol(X)) * 4000, beta0 = rep(0, ncol(X)),
           N0 = 500, MM = 1500, estacionario = estac)
}

modelos <- list()

set.seed(12345)
modelos$ar4 <- list(
  draws = a_draws(reg(yy_g[5:T1],
                      cbind(1, yy_g[4:(T1 - 1)], yy_g[3:(T1 - 2)],
                            yy_g[2:(T1 - 3)], yy_g[1:(T1 - 4)]), estac = TRUE),
                  c("mu", "phi1", "phi2", "phi3", "phi4", "sigma2")),
  titulo = "AR(4) PBI EEUU")

set.seed(12345)
modelos$ej5ab <- list(
  draws = a_draws(reg(d$dif_ln_m1_cpi, cbind(1, d$intrates, d$gdp_log)),
                  c("alpha_0", "alpha_1", "alpha_2", "sig2")),
  titulo = "Dinero (niveles)")

set.seed(12345)
d1 <- d[complete.cases(d$dif_dlog_m1_cpi, d$intrates, d$gdp_dlog), ]
modelos$ej5c1 <- list(
  draws = a_draws(reg(d1$dif_dlog_m1_cpi, cbind(1, d1$intrates, d1$gdp_dlog)),
                  c("alpha_0", "alpha_1", "alpha_2", "sig2")),
  titulo = "Dinero (tasas de crecimiento)")

set.seed(12345)
d2 <- d[complete.cases(d$dif_dlog_m1_cpi, d$intrates_d, d$gdp_dlog), ]
modelos$ej5c2 <- list(
  draws = a_draws(reg(d2$dif_dlog_m1_cpi, cbind(1, d2$intrates_d, d2$gdp_dlog)),
                  c("alpha_0", "alpha_1", "alpha_2", "sig2")),
  titulo = "Dinero (tasas de crecimiento, d(i))")

set.seed(12345)
ms <- gibbs_ms3(yy0_m - mean(yy0_m),
                P_ini = c(p11 = 0.9, p12 = 0.05, p21 = 0.0, p22 = 0.9, p31 = 0.1, p32 = 0.1))
ms$aux$retorno <- yy0_m
modelos$s3_merval <- list(draws = a_draws(ms$draws), aux = ms$aux,
                          titulo = "3 regimenes - Merval", qi = TRUE)

set.seed(198011)
ms <- gibbs_ms3(yy0_c - mean(yy0_c))
ms$aux$retorno <- yy0_c
modelos$s3_crsp <- list(draws = a_draws(ms$draws), aux = ms$aux,
                        titulo = "3 regimenes - CRSP", qi = TRUE)


# =============================================================================
# 5. RESULTADOS
# =============================================================================
resumenes <- lapply(names(modelos), function(m) {
  r <- resumen_tidy(modelos[[m]]$draws, con_qi = isTRUE(modelos[[m]]$qi))
  cat("\n==", modelos[[m]]$titulo, "(", m, ") ==\n")
  print(as.data.frame(r), digits = 4)
  mutate(r, modelo = m, .before = 1)
})
write.csv(bind_rows(resumenes), "gibbs_tidybayes_resumenes.csv", row.names = FALSE)

pdf("gibbs_tidybayes_graficos.pdf", width = 10, height = 6)
for (m in names(modelos)) {
  graficos_cadena(modelos[[m]]$draws, modelos[[m]]$titulo)
  if (!is.null(modelos[[m]]$aux)) graficos_ms3(modelos[[m]]$aux, modelos[[m]]$titulo)
}
invisible(dev.off())
