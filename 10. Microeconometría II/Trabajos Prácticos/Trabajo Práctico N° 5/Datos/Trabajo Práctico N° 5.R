rm(list = ls())

# setwd("C:/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Econometría/10. Microeconometría II/Trabajos Prácticos/Trabajo Práctico N° 5/Datos")
setwd("D:/Box/Maestria_en_Econometria_UTDT/10. Microeconometría II/Trabajos Prácticos/Trabajo Práctico N° 5/Datos")


################################################################################
#                                EJERCICIO 2                                   #
################################################################################

# INCISO (a)

set.seed(12345)
n <- 100

y0 <- rnorm(n, 100, 30)

# INCISO (b)

te <- rnorm(n, 20, 10)
y1 <- y0 + te + rnorm(n, 0, 10)

DD <- as.numeric(rnorm(n) > 0)   # instrumento (asignación aleatoria)

# INCISO (c)

random2 <- runif(n, 0, 1)

alwaystaker <- as.numeric(random2 < 0.25)
nevertaker  <- as.numeric(random2 >= 0.25 & random2 < 0.5)
defier      <- as.numeric(random2 >= 0.5 & random2 < 0.75)
complier    <- as.numeric(random2 > 0.75)

D <- rep(0, n)
D[alwaystaker == 1] <- 1
D[nevertaker == 1]  <- 0
D[complier == 1]    <- DD[complier == 1]
D[defier == 1]      <- 1 - DD[defier == 1]

# INCISO (d)

y <- D * y1 + (1 - D) * y0

# INCISO (e)

for (g in 0:1) {
  cat("\nDD =", g, "\n")
  print(summary(y[DD == g]))
}
for (g in 0:1) {
  cat("\nD =", g, "\n")
  print(summary(y[D == g]))
}
# Stata: ttest ..., by() usa varianzas iguales por defecto (var.equal = TRUE)
print(t.test(y[D == 1], y[D == 0], var.equal = TRUE))

cat("LATE =", mean(te[complier == 1]), "\n")
cat("ATE =", mean(te), "\n")


################################################################################
#                                EJERCICIO 3                                   #
################################################################################

# (Sin código en el .do original)
