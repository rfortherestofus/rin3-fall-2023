library(tidyverse)
library(rnaturalearth)
library(jardskjalftar)


# Iceland Earthquakes -----------------------------------------------------

iceland <-
  ne_countries(
    country = "Iceland",
    scale = "large",
    returnclass = "sf"
  )

ggplot(data = iceland) +
  geom_sf() +
  theme_void()

current_date <- today()
current_year <- year(current_date)
current_week <- week(current_date)

earthquakes_this_week <- download_jsk_data(
  year = current_year,
  week = current_week
)

ggplot() +
  geom_sf(data = iceland,
          fill = "lightblue") +
  geom_sf(data = earthquakes_this_week,
          aes(color = depth)) +
  theme_void()


# Median Income -----------------------------------------------------------

library(tidycensus)
library(tidyverse)
library(sf)

median_income <-
  get_acs(
    state = "MI",
    geography = "county",
    variables = "B19013_001",
    geometry = TRUE,
    year = 2021
  )

median_income_points <-
  median_income |>
  st_centroid()

median_income |>
  ggplot(aes(fill = estimate)) +
  # geom_sf() +
  geom_sf(data = median_income_points,
          color = "red",
          aes(size = estimate)) +
  scale_fill_viridis_c(option = "magma") +
  theme_void()
