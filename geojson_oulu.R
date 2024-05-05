library(geofi)
library(data.table)
library(sf)
library(tidyverse)
library(here)
i_am("geojson.R")

# postal code areas
geoms <- get_zipcodes(year = 2024, extend_to_sea_areas = F) %>% 
  st_transform(4326) %>%
  as.data.table() %>% 
  .[, .(postal_code = posti_alue,
        area = nimi,
        geom,
        kuntanro)] %>% 
  .[kuntanro == 564]

geoms %>% 
  st_write(here("./oulu/posti.geojson"), 
           delete_dsn = T)
