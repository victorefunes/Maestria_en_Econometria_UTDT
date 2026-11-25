# Examen Final - Punto 6: Markov switching en varianza (3 estados) para el MERVAL
suppressPackageStartupMessages({library(MSwM); library(rugarch)})
setwd("d:/Box/Maestria_en_Econometria_UTDT/08. Series de Tiempo/Examen/Datos")
source("gibbs_funciones.R")
set.seed(12345)
px  <- read.csv("merval_modify.csv")
yy0 <- px$RETURNS_MERVAL[!is.na(px$RETURNS_MERVAL)]          # retornos logaritmicos (decimal)
yy  <- yy0 - mean(yy0); T <- length(yy)
cat("Retornos:", T, "| desvio:", round(sd(yy0), 5), "\n")

# --- (a) Gibbs sampling, 3 regimenes de varianza ---------------------------------------
res <- gibbs_ms3(yy, N0 = 1000, MM = 10000, verbose = FALSE)
so <- resumen_posterior(res$fnl_mat, LL = 5, cuantiles = c(0.025, 0.975))
rownames(so) <- colnames(res$fnl_mat)
cat("\n==== (a) Posterior (1 de cada 5 draws) ====\n"); print(signif(so, 4))
fm <- res$fnl_mat
p33 <- 1 - fm[, "P3_1MM"] - fm[, "P3_2MM"]
p11 <- fm[, "P1_1MM"]; p22 <- fm[, "P2_2MM"]
cat("\nPr(permanecer): P11 =", round(mean(p11), 3), " P22 =", round(mean(p22), 3), " P33 =", round(mean(p33), 3), "\n")
cat("Duracion esperada (periodos): R1 =", round(mean(1 / (1 - p11)), 1), " R2 =", round(mean(1 / (1 - p22)), 1),
    " R3 =", round(mean(1 / (1 - p33)), 1), "\n")
sd_pct <- 100 * sqrt(colMeans(fm[, c("SIG1MM", "SIG2MM", "SIG3MM")]))
cat("Desvio estandar por regimen (% por periodo):", round(sd_pct, 2), "\n")
cat("Fraccion del tiempo (prob. filtradas medias): R1", round(mean(res$s1), 2), " R2", round(mean(res$s2), 2),
    " R3", round(mean(res$s3), 2), "\n")

# --- (b) Histogramas de los parametros de volatilidad ------------------------------------
pdf("Examen_P6_graficos.pdf", width = 10, height = 8)
par(mfrow = c(2, 2))
for (j in c("SIG1MM", "SIG2MM", "SIG3MM"))
  hist(1e4 * fm[, j], breaks = 50, col = "grey80", border = "white", main = paste("Posterior", j, "(x1e-4)"), xlab = "")
hist(fm[, "SIG3MM"] / fm[, "SIG1MM"], breaks = 50, col = "grey80", border = "white",
     main = "SIG3/SIG1", xlab = "")
par(mfrow = c(2, 1))
matplot(cbind(res$s1, res$s2, res$s3), type = "l", lty = 1, col = c("black", "blue", "red"),
        main = "Probabilidades filtradas de los 3 regimenes", xlab = "", ylab = "")
legend("topright", c("baja", "media", "alta"), lty = 1, col = c("black", "blue", "red"), bty = "n")
plot(res$sigma, type = "l", col = "red", main = "Varianza esperada (MS 3 estados)", xlab = "", ylab = "")
dev.off()

# --- (c) Modelos de 2 y 3 estados por maxima verosimilitud (media constante) -------------------
cat("\n==== (c) Markov switching en varianza por ML (MSwM) ====\n")
# media y varianza cambian; con k = 3 el ajuste puede ser degenerado y MSwM falla al
# invertir el hessiano ("system is exactly singular"): se captura el error
ml <- function(k) {
  set.seed(12345)
  tryCatch(msmFit(lm(yy ~ 1), k = k, sw = c(TRUE, TRUE), p = 0),
           error = function(e) { cat("MSwM no pudo ajustar k =", k, ":", conditionMessage(e), "\n"); NULL })
}
m2 <- ml(2); m3 <- ml(3)
if (is.null(m2)) stop("El modelo de 2 estados no se pudo ajustar")
for (k in 2:3) {
  m <- if (k == 2) m2 else m3
  if (is.null(m)) next
  cat("\n-- ", k, "estados --\n")
  cat("Medias por regimen (%):", round(100 * m@Coef[, 1], 3), "| desvios (%):", round(100 * m@std, 2), "\n")
  print(round(m@transMat, 3))
  ll <- m@Fit@logLikel; npar <- k * (k - 1) + 2 * k
  cat("logLik:", round(ll, 2), " AIC:", round(-2 * ll + 2 * npar, 1), " BIC:", round(-2 * ll + log(T) * npar, 1),
      " (npar =", npar, ")\n")
}
p2  <- m2@Fit@smoProb[-1, ][seq_len(T), ]
cat("\nDuracion esperada, 2 estados (periodos):", round(1 / (1 - diag(m2@transMat)), 1), "\n")

# --- comparacion con el GARCH del punto 1 ----------------------------------------------------------
r <- 100 * yy0
sp <- ugarchspec(variance.model = list(model = "sGARCH", garchOrder = c(2, 1)),
                 mean.model = list(armaOrder = c(0, 0)), distribution.model = "norm")
g <- ugarchfit(sp, r, solver = "hybrid")
hg <- as.numeric(sigma(g))^2
cat("\n==== Comparacion con GARCH(2,1) ====\n")
cat("Correlacion entre la varianza esperada MS (3 est.) y la varianza condicional GARCH:",
    round(cor(res$sigma, hg / 1e4), 3), "\n")
ms2_var <- as.numeric(p2 %*% (m2@std^2))
cat("Correlacion MS 2 estados vs GARCH:", round(cor(ms2_var, hg / 1e4), 3), "\n")
cat("Correlacion MS 3 estados vs MS 2 estados:", round(cor(res$sigma, ms2_var), 3), "\n")
