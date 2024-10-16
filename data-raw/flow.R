
## code to prepare `flow` dataset goes here
library(BESdata)
library(tibble)
library(dplyr)

flow <- BESdata::read.flow(
  location_code = "TGD-24",
  start         = as.Date("2024-01-01"),
  end           = as.Date("2024-03-01")
)
usethis::use_data(flow, overwrite = TRUE)
