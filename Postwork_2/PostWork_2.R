library(dplyr)

fetch.football.stats <- function(url) {
  stats <- url %>%
    read.csv %>%
    select(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR) %>%
    mutate(Date = as.Date(Date))
  
  return(stats)
}

describe.football.stats <- function(stats) {
  str(stats)
  head(stats)
  summary(stats)
}

# Fetch and describe Football Stats from 2017 to 2018
football.1718 <-
  fetch.football.stats("https://www.football-data.co.uk/mmz4281/1718/SP1.csv")
describe.football.stats(football.1718)

# Fetch and describe Football Stats from 2018 to 2019
football.1819 <-
  fetch.football.stats("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
describe.football.stats(football.1819)

# Fetch and describe Football Stats from 2019 to 2020
football.1920 <-
  fetch.football.stats("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")
describe.football.stats(football.1920)

# Join and describe Football Stats from 2017 to 2020
football.1720 <- rbind(football.1718, football.1819, football.1920)
describe.football.stats(football.1720)
