#' Pivot a string into a long data frame format
#'
#' @description
#' `pivot_string_long()` splits a string (or vector of strings) into its
#' constituent parts based on a specified regex pattern and returns a 'tidy'
#' (long) `data.frame`.
#'
#' @param string A character vector; the string or strings to split.
#' @param sep A regular expression used as the separator to split the string(s)
#'   into items. The default is "[^[:alnum:]]+", which splits based on one or
#'   more non-alphanumeric characters.
#'
#' @return A data frame with two columns: `unique_items`, containing the unique
#'   items extracted from the string(s), and `string`, containing the original
#'   string(s).  Each row represents a unique item from the string(s), with the
#'   original string(s) placed at the first row of each `unique_item`.
#'
#' @section Note:
#' The function handles vectors of strings by applying the splitting and data
#' frame creation process to each element of the vector and then row-binding
#' the individual data frames into a single data frame. The returned `string`
#' column contains the original string and `length(unlist(strsplit(x))) - 1`
#' missing values
#'
#' @section Details:
#' If a single string is provided, the function will split that string into
#' items and return a `data.frame` with each item and the original string. If a
#' vector of strings is provided, the function applies the splitting process
#' to each string in the vector and combines the results into a single
#' `data.frame`.
#'
#' @export
#'
#' @examples
#' pivot_string_long("one-two-three")
#' # include white space
#' pivot_string_long(
#'   c("apple, orange, banana", "cat-dog"),
#'    sep = ",?\\s*-?\\s*")
#' # longer strings
#' pivot_string_long("A large size in stockings is hard to sell.")
#' # larger strings
#' pivot_string_long(c("A large size in stockings is hard to sell.",
#'                     "The first part of the plan needs changing." ))
pivot_string_long <- function(string, sep = "[^[:alnum:]]+") {

  pivot_string <- function(string, sep) {
      string_items <- unlist(strsplit(unname(string), sep))
      string_col <- c(string, rep(NA_character_, times = length(string_items) - 1))
      data.frame(unique_items = string_items, string = string_col)
  }

  if (length(string) > 1) {
    do.call(rbind, lapply(string, pivot_string, sep = sep))
  } else {
    pivot_string(string = string, sep = sep)
  }

}
