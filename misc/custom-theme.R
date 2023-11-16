library(tidyverse)
library(palmerpenguins)
library(ggtext)

# Make base_font an option
# Make removing gridlines an option
# Make removing legend an option
# Make base text size an option based on operating system

theme_dk <- function(base_font = "Inter",
                     hide_gridlines = TRUE,
                     hide_legend = TRUE) {

  update_geom_defaults(geom = "text",
                       aes(family = base_font))

  custom_theme <-
    theme_minimal(base_family = base_font) +
    theme(axis.title = element_blank(),
          axis.text = element_text(color = "grey60",
                                   size = 10),
          plot.title = element_markdown(),
          plot.title.position = "plot",
          legend.position = "none")


  if (hide_gridlines == TRUE) {

    custom_theme <-
      custom_theme +
      theme(panel.grid = element_blank())

  }

  if (hide_legend == FALSE) {

    custom_theme <-
      custom_theme +
      theme(legend.position = "right")

  }



  return(custom_theme)

}



penguins_bill_length_by_island <- penguins |>
  group_by(island) |>
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))

ggplot(data = penguins_bill_length_by_island,
       aes(x = island,
           y = mean_bill_length,
           fill = island,
           label = island)) +
  geom_col() +
  geom_text(vjust = -1) +
  scale_y_continuous(limits = c(0, 50)) +
  theme_dk(base_font = "Inter",
           hide_gridlines = TRUE,
           hide_legend = TRUE)



# OMNI --------------------------------------------------------------------

# https://rfortherestofus.github.io/omni/articles/theme.html

theme_omni <- function(show_grid_lines = FALSE,
                       show_legend = TRUE,
                       base_family = "Calibri") {

  omni_theme <- theme_minimal(base_family = base_family) +
    theme(
      panel.grid.minor = element_blank(),
      axis.ticks = element_blank(),
      axis.title.x = element_text(margin = margin(15, 0, 0, 0)),
      axis.title.y = element_text(margin = margin(0, 15, 0, 0)),
      plot.title = element_markdown(
        margin = margin(0, 0, 15, 0),
        face = "bold",
        size = 12
      ),
      plot.subtitle = element_markdown(size = 12),
      plot.caption = element_text(size = 11, face = "italic")
    )

  # grid lines option
  if (show_grid_lines == FALSE) {
    omni_theme <- omni_theme +
      theme(panel.grid.major = element_blank())
  }

  if (show_legend == FALSE) {
    omni_theme <- omni_theme +
      theme(legend.position = "none")
  }

  # return
  omni_theme
}
