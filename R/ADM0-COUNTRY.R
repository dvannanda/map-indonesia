# load libraries

## data-wrangling
library(tidyverse)
library(here)

## map
library(sf)

# get map data
ID_MAP <- 
  here("data/idn_adm_bps_20200401_shp/idn_admbnda_adm2_bps_20200401.shp") %>% 
  st_read()

# combine polygons to ADM2
ID_MAP_ADM0 <-
  ID_MAP %>% 
  select(ADM0_EN, geometry) %>% 
  group_by(ADM0_EN) %>% 
  summarise(geometry = st_union(geometry)) %>% 
  ungroup()

# get coordinates
MAP_xy <-
  ID_MAP_ADM0 %>% 
  mutate(centroid = map(geometry, ~setNames(st_centroid(.x), c("x", "y")))) %>%
  unnest_wider(centroid)

# save st object
st_write(MAP_xy, here("data/adm0.shp"))


