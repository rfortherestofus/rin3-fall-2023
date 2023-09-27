# Your job is to update the TODOs below to recreate this visualization
# https://show.rfor.us/4MwDlgt2

# This is part of Oregon by the Numbers
# See https://www.tfff.org/oregon-numbers/

library(tidyverse)
library(scales)
library(obtn)

median_income <- read_csv("https://raw.githubusercontent.com/rfortherestofus/rin3-fall-2023/main/data-raw/oregon-median-income-by-county.csv")

median_income_yamhill <- median_income |>
  filter(geography %in% c("Yamhill", "Oregon"))

ggplot(data = median_income_yamhill,
       aes(x = TODO,
           y = TODO,
           label = TODO,
           fill = TODO)) +
  geom_col(show.legend = FALSE) +
  geom_text(color = TODO,
            hjust = TODO) +
  scale_fill_manual(values = c(
    TODO
  )) +
  theme_TODO()
