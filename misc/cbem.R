#  Recreating this: https://show.rfor.us/cditiy

# Load Packages -----------------------------------------------------------

library(tidyverse)
library(scales)
library(ggchicklet)
library(patchwork)

# Import Data ------------------------------------------------------------

cbem <- read_csv("data-raw/cbem.csv")
