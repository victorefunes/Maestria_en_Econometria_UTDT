# Trabajo Final - Econometría (UTDT)
# Traducción a R de "Trabajo Final.do"
#
# Notas:
# - Las matrices n x n del .do (omega, P, P^-1, matriz de White) son diagonales,
#   por lo que acá se usan operaciones vectorizadas equivalentes (mucho más rápido).
# - Las secuencias de números aleatorios de R y Stata son distintas: los resultados
#   replican el diseño, pero no coinciden dígito a dígito con los de Stata.
# - `test x=b` de Stata tras `regress` es un test F con 1 gl en el numerador, que
#   equivale al test t bilateral con n-k grados de libertad (lo que se usa acá).

rm(list = ls())

# Directorio de trabajo (alternar según la máquina)
disco <- "D:/"
# disco <- "G:/Mi unidad"
setwd(file.path(disco, "Box/Maestria_en_Econometria_UTDT/05. Econometría/Trabajo Final/Datos"))

sink("Trabajo Final.log", split = TRUE)

seed <- 2205


# Auxiliares --------------------------------------------------------------

# MCO: devuelve coeficientes, residuos y matriz de varianzas clásica
ols <- function(y, X) {
  XtX_inv <- solve(crossprod(X))
  b   <- as.vector(XtX_inv %*% crossprod(X, y))
  res <- as.vector(y - X %*% b)
  s2  <- sum(res^2) / (length(y) - ncol(X))
  list(b = b, res = res, V = s2 * XtX_inv, df = length(y) - ncol(X))
}

# p-valor del test de H0: b[j] = valor (equivalente a `test` de Stata)
pval <- function(fit, j, valor) {
  t <- (fit$b[j] - valor) / sqrt(fit$V[j, j])
  2 * pt(-abs(t), fit$df)
}


#############################################################################
##################### 1. INFERENCIA EN EL MODELO DE REGRESIÓN LINEAL ########
#############################################################################

alpha <- 3
beta  <- 1
reps  <- 2000

# PROGRAMA: una réplica de Monte Carlo; devuelve el p-valor de H0: beta = 1
mcc <- function(n, model) {
  x <- rnorm(n, 2, 1)
  u <- switch(model,
    runif(n, -6, 6),                              # 1
    sqrt(2542 / 5) * (rbeta(n, 2, 5) - 2 / 7),    # 2
    rt(n, 2.1818),                                # 3
    sqrt(75) * (rbinom(n, 1, 0.8) - 0.8),         # 4
    rnorm(n, 0, sqrt(12)),                        # 5
    rnorm(n, 0, sqrt(12))                         # 6 (con outlier)
  )
  if (model == 6) u[1] <- 500
  y <- alpha + beta * x + u

  # Regresión simple y ~ x con constante (forma cerrada)
  xc  <- x - mean(x)
  sxx <- sum(xc^2)
  b   <- sum(xc * y) / sxx
  res <- y - mean(y) - b * xc
  se  <- sqrt(sum(res^2) / (n - 2) / sxx)
  2 * pt(-abs((b - beta) / se), n - 2)
}

# SIMULACIONES
samples <- c(10, 20, 100, 200, 500, 1000, 5000, 10000)

mcc_mat <- matrix(NA_real_, 6, length(samples),
                  dimnames = list(paste0("model_", 1:6), paste0("n_", samples)))
mcc_base <- list()   # p-valores de todas las simulaciones

for (model in 1:6) {
  for (j in seq_along(samples)) {
    n <- samples[j]
    cat("Simulación mediante estimación por MCC de modelo (1)", model,
        "con tamaño de muestra n =", n, "\n")

    set.seed(seed)
    p <- replicate(reps, mcc(n, model))
    mcc_base[[sprintf("pvalue_model%d_n%d", model, n)]] <- p

    mcc_mat[model, j] <- mean(p < 0.05) * 100
  }
}

# RESULTADOS FINALES
print(mcc_mat)
mcc_t <- data.frame(n = samples, t(mcc_mat))

matplot(samples, t(mcc_mat), type = "l", lty = 1, col = 1:6,
        xlab = "Tamaño de muestra (n)", ylab = "")
abline(h = 5, col = "black")
legend("topright", legend = paste("Modelo", 1:6), col = 1:6, lty = 1)

write.csv(as.data.frame(mcc_base), "mcc_base.csv", row.names = FALSE)
write.csv(mcc_t, "mcc_matriz.csv", row.names = FALSE)


#############################################################################
################### 2. PROPIEDADES DE MUESTRA FINITA DE FGLS ################
#############################################################################

beta0 <- -3
beta1 <- 0.8
reps  <- 5000
omega <- diag(c(4, 9, 16, 25, 36))

# PROGRAMA: una réplica; devuelve resultados de FGLS (y de GLS si n = 5)
fgls_gls <- function(n) {
  n1 <- n / 5
  x  <- runif(n, 1, 50)
  u  <- rnorm(n) * rep(sqrt(diag(omega)), each = n1)
  y  <- beta0 + beta1 * x + u
  X  <- cbind(x = x, c = 1)

  # FGLS: omega estimada = diag(residuos MCO^2) => P^-1 = diag(1 / |r|)
  r   <- ols(y, X)$res
  w   <- 1 / sqrt(r^2)
  fit <- ols(w * y, w * X)           # coeficientes: [1] = x, [2] = constante
  out <- c(p08_fgls = pval(fit, 1, beta1),
           p00_fgls = pval(fit, 1, 0),
           p04_fgls = pval(fit, 1, 0.4),
           b0_fgls  = fit$b[2],
           b1_fgls  = fit$b[1])

  # GLS: omega conocida => P^-1 = diag(1 / sd)
  if (n == 5) {
    w   <- 1 / sqrt(diag(omega))
    fit <- ols(w * y, w * X)
    out <- c(out,
             p08_gls = pval(fit, 1, beta1),
             p00_gls = pval(fit, 1, 0),
             p04_gls = pval(fit, 1, 0.4),
             b0_gls  = fit$b[2],
             b1_gls  = fit$b[1])
  }
  unname(out)
}

# SIMULACIONES
samples <- c(5, 10, 30, 100, 200, 500)
nms <- c("p08_fgls", "p00_fgls", "p04_fgls", "b0_fgls", "b1_fgls",
         "p08_gls", "p00_gls", "p04_gls", "b0_gls", "b1_gls")

fgls_mat <- matrix(NA_real_, 10, length(samples) + 1,
                   dimnames = list(
                     c("tam_test_1", "tam_test_5", "poder_test_b1_00", "poder_test_b1_04",
                       "media_b0", "mediana_b0", "de_b0", "media_b1", "mediana_b1", "de_b1"),
                     c("5N_5_fgls", "5N_5_gls", paste0("5N_", samples[-1], "_fgls"))))

# Resume los resultados (p-valores y estimaciones) de FGLS o GLS en una columna
resumir <- function(sim, sufijo) {
  p08 <- sim[, paste0("p08_", sufijo)]
  p00 <- sim[, paste0("p00_", sufijo)]
  p04 <- sim[, paste0("p04_", sufijo)]
  b0  <- sim[, paste0("b0_",  sufijo)]
  b1  <- sim[, paste0("b1_",  sufijo)]
  c(mean(p08 < 0.01) * 100, mean(p08 < 0.05) * 100,
    mean(p00 < 0.05) * 100, mean(p04 < 0.05) * 100,
    mean(b0), median(b0), sd(b0),
    mean(b1), median(b1), sd(b1))
}

fgls_base <- list()
i <- 1
for (n in samples) {
  cat("Simulación mediante estimación por FGLS-GLS de modelo (2) con tamaño de muestra 5N =", n, "\n")

  set.seed(seed)
  sim <- t(replicate(reps, fgls_gls(n)))
  colnames(sim) <- nms[seq_len(ncol(sim))]
  fgls_base[[paste0("n", n)]] <- sim

  fgls_mat[, i] <- resumir(sim, "fgls")
  if (n == 5) {
    i <- i + 1
    fgls_mat[, i] <- resumir(sim, "gls")
  }
  i <- i + 1
}

# RESULTADOS FINALES
print(fgls_mat)
fgls_t <- data.frame(n = c(5, 5, samples[-1]), t(fgls_mat))

write.csv(do.call(cbind, lapply(names(fgls_base), function(k) {
  m <- fgls_base[[k]]; colnames(m) <- paste0(colnames(m), "_", k); m
})), "fgls_gls_base.csv", row.names = FALSE)
write.csv(fgls_t, "fgls_gls_matriz.csv", row.names = FALSE)


#############################################################################
# 3. CORRECCIÓN DE LA MATRIZ DE VARIANZAS Y COVARIANZAS EN PRESENCIA DE
#    HETEROCEDASTICIDAD, WHITE (1980)
#############################################################################

b0 <- 1; b1 <- 1; b2 <- 1
reps <- 5000

# Varianza de White (HC0): (X'X)^-1 X' diag(w) X (X'X)^-1, con w = vector diagonal
white <- function(X, XtX_inv, w) XtX_inv %*% crossprod(X, X * w) %*% XtX_inv

# Sesgo relativo de la varianza clásica respecto de la de White, para (b0, b1, b2)
# Las columnas de X son (x1, x2, c): b1 = [1,1], b2 = [2,2], b0 = [3,3]
sesgo_rel <- function(var_est, var_white) {
  d <- (diag(var_est) - diag(var_white)) / diag(var_white)
  c(b0 = d[3], b1 = d[1], b2 = d[2])
}

# PROGRAMA: una réplica; devuelve 12 sesgos relativos
# (r2: d1, d2; e2: d1, d2) x (b0, b1, b2)
mcc_white <- function(n) {
  x1 <- as.vector(replicate(n / 20, c(-1, runif(18, -1, 1), 1)))
  x2 <- rnorm(n)
  u1 <- rnorm(n)
  u2 <- rt(n, 5)
  v  <- exp(0.25 * x1 + 0.25 * x2)
  e_d1 <- sqrt(v) * u1
  e_d2 <- sqrt(v) * u2
  y1 <- b0 + b1 * x1 + b2 * x2 + e_d1
  y2 <- b0 + b1 * x1 + b2 * x2 + e_d2

  X <- cbind(x1, x2, c = 1)
  XtX_inv <- solve(crossprod(X))

  fits <- lapply(list(y1, y2), function(y) ols(y, X))
  out <- NULL

  # MCC-White_r2: matriz de White con residuos MCO al cuadrado
  for (d in 1:2) {
    out <- c(out, sesgo_rel(fits[[d]]$V, white(X, XtX_inv, fits[[d]]$res^2)))
  }
  # MCC-White_e2: matriz de White con errores verdaderos al cuadrado
  for (d in 1:2) {
    e <- list(e_d1, e_d2)[[d]]
    out <- c(out, sesgo_rel(fits[[d]]$V, white(X, XtX_inv, e^2)))
  }
  unname(out)
}

# SIMULACIONES
samples <- c(20, 60, 100, 200, 400, 600)

filas <- as.vector(t(outer(
  c("r2_d1", "r2_d2", "e2_d1", "e2_d2"),
  c("b0", "b1", "b2", "tot"),
  function(a, b) paste0("sesgo_rel_", b, "_", a)
)))
white_mat <- matrix(NA_real_, 16, length(samples),
                    dimnames = list(filas, paste0("n_", samples)))

white_base <- list()
for (i in seq_along(samples)) {
  n <- samples[i]
  cat("Simulación mediante MCC-White de modelo (3) con tamaño de muestra n =", n, "\n")

  set.seed(seed)
  sim <- t(replicate(reps, mcc_white(n)))      # reps x 12
  white_base[[paste0("n", n)]] <- sim

  medias <- colMeans(sim)                        # 4 bloques de (b0, b1, b2)
  for (k in 0:3) {
    m <- medias[(3 * k + 1):(3 * k + 3)]
    white_mat[(4 * k + 1):(4 * k + 4), i] <- c(m, sum(abs(m)))
  }
}

# RESULTADOS FINALES
print(white_mat)
white_t <- data.frame(n = samples, t(white_mat))

matplot(samples, t(white_mat[c("sesgo_rel_tot_r2_d1", "sesgo_rel_tot_r2_d2",
                               "sesgo_rel_tot_e2_d1", "sesgo_rel_tot_e2_d2"), ]),
        type = "l", lty = 1, col = 1:4,
        xlab = "Tamaño de muestra (n)", ylab = "Sesgo relativo total")
legend("topright", col = 1:4, lty = 1,
       legend = c("Diseño 1 - White r2", "Diseño 2 - White r2",
                  "Diseño 1 - White e2", "Diseño 2 - White e2"))

write.csv(white_t, "mcc_white_matriz.csv", row.names = FALSE)

sink()
