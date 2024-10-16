#'
#' @export
convert_to_si <- function(x, depth, velocity, flow) {
  x |>
    dplyr::mutate(
      "depth"    :=   set_units({{depth}}, "m", mode = "char"),
      "velocity" := set_units({{velocity}}, "m/s", mode = "char"),
      "flow"     := set_units({{flow}}, "m^3/s", mode = "char"),
      .keep = "unused"
    )
}
