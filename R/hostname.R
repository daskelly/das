#' Retrieve the hostname of your machine
#'
#' @export
#' @examples
#' hostname()
hostname <- function() {
  system("hostname", intern = TRUE)
}
