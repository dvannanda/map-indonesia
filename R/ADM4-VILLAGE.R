# load libraries

## data-wrangling
library(tidyverse)
library(here)

## map
library(sf)

# get map data
ID_MAP <- 
  here("data/idn_adm_bps_20200401_shp/idn_admbndp_admALL_bps_itos_20200401.shp") %>% 
  st_read()
  
# combine polygons to ADM4
ID_MAP_ADM4 <-
  ID_MAP %>% 
  select(ADM4_EN, geometry)

# get coordinates
<<<<<<< HEAD
MAP_xy <-
=======
MAP_ADM4_xy <-
>>>>>>> bd169b68f875ac3815ea54e76fc2392aac599516
  ID_MAP_ADM4 %>% 
  mutate(centroid = map(geometry, ~setNames(st_centroid(.x), c("x", "y")))) %>%
  unnest_wider(centroid)