#' Pickler logos
#'
#' logo with `'`
#'
#' @return text logo
#'
#' @export
#'
#' @examples
#' logo()
logo <- function() {
  cat("
             d8b          888      888
             Y8P          888      888
                          888      888
    88888b.  888  .d8888b 888  888 888  .d88b.  888d888
    888 '88b 888 d88P'    888 .88P 888 d8P  Y8b 888P'
    888  888 888 888      888888K  888 88888888 888
    888 d88P 888 Y88b.    888 '88b 888 Y8b.     888
    88888P'  888  'Y8888P 888  888 888  'Y8888  888
    888
    888
    888
    ")
}
#' alternate pickler logo 2
#'
#' logo with `\"`
#'
#' @return text logo
#'
#' @export
#'
#' @examples
#' logo2()
logo2 <- function() {
  cat("
             d8b          888      888
             Y8P          888      888
                          888      888
    88888b.  888  .d8888b 888  888 888  .d88b.  888d888
    888 \"88b 888 d88P\"    888 .88P 888 d8P  Y8b 888P\"
    888  888 888 888      888888K  888 88888888 888
    888 d88P 888 Y88b.    888 \"88b 888 Y8b.     888
    88888P\"  888  \"Y8888P 888  888 888  \"Y8888  888
    888
    888
    888
    "
    )
}

