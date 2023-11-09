#  Recreating this: https://show.rfor.us/cditiy

# Load Packages -----------------------------------------------------------

library(tidyverse)
library(scales)
library(ggchicklet)
library(patchwork)

# Import Data ------------------------------------------------------------

cbem <- read_csv("data-raw/cbem.csv")

cbem_plot <- function(state, age_group_to_filter) {

state_avg <-
  cbem |>
  filter(location == state) |>
  filter(age_group == age_group_to_filter) |>
  filter(group == "All Persons") |>
  pull(percent)

state_annotation <-
  str_glue("CBEM State Rate
         {percent(state_avg, accuracy = 0.1)}")

cbem |>
  filter(location == state) |>
  filter(age_group == age_group_to_filter) |>
  filter(group != "All Persons") |>
  mutate(percent_formatted = percent(percent, accuracy = 0.1)) |>
  mutate(group = fct(group,
                     levels = c("American Indian or Alaska Native",
                                "Asian or Pacific Islander",
                                "Black or African American",
                                "White",
                                "Hispanic or Latino"))) |>
  mutate(x_position = row_number()) |>
  mutate(x_position = case_when(
    group == "Hispanic or Latino" ~ 5.5,
    .default = x_position
  )) |>
  ggplot(aes(x = x_position,
             y = percent,
             label = percent_formatted,
             fill = group)) +
  geom_hline(yintercept = state_avg,
             linetype = "dashed",
             color = "grey60") +
  geom_chicklet() +
  geom_text(vjust = 1.5,
            color = "white") +
  annotate(geom = "text",
           x = 5.5,
           y = state_avg,
           label = state_annotation,
           vjust = -0.5) +
  scale_fill_manual(
    values = c("American Indian or Alaska Native" = "#9CC892",
               "Asian or Pacific Islander" = "#0066cc",
               "Black or African American" = "#477A3E",
               "White" = "#6CC5E9",
               "Hispanic or Latino" = "#ff7400")
  ) +
  theme_void() +
  theme(legend.position = "none")
}



alabama_under_18 <-
  cbem_plot(state = "Alabama",
          age_group_to_filter = "Under 18")

alabama_under_25 <-
  cbem_plot(state = "Alabama",
          age_group_to_filter = "Under 25")

alabama_under_18 + alabama_under_25
