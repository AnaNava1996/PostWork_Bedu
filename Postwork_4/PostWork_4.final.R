library(dplyr)
library(boot)

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

#######    SEGUNDA PARTE   ##########    BOOTSTRAP   #########





