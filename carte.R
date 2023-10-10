#carte interractive
library(tidygeocoder)
library(leaflet)
leaflet() %>% addTiles()

library(cowplot) 
library(mapview) 
library(sf)
library(tidyverse)
library(tmap)
install.packages(c("httr","jsonlite","DBI"))
library(DBI)
library(tidyr)

base <- 'https://api.jcdecaux.com/vls/v1/stations?contract=Lyon&apiKey=b84356facb5f194cb1281e653610562177b15c29'
data <-get(base)
data= fromJSON(rawToChar(data$content))

Lyon<-data.frame(lon=4.82965,lat=45.75917) %>% 
  st_as_sf(coords = c("lon", "lat")) %>% 
  st_set_crs(4326)

mapview(Lyon)


read.delim(base)
