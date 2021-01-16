library(dplyr)
library(ggplot2)


# 1- Cargamos el csv del enlace en la variable primera19_20

primera19_20 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

head(primera19_20)
dim(primera19_20)
class(primera19_20)
str(primera19_20)

# 2- Del data frame que resulta de importar los datos a R, extrae las columnas que contienen los números de 
# goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)

goles <- select(primera19_20, HomeTeam, AwayTeam, FTHG, FTAG)
goles <- rename(goles, casa=FTHG, visitante=FTAG )
goles
# 3- Consulta cómo funciona la función table en R al ejecutar en la consola ?table

?table

#  Posteriormente elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:
#  La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)
#  La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)
#  La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)


