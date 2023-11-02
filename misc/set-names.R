library(tidyverse)
library(palmerpenguins)

penguins |>
  select(species, island) |>
  set_names("Species", "Island", "Extra")
