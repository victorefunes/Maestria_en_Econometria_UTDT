# =============================================================================
# Funciones compartidas por los programas de Gibbs sampling (traduccion de GAUSS)
#   - gibbs_lm():  regresion lineal con errores N(0, sigma^2) (Albert y Chib, 1993)
#                  con opcion de rechazar draws no estacionarios (AR(p))
#   - gibbs_ms3(): modelo de 3 regimenes de varianza con cambio markoviano
#                  (Chang-Jin Kim)
#   - resumen_posterior(): media, desvio, mediana (y cuantiles) con thinning
#
# Los generadores a mano de GAUSS (rndc, rndb, rg1, rg2) se reemplazan por
# rchisq() y rbeta() de R. Mismas distribuciones, distinto flujo aleatorio.
# =============================================================================


# -----------------------------------------------------------------------------
# Regresion lineal bayesiana: Y = X beta + e, e ~ N(0, sig2)
# Prior: beta ~ N(beta0, R0), sig2 ~ inv-gamma (nu0, d0)
# Si estacionario = TRUE, X = [1, y_{t-1}, ..., y_{t-p}] y se rechazan los draws
# de beta cuyo polinomio AR tenga raices con modulo < 1.0001.
# Devuelve fnl_mat (filas = draws post burn-in; columnas = beta, sig2).
# -----------------------------------------------------------------------------
gibbs_lm <- function(Y, X, R0, beta0, nu0 = 0, d0 = 0, sig2 = 0.5,
                     N0 = 500, MM = 1500, estacionario = FALSE, verbose = TRUE) {
  Y <- as.matrix(Y); X <- as.matrix(X)
  k <- ncol(X); T <- nrow(Y)
  R0inv <- solve(R0)
  XtX <- crossprod(X); XtY <- crossprod(X, Y)
  beta0 <- matrix(beta0, ncol = 1)

  CAPN <- N0 + MM
  betamm <- matrix(NA_real_, nrow = MM, ncol = k)
  sig2mm <- numeric(MM)

  for (itr in seq_len(CAPN)) {
    if (verbose) cat(itr, "th iteration.....\n")

    # beta | sig2
    V     <- solve(R0inv + XtX / sig2)
    beta1 <- V %*% (R0inv %*% beta0 + XtY / sig2)
    C     <- chol(V)                       # triangular superior, V = C'C
    repeat {
      beta <- beta1 + t(C) %*% rnorm(k)
      if (!estacionario) break
      # GAUSS: polyroot(-rev(phi) | 1) -> en R los coeficientes van de menor a mayor
      raices <- polyroot(c(1, -beta[2:k]))
      if (min(Mod(raices)) >= 1.0001) break
    }

    # sig2 | beta
    nu1  <- T + nu0
    res  <- Y - X %*% beta
    d1   <- d0 + sum(res^2)
    sig2 <- d1 / rchisq(1, nu1)

    if (itr > N0) {
      betamm[itr - N0, ] <- beta
      sig2mm[itr - N0]   <- sig2
    }
  }
  cbind(betamm, sig2mm)
}


# -----------------------------------------------------------------------------
# Resumen posterior con thinning (se usa 1 de cada LL draws, empezando por el 1ro)
# Devuelve data.frame con media, desvio (n-1), mediana y, opcionalmente, cuantiles
# (cuantil = x_ordenado[ceiling(q * n)], igual que en GAUSS).
# -----------------------------------------------------------------------------
resumen_posterior <- function(fnl_mat, LL = 5, nombres = NULL, cuantiles = NULL) {
  idx <- seq(1, nrow(fnl_mat), by = LL)
  out <- t(apply(fnl_mat[idx, , drop = FALSE], 2, function(x) {
    xs <- sort(x)
    r  <- c(mean = mean(x), sd = sd(x), mediana = median(x))
    if (!is.null(cuantiles))
      r <- c(r, setNames(xs[ceiling(cuantiles * length(xs))], paste0("q", cuantiles)))
    r
  }))
  out <- as.data.frame(out)
  if (!is.null(nombres)) rownames(out) <- nombres
  out
}


# -----------------------------------------------------------------------------
# Graficos de traza + histograma (50 bins) para cada columna de fnl_mat
# -----------------------------------------------------------------------------
graficar_cadenas <- function(fnl_mat, nombres, archivo_pdf = NULL) {
  if (!is.null(archivo_pdf)) pdf(archivo_pdf, width = 9, height = 5)
  op <- par(mfrow = c(1, 2)); on.exit(par(op))
  for (j in seq_len(ncol(fnl_mat))) {
    plot(fnl_mat[, j], type = "l", main = paste(nombres[j], "- traza"),
         xlab = "iteracion", ylab = "")
    hist(fnl_mat[, j], breaks = 50, main = paste(nombres[j], "- posterior"),
         xlab = "", col = "grey80", border = "white")
  }
  if (!is.null(archivo_pdf)) dev.off()
  invisible(NULL)
}


# -----------------------------------------------------------------------------
# Modelo de 3 regimenes de varianza con cambio de regimen markoviano
#   y_t | s_t=i ~ N(0, sig_i), sig2 = sig1 (1+h2), sig3 = sig1 (1+h2)(1+h3)
# Estados: 1 = varianza baja, 2 = media, 3 = alta.
# P[a, b] = Pr(s_t = b | s_{t-1} = a)
# -----------------------------------------------------------------------------
gibbs_ms3 <- function(yy, N0 = 100, MM = 1000,
                      P_ini = c(p11 = 0.9, p12 = 0.05, p21 = 0.05, p22 = 0.9,
                                p31 = 0.1, p32 = 0.1),
                      sig1 = 0.001, h2 = 0.9, h3 = 2.5, mu = 0,
                      verbose = TRUE) {
  T <- length(yy)

  # Priors (todos 1 para transiciones; 0 para varianzas)
  U <- list(u1_1 = 1, u1_23 = 1, u1_2_23 = 1, u1_3_23 = 1,
            u2_13 = 1, u2_2 = 1, u2_1_13 = 1, u2_3_13 = 1,
            u3_3 = 1, u3_12 = 1, u3_2_12 = 1, u3_1_12 = 1)
  v1_ <- 0; v11_ <- 0; v2_ <- 0; v22_ <- 0; v3_ <- 0; v33_ <- 0

  P <- rbind(c(P_ini["p11"], P_ini["p12"], 1 - P_ini["p11"] - P_ini["p12"]),
             c(P_ini["p21"], P_ini["p22"], 1 - P_ini["p21"] - P_ini["p22"]),
             c(P_ini["p31"], P_ini["p32"], 1 - P_ini["p31"] - P_ini["p32"]))
  sig2 <- sig1 * (1 + h2)
  sig3 <- sig2 * (1 + h3)

  CAPN <- N0 + MM
  fnl_mat <- matrix(NA_real_, nrow = CAPN, ncol = 9,
                    dimnames = list(NULL, c("P1_1MM", "P1_2MM", "P2_1MM", "P2_2MM",
                                            "P3_1MM", "P3_2MM", "SIG1MM", "SIG2MM", "SIG3MM")))
  s1mm <- s2mm <- s3mm <- sigmamm <- stetmm <- numeric(T)

  for (itr in seq_len(CAPN)) {
    if (verbose) cat(itr - N0, "th iteration.......\n")

    # ---- estados (Carter y Kohn) -------------------------------------------
    s <- .gen_st(yy, P, c(sig1, sig2, sig3), mu)
    S1 <- as.numeric(s == 1); S2 <- as.numeric(s == 2); S3 <- as.numeric(s == 3)

    # ---- varianzas ---------------------------------------------------------
    # sig1
    e_mat <- (yy - mu) / sqrt(1 + S2 * h2) / sqrt((1 + S3 * h2) * (1 + S3 * h3))
    sig1  <- (v11_ + sum(e_mat^2)) / rchisq(1, length(e_mat) + v1_)
    # h2
    ehat <- (yy - mu) / sqrt(sig1) / sqrt(1 + S3 * h3)
    ehat <- ehat[(S2 + S3) != 0]
    h2   <- .gen_h(ehat, v2_, v22_, cota_sup = 4) - 1
    # h3
    ehat <- (yy - mu) / sqrt(sig1 * (1 + S3 * h2))
    ehat <- ehat[S3 != 0]
    h3   <- .gen_h(ehat, v3_, v33_, cota_sup = Inf) - 1

    sig2    <- sig1 * (1 + h2)
    sig3    <- sig1 * (1 + h2) * (1 + h3)
    sigmatt <- S1 * sig1 + S2 * sig2 + S3 * sig3

    # ---- probabilidades de transicion --------------------------------------
    tm <- matrix(0, 3, 3)
    for (t in 2:T) tm[s[t - 1], s[t]] <- tm[s[t - 1], s[t]] + 1

    p11 <- rbeta(1, tm[1, 1] + U$u1_1,   tm[1, 2] + tm[1, 3] + U$u1_23)
    p12 <- rbeta(1, tm[1, 2] + U$u1_2_23, tm[1, 3] + U$u1_3_23) * (1 - p11)
    p13 <- 1 - p11 - p12

    p22 <- rbeta(1, tm[2, 2] + U$u2_2,   tm[2, 1] + tm[2, 3] + U$u2_13)
    p21 <- rbeta(1, tm[2, 1] + U$u2_1_13, tm[2, 3] + U$u2_3_13) * (1 - p22)
    p23 <- 1 - p21 - p22

    p33 <- rbeta(1, tm[3, 3] + U$u3_3,   tm[3, 2] + tm[3, 1] + U$u3_12)
    p32 <- rbeta(1, tm[3, 2] + U$u3_2_12, tm[3, 1] + U$u3_1_12) * (1 - p33)
    p31 <- 1 - p32 - p33

    P <- rbind(c(p11, p12, p13), c(p21, p22, p23), c(p31, p32, p33))

    # ---- almacenamiento ----------------------------------------------------
    fnl_mat[itr, ] <- c(p11, p12, p21, p22, p31, p32, sig1, sig2, sig3)

    if (itr > N0) {
      s1mm <- s1mm + S1; s2mm <- s2mm + S2; s3mm <- s3mm + S3
      sigmamm <- sigmamm + sigmatt
      stetmm  <- stetmm + (yy - mu) / sqrt(sigmatt)
    }
  }

  list(fnl_mat = fnl_mat[(N0 + 1):CAPN, , drop = FALSE],
       s1 = s1mm / MM, s2 = s2mm / MM, s3 = s3mm / MM,
       sigma = sigmamm / MM, stdret = stetmm / MM)
}


# draw de (1 + h): inversa-gamma truncada (1, cota_sup); tras 100 intentos fallidos
# se fija en 1.01 (igual que GAUSS)
.gen_h <- function(ehat, v_, vv_, cota_sup) {
  nn <- length(ehat) + v_
  d  <- vv_ + sum(ehat^2)
  jj <- 1
  repeat {
    sigma2 <- d / rchisq(1, nn)
    if (sigma2 > 1 && sigma2 < cota_sup) break
    if (jj > 100) { sigma2 <- 1.01; break }
    jj <- jj + 1
  }
  sigma2
}


# Muestreo de los estados: filtro de Hamilton hacia adelante + muestreo hacia atras
.gen_st <- function(yy, P, sig, mu) {
  T <- length(yy)
  Q <- t(P)                                    # Q[i, j] = Pr(s_t = i | s_{t-1} = j)
  A <- rbind(diag(3) - Q, rep(1, 3))
  steady <- drop(solve(crossprod(A), crossprod(A, c(0, 0, 0, 1))))

  flt <- matrix(0, 3, T)
  for (t in seq_len(T)) {
    ev   <- yy[t] - mu
    dens <- exp(-0.5 * ev^2 / sig) / sqrt(2 * pi * sig)   # por estado actual i
    pr_vl <- dens * Q * matrix(steady, 3, 3, byrow = TRUE) # [i, j]
    pro   <- pr_vl / sum(pr_vl)
    steady <- rowSums(pro)
    flt[, t] <- steady
  }

  s <- integer(T)
  s[T] <- sample.int(3, 1, prob = flt[, T])
  for (t in (T - 1):1) {
    w <- P[, s[t + 1]] * flt[, t]              # Pr(s_t = a | s_{t+1}, I_t)
    s[t] <- sample.int(3, 1, prob = w)
  }
  s
}
