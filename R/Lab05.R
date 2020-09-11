####
## Lab 05 - Rasters and Remote Sensing
## Jordan Molinski
## Date: September 7th
####


#Libraries

# SPDS
# SPDS
library(tidyverse)
library(sf)
library(units)

# Data
library(USAboundaries)
library(rnaturalearth)

# Visualization
library(gghighlight)
library(ggrepel)
library(knitr)
library(kableExtra)
library(readxl)
library(leaflet)
library(raster) # Raster Data handling
library(tidyverse) # Data Manipulation
library(getlandsat) # keyless Landsat data (2013-2017)
library(sf) # Vector data processing
library(mapview) # Rapid Interactive visualization

## AOI Identification
Palo = read_csv('../data/uscities.csv') %>%
  filter(city == "Palo") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  st_transform(5070) %>%
  st_buffer(5000) %>%
  st_bbox() %>%
  st_as_sfc() %>%
  st_as_sf()

mapview(Palo)

Palowgs = Palo %>%
  st_transform(4326)
Palo = st_bbox(Palowgs)


scenes = getlandsat::lsat_scenes()

down = scenes %>%
  filter(min_lat <= Palo$ymin, max_lat >= Palo$ymax,
         min_lon <= Palo$xmin, max_lon >= Palo$xmax,
         as.Date(acquisitionDate) == as.Date("2016-09-26"))

write.csv(down, file = "data/palo-flood-scene.csv", row.names = FALSE)


