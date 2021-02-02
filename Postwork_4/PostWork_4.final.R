library(dplyr)

library(ggplot2)
library(boot)

#######    PRIMERA PARTE   ##########    COCIENTE   #########

#   Se leen los data sets
goles <- select(read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv"),FTHG,FTAG)
goles <- rbind(goles, select(read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv"),FTHG,FTAG))
goles <- rbind(goles, select(read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv"),FTHG,FTAG))

#   Se construye la tabla de probabilidades conjuntas
mytable <- prop.table(table(goles$FTHG,goles$FTAG))

table(goles$FTHG,goles$FTAG)

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

#######    SEGUNDA PARTE   ##########    BOOTSTRAP   #########


#  https://www.statmethods.net/advstats/bootstrapping.html
# pagina 123
#  https://cran.r-project.org/doc/contrib/Seefeld_StatsRBio.pdf


#   Para que el coeficiente sea igual a 1, la probabilidad conjunta debe ser igual a el producto
#   de las probabilidad marginales correspondientes, denotando así independencia entre las variables.
#   al sacar la media en el resultado de los coeficientes, se obtiene lo siguiente

mean(newdf$Cociente) # 0.8595706

#   Tal valor no es igual a 1, y podría indicar que las variables No son independientes
#   para confirmar tal hipótesis, se hará uso de Bootstrap
#   para Simulará muestreos parecidos, y obtener la media de las medias...


set.seed(123456)

funcion_cociente <- funtion(){
  
  
}

boot()




