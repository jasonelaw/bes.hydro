#' @export
plot_flow <- function(data, timestamp, depth, velocity, flow, rain, rain.type) {
  pl1 <- data |> plot_parameter({{ timestamp }}, {{ depth }})
  pl2 <- data |> plot_parameter({{ timestamp }}, {{ velocity }})
  pl3 <- data |> plot_parameter({{ timestamp }}, {{ flow }})
  pl4 <- data |> plot_rain({{ timestamp }}, {{ rain }}, type = rain.type)
  layout <- patchwork::plot_layout(nrow = 5, axes = "collect")
  patchwork::wrap_plots(pl1, pl2, pl3, pl4) + layout
}

plot_parameter <- function(x, time, parameter) {
  ret <- ggplot2::ggplot(data = x) +
    ggplot2::geom_line(mapping = aes({{ time }}, {{ parameter }}))
  ret
}

#' @export
plot_rain <- function(x, time, rain, type = c("bar", "cumulative")) {
  type <- match.arg(type)
  ret <- ggplot2::ggplot(data = x)
  geom <- switch(type,
    bar = ggplot2::geom_col(mapping = aes({{ time }}, {{ rain }})),
    cumulative = ggplot2::geom_line(aes({{ time }}, cumsum({{ rain }})))
  )
  ret <- ret + geom
  ret
}

#' @export
plot_dv <- function(data, depth, velocity, ...) {
  ret <- ggplot2::ggplot(data, aes(depth, velocity)) +
    ggplot2::geom_point(...) +
    units::scale_x_units(unit = "ft")
  ret
}

#' @export
label_n <- function(pipe, n = 10, adjust.depth = 0, ...) {
  geom_label(
    aes(
      label = format(manning_n(pipe, after_stat(x) - adjust.depth, after_stat(y)), digits = 2)
    ),
    stat = "smooth",
    n = n,
    ...
  )
}

#' @export
geom_manning_velocity <- function(pipe, n, adjust.depth = 0, ...) {
  if(missing(n)) {
    n <- pipe$n
  }
  geom_function(
    fun = ~ manning_velocity(pipe, after_scale(.) - adjust.depth, n = n),
    ...
  )
}

#' #' @format NULL
#' #' @usage NULL
#' #' @export
#' stat_function_lineribbon <- function(
#'     mapping = NULL, data = NULL,
#'     geom = ggdist:::GeomLineribbon, position = "identity",
#'     ...,
#'     fun,
#'     xlim = NULL,
#'     n = 101,
#'     args = list(),
#'     na.rm = FALSE,
#'     show.legend = NA,
#'     inherit.aes = TRUE) {
#'   if (is.null(data)) {
#'     data <- ensure_nonempty_data
#'   }
#'
#'   ggplot2:::layer(
#'     data = data,
#'     mapping = mapping,
#'     stat = StatFunctionLineRibbon,
#'     geom = geom,
#'     position = position,
#'     show.legend = show.legend,
#'     inherit.aes = inherit.aes,
#'     params = rlang::list2(
#'       fun = fun,
#'       n = n,
#'       args = args,
#'       na.rm = na.rm,
#'       xlim = xlim,
#'       ...
#'     )
#'   )
#' }
#'
#' StatFunctionLineRibbon <- ggplot2::ggproto("StatFunctionLineRibbon", ggplot2::Stat,
#'   default_aes = ggplot2::aes(
#'     y = after_scale(y),
#'     ymin = after_scale(y),
#'     ymax = after_scale(ymax)
#'   ),
#'   compute_group = function(data, scales, fun, uncertain, xlim = NULL, n = 101, args = list()) {
#'     if (is.null(scales$x)) {
#'       range <- xlim %||% c(0, 1)
#'       xseq <- seq(range[1], range[2], length.out = n)
#'       x_trans <- xseq
#'     } else {
#'       range <- xlim %||% scales$x$dimension()
#'       xseq <- seq(range[1], range[2], length.out = n)
#'
#'       if (scales$x$is_discrete()) {
#'         x_trans <- xseq
#'       } else {
#'         # For continuous scales, need to back transform from transformed range
#'         # to original values
#'         x_trans <- scales$x$get_transformation()$inverse(xseq)
#'       }
#'     }
#'
#'     if (inherits(fun, "formula")) fun <- rlang::as_function(fun)
#'     call_fun <- function(fun, args, which_arg, i) {
#'       args <- purrr::modify_at(args, which_arg, \(x) x[i])
#'       rlang::inject(fun(x_trans, !!!args))
#'     }
#'
#'     y_out <- call_fun(fun, args, "uncertain", 2)
#'     ymin_out <- call_fun(fun, args, "uncertain", 1)
#'     ymax_out <- call_fun(fun, args, "uncertain", 3)
#'
#'     if (!is.null(scales$y) && !scales$y$is_discrete()) {
#'       # For continuous scales, need to apply transform
#'       y_out <- scales$y$get_transformation()$transform(y_out)
#'       ymin_out <- scales$y$get_transformation()$transform(ymin_out)
#'       ymax_out <- scales$y$get_transformation()$transform(ymax_out)
#'     }
#'
#'     ggplot2:::data_frame0(x = xseq, y = y_out, ymax = ymin_out, ymin = ymax_out)
#'   }
#' )
#'
#' # Convenience function used by `stat_function()` and
#' # `geom_function()` to convert empty input data into
#' # non-empty input data without touching any non-empty
#' # input data that may have been provided.
#' ensure_nonempty_data <- function(data) {
#'   if (ggplot2:::empty(data)) {
#'     ggplot2:::data_frame0(group = 1, .size = 1)
#'   } else {
#'     data
#'   }
#' }
