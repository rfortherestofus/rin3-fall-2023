library(tidyverse)
library(geomtextpath)

# Load data
penguins <- read_csv("https://raw.githubusercontent.com/rfortherestofus/rin3-fall-2023/main/data-raw/penguins.csv")

# Create a scatter plot and add geomtextpath to show a smooth best fit line with species name
ggplot(data = penguins, aes(x = bill_length_mm,
                            y = flipper_length_mm,
                            group = species,
                            color = species)) +
  geom_point() +
  geomtextpath::geom_labelpath(aes(label = paste0(species)),
                               stat = "smooth",
                               alpha = 0.8) +
  theme(legend.position="none")


# Gapminder ---------------------------------------------------------------

library(tidyverse)
library(gapminder)

gapminder |>
  filter(continent == "Asia") |>
  ggplot(aes(x = year,
             y = lifeExp,
             label = country)) +
  geom_textline() +
  # geom_line() +
  facet_wrap(~country)
