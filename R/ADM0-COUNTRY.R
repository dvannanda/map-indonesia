# load libraries

## data-wrangling
library(tidyverse)
library(here)

## map
library(sf)

# get map data
ID_MAP <- 
  here("data",
       "idn_adm_bps_20200401_shp",
       "idn_admbnda_adm0_bps_20200401.shp") %>% 
  st_read()

# get center coordinates
MAP_ADM0_xy <-
  ID_MAP %>% 
  select(ADM0_EN, geometry) %>% 
  # to solve Error: `centroid` must be a data frame column
  group_by(ADM0_EN) %>% 
  # get center coordinates
  mutate(centroid = map(geometry, ~setNames(st_centroid(.x), c("x", "y")))) %>%
  unnest_wider(centroid) %>% 
  ungroup() 

# plot vignette
plot <-
  MAP_ADM0_xy %>% 
  ggplot() +
  geom_sf(aes(geometry = geometry)) +
  theme_bw()

# save the plot
ggsave(here("plot/adm0_country.png"),
       plot = plot,
       width = 7,
       height = 4, 
       device = "png")

