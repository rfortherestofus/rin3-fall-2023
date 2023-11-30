library(tidyverse)
library(quarto)

oregon_counties <-
  read_csv("https://raw.githubusercontent.com/rfortherestofus/rin3-fall-2023/main/data-raw/oregon-median-income-by-county.csv") |>
  filter(geography != "Oregon") |>
  pull(geography)

reports <- tibble(
  input = "misc/oregon-median-income-report.qmd",
  output_file = str_glue("{oregon_counties}.docx"),
  execute_params = map(oregon_counties, ~list(county = .))
)

reports |>
  pwalk(quarto_render)

