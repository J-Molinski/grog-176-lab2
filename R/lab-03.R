####
## Lab 03
## Jordan Molinski
## Date: August 20
####

library(tidyverse)
library(sf)
library(units)

region = data.frame(region = state.region,
                    state_name = state.name)


south = USAboundaries::us_states() %>%
  right_join(region, by = 'state_name') %>%
  filter(region == "South")

plot(south['awater'])

cities = readr::read_csv("data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  st_filter(south, .predicate = st_intersects)

plot(south$geometry)
plot(cities$geometry, add= TRUE, pch = 16, cex = .1)

south_c = st_combine(south) %>%
  st_cast("MULTILINESTRING")

south_c = st_transform(south_c, 5070)
cities = st_transform(cities, 5070)

cities = cities %>%
  mutate(dist_state = st_distance(cities, south_c))

ggplot()

install.packages("ggrepel")
install.packages("gghighlight")



