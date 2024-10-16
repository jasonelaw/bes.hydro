Circle <- R6::R6Class("Circle",
  public = list(
    radius = NULL,
    diameter = NULL,
    initialize = function(radius) {
      stopifnot(is.numeric(radius), identical(length(radius), 1L))
      self$radius <- radius
      self$diameter <- radius * 2
    },
    segment_central_angle = function(height) {
      ret <- 2 * acos(1 - (2 * as.numeric(height / self$diameter)))
      return(ret)
    },
    segment_area = function(height) {
      theta <- self$segment_central_angle(height)
      area <- (self$diameter^2 / 8) * (theta - sin(theta))
      return(area)
    },
    segment_arc_length = function(height) {
      self$segment_central_angle(height) * self$diameter / 2
    },
    coordinates = function() {
      (x - 0)^2 + (y - 0)^2 = self$radius^2
    }
  ),
  active = list(
    area = function() {
      pi * self$radius^2
    },
    perimeter = function() {
      pi * self$diameter
    }
  )
)
