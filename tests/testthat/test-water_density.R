library(units)

test_that("water_density works", {
  temp <- set_units(c(260, 298.15, 375), "K")
  temp_nounit <- drop_units(temp) - 273.15
  expected <- c(997.068360, 997.047013, 957.009710)
  expect_equal(water_density(temp), expected)
  expect_equal(water_density(set_units(temp, "degF")), expected)
  expect_equal(water_density(temp_nounit), expected)
})
