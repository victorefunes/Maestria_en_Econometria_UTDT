# =============================================================================
# Gibbs sampling para un AR(4):
#   Y_t = MU + PHI1*Y_{t-1} + PHI2*Y_{t-2} + PHI3*Y_{t-3} + PHI4*Y_{t-4} + e_t
#   e_t ~ i.i.d. N(0, sigma^2)
# Basado en Albert y Chib (1993, Journal of Econometrics).
# Traduccion de gbs_ar4.prg (GAUSS).
#
# Ejecutar con el directorio de trabajo en la carpeta Datos.
# =============================================================================
setwd("D:/Box/Maestria_en_Econometria_UTDT/08. Series de Tiempo/Examen/Datos")
source("gibbs_funciones.R")
set.seed(12345)

# --- Datos: PBI real de EEUU, 1947.1 - 1995.3 (195 obs) -----------------------
# El archivo original (gdp4795.prn) no esta en esta carpeta: ajustar la ruta.
archivo_gdp <- "gdp4795.prn"
if (!file.exists(archivo_gdp)) stop("No se encuentra ", archivo_gdp)
gdp <- scan(archivo_gdp, quiet = TRUE)

yy <- diff(log(gdp[20:195])) * 100              # 1952.II - 1995.3
T1 <- length(yy)

Y <- yy[5:T1]
X <- cbind(1, yy[4:(T1 - 1)], yy[3:(T1 - 2)], yy[2:(T1 - 3)], yy[1:(T1 - 4)])

# --- Prior y diseño del sampler -------------------------------------------------
R0    <- diag(5) * 4000
beta0 <- rep(0, 5)                              # mu, phi1, ..., phi4
fnl_mat <- gibbs_lm(Y, X, R0, beta0, nu0 = 0, d0 = 0, sig2 = 0.5,
                    N0 = 500, MM = 1500, estacionario = TRUE)

# --- Resultados -----------------------------------------------------------------
nombres <- c("mu", "phi1", "phi2", "phi3", "phi4", "sigma^2")
sort_out <- resumen_posterior(fnl_mat, LL = 5, nombres = nombres)
print(round(sort_out, 5))
sink("gbs_ar4.out"); print(round(sort_out, 5)); sink()

graficar_cadenas(fnl_mat, nombres, "gbs_ar4_graficos.pdf")
