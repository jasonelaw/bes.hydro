#' Calculate water density from pressure
#'
#' Calculates water density according to "The international association for the
#' properties of water and steam." Revised supplementary release on properties of
#' liquid water at 0.1 MPa (2011)
#' @param x water temperature in Celsius
#' @returns a numeric vector, representing the density of water in kg/m^3
#' @export
water_density <- function(x) {
  x <- x + 273.15
  R  <- 461.51805 # [J/kg/K] Gas constant
  p0 <-   0.1e6   # [P]
  Tr <-  10.0     # [K]
  Ta <- 593.0     # [K]
  Tb <- 232.0     # [K]

  a <- c(
     1.93763157E-2,
     0,0,0,
     6.74458446E+3,
    -2.22521604E+5,
     0,
     1.00231247E+8,
    -1.63552118E+9,
     8.32299658E+9
   )
  b <- c(
     0,
     5.78545292E-3,
    -1.53195665E-2,
     3.11337859E-2,
    -4.23546241E-2,
     3.38713507E-2,
    -1.19946761E-2
  )
  p1 <- as.function(polynom::polynomial(a))
  p2 <- as.function(polynom::polynomial(b))

  alpha = Tr / (Ta - x)
  beta  = Tr / (x - Tb)

  rho = 1 / (R * Tr / p0 * (p1(alpha) + p2(beta)))
  rho
}

#'Calculates depth from water and air pressure
#'
#' @param water water pressure in kPa
#' @param air air pressure in kPa
#' @param temp water temperature in °C
#'
#' @returns numeric vector, representing depth in meters
#' @export
water_depth <- function(water, air, temp) {
  water <- water * 1000
  air   <- air * 1000
  g  <-   9.80665 #[m/s^2] Acceleration due to gravity
  rho <- water_density(temp)
  (water - air) / (rho * g)
}
