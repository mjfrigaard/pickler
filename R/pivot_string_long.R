#' Pivot a string into a data.frame (long)
#'
#' @param string a character vector.
#' @param sep separator pattern (set to `"[^[:alnum:]]+"`)
#'
#' @return data.frame with `unique_items` and `term`
#'
#' @export
#'
#' @examples
#' pivot_string_long("A large size in stockings is hard to sell.")
#' pivot_string_long(c("A large size in stockings is hard to sell.", "The first part of the plan needs changing." ))
pivot_string_long <- function(string, sep = "[^[:alnum:]]+") {

  pivot_string <- function(string, sep) {
      string_items <- unlist(strsplit(string, sep))
      string_col <- c(string, rep(NA_character_, times = length(string_items) - 1))
      data.frame(unique_items = string_items, string = string_col)
  }

  if (length(string) > 1) {
    do.call(rbind, lapply(string, pivot_string, sep = sep))
  } else {
    pivot_string(string = string, sep = sep)
  }

}
