#' Reverse a String
#'
#' @description Takes a single string as input, reverses the characters in the string,
#' and reassigns the reversed string to the variable in the global environment.
#'
#' @section What it does:
#' `rev_string()` splits an input string into its individual characters,
#' reverses their order, and then collapses them back into a single string. The
#' result is then assigned to the original variable name provided as input in
#' the global environment.
#'
#' @param string A single string that the user wants to reverse.
#'
#' @return `rev_string()` does not return values to the console, because it
#' modifies the input variable directly by assigning the value to the original
#' input object in the global environment (i.e., with
#' `assign(envir =.GlobalEnv)`).  To see the result, print the original
#' variable after calling this function.
#'
#' @export
#'
#'
#' @section How it Works:
#' The function uses several base R functions to achieve the reversal:
#' - `deparse(substitute(string))`: gets the name of the input variable as a string
#' - `strsplit()`: splits the input string into a list of single characters
#' - `rev()`: to reverse the list
#' - `paste(..., collapse = "")`: to combine the characters back into a single string
#' - `assign()`: to reassign the reversed string to the original variable name in the global environment.
#' @examples
#' my_string <- "hello"
#' rev_string(my_string)
#' print(my_string) # outputs "olleh"
rev_string <- function(string) {
  nm <- deparse(substitute(string))
  # split the string into characters
  components <- strsplit(string, "")[[1]]
  # and reverse it
  reversed_components <- rev(components)
  # collapse the reversed characters back into a string
  reversed_string <- paste(reversed_components, collapse = "")
  # assign back to original object
  assign(nm, reversed_string, envir = .GlobalEnv)
}
