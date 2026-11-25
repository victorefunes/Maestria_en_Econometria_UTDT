# =============================================================================
# Gibbs sampling para un modelo con 3 regresores (demanda de dinero, niveles):
#   log(m_t) - log(p_t) = alpha_0 + alpha_1 * i_t + alpha_2 * log(y_t) + e_t
#   e_t ~ i.i.d. N(0, sigma^2)
# Basado en Albert y Chib (1993). Traduccion de gbs_ar4_ej5ab.prg (GAUSS).
#
# Ejecutar con el directorio de trabajo en la carpeta Datos.
# =============================================================================

source("gibbs_funciones.R")
set.seed(12345)

# --- Datos --------------------------------------------------------------------
# datos_modify.dat: 212 obs trimestrales (1962q1-2014q4)
datos <- read.table("datos_modify.dat", header = TRUE, sep = "\t", na.strings = "NA")

# Muestra: "completa" (1962q1-2014q4), "sub1" (1962q1-1979q3), "sub2" (1982q4-2014q4)
muestra <- "completa"
filas <- switch(muestra, completa = 1:212, sub1 = 1:71, sub2 = 84:212)
d <- datos[filas, ]

Y <- d$dif_ln_m1_cpi
X <- cbind(1, d$intrates, d$gdp_log)

# --- Prior y sampler -----------------------------------------------------------
R0    <- diag(3) * 4000
beta0 <- rep(0, 3)                              # alpha_0, alpha_1, alpha_2
fnl_mat <- gibbs_lm(Y, X, R0, beta0, nu0 = 0, d0 = 0, sig2 = 0.5,
                    N0 = 500, MM = 1500)

# --- Resultados (media, mediana, desvio) -------------------------------------------
nombres <- c("alpha_0", "alpha_1", "alpha_2", "sig2")
sort_out <- resumen_posterior(fnl_mat, LL = 5, nombres = nombres)[, c("mean", "mediana", "sd")]
print(round(sort_out, 5))

graficar_cadenas(fnl_mat, nombres, "gbs_ar4_ej5ab_graficos.pdf")
