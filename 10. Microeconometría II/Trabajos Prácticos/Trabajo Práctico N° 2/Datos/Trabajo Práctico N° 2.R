rm(list = ls())

# setwd("C:/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Econometría/10. Microeconometría II/Trabajos Prácticos/Trabajo Práctico N° 2/Datos")
setwd("D:/Box/Maestria_en_Econometria_UTDT/10. Microeconometría II/Trabajos Prácticos/Trabajo Práctico N° 2/Datos")

# install.packages(c("haven", "MatchIt", "Matching"))
library(haven)
library(MatchIt)
library(Matching)

set.seed(12345)


################################################################################
#                      FUNCIONES AUXILIARES (equivalentes a ados de Stata)     #
################################################################################

# Tabla de balance: medias por grupo y test de diferencia de medias (varianzas desiguales)
balance <- function(d, vars, treat = "mbsmoke") {
  res <- t(sapply(vars, function(v) {
    x0 <- d[[v]][d[[treat]] == 0]
    x1 <- d[[v]][d[[treat]] == 1]
    tt <- t.test(x0, x1, var.equal = FALSE)
    c(media0 = mean(x0), media1 = mean(x1), dif = mean(x0) - mean(x1),
      t = unname(tt$statistic), p = tt$p.value)
  }))
  print(round(res, 4))
}

# psestimate (Imbens-Rubin): selección de términos lineales y cuadráticos del pscore
psestimate <- function(d, treat, totry, C_lin = 1, C_qua = 2.71) {
  D <- d[[treat]]
  loglik <- function(X) -suppressWarnings(glm.fit(X, D, family = binomial())$deviance) / 2

  forward <- function(X, cand, C) {
    chosen <- character(0)
    ll_cur <- loglik(X)
    repeat {
      rem <- setdiff(names(cand), chosen)
      if (length(rem) == 0) break
      stats <- sapply(rem, function(nm) {
        Xn <- cbind(X, cand[[nm]])
        if (qr(Xn)$rank <= ncol(X)) return(-Inf)
        2 * (loglik(Xn) - ll_cur)
      })
      if (max(stats) <= C) break
      best <- rem[which.max(stats)]
      X <- cbind(X, cand[[best]])
      ll_cur <- loglik(X)
      chosen <- c(chosen, best)
    }
    list(X = X, chosen = chosen)
  }

  X0 <- matrix(1, nrow(d), 1)
  lin <- forward(X0, setNames(lapply(totry, function(v) d[[v]]), totry), C_lin)

  cand_q <- list()
  sel <- lin$chosen
  for (i in seq_along(sel)) for (j in i:length(sel)) {
    if (length(sel) == 0) break
    cand_q[[paste0(sel[i], "*", sel[j])]] <- d[[sel[i]]] * d[[sel[j]]]
  }
  qua <- forward(lin$X, cand_q, C_qua)

  cat("Términos lineales seleccionados:", lin$chosen, "\n")
  cat("Términos cuadráticos seleccionados:", qua$chosen, "\n")

  fit <- suppressWarnings(glm.fit(qua$X, D, family = binomial()))
  list(X = qua$X, pscore = fit$fitted.values)
}

# optselect (Crump, Hotz, Imbens y Mitnik 2009): cota óptima de recorte del pscore
optselect <- function(ps) {
  g <- 1 / (ps * (1 - ps))
  if (max(g) <= 2 * mean(g)) {
    cat("No es necesario recortar la distribución del pscore\n")
    return(0)
  }
  a <- 0.0001
  for (i in 1:100) {
    gam <- mean(g[ps >= a & ps <= 1 - a])
    a_new <- 0.5 - sqrt(0.25 - 1 / (2 * gam))
    if (abs(a_new - a) < 1e-6) { a <- a_new; break }
    a <- a_new
    if (i == 100) { cat("No convergió; cota fijada en 0.10\n"); a <- 0.10 }
  }
  cat("Cota óptima =", a, "\n")
  a
}

# pscore (Becker-Ichino): estimación del pscore y algoritmo de bloques
pscore_blocks <- function(d, vars, treat = "mbsmoke", alpha = 0.005) {
  f <- reformulate(vars, response = treat)
  ps <- fitted(glm(f, data = d, family = binomial(link = "probit")))
  D <- d[[treat]]

  lo <- max(min(ps[D == 1]), min(ps[D == 0]))
  hi <- min(max(ps[D == 1]), max(ps[D == 0]))
  pending <- Map(c, seq(lo, hi, length.out = 6)[-6], seq(lo, hi, length.out = 6)[-1])
  final <- list()
  while (length(pending) > 0) {
    b <- pending[[1]]; pending <- pending[-1]
    inb <- ps >= b[1] & ps <= b[2]
    p1 <- ps[inb & D == 1]; p0 <- ps[inb & D == 0]
    split <- FALSE
    if (length(p1) > 1 && length(p0) > 1) {
      pv <- tryCatch(t.test(p1, p0)$p.value, error = function(e) 1)
      split <- !is.na(pv) && pv < alpha && (b[2] - b[1]) > 1e-4
    }
    if (split) {
      mid <- (b[1] + b[2]) / 2
      pending <- c(pending, list(c(b[1], mid), c(mid, b[2])))
    } else final <- c(final, list(b))
  }
  lower <- sort(sapply(final, `[`, 1))
  blockid <- findInterval(ps, lower)
  blockid[ps < lo | ps > hi] <- NA
  cat("Número de bloques:", length(lower), "\n")
  list(pscore = ps, blockid = blockid)
}

# Error estándar bootstrap de un estimador que depende de un vector de índices
boot_se <- function(est, n, reps = 10) sd(replicate(reps, est(sample(n, replace = TRUE))))

mostrar <- function(nombre, est, n, reps = 10) {
  cat(sprintf("%-32s ATT = %10.4f   (EE bootstrap, %d reps = %.4f)\n",
              nombre, est(seq_len(n)), reps, boot_se(est, n, reps)))
}


################################################################################
#                                EJERCICIO 3                                   #
################################################################################

dat <- as.data.frame(zap_labels(read_dta("cattaneo2.dta")))
str(dat)

vars <- c("mmarried", "alcohol", "deadkids", "nprenatal", "monthslb", "prenatal", "fbaby")

# INCISO (a)

for (g in 0:1) {
  cat("\nmbsmoke =", g, "\n")
  print(summary(dat[dat$mbsmoke == g, vars]))
}

# INCISO (b)

balance(dat, vars)

# INCISO (c)

ps_sel <- psestimate(dat, "mbsmoke", vars)

# Logit de mbsmoke sobre el índice lineal del pscore estimado
h <- as.vector(ps_sel$X %*% coef(glm.fit(ps_sel$X, dat$mbsmoke, family = binomial())))
dat$e_x <- fitted(glm(mbsmoke ~ h, data = dat, family = binomial()))

bound <- optselect(dat$e_x)
dat <- dat[dat$e_x >= bound & dat$e_x <= 1 - bound, ]

# psmatch2, noreplacement: vecino más cercano 1 a 1 sin reemplazo
m <- matchit(mbsmoke ~ e_x, data = dat, distance = dat$e_x,
             method = "nearest", replace = FALSE, m.order = "data")
dat <- match.data(m)
dat$e_x <- NULL

# OJO: en el .do, "pscore `vars'" toma la PRIMERA variable (mmarried) como
# tratamiento (probit de mmarried sobre el resto). Se replica tal cual.
pb <- pscore_blocks(dat, vars[-1], treat = vars[1])
dat$e_x <- pb$pscore
dat$blockid <- pb$blockid

for (g in 0:1) {
  cat("\nmbsmoke =", g, "\n")
  print(summary(dat[dat$mbsmoke == g, vars]))
}
balance(dat, vars)

# INCISO (d)

y <- dat$bweight
D <- dat$mbsmoke
ps <- dat$e_x
blk <- dat$blockid
n <- nrow(dat)

# attnd: vecino más cercano (con reemplazo)
att_nnd <- function(idx) {
  yy <- y[idx]; DD <- D[idx]; pp <- ps[idx]
  t <- which(DD == 1); c0 <- which(DD == 0)
  nn <- sapply(pp[t], function(p) c0[which.min(abs(pp[c0] - p))])
  mean(yy[t] - yy[nn])
}

# attr: radio (por defecto 0.1)
att_rad <- function(idx, radius = 0.1) {
  yy <- y[idx]; DD <- D[idx]; pp <- ps[idx]
  t <- which(DD == 1); c0 <- which(DD == 0)
  efectos <- sapply(t, function(i) {
    w <- c0[abs(pp[c0] - pp[i]) < radius]
    if (length(w) == 0) NA else yy[i] - mean(yy[w])
  })
  mean(efectos, na.rm = TRUE)
}

# attk: kernel normal, ancho de banda 0.06
att_ker <- function(idx, bw = 0.06) {
  yy <- y[idx]; DD <- D[idx]; pp <- ps[idx]
  t <- which(DD == 1); c0 <- which(DD == 0)
  efectos <- sapply(t, function(i) {
    w <- dnorm((pp[c0] - pp[i]) / bw)
    if (sum(w) == 0) NA else yy[i] - sum(w * yy[c0]) / sum(w)
  })
  mean(efectos, na.rm = TRUE)
}

# atts: estratificación por bloques
att_str <- function(idx) {
  yy <- y[idx]; DD <- D[idx]; bb <- blk[idx]
  bl <- sort(unique(bb[!is.na(bb)]))
  dif <- nt <- rep(NA_real_, length(bl))
  for (k in seq_along(bl)) {
    s <- !is.na(bb) & bb == bl[k]
    if (any(DD[s] == 1) && any(DD[s] == 0)) {
      dif[k] <- mean(yy[s & DD == 1]) - mean(yy[s & DD == 0])
      nt[k] <- sum(s & DD == 1)
    }
  }
  sum(dif * nt, na.rm = TRUE) / sum(nt, na.rm = TRUE)
}

cat("\nEstimaciones del ATT (Becker-Ichino)\n")
mostrar("attnd (vecino más cercano)", att_nnd, n)
mostrar("attr (radio 0.1)", att_rad, n)
mostrar("attk (kernel normal, bw 0.06)", att_ker, n)
mostrar("atts (estratificación)", att_str, n)

# INCISO (e)

nn <- Match(Y = y, Tr = D, X = ps, estimand = "ATE", M = 1,
            BiasAdjust = TRUE, Z = as.matrix(dat[, vars]))
summary(nn)

# INCISOS (f), (g), (h): regression adjustment, IPW y AIPW (ATE)

X <- cbind(1, as.matrix(dat[, vars]))
k <- ncol(X)

ols <- function(s) {
  b <- solve(crossprod(X[s, ]), crossprod(X[s, ], y[s]))
  drop(b)
}
b1 <- ols(D == 1); b0 <- ols(D == 0)
mu1 <- drop(X %*% b1); mu0 <- drop(X %*% b0)

gfit <- suppressWarnings(glm.fit(X, D, family = binomial()))
e <- gfit$fitted.values

reportar <- function(nombre, ate, se) {
  cat(sprintf("%-8s ATE = %10.4f   EE = %8.4f   z = %7.3f   IC95%% = [%.4f, %.4f]\n",
              nombre, ate, se, ate / se, ate - 1.96 * se, ate + 1.96 * se))
}

# INCISO (f): regression adjustment
ate_ra <- mean(mu1 - mu0)
xbar <- colMeans(X)
IFb1 <- (X * (D * (y - mu1))) %*% t(solve(crossprod(X[D == 1, ]) / n))
IFb0 <- (X * ((1 - D) * (y - mu0))) %*% t(solve(crossprod(X[D == 0, ]) / n))
psi <- (mu1 - mu0 - ate_ra) + drop(IFb1 %*% xbar) - drop(IFb0 %*% xbar)
cat("\n")
reportar("RA", ate_ra, sqrt(mean(psi^2) / n))

# INCISO (g): IPW (pesos normalizados, pscore logit estimado)
# OJO: en el .do, "teffects ipw (bweight) (`vars', logit)" toma la PRIMERA
# variable (mmarried) como tratamiento, con el resto como covariables.
# Se replica tal cual (el "ATE" es el efecto de estar casada).
Dg <- dat$mmarried
Xg <- X[, -2]  # constante + vars[-1]
eg <- suppressWarnings(glm.fit(Xg, Dg, family = binomial()))$fitted.values
w1 <- Dg / eg; w0 <- (1 - Dg) / (1 - eg)
m1 <- sum(w1 * y) / sum(w1)
m0 <- sum(w0 * y) / sum(w0)
H <- crossprod(Xg * eg * (1 - eg), Xg) / n
IFg <- (Xg * (Dg - eg)) %*% t(solve(H))
A1 <- colMeans(Xg * (-Dg * (y - m1) * (1 - eg) / eg))
A0 <- colMeans(Xg * ((1 - Dg) * (y - m0) * eg / (1 - eg)))
psi1 <- (w1 * (y - m1) + drop(IFg %*% A1)) / mean(w1)
psi0 <- (w0 * (y - m0) + drop(IFg %*% A0)) / mean(w0)
reportar("IPW", m1 - m0, sqrt(mean((psi1 - psi0)^2) / n))

# INCISO (h): AIPW (doblemente robusto)
psi_aipw <- mu1 - mu0 + D * (y - mu1) / e - (1 - D) * (y - mu0) / (1 - e)
ate_aipw <- mean(psi_aipw)
reportar("AIPW", ate_aipw, sqrt(mean((psi_aipw - ate_aipw)^2) / n))
