rm(list = ls())

# setwd("C:/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Econometría/10. Microeconometría II/Trabajos Prácticos/Trabajo Práctico N° 3/Datos")
setwd("D:/Box/Maestria_en_Econometria_UTDT/10. Microeconometría II/Trabajos Prácticos/Trabajo Práctico N° 3/Datos")


# install.packages(c("haven", "fixest", "sandwich", "lmtest"))
library(haven)
library(fixest)
library(sandwich)
library(lmtest)

set.seed(12345)

leer <- function(archivo) as.data.frame(zap_labels(read_dta(archivo)))

# Diferencias en diferencias simple (equivalente a "diff"): tabla de medias y estimador
# per: variable de período (0/1); tr: variable de tratamiento (0/1)
diff_did <- function(d, y, per, tr, cov = NULL) {
  f <- reformulate(c(sprintf("%s * %s", per, tr), cov), response = y)
  m <- lm(f, data = d)
  coefs <- summary(m)$coefficients
  fila <- paste0(per, ":", tr)
  list(modelo = m, did = coefs[fila, ], tabla = coefs)
}

# Bootstrap (reps = 50, como "diff, bs") del estimador DiD
diff_boot <- function(d, y, per, tr, cov = NULL, reps = 50) {
  fila <- paste0(per, ":", tr)
  est <- function(dd) coef(lm(reformulate(c(sprintf("%s * %s", per, tr), cov), response = y),
                              data = dd))[fila]
  b <- replicate(reps, est(d[sample(nrow(d), replace = TRUE), ]))
  c(estimador = unname(est(d)), ee_bootstrap = sd(b))
}


################################################################################
#                                EJERCICIO 2                                   #
################################################################################

panel <- leer("Panel101.dta")
str(panel)
if (is.character(panel$country)) panel$country <- as.integer(factor(panel$country))

# INCISO (a)

panel$Y <- panel$y / 1000000000
panel$time <- as.numeric(panel$year >= 1994 & !is.na(panel$year))
panel$treated <- as.numeric(panel$country > 4 & !is.na(panel$country))
panel$did <- panel$time * panel$treated

# INCISO (b)

print(summary(lm(Y ~ time + treated + did, data = panel)))

# INCISO (c)
# Efectos fijos por país (treated es colineal con los efectos fijos y se omite)

print(summary(feols(Y ~ time + treated + did | country, data = panel, vcov = "iid")))
print(summary(feols(Y ~ time * treated | country, data = panel, vcov = "iid")))

# INCISO (d)

r <- diff_did(panel, "Y", "time", "treated")
print(round(r$tabla, 4))
cat("Diferencia en diferencias (DiD):\n"); print(round(r$did, 4))


################################################################################
#                                EJERCICIO 3                                   #
################################################################################

ck <- leer("CardKrueger1994.dta")
str(ck)

# INCISO (c)

for (g in sort(unique(ck$treated))) {
  cat("\ntreated =", g, "\n")
  print(summary(ck[ck$treated == g, ]))
}
print(aggregate(fte ~ treated + t, data = ck,
                FUN = function(x) c(n = length(x), media = mean(x), sd = sd(x))))

r <- diff_did(ck, "fte", "t", "treated")
print(round(r$tabla, 4))
cat("Diferencia en diferencias (DiD):\n"); print(round(r$did, 4))

# INCISO (d)

print(round(diff_boot(ck, "fte", "t", "treated"), 4))

# INCISO (e)

cov <- c("bk", "kfc", "roys")
r <- diff_did(ck, "fte", "t", "treated", cov)
print(round(r$tabla, 4))
cat("Diferencia en diferencias (DiD) con covariables:\n"); print(round(r$did, 4))

print(round(diff_boot(ck, "fte", "t", "treated", cov), 4))


################################################################################
#                                EJERCICIO 4                                   #
################################################################################

hosp <- leer("hospdd.dta")
str(hosp)

# INCISO (c)

print(summary(hosp))
print(table(hosp$procedure))
print(table(hosp$month, hosp$procedure))
print(table(hosp$hospital, hosp$procedure))

hosp$treated <- ave(hosp$procedure, hosp$hospital, FUN = max)
hosp$post <- as.numeric(hosp$month >= 4 & !is.na(hosp$procedure))

print(table(hosp$treated))
print(table(hosp$procedure, hosp$treated))

# didregress (satis i.treated i.post) (procedure), group(hospital) time(month)
# = regresión con efectos fijos de hospital y de mes; EE clusterizados por hospital
# (treated y post son colineales con los efectos fijos y se omiten)
print(summary(feols(satis ~ procedure + treated + post | hospital + month,
                    data = hosp, cluster = ~hospital)))

# INCISO (e)

m <- lm(satis ~ procedure + factor(hospital) + factor(month), data = hosp)

# vce(robust): HC1
print(coeftest(m, vcov = vcovHC(m, type = "HC1"))["procedure", , drop = FALSE])

# vce(hc2)
print(coeftest(m, vcov = vcovHC(m, type = "HC2"))["procedure", , drop = FALSE])

# vce(bootstrap): bootstrap por clusters (hospitales), 50 repeticiones
hosp_ids <- unique(hosp$hospital)
boot_coef <- replicate(50, {
  s <- sample(hosp_ids, replace = TRUE)
  dd <- do.call(rbind, lapply(seq_along(s), function(i) {
    x <- hosp[hosp$hospital == s[i], ]
    x$hospital <- i
    x
  }))
  coef(feols(satis ~ procedure | hospital + month, data = dd))["procedure"]
})
cat("procedure: coef =", coef(m)["procedure"], " EE bootstrap =", sd(boot_coef), "\n")
