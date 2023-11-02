library(tidyverse)
library(palmerpenguins)

penguins_2007 <-
  penguins |>
  filter(year == 2007)



penguins_2008 <-
  penguins |>
  filter(year == 2008) |>
  select(-year)

bind_rows(penguins_2007, penguins_2008) |>
  fill(year, .direction = "down") |>
  view()
