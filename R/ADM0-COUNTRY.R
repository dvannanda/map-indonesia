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

# combine polygons to ADM2
ID_MAP_ADM0 <-
  ID_MAP %>% 
  select(ADM0_EN, geometry) %>% 
  group_by(ADM0_EN) %>% 
  summarise(geometry = st_union(geometry)) %>% 
  ungroup()

# get coordinates
MAP_ADM0_xy <-
  ID_MAP_ADM0 %>% 
  mutate(centroid = map(geometry, ~setNames(st_centroid(.x), c("x", "y")))) %>%
  unnest_wider(centroid)


