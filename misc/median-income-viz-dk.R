library(tidyverse)
library(scales)
library(obtn)

obtn_data_median_income |>
  filter(year == 2023) |>
  select(-year) |>
  rename(amount = value) |>
  mutate(amount_formatted = dollar(amount)) |>
  write_csv("data-raw/oregon-median-income-by-county.csv")

median_income <- read_csv("data-raw/oregon-median-income-by-county.csv")

median_income_yamhill <- median_income |>
  filter(geography %in% c("Yamhill", "Oregon"))

ggplot(data = median_income_yamhill,
       aes(x = amount,
           y = geography,
           label = amount_formatted,
           fill = geography)) +
  geom_col(show.legend = FALSE) +
  geom_text(color = "white",
            hjust = 1.5) +
  scale_fill_manual(values = c(
    "Yamhill" = "darkgreen",
    "Oregon" = "grey"
  )) +
  theme_void()
