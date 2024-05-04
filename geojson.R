library(geofi)
library(data.table)
library(sf)
library(tidyverse)
i_am("geojson.R")

# postal code areas
geoms <- get_zipcodes(year = 2024, extend_to_sea_areas = F) %>% 
  st_transform(4326) %>%
  st_simplify(dTolerance = 500) %>% 
  as.data.table() %>% 
  .[, .(postal_code = posti_alue,
        geom)]

geoms %>% 
  as.data.frame() %>% 
  st_sf() %>% 
  st_write("posti.geojson", 
           delete_dsn = T)

# municipalities
geoms <- get_municipalities(year = 2024) %>% 
  st_transform(4326) %>% 
  st_simplify(dTolerance = 1000) %>% 
  as.data.table() %>% 
  .[, .(municipality = name,
        geom)]

geoms %>% 
  as.data.frame() %>% 
  st_sf() %>% 
  st_write("kunta.geojson", 
           delete_dsn = T)
