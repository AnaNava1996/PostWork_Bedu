install.packages("gmodels")
library(gmodels)


# 1- Cargamos el csv del enlace en la variable primera19_20

primera19_20 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

head(primera19_20)
dim(primera19_20)
class(primera19_20)
str(primera19_20)

# 2- Del data frame que resulta de importar los datos a R, extrae las columnas que contienen los números de 
# goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG)

goles <- select(primera19_20, HomeTeam, AwayTeam, FTHG, FTAG)

#goles_FTHG <- primera19_20$FTHG
#goles_FTAG <- primera19_20$FTAG

#goles
# 3- Consulta cómo funciona la función table en R al ejecutar en la consola ?table

?table

#  Posteriormente elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:
#  La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)

goles_casa <- sort(unique(goles$FTHG))
frecuencia_marginal <- as.vector(table(goles$FTHG))                #frecuencias absolutas
probabilidad_marginal <- as.vector(prop.table(table(goles$FTHG)))  #frecuencias relativas
data.frame(goles_casa, frecuencia_marginal, probabilidad_marginal)

#  La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)

goles_visitantes <- sort(unique(goles$FTAG))
frecuencias_marginales <- as.vector(table(goles$FTAG))
frecuencias_relativas <- as.vector(prop.table(table(goles$FTAG)))
data.frame(goles_visitantes, frecuencias_marginales, frecuencias_relativas)


#  La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)

mytable <- table(goles$FTHG,goles$FTAG)
mytable <- prop.table(mytable)
mytable

CrossTable(goles$FTHG, goles$FTAG, prop.chisq=FALSE, prop.r=FALSE, prop.c=FALSE)
