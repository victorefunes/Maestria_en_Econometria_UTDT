################################################################################
# Trabajo Práctico N° 2 - Microeconometría I
# Traducción a R del do-file de Stata
################################################################################

rm(list = ls())

paquetes <- c("haven", "survey", "glmx", "modelsummary")
faltan <- paquetes[!sapply(paquetes, requireNamespace, quietly = TRUE)]
if (length(faltan) > 0) install.packages(faltan)
invisible(lapply(paquetes, library, character.only = TRUE))

# Directorio de trabajo: carpeta donde están los datos
if (requireNamespace("rstudioapi", quietly = TRUE) &&
    rstudioapi::isAvailable()) {
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}

setwd("D:/Box/Maestria_en_Econometria_UTDT/06. Microeconometría I/Trabajos Prácticos/Trabajo Práctico N° 2/Datos")

stars_cfg <- c("*" = .10, "**" = .05, "***" = .01)

# ------------------------------------------------------------------------------
# IV Probit por máxima verosimilitud (equivalente a ivprobit de Stata)
#   y*  = X b + g*y2 + u,   y2 = Z pi + v,   (u,v) normal, var(u)=1, corr = rho
#   X: regresores exógenos (con constante), Z: X + instrumentos excluidos
# ------------------------------------------------------------------------------
ivprobit_mle <- function(y, X, y2, Z, se = TRUE) {
  kx <- ncol(X); kz <- ncol(Z)
  y2 <- as.vector(y2)
  X2 <- cbind(X, y2)
  q  <- 2 * y - 1

  # Descompone el vector de parametros (con lsig y arho acotados)
  desarmar <- function(th) {
    list(b    = th[1:(kx + 1)],
         pi_  = th[(kx + 2):(kx + 1 + kz)],
         lsig = max(min(th[kx + 2 + kz], 10), -10),
         arho = max(min(th[kx + 3 + kz], 8), -8))
  }
  # Cantidades comunes a la log-verosimilitud y al gradiente
  calc <- function(th) {
    p <- desarmar(th)
    sig <- exp(p$lsig); rho <- tanh(p$arho); cc <- sqrt(1 - rho^2)
    v <- as.vector(y2 - Z %*% p$pi_) / sig
    xb <- as.vector(X2 %*% p$b)
    m <- (xb + rho * v) / cc
    lp <- pnorm(q * m, log.p = TRUE)
    c(p, list(sig = sig, rho = rho, cc = cc, v = v, m = m, lp = lp))
  }

  negll <- function(th) {
    k <- calc(th)
    out <- -sum(dnorm(k$v, log = TRUE) - k$lsig + k$lp)
    if (!is.finite(out)) out <- 1e10   # penalizacion: el optimizador retrocede
    out
  }

  # Gradiente analitico (evita ~2*(#parametros) evaluaciones por iteracion)
  negscore <- function(th) {
    k <- calc(th)
    lam <- q * exp(dnorm(k$m, log = TRUE) - k$lp)     # d log Phi(q m) / d m
    dv  <- -k$v + lam * k$rho / k$cc                  # d ll / d v
    g_b <- crossprod(X2, lam / k$cc)
    g_p <- -crossprod(Z, dv) / k$sig
    g_s <- sum(-k$v * dv - 1)
    g_r <- sum(lam * (k$v * k$cc + k$m * k$rho))
    g <- -c(g_b, g_p, g_s, g_r)
    if (!all(is.finite(g))) g[] <- 0
    g
  }

  # valores iniciales: primera etapa por MCO + probit con funcion de control
  pi0 <- solve(crossprod(Z), crossprod(Z, y2))
  v0  <- as.vector(y2 - Z %*% pi0)
  s0  <- sd(v0)
  cf  <- glm(y ~ cbind(X2, v0) - 1, family = binomial("probit"))
  bcf <- coef(cf)
  # Funcion de control: b_cf = b/sqrt(1-rho^2), lambda = rho/(sigma*sqrt(1-rho^2))
  # => rho = lambda*sigma/sqrt(1+(lambda*sigma)^2), b = b_cf*sqrt(1-rho^2)
  lam <- bcf[kx + 2]
  rho0 <- (lam * s0) / sqrt(1 + (lam * s0)^2)
  th0 <- c(bcf[1:(kx + 1)] * sqrt(1 - rho0^2), pi0, log(s0), atanh(rho0))
  th0 <- unname(th0)

  opt <- optim(th0, negll, gr = negscore, method = "BFGS",
               control = list(maxit = 2000, reltol = 1e-10))
  nb <- c(colnames(X), "y2")
  if (se) {
    # Hessiana numerica a partir del gradiente analitico (solo con pocos parametros)
    H <- optimHess(opt$par, negll, gr = negscore)
    ee <- sqrt(diag(solve(H)))[1:(kx + 1)]
  } else ee <- rep(NA_real_, kx + 1)
  list(coef = setNames(opt$par[1:(kx + 1)], nb),
       se   = setNames(ee, nb),
       rho  = tanh(opt$par[kx + 3 + kz]),
       logLik = -opt$value, X2 = X2, convergence = opt$convergence)
}


################################################################################
# EJERCICIO 1
################################################################################

bwght <- zap_labels(as.data.frame(read_dta("BWGHT.DTA")))
str(bwght)

## INCISO (a)

print(table(bwght$cigs))
bwght$smokes <- as.numeric(bwght$cigs > 0)
print(table(bwght$smokes))

probit1 <- glm(smokes ~ motheduc + white + lfaminc, data = bwght,
               family = binomial("probit"))

# margins, at(white==0 motheduc==12 / 16) atmeans
# (resto de las variables en su media, calculada sobre la muestra estimada)
medias <- colMeans(model.frame(probit1)[, c("motheduc", "white", "lfaminc")])
pred_en <- function(educ) {
  nd <- data.frame(motheduc = educ, white = 0, lfaminc = medias["lfaminc"])
  predict(probit1, newdata = nd, type = "response")
}
p12 <- pred_en(12); p16 <- pred_en(16)
cat("La diferencia estimada en la probabilidad de fumar para una mujer con 16",
    "años de educación y una con 12 años de educación es", p16 - p12, "\n")

## INCISO (c)

# Primera etapa (Stata descarta observaciones con fatheduc faltante)
etapa1 <- lm(lfaminc ~ motheduc + white + fatheduc, data = bwght)
bwght$v2hat <- NA_real_
bwght$v2hat[as.numeric(names(residuals(etapa1)))] <- residuals(etapa1)

## INCISO (d)

# Test de exogeneidad (función de control): H0: coeficiente de v2hat = 0
probit_cf <- glm(smokes ~ motheduc + white + lfaminc + v2hat, data = bwght,
                 family = binomial("probit"))
print(summary(probit_cf))
z <- summary(probit_cf)$coefficients["v2hat", "z value"]
cat("Test v2hat: chi2(1) =", z^2, " p-valor =", pchisq(z^2, 1, lower.tail = FALSE), "\n")

probit_m <- glm(smokes ~ motheduc + white + lfaminc,
                data = subset(bwght, !is.na(v2hat)), family = binomial("probit"))

# Como en Stata, se descartan las observaciones con faltantes en cualquiera de
# las variables del modelo (motheduc y fatheduc tienen NA)
dat_iv <- bwght[complete.cases(bwght[, c("smokes", "motheduc", "white",
                                         "lfaminc", "fatheduc")]), ]
Xiv <- cbind(`(Intercept)` = 1, motheduc = dat_iv$motheduc, white = dat_iv$white)
Ziv <- cbind(Xiv, fatheduc = dat_iv$fatheduc)
ivp1 <- ivprobit_mle(dat_iv$smokes, Xiv, dat_iv$lfaminc, Ziv)
names(ivp1$coef)[length(ivp1$coef)] <- names(ivp1$se)[length(ivp1$se)] <- "lfaminc"

cat("\nIV Probit (ML): rho =", ivp1$rho, " logLik =", ivp1$logLik, "\n")
tabla1 <- data.frame(Probit = NA, `Probit EE` = NA, `IV Probit` = ivp1$coef,
                     `IV Probit EE` = ivp1$se, check.names = FALSE)
cp <- summary(probit_m)$coefficients
tabla1[rownames(cp), "Probit"]    <- cp[, 1]
tabla1[rownames(cp), "Probit EE"] <- cp[, 2]
print(round(tabla1, 4))


################################################################################
# EJERCICIO 2
################################################################################

price <- zap_labels(as.data.frame(read_dta("pricedata.dta")))

# Diseño muestral guardado en el .dta: pweight = v00281, PSU = UPA_PNS
# (svyset UPA_PNS [pweight=v00281])
options(survey.lonely.psu = "adjust")

factores <- c("AgeCategory", "LaborCategory", "v0024", "CompleteEduc")
for (v in factores) price[[v]] <- factor(price[[v]])

fml_X <- ~ Gender + WealthIndex + AgeCategory + LaborCategory + v0024 +
  CompleteEduc + Student + MonthlyIncome + MaritalStatus
fml_Z <- ~ Gender + WealthIndex + AgeCategory + LaborCategory + v0024

dise <- function(d) svydesign(ids = ~UPA_PNS, weights = ~v00281, data = d, nest = TRUE)

## INCISO (b)

## Alternativa 1

# Etapa 1 con la muestra con precio observado (Stata descarta los faltantes)
obs <- !is.na(price$LogPricePack)
d_obs <- price[obs, ]
reg0 <- svyglm(update(fml_X, LogPricePack ~ .), design = dise(d_obs))

# Predicción para toda la muestra (niveles de factores no vistos -> base)
# (16 niveles de v0024 no aparecen en la muestra con precio: coeficiente NA,
#  que se trata como 0 -> contribucion de la categoria base)
mm_X0 <- model.matrix(fml_X, price)
stopifnot(nrow(mm_X0) == nrow(price))
b0_hat <- coef(reg0); b0_hat[is.na(b0_hat)] <- 0
price$LogPricePack_hat0 <- as.vector(mm_X0[, names(b0_hat)] %*% b0_hat)
rm(mm_X0)
price$resid0 <- price$LogPricePack - price$LogPricePack_hat0
set.seed(12345)
price$random <- rnorm(nrow(price), mean(price$resid0, na.rm = TRUE),
                      sd(price$resid0, na.rm = TRUE))
price$LogPricePack_hat1 <- price$LogPricePack
price$LogPricePack_hat1[!obs] <- price$LogPricePack_hat0[!obs] + price$random[!obs]

reg1 <- lm(update(fml_X, LogPricePack_hat1 ~ .), data = price)
price$resid1 <- residuals(reg1)

des <- dise(price)
probit_b1 <- svyglm(update(fml_Z, SmokeCigs ~ . + LogPricePack_hat1 + resid1),
                    design = des, family = quasibinomial("probit"))
print(regTermTest(probit_b1, ~ resid1))

## Alternativa 2

# svy: regress LogPricePack i.UPA_PNS (puntos idénticos con MCO ponderado)
# Con una dummy por UPA el modelo esta saturado: la prediccion es la media
# ponderada de LogPricePack dentro de cada UPA. Se calcula directamente
# (la regresion con ~3.900 dummies y su prediccion densa agotan la memoria).
medias_upa <- tapply(d_obs$LogPricePack * d_obs$v00281, d_obs$UPA_PNS, sum) /
  tapply(d_obs$v00281, d_obs$UPA_PNS, sum)
price$LogPricePack_hat2 <- as.numeric(medias_upa[as.character(price$UPA_PNS)])
# UPAs sin precio observado: todas las dummies = 0 -> prediccion = constante,
# es decir la media de la UPA base (la de menor codigo), igual que Stata
base_upa <- as.character(min(d_obs$UPA_PNS))
price$LogPricePack_hat2[is.na(price$LogPricePack_hat2)] <- medias_upa[[base_upa]]

reg2 <- lm(update(fml_X, LogPricePack_hat2 ~ .), data = price)
price$resid2 <- residuals(reg2)

des <- dise(price)
probit_b2 <- svyglm(update(fml_Z, SmokeCigs ~ . + LogPricePack_hat2 + resid2),
                    design = des, family = quasibinomial("probit"))
print(regTermTest(probit_b2, ~ resid2))

## INCISO (c)

# Instrumentos: i.CompleteEduc Student MonthlyIncome MaritalStatus
# Exógenos incluidos: Gender WealthIndex i.AgeCategory i.LaborCategory i.v0024
ivprobit_elast <- function(endog) {
  mm_X <- model.matrix(fml_Z, price)
  mm_I <- model.matrix(~ CompleteEduc + Student + MonthlyIncome + MaritalStatus,
                       price)[, -1, drop = FALSE]
  # se descartan columnas colineales (Stata las omite)
  qrx <- qr(cbind(mm_X, mm_I)); keep <- qrx$pivot[seq_len(qrx$rank)]
  Z <- cbind(mm_X, mm_I)[, sort(keep), drop = FALSE]
  X <- mm_X[, colnames(mm_X) %in% colnames(Z), drop = FALSE]
  # se = FALSE: la hessiana de ~1.200 parametros es muy costosa y aqui
  # solo hacen falta los coeficientes para la elasticidad
  fit <- ivprobit_mle(price$SmokeCigs, X, price[[endog]], Z, se = FALSE)
  xb  <- as.vector(fit$X2 %*% fit$coef)
  elast <- fit$coef["y2"] * pnorm(xb) / dnorm(xb)
  cat("\nIV Probit (", endog, "): coef. endógena =", fit$coef["y2"],
      " rho =", fit$rho, " convergencia =", fit$convergence, "\n")
  price$elast <- as.vector(elast)
  print(svymean(~elast, dise(price)))
}

## Alternativa 1
ivprobit_elast("LogPricePack_hat1")

## Alternativa 2
ivprobit_elast("LogPricePack_hat2")


################################################################################
# EJERCICIO 3
################################################################################

# Nota: el generador de números aleatorios de R no replica el de Stata, por lo
# que los valores simulados (y las estimaciones) difieren en la semilla.
set.seed(12345)
n <- 1000

x     <- runif(n, -1, 1)
xhet  <- runif(n)
sigma <- exp(1.5 * xhet)
p     <- pnorm((0.3 + 2 * x) / sigma)
y     <- ifelse(p >= runif(n), 1, 0)
sim   <- data.frame(y, x, xhet)

hetprobit <- hetglm(y ~ x | xhet, data = sim, family = binomial("probit"))
print(summary(hetprobit))

# test x == 2 (Wald)
wald_x2 <- function(m, nombre = "x") {
  cf <- coef(m)[nombre]; v <- vcov(m)[nombre, nombre]
  w <- (cf - 2)^2 / v
  cat("Test x == 2: chi2(1) =", w, " p-valor =", pchisq(w, 1, lower.tail = FALSE), "\n")
}
wald_x2(hetprobit, "x")

probit3 <- glm(y ~ x, data = sim, family = binomial("probit"))
print(summary(probit3))
wald_x2(probit3, "x")

# Tabla comparativa (modelsummary no soporta objetos hetglm)
estrellas <- function(p) ifelse(p < .01, "***", ifelse(p < .05, "**", ifelse(p < .10, "*", "")))
fila <- function(m, nombre, rotulo) {
  cf <- summary(m)$coefficients
  cf <- if (is.list(cf)) do.call(rbind, cf) else cf
  cf <- cf[nombre, , drop = FALSE]
  data.frame(termino = rotulo,
             est = sprintf("%.4f%s", cf[, 1], estrellas(cf[, 4])),
             ee = sprintf("(%.4f)", cf[, 2]))
}
tab_het <- rbind(fila(hetprobit, "(Intercept)", "Constante"),
                 fila(hetprobit, "x", "x"),
                 fila(hetprobit, "xhet", "xhet (heterocedasticidad)"))
tab_pro <- rbind(fila(probit3, "(Intercept)", "Constante"),
                 fila(probit3, "x", "x"))
cat("\nProbit Heterocedástico\n"); print(tab_het, row.names = FALSE)
cat("\nProbit\n"); print(tab_pro, row.names = FALSE)
cat("\nLog-verosimilitud: hetprobit =", as.numeric(logLik(hetprobit)),
    " probit =", as.numeric(logLik(probit3)), "\n")
