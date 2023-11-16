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
