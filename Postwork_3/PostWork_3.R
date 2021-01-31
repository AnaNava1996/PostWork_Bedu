library(dplyr)
library(ggplot2)

fetch.football.stats <- function(url) {
  stats <- url %>%
    read.csv %>%
    select(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR) %>%
    mutate(Date = as.Date(Date))
  
  return(stats)
}

football.1720 <-
  list(
    "https://www.football-data.co.uk/mmz4281/1718/SP1.csv",
    "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
    "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
  ) %>%
  lapply(fetch.football.stats) %>%
  do.call("rbind", .)


# Frequency of goals for home team
football.1720 %>%
  group_by(FTHG) %>%
  summarize(frecuencia = n()) %>%
  ggplot() +
  geom_col() +
  aes(x = FTHG, y = frecuencia) +
  labs(x = "Goles en el partido",
       y = "Frecuencia",
       title = "Goles por partidos para equipo de casa")


# Frequency of goals for away team
football.1720 %>%
  group_by(FTAG) %>%
  summarize(frecuencia = n()) %>%
  ggplot() +
  geom_col() +
  aes(x = FTAG, y = frecuencia) +
  labs(x = "Goles en el partido",
       y = "Frecuencia",
       title = "Goles por partidos para equipo visitante")

# Heat Map
football.1720 %>%
  group_by(FTHG, FTAG) %>%
  summarize(frecuencia = n()) %>%
  ggplot() +
  geom_tile() +
  aes(x = FTHG, y = FTAG, fill = frecuencia) +
  labs(x = "Goles de equipo de casa", 
       y = "Goles de equipo visitante",
       title = "Correlaciones de goles por equipo")

