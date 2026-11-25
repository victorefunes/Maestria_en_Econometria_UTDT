# =============================================================================
# Trabajo Practico N1 - Problema 3: VAR con datos de EE.UU. (inflacion,
# desempleo, tasa de fondos federales), 1960Q1-2000Q4 (164 trimestres).
#
# DATOS: R no lee workfiles de EViews (.wf1). Abrir var.wf1 en EViews, abrir las
# tres series (inflacion, desempleo, tasa) como grupo y exportar a CSV
# (File > Save As > .csv), con una columna por serie. Guardar como "var.csv"
# en esta carpeta. El script toma las tres primeras columnas numericas, en el
# orden: inflacion, desempleo, tasa.
#
# Paquetes: vars (ya instalado).
# =============================================================================
library(vars)
library(hexView)


set.seed(1)
p <- 4                                    # rezagos del VAR del enunciado
archivo <- "./Material teórico/Notas de clase/Datos/var.wf1"
if (!file.exists(archivo)) stop("No se encuentra ", archivo, " (setwd a la carpeta de la materia)")

# --- Datos --------------------------------------------------------------------
raw <- readEViews(archivo, as.data.frame = FALSE)   # lista: una serie por elemento
cat("Series en el workfile:\n")
print(sapply(raw, length))
# Series numericas con 164 observaciones (1960Q1-2000Q4)
ok <- sapply(raw, function(s) is.numeric(s) && length(s) == 164)
if (sum(ok) < 3)
  stop("El workfile no tiene 3 series numericas de 164 obs. (ver longitudes arriba). ",
       "Usar el workfile con inflacion, desempleo y tasa, o exportarlo a CSV.")
# Ajustar los nombres si el workfile tiene mas de 3 series de 164 obs.
num <- as.data.frame(raw[ok])[, 1:3]
colnames(num) <- c("inflacion", "desempleo", "tasa")
y <- ts(num, start = c(1960, 1), frequency = 4)
stopifnot(nrow(y) == 164)                 # 1960Q1-2000Q4
cat("Muestra: T =", nrow(y), "\n")

# --- a) VAR(4) trivariado --------------------------------------------------------
var4 <- VAR(y, p = p, type = "const")
cat("\n==== a) VAR(4) ====\n")
print(summary(var4))

# --- b) Estabilidad: raices del polinomio caracteristico -----------------------------
cat("\n==== b) Estabilidad ====\n")
raices <- roots(var4, modulus = TRUE)     # modulos de los autovalores de la companion
print(round(raices, 4))
cat("Modulo maximo:", round(max(raices), 4),
    if (max(raices) < 1) "-> VAR estable (todas las raices dentro del circulo unitario)\n"
    else "-> VAR NO estable\n")

# --- c) Seleccion de rezagos -----------------------------------------------------
cat("\n==== c) Numero de rezagos ====\n")
sel <- VARselect(y, lag.max = 8, type = "const")
print(sel$selection)
print(round(sel$criteria, 4))

# Test de razon de verosimilitud VAR(4) vs VAR(m), m<4, misma muestra efectiva
# (correccion de Sims: T - c, c = parametros por ecuacion del modelo no restringido)
Tn <- nrow(y); k <- ncol(y)
Z  <- embed(as.matrix(y), p + 1)                    # [y_t, y_{t-1}, ..., y_{t-p}]
Yt <- Z[, 1:k]
lagj <- function(j) Z[, (j * k + 1):((j + 1) * k)]
ld_sys <- function(lags) {                          # log det de Sigma con esos rezagos
  X <- do.call(cbind, lapply(lags, lagj))
  e <- resid(lm(Yt ~ X))
  log(det(crossprod(e) / nrow(e)))
}
cp      <- 1 + k * p
ld_full <- ld_sys(1:p)
cat("\nLR: H0 = VAR(m) vs H1 = VAR(4)\n")
lr_tab <- t(sapply(1:(p - 1), function(m) {
  lr <- (Tn - p - cp) * (ld_sys(1:m) - ld_full)
  df <- k^2 * (p - m)
  c(m = m, LR = lr, gl = df, p_valor = pchisq(lr, df, lower.tail = FALSE))
}))
print(round(lr_tab, 4))

cat("\nExclusion del rezago j en todo el sistema (LR)\n")
excl_tab <- t(sapply(1:p, function(j) {
  lr <- (Tn - p - cp) * (ld_sys(setdiff(1:p, j)) - ld_full)
  c(rezago = j, LR = lr, gl = k^2, p_valor = pchisq(lr, k^2, lower.tail = FALSE))
}))
print(round(excl_tab, 4))

# --- d) Causalidad de Granger ------------------------------------------------------
cat("\n==== d) Causalidad de Granger (VAR(4)) ====\n")
vn <- colnames(y)
X_full <- do.call(cbind, lapply(1:p, lagj))
# H0: los 4 rezagos de `causa` no entran en la ecuacion de `efecto`
granger_pair <- function(causa, efecto) {
  cols <- unlist(lapply(0:(p - 1), function(l) l * k + match(causa, vn)))
  ie   <- match(efecto, vn)
  a <- anova(lm(Yt[, ie] ~ X_full[, -cols]), lm(Yt[, ie] ~ X_full))
  data.frame(causa = causa, efecto = efecto, F = round(a$F[2], 4),
             p_valor = round(a$`Pr(>F)`[2], 4))
}
g_tab <- do.call(rbind, unlist(lapply(vn, function(cz)
  lapply(setdiff(vn, cz), function(ef) granger_pair(cz, ef))), recursive = FALSE))
print(g_tab, row.names = FALSE)
cat("\nTest en bloque (vars::causality): una variable vs. las otras dos\n")
for (cz in vn) {
  g <- causality(var4, cause = cz)$Granger
  cat(sprintf("%-10s no causa a las otras: stat = %.4f, p = %.4f\n",
              cz, g$statistic, g$p.value))
}

# --- e) Funciones impulso-respuesta ----------------------------------------------------
# Cholesky con orden: inflacion, desempleo, tasa (el orden de las columnas de y)
cat("\n==== e) IRF (Cholesky: inflacion, desempleo, tasa; bandas bootstrap 95%) ====\n")
irf4 <- irf(var4, n.ahead = 24, ortho = TRUE, boot = TRUE, runs = 1000, ci = 0.95)
pdf("Problema3_IRF.pdf", width = 10, height = 8)
plot(irf4)
dev.off()
for (v in names(irf4$irf)) {
  cat("\nShock a", v, "(primeros 13 periodos)\n")
  print(round(irf4$irf[[v]][1:13, ], 4))
}

# --- f) Descomposicion de varianza del error de pronostico --------------------------------
cat("\n==== f) Descomposicion de varianza (n = 1, 4, 8, 12) ====\n")
fe <- fevd(var4, n.ahead = 12)
for (v in vn) {
  cat("\nVariable:", v, "\n")
  print(round(fe[[v]][c(1, 4, 8, 12), ], 4))
}
