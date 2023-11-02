library(tidyverse)
library(gssr)

gss18 <- gss_get_yr(2018)

data(gss_doc)

gss_doc |>
  view()

# My question: what percentage of black or african american people say they feel lonely?

gss18 |>
  select(id, starts_with("racecen"))

# Lonely

lonely <-
  gss18 |>
  select(id, starts_with("lonely")) |>
  pivot_longer(cols = -id,
               names_to = "lonely_question",
               values_to = "lonely_response") |>
  mutate(lonely_response = as_factor(lonely_response)) |>
  mutate(lonely_question = case_when(
    lonely_question == "lonely1" ~ "Lack companionship",
    lonely_question == "lonely2" ~ "Isolated",
    lonely_question == "lonely3" ~ "Left out"
  ))


# Race

race <-
  gss18 |>
  select(id, starts_with("racecen")) |>
  drop_na() |>
  pivot_longer(cols = -id,
               names_to = "question",
               values_to = "race") |>
  mutate(race = as_factor(race)) |>
  select(-question)


# Join and count ----------------------------------------------------------

lonely |>
  left_join(race,
            join_by("id")) |>
  filter(race == "black or african american") |>
  count(lonely_question, lonely_response) |>
  group_by(lonely_question) |>
  mutate(pct = n / sum(n)) |>
  ungroup()
