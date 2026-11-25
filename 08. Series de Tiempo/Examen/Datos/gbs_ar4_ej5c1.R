# =============================================================================
# Gibbs sampling para un modelo con 3 regresores (demanda de dinero, tasas de
# crecimiento):
#   dlog(m_t) - dlog(p_t) = alpha_0 + alpha_1 * i_t + alpha_2 * dlog(y_t) + e_t
#   e_t ~ i.i.d. N(0, sigma^2)
# Basado en Albert y Chib (1993). Traduccion de gbs_ar4_ej5c1.prg (GAUSS).
#
# Ejecutar con el directorio de trabajo en la carpeta Datos.
# =============================================================================
setwd("D:/Box/Maestria_en_Econometria_UTDT/08. Series de Tiempo/Examen/Datos")
source("gibbs_funciones.R")
set.seed(12345)

# --- Datos --------------------------------------------------------------------
datos <- read.table("datos_modify.dat", header = TRUE, sep = "\t", na.strings = "NA")

# Muestra: "completa" (1962q1-2014q4), "sub1" (1962q1-1979q3), "sub2" (1982q4-2014q4)
muestra <- "completa"
filas <- switch(muestra, completa = 1:212, sub1 = 1:71, sub2 = 84:212)
d <- datos[filas, ]
# La primera observacion de las series en diferencias es NA: se descarta
d <- d[complete.cases(d$dif_dlog_m1_cpi, d$intrates, d$gdp_dlog), ]

Y <- d$dif_dlog_m1_cpi
X <- cbind(1, d$intrates, d$gdp_dlog)

# --- Prior y sampler -----------------------------------------------------------
R0    <- diag(3) * 4000
beta0 <- rep(0, 3)
fnl_mat <- gibbs_lm(Y, X, R0, beta0, nu0 = 0, d0 = 0, sig2 = 0.5,
                    N0 = 500, MM = 1500)

# --- Resultados (media, mediana, desvio) -------------------------------------------
nombres <- c("alpha_0", "alpha_1", "alpha_2", "sig2")
sort_out <- resumen_posterior(fnl_mat, LL = 5, nombres = nombres)[, c("mean", "mediana", "sd")]
print(round(sort_out, 5))

graficar_cadenas(fnl_mat, nombres, "gbs_ar4_ej5c1_graficos.pdf")
