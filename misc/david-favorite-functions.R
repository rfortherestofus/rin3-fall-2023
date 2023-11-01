
# Load Packages -----------------------------------------------------------

library(tidyverse)
library(tidycensus)
library(janitor)
library(readxl)
library(scales)

# Tidycensus --------------------------------------------------------------

get_acs(
  geography = "state",
  variables = c(
    "B03002_003",
    "B03002_004",
    "B03002_005",
    "B03002_006",
    "B03002_007",
    "B03002_008",
    "B03002_009",
    "B03002_012"
  )
)

get_acs_race_ethnicity <- function() {

  race_ethnicity_data <-
    get_acs(
      geography = "state",
      variables = c(
        "White" = "B03002_003",
        "Black/African American" = "B03002_004",
        "American Indian/Alaska Native" = "B03002_005",
        "Asian" = "B03002_006",
        "Native Hawaiian/Pacific Islander" = "B03002_007",
        "Other race" = "B03002_008",
        "Multi-Race" = "B03002_009",
        "Hispanic/Latino" = "B03002_012"
      )
    )

  race_ethnicity_data

}

get_acs_race_ethnicity <- function(clean_variable_names = FALSE) {

  race_ethnicity_data <-
    get_acs(
      geography = "state",
      variables = c(
        "White" = "B03002_003",
        "Black/African American" = "B03002_004",
        "American Indian/Alaska Native" = "B03002_005",
        "Asian" = "B03002_006",
        "Native Hawaiian/Pacific Islander" = "B03002_007",
        "Other race" = "B03002_008",
        "Multi-Race" = "B03002_009",
        "Hispanic/Latino" = "B03002_012"
      )
    )

  if (clean_variable_names == TRUE) {
    race_ethnicity_data <- clean_names(race_ethnicity_data)

  }

  race_ethnicity_data

}


# Read Multiple Excel Files -----------------------------------------------

import_median_income_data <- function(data_year) {

  read_excel(str_glue("data-raw/{data_year}-obtn-by-county.xlsx"),
             sheet = "Median Income") |>
    clean_names() |>
    mutate(geography = str_trim(geography)) |>
    set_names(c("geography", "value")) |>
    mutate(amount_formatted = dollar(value)) |>
    mutate(year = data_year) |>
    drop_na(geography) |>
    rename(amount = value) |>
    select(year, geography, amount, amount_formatted)

}

import_median_income_data(2023)


# Plot --------------------------------------------------------------------

median_income <- import_median_income_data(2023)

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


