library(tidyverse)
library(palmerpenguins)
library(ggtext)

# Make base_font an option
# Make removing gridlines an option
# Make removing legend an option
# Make base text size an option based on operating system

theme_dk <- function() {

  theme_minimal(base_family = "Geist Mono") +
    theme(axis.title = element_blank(),
          axis.text = element_text(color = "grey60",
                                   size = 10),
          plot.title = element_markdown(),
          plot.title.position = "plot",
          panel.grid = element_blank(),
          legend.position = "none")

}

update_geom_defaults(geom = "text",
                     aes(family = "Geist Mono"))

penguins_bill_length_by_island <- penguins |>
  group_by(island) |>
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))

ggplot(data = penguins_bill_length_by_island,
       aes(x = island,
           y = mean_bill_length,
           label = island)) +
  geom_col() +
  geom_text(vjust = -1) +
  scale_y_continuous(limits = c(0, 50)) +
  theme_dk()
