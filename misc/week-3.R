library(tidyverse)
library(gapminder)


# Line Charts -------------------------------------------------------------

gapminder

ggplot(data = gapminder,
       aes(x = year,
           y = lifeExp)) +
  geom_line()


# Reordering Bar Charts ---------------------------------------------------

penguins <- read_csv("data-raw/penguins.csv")

penguins_bill_length_by_island <- penguins |>
  group_by(island) |>
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE)) |>
  mutate(island = fct_relevel(island, "Torgersen", "Dream", "Biscoe"))

ggplot(data = penguins_bill_length_by_island,
       aes(x = island,
           y = mean_bill_length)) +
  geom_col()


# Wrapping Long Text ------------------------------------------------------

ggplot(data = gapminder,
       aes(x = year,
           y = lifeExp)) +
  geom_line() +
  facet_wrap(vars(country))

gapminder_wrapped <-
  gapminder |>
  mutate(country_wrapped = str_wrap(country, width = 10))

ggplot(data = gapminder_wrapped,
       aes(x = year,
           y = lifeExp)) +
  geom_line() +
  facet_wrap(vars(country_wrapped))
