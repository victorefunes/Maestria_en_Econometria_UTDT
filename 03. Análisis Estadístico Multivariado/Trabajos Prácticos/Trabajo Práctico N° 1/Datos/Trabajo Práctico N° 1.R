################################################################################
# Trabajo Práctico N° 1 - Análisis Estadístico Multivariado
# Traducción a R del do-file de Stata
################################################################################

rm(list = ls())

paquetes <- c("haven")
faltan <- paquetes[!sapply(paquetes, requireNamespace, quietly = TRUE)]
if (length(faltan) > 0) install.packages(faltan)
invisible(lapply(paquetes, library, character.only = TRUE))

# Directorio de trabajo: carpeta donde están los datos
# (si se corre desde RStudio con el script abierto, se usa su ubicación)
if (requireNamespace("rstudioapi", quietly = TRUE) &&
    rstudioapi::isAvailable()) {
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}

setwd("D:/Box/Maestria_en_Econometria_UTDT/03. Análisis Estadístico Multivariado/Trabajos Prácticos/Trabajo Práctico N° 1/Datos")

dir.create("../Figuras", showWarnings = FALSE)

options(width = 140, digits = 7)

#-------------------------------------------------------------------------------
# Funciones auxiliares (equivalentes a comandos de Stata)
#-------------------------------------------------------------------------------

# summarize
resumen <- function(df) {
  out <- t(sapply(df, function(x) {
    x <- x[!is.na(x)]
    c(Obs = length(x), Mean = mean(x), Std.Dev = sd(x), Min = min(x), Max = max(x))
  }))
  print(round(out, 4))
}

# summarize, detail (asimetría y curtosis con momentos poblacionales, como Stata)
resumen_detalle <- function(df) {
  for (v in names(df)) {
    x <- sort(df[[v]][!is.na(df[[v]])])
    n <- length(x)
    m2 <- mean((x - mean(x))^2)
    cat("\n----", v, "----\n")
    pct <- quantile(x, c(.01, .05, .10, .25, .50, .75, .90, .95, .99), type = 2)
    print(round(pct, 4))
    cat("Menores:", round(head(x, 4), 4), "\n")
    cat("Mayores:", round(tail(x, 4), 4), "\n")
    cat("Obs =", n, " Media =", mean(x), " Desv.Est. =", sd(x), " Varianza =", var(x), "\n")
    cat("Asimetría =", mean((x - mean(x))^3) / m2^1.5,
        " Curtosis =", mean((x - mean(x))^4) / m2^2, "\n")
  }
}

# tabstat, statistics(mean variance cv)
tabstat_mvc <- function(df) {
  out <- t(sapply(df, function(x) c(mean = mean(x), variance = var(x), cv = sd(x) / mean(x))))
  print(round(out, 6))
}

# Medidas de variabilidad global a partir de la matriz de covarianzas
variabilidad_global <- function(S) {
  p <- ncol(S)
  res <- c(var_tot = sum(diag(S)),
           var_media = sum(diag(S)) / p,
           var_gen = det(S),
           var_efec = det(S)^(1 / p))
  cat("Varianza total =", res["var_tot"], "\n")
  cat("Varianza media =", res["var_media"], "\n")
  cat("Varianza generalizada =", res["var_gen"], "\n")
  cat("Varianza efectiva =", res["var_efec"], "\n")
  invisible(res)
}

# Correlaciones parciales a partir de la matriz de precisión
corr_parcial_matriz <- function(S) {
  P <- solve(S)
  R <- -P / sqrt(outer(diag(P), diag(P)))
  diag(R) <- 1
  dimnames(R) <- dimnames(S)
  R
}

# pcorr y x1 ... xk: correlaciones parcial y semiparcial de la 1ra variable
pcorr <- function(df) {
  S <- cov(df)
  Rp <- corr_parcial_matriz(S)
  y <- 1
  xs <- 2:ncol(df)
  Pxx <- solve(S[xs, xs, drop = FALSE])
  beta <- solve(S[xs, xs, drop = FALSE], S[xs, y])
  semi <- beta * sqrt(1 / diag(Pxx)) / sqrt(S[y, y])
  out <- cbind(Parcial = Rp[y, xs], Semiparcial = semi)
  rownames(out) <- colnames(df)[xs]
  cat("Correlaciones parcial y semiparcial de", colnames(df)[y], "\n")
  print(round(out, 4))
  invisible(out)
}

# Coeficiente de dependencia efectiva
dependencia_efectiva <- function(C) {
  1 - det(C)^(1 / (ncol(C) - 1))
}


#*##############################################################################*
#                                EJERCICIO 1
#*##############################################################################*

eurosec <- as.data.frame(read_dta("eurosec.dta"))
str(eurosec)

cols <- 9
vars <- paste0("s", 1:cols)

etiquetas <- c(pais = "País", s1 = "Agricultura", s2 = "Minería", s3 = "Industria",
               s4 = "Energía", s5 = "Construcción", s6 = "Servicios Industriales",
               s7 = "Finanzas", s8 = "Servicios",
               s9 = "Transporte y Telecomunicaciones")

## INCISO (a) ##

resumen(eurosec[vars])
resumen_detalle(eurosec[vars])
tabstat_mvc(eurosec[vars])

## INCISO (b) ##

S <- cov(eurosec[vars])
print(S)

## INCISO (c) ##

X <- as.matrix(eurosec[vars])
fils <- nrow(X)
cols <- ncol(X)

cat("\n")
res_c <- variabilidad_global(S)

## INCISO (d) ##

print(cor(eurosec[vars]))

## INCISO (e) ##

reg <- lm(s2 ~ s1 + s3 + s4 + s5 + s6 + s7 + s8 + s9, data = eurosec)
print(summary(reg))
r2_reg <- summary(reg)$r.squared
var_resid_reg <- var(residuals(reg))

cat("Varianza de los residuos =", var_resid_reg, "\n")
cat("Coeficiente de determinación =", r2_reg, "\n")

S_inv <- solve(S)
print(S_inv)
var_resid_S <- 1 / S_inv[2, 2]
cat("Varianza de los residuos mediante matriz de precisión =", var_resid_S, "\n")
cat("Varianza de los residuos mediante regresión =", var_resid_reg, "\n")

r2_S <- 1 - 1 / (S[2, 2] * S_inv[2, 2])
cat("Coeficiente de determinación mediante matriz de precisión =", r2_S, "\n")
cat("Coeficiente de determinación mediante regresión =", r2_reg, "\n")

## INCISO (f) ##

pcorr(eurosec[vars])

resid_s1 <- residuals(lm(s1 ~ s3 + s4 + s5 + s6 + s7 + s8 + s9, data = eurosec))
resid_s2 <- residuals(lm(s2 ~ s3 + s4 + s5 + s6 + s7 + s8 + s9, data = eurosec))

coef_corr_part_com <- cor(resid_s1, resid_s2)
cat("Coeficiente de correlación parcial =", coef_corr_part_com, "\n")

coef_corr_part_S <- -S_inv[1, 2] / sqrt(S_inv[1, 1] * S_inv[2, 2])
cat("Coeficiente de correlación parcial =", coef_corr_part_S, "\n")

## INCISO (g) ##

C <- cor(eurosec[vars])
Aval <- eigen(C, symmetric = TRUE)$values
print(Aval)
cat("Número de variables =", sum(Aval), "\n")

## INCISO (h) ##

coef_dep_efec <- dependencia_efectiva(C)
cat("Coeficiente de dependencia efectiva =", coef_dep_efec, "\n")


#*##############################################################################*
#                                EJERCICIO 2
#*##############################################################################*

rm(list = setdiff(ls(), lsf.str()))   # se conservan solo las funciones

indiv <- as.data.frame(read_dta("Individual_t410.dta"))
str(indiv)
indiv <- indiv[!is.na(indiv$estado) & indiv$estado == 1 &
                 !is.na(indiv$ch06) & indiv$ch06 > 15, ]

# Sector de empleo a partir de los 2 primeros dígitos de pp04b_cod
s <- suppressWarnings(as.numeric(substr(trimws(as.character(indiv$pp04b_cod)), 1, 2)))
sector <- s   # los códigos no contemplados conservan su valor original (como en Stata)
sector[!is.na(s) & s >= 1  & s <= 5]  <- 1
sector[!is.na(s) & s >= 10 & s <= 14] <- 2
sector[!is.na(s) & s >= 15 & s <= 37] <- 3
sector[!is.na(s) & s == 40]            <- 4
sector[!is.na(s) & s == 45]            <- 5
sector[!is.na(s) & s >= 50 & s <= 53] <- 6
sector[!is.na(s) & s == 64]            <- 7
sector[!is.na(s) & s >= 65 & s <= 67] <- 8
sector[!is.na(s) & (s == 41 | s == 55 | (s >= 60 & s <= 63) |
                      (s >= 70 & s <= 74) | s == 80 | s == 85 |
                      (s >= 90 & s <= 99))] <- 9
sector[!is.na(s) & s == 75]            <- 10

etiq_sector <- c("Agricultura, Ganadería, Caza y Pesca", "Minería", "Industria",
                 "Energía", "Construcción", "Comercio", "Correo y Telecomunicaciones",
                 "Ss. Financieros", "Otros Ss.", "Administración Pública")
indiv$sector_empleo <- sector

print(table(indiv$sector_empleo, useNA = "ifany"))

indiv <- indiv[order(indiv$aglomerado, indiv$sector_empleo), ]

## INCISO (a) ##

tabmat <- unclass(table(indiv$aglomerado, indiv$sector_empleo))  # excluye faltantes
X <- tabmat / nrow(indiv) * 100     # nrow = _N (incluye obs. con sector faltante)
fils <- nrow(X)
cols <- ncol(X)
colnames(X) <- paste0("X", seq_len(cols))
print(round(X, 4))
if (cols != 10) warning("Se encontraron ", cols, " categorías de sector (se esperaban 10): ",
                        "revisar códigos no contemplados en pp04b_cod.")

Xdf <- as.data.frame(X)

vector_media <- sapply(Xdf, mean)
vector_var   <- sapply(Xdf, var)
vector_cv    <- sapply(Xdf, sd) / vector_media

nombres_sector <- if (cols == 10) etiq_sector else colnames(X)
res_vectores <- data.frame(media = vector_media, var = vector_var, cv = vector_cv,
                           row.names = nombres_sector)
print(res_vectores)

## INCISO (b) ##

S <- cov(Xdf)
cat("\n")
res_b <- variabilidad_global(S)

## INCISO (c) ##

reg <- lm(X9 ~ X1 + X2 + X3 + X4 + X5 + X6 + X7 + X8 + X10, data = Xdf)
print(summary(reg))
r2_reg <- summary(reg)$r.squared
var_resid_reg <- var(residuals(reg))

cat("Varianza de los residuos =", var_resid_reg, "\n")
cat("Coeficiente de determinación =", r2_reg, "\n")

S_inv <- solve(S)
print(S_inv)
var_resid_S <- 1 / S_inv[9, 9]
cat("Varianza de los residuos mediante matriz de precisión =", var_resid_S, "\n")
cat("Varianza de los residuos mediante regresión =", var_resid_reg, "\n")

r2_S <- 1 - 1 / (S[9, 9] * S_inv[9, 9])
cat("Coeficiente de determinación mediante matriz de precisión =", r2_S, "\n")
cat("Coeficiente de determinación mediante regresión =", r2_reg, "\n")

## INCISO (d) ##

pcorr(Xdf[c("X9", "X1", "X2", "X3", "X4", "X5", "X6", "X7", "X8", "X10")])

resid_s6 <- residuals(lm(X6 ~ X1 + X2 + X3 + X4 + X5 + X7 + X8 + X10, data = Xdf))
resid_s9 <- residuals(lm(X9 ~ X1 + X2 + X3 + X4 + X5 + X7 + X8 + X10, data = Xdf))

coef_corr_part_com <- cor(resid_s6, resid_s9)
cat("Coeficiente de correlación parcial =", coef_corr_part_com, "\n")

coef_corr_part_S <- -S_inv[6, 9] / sqrt(S_inv[6, 6] * S_inv[9, 9])
cat("Coeficiente de correlación parcial =", coef_corr_part_S, "\n")

## INCISO (e) ##

C <- cor(Xdf)
Aval <- eigen(C, symmetric = TRUE)$values
print(Aval)

## INCISO (f) ##

coef_dep_efec <- dependencia_efectiva(C)
cat("Coeficiente de dependencia efectiva =", coef_dep_efec, "\n")


#*##############################################################################*
#                                EJERCICIO 3
#*##############################################################################*

rm(list = setdiff(ls(), lsf.str()))

records <- as.data.frame(read_dta("records.dta"))
str(records)

vars <- c("m_100", "m_200", "m_400", "m_800", "m_1500", "km_5", "km_10", "maraton")
cols <- length(vars)

## INCISO (a) ##

resumen(records[vars])
resumen_detalle(records[vars])
tabstat_mvc(records[vars])
print(cor(records[vars]))
print(cov(records[vars]))
pcorr(records[vars])

## INCISO (b) ##

# PCA basado en la matriz de covarianzas
eig_cov <- eigen(cov(records[vars]), symmetric = TRUE)
eigenvalues_cov <- eig_cov$values
eigenvectors_cov <- eig_cov$vectors
dimnames(eigenvectors_cov) <- list(vars, paste0("Comp", 1:cols))
print(eigenvalues_cov)
print(eigenvectors_cov)

# PCA basado en la matriz de correlaciones
eig_cor <- eigen(cor(records[vars]), symmetric = TRUE)
eigenvalues_cor <- eig_cor$values
eigenvectors_cor <- eig_cor$vectors
dimnames(eigenvectors_cor) <- list(vars, paste0("Comp", 1:cols))
print(eigenvalues_cor)
print(eigenvectors_cor)

## INCISO (c) ##

# (i) Scree plot
png("../Figuras/Ejercicio 3.c.i.png", width = 900, height = 650)
plot(1:cols, eigenvalues_cor, type = "b", pch = 19,
     main = "PCA\n(basado en matriz de correlaciones)",
     xlab = "Componente", ylab = "Autovalor")
abline(h = 1, col = "red")
dev.off()

# (ii) Varianza explicada
prop <- eigenvalues_cor / sum(eigenvalues_cor)
prop_acum <- cumsum(prop)
print(cbind(comp = 1:cols, prop = prop))

png("../Figuras/Ejercicio 3.c.ii (a).png", width = 900, height = 650)
b <- barplot(prop, names.arg = 1:cols, ylim = c(0, 1), yaxt = "n", space = 0.1,
             xlab = "Componente",
             main = "Porcentaje de varianza explicada por cada componente\n(basado en matriz de correlaciones)")
axis(2, at = seq(0.1, 1, 0.1), labels = paste0(seq(10, 100, 10), "%"), las = 1)
text(b, prop, labels = formatC(prop, digits = 3, format = "g"), pos = 3)
dev.off()

png("../Figuras/Ejercicio 3.c.ii (b).png", width = 900, height = 650)
b <- barplot(prop_acum, names.arg = 1:cols, ylim = c(0, 1), yaxt = "n", space = 0.1,
             xlab = "Componente",
             main = "Porcentaje acumulado de varianza explicada por cada componente\n(basado en matriz de correlaciones)")
axis(2, at = seq(0.1, 1, 0.1), labels = paste0(seq(10, 100, 10), "%"), las = 1)
text(b, prop_acum, labels = formatC(prop_acum, digits = 3, format = "g"), pos = 3)
dev.off()

## INCISO (d) ##

# Scores de los dos primeros componentes (PCA sobre correlaciones)
scores <- scale(as.matrix(records[vars])) %*% eigenvectors_cor[, 1:2]
u_1 <- scores[, 1]
u_2 <- scores[, 2]

png("../Figuras/Ejercicio 3.d.png", width = 900, height = 650)
plot(u_1, u_2, pch = 19, cex = 0.6,
     main = "Scatterplot\n(basado en matriz de correlaciones)",
     xlab = "Componente 1", ylab = "Componente 2")
abline(h = 0, v = 0, col = "red")
text(u_1, u_2, labels = records$pais, pos = 4, cex = 0.7)
dev.off()
