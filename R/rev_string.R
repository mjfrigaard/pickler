#' Reverse strings (function for testing)
#'
#' An example function for testing and writing BDD feature, scenarios, and
#' background (original code was adapted from [this StackOverflow post](https://stackoverflow.com/questions/56428360/modify-the-object-without-using-return-in-r-function))
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
