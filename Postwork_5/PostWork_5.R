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
    )
  
  return(stats)
}

goles <-
  list(
    "https://www.football-data.co.uk/mmz4281/1718/SP1.csv",
    "https://www.football-data.co.uk/mmz4281/1819/SP1.csv",
    "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
  ) %>%
  lapply(fetch.football.stats) %>%
  do.call("rbind", .)

write.csv(goles, "./soccer.csv", row.names = FALSE)


