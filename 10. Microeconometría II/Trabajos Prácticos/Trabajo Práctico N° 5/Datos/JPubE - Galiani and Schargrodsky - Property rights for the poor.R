rm(list = ls())

# setwd("C:/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Econometría/10. Microeconometría II/Trabajos Prácticos/Trabajo Práctico N° 5/Datos")
setwd("D:/Box/Maestria_en_Econometria_UTDT/10. Microeconometría II/Trabajos Prácticos/Trabajo Práctico N° 5/Datos")

# install.packages(c("haven", "sandwich", "lmtest", "AER", "car"))
library(haven)
library(sandwich)
library(lmtest)
library(AER)
library(car)

# Galiani y Schargrodsky, "Property rights for the poor", JPubE.
# Nota: el .do original corre primero "... - Matching datasets.do", que construye los
# datasets "...Matching.dta" (pscore y bloques). Aquí se leen directamente esos .dta ya
# existentes en la carpeta.

pref <- "JPubE - Galiani and Schargrodsky - Property rights for the poor - "
leer <- function(nombre) as.data.frame(zap_labels(read_dta(paste0(pref, nombre, ".dta"))))


################################################################################
#                            FUNCIONES AUXILIARES                              #
################################################################################

X5  <- c("parcelSurface", "distanceToCreek", "blockCorner", "distToNonSquatted")
Xhh <- c("ageOfOrigSquatterDummy", "ageOsMiss", "femaleOrigSquatter", "argentineOrigSquatter",
         "educationYearsOrigSquatter", "argentineOrigSquatterFather", "argentinaFatherOsMiss",
         "educYearsOrigSquatterFather", "educationOfTheFatherMiss", "argentineOrigSquatterMother",
         "educYearsOrigSquatterMother", "educationOfTheMotherMiss")
XB  <- c(X5, Xhh)                      # controles completos
XE  <- c(X5, "male", "childAge", Xhh)  # controles completos (educación)

# Variables de datos faltantes (idéntico bloque en el .do para cada dataset)
agregar_miss <- function(d) {
  d$ageOsMiss <- as.numeric(is.na(d$ageOrigSquatter))
  d$argentinaFatherOsMiss <- as.numeric(is.na(d$argentineOrigSquatterFather))
  d$argentineOrigSquatterFather[is.na(d$argentineOrigSquatterFather)] <- 0
  d$argentinaMotherOsMiss <- as.numeric(is.na(d$argentineOrigSquatterMother))
  d$argentineOrigSquatterMother[is.na(d$argentineOrigSquatterMother)] <- 0
  d$educationOfTheFatherMiss <- as.numeric(is.na(d$levelEducationOfTheFather))
  d$educYearsOrigSquatterFather[is.na(d$levelEducationOfTheFather)] <- 0
  d$educationOfTheMotherMiss <- as.numeric(is.na(d$levelEducationOfTheMother))
  d$educYearsOrigSquatterMother[is.na(d$levelEducationOfTheMother)] <- 0
  d
}

# Muestras (devuelven índices de filas; las condiciones con NA son falsas, como en Stata)
s_inv <- function(d, nb = TRUE, hh86 = TRUE, rep0 = TRUE) {
  ok <- d$inBothDatasets == 3 & is.na(d$nonSurveyed)
  if (rep0) ok <- ok & d$repeatedParcel == 0
  if (nb)   ok <- ok & d$neighborhood < 5
  if (hh86) ok <- ok & d$householdArrivedBefore1986 == 1
  which(ok)
}
s_hh <- function(d, nb = TRUE) s_inv(d, nb = nb, hh86 = TRUE, rep0 = FALSE)

# reg y xs [if] [, cluster()] ; imprime los coeficientes clave
reg <- function(d, y, xs, idx = seq_len(nrow(d)), keys = "propertyRight", cluster = NULL,
                etiqueta = "") {
  d2 <- d[idx, , drop = FALSE]
  d2 <- d2[complete.cases(d2[, c(y, xs, cluster)]), , drop = FALSE]
  m <- lm(reformulate(xs, y), data = d2)
  if (is.null(cluster)) {
    ct <- coeftest(m)
  } else {
    g <- d2[[cluster]]
    ct <- coeftest(m, vcov = vcovCL(m, cluster = g, type = "HC1"),
                   df = length(unique(g)) - 1)
  }
  cat(sprintf("\n[%s] reg %s%s  (N = %d, R2 = %.4f)\n", etiqueta, y,
              if (is.null(cluster)) "" else paste0(", cluster(", cluster, ")"),
              nrow(d2), summary(m)$r.squared))
  print(round(ct[intersect(keys, rownames(ct)), , drop = FALSE], 4))
  if ("propertyRight" %in% xs) {
    cat("Media de", y, "con propertyRight == 0:", mean(d2[[y]][d2$propertyRight == 0]), "\n")
  }
  invisible(m)
}

# ivreg y (propertyRight = propertyOffer) xs [if]
ivr <- function(d, y, xs, idx = seq_len(nrow(d)), etiqueta = "") {
  d2 <- d[idx, , drop = FALSE]
  d2 <- d2[complete.cases(d2[, c(y, xs, "propertyRight", "propertyOffer")]), , drop = FALSE]
  f <- as.formula(paste(y, "~ propertyRight +", paste(xs, collapse = " + "),
                        "| propertyOffer +", paste(xs, collapse = " + ")))
  m <- ivreg(f, data = d2)
  cat(sprintf("\n[%s] ivreg %s (propertyRight = propertyOffer)  (N = %d)\n", etiqueta, y, nrow(d2)))
  print(round(coef(summary(m))["propertyRight", , drop = FALSE], 4))
  invisible(m)
}

# atts (Becker-Ichino, estratificación) con bootstrap de 100 repeticiones
atts <- function(d, y, treat = "propertyRight", block = "matchingBlock", reps = 100) {
  est <- function(dd) {
    bl <- sort(unique(dd[[block]]))
    dif <- nt <- rep(NA_real_, length(bl))
    for (k in seq_along(bl)) {
      s <- dd[[block]] == bl[k]
      if (any(dd[[treat]][s] == 1) && any(dd[[treat]][s] == 0)) {
        dif[k] <- mean(dd[[y]][s & dd[[treat]] == 1]) - mean(dd[[y]][s & dd[[treat]] == 0])
        nt[k] <- sum(s & dd[[treat]] == 1)
      }
    }
    sum(dif * nt, na.rm = TRUE) / sum(nt, na.rm = TRUE)
  }
  set.seed(1)
  b <- replicate(reps, est(dd = d[sample(nrow(d), replace = TRUE), ]))
  cat(sprintf("atts %s: ATT = %.4f   EE bootstrap (%d reps) = %.4f\n", y, est(d), reps, sd(b)))
}

# Bloque "use ...Matching, clear; drop if y==.; set seed 1; atts ..."
atts_archivo <- function(archivo, y) {
  m <- leer(archivo)
  m <- m[!is.na(m[[y]]), ]
  atts(m, y)
}

# Welch t-test (ttest ..., by() unequal welch); diferencia = media(0) - media(1)
ttw <- function(d, v, by, idx) {
  d2 <- d[idx, ]
  tt <- t.test(d2[[v]][d2[[by]] == 0], d2[[v]][d2[[by]] == 1])
  cat(sprintf("%-34s media0 = %9.4f  media1 = %9.4f  dif = %9.4f  t = %7.3f  p = %.4f\n",
              v, tt$estimate[1], tt$estimate[2], tt$estimate[1] - tt$estimate[2],
              tt$statistic, tt$p.value))
}

# Columnas 1 a 9 de las tablas de inversión / tamaño del hogar
columnas_hogar <- function(d, y, tipo = c("inv", "hh")) {
  tipo <- match.arg(tipo)
  S  <- if (tipo == "inv") s_inv(d) else s_hh(d)
  S4 <- if (tipo == "inv") s_inv(d, nb = FALSE) else s_hh(d, nb = FALSE)
  reg(d, y, c("propertyRight", XB), S, etiqueta = "col 1")
  reg(d, y, "propertyRight", S, etiqueta = "col 2")
  reg(d, y, c("propertyRight", X5), S, etiqueta = "col 3")
  reg(d, y, c("propertyRight", XB), S4, etiqueta = "col 4")
  reg(d, y, c("propertyRight", XB), S, cluster = "blockId", etiqueta = "col 5")
  reg(d, y, c("propertyRight", XB), S, cluster = "formerOwner", etiqueta = "col 6")
  reg(d, y, c("propertyOffer", XB), S, keys = "propertyOffer", etiqueta = "col 7")
  ivr(d, y, XB, S, etiqueta = "col 8")
  m9 <- reg(d, y, c("propertyRightEarly", "propertyRightLate", XB), S,
            keys = c("propertyRightEarly", "propertyRightLate"), etiqueta = "col 9")
  print(linearHypothesis(m9, "propertyRightEarly = propertyRightLate"))
}

# Columnas 1 a 9 de las tablas de educación
columnas_educ <- function(d, y) {
  reg(d, y, c("propertyRight", XE), etiqueta = "col 1")
  reg(d, y, c("propertyRight", "male", "childAge"), etiqueta = "col 2")
  reg(d, y, c("propertyRight", X5, "male", "childAge"), etiqueta = "col 3")
  reg(d, y, c("propertyRight", XE), cluster = "householdId", etiqueta = "col 4")
  reg(d, y, c("propertyRight", XE), cluster = "blockId", etiqueta = "col 5")
  reg(d, y, c("propertyRight", XE), cluster = "formerOwner", etiqueta = "col 6")
  reg(d, y, c("propertyOffer", XE), keys = "propertyOffer", etiqueta = "col 7")
  ivr(d, y, XE, etiqueta = "col 8")
  reg(d, y, c("propertyRightEarly", "propertyRightLate", XE),
      keys = c("propertyRightEarly", "propertyRightLate"), etiqueta = "col 9")
}

# Columnas con matching en educación: recorte por pscore, 5 bloques con percentiles
# 20/40/60/80 del pscore de los tratados, y atts.
atts_educ <- function(y, edad_min, edad_max, lo, hi, excluir = NULL) {
  m <- leer("educationMatching")
  if (!is.null(excluir)) m <- m[!(m[[excluir]] %in% 1), ]
  m <- m[which(m$childAge >= edad_min & m$childAge < edad_max), ]
  m <- m[which(m$propensityScore >= lo & m$propensityScore <= hi), ]
  b <- quantile(m$propensityScore[m$propertyRight == 1], c(0.2, 0.4, 0.6, 0.8), type = 2)
  m$matchingBlock <- findInterval(m$propensityScore, b) + 1
  m <- m[!is.na(m[[y]]), ]
  m <- m[order(m$personId), ]
  atts(m, y)
}


################################################################################
#                        DATASET DE INVERSIÓN (investment)                     #
################################################################################

inv <- leer("investment")

# Table 1
cat("\n===== TABLE 1 - Panel A =====\n")
SA <- which(inv$neighborhood < 5 & inv$repeatedParcel == 0)
for (v in c("distanceToCreek", "distToNonSquatted", "parcelSurface", "blockCorner"))
  ttw(inv, v, "propertyOffer", SA)

cat("\n===== TABLE 1 - Panel B =====\n")
SB <- s_inv(inv)
for (v in c("ageOrigSquatter", "femaleOrigSquatter", "argentineOrigSquatter",
            "educationYearsOrigSquatter", "argentineOrigSquatterFather",
            "educYearsOrigSquatterFather", "argentineOrigSquatterMother",
            "educYearsOrigSquatterMother"))
  ttw(inv, v, "propertyOffer", SB)

inv <- agregar_miss(inv)

# Table 2
cat("\n===== TABLE 2 =====\n")
S2 <- which(inv$repeatedParcel == 0 & inv$neighborhood < 5)
ttw(inv, "householdArrivedBefore1986", "propertyOffer", S2)
ttw(inv, "householdArrivedBefore1986", "propertyOffer",
    which(inv$repeatedParcel == 0 & inv$propertyRightOfferLate == 0 & inv$neighborhood < 5))
ttw(inv, "householdArrivedBefore1986", "propertyOffer",
    which(inv$repeatedParcel == 0 & inv$propertyRightOfferEarly == 0 & inv$neighborhood < 5))

# Table 3 (la primera regresión del .do incluye además argentinaMotherOsMiss)
cat("\n===== TABLE 3 =====\n")
S <- s_inv(inv)
reg(inv, "goodWalls", c("propertyRight", XB, "argentinaMotherOsMiss"), S, etiqueta = "T3 goodWalls")
for (y in c("goodRoof", "constructedSurface", "concreteSidewalk", "overallHousingAppearance"))
  reg(inv, y, c("propertyRight", XB), S, etiqueta = paste("T3", y))

# Table 4 (goodWalls) y Tables A.1 - A.4 (mismas 11 columnas con otro outcome)
tabla_inv <- function(y, titulo) {
  cat("\n=====", titulo, "(", y, ") =====\n")
  columnas_hogar(inv, y, "inv")
  cat("\n[col 10] matching\n")
  atts_archivo("investmentMatching", y)
  reg(inv, y, c("propertyRight", X5), s_inv(inv, hh86 = FALSE), etiqueta = "col 11")
}
tabla_inv("goodWalls", "TABLE 4")
tabla_inv("goodRoof", "TABLE A.1")
tabla_inv("constructedSurface", "TABLE A.2")
tabla_inv("concreteSidewalk", "TABLE A.3")
tabla_inv("overallHousingAppearance", "TABLE A.4")

# Table A.5 (sobre el dataset en memoria; condición sin repeatedParcel == 0)
cat("\n===== TABLE A.5 =====\n")
hh <- agregar_miss(leer("householdSize"))
for (y in c("hasRefrigetratorWithFreezer", "hasRefrigetratorWithoutFreezer", "laundryMachine",
            "hasTv", "hasCellularPhone")) {
  d <- if (y %in% names(inv)) inv else hh
  reg(d, y, c("propertyRight", XB), s_hh(d), etiqueta = "A.5")
}


################################################################################
#                  DATASET DE TAMAÑO DEL HOGAR (householdSize)                 #
################################################################################

# Table 5
cat("\n===== TABLE 5 =====\n")
S <- s_hh(hh)
reg(hh, "householdSize", c("propertyRight", XB), S, etiqueta = "reg 1")
reg(hh, "spouse", c("propertyRight", XB), S, etiqueta = "reg 2")
reg(hh, "numberChildrensMoreThan14", c("propertyRight", XB), S, etiqueta = "reg 3")
reg(hh, "numberOtherRelatives", c("propertyRight", XB), S, etiqueta = "reg 4")
reg(hh, "numberChildrens5_13", c("propertyRight", XB), S, etiqueta = "reg 5")
reg(hh, "numberChildrens5_13", c("propertyRightEarly", "propertyRightLate", XB), S,
    keys = c("propertyRightEarly", "propertyRightLate"), etiqueta = "reg 6")
reg(hh, "numberChildrens0_4", c("propertyRight", XB), S, etiqueta = "reg 7")
reg(hh, "numberChildrens0_4", c("propertyRightEarly", "propertyRightLate", XB), S,
    keys = c("propertyRightEarly", "propertyRightLate"), etiqueta = "reg 8")

# Tables A.6 - A.11
tabla_hh <- function(y, titulo, extra = FALSE) {
  cat("\n=====", titulo, "(", y, ") =====\n")
  columnas_hogar(hh, y, "hh")
  cat("\n[col 10] matching\n")
  atts_archivo("householdSizeMatching", y)
  if (extra) {
    cat("[matching: propertyRightEarly]\n"); atts_archivo("householdSizeMatchingEarly", y)
    cat("[matching: propertyRightLate]\n");  atts_archivo("householdSizeMatchingLate", y)
  }
}
tabla_hh("householdSize", "TABLE A.6")
tabla_hh("spouse", "TABLE A.7")
tabla_hh("numberChildrensMoreThan14", "TABLE A.8")
tabla_hh("numberOtherRelatives", "TABLE A.9")
tabla_hh("numberChildrens5_13", "TABLE A.10", extra = TRUE)
tabla_hh("numberChildrens0_4", "TABLE A.11", extra = TRUE)


################################################################################
#                       DATASET DE EDUCACIÓN (education)                       #
################################################################################

edu <- agregar_miss(leer("education"))

# Table 6 (las cohortes se restringen progresivamente, como los "keep" del .do)
cat("\n===== TABLE 6 =====\n")
reg(edu, "schoolAchievement", c("propertyRight", XE), etiqueta = "col 1")
reg(edu, "schoolAchievement", c("propertyRightEarly", "propertyRightLate", XE),
    keys = c("propertyRightEarly", "propertyRightLate"), etiqueta = "col 2")
e13 <- edu[which(edu$childAge >= 13 & edu$childAge < 21), ]
reg(e13, "primarySchoolCompletion", c("propertyRight", XE), etiqueta = "col 3")
reg(e13, "primarySchoolCompletion", c("propertyRightEarly", "propertyRightLate", XE),
    keys = c("propertyRightEarly", "propertyRightLate"), etiqueta = "col 4")
e18 <- e13[which(e13$childAge >= 18 & e13$childAge < 21), ]
reg(e18, "secondarySchoolCompletion", c("propertyRight", XE), etiqueta = "col 5")
reg(e18, "secondarySchoolCompletion", c("propertyRightEarly", "propertyRightLate", XE),
    keys = c("propertyRightEarly", "propertyRightLate"), etiqueta = "col 6")
reg(e18, "postSecondaryEducation", c("propertyRight", XE), etiqueta = "col 7")
reg(e18, "postSecondaryEducation", c("propertyRightEarly", "propertyRightLate", XE),
    keys = c("propertyRightEarly", "propertyRightLate"), etiqueta = "col 8")

# Table 7
cat("\n===== TABLE 7 =====\n")
S <- s_hh(hh)
for (y in c("creditCardBankAccount", "nonMortgageLoan", "informalCredit", "groceryStoreCredit",
            "mortgageLoan"))
  reg(hh, y, c("propertyRight", XB), S, etiqueta = paste("T7", y))
reg(hh, "mortgageLoan", c("propertyRightEarly", "propertyRightLate", XB), S,
    keys = c("propertyRightEarly", "propertyRightLate"), etiqueta = "T7 col 6")

# Table 8
cat("\n===== TABLE 8 =====\n")
for (y in c("householdHeadIncome", "totalHouseholdIncome", "totalHouseholdIncomePerCapita",
            "totalHouseholdIncomePerAdult", "employedHouseholdHead"))
  reg(hh, y, c("propertyRight", XB), S, etiqueta = paste("T8", y))

# Tables A.12 - A.15: educación por tramo de edad
# matching = lista de especificaciones (edad_min, lo, hi, excluir) para cols de matching
tabla_educ <- function(y, titulo, edad_min, edad_max, matching) {
  cat("\n=====", titulo, "(", y, ") =====\n")
  d <- edu[which(edu$childAge >= edad_min & edu$childAge < edad_max), ]
  columnas_educ(d, y)
  for (k in seq_along(matching)) {
    s <- matching[[k]]
    cat(sprintf("\n[matching %d] edad >= %d, pscore en [%.7f, %.7f], excluye %s\n",
                k, s$edad, s$lo, s$hi, if (is.null(s$excluir)) "-" else s$excluir))
    atts_educ(y, s$edad, edad_max, s$lo, s$hi, s$excluir)
  }
}

tabla_educ("schoolAchievement", "TABLE A.12", 6, 21, list(
  list(edad = 6, lo = 0.5381833, hi = 0.7507662),
  list(edad = 6, lo = 0.6363688, hi = 0.7507662, excluir = "propertyRightLate"),
  list(edad = 6, lo = 0.5381833, hi = 0.7088112, excluir = "propertyRightEarly")))

tabla_educ("primarySchoolCompletion", "TABLE A.13", 13, 21, list(
  list(edad = 13, lo = 0.5381833, hi = 0.7503611),
  list(edad = 12, lo = 0.653023,  hi = 0.7503611, excluir = "propertyRightLate"),
  list(edad = 13, lo = 0.653023,  hi = 0.7503611, excluir = "propertyRightLate"),
  list(edad = 13, lo = 0.5381833, hi = 0.7088112, excluir = "propertyRightEarly")))

tabla_educ("secondarySchoolCompletion", "TABLE A.14", 18, 21, list(
  list(edad = 18, lo = 0.5381833, hi = 0.7366924),
  list(edad = 18, lo = 0.653023,  hi = 0.7366924, excluir = "propertyRightLate"),
  list(edad = 18, lo = 0.5519478, hi = 0.7014628, excluir = "propertyRightEarly")))

tabla_educ("postSecondaryEducation", "TABLE A.15", 18, 21, list(
  list(edad = 18, lo = 0.5519478, hi = 0.7366924),
  list(edad = 18, lo = 0.653023,  hi = 0.7366924, excluir = "propertyRightLate"),
  list(edad = 18, lo = 0.5519478, hi = 0.7014628, excluir = "propertyRightEarly")))


################################################################################
#                               TABLES A.16 - A.17                             #
################################################################################

cat("\n===== TABLE A.16 =====\n")
S <- s_hh(hh)
for (y in c("creditCardBankAccount", "nonMortgageLoan", "informalCredit", "groceryStoreCredit",
            "mortgageLoan")) {
  reg(hh, y, c("propertyRight", XB), S, etiqueta = paste("A.16", y))
  reg(hh, y, c("propertyRightEarly", "propertyRightLate", XB), S,
      keys = c("propertyRightEarly", "propertyRightLate"), etiqueta = paste("A.16", y, "Early/Late"))
}

cat("\n===== TABLE A.17 =====\n")
for (y in c("householdHeadIncome", "totalHouseholdIncome", "totalHouseholdIncomePerCapita",
            "totalHouseholdIncomePerAdult", "employedHouseholdHead")) {
  reg(hh, y, c("propertyRight", XB), S, etiqueta = paste("A.17", y))
  reg(hh, y, c("propertyRightEarly", "propertyRightLate", XB), S,
      keys = c("propertyRightEarly", "propertyRightLate"), etiqueta = paste("A.17", y, "Early/Late"))
}
