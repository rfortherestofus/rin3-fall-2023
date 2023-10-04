library(tidyverse)
library(gapminder)


# Line Charts -------------------------------------------------------------

data(gapminder)

ggplot(data = gapminder,
       aes(x = year,
           y = lifeExp,
           group = country)) +
  geom_line()


# Reordering Bar Charts ---------------------------------------------------

penguins <- read_csv("data-raw/penguins.csv")

penguins_bill_length_by_island <- penguins |>
  group_by(island) |>
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE)) |>
  mutate(island = fct_reorder(island, mean_bill_length))
  # mutate(island = fct_relevel(island, "Torgersen", "Dream", "Biscoe"))

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


# Font Size ---------------------------------------------------------------

ggplot(data = penguins_bill_length_by_island,
       aes(x = island,
           y = mean_bill_length,
           label = mean_bill_length)) +
  geom_col() +
  geom_text(size = 20 / .pt) +
  theme_minimal(base_size = 20)


# Center Text in Bar Chart ------------------------------------------------

ggplot(data = penguins_bill_length_by_island,
       aes(x = island,
           y = mean_bill_length,
           label = mean_bill_length)) +
  geom_col() +
  geom_text(size = 20 / .pt,
            position=position_stack(vjust=0.5)) +
  theme_minimal(base_size = 20)


# Bar Chart Width ---------------------------------------------------------

ggplot(data = penguins_bill_length_by_island,
       aes(x = island,
           y = mean_bill_length,
           label = mean_bill_length)) +
  geom_col(width = 0.5) +
  geom_text(size = 3,
            position=position_stack(vjust=0.5)) +
  theme_minimal(base_size = 20)


