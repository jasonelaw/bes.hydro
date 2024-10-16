#' Calculate velocity estimated by Manning's equation
#'
#' Calculate flow or velocity using velocity estimated by Manning's equation and pipe
#' geometry. If missing, will use the default roughness defined for the pipe,
#' if available.
#' @param pipe a pipe geometry object
#' @param depth depth measurements
#' @param n Manning's roughness coefficient
#' @param unit the unit of measure for depth measurements, defaults to feet.
#' @name manning
NULL

#' @describeIn manning
#' @export
manning_velocity <- function(pipe, depth, n, unit = c("ft", "m")) {
  unit <- match.arg(unit)
  stopifnot(identical(unit, pipe$unit))
  if(missing(n)) {
    n <- pipe$n
  }
  rh <- pipe$hydraulic_radius(depth)
  slope <- pipe$slope
  k <- if(identical(unit, "ft")) (1/.3048)^(1/3) else 1
  ret <- (k / n) * rh^(2 / 3) * sqrt(slope)
  ret
}

manning_n <- function(pipe, depth, velocity, unit = c("ft", "m")) {
  unit <- match.arg(unit)
  rh <- pipe$hydraulic_radius(depth)
  slope <- pipe$slope
  k <- if(identical(unit, "ft")) (1/.3048)^(1/3) else 1
  ret <- (k / velocity) * rh^(2 / 3) * sqrt(slope)
  ret
}

#' @describeIn manning
#' @export
manning_flow <- function(pipe, depth, n, unit = c("ft", "m")) {
  unit <- match.arg(unit)
  if(missing(n)) {
    n <- pipe$n
  }
  v <- manning_velocity(pipe, depth, n, unit = unit)
  area <- pipe$wetted_area(depth)
  ret <- v * area
  ret
}

add_pipe_attr <- function(x, depth, pipe) {
  x |>
    mutate(
      r_h   = pipe$hydraulic_radius(pmin(as.numeric({{ depth }}), pipe$diameter)),
      slope = pipe$slope,
      n     = pipe$n
    )
}

nice_sequence <- \(center, halfwidth, steps = 10){
  from <- center
  to <- center + halfwidth
  x <- seq(0.1, 2, length.out = steps)
  ret <- exp(x)
  rng <- range(ret)
  ret <- (ret - rng[1]) / diff(rng)
  ret <- ret * c(to - from)
  c(-rev(ret[-1]), ret) + center
}

fit_manning_coefficient <- function(x, pipe) {
  mod <- mgcv::gam(
    formula = I(as.numeric(velocity)) ~ s(I(r_h^(2/3) * slope^(1/2))),
    data = x
  )
  broom::augment(mod, x) |>
    mutate(
      .fitted_n = (r_h^(2/3) * slope^(1/2)) / .fitted,
      .fitted = set_units(.fitted, "m/s")
    )
}

#' Wong, Tommy SW. "Discussion of" Explicit solutions of the Manning equation
#' for partially filled circular pipes"(1)." Canadian Journal of Civil
#' Engineering 33.3 (2006): 349-353.
var_n_factor <- function(theta) {
  1 + 0.005 * theta^1.2 * (2 * pi - theta)^2.2
}
