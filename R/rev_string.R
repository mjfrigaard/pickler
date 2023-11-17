#' Reverse strings (function for testing)
#'
#' **This is a function for testing pickler.**
#'
#' @section More info:
#'
#' The original code for this function is from [this StackOverflow post](https://stackoverflow.com/questions/56428360/modify-the-object-without-using-return-in-r-function). I've included it because of it uses `deparse(substitute())` and `assign()` (which makes for interesting tests).
#'
#' @param string string
#'
#' @return reversed string
#'
#' @export rev_string
#'
#' @examples
#' ## NOT RUN
#' # a <- "StackOverFlow"
#' # rev_string(a)
#' # a
# [1] "wolFrevOkcatS"
rev_string <- function(string){

  nm <- deparse(substitute(string))

  components <- unlist(strsplit(string, ""))

  left <- 1
  right <- length(components)

  while (left < right) {
    temp <- components[left]
    components[left] <- components[right]
    components[right] <- temp
    left <- left + 1
    right <- right - 1
  }

  reversed_string <- paste(components, collapse = "")

  assign(nm, reversed_string, envir = .GlobalEnv)

}
