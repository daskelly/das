#' Make a color opaque
#'
#' @param color Name or hex code of color
#' @param opacity Opacity (default is out of 255)
#' @param max Maximum value (typically 1 or 255)
#' @keywords color
#' @export
#' @examples
#' opaque('red', 50)
opaque <- function(color, opacity, max = 255) {
  rgb(t(col2rgb(color)), alpha = opacity, max = max)
}
