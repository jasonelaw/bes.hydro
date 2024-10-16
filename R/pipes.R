#' Pipe class with circular cross-section
#'
#' @description
#' A `CircularPipe` is created by a diameter and slope. Units passed to the
#' `depth` argument of methods must match the pipe units
#'
#' @param depth depth of flow
#' @export
CircularPipe <- R6::R6Class("CircularPipe",
  inherit = Circle,
  public = list(

    #' @field diameter the pipe diameter
    diameter = NULL,

    #' @field n a default roughness coefficient for the pipe
    n = NULL,

    #' @field slope the pipe slope
    slope = NULL,

    #' @field unit the pipe diameter unit
    unit = NULL,

    #' @description
    #' Create a new `CircularPipe` object
    #' @param diameter the pipe diameter
    #' @param slope the pipe slope
    #' @param n a default Manning roughness coefficient
    #' @return a new `CircularPipe` object
    initialize = function(diameter, slope, n = NA, unit = c("ft", "in", "m")) {
      unit <- match.arg(unit)
      diameter <- as.numeric(diameter)
      super$initialize(diameter / 2)
      self$n <- n
      self$slope <- slope
      self$diameter <- diameter
      self$unit <- unit
    },

    #' @description
    #' Print a CircularPipe object
    print = function() {
      cat(glue::glue(
        "Circular Pipe: ",
        "diameter = {format(self$diameter)}, ",
        "slope = {self$slope}, ",
        "Manning coef = {self$n}"
      ))
    },

    #' @description
    #' Calculate the pipe hydraulic radius
    hydraulic_radius = function(depth) {
      depth <- as.numeric(depth)
      self$wetted_area(depth) / self$wetted_perimeter(depth)
    },

    #' @description
    #' Calculate the pipe wetted perimeter
    wetted_perimeter = function(depth) {
      depth <- as.numeric(depth)
      self$segment_arc_length(depth)
    },

    #' @description
    #' Calculate the pipe wetted area
    wetted_area = function(depth) {
      depth <- as.numeric(depth)
      self$segment_area(depth)
    },

    #' @description
    #' Calculate critical flow. See Chow "Open Channel Hydraulics" Page 81
    #' Equation 4-21
    critical_flow = function(depth) {
      depth <- as.numeric(depth)
      theta <- self$segment_central_angle(depth)
      ret <- (0.251 * (theta - sin(theta)))^1.5 / sin(theta / 2)^0.5 * depth^2.5
      ret
    },

    convert_to_si = function() {
      diameter <- set_units(self$diameter, self$unit, mode = "char")
      CircularPipe$new(
        diameter = set_units(diameter, "m", mode = "char"),
        slope = self$slope,
        n = self$n,
        unit = "m"
      )
    }
  )
)

#' Pipe class with arbitrary polygon cross-section
#'
#' @description
#' A PolygonPipe is created by passing a shape of class `sfg` from the sf
#' package. Units passed to the `depth` argument of methods must match the pipe
#' units
#' @param depth depth of flow
#' @param interp TRUE if desired to interpolate pipe geometry calculations
#' rather than calculate exact values. May speed up calculations for large
#' depth vectors
#' @export
PolygonPipe <- R6::R6Class("PolygonPipe",
  public = list(

    #' @field shape the pipe cross-section
    shape = NULL,

    #' @field n a default roughness coefficient for the pipe
    n = NULL,

    #' @field slope the pipe slope
    slope = NULL,

    #' @field bbox the bounding box of the pipe shape
    bbox = NULL,

    #' @description
    #' Create a new `PolygonPipe` object
    #' @param shape the pipe cross-section, an `sfg` object
    #' @param slope the pipe slope
    #' @param n a default Manning roughness coefficient
    #' @return a new `PolygonPipe` object
    initialize = function(shape, slope, n = NA) {
      stopifnot(inherits(shape, "sfg"))
      self$shape <- shift_upper(shape)
      self$bbox  <- st_bbox(shape)
      self$n     <- n
      self$slope <- slope
    },

    #' @description
    #' Print a PolygonPipe object
    print = function() {
      cat(glue::glue(
        "PolygonPipe: ",
        "shape = {format(self$shape)}, ",
        "slope = {self$slope}, ",
        "Manning coef = {self$n}."
      ))
    },

    #' @description
    #' The pipe wetted area
    #' @return a vector of wetted areas for the given depth
    wetted_area = function(depth, interp = TRUE) {
      nmax <- Inf
      if (isTRUE(interp)) {
        nmax <- 500
      }
      if (is.numeric(interp)) {
        nmax <- interp
      }
      if (length(depth) > nmax) {
        ret <- private$interp(depth, \(x) st_area(private$wetted_geometry(x)), nmax)
      } else {
        pw <- private$wetted_geometry(depth)
        ret <- st_area(pw)
      }
      ret
    },

    #' Calculate pipe wetted perimeter
    #' @return a vector of wetted perimeters for the given depth
    wetted_perimeter = function(depth, interp = TRUE) {
      nmax <- Inf
      if (isTRUE(interp)) {
        nmax <- 500
      }
      if (is.numeric(interp)) {
        nmax <- interp
      }
      if (length(depth) > nmax) {
        calc <- \(x){
          sf::st_perimeter(private$wetted_geometry(x)) -
            sf::st_length(private$water_surface(x))
        }
        private$interp(depth, calc, nmax)
      } else {
        surface <- sf::st_length(private$water_surface(depth_ft))
        perimeter <- sf::st_perimeter(private$wetted_geometry(depth_ft))
        perimeter - surface
      }
    },

    #' @description
    #' Calculate hydraulic radius for the given depth vector
    #' @return a vector of wetted perimeters for the given depth
    hydraulic_radius = function(depth, interp = TRUE) {
      rh <- self$wetted_area(depth_ft, interp = interp) / self$wetted_perimeter(depth_ft, interp = interp)
      return(rh)
    }
  ),
  private = list(
    interp = function(x, fun, n) {
      xseq <- seq(min(x), max(x), length.out = n)
      fx <- splinefun(xseq, fun(xseq))
      fx(x)
    },
    water_surface = function(x) {
      xmin <- self$bbox$xmin
      xmax <- self$bbox$xmax
      lines <- lapply(
        pmin(x, self$bbox$ymax),
        \(x) {
          sf::st_linestring(rbind(c(xmin, x), c(xmax, x)))
        }
      )
      lines <- sf::st_as_sfc(lines)
      lines <- sf::st_intersection(lines, self$shape)
      lines
    },
    depth_mask = function(x) {
      ret <- lapply(x, \(x){
        bb <- self$bbox
        bb["ymin"] <- x
        ret <- sf::st_as_sfc(bb)
        ret[[1]]
      })
      st_as_sfc(ret)
    },
    wetted_geometry = function(depth) {
      depth <- pmin(depth, self$bbox$ymax)
      mask <- private$depth_mask(depth)
      ret <- lapply(mask, \(x) st_difference(self$shape, x))
      st_as_sfc(ret)
    }
  )
)

shift_upper <- function(x) {
  x <- x - sf::st_centroid(x)
  bb <- sf::st_bbox(x)
  x <- x - c(bb$xmin, bb$ymin)
  x
}
