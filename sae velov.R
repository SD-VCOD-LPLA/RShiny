install.packages(c("httr","jsonlite"))
library(httr)
library(jsonlite)
base <- 'https://api.jcdecaux.com/vls/v1/stations?contract='
contract <- 'Lyon'
apikey <- '8209583bd2353b8626962dc5841d9ddf4d00db47'

API_URL <- paste0(base, contract, "&apiKey=", apikey)
raw_data <- GET (API_URL)

vlov <- fromJSON(rawToChar(raw_data$content), flatten = TRUE)

install.packages("RMySQL")
library(RMySQL)
  con <- dbConnect(MySQL(),
                   user = 'sql11646649',
                   password = 'YvFSyiQniz',
                   host = 'sql11.freesqldatabase.com',
                   dbname = 'sql11646649')
summary(con)
dbGetInfo(con)
dbWriteTable(con, "Etat", vlov)
dbReadTable(con, "Etat")
