################################################################################
# Trabajo Práctico N° 3 - Microeconometría I
# Traducción a R del do-file de Stata
################################################################################

rm(list = ls())

paquetes <- c("haven", "nnet", "mlogit", "dfidx", "pbivnorm", "ggplot2")
faltan <- paquetes[!sapply(paquetes, requireNamespace, quietly = TRUE)]
if (length(faltan) > 0) install.packages(faltan)
invisible(lapply(paquetes, library, character.only = TRUE))

# Directorio de trabajo: carpeta donde están los datos
if (requireNamespace("rstudioapi", quietly = TRUE) &&
    rstudioapi::isAvailable()) {
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}
setwd("D:/Box/Maestria_en_Econometria_UTDT/06. Microeconometría I/Trabajos Prácticos/Trabajo Práctico N° 3/Datos")

# ------------------------------------------------------------------------------
# Funciones auxiliares
# ------------------------------------------------------------------------------

# Nombres de los parametros de una matriz de coeficientes B (J-1 x K) vectorizada
# por columnas: "eq:variable" (misma convencion que vcov de nnet::multinom)
nombres_theta <- function(B) {
  paste(rep(rownames(B), times = ncol(B)), rep(colnames(B), each = nrow(B)), sep = ":")
}

# Probabilidades del logit multinomial. eta: n x J con la base (col. 1) en 0
probs_mlogit <- function(eta) {
  e <- exp(eta - apply(eta, 1, max)); e / rowSums(e)
}

# Probabilidades del probit multinomial con errores independientes (J = 3),
# como mprobit de Stata: P(y=j) = P(e_k - e_j < V_j - V_k, k != j), donde las
# diferencias tienen var = 2 y cov = 1 (correlacion 0,5) -> normal bivariada.
probs_mprobit3 <- function(eta) {
  pj <- function(j) {
    o <- setdiff(1:3, j)
    z1 <- (eta[, j] - eta[, o[1]]) / sqrt(2)
    z2 <- (eta[, j] - eta[, o[2]]) / sqrt(2)
    pbivnorm(z1, z2, rho = 0.5)
  }
  p <- cbind(pj(1), pj(2), pj(3))
  pmin(pmax(p, 1e-12), 1)
}

# Probabilidades a partir del vector de parametros theta (matriz B vectorizada)
probs_theta <- function(theta, X, J, K, tipo) {
  B <- matrix(theta, nrow = J - 1, ncol = K)
  eta <- cbind(0, X %*% t(B))
  if (tipo == "logit") probs_mlogit(eta) else probs_mprobit3(eta)
}

# Efectos marginales sobre Pr(y = j) evaluados en las medias (equivalente a
# mfx, predict(pr outcome(j)) de Stata): derivada numerica para variables
# continuas y cambio discreto 0 -> 1 para dummies. Errores estandar por metodo
# delta con jacobiano numerico.
mfx_medias <- function(theta, V, X, J, tipo, dummies, h = 1e-5) {
  K <- ncol(X); xbar <- colMeans(X)
  vars <- setdiff(colnames(X), "(Intercept)")
  me <- function(th) {
    out <- matrix(NA_real_, J, length(vars), dimnames = list(NULL, vars))
    for (v in vars) {
      x1 <- x0 <- xbar
      if (v %in% dummies) { x1[v] <- 1; x0[v] <- 0; d <- 1
      } else { x1[v] <- x1[v] + h; x0[v] <- x0[v] - h; d <- 2 * h }
      p1 <- probs_theta(th, rbind(x1), J, K, tipo)
      p0 <- probs_theta(th, rbind(x0), J, K, tipo)
      out[, v] <- (p1 - p0) / d
    }
    out
  }
  est <- me(theta)
  Jac <- sapply(seq_along(theta), function(i) {
    e <- rep(0, length(theta)); e[i] <- 1e-5
    as.vector(me(theta + e) - me(theta - e)) / 2e-5
  })
  se <- matrix(sqrt(pmax(diag(Jac %*% V %*% t(Jac)), 0)), J, length(vars))
  list(dydx = est, se = se, vars = vars)
}

imprimir_mfx <- function(r, J) {
  for (j in 1:J) {
    cat("\nEfectos marginales sobre Pr(y =", j, ") en las medias\n")
    tab <- data.frame(dydx = r$dydx[j, ], ee = r$se[j, ],
                      z = r$dydx[j, ] / r$se[j, ],
                      p = 2 * pnorm(-abs(r$dydx[j, ] / r$se[j, ])))
    print(round(tab, 5))
  }
}

# Test de Wald (igual que test de Stata) sobre un subconjunto de parametros
wald <- function(theta, V, idx, etiqueta = "") {
  b <- theta[idx]; W <- as.numeric(t(b) %*% solve(V[idx, idx, drop = FALSE]) %*% b)
  df <- length(idx)
  cat(sprintf("Test %-12s chi2(%d) = %9.4f   p-valor = %.4f\n",
              etiqueta, df, W, pchisq(W, df, lower.tail = FALSE)))
}

# Ajusta el multinomial y devuelve theta, vcov y probabilidades
ajustar_mlogit <- function(fml, data) {
  # la llamada se arma con los valores ya sustituidos para que fitted()/vcov()
  # no dependan de los nombres locales de esta funcion
  m <- eval(bquote(multinom(.(fml), data = .(data), maxit = 1000,
                            reltol = 1e-12, trace = FALSE)))
  B <- coef(m); th <- as.vector(B)
  V <- vcov(m)[nombres_theta(B), nombres_theta(B)]
  list(m = m, B = B, theta = setNames(th, nombres_theta(B)), V = V,
       logLik = as.numeric(logLik(m)))
}

# Tabla de coeficientes (equivalente a la salida de mlogit de Stata)
tabla_coef <- function(r) {
  ee <- sqrt(diag(r$V)); z <- r$theta / ee
  cat("Log-verosimilitud:", r$logLik, "\n")
  print(round(cbind(coef = r$theta, ee = ee, z = z,
                    p = 2 * pnorm(-abs(z))), 4))
}


################################################################################
# EJERCICIO 1
################################################################################

## INCISO (a)

pesca <- zap_labels(as.data.frame(read_dta("fishingchoice.dta")))
str(pesca)

print(summary(pesca))
print(table(pesca$mode))

# table mode, contents(N income mean income sd income)
print(do.call(rbind, lapply(split(pesca$income, pesca$mode), function(x)
  c(N = length(x), media = mean(x), sd = sd(x)))))
print(aggregate(cbind(pbeach, ppier, pprivate, pcharter) ~ mode, pesca, mean))
print(aggregate(cbind(qbeach, qpier, qprivate, qcharter) ~ mode, pesca, mean))

## INCISO (b)

pesca$modo <- factor(pesca$mode, levels = 1:4,
                     labels = c("beach", "pier", "private", "charter"))
ml <- ajustar_mlogit(modo ~ income, pesca)
tabla_coef(ml)
cat("\nRazones de riesgo relativo (rrr)\n"); print(exp(ml$B))

# test income (conjunto, todas las ecuaciones)
wald(ml$theta, ml$V, grep(":income$", names(ml$theta)), "income")

pr_mlogit <- fitted(ml$m)
colnames(pr_mlogit) <- paste0("pr_mlogit", 1:4)
d_modo <- pesca[, c("dbeach", "dpier", "dprivate", "dcharter")]
print(summary(cbind(pr_mlogit, d_modo)))

X1 <- model.matrix(~ income, pesca)
imprimir_mfx(mfx_medias(ml$theta, ml$V, X1, J = 4, tipo = "logit", dummies = character(0)), 4)

## INCISO (c)

# reshape long d p q, i(id) j(fishmode beach pier private charter)
alts <- c("beach", "pier", "private", "charter")
pesca$id <- seq_len(nrow(pesca))
largo <- do.call(rbind, lapply(alts, function(a)
  data.frame(id = pesca$id, fishmode = a,
             d = as.logical(pesca[[paste0("d", a)]]),
             p = pesca[[paste0("p", a)]], q = pesca[[paste0("q", a)]],
             income = pesca$income)))
largo$fishmode <- factor(largo$fishmode, levels = alts)
largo <- largo[order(largo$id, largo$fishmode), ]
largo_idx <- dfidx(largo, idx = c("id", "fishmode"))

# asclogit d p q, casevars(income) basealternative(beach)
clogit1 <- mlogit(d ~ p + q | income, data = largo_idx, reflevel = "beach")
print(summary(clogit1))
pr1 <- fitted(clogit1, outcome = FALSE)
tabla_pr <- function(pr) {
  t <- t(sapply(alts, function(a)
    c(media_d = mean(pesca[[paste0("d", a)]]), media_pr = mean(pr[, a]), sd_pr = sd(pr[, a]))))
  t
}
print(tabla_pr(pr1))

# asclogit d, casevars(income): solo variables del individuo
clogit2 <- mlogit(d ~ 0 | income, data = largo_idx, reflevel = "beach")
print(summary(clogit2))
pr2 <- fitted(clogit2, outcome = FALSE)
print(tabla_pr(pr2))


################################################################################
# EJERCICIO 2
################################################################################

nps <- zap_labels(as.data.frame(read_dta("NPS.dta")))
str(nps)
set.seed(12345)

## INCISO (a)

print(nps[duplicated(nps) | duplicated(nps, fromLast = TRUE), ])   # duplicates list
print(data.frame(faltantes = colSums(is.na(nps)),                  # mdesc
                 porcentaje = round(colMeans(is.na(nps)) * 100, 2)))
print(summary(nps))
nps <- nps[!is.na(nps$nps), ]

## INCISO (b)

nps$clasificacion <- cut(nps$nps, breaks = c(-Inf, 6, 8, Inf),
                         labels = c("Detractor", "Neutral", "Promotor"))
print(table(nps$clasificacion))

## INCISO (c)

print(aggregate(espera ~ clasificacion, nps,
                function(x) c(N = length(x), media = mean(x), sd = sd(x),
                              min = min(x), max = max(x))))
print(ggplot(nps, aes(clasificacion, espera)) + geom_boxplot())

## INCISO (d)

# sample 10: muestra aleatoria del 10% (la semilla de R no replica la de Stata)
nps$gender_code <- factor(nps$gender_code)
nps$segmento    <- factor(nps$segmento)
muestra <- nps[sample(nrow(nps), round(0.10 * nrow(nps))), ]
cat("Tamaño de la muestra:", nrow(muestra), "\n")

fml2 <- clasificacion ~ gender_code + edad + segmento + espera
ml2 <- ajustar_mlogit(fml2, muestra)
tabla_coef(ml2)
cat("\nRazones de riesgo relativo (rrr)\n"); print(exp(ml2$B))
pr_ml2 <- fitted(ml2$m)

## INCISO (e)

X2 <- model.matrix(fml2[-2], muestra)
dummies2 <- grep("^gender_code|^segmento", colnames(X2), value = TRUE)
imprimir_mfx(mfx_medias(ml2$theta, ml2$V, X2, J = 3, tipo = "logit", dummies = dummies2), 3)

## INCISO (f)

# mprobit clasificacion ..., baseoutcome(1): probit multinomial con errores
# independientes, estimado por maxima verosimilitud exacta
y2 <- as.integer(muestra$clasificacion)
K2 <- ncol(X2); J2 <- 3
negll_mp <- function(th) {
  p <- probs_theta(th, X2, J2, K2, "probit")
  -sum(log(p[cbind(seq_along(y2), y2)]))
}
th0 <- as.vector(ml2$B) / 1.6                    # valor inicial: logit / 1,6
opt_mp <- optim(th0, negll_mp, method = "BFGS", hessian = TRUE,
                control = list(maxit = 500, reltol = 1e-10))
cat("Convergencia mprobit:", opt_mp$convergence, " logLik =", -opt_mp$value, "\n")
B_mp <- matrix(opt_mp$par, nrow = J2 - 1, ncol = K2,
               dimnames = dimnames(ml2$B))
theta_mp <- setNames(opt_mp$par, nombres_theta(B_mp))
V_mp <- solve(opt_mp$hessian); dimnames(V_mp) <- list(names(theta_mp), names(theta_mp))
print(round(cbind(coef = theta_mp, ee = sqrt(diag(V_mp)),
                  z = theta_mp / sqrt(diag(V_mp))), 4))
pr_mprobit <- probs_theta(theta_mp, X2, J2, K2, "probit")
colnames(pr_mprobit) <- paste0("pr_mprobit", 1:3)

imprimir_mfx(mfx_medias(theta_mp, V_mp, X2, J = 3, tipo = "probit", dummies = dummies2), 3)

## INCISO (g)

tests <- function(theta, V) {
  noconst <- grep(":\\(Intercept\\)$", names(theta), invert = TRUE)
  wald(theta, V, noconst, "(todas)")
  for (v in setdiff(colnames(X2), "(Intercept)"))
    wald(theta, V, grep(paste0(":", v, "$"), names(theta)), v)
}
cat("\nMultinomial logit\n");  tests(ml2$theta, ml2$V)
cat("\nMultinomial probit\n"); tests(theta_mp, V_mp)


################################################################################
# EJERCICIO 3
################################################################################

# (el .xlsx ya esta convertido a .dta en la carpeta)
eph <- zap_labels(as.data.frame(read_dta("usu_individual_t416.dta")))
str(eph)

eph <- eph[eph$estado %in% c(1, 2, 3), ]

eph$d_ocupado    <- as.numeric(eph$estado == 1)
eph$d_desocupado <- as.numeric(eph$estado == 2)
eph$d_inactivo   <- as.numeric(eph$estado == 3)

eph$aglomerado <- factor(eph$aglomerado)
eph$ch07       <- factor(eph$ch07)
eph$estado_f   <- relevel(factor(eph$estado), ref = "3")   # baseoutcome(3)

ml3 <- ajustar_mlogit(estado_f ~ aglomerado + ch06 + ch07, eph)
tabla_coef(ml3)
cat("\nRazones de riesgo relativo (rrr)\n"); print(exp(ml3$B))

pr_ml3 <- fitted(ml3$m)[, c("1", "2", "3")]
colnames(pr_ml3) <- paste0("pr_mlogit", 1:3)
print(summary(cbind(pr_ml3, eph[, c("d_ocupado", "d_desocupado", "d_inactivo")])))
