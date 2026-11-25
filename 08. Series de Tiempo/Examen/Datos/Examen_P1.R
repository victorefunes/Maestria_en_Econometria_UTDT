# Examen Final - Punto 1: GARCH para MERVAL, tres acciones y GARCH multivariado
suppressPackageStartupMessages({library(rugarch); library(rmgarch)})
setwd("d:/Box/Maestria_en_Econometria_UTDT/08. Series de Tiempo/Examen/Datos")
px <- read.csv("merval_modify.csv")
ret <- function(v) 100 * diff(log(v))               # retornos logaritmicos en %
cat("Observaciones de precios:", nrow(px), "-> retornos:", nrow(px) - 1, "\n")

# test ARCH-LM: regresion de z^2 sobre sus m rezagos, LM = n R^2 ~ chi2(m)
arch_lm <- function(z, m) {
  z2 <- (z - mean(z))^2
  X  <- embed(z2, m + 1)
  r2 <- summary(lm(X[, 1] ~ X[, -1]))$r.squared
  pchisq(nrow(X) * r2, m, lower.tail = FALSE)
}

# --- elegir GARCH(p,q) por BIC, media constante ---------------------------------------
fit_best <- function(r, nombre, dist = "norm") {
  res <- NULL
  for (p in 1:2) for (q in 0:2) {                    # p = ARCH, q = GARCH
    sp <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(p, q)),
                     mean.model = list(armaOrder = c(0, 0)), distribution.model = dist)
    f <- tryCatch(ugarchfit(sp, r, solver = "hybrid"), error = function(e) NULL)
    if (!is.null(f) && f@fit$convergence == 0)
      res <- rbind(res, data.frame(serie = nombre, p_ARCH = p, q_GARCH = q,
                                   BIC = infocriteria(f)[2], AIC = infocriteria(f)[1],
                                   LL = likelihood(f)))
  }
  res[order(res$BIC), ]
}
diag_modelo <- function(r, nombre, p, q, dist = "norm") {
  sp <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(p, q)),
                   mean.model = list(armaOrder = c(0, 0)), distribution.model = dist)
  f <- ugarchfit(sp, r, solver = "hybrid")
  z <- as.numeric(residuals(f, standardize = TRUE))
  cat("\n--", nombre, ": GARCH(", p, ",", q, ") dist =", dist, "--\n")
  print(round(f@fit$robust.matcoef, 4))
  cat("Persistencia:", round(persistence(f), 4), "\n")
  cat("Ljung-Box z^2 (10 rezagos) p =", round(Box.test(z^2, 10, "Ljung")$p.value, 4),
      "| ARCH-LM(10) en z p =", round(arch_lm(z, 10), 4), "\n")
  f
}

series <- list(MERVAL = ret(px$MERVAL), GGAL = ret(px$GGAL),
               PAMP = ret(px$PAMP), TECO2 = ret(px$TECO2))
cat("\n==== (a)/(b) Estadisticos descriptivos y efectos ARCH ====\n")
for (n in names(series)) {
  r <- series[[n]]
  cat(sprintf("%-7s media %.3f desvio %.3f asim %.2f curt %.2f | ARCH-LM(5) p=%.4f | LB r^2(10) p=%.4f\n",
              n, mean(r), sd(r), mean((r - mean(r))^3) / sd(r)^3,
              mean((r - mean(r))^4) / sd(r)^4, arch_lm(r, 5),
              Box.test((r - mean(r))^2, 10, "Ljung")$p.value))
}

best <- list()
for (n in names(series)) {
  cat("\n==== ", n, ": seleccion de GARCH(p,q) por BIC (normal) ====\n")
  tab <- fit_best(series[[n]], n)
  print(round(tab[, -1], 3), row.names = FALSE)
  best[[n]] <- tab[1, ]
}
fits <- list()
for (n in names(series)) {
  b <- best[[n]]
  fits[[n]] <- diag_modelo(series[[n]], n, b$p_ARCH, b$q_GARCH)
}

# --- asimetria (GJR) para comparar -----------------------------------------------------
cat("\n==== GJR-GARCH(1,1): termino de apalancamiento ====\n")
for (n in names(series)) {
  sp <- ugarchspec(variance.model = list(model = "gjrGARCH", garchOrder = c(1, 1)),
                   mean.model = list(armaOrder = c(0, 0)), distribution.model = "norm")
  f <- ugarchfit(sp, series[[n]], solver = "hybrid")
  m <- f@fit$robust.matcoef
  cat(sprintf("%-7s gamma = %.4f (p = %.4f)\n", n, m["gamma1", 1], m["gamma1", 4]))
}

# --- (c) GARCH multivariado: DCC con dos acciones -----------------------------------------
cat("\n==== (c) DCC-GARCH(1,1) para GGAL y TECO2 ====\n")
R2 <- cbind(GGAL = series$GGAL, TECO2 = series$TECO2)
uspec <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(1, 1)),
                    mean.model = list(armaOrder = c(0, 0)), distribution.model = "norm")
mspec <- multispec(replicate(2, uspec))
dspec <- dccspec(mspec, dccOrder = c(1, 1), distribution = "mvnorm")
dfit  <- dccfit(dspec, R2)
show(dfit)
rho <- rcor(dfit)[1, 2, ]
cat("Correlacion condicional: media", round(mean(rho), 3), "min", round(min(rho), 3),
    "max", round(max(rho), 3), "\n")
cat("Correlacion incondicional:", round(cor(R2)[1, 2], 3), "\n")
pdf("Examen_P1_graficos.pdf", width = 9, height = 7)
par(mfrow = c(2, 1))
plot(as.numeric(sigma(fits$MERVAL)), type = "l", main = "MERVAL: volatilidad condicional GARCH",
     ylab = "%", xlab = "")
plot(as.numeric(rho), type = "l", main = "DCC: correlacion condicional GGAL-TECO2",
     ylab = "rho", xlab = "")
dev.off()
