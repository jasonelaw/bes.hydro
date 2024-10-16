
test_that("CircularPipe works", {
  pipe <- CircularPipe$new(diameter = 2, s = 0.01, n = 0.02)

  expect_s3_class(pipe, "CircularPipe")
  expect_s3_class(pipe, "Circle")

  expect_equal(pipe$diameter, 2.0)
  expect_equal(pipe$radius, 1.0)
  expect_equal(pipe$slope, 0.01)
  expect_equal(pipe$n, 0.02)

  expect_equal(pipe$hydraulic_radius(1), 1/2)
})


