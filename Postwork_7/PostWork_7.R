library(mongolite)

did.win <- function(result) {
  if (result == "H") {
    return("gano")
  } else if (result == "A") {
    return("perdio")
  } else {
    return("empato")
  }
}

match.games <-
  "https://raw.githubusercontent.com/beduExpert/Programacion-con-R-Santander/master/Sesion-07/Postwork/data.csv" %>%
  read.csv

client = mongo(collection = "match",
               db = "bedu",
               url = "mongodb+srv://bedu:KzKyZyvIe7nfpH46@hjgr-db.qidup.mongodb.net/bedu?retryWrites=true&w=majority")

if (client$count() > 0) {
  client$drop()
}

client$insert(match.games)

print(paste("Cantidad de documentos en coleecion: ", client$count()))

first <- client$find('{"Date": "2015-12-20", "HomeTeam": "Real Madrid"}')[1,]

if (length(first) > 0) {
  print(paste("Real Madrid ", did.win(first$FTR)))  
} else {
  print("No hay elemento")
}


client$disconnect()