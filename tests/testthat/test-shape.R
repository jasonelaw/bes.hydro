test_that("Circle works", {
  circle <- Circle$new(radius = 1.0)

  expect_s3_class(circle, "Circle")
  expect_equal(circle$radius, 1.0)
  expect_equal(circle$diameter, 2.0)
  expect_equal(circle$perimeter, 2 * pi)
  expect_equal(circle$area, pi)

})

test_that("Circle segments work", {
  circle <- Circle$new(radius = 1.0)

  expect_equal(circle$segment_central_angle(1), pi)
  expect_equal(circle$segment_arc_length(1),    pi)
  expect_equal(circle$segment_area(1),          pi/2)
})
