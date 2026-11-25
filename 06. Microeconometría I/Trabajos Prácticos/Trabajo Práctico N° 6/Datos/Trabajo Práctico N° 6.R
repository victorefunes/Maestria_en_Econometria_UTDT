################################################################################
# Trabajo Práctico N° 6 - Microeconometría I
# Traducción a R del do-file de Stata (modelo de Heckman)
################################################################################

rm(list = ls())

paquetes <- c("haven", "sampleSelection", "ggplot2")
faltan <- paquetes[!sapply(paquetes, requireNamespace, quietly = TRUE)]
if (length(faltan) > 0) install.packages(faltan)
invisible(lapply(paquetes, library, character.only = TRUE))

# Directorio de trabajo: carpeta donde están los datos
if (requireNamespace("rstudioapi", quietly = TRUE) &&
    rstudioapi::isAvailable()) {
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}
setwd("D:/Box/Maestria_en_Econometria_UTDT/06. Microeconometría I/Trabajos Prácticos/Trabajo Práctico N° 6/Datos")

# ------------------------------------------------------------------------------
# Tobit por maxima verosimilitud (equivalente a tobit de Stata), igual que en
# el Trabajo Práctico N° 5. Censuradas: y <= L  /  y >= U.
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
  s <- exp(opt$par[K + 1])
  V <- diag(c(rep(1, K), s)) %*% solve(opt$hessian) %*% diag(c(rep(1, K), s))
  th <- c(opt$par[1:K], s)
  nm <- c(colnames(X), "sigma")
  names(th) <- nm; dimnames(V) <- list(nm, nm)
  list(theta = th, V = V, K = K, L = L, U = U, N = length(y),
       n_cens_izq = sum(cL), logLik = -opt$value)
}

# Valores esperados del Tobit/Heckman en funcion del indice xb (ver TP5)
E_censurada <- function(xb, s, L, U) {          # ystar(L,U)
  a <- (L - xb) / s; b <- (U - xb) / s
  pL <- if (is.finite(L)) L * pnorm(a) else 0
  pU <- if (is.finite(U)) U * pnorm(b, lower.tail = FALSE) else 0
  pL + pU + xb * (pnorm(b) - pnorm(a)) + s * (dnorm(a) - dnorm(b))
}
E_truncada <- function(xb, s, L, U) {           # e(L,U)
  a <- (L - xb) / s; b <- (U - xb) / s
  xb + s * (dnorm(a) - dnorm(b)) / (pnorm(b) - pnorm(a))
}

# ------------------------------------------------------------------------------
# Tablas comparativas (equivalente a esttab, se star)
# ------------------------------------------------------------------------------
estrellas <- function(p) ifelse(is.na(p), "", ifelse(p < .01, "***",
                         ifelse(p < .05, "**", ifelse(p < .10, "*", ""))))

# Cada modelo se pasa a data.frame(termino, est, ee, p) y una lista de estadisticos
tidy_selection <- function(m) {
  s <- summary(m)$estimate; ix <- m$param$index
  nom <- rownames(s)
  term <- character(nrow(s))
  term[ix$betaS] <- paste0("Seleccion: ", nom[ix$betaS])
  term[ix$betaO] <- paste0("Resultado: ", nom[ix$betaO])
  if (!is.null(ix$Mills)) term[ix$Mills] <- "lambda (Mills)"
  if (!is.null(ix$sigma)) {                        # dos etapas
    term[ix$sigma] <- "sigma"; term[ix$rho] <- "rho"
  } else {                                         # maxima verosimilitud
    term[ix$errTerms] <- names(ix$errTerms)
  }
  list(d = data.frame(term, est = s[, 1], ee = s[, 2], p = s[, 4]),
       st = c(N = nobs(m)))
}
tidy_lm <- function(m) {
  s <- summary(m)$coefficients
  list(d = data.frame(term = paste0("Resultado: ", rownames(s)),
                      est = s[, 1], ee = s[, 2], p = s[, 4]),
       st = c(N = nobs(m), R2 = summary(m)$r.squared))
}
tidy_tobit <- function(r) {
  ee <- sqrt(diag(r$V)); z <- r$theta / ee
  list(d = data.frame(term = ifelse(names(r$theta) == "sigma", "sigma",
                                    paste0("Resultado: ", names(r$theta))),
                      est = r$theta, ee = ee, p = 2 * pnorm(-abs(z))),
       st = c(N = r$N, logLik = r$logLik))
}
tabla_modelos <- function(modelos) {
  terms <- unique(unlist(lapply(modelos, function(m) m$d$term)))
  out <- do.call(cbind, lapply(modelos, function(m) {
    v <- character(2 * length(terms))
    for (i in seq_along(terms)) {
      j <- match(terms[i], m$d$term)
      if (!is.na(j)) {
        v[2 * i - 1] <- sprintf("%.4f%s", m$d$est[j], estrellas(m$d$p[j]))
        if (!is.na(m$d$ee[j])) v[2 * i] <- sprintf("(%.4f)", m$d$ee[j])
      }
    }
    v
  }))
  rownames(out) <- as.vector(rbind(terms, ""))
  colnames(out) <- names(modelos)
  stats <- do.call(cbind, lapply(modelos, function(m)
    c(N = unname(m$st["N"]), R2 = if ("R2" %in% names(m$st)) unname(m$st["R2"]) else NA)))
  print(noquote(rbind(out, round(stats, 4))))
}

resumen_detalle <- function(x) {
  x <- x[!is.na(x)]
  print(round(c(N = length(x), media = mean(x), sd = sd(x), min = min(x),
                quantile(x, c(.01, .05, .10, .25, .50, .75, .90, .95, .99)),
                max = max(x)), 4))
}
mdesc <- function(d) print(data.frame(faltantes = colSums(is.na(d)),
                                      porcentaje = round(colMeans(is.na(d)) * 100, 2)))


################################################################################
# EJERCICIO 1
################################################################################

ms <- zap_labels(as.data.frame(read_dta("mus16datav2.dta")))
str(ms)

print(ms[duplicated(ms) | duplicated(ms, fromLast = TRUE), ])   # duplicates list
mdesc(ms)

vars1 <- c("age", "female", "educ", "blhisp", "totchr", "ins")
f_sel1 <- reformulate(c(vars1, "income"), response = "dambexp")
f_out1 <- reformulate(vars1, response = "lambexp")

# heckman ... (MLE) y heckman ..., twostep
heck1_ml <- selection(f_sel1, f_out1, data = ms, method = "ml")
heck1_2s <- selection(f_sel1, f_out1, data = ms, method = "2step")
print(summary(heck1_ml)); print(summary(heck1_2s))

# tobit lambexp, ll(0): lambexp esta missing cuando ambexp == 0 (esas
# observaciones se descartan), y se censura en y <= 0
ms_t <- ms[!is.na(ms$lambexp), ]
X1 <- model.matrix(reformulate(vars1), ms_t)
tob1 <- tobit_ml(ms_t$lambexp, X1, L = 0)
cat("\nTobit lambexp ll(0): censuradas =", tob1$n_cens_izq, " N =", tob1$N, "\n")

tabla_modelos(list(`Heckman (MLE)` = tidy_selection(heck1_ml),
                   `Heckman (Two Step)` = tidy_selection(heck1_2s),
                   Tobit = tidy_tobit(tob1)))


################################################################################
# EJERCICIO 2
################################################################################

# webuse womenwk (base publica de Stata). Sin conexion: colocar womenwk.dta en
# la carpeta de datos.
wk <- tryCatch(zap_labels(as.data.frame(read_dta("https://www.stata-press.com/data/r17/womenwk.dta"))),
               error = function(e) zap_labels(as.data.frame(read_dta("womenwk.dta"))))
str(wk)

print(wk[duplicated(wk) | duplicated(wk, fromLast = TRUE), ])
mdesc(wk)
print(summary(wk))
print(summary(wk$wage))
resumen_detalle(wk$wage)
print(ggplot(wk, aes(wage)) + geom_histogram(bins = 40, na.rm = TRUE))

wk$wage[is.na(wk$wage)] <- 0                    # replace wage=0 if wage==.
wk$dwage <- as.numeric(wk$wage > 0)

vars2 <- c("age", "education", "married")
ols2 <- lm(reformulate(vars2, "wage"), wk)      # (incluye los ceros)

f_sel2 <- reformulate(c(vars2, "children"), response = "dwage")
f_out2 <- reformulate(vars2, response = "wage")
heck2_ml <- selection(f_sel2, f_out2, data = wk, method = "ml")
heck2_2s <- selection(f_sel2, f_out2, data = wk, method = "2step")
print(summary(heck2_ml)); print(summary(heck2_2s))

tabla_modelos(list(OLS = tidy_lm(ols2),
                   `Heckman (MLE)` = tidy_selection(heck2_ml),
                   `Heckman (Two Step)` = tidy_selection(heck2_2s)))


################################################################################
# EJERCICIO 3
################################################################################

mroz <- zap_labels(as.data.frame(read_dta("mroz.dta")))
str(mroz)

vars3 <- c("kidsge6", "age", "educ", "exper", "nwifeinc", "expersq")

print(summary(mroz$hours))
resumen_detalle(mroz$hours)
print(ggplot(mroz, aes(hours)) + geom_histogram(bins = 50))

mroz$dhours <- as.numeric(mroz$hours > 0)

ols3 <- lm(reformulate(vars3, "hours"), mroz)

# heckman hours ..., select(dhours = ... kidslt6) twostep
f_sel3 <- reformulate(c(vars3, "kidslt6"), response = "dhours")
f_out3 <- reformulate(vars3, response = "hours")
heck3 <- selection(f_sel3, f_out3, data = mroz, method = "2step")
print(summary(heck3))
tabla_modelos(list(OLS = tidy_lm(ols3), `Heckman (Two Step)` = tidy_selection(heck3)))

# ------------------------------------------------------------------------------
# Dos etapas "a mano": probit de seleccion + MCO aumentado con la inversa del
# ratio de Mills (lo que pide la consigna), con errores estandar por bootstrap
# ------------------------------------------------------------------------------
dos_etapas <- function(d) {
  pr <- glm(f_sel3, data = d, family = binomial("probit"))
  zg <- predict(pr)                              # indice de seleccion z'gamma
  d$lambda <- dnorm(zg) / pnorm(zg)              # inversa del ratio de Mills
  sel <- d$dhours == 1
  f_aum <- reformulate(c(vars3, "lambda"), response = "hours")
  ols <- lm(f_aum, data = d[sel, ])
  th <- coef(ols)["lambda"]                      # theta = rho * sigma
  delta <- (d$lambda * (d$lambda + zg))[sel]
  s2 <- sum(residuals(ols)^2) / sum(sel) + th^2 * mean(delta)
  list(gamma = coef(pr), beta = coef(ols)[c("(Intercept)", vars3)],
       theta = unname(th), sigma = unname(sqrt(s2)), ols = ols, probit = pr)
}

# Efectos marginales sobre las horas, promedio muestral (AME) y en las medias.
#   lit_ystar / lit_e : lo que calcula el do-file con margins tras heckman
#                       (predict(ystar(0,.)) / predict(e(0,.)): usan solo xb y
#                        sigma de la ecuacion de resultado, ignorando la seleccion)
#   cond   : d E[hours | hours > 0, x] / dx  = beta_k + theta*d lambda(z'g)/dx
#   incond : d E[hours | x] / dx             = d { Phi(z'g) * E[hours | hours>0, x] } / dx
me_heckman <- function(fit, d) {
  Xo <- model.matrix(reformulate(vars3), d)                 # (Intercept) + vars3
  Z  <- model.matrix(reformulate(c(vars3, "kidslt6")), d)   # (Intercept) + vars3 + kidslt6
  b <- fit$beta; g <- fit$gamma; th <- fit$theta; s <- fit$sigma
  nombres <- c(vars3, "kidslt6")
  h <- 1e-5

  evalua <- function(Xo, Z) {
    zg <- as.vector(Z %*% g); xb <- as.vector(Xo %*% b)
    lam <- dnorm(zg) / pnorm(zg)
    cond <- xb + th * lam
    cbind(lit_ystar = E_censurada(xb, s, 0, Inf),
          lit_e     = E_truncada(xb, s, 0, Inf),
          cond      = cond,
          incond    = pnorm(zg) * cond)
  }
  mover <- function(M, v, delta) {
    if (v %in% colnames(M)) M[, v] <- M[, v] + delta
    M
  }
  derivadas <- function(Xo, Z) {                 # promedio de dE/dx por variable
    t(sapply(nombres, function(v) {
      d1 <- evalua(mover(Xo, v, h), mover(Z, v, h))
      d0 <- evalua(mover(Xo, v, -h), mover(Z, v, -h))
      colMeans((d1 - d0) / (2 * h))
    }))
  }
  list(ame = derivadas(Xo, Z),
       medias = derivadas(rbind(colMeans(Xo)), rbind(colMeans(Z))))
}

fit3 <- dos_etapas(mroz)
cat("\nDos etapas manual: theta =", fit3$theta, " sigma =", fit3$sigma,
    " rho =", fit3$theta / fit3$sigma, "\n")
cat("Coeficientes (resultado) manual vs heckman twostep:\n")
print(round(cbind(manual = fit3$beta,
                  heckman = coef(heck3, part = "outcome")[1:7]), 4))

est3 <- me_heckman(fit3, mroz)

# Bootstrap de los efectos marginales
set.seed(12345)
B <- 500
boot <- replicate(B, {
  r <- tryCatch(me_heckman(dos_etapas(mroz[sample(nrow(mroz), replace = TRUE), ]), mroz),
                error = function(e) NULL)
  if (is.null(r)) rep(NA_real_, 2 * 7 * 4) else c(r$ame, r$medias)
})
sd_boot <- apply(boot, 1, sd, na.rm = TRUE)
nm <- rownames(est3$ame); col <- colnames(est3$ame)
ee_ame    <- matrix(sd_boot[1:(7 * 4)], 7, 4, dimnames = list(nm, col))
ee_medias <- matrix(sd_boot[(7 * 4 + 1):(2 * 7 * 4)], 7, 4, dimnames = list(nm, col))

reportar <- function(est, ee, titulo) {
  cat("\n", titulo, "\n", sep = "")
  print(round(data.frame(dydx = est, ee_bootstrap = ee), 5))
}
reportar(est3$ame[, "lit_ystar"], ee_ame[, "lit_ystar"], "AME - predict(ystar(0,.)) [como en el do-file]")
reportar(est3$ame[, "lit_e"],     ee_ame[, "lit_e"],     "AME - predict(e(0,.)) [como en el do-file]")
reportar(est3$medias[, "lit_ystar"], ee_medias[, "lit_ystar"], "En las medias - predict(ystar(0,.))")
reportar(est3$medias[, "lit_e"],     ee_medias[, "lit_e"],     "En las medias - predict(e(0,.))")
reportar(est3$ame[, "cond"],   ee_ame[, "cond"],   "AME correcto sobre E[hours | hours > 0]  (incluye el ratio de Mills)")
reportar(est3$ame[, "incond"], ee_ame[, "incond"], "AME correcto sobre E[hours]  (incluye probabilidad de participar)")
reportar(est3$medias[, "cond"],   ee_medias[, "cond"],   "En las medias, correcto sobre E[hours | hours > 0]")
reportar(est3$medias[, "incond"], ee_medias[, "incond"], "En las medias, correcto sobre E[hours]")
