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
  geom_sf(data = iceland) +
  geom_sf(data = earthquakes_this_week) +
  theme_void()


# Median Income -----------------------------------------------------------

library(tidycensus)
library(tidyverse)

median_income <-
  get_acs(
    state = "OR",
    county = "Multnomah",
    geography = "tract",
    variables = "B19013_001",
    geometry = TRUE,
    year = 2021
  )

median_income |>
  ggplot(aes(fill = estimate)) +
  geom_sf() +
  scale_fill_viridis_c(option = "magma") +
  theme_void()
