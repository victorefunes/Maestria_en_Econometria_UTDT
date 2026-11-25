################################################################################
# Trabajo Práctico N° 1 - Microeconometría I
# Traducción a R del do-file de Stata
################################################################################

rm(list = ls())

paquetes <- c("haven", "sandwich", "lmtest", "pROC", "marginaleffects",
              "modelsummary", "ggplot2")
faltan <- paquetes[!sapply(paquetes, requireNamespace, quietly = TRUE)]
if (length(faltan) > 0) install.packages(faltan)
invisible(lapply(paquetes, library, character.only = TRUE))

# Directorio de trabajo: carpeta donde están los datos
# (si se corre desde RStudio con el script abierto, se usa su ubicación)
if (requireNamespace("rstudioapi", quietly = TRUE) &&
    rstudioapi::isAvailable()) {
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}
# setwd("RUTA/A/Trabajo Práctico N° 1/Datos")

# Tasa de aciertos (equivalente a estat classification, corte 0.5)
tasa_aciertos <- function(y, p, corte = 0.5) {
  yhat <- as.numeric(p > corte)
  tab <- table(y, yhat)
  print(tab)
  sum(diag(tab)) / sum(tab) * 100
}


################################################################################
# EJERCICIO 1
################################################################################

insurance <- as.data.frame(read_dta("./Trabajos Prácticos/Trabajo Práctico N° 1/Datos/insurance.dta"))
str(insurance)

# Variables categóricas (i.var en Stata)
for (v in c("retire", "hstatusg", "married", "hisp")) {
  insurance[[v]] <- factor(insurance[[v]])
}

fml1 <- ins ~ retire + age + hstatusg + hhincome + educyear + married + hisp

## INCISO (a)

ols    <- lm(fml1, data = insurance)
logit  <- glm(fml1, data = insurance, family = binomial(link = "logit"))
probit <- glm(fml1, data = insurance, family = binomial(link = "probit"))

insurance$yhat_ols    <- predict(ols)
insurance$phat_logit  <- predict(logit,  type = "response")
insurance$phat_probit <- predict(probit, type = "response")

betas_ols    <- coef(ols)
betas_logit  <- coef(logit)
betas_probit <- coef(probit)
print(betas_ols); print(betas_logit); print(betas_probit)

modelsummary(list("OLS" = ols, "Logit" = logit, "Probit" = probit),
             stars = c("*" = .10, "**" = .05, "***" = .01),
             gof_map = c("r.squared", "nobs", "logLik"),
             output = "markdown")

## INCISO (d)

# Manual
cat("La tasa de aciertos del Logit es de",
    round(tasa_aciertos(insurance$ins, insurance$phat_logit), 2), "\n")
cat("La tasa de aciertos del Probit es de",
    round(tasa_aciertos(insurance$ins, insurance$phat_probit), 2), "\n")
# (estat classification de Stata equivale a lo anterior con corte 0.5)

## INCISO (e)

prueba_logit <- cbind("Betas Logit" = betas_logit,
                      "4 * Betas OLS" = 4 * betas_ols)
print(prueba_logit)

prueba_probit <- cbind("Betas Probit" = betas_probit,
                       "2,5 * Betas OLS" = 2.5 * betas_ols)
print(prueba_probit)

## INCISO (f)  (margins, atmeans)

# Perfil "en la media": numéricas en su media; factores como dummies en su
# media (igual que atmeans de Stata), por eso se arma la matriz de diseño.
X_medias <- colMeans(model.matrix(ols))

pred_medias <- function(modelo) {
  eta <- sum(coef(modelo) * X_medias)
  if (inherits(modelo, "glm")) modelo$family$linkinv(eta) else eta
}
cat("Prob. esperada de ins=1 en las medias - OLS:    ", pred_medias(ols), "\n")
cat("Prob. esperada de ins=1 en las medias - Logit:  ", pred_medias(logit), "\n")
cat("Prob. esperada de ins=1 en las medias - Probit: ", pred_medias(probit), "\n")

## INCISO (g)  (logit ..., or)

print(exp(cbind(OR = coef(logit), confint.default(logit))))


################################################################################
# EJERCICIO 2
################################################################################

mroz <- as.data.frame(read_dta("./Trabajos Prácticos/Trabajo Práctico N° 1/Datos/mroz.dta"))
str(mroz)

fml2 <- inlf ~ educ + city + exper + kidslt6 + expersq

## INCISO (a)

summary(mroz)
View(mroz)

## INCISO (b)

mroz$educ_cent <- mroz$educ - mean(mroz$educ, na.rm = TRUE)
summary(mroz[, c("educ", "educ_cent")])

## INCISO (c)

ggplot(mroz, aes(educ, wage)) + geom_point()
ggplot(mroz, aes(educ, wage)) + geom_point() + facet_wrap(~ inlf)
ggplot(mroz, aes(educ, wage)) + geom_point() + facet_wrap(~ kidslt6)

## INCISO (d)

# mdesc: valores faltantes por variable
faltantes <- data.frame(
  faltantes  = colSums(is.na(mroz)),
  total      = nrow(mroz),
  porcentaje = round(colMeans(is.na(mroz)) * 100, 2)
)
print(faltantes)
# duplicates list
print(mroz[duplicated(mroz) | duplicated(mroz, fromLast = TRUE), ])

## INCISO (e)

ols2 <- lm(fml2, data = mroz)
mroz$yhat_ols <- predict(ols2)

## INCISO (f)  (robust = HC1 en Stata)

coeftest(ols2, vcov = vcovHC(ols2, type = "HC1"))
ols2_rob <- ols2

## INCISO (g)

ols2_nc <- lm(update(fml2, . ~ . - 1), data = mroz)
coeftest(ols2_nc, vcov = vcovHC(ols2_nc, type = "HC1"))

## INCISO (h)

ols2_city <- lm(fml2, data = subset(mroz, city == 1))
coeftest(ols2_city, vcov = vcovHC(ols2_city, type = "HC1"))

## INCISO (i)

logit2 <- glm(fml2, data = mroz, family = binomial(link = "logit"))
summary(logit2)

## INCISO (j)

mroz$yhat_logit <- predict(logit2, type = "response")

## INCISO (k)  (lroc)

roc_logit <- roc(mroz$inlf, mroz$yhat_logit)
print(auc(roc_logit))
plot(roc_logit, legacy.axes = TRUE, print.auc = TRUE,
     xlab = "1 - Especificidad", ylab = "Sensibilidad")

## INCISO (l)  margins, dydx(*) atmeans

# Efectos marginales en las medias de las covariables
print(avg_slopes(logit2, newdata = "mean"))

## INCISO (m)  margins, dydx(*) at(...)

print(slopes(logit2,
             newdata = datagrid(educ = 10, city = 1, exper = 20,
                                kidslt6 = 3, expersq = 400)))

## INCISO (n)

probit2 <- glm(fml2, data = mroz, family = binomial(link = "probit"))

modelsummary(list("OLS" = ols2_rob, "Logit" = logit2, "Probit" = probit2),
             stars = c("*" = .10, "**" = .05, "***" = .01),
             gof_map = c("r.squared", "nobs", "logLik"),
             output = "markdown")


################################################################################
# EJERCICIO 3
################################################################################

eph <- as.data.frame(read_dta("./Trabajos Prácticos/Trabajo Práctico N° 1/Datos/Individual_t215.dta"))
str(eph)

eph <- subset(eph, ch03 == 1 & ch04 == 1 & ch06 >= 25 & ch06 <= 65 &
                (estado == 1 | estado == 2))

eph$aglomerado <- factor(eph$aglomerado)
eph$ch07       <- factor(eph$ch07)

fml3 <- desempleado ~ aglomerado + ch06 + ch07

## INCISO (a)

eph$desempleado <- ifelse(eph$estado == 2, 1, 0)

ols3 <- lm(fml3, data = eph, weights = pondera)
eph$yhat_ols <- predict(ols3)

obs_mayor_1 <- sum(eph$yhat_ols > 1)
cat("La proporción de la muestra con probabilidades predichas > 1 es",
    obs_mayor_1 / nrow(eph), "\n")

obs_menor_0 <- sum(eph$yhat_ols < 0)
cat("La proporción de la muestra con probabilidades predichas < 0 es",
    obs_menor_0 / nrow(eph), "\n")

## INCISO (b)

# quasibinomial: mismas estimaciones que binomial, sin advertencias por
# ponderadores no enteros
probit3 <- glm(fml3, data = eph, weights = pondera,
               family = quasibinomial(link = "probit"))
eph$yhat_probit <- predict(probit3, type = "response")

logit3 <- glm(fml3, data = eph, weights = pondera,
              family = quasibinomial(link = "logit"))
eph$yhat_logit <- predict(logit3, type = "response")

modelsummary(list("OLS" = ols3, "Probit" = probit3, "Logit" = logit3),
             stars = c("*" = .10, "**" = .05, "***" = .01),
             gof_map = c("r.squared", "nobs"),
             output = "markdown")

## INCISO (c)

aglomerados <- sort(unique(as.numeric(as.character(eph$aglomerado))))
grilla <- expand.grid(aglomerado = factor(aglomerados, levels = levels(eph$aglomerado)),
                      ch06 = 25:65,
                      ch07 = factor(2, levels = levels(eph$ch07)))

# Probit: efecto marginal promedio de la edad y gráfico
# (se replica el procedimiento original: yhat vs. edad * AME)
ame_probit <- avg_slopes(probit3, variables = "ch06", wts = "pondera")
print(ame_probit)
eph$em_edad_probit <- eph$ch06 * ame_probit$estimate
ggplot(eph, aes(em_edad_probit, yhat_probit)) + geom_point()

# Logit
ame_logit <- avg_slopes(logit3, variables = "ch06", wts = "pondera")
print(ame_logit)
eph$em_edad_logit <- eph$ch06 * ame_logit$estimate
ggplot(eph, aes(em_edad_logit, yhat_logit)) + geom_point()

# Probabilidades predichas sobre la grilla (margins, at(...))
grilla$p_probit <- predict(probit3, newdata = grilla, type = "response")
grilla$p_logit  <- predict(logit3,  newdata = grilla, type = "response")
head(grilla)
