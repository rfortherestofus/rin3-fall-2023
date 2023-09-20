library(tidyverse)

penguins <- read_csv(file = "data-raw/penguins.csv")


# NA values ---------------------------------------------------------------

penguins

penguins |>
  mutate(not_actually_na = "NA")




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

penguins |>
  mutate(weight_category = case_when(
    body_mass_g > 4000 ~ "Over 4000 grams",
    body_mass_g < 4000 & body_mass_g >= 3500 ~ "Between 3500 and 4000 grams",
    body_mass_g < 3500 ~ "Less than 3500 grams"
  ))


# Viewing your dataset ----------------------------------------------------

penguins |>
  print(n = 100)
