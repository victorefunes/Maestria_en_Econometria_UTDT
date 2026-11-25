################################################################################
# Trabajo Práctico N° 4 - Microeconometría I
# Traducción a R del do-file de Stata
################################################################################

rm(list = ls())

paquetes <- c("haven", "MASS", "ggplot2")
faltan <- paquetes[!sapply(paquetes, requireNamespace, quietly = TRUE)]
if (length(faltan) > 0) install.packages(faltan)
invisible(lapply(paquetes, library, character.only = TRUE))

# Directorio de trabajo: carpeta donde están los datos
if (requireNamespace("rstudioapi", quietly = TRUE) &&
    rstudioapi::isAvailable()) {
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}
setwd("D:/Box/Maestria_en_Econometria_UTDT/06. Microeconometría I/Trabajos Prácticos/Trabajo Práctico N° 4/Datos")


# ------------------------------------------------------------------------------
# Funciones auxiliares (modelos ordenados)
# ------------------------------------------------------------------------------

# Ajusta un modelo ordenado con polr. La llamada se arma con los valores ya
# sustituidos para que fitted()/vcov() no dependan de nombres locales.
ajustar_ordenado <- function(fml, data, metodo) {
  m <- eval(bquote(polr(.(fml), data = .(data), Hess = TRUE, method = .(metodo))))
  th <- c(coef(m), m$zeta)
  V <- vcov(m)[names(th), names(th)]
  list(m = m, theta = th, V = V, nb = length(coef(m)),
       logLik = as.numeric(logLik(m)), metodo = metodo)
}

tabla_coef <- function(r) {
  ee <- sqrt(diag(r$V)); z <- r$theta / ee
  cat("Log-verosimilitud:", r$logLik, "\n")
  print(round(cbind(coef = r$theta, ee = ee, z = z, p = 2 * pnorm(-abs(z))), 4))
}

# Probabilidades de cada categoria: P(y=k) = F(c_k - xb) - F(c_{k-1} - xb)
probs_ord <- function(theta, X, nb, metodo) {
  Fn <- if (metodo == "logistic") plogis else pnorm
  b <- theta[1:nb]; cuts <- theta[-(1:nb)]
  eta <- as.vector(X %*% b)
  # matriz n x (J-1) de probabilidades acumuladas (n puede ser 1)
  F_k <- matrix(sapply(cuts, function(k) Fn(k - eta)), nrow = length(eta))
  acum <- cbind(0, F_k, 1)
  acum[, -1, drop = FALSE] - acum[, -ncol(acum), drop = FALSE]
}

# Efectos marginales en las medias sobre Pr(y = j) (mfx, predict(pr outcome(j)));
# dummies: cambio discreto 0 -> 1; continuas: derivada numerica. Metodo delta.
mfx_ord <- function(r, X, dummies, h = 1e-5) {
  nb <- r$nb; vars <- colnames(X); xbar <- colMeans(X); J <- length(r$theta) - nb + 1
  me <- function(th) {
    out <- matrix(NA_real_, J, length(vars), dimnames = list(NULL, vars))
    for (v in vars) {
      x1 <- x0 <- xbar
      if (v %in% dummies) { x1[v] <- 1; x0[v] <- 0; d <- 1
      } else { x1[v] <- x1[v] + h; x0[v] <- x0[v] - h; d <- 2 * h }
      out[, v] <- as.vector(probs_ord(th, rbind(x1), nb, r$metodo) -
                            probs_ord(th, rbind(x0), nb, r$metodo)) / d
    }
    out
  }
  est <- me(r$theta)
  Jac <- sapply(seq_along(r$theta), function(i) {
    e <- rep(0, length(r$theta)); e[i] <- 1e-5
    as.vector(me(r$theta + e) - me(r$theta - e)) / 2e-5
  })
  se <- matrix(sqrt(pmax(diag(Jac %*% r$V %*% t(Jac)), 0)), J, length(vars))
  for (j in 1:J) {
    cat("\nEfectos marginales sobre Pr(y =", j, ") en las medias\n")
    z <- est[j, ] / se[j, ]
    print(round(data.frame(dydx = est[j, ], ee = se[j, ], z = z,
                           p = 2 * pnorm(-abs(z))), 5))
  }
  invisible(list(dydx = est, se = se))
}

wald <- function(theta, V, idx, etiqueta = "") {
  b <- theta[idx]; W <- as.numeric(t(b) %*% solve(V[idx, idx, drop = FALSE]) %*% b)
  cat(sprintf("Test %-22s chi2(%d) = %9.4f   p-valor = %.4f\n",
              etiqueta, length(idx), W, pchisq(W, length(idx), lower.tail = FALSE)))
}


################################################################################
# EJERCICIO 1
################################################################################

## INCISO (a)

nps <- zap_labels(as.data.frame(read_dta("NPS.dta")))
str(nps)

print(nps[duplicated(nps) | duplicated(nps, fromLast = TRUE), ])   # duplicates list
print(data.frame(faltantes = colSums(is.na(nps)),                  # mdesc
                 porcentaje = round(colMeans(is.na(nps)) * 100, 2)))
print(summary(nps))
nps <- nps[!is.na(nps$nps), ]

## INCISO (b)

nps$clasificacion <- cut(nps$nps, breaks = c(-Inf, 6, 8, Inf),
                         labels = c("Detractor", "Neutral", "Promotor"),
                         ordered_result = TRUE)
print(table(nps$clasificacion))

## INCISO (c)

print(aggregate(espera ~ clasificacion, nps,
                function(x) c(N = length(x), media = mean(x), sd = sd(x),
                              min = min(x), max = max(x))))
print(ggplot(nps, aes(clasificacion, espera)) + geom_boxplot())

## INCISO (d)

# sample 10: muestra aleatoria del 10% que se mantiene en todo el ejercicio
# (la semilla de R no replica la de Stata)
set.seed(12345)
nps$gender_code <- factor(nps$gender_code)
nps$segmento    <- factor(nps$segmento)
muestra <- nps[sample(nrow(nps), round(0.10 * nrow(nps))), ]
cat("Tamaño de la muestra:", nrow(muestra), "\n")

fml1 <- clasificacion ~ gender_code + edad + segmento + espera
ologit <- ajustar_ordenado(fml1, muestra, "logistic")
tabla_coef(ologit)
cat("\nOdds ratios (ologit, or)\n")
print(round(exp(ologit$theta[1:ologit$nb]), 4))
pr_ologit <- fitted(ologit$m)
colnames(pr_ologit) <- paste0("pr_ologit", 1:3)
print(summary(pr_ologit))

## INCISO (e)

X1 <- model.matrix(fml1[-2], muestra)[, -1]
dummies1 <- grep("^gender_code|^segmento", colnames(X1), value = TRUE)
mfx_ord(ologit, X1, dummies1)

## INCISO (f)

oprobit <- ajustar_ordenado(fml1, muestra, "probit")
tabla_coef(oprobit)
pr_oprobit <- fitted(oprobit$m)
colnames(pr_oprobit) <- paste0("pr_oprobit", 1:3)
print(summary(pr_oprobit))
mfx_ord(oprobit, X1, dummies1)

## INCISO (g)

tests <- function(r) {
  nm <- names(r$theta)[1:r$nb]
  wald(r$theta, r$V, 1:r$nb, "(todas)")
  for (v in nm) wald(r$theta, r$V, which(names(r$theta) == v), v)
}
cat("\nLogit ordenado\n");  tests(ologit)
cat("\nProbit ordenado\n"); tests(oprobit)


################################################################################
# EJERCICIO 2
################################################################################

## INCISO (a)  Logit secuencial en nlsw88

nlsw <- zap_labels(as.data.frame(read_dta("nlsw88.dta")))
str(nlsw)

nlsw$educ_cat <- with(nlsw, ifelse(is.na(grade), NA,
                    ifelse(grade < 12, 1, ifelse(grade == 12, 2,
                    ifelse(grade < 16, 3, 4)))))
nlsw$educ_cat <- factor(nlsw$educ_cat, levels = 1:4,
                        labels = c("Less than High School", "High School",
                                   "Junior College", "College"))
nlsw$race  <- factor(nlsw$race)
nlsw$south <- factor(nlsw$south)
print(table(nlsw$educ_cat, useNA = "ifany"))

# Indicadores de cada transicion (solo definidos para quienes llegan a ella)
ec <- as.integer(nlsw$educ_cat)
nlsw$hs <- ifelse(is.na(ec), NA, as.numeric(ec >= 2))
nlsw$jc <- ifelse(is.na(ec) | ec < 2, NA, as.numeric(ec >= 3))
nlsw$c  <- ifelse(is.na(ec) | ec < 3, NA, as.numeric(ec == 4))

# Tres logits separados (logit hs / jc / c)
l_hs <- glm(hs ~ race + south, data = nlsw, family = binomial)
l_jc <- glm(jc ~ race + south, data = nlsw, family = binomial)
l_c  <- glm(c  ~ race + south, data = nlsw, family = binomial)

# seqlogit con tree(1: 2 3 4, 2: 3 4, 3: 4): se estima en una sola funcion de
# verosimilitud apilando las tres transiciones con coeficientes propios de cada una
apilado <- rbind(
  data.frame(etapa = "t1", y = nlsw$hs, race = nlsw$race, south = nlsw$south),
  data.frame(etapa = "t2", y = nlsw$jc, race = nlsw$race, south = nlsw$south),
  data.frame(etapa = "t3", y = nlsw$c,  race = nlsw$race, south = nlsw$south))
apilado <- apilado[!is.na(apilado$y), ]
apilado$etapa <- factor(apilado$etapa)
seq_fit <- glm(y ~ 0 + etapa + etapa:race + etapa:south, data = apilado,
               family = binomial)

# Comparacion de coeficientes
sep <- list(t1 = coef(l_hs), t2 = coef(l_jc), t3 = coef(l_c))
cmp <- do.call(rbind, lapply(names(sep), function(e) {
  nm <- names(sep[[e]])
  nm_seq <- ifelse(nm == "(Intercept)", paste0("etapa", e),
                   paste0("etapa", e, ":", nm))
  data.frame(transicion = e, termino = nm, logit_separado = unname(sep[[e]]),
             logit_secuencial = unname(coef(seq_fit)[nm_seq]))
}))
cmp$diferencia <- cmp$logit_separado - cmp$logit_secuencial
print(cmp, digits = 6)
cat("\nMaxima diferencia absoluta entre ambos enfoques:",
    max(abs(cmp$diferencia)), "\n")
cat("Log-verosimilitud: secuencial =", as.numeric(logLik(seq_fit)),
    " suma de logits separados =",
    as.numeric(logLik(l_hs) + logLik(l_jc) + logLik(l_c)), "\n")

## INCISO (b)  Logit secuencial en gss

gss <- zap_labels(as.data.frame(read_dta("gss.dta")))
str(gss)

# NOTA: el do-file no incluye paeduc entre los regresores aunque la consigna
# pide el efecto de la educacion del padre en cada transicion; aqui se incluye.
# tree(0: 1 2 3, 1: 2 3, 2: 3): transiciones 0->{>=1}, 1->{>=2}, 2->3
gss$coh2 <- gss$coh^2                       # c.coh##c.coh
gss$t1 <- ifelse(is.na(gss$degree), NA, as.numeric(gss$degree >= 1))
gss$t2 <- ifelse(is.na(gss$degree) | gss$degree < 1, NA, as.numeric(gss$degree >= 2))
gss$t3 <- ifelse(is.na(gss$degree) | gss$degree < 2, NA, as.numeric(gss$degree == 3))

seq_gss <- function(d, etiqueta) {
  cat("\n=====", etiqueta, "=====\n")
  d <- d[complete.cases(d[, c("degree", "south", "coh", "paeduc")]), ]
  cat("Observaciones:", nrow(d), "\n")
  res <- lapply(c("t1", "t2", "t3"), function(t) {
    dd <- d[!is.na(d[[t]]), ]
    m <- glm(reformulate(c("south", "coh", "coh2", "paeduc"), response = t),
             data = dd, family = binomial)
    cf <- summary(m)$coefficients
    # efecto marginal promedio de paeduc sobre Pr(pasa la transicion)
    ame <- mean(coef(m)["paeduc"] * dlogis(predict(m)))
    cat("\nTransicion", t, " (N =", nrow(dd), ")\n")
    print(round(cbind(cf, OR = exp(cf[, 1])), 4))
    cat("Efecto marginal promedio de paeduc sobre Pr(pasar):", round(ame, 5), "\n")
    data.frame(muestra = etiqueta, transicion = t, coef_paeduc = cf["paeduc", 1],
               ee = cf["paeduc", 2], OR = exp(cf["paeduc", 1]), ame = ame,
               N = nrow(dd))
  })
  do.call(rbind, res)
}

resumen <- rbind(seq_gss(gss, "Todos"),
                 seq_gss(gss[gss$black == 0, ], "black == 0"),
                 seq_gss(gss[gss$black == 1, ], "black == 1"))

cat("\nEfecto de la educacion del padre (paeduc) en cada transicion\n")
print(resumen, digits = 4, row.names = FALSE)
