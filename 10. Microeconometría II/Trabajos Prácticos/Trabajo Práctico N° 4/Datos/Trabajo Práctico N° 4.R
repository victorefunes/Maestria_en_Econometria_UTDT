rm(list = ls())

# setwd("C:/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Econometría/10. Microeconometría II/Trabajos Prácticos/Trabajo Práctico N° 4/Datos")
setwd("D:/Box/Maestria_en_Econometria_UTDT/10. Microeconometría II/Trabajos Prácticos/Trabajo Práctico N° 4/Datos")

# install.packages(c("haven", "fixest", "did", "etwfe", "marginaleffects"))
library(haven)
library(fixest)
library(did)
library(etwfe)

leer <- function(archivo) as.data.frame(zap_labels(read_dta(archivo)))


################################################################################
#                                EJERCICIO 1                                   #
################################################################################

org <- leer("organ_donations.dta")
str(org)

org$state_id <- as.integer(factor(org$state))

# INCISO (e)

org$Treated <- as.numeric(org$state == "California")
org$Post <- as.numeric(org$quarter %in% c("Q32011", "Q42011", "Q12012"))
org$D <- org$Treated * org$Post

print(table(org$D))
print(table(org$state, org$D))
print(table(org$quarter_num, org$D))

# reghdfe rate D, absorb(state quarter) vce(cluster state)
print(summary(feols(rate ~ D | state + quarter, data = org, cluster = ~state)))

# xtreg rate i.quarter_num D, fe
print(summary(feols(rate ~ factor(quarter_num) + D | state_id, data = org, vcov = "iid")))


################################################################################
#                                EJERCICIO 2                                   #
################################################################################

# INCISO (b)

org$California <- as.numeric(org$state == "California")

# California##ib3.quarter_num (trimestre 3 como base)
es <- feols(rate ~ i(quarter_num, California, ref = 3) | state + quarter_num,
            data = org, cluster = ~state)
print(summary(es))

# INCISO (c)

ct <- as.data.frame(coeftable(es))
ct$quarter_num <- as.numeric(sub(".*::(\\d+):California", "\\1", rownames(ct)))
ct <- rbind(data.frame(Estimate = 0, `Std. Error` = 0, `t value` = NA, `Pr(>|t|)` = NA,
                       quarter_num = 3, check.names = FALSE), ct)
ct <- ct[order(ct$quarter_num), ]
ct$ic_sup <- ct$Estimate + 1.96 * ct[["Std. Error"]]
ct$ic_inf <- ct$Estimate - 1.96 * ct[["Std. Error"]]

plot(ct$quarter_num, ct$Estimate, type = "b", xlab = "Quarter", ylab = "Coeficiente",
     ylim = range(ct$ic_inf, ct$ic_sup, 0), xlim = c(1, 6))
arrows(ct$quarter_num, ct$ic_inf, ct$quarter_num, ct$ic_sup,
       angle = 90, code = 3, length = 0.05)
abline(h = 0)

# INCISO (d)

org3 <- org[org$quarter_num <= 3, ]

org3$FakeTreat1 <- as.numeric(org3$state == "California" & org3$quarter %in% c("Q12011", "Q22011"))
org3$FakeTreat2 <- as.numeric(org3$state == "California" & org3$quarter == "Q22011")

print(summary(feols(rate ~ FakeTreat1 | state + quarter, data = org3, cluster = ~state)))
print(summary(feols(rate ~ FakeTreat2 | state + quarter, data = org3, cluster = ~state)))


################################################################################
#                                EJERCICIO 3                                   #
################################################################################

mp <- leer("mpdta.dta")
str(mp)

# Equivalente a: csdid (dripw) + estat pretrend / simple / group / calendar / event
# (errores estándar analíticos, sin bootstrap)
csdid_todo <- function(data, xformla = ~1, control = "nevertreated") {
  res <- att_gt(yname = "lemp", tname = "year", idname = "countyreal", gname = "first_treat",
                xformla = xformla, data = data, est_method = "dr",
                control_group = control, bstrap = FALSE, cband = FALSE)
  print(summary(res))

  # estat pretrend: test de Wald de que los efectos pre-tratamiento son cero
  pre <- which(res$group > res$t)
  if (length(pre) > 0) {
    V <- res$V_analytical[pre, pre, drop = FALSE]
    W <- drop(t(res$att[pre]) %*% solve(V) %*% res$att[pre])
    cat(sprintf("Pretrend: chi2(%d) = %.4f, p-valor = %.4f\n",
                length(pre), W, pchisq(W, length(pre), lower.tail = FALSE)))
  }

  # estat simple / group / calendar / event
  for (tipo in c("simple", "group", "calendar", "dynamic")) {
    cat("\n== aggte:", tipo, "==\n")
    print(summary(aggte(res, type = tipo, na.rm = TRUE, bstrap = FALSE, cband = FALSE)))
  }
  invisible(res)
}

# INCISO (a), (b), (c)

res_a <- csdid_todo(mp, ~1, "nevertreated")

# INCISO (d)

res_d <- csdid_todo(mp, ~lpop, "nevertreated")

# INCISO (e): grupo de control "not yet treated"

res_e1 <- csdid_todo(mp, ~1, "notyettreated")
res_e2 <- csdid_todo(mp, ~lpop, "notyettreated")

# INCISO (f)

mp$D <- as.numeric(mp$first_treat <= mp$year & mp$treat == 1)

for (i in 1:4) {
  mp[[paste0("Tm", i)]] <- ifelse(mp$treat == 1, as.numeric(mp$year - mp$first_treat == -i), 0)
}
for (i in 0:3) {
  mp[[paste0("Tp", i)]] <- ifelse(mp$treat == 1, as.numeric(mp$year - mp$first_treat == i), 0)
}

print(summary(feols(lemp ~ D | countyreal + year, data = mp, cluster = ~countyreal)))
print(summary(feols(lemp ~ Tm4 + Tm3 + Tm2 + Tm1 + Tp1 + Tp2 + Tp3 | countyreal + year,
                    data = mp, cluster = ~countyreal)))


################################################################################
#                                EJERCICIO 4                                   #
################################################################################

# Equivalente a jwdid + estat simple / group / calendar / event
# (Wooldridge 2021, ETWFE). cgroup = "never" replica la opción "never" de jwdid;
# sin esa opción el grupo de control es "not yet treated".
# Se omite ivar (efectos fijos de grupo/cohorte) para replicar la opción "group".
jwdid_todo <- function(data, fml, cgroup) {
  mod <- etwfe(fml = fml, tvar = year, gvar = first_treat, data = data, cgroup = cgroup)
  print(mod)
  for (tipo in c("simple", "group", "calendar", "event")) {
    cat("\n== emfx:", tipo, "==\n")
    print(emfx(mod, type = tipo))
  }
  invisible(mod)
}

jw1 <- jwdid_todo(mp, lemp ~ 0, "never")
jw2 <- jwdid_todo(mp, lemp ~ lpop, "never")
jw3 <- jwdid_todo(mp, lemp ~ 0, "notyet")
jw4 <- jwdid_todo(mp, lemp ~ lpop, "notyet")
