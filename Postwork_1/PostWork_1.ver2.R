library(dplyr)

goles <-
  "https://www.football-data.co.uk/mmz4281/1920/SP1.csv" %>%
  read.csv %>%
  select(casa = FTHG, visitante = FTAG)

# Frecuencia marginal de equipo de casa
frecuencia.marginal.casa <-
  goles %>%
  group_by(casa) %>%
  summarize(frecuencia = n())

# Probabilidad marginal de equipo de casa
prob.marginal.casa <-
  frecuencia.marginal.casa %>%
  ungroup %>%
  mutate(prob.marginal = frecuencia / sum(frecuencia))

# Frecuencia marginal de equipo visitante
frecuencia.marginal.visitante <-
  goles %>%
  group_by(visitante) %>%
  summarize(frecuencia = n()) %>%
  ungroup %>%
  mutate(prob.marginal = frecuencia / sum(frecuencia))

# Probabilidad marginal de equipo visitante
prob.marginal.visitante <-
  frecuencia.marginal.visitante %>%
  ungroup %>%
  mutate(prob.marginal = frecuencia / sum(frecuencia))

# Frecuencia conjunta (casa, visitante)
frecuencia.conjunta <-
  goles %>%
  group_by(casa, visitante) %>%
  summarize(frecuencia = n())

# Probabilidad conjunta (casa, visitante)
prob.conjunta <- frecuencia.conjunta %>%
  ungroup %>%
  mutate(prob.marginal = frecuencia / sum(frecuencia))