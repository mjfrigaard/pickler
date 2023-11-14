#' Reverse strings (test function)
#'
#'
#' From https://stackoverflow.com/questions/56428360/modify-the-object-without-using-return-in-r-function
#'
#' @param x string
#'
#' @return reversed string
#'
#' @export
#'
#' @examples
#' ## Input
#' a <- "StackOverFlow"
#' rev_string(a)
#' a
rev_string <- function(x){
  nm <- deparse(substitute(x))
  x <- unlist(strsplit(x, ""))

  left_side <- 1
  right_side <- length(x)

  while (left_side < right_side) {
    temp <- x[left_side]
    x[left_side] <- x[right_side]
    x[right_side] <- temp
    left_side <- left_side + 1
    right_side <- right_side - 1
  }
  # browser()
  assign(nm, paste(x, collapse = ""), envir = .GlobalEnv)
}
## Input
a <- "StackOverFlow"
rev_string(a)
a

