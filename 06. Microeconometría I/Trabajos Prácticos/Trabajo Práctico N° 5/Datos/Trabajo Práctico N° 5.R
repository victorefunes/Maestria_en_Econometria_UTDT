################################################################################
# Trabajo Práctico N° 5 - Microeconometría I
# Traducción a R del do-file de Stata (modelos Tobit)
################################################################################

rm(list = ls())

paquetes <- c("haven", "ggplot2")
faltan <- paquetes[!sapply(paquetes, requireNamespace, quietly = TRUE)]
if (length(faltan) > 0) install.packages(faltan)
invisible(lapply(paquetes, library, character.only = TRUE))

# Directorio de trabajo: carpeta donde están los datos
if (requireNamespace("rstudioapi", quietly = TRUE) &&
    rstudioapi::isAvailable()) {
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}
setwd("D:/Box/Maestria_en_Econometria_UTDT/06. Microeconometría I/Trabajos Prácticos/Trabajo Práctico N° 5/Datos")


# ------------------------------------------------------------------------------
# Tobit por maxima verosimilitud (equivalente a tobit de Stata)
#   y* = X b + u, u ~ N(0, s^2);  y = max(L, min(y*, U))
#   Como en Stata, se consideran censuradas las observaciones con y <= L / y >= U
#   (tobit y x, ll  -> L = min(y), ul -> U = max(y))
# ------------------------------------------------------------------------------
tobit_ml <- function(y, X, L = -Inf, U = Inf) {
  K <- ncol(X)
  cL <- y <= L; cU <- y >= U; cN <- !cL & !cU
  negll <- function(th) {
    b <- th[1:K]; s <- exp(th[K + 1]); xb <- as.vector(X %*% b)
    ll <- numeric(length(y))
    ll[cN] <- dnorm((y[cN] - xb[cN]) / s, log = TRUE) - log(s)
    if (any(cL)) ll[cL] <- pnorm((L - xb[cL]) / s, log.p = TRUE)
    if (any(cU)) ll[cU] <- pnorm((U - xb[cU]) / s, lower.tail = FALSE, log.p = TRUE)
    -sum(ll)
  }
  ols <- lm.fit(X, y)
  s0 <- sqrt(sum(ols$residuals^2) / (length(y) - K))
  opt <- optim(c(ols$coefficients, log(s0)), negll, method = "BFGS",
               hessian = TRUE, control = list(maxit = 2000, reltol = 1e-12))
  # varianza en la parametrizacion (b, sigma) por metodo delta desde (b, log sigma)
  s <- exp(opt$par[K + 1])
  Vl <- solve(opt$hessian)
  D <- diag(c(rep(1, K), s))
  V <- D %*% Vl %*% D
  th <- c(opt$par[1:K], s)
  nm <- c(colnames(X), "sigma")
  names(th) <- nm; dimnames(V) <- list(nm, nm)
  # modelo nulo (solo constante) para el pseudo R2
  X0 <- matrix(1, nrow(X), 1, dimnames = list(NULL, "(Intercept)"))
  ll0 <- if (K > 1) -tobit_ml(y, X0, L, U)$negll else -opt$value
  list(theta = th, V = V, K = K, L = L, U = U, N = length(y),
       n_cens_izq = sum(cL), n_cens_der = sum(cU), n_no_cens = sum(cN),
       logLik = -opt$value, ll0 = ll0, negll = opt$value,
       pseudoR2 = 1 - (-opt$value) / ll0, convergencia = opt$convergence,
       xb = as.vector(X %*% th[1:K]))
}

# Valores esperados del Tobit en funcion del indice xb
#   ystar(L,U): E[y*] con y* = max(L, min(y,U)) (media censurada)
#   e(L,U)    : E[y | L < y < U]                (media truncada)
E_censurada <- function(xb, s, L, U) {
  a <- (L - xb) / s; b <- (U - xb) / s
  pL <- if (is.finite(L)) L * pnorm(a) else 0
  pU <- if (is.finite(U)) U * pnorm(b, lower.tail = FALSE) else 0
  pL + pU + xb * (pnorm(b) - pnorm(a)) + s * (dnorm(a) - dnorm(b))
}
E_truncada <- function(xb, s, L, U) {
  a <- (L - xb) / s; b <- (U - xb) / s
  xb + s * (dnorm(a) - dnorm(b)) / (pnorm(b) - pnorm(a))
}

# Efectos marginales (margins, predict(ystar(L,U)|e(L,U)) dydx(...)).
#   Xs: filas donde se evalua; se promedian los efectos sobre esas filas
#   (average marginal effects) -> con una fila equivale a atmeans / at().
#   Errores estandar por metodo delta con jacobiano numerico en (b, sigma).
me_tobit <- function(r, Xs, tipo = c("ystar", "e"), h = 1e-5) {
  tipo <- match.arg(tipo)
  Ef <- if (tipo == "ystar") E_censurada else E_truncada
  K <- r$K; vars <- setdiff(colnames(Xs), "(Intercept)")
  vi <- match(vars, colnames(Xs))
  me <- function(th) {
    b <- th[1:K]; s <- th[K + 1]; xb <- as.vector(Xs %*% b)
    dE <- (Ef(xb + h, s, r$L, r$U) - Ef(xb - h, s, r$L, r$U)) / (2 * h)
    sapply(vi, function(j) mean(b[j] * dE))
  }
  est <- me(r$theta)
  Jac <- sapply(seq_along(r$theta), function(i) {
    e <- rep(0, length(r$theta)); e[i] <- 1e-6
    (me(r$theta + e) - me(r$theta - e)) / 2e-6
  })
  Jac <- matrix(Jac, nrow = length(vars))
  se <- sqrt(pmax(diag(Jac %*% r$V %*% t(Jac)), 0))
  data.frame(dydx = est, ee = se, z = est / se,
             p = 2 * pnorm(-abs(est / se)), row.names = vars)
}

# Tabla comparativa de modelos (equivalente a esttab, se star)
estrellas <- function(p) ifelse(p < .01, "***", ifelse(p < .05, "**", ifelse(p < .10, "*", "")))
coef_tabla <- function(m) {
  if (inherits(m, "lm")) {
    cf <- summary(m)$coefficients
    list(est = cf[, 1], ee = cf[, 2], p = cf[, 4],
         stats = c(N = nobs(m), R2 = summary(m)$r.squared))
  } else {
    ee <- sqrt(diag(m$V)); z <- m$theta / ee
    list(est = m$theta, ee = ee, p = 2 * pnorm(-abs(z)),
         stats = c(N = m$N, pseudoR2 = m$pseudoR2, logLik = m$logLik))
  }
}
tabla_modelos <- function(modelos) {
  tt <- lapply(modelos, coef_tabla)
  nombres <- unique(unlist(lapply(tt, function(t) names(t$est))))
  out <- do.call(cbind, lapply(tt, function(t) {
    v <- character(2 * length(nombres))
    for (i in seq_along(nombres)) {
      n <- nombres[i]
      if (n %in% names(t$est)) {
        v[2 * i - 1] <- sprintf("%.4f%s", t$est[n], estrellas(t$p[n]))
        v[2 * i]     <- sprintf("(%.4f)", t$ee[n])
      }
    }
    v
  }))
  rownames(out) <- as.vector(rbind(nombres, ""))
  colnames(out) <- names(modelos)
  est <- do.call(cbind, lapply(tt, function(t) {
    c(N = unname(t$stats["N"]),
      `R2 / pseudo R2` = unname(if ("R2" %in% names(t$stats)) t$stats["R2"] else t$stats["pseudoR2"]))
  }))
  print(noquote(rbind(out, round(est, 4))))
}

# summarize, detail (percentiles principales)
resumen_detalle <- function(x) {
  x <- x[!is.na(x)]
  print(round(c(N = length(x), media = mean(x), sd = sd(x), min = min(x),
                quantile(x, c(.01, .05, .10, .25, .50, .75, .90, .95, .99)),
                max = max(x)), 4))
}


################################################################################
# EJERCICIO 1
################################################################################

## INCISO (a)

# webuse auto (base publica de Stata). Si no hay conexion, colocar auto.dta
# en la carpeta de datos.
auto <- tryCatch(zap_labels(as.data.frame(read_dta("https://www.stata-press.com/data/r17/auto.dta"))),
                 error = function(e) zap_labels(as.data.frame(read_dta("auto.dta"))))
str(auto)
print(summary(auto))
auto$wgt <- auto$weight / 1000

resumen_detalle(auto$mpg)
print(table(auto$mpg[auto$mpg < 17]))
cat("Observaciones con mpg < 17:", sum(auto$mpg < 17), "\n")
auto$mpg_a <- pmax(auto$mpg, 17)               # replace mpg_a=17 if mpg_a<17

X_a <- model.matrix(~ wgt, auto)
est_ols    <- lm(mpg   ~ wgt, auto)
est_ols_a  <- lm(mpg_a ~ wgt, auto)
est_tobit_a1 <- tobit_ml(auto$mpg_a, X_a, L = min(auto$mpg_a))   # tobit ..., ll
est_tobit_a2 <- tobit_ml(auto$mpg_a, X_a, L = 17)                # tobit ..., ll(17)

tabla_modelos(list(OLS = est_ols, `OLS ll(17)` = est_ols_a,
                   `Tobit ll()` = est_tobit_a1, `Tobit ll(17)` = est_tobit_a2))
cat("Observaciones censuradas por la izquierda:", est_tobit_a2$n_cens_izq, "\n")

## INCISO (b)

resumen_detalle(auto$mpg)
print(table(auto$mpg[auto$mpg > 24]))
cat("Observaciones con mpg > 24:", sum(auto$mpg > 24), "\n")
auto$mpg_b <- pmin(auto$mpg, 24)               # replace mpg_b=24 if mpg_b>24

est_ols_b <- lm(mpg_b ~ wgt, auto)
est_tobit_b1 <- tobit_ml(auto$mpg_b, X_a, U = max(auto$mpg_b))   # tobit ..., ul
est_tobit_b2 <- tobit_ml(auto$mpg_b, X_a, U = 24)                # tobit ..., ul(24)

tabla_modelos(list(OLS = est_ols, `OLS ul(24)` = est_ols_b,
                   `Tobit ul()` = est_tobit_b1, `Tobit ul(24)` = est_tobit_b2))

## INCISO (c)

# margins, predict(...) dydx(wgt) at(wgt=(1 2 3 4))
em_en <- function(r, tipo) {
  do.call(rbind, lapply(1:4, function(w) {
    cbind(wgt = w, me_tobit(r, cbind(`(Intercept)` = 1, wgt = w), tipo))
  }))
}
cat("\nTobit ll(17): ystar(17,.)  -> efecto marginal sobre E[y*]\n")
print(round(em_en(est_tobit_a2, "ystar"), 5))
cat("\nTobit ll(17): e(17,.)      -> efecto marginal sobre E[y | y > 17]\n")
print(round(em_en(est_tobit_a2, "e"), 5))
cat("\nTobit ul(24): ystar(.,24)  -> efecto marginal sobre E[y*]\n")
print(round(em_en(est_tobit_b2, "ystar"), 5))
cat("\nTobit ul(24): e(.,24)      -> efecto marginal sobre E[y | y < 24]\n")
print(round(em_en(est_tobit_b2, "e"), 5))


################################################################################
# EJERCICIO 2
################################################################################

## INCISO (a)

ms <- zap_labels(as.data.frame(read_dta("mus16datav2.dta")))
str(ms)
vars2 <- c("age", "female", "educ", "blhisp", "totchr", "ins")

print(ms[duplicated(ms) | duplicated(ms, fromLast = TRUE), ])         # duplicates list
print(data.frame(faltantes = colSums(is.na(ms)),                      # mdesc
                 porcentaje = round(colMeans(is.na(ms)) * 100, 2)))
print(summary(ms))
print(summary(ms[, vars2]))
resumen_detalle(ms$ambexp)
cat("Proporcion de ambexp == 0:", mean(ms$ambexp == 0), "\n")
print(ggplot(ms, aes(ambexp)) + geom_histogram(bins = 50))

X2 <- model.matrix(reformulate(vars2), ms)
tob2 <- tobit_ml(ms$ambexp, X2, L = 0)
cat("\nTobit ambexp (ll(0)): censuradas =", tob2$n_cens_izq,
    " no censuradas =", tob2$n_no_cens, " logLik =", tob2$logLik, "\n")
print(round(cbind(coef = tob2$theta, ee = sqrt(diag(tob2$V)),
                  z = tob2$theta / sqrt(diag(tob2$V))), 4))

## INCISO (b)

cat("\nAverage marginal effects - ystar(0,.)\n"); print(round(me_tobit(tob2, X2, "ystar"), 5))
cat("\nAverage marginal effects - e(0,.)\n");     print(round(me_tobit(tob2, X2, "e"), 5))
X2m <- rbind(colMeans(X2))
cat("\nMarginal effects at means - ystar(0,.)\n"); print(round(me_tobit(tob2, X2m, "ystar"), 5))
cat("\nMarginal effects at means - e(0,.)\n");     print(round(me_tobit(tob2, X2m, "e"), 5))

## INCISO (c)  (con escalares y matrices, como en el do-file)

betas_tobit <- tob2$theta                       # (b0..b6, sigma)
k <- length(vars2)                              # e(df_m)
sigma <- betas_tobit[k + 2]
betas_coef <- betas_tobit[1:(k + 1)]
mean_xb <- mean(tob2$xb)                        # predict xb, xb; summarize xb
phi <- pnorm(mean_xb / sigma)
em <- phi * betas_coef
cat("\nEfectos marginales (Phi(mean(xb)/sigma) * beta)\n"); print(em)

## INCISO (d)

gamma <- min(ms$lambexp, na.rm = TRUE)
ms$lambexp[is.na(ms$lambexp)] <- gamma - 0.0000001
cat("\nmin(lambexp) =", gamma, "\n")

est_ols_l <- lm(reformulate(vars2, "lambexp"), ms)
tob_l <- tobit_ml(ms$lambexp, X2, L = -0.0000001)
cat("Observaciones censuradas:", tob_l$n_cens_izq, "\n")
tabla_modelos(list(`OLS (log)` = est_ols_l, `Tobit (log)` = tob_l))


################################################################################
# EJERCICIO 3
################################################################################

mroz <- zap_labels(as.data.frame(read_dta("mroz.dta")))
str(mroz)
vars3 <- c("kidslt6", "kidsge6", "age", "educ", "exper", "nwifeinc", "expersq")

print(summary(mroz$hours))
resumen_detalle(mroz$hours)
print(ggplot(mroz, aes(hours)) + geom_histogram(bins = 50))

ols3 <- lm(reformulate(vars3, "hours"), mroz)
X3 <- model.matrix(reformulate(vars3), mroz)
tob3 <- tobit_ml(mroz$hours, X3, L = 0)
cat("\nObservaciones censuradas (hours = 0):", tob3$n_cens_izq, "\n")
tabla_modelos(list(OLS = ols3, Tobit = tob3))

cat("\nAverage marginal effects - ystar(0,.)\n"); print(round(me_tobit(tob3, X3, "ystar"), 5))
cat("\nAverage marginal effects - e(0,.)\n");     print(round(me_tobit(tob3, X3, "e"), 5))
X3m <- rbind(colMeans(X3))
cat("\nMarginal effects at means - ystar(0,.)\n"); print(round(me_tobit(tob3, X3m, "ystar"), 5))
cat("\nMarginal effects at means - e(0,.)\n");     print(round(me_tobit(tob3, X3m, "e"), 5))
