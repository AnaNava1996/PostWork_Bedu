# Postwork Sesión 4: dependencia o independencia de variables aleatorias.

#### Tabla de contenidos
- [Objetivo](#objetivo)
- [Requisitos](#requisitos)
- [Instrucciones](#instrucciones)
- [Desarrollo](#desarrollo)
- [Referencias](#referencias)


#### Objetivo

- Investigar la dependencia o independecia de las variables aleatorias X y Y, el número de goles anotados por el equipo de casa y el número de goles anotados por el equipo visitante.

#### Requisitos

- R, RStudio
- Haber trabajado con el Prework y el Work

#### Instrucciones

Ahora investigarás la dependencia o independencia del número de goles anotados por el equipo de casa y el número de goles anotados por el equipo visitante mediante un procedimiento denominado bootstrap, revisa bibliografía en internet para que tengas nociones de este desarrollo. 

1. Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.

2. Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla del punto anterior. Esto para tener una idea de las distribuciones de la cual vienen los cocientes en la tabla anterior. Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla en el punto 1, son iguales a 1 (en tal caso tendríamos independencia de las variables aleatorias X y Y).

## Desarrollo
Se importan las bibliotecas que se vamos a utilizar.

```R
library(dplyr)
library(ggplot2)
```

Se leen los data sets
```R
goles <- select(read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv"),FTHG,FTAG)
goles <- rbind(goles, select(read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv"),FTHG,FTAG))
goles <- rbind(goles, select(read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv"),FTHG,FTAG))
```

Se construye la tabla de probabilidades conjuntas
```R
mytable <- prop.table(table(goles$FTHG,goles$FTAG))
```
<img src="https://github.com/AnaNava1996/PostWork_Bedu/blob/main/Postwork_4/screenshots/probabilidades_conjuntas.png" />

La convierto a un dataframe
```R
mydf <- as.data.frame(mytable)
```

Obtengo las probabilidades marginales
```R
marginal_casa = as.data.frame(prop.table(table(goles$FTHG)))
marginal_visitantes = as.data.frame(prop.table(table(goles$FTAG)))
```

Cambio los nombres para hacer Merge()
```R
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
```

Obtengo el cociente de dividir las probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.

```R
newdf <- transform(newdf, Cociente = ProbabilidadConjunta / ( Prob_marginal_casa * Prob_marginal_visitantes))
```

Analizo el histograma de los coeficientes
```R
hist(newdf$Cociente,breaks = length(newdf$Cociente))
```

La barra en 0 está relacionada a la frecuencia de goles de la cual no hubo ocurrencias. pero el histograma señala que la muestra tendría una media cercana a 1.

Para que el coeficiente sea igual a 1, la probabilidad conjunta debe ser igual al producto de las probabilidad marginales correspondientes, denotando así independencia entre las variables. al sacar la media en el resultado de los coeficientes, se obtiene lo siguiente

```R
mean(newdf$Cociente) # 0.8595706
```

Tal valor no es igual a 1, y podría indicar que las variables NO son independientes para confirmar tal hipótesis, se hará uso de Bootstrap que nos servirá para simular muestreos parecidos, y obtener la media de las medias...

```R
set.seed(123456)
muestra <- newdf$Cociente
Bootstrap_muestras_coeficiente <- replicate(50000, mean(sample(muestra, 380, replace = TRUE)))

mean(Bootstrap_muestras_coeficiente)

hist(Bootstrap_muestras_coeficiente)
```

Finalmente se tiene que al hacer 380 partidos unas 50000 veces, con remplazos en los valores, la media sigue siendo al rededor de 0.85, un salor diferente a 1, por lo tanto las variables son dependientes.


#### Referencias
https://ademos.people.uic.edu/Chapter7.html
