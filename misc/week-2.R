library(tidyverse)

penguins <- read_csv(file = "data-raw/penguins.csv")


# NA values ---------------------------------------------------------------

penguins

penguins |>
  mutate(not_actually_na = "NA") |>
  mutate(actually_na = na_if(not_actually_na, "NA")) |>
  mutate(really_not_na = replace_na(actually_na, "NA"))

penguins |>
  drop_na(body_mass_g) |>
  drop_na(sex)

penguins |>
  drop_na(body_mass_g, sex)

penguins |>
  filter(!is.na(bill_length_mm))

penguins |>
  # drop_na(bill_length_mm) |>
  count(species)




# Sequential summaries ----------------------------------------------------



# I'm just curious, so feel free to ignore if this is covered later.
# But, you mentioned that piping sequential summarizes into each other doesn't work to get a single table with multiple columns.
# Is there a way to do that? I didn't know if mutate would be able to handle taking in a tibble from summarize?
# I was guessing there must be some other way to combine tibbles?
# For example, if you were getting the mean bill length from the penguins data,
# but also wanted to get a mean bill length from some other bird dataset,
# and have these in the same table side by side
# (I googled it and it looked like there's a merge() function, but I didn't know if that was the best way to go about it in this case)

penguins_2007 <- penguins |>
  filter(year == 2007)

penguins_2008 <- penguins |>
  filter(year == 2008)

penguins_2007 |>
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE),
            max_bill_depth = max(bill_depth_mm, na.rm = TRUE))


# %in% --------------------------------------------------------------------

penguins |>
  filter(island %in% c("Torgersen", "Biscoe"))

penguins |>
  filter


# Crosstabs ---------------------------------------------------------------

library(janitor)

penguins |>
  tabyl(species, island)

penguins |>
  count(species, island)


# case_when() -------------------------------------------------------------

penguins <- penguins |>
  mutate(weight_category = case_when(
    body_mass_g > 4000 ~ "Over 4000 grams",
    body_mass_g < 4000 & body_mass_g >= 3500 ~ "Between 3500 and 4000 grams",
    body_mass_g < 3500 ~ "Less than 3500 grams",
    is.na(body_mass_g) ~ "Missing data",
    .default = "Exactly 4000 grams"
  ))

penguins |>
  mutate(weight_category = if_else(body_mass_g > 4000, true = "Over 4000 gramts", false = "Under or equal to 4000 grams"))


# Viewing your dataset ----------------------------------------------------

penguins |>
  select(species, island)

penguins |>
  print(n = 100)


# Column names ------------------------------------------------------------

read_csv("data-raw/column-names.csv") |>
  rename(how_cute = `How Cute`)

read_csv("data-raw/column-names.csv") |>
  clean_names() |>

