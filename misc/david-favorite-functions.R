
# Load Packages -----------------------------------------------------------

library(tidyverse)
library(tidycensus)
library(janitor)
library(readxl)
library(scales)

# Tidycensus --------------------------------------------------------------

race_ethnicity_data <-
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

race_ethnicity_2 <-
  get_acs_race_ethnicity()


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

race_ethnicity_3 <-
  get_acs_race_ethnicity(clean_variable_names = TRUE)


# Read Multiple Excel Files -----------------------------------------------

data_year <- 2023




import_median_income_data <- function(data_year) {

  read_excel(path = str_glue("data-raw/{data_year}-obtn-by-county.xlsx"),
             sheet = "Median Income") |>
    clean_names() |>
    mutate(geography = str_trim(geography)) |>
    set_names(c("geography", "amount")) |>
    mutate(amount_formatted = dollar(amount)) |>
    mutate(year = data_year)|>
    drop_na(geography) |>
    select(year, geography, amount, amount_formatted)

}

median_income_data_2022 <- import_median_income_data(2022)
median_income_data_2021 <- import_median_income_data(2021)

bind_rows(median_income_data_2021, median_income_data_2022) |>
  view()

obtn_years <- seq(from = 2019,
                  to = 2023,
                  by = 1)

map_df(.x = obtn_years,
       .f = import_median_income_data) |>
  view()


# Plot --------------------------------------------------------------------

median_income <- import_median_income_data(2023)

median_income_plot <- function(county) {

  median_income <- import_median_income_data(2023)

  median_income_county_and_oregon <- median_income |>
    filter(geography %in% c(county, "Oregon")) |>
    mutate(geography = factor(geography,
                              levels = c("Oregon", county)))

  # return(median_income_county_and_oregon)

  ggplot(data = median_income_county_and_oregon,
         aes(x = amount,
             y = geography,
             label = amount_formatted,
             fill = geography)) +
    geom_col(show.legend = FALSE) +
    geom_text(color = "white",
              hjust = 1.5) +
    scale_fill_manual(values = c("grey", "darkgreen")) +
    theme_void()


}

median_income_plot(county = "Baker")

