# =============================================================================
# Gibbs sampling: modelo de 3 regimenes de varianza con cambio markoviano
# aplicado a los retornos del Merval.
# Basado en Chang-Jin Kim. Traduccion de gibs_s3_modify.prg (GAUSS).
#
# Ejecutar con el directorio de trabajo en la carpeta Datos.
# =============================================================================

source("gibbs_funciones.R")
set.seed(12345)

# --- Datos --------------------------------------------------------------------
# merval_modify.dat: 399 obs, la primera es NA (se descarta, igual que GAUSS)
merval <- read.table("merval_modify.dat", header = TRUE, na.strings = "NA")$returns_merval
yy0 <- merval[2:399]
yy  <- yy0 - mean(yy0)
T   <- length(yy0)

# --- Sampler ------------------------------------------------------------------
res <- gibbs_ms3(yy, N0 = 100, MM = 1000,
                 P_ini = c(p11 = 0.9, p12 = 0.05, p21 = 0.0, p22 = 0.9,
                           p31 = 0.1, p32 = 0.1),
                 sig1 = 0.001, h2 = 0.9, h3 = 2.5, mu = 0)

# --- Salidas ------------------------------------------------------------------
write.csv(data.frame(yy0, sigma = res$sigma, stdret = res$stdret),
          "rtrn_o_s.csv", row.names = FALSE)
write.csv(data.frame(S1T = res$s1, S2T = res$s2, S3T = res$s3,
                     SigmaT = res$sigma, stdret = res$stdret, data = yy0),
          "gibs_s3_modify_out.csv", row.names = FALSE)

# --- Resumen posterior (1 de cada LL = 5 draws) ----------------------------------
sort_out <- resumen_posterior(res$fnl_mat, LL = 5,
                              cuantiles = c(0.025, 0.05, 0.10, 0.90, 0.95, 0.975))
rownames(sort_out) <- colnames(res$fnl_mat)
print(round(sort_out, 4))

# --- Graficos ------------------------------------------------------------------
pdf("gibs_s3_modify_graficos.pdf", width = 9, height = 6)
matplot(cbind(res$s1, res$s2, res$s3), type = "l", lty = 1:3, col = c("black", "blue", "red"),
        main = "Filtered Probabilities", xlab = "", ylab = "")
legend("topright", c("P(S1|I)", "P(S2|I)", "P(S3|I)"), lty = 1:3, col = c("black", "blue", "red"))
plot(res$s1, type = "l", main = "Varianza baja", xlab = "", ylab = "")
plot(res$s2, type = "l", main = "Varianza media", xlab = "", ylab = "")
plot(res$s3, type = "l", main = "Varianza alta", xlab = "", ylab = "")
matplot(cbind(res$sigma, 0.1 * yy0), type = "l", lty = c(2, 1), col = c("red", "black"),
        main = "Volatility and Returns", xlab = "", ylab = "")
legend("topright", c("Volatility", "Returns (x0.1)"), lty = c(2, 1), col = c("red", "black"))
dev.off()
