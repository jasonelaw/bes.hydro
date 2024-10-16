library(sf)

test_that("Manning's calculations work - Circular Pipe", {
  pipe <- CircularPipe$new(diameter = 2, s = 0.01, n = 0.02)

  # velocity from https://eng.auburn.edu/~xzf0001/Handbook/Channels.html
  # 1% tolerance is very loose, but most Manning's calculators round severely
  expect_equal(manning_velocity(pipe, 1), 4.6806, tolerance = 0.01)
  expect_equal(manning_flow(pipe, 1), 4.6806 * pi/2, tolerance = 0.01)
})

test_that("Manning's calculations work - Circular Polygon Pipe", {
  pt <- st_buffer(st_point(x = c(0,0)), 1, nQuadSegs = 100)
  pipe <- PolygonPipe$new(shape = pt, s = 0.01, n = 0.02)

  # velocity from https://eng.auburn.edu/~xzf0001/Handbook/Channels.html
  # 1% tolerance is very loose, but most Manning's calculators round severely
  expect_equal(manning_velocity(pipe, 1), 4.6806, tolerance = 0.01)
  expect_equal(manning_flow(pipe, 1), 4.6806 * pi/2, tolerance = 0.01)
})

test_that("Manning's calculations work - Trapezoid Polygon Pipe", {
  pt <- st_buffer(st_point(x = c(0,0)), 1, nQuadSegs = 100)
  pipe <- PolygonPipe$new(
    shape = st_polygon(list(matrix(c(0,1,2,3,0,1,0,0,1,1), ncol = 2))),
    s = 0.01,
    n = 0.02
  )

  # velocity and flow from https://eng.auburn.edu/~xzf0001/Handbook/Channels.html
  # 1% tolerance is very loose, but most Manning's calculators round severely
  expect_equal(manning_velocity(pipe, 0.5), 3.4081, tolerance = 0.01)
  expect_equal(manning_flow(pipe, 0.5), 2.5561, tolerance = 0.01)
})
