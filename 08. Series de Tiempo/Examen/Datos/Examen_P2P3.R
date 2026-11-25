# Examen Final - Puntos 2 y 3: ciclos del PBI (Markov, STAR, HP) y STAR bivariado
suppressPackageStartupMessages({library(MSwM); library(mFilter)})
setwd("d:/Box/Maestria_en_Econometria_UTDT/08. Series de Tiempo/Examen/Datos")
set.seed(123)
m <- read.csv("money.csv")
fechas <- m$obs
cat("Muestra:", fechas[1], "a", fechas[nrow(m)], " T =", nrow(m), "\n")

# desestacionalizar (STL robusto sobre el log): devuelve log del nivel SA y fechas
sa_log <- function(v) {
  ok <- which(!is.na(v))
  y <- ts(log(v[ok]), frequency = 4,
          start = c(1980 + (ok[1] - 1) %/% 4, (ok[1] - 1) %% 4 + 1))
  s <- stl(y, "periodic", robust = TRUE)
  list(sa = as.numeric(s$time.series[, "trend"] + s$time.series[, "remainder"]), obs = fechas[ok])
}

# --- candidatas a variable umbral (del conjunto de datos) -------------------------------
# la inflacion solo es confiable cuando el indice supera 1e-4 (resolucion de 1e-6 antes)
infl  <- c(NA, 100 * diff(log(ifelse(m$IPC_PRIVADO > 1e-4, m$IPC_PRIVADO, NA))))
dtasa <- c(NA, diff(m$TASA_DE_INTERES))
dm1r  <- c(NA, 100 * diff(log(m$M1))) - infl            # crecimiento real de M1
cat("Primera observacion de inflacion utilizable:", fechas[which(!is.na(infl))[1]], "\n")

# ============================ PUNTO 2 ====================================================
res2 <- list()
for (nom in c("PBI_REAL", "PBI_PRIVADO")) {
  cat("\n\n############ Punto 2:", nom, "############\n")
  s <- sa_log(m[[nom]])
  g <- 100 * diff(s$sa); fg <- s$obs[-1]               # crecimiento trimestral SA (%)
  cat("Crecimiento trimestral SA: media", round(mean(g), 3), "desvio", round(sd(g), 3), "\n")

  # (a) Markov switching: media y varianza cambian, 2 regimenes
  cat("\n--- (a) Markov Switching (2 regimenes, media y varianza) ---\n")
  ms <- msmFit(lm(g ~ 1), k = 2, sw = c(TRUE, TRUE), p = 0)
  print(ms@Coef); print(round(ms@transMat, 3))
  mu <- ms@Coef[, 1]
  rec <- which.min(mu)
  dur <- 1 / (1 - diag(ms@transMat))
  cat("Regimen recesivo = regimen", rec, "(media", round(mu[rec], 3), "% trim.); duraciones esperadas (trim.):",
      round(dur, 1), "\n")
  rec_ms <- ms@Fit@smoProb[-1, rec][seq_along(g)] > 0.5

  # (b) STAR logistico: y_t = a'x + G(z)*b'x + e, x = (1, y_{t-1}, y_{t-2})
  cat("\n--- (b) STAR: eleccion de la variable de transicion (test LM de linealidad) ---\n")
  idx <- match(fg, fechas)
  n <- length(g)
  Y  <- g[3:n]; X <- cbind(1, g[2:(n - 1)], g[1:(n - 2)])
  i3 <- idx[3:n]
  cand <- list(crec_L1 = g[2:(n - 1)], crec_L2 = g[1:(n - 2)],
               infl_L1 = infl[i3 - 1], dtasa_L1 = dtasa[i3 - 1], tasa_L1 = m$TASA_DE_INTERES[i3 - 1],
               dm1real_L1 = dm1r[i3 - 1])
  lm_lin <- function(z) {                              # LM3 de Terasvirta: x*z, x*z^2, x*z^3
    ok <- complete.cases(cbind(Y, X, z)); y <- Y[ok]; x <- X[ok, ]; zz <- z[ok]
    e0 <- resid(lm(y ~ x - 1))
    aux <- cbind(x[, -1] * zz, x[, -1] * zz^2, x[, -1] * zz^3, zz, zz^2, zz^3)
    r2 <- summary(lm(e0 ~ x - 1 + aux))$r.squared
    LM <- length(y) * r2; df <- ncol(aux)
    c(LM = LM, gl = df, p = pchisq(LM, df, lower.tail = FALSE), n = length(y))
  }
  tab <- t(sapply(cand, lm_lin)); print(round(tab, 4))
  zname <- names(which.min(tab[, "p"])); z <- cand[[zname]]
  cat("Variable de transicion elegida (menor p-valor de linealidad):", zname, "\n")

  ok <- complete.cases(cbind(Y, X, z)); y <- Y[ok]; x <- X[ok, ]; zz <- z[ok]
  fz <- fg[3:n][ok]
  zs <- (zz - mean(zz)) / sd(zz)
  ssr_fun <- function(gam, c0) {
    G <- 1 / (1 + exp(-gam * (zs - c0)))
    sum(resid(lm(y ~ cbind(x, x * G) - 1))^2)
  }
  gr <- expand.grid(gam = c(0.5, 1, 2, 4, 8, 16, 32), c0 = quantile(zs, seq(0.15, 0.85, 0.025)))
  gr$ssr <- mapply(ssr_fun, gr$gam, gr$c0)
  b <- gr[which.min(gr$ssr), ]
  opt <- optim(c(b$gam, b$c0), function(p) ssr_fun(abs(p[1]), p[2]), method = "Nelder-Mead")
  gam <- abs(opt$par[1]); c0 <- opt$par[2]
  G <- 1 / (1 + exp(-gam * (zs - c0)))
  fit <- lm(y ~ cbind(x, x * G) - 1)
  cat(sprintf("gamma = %.2f, umbral c = %.3f (en %s original = %.3f), SSR lineal %.2f -> STAR %.2f\n",
              gam, c0, zname, mean(zz) + c0 * sd(zz), sum(resid(lm(y ~ x - 1))^2), sum(resid(fit)^2)))
  print(round(summary(fit)$coefficients, 4))
  m_hi <- mean(y[G > 0.5]); m_lo <- mean(y[G <= 0.5])
  rec_star <- if (m_hi < m_lo) G > 0.5 else G <= 0.5
  cat("Crecimiento medio con G>0.5:", round(m_hi, 3), "| con G<=0.5:", round(m_lo, 3), "\n")

  # (c) Filtro HP (lambda = 1600) sobre el log del PBI desestacionalizado
  hp <- hpfilter(ts(s$sa), freq = 1600)
  cyc <- as.numeric(hp$cycle) * 100
  rec_hp <- cyc < 0
  cat("\n--- (c) Filtro HP: ciclo (%), min", round(min(cyc), 2), "max", round(max(cyc), 2), "\n")

  # --- comparacion: trimestres en recesion segun cada metodo ---------------------------
  all_f <- s$obs
  R <- data.frame(obs = all_f, MS = FALSE, STAR = NA, HP = rec_hp)
  R$MS[match(fg, all_f)] <- rec_ms
  R$STAR[match(fz, all_f)] <- rec_star
  cat("\nTrimestres en recesion: MS", sum(R$MS), "| STAR", sum(R$STAR, na.rm = TRUE), "| HP", sum(R$HP), "\n")
  okS <- !is.na(R$STAR)
  cat("Concordancia (% trimestres iguales): MS-HP", round(100 * mean(R$MS == R$HP), 1),
      "| MS-STAR", round(100 * mean(R$MS[okS] == R$STAR[okS]), 1),
      "| STAR-HP", round(100 * mean(R$STAR[okS] == R$HP[okS]), 1), "\n")
  ep <- function(v) { r <- rle(v); e <- cumsum(r$lengths); st <- e - r$lengths + 1
    data.frame(inicio = all_f[st[r$values]], fin = all_f[e[r$values]], trim = r$lengths[r$values]) }
  cat("\nEpisodios recesivos segun Markov switching:\n"); print(ep(R$MS), row.names = FALSE)
  cat("\nEpisodios recesivos segun HP:\n"); print(ep(R$HP), row.names = FALSE)
  res2[[nom]] <- R
}
pdf("Examen_P2_ciclos.pdf", width = 9, height = 8)
par(mfrow = c(2, 1))
for (nom in names(res2)) {
  R <- res2[[nom]]
  plot(seq_len(nrow(R)), rep(NA, nrow(R)), ylim = c(0.5, 3.5), xlab = "", ylab = "", yaxt = "n",
       xaxt = "n", main = paste("Recesiones:", nom))
  axis(2, 1:3, c("HP", "STAR", "MS"), las = 1)
  axis(1, seq(1, nrow(R), 8), R$obs[seq(1, nrow(R), 8)], cex.axis = 0.7)
  for (k in 1:3) { v <- list(R$HP, R$STAR, R$MS)[[k]]; v[is.na(v)] <- FALSE
    segments(which(v), k - 0.3, which(v), k + 0.3, col = k + 1, lwd = 3) }
}
dev.off()

# ============================ PUNTO 3 ====================================================
cat("\n\n############ Punto 3: STAR bivariado (inflacion y crecimiento privado) ############\n")
s <- sa_log(m$PBI_PRIVADO)
v <- rep(NA_real_, nrow(m)); v[match(s$obs, fechas)] <- s$sa
D <- data.frame(obs = fechas, pi = infl, g = c(NA, 100 * diff(v)))
D$pi_L1 <- c(NA, D$pi[-nrow(D)]); D$g_L1 <- c(NA, D$g[-nrow(D)])
D <- D[complete.cases(D), ]
cat("Muestra efectiva:", D$obs[1], "a", D$obs[nrow(D)], " T =", nrow(D), "\n")
Y <- as.matrix(D[, c("pi", "g")]); X <- cbind(1, D$pi_L1, D$g_L1)

ld <- function(E) log(det(crossprod(E) / nrow(E)))
E0 <- resid(lm(Y ~ X - 1)); ld0 <- ld(E0)
cat("\nVAR(1) lineal: log|Sigma| =", round(ld0, 4), "\n")

star_fit <- function(z, nombre) {
  zs <- (z - mean(z)) / sd(z)
  fobj <- function(gam, c0) {
    G <- if (is.finite(gam)) 1 / (1 + exp(-gam * (zs - c0))) else as.numeric(zs > c0)
    ld(resid(lm(Y ~ cbind(X, X * G) - 1)))
  }
  gr <- expand.grid(gam = c(Inf, 1, 2, 4, 8, 16), c0 = quantile(zs, seq(0.15, 0.85, 0.025)))
  gr$v <- mapply(fobj, gr$gam, gr$c0)
  b <- gr[which.min(gr$v), ]
  list(nombre = nombre, gam = b$gam, c0 = b$c0, v = b$v, zs = zs, z = z)
}
cand3 <- list(inflacion_L1 = D$pi_L1, crecimiento_L1 = D$g_L1)
fits3 <- lapply(names(cand3), function(n) star_fit(cand3[[n]], n))
for (f in fits3) {
  umbral <- mean(f$z) + f$c0 * sd(f$z)
  Gf <- if (is.finite(f$gam)) 1 / (1 + exp(-f$gam * (f$zs - f$c0))) else as.numeric(f$zs > f$c0)
  cat(sprintf("\nUmbral = %s: gamma = %s, c = %.3f (= %.3f), log|Sigma| = %.4f, LR = %.2f, obs. regimen alto = %d / %d\n",
              f$nombre, ifelse(is.finite(f$gam), f$gam, "Inf (TAR)"), f$c0, umbral, f$v,
              nrow(D) * (ld0 - f$v), sum(Gf > 0.5), nrow(D)))
}
best3 <- fits3[[which.min(sapply(fits3, `[[`, "v"))]]
cat("\nMejor separacion:", best3$nombre, "\n")

# p-valor del sup-LR por bootstrap bajo el VAR(1) lineal (residuos remuestreados, umbral TAR)
B <- 199; lr_obs <- nrow(D) * (ld0 - best3$v)
cat("Bootstrap del sup-LR (", B, "replicaciones, con", best3$nombre, "como umbral)...\n")
A <- coef(lm(Y ~ X - 1)); lrb <- numeric(B)
for (b in 1:B) {
  Eb <- E0[sample(nrow(E0), replace = TRUE), ]
  Yb <- matrix(0, nrow(D), 2); Yb[1, ] <- Y[1, ]
  for (t in 2:nrow(D)) Yb[t, ] <- c(1, Yb[t - 1, ]) %*% A + Eb[t, ]
  Xb <- cbind(1, rbind(c(0, 0), Yb[-nrow(D), ]))
  zb <- if (grepl("infl", best3$nombre)) Xb[, 2] else Xb[, 3]
  zbs <- (zb - mean(zb)) / sd(zb)
  ld0b <- ld(resid(lm(Yb ~ Xb - 1)))
  vmin <- min(sapply(quantile(zbs, seq(0.15, 0.85, 0.05)), function(c0)
    ld(resid(lm(Yb ~ cbind(Xb, Xb * (zbs > c0)) - 1)))))
  lrb[b] <- nrow(D) * (ld0b - vmin)
}
cat("sup-LR observado:", round(lr_obs, 2), "| p-valor bootstrap ~", round(mean(lrb >= lr_obs), 3), "\n")

f <- best3
G <- if (is.finite(f$gam)) 1 / (1 + exp(-f$gam * (f$zs - f$c0))) else as.numeric(f$zs > f$c0)
fitb <- lm(Y ~ cbind(X, X * G) - 1)
cat("\nCoeficientes: filas = [const, pi_L1, g_L1, G*const, G*pi_L1, G*g_L1]; columnas = ecuaciones\n")
cf <- coef(fitb); rownames(cf) <- c("const", "pi_L1", "g_L1", "G*const", "G*pi_L1", "G*g_L1")
print(round(cf, 4))
cat("R2 por ecuacion:", round(sapply(summary(fitb), function(s) s$r.squared), 3), "\n")
A0 <- t(cf[2:3, ]); A1 <- A0 + t(cf[5:6, ])
cat("Modulo maximo de las raices: regimen bajo", round(max(Mod(eigen(A0)$values)), 3),
    "| regimen alto", round(max(Mod(eigen(A1)$values)), 3), "\n")
