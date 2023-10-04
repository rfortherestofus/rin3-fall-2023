library(tidyverse)
library(gapminder)

gapminder |>
  filter(country == "Afghanistan") |>
  ggplot(aes(x = year,
           y = lifeExp)) +
  geom_line()
