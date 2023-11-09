library(tidyverse)
library(palmerpenguins)

most_populous_island <-
  penguins |>
  count(island) |>
  slice_max(order_by = n,
            n = 1)

penguins |>
  count(island) |>
  ggplot(aes(x = island,
             y = n)) +
  geom_col() +
  labs(title = "Number of penguins on each island",
       subtitle = str_glue("{most_populous_island$island} has the most penguins ({most_populous_island$n})")) +
  theme_minimal()
