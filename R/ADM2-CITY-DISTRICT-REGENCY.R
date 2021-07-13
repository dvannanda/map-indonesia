# load libraries

## data-wrangling
library(tidyverse)
library(here)

## map
library(sf)

# get map data
ID_MAP <- 
<<<<<<< HEAD
  here("data/idn_adm_bps_20200401_shp/idn_admbnda_adm2_bps_20200401.shp") %>% 
=======
  here("data/idn_adm_bps_20200401_shp/idn_admbndp_admALL_bps_itos_20200401.shp") %>% 
>>>>>>> bd169b68f875ac3815ea54e76fc2392aac599516
  st_read() 
  
# combine polygons to ADM2
ID_MAP_ADM2 <-
  ID_MAP %>% 
  select(ADM2_EN, geometry) %>% 
  group_by(ADM2_EN) %>% 
  summarise(geometry = st_union(geometry)) %>% 
  ungroup()

# get coordinates
<<<<<<< HEAD
MAP_xy <-
=======
MAP_ADM2_xy <-
>>>>>>> bd169b68f875ac3815ea54e76fc2392aac599516
  ID_MAP_ADM2 %>% 
  mutate(centroid = map(geometry, ~setNames(st_centroid(.x), c("x", "y")))) %>%
  unnest_wider(centroid)