#' Check for string (rlang util)
#'
#' @param x input argument
#'
#' @return invisible is passes, alert if fails
#'
#' @keywords internal
#'
#' @examples
#' bddR:::check_string("test")
#' bddR:::check_string(1)
check_string <- function(x) {
  if (rlang::is_string(x)) {
    invisible()
  } else {
    cli::cli_abort("Argument is not string!")
  }
}
