library(dplyr)

fetch.football.stats <- function(url) {
  stats <- url %>%
    read.csv %>%
    select(FTHG, FTAG)
  
  return(stats)
}

frecuencia.goles <-
  list(
    "https://www.football-data.co.uk/mmz4281/1718/SP1.csv",
    "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
    "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
  ) %>%
  lapply(fetch.football.stats) %>%
  do.call("rbind", .) %>%
  group_by(FTHG, FTAG) %>%
  summarize(frecuencia = n())


marginal.goles.casa <-
  frecuencia.goles %>%
  group_by(FTHG) %>%
  summarize(frecuencia = sum(frecuencia)) %>%
  ungroup %>%
  mutate(marginal = frecuencia /  sum(frecuencia))


marginal.goles.visitante <-
  frecuencia.goles %>%
  group_by(FTAG) %>%
  summarize(frecuencia = sum(frecuencia)) %>%
  ungroup %>%
  mutate(marginal = frecuencia /  sum(frecuencia))

conjuntas.goles <-
  frecuencia.goles %>%
  ungroup %>%
  mutate(conjunta = frecuencia /  sum(frecuencia))