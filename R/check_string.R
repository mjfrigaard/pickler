#' Check for string (rlang util)
#'
#' @param x input argument
#'
#' @return `TRUE` is passes, alert + `FALSE` if fails
#'
#' @keywords internal
#'
#' @examples
#' pickler:::check_string("test")
#' pickler:::check_string(1)
check_string <- function(x) {
  if (rlang::is_string(x)) {
    TRUE
  } else {
    cli::cli_alert_danger("Argument is not string!")
    FALSE
  }
}
