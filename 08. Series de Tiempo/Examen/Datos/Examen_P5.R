# Examen Final - Punto 5: demanda de dinero estimada por MCMC (Gibbs sampling)
# Tres ecuaciones x tres muestras, con el sampler gibbs_lm() de gibbs_funciones.R
setwd("d:/Box/Maestria_en_Econometria_UTDT/08. Series de Tiempo/Examen/Datos")
source("gibbs_funciones.R")
set.seed(12345)
d0 <- read.csv("datos_modify.csv")
cat("Observaciones:", nrow(d0), "(", d0$obs[1], "a", d0$obs[nrow(d0)], ")\n")

# Filas: completa 1962q1-2014q4; sub1 1962q1-1979q3; sub2 1982q4-2014q4
muestras <- list(completa = 1:nrow(d0), sub1 = 1:71, sub2 = 84:nrow(d0))
cat("sub1 termina en", d0$obs[71], "| sub2 empieza en", d0$obs[84], "\n")
eqs <- list(
  "(a) log(m)-log(p) = a0 + a1*i + a2*log(y)"          = c("DIF_LN_M1_CPI", "INTRATES", "GDP_LOG"),
  "(c1) dlog(m)-dlog(p) = a0 + a1*i + a2*dlog(y)"      = c("DIF_DLOG_M1_CPI", "INTRATES", "GDP_DLOG"),
  "(c2) dlog(m)-dlog(p) = a0 + a1*di + a2*dlog(y)"     = c("DIF_DLOG_M1_CPI", "INTRATES_D", "GDP_DLOG"))

N0 <- 1000; MM <- 10000
out <- NULL
for (en in names(eqs)) {
  v <- eqs[[en]]
  for (mn in names(muestras)) {
    d <- d0[muestras[[mn]], ]
    d <- d[complete.cases(d[, v]), ]
    Y <- d[[v[1]]]; X <- cbind(1, d[[v[2]]], d[[v[3]]])
    ols <- summary(lm(Y ~ X - 1))
    fm  <- gibbs_lm(Y, X, R0 = diag(3) * 4000, beta0 = rep(0, 3), nu0 = 0, d0 = 0, sig2 = 0.5,
                    N0 = N0, MM = MM, verbose = FALSE)
    s <- resumen_posterior(fm, LL = 1, nombres = c("alpha0", "alpha1", "alpha2", "sig2"),
                           cuantiles = c(0.025, 0.975))
    s$ols_coef <- c(coef(ols)[, 1], ols$sigma^2)
    s$ols_se   <- c(coef(ols)[, 2], NA)
    s$ecuacion <- en; s$muestra <- mn; s$T <- nrow(d); s$parametro <- rownames(s)
    out <- rbind(out, s)
  }
}
rownames(out) <- NULL
write.csv(out, "Examen_P5_resultados.csv", row.names = FALSE)
for (en in names(eqs)) {
  cat("\n=====", en, "=====\n")
  for (mn in names(muestras)) {
    cat("\nMuestra:", mn, "(T =", out$T[out$ecuacion == en & out$muestra == mn][1], ")\n")
    print(round(out[out$ecuacion == en & out$muestra == mn,
                    c("mean", "sd", "mediana", "q0.025", "q0.975", "ols_coef", "ols_se")], 5))
  }
  cat("\nDispersion posterior (sd) de alpha1 y alpha2 por submuestra:\n")
  tab <- sapply(c("sub1", "sub2"), function(mn)
    out$sd[out$ecuacion == en & out$muestra == mn & out$parametro %in% c("alpha1", "alpha2")])
  rownames(tab) <- c("alpha1", "alpha2"); tab <- cbind(tab, razon_sub2_sub1 = tab[, "sub2"] / tab[, "sub1"])
  print(round(tab, 5))
}
