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

# combine polygons to ADM1
ID_MAP_ADM1 <-
  ID_MAP %>% 
  select(ADM1_EN, geometry)
  group_by(ADM1_EN) %>% 
  summarise(geometry = st_union(geometry)) %>% 
  ungroup() %>% 
  # spelling preference 
  mutate(ADM1_EN = recode(ADM1_EN,
                          "Daerah Istimewa Yogyakarta" = "DI Yogyakarta",
                          "Dki Jakarta" = "DKI Jakarta"))

# get coordinates
MAP_ADM1_xy <-
  ID_MAP_ADM1 %>% 
  mutate(centroid = map(geometry, ~setNames(st_centroid(.x), c("x", "y")))) %>%
  unnest_wider(centroid)
