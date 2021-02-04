library(dplyr)
library(fbRanks)

fetch.football.stats <- function(url) {
  stats <- url %>%
    read.csv %>%
    
    select(
      date = Date,
      home.team = HomeTeam,
      away.team = AwayTeam,
      home.score = FTHG,
      away.score = FTAG,
    ) %>%
    
    mutate(date = as.Date(date,"%d/%m/%y"))
  
  return(stats)
}

SmallData <-
  list(
    "https://www.football-data.co.uk/mmz4281/1718/SP1.csv",
    "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
    "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
  ) %>%
  lapply(fetch.football.stats) %>%
  do.call("rbind", .)

write.csv(SmallData, "./soccer.csv", row.names = FALSE)

listasoccer <- create.fbRanks.dataframes("soccer.csv")

head(listasoccer$scores)
head(listasoccer$teams)

anotaciones <- listasoccer$scores
equipos <- listasoccer$teams

head(anotaciones)
head(equipos)

fecha<-unique(anotaciones$date)
n<-length(fecha)
head(fecha)
tail(fecha)
n
fecha[331]

ranking<-rank.teams(anotaciones,equipos, max.date=max(fecha), min.date =min(fecha))
head(rankin)

predict(ranking, date = fecha[n])
