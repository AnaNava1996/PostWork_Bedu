library(dplyr)
library(ggplot2)

goles <-
  "https://www.football-data.co.uk/mmz4281/1920/SP1.csv" %>%
  read.csv %>%
  select(casa = FTHG, visitante = FTAG)

frecuencia.marginal.casa <- table(goles$casa)
frecuencia.marginal.visitante <- table(goles$visitante)
frecuencia.conjunta <- table(goles)