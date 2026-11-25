rm(list = ls())

# setwd("C:/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Econometría/10. Microeconometría II/Trabajos Prácticos/Trabajo Práctico N° 1/Datos")
# setwd("G:/Mi unidad/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Econometría/10. Microeconometría II/Trabajos Prácticos/Trabajo Práctico N° 1/Datos")

seed <- 12345


################################################################################
#                                EJERCICIO 2                                   #
################################################################################

reps <- 10000

y1 <- c(7, 5, 5, 7, 4, 10, 1, 5, 3, 9)
y0 <- c(1, 6, 1, 8, 2, 1, 10, 6, 7, 8)

set.seed(seed)

simulation <- function() {
  # Asignación aleatoria: 5 tratados y 5 controles
  d <- sample(c(rep(1, 5), rep(0, 5)))
  y <- d * y1 + (1 - d) * y0
  mean(y[d == 1]) - mean(y[d == 0])
}

dif <- replicate(reps, simulation())

print(summary(dif))
cat("La media de las diferencias de medias de cada simulación es", mean(dif), "\n")


################################################################################
#                                EJERCICIO 3                                   #
################################################################################

# Resumen de resultados (equivalente a summarize / ttest / ATE-ATT-ATU de Stata)
resumen <- function(y, tr, te) {
  for (g in 0:1) {
    cat("\n", if (g == 1) "Tratados" else "Controles", " (D = ", g, ")\n", sep = "")
    print(summary(y[tr == g]))
  }
  # Stata: ttest ..., by() usa varianzas iguales por defecto (var.equal = TRUE)
  print(t.test(y[tr == 1], y[tr == 0], var.equal = TRUE))
  cat("ATE =", mean(te), "\n")
  cat("ATT =", mean(te[tr == 1]), "\n")
  cat("ATU =", mean(te[tr == 0]), "\n")
}

# INCISO (c)

set.seed(seed)
n <- 100

y0 <- rnorm(n, 100, 30)

# INCISO (d)

te <- rep(20, n)
y1 <- y0 + te + rnorm(n, 0, 10)

D <- as.numeric(rnorm(n) > 0)

y <- D * y1 + (1 - D) * y0

resumen(y, D, te)

# INCISO (e)

set.seed(seed)

y0 <- rnorm(n, 100, 30)

te <- rnorm(n, 20, 10)
y1 <- y0 + te + rnorm(n, 0, 10)

D <- as.numeric(rnorm(n) > 0)

y <- D * y1 + (1 - D) * y0

resumen(y, D, te)

# INCISO (f)

set.seed(seed)

y0 <- rnorm(n, 100, 30)

W <- as.numeric(rnorm(n) > 0)

te <- ifelse(W == 1, rnorm(n, 20, 10), rnorm(n, 10, 10))

y1 <- y0 + te + rnorm(n, 0, 10)

y <- W * y1 + (1 - W) * y0

resumen(y, W, te)

# INCISO (g)

set.seed(seed)

y0 <- rnorm(n, 100, 30)

W <- as.numeric(rnorm(n) > 0)

te <- ifelse(W == 1, rnorm(n, 20, 10), rnorm(n, 10, 10))

y1 <- y0 + te + rnorm(n, 0, 10)

D <- as.numeric(rnorm(n) > 0)

y <- D * y1 + (1 - D) * y0

resumen(y, D, te)
