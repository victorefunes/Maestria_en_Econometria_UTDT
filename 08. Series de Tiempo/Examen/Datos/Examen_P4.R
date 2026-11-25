# Examen Final - Punto 4: factor comun (filtro de Kalman) de los retornos en exceso
# y poder explicativo de la pendiente y la curvatura
suppressPackageStartupMessages({library(KFAS); library(sandwich); library(lmtest)})
setwd("d:/Box/Maestria_en_Econometria_UTDT/08. Series de Tiempo/Examen/Datos")
a <- read.csv("annlee.csv")
rets <- c("EX3MHOLD12", "EX3MHOLD24", "EX3MHOLD60", "EX3MHOLD120")
cat("Muestra:", a$obs[1], "a", a$obs[nrow(a)], "| T =", nrow(a), "\n")
cat("Primer dato de retornos:", a$obs[which(complete.cases(a[, rets]))[1]], "\n")
cat("Observaciones faltantes por serie:", colSums(is.na(a[, rets])), "\n")

Yraw <- as.matrix(a[, rets])
mu <- colMeans(Yraw, na.rm = TRUE); sdv <- apply(Yraw, 2, sd, na.rm = TRUE)
Y <- sweep(sweep(Yraw, 2, mu), 2, sdv, "/")                      # series estandarizadas
colnames(Y) <- rets

# --- (a) Modelo de factor dinamico: y_it = lambda_i f_t + e_it ; f_t = phi f_{t-1} + eta_t ---
#     Var(eta) = 1 (normalizacion). Estimacion de lambda, phi y Var(e_i) por maxima
#     verosimilitud con el filtro de Kalman (los NA se manejan automaticamente).
mod <- SSModel(Y ~ -1 + SSMcustom(Z = matrix(1, 4, 1), T = matrix(0.9), R = matrix(1),
                                  Q = matrix(1), a1 = matrix(0), P1 = matrix(1 / (1 - 0.81)),
                                  n = nrow(Y)),
               H = diag(NA_real_, 4))
upd <- function(p, model) {
  model$Z[, , 1] <- matrix(p[1:4], 4, 1)
  model$T[, , 1] <- tanh(p[5])                                   # |phi| < 1
  model$P1[, ] <- 1 / (1 - tanh(p[5])^2)
  model$H[, , 1] <- diag(exp(p[6:9]), 4)
  model
}
fit <- fitSSM(mod, inits = c(rep(0.7, 4), atanh(0.9), rep(log(0.3), 4)), updatefn = upd, method = "BFGS")
p <- fit$optim.out$par
lambda <- p[1:4]; phi <- tanh(p[5]); H <- exp(p[6:9])
sgn <- if (mean(lambda) < 0) -1 else 1                           # signo: carga media positiva
lambda <- sgn * lambda
cat("\n==== (a) Estimaciones del factor comun ====\n")
cat("logLik:", round(logLik(fit$model), 2), "| convergencia:", fit$optim.out$convergence, "\n")
est <- data.frame(serie = rets, carga = round(lambda, 3), var_idiosinc = round(H, 3),
                  porc_var_comun = round(100 * lambda^2 / (1 - phi^2) / (lambda^2 / (1 - phi^2) + H), 1))
print(est, row.names = FALSE)
cat("phi (persistencia del factor):", round(phi, 3), "\n")

sm <- KFS(fit$model, smoothing = "state")
f  <- sgn * as.numeric(sm$alphahat)                              # factor suavizado
cat("Correlaciones factor vs. cada retorno (obs. disponibles):\n")
print(round(sapply(rets, function(r) cor(f, Yraw[, r], use = "complete.obs")), 3))
cat("Correlacion con el promedio de los 4 retornos estandarizados:",
    round(cor(f, rowMeans(Y, na.rm = TRUE), use = "complete.obs"), 3), "\n")
write.csv(data.frame(obs = a$obs, factor = f), "factor_comun.csv", row.names = FALSE)

# --- (b) Poder explicativo de la pendiente y la curvatura sobre el factor y los retornos --------
cat("\n==== (b) Factor ~ pendiente + curvatura ====\n")
D <- data.frame(f = f, pend = a$SLOPE, curv = a$CURVATURE)
D$pend_L1 <- c(NA, D$pend[-nrow(D)]); D$curv_L1 <- c(NA, D$curv[-nrow(D)])
ok <- complete.cases(Y)
Dm <- D[ok, ]
hac <- function(m) coeftest(m, vcov = NeweyWest(m, lag = 12, prewhite = FALSE))
m0 <- lm(f ~ pend + curv, Dm)
cat("\nContemporaneo, errores Newey-West (12 rezagos):\n"); print(hac(m0))
cat("R2:", round(summary(m0)$r.squared, 4), "\n")
m1 <- lm(f ~ pend_L1 + curv_L1, Dm[-1, ])
cat("\nRezagado un mes (predictivo), Newey-West:\n"); print(hac(m1))
cat("R2:", round(summary(m1)$r.squared, 4), "\n")
cat("Test conjunto pend_L1 = curv_L1 = 0 (Wald, Newey-West):\n")
print(waldtest(m1, . ~ 1, vcov = NeweyWest(m1, lag = 12, prewhite = FALSE), test = "Chisq"))

cat("\nRetornos individuales ~ pendiente + curvatura rezagadas (R2 y significancia conjunta):\n")
for (r in rets) {
  d <- data.frame(y = Yraw[, r], pend_L1 = D$pend_L1, curv_L1 = D$curv_L1)[ok, ][-1, ]
  mm <- lm(y ~ pend_L1 + curv_L1, d)
  w <- waldtest(mm, . ~ 1, vcov = NeweyWest(mm, lag = 12, prewhite = FALSE), test = "Chisq")
  cat(sprintf("%-12s b_pend = %6.3f  b_curv = %6.3f  R2 = %.4f  Wald p = %.4f\n", r,
              coef(mm)[2], coef(mm)[3], summary(mm)$r.squared, w$`Pr(>Chisq)`[2]))
}
