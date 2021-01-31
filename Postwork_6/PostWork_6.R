library(dplyr)

goles.por.mes <-
  "https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-06/Postwork/match.data.csv" %>%
  read.csv %>%
  mutate(
    date = as.Date(date),
    sumagoles = home.score + away.score,
    month = format(date, "%m"),
    year = format(date, "%Y")
  ) %>%
  group_by(month, year) %>%
  summarize(mean = mean(sumagoles)) %>%
  {
    ts(.$mean, start = min(.$year), end = 2019, frequency = 12)
  }

plot(goles.por.mes, main = "Serie de goles", xlab = "Tiempo", ylab = "Goles")
