library(dplyr)
library(ggplot2)

#######    PRIMERA PARTE   ##########    COCIENTE   #########

#   Se leen los data sets
goles <- select(read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv"),FTHG,FTAG)
goles <- rbind(goles, select(read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv"),FTHG,FTAG))
goles <- rbind(goles, select(read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv"),FTHG,FTAG))

#   Se construye la tabla de probabilidades conjuntas
mytable <- prop.table(table(goles$FTHG,goles$FTAG))

#   La convierto a un dataframe
mydf <- as.data.frame(mytable)

#   Obtengo las probabilidades marginales
marginal_casa = as.data.frame(prop.table(table(goles$FTHG)))
marginal_visitantes = as.data.frame(prop.table(table(goles$FTAG)))

#   Cambio los nombres para hacer Merge()
marginal_casa <- marginal_casa %>% 
  rename(
    FTHG = Var1,
    Prob_marginal_casa = Freq
  )

marginal_visitantes <- marginal_visitantes %>% 
  rename(
    FTAG = Var1,
    Prob_marginal_visitantes = Freq
  )

mydf <- mydf %>% 
  rename(
    FTHG = Var1,
    FTAG = Var2,
    ProbabilidadConjunta = Freq
  )

newdf <- merge(mydf,marginal_casa,by="FTHG")
newdf <- merge(newdf,marginal_visitantes,by="FTAG")

#   Obtengo el cociente de dividir las probabilidades conjuntas por el producto de 
#   las probabilidades marginales correspondientes.

newdf <- transform(newdf, Cociente = ProbabilidadConjunta / ( Prob_marginal_casa * Prob_marginal_visitantes))

# Analizo el histograma de los coeficientes
hist(newdf$Cociente, 
     breaks = length(newdf$Cociente), 
     main = "Histograma de Cocientes",
     xlab = "Cocientes",
     ylab = "Frecuencia")

# la barra en 0 está relacionada a la frecuencia de goles de la cual no hubo ocurrencias.
# pero el histograma señala que la muestra tendría una media cercana a 1.


#######    SEGUNDA PARTE   ##########    BOOTSTRAP   #########


#   Para que el cociente sea igual a 1, la probabilidad conjunta debe ser igual al producto
#   de las probabilidad marginales correspondientes, denotando así independencia entre las variables.
#   al sacar la media en el resultado de los cocientes, se obtiene lo siguiente

mean(newdf$Cociente) # 0.8595706

#   Tal valor no es igual a 1, y podría indicar que las variables NO son independientes
#   para confirmar tal hipótesis, se hará uso de Bootstrap que nos servirá para 
#   simular muestreos parecidos, y obtener la media de las medias...


set.seed(123456)
muestra <- newdf$Cociente
Bootstrap_muestras_cocientes <- replicate(50000, mean(sample(muestra, 380, replace = TRUE)))

mean(Bootstrap_muestras_cocientes)

hist(Bootstrap_muestras_cocientes,
     main = "Histograma de medias de cocientes",
     xlab = "Medias de cocientes",
     ylab = "Frecuencia")


# finalmente se tiene que al hacer 380 partidos unas 50000 veces, con remplazos en los valores,
# la media sigue siendo al rededor de 0.85, un salor diferente a 1, por lo tanto
# las variables son dependientes.
