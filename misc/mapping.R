library(tidyverse)
library(rnaturalearth)
library(jardskjalftar)


# Iceland Earthquakes -----------------------------------------------------

iceland <-
  ne_countries(country = "Iceland",
               scale = "large",
               returnclass = "sf")

ggplot(data = iceland) +
  geom_sf() +
  theme_void()

cur_date <- Sys.Date()
cur_year <- lubridate::year(cur_date)
cur_week <- lubridate::week(cur_date)
# Sækjum fyrir síðustu viku
cur_week <- cur_week - 1
recent_earthquakes <- download_jsk_data(year = cur_year, week = cur_week)

ggplot() +
  geom_sf(data = iceland) +
  geom_sf(data = recent_earthquakes) +
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
