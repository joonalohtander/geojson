library(geofi)
library(data.table)
library(sf)
library(tidyverse)
i_am("geojson.R")

# postal code areas
geoms <- get_zipcodes(year = 2024, extend_to_sea_areas = F) %>% 
  st_transform(4326) %>%
  as.data.table() %>% 
  .[, .(postal_code = posti_alue,
        area = nimi,
        geom)]

geoms %>% 
  st_write("posti.geojson", 
           delete_dsn = T)

# municipalities
geoms <- get_municipalities(year = 2024) %>% 
  st_transform(4326) %>% 
  as.data.table() %>% 
  .[, .(municipality = name,
        municipality_key = kunta,
        geom)]

geoms %>% 
  st_write("kunta.geojson", 
           delete_dsn = T)
