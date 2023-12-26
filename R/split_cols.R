#' Split a column into multiple columns based on a pattern
#'
#' @description
#' `split_cols()` splits a specific column into multiple columns based on a
#' provided pattern (new columns can have a specified prefix).
#'
#' @param data A `data.frame` or `tibble` in with a column to split.
#' @param col name of the character column to split
#' @param pattern regular expression used to define the split points in the
#' column's values. The default is "[^[:alnum:]]+", which matches one or more
#' non-alphanumeric characters.
#' @param col_prefix prefix to use for the columns created from the split. The
#' default prefix is `col_`.
#'
#' @return A data frame with the original columns and the new columns created
#' from splitting the specified column.
#'
#' @section Details:
#' The function verifies the input types and the presence of the column to be
#' split in the data frame. It then splits the specified column into a list of
#' vectors, finds the maximum number of elements from these vectors, and pads
#' shorter vectors with `NA` to align all vectors to the same length. These
#' vectors are then combined into new columns and appended to the original
#' data frame.
#'
#' @section Checks:
#' The function will stop and throw an error if any of the input conditions are
#' not met, ensuring that the input `data.frame`, column name, pattern, and
#' column prefix are all correctly specified and formatted before proceeding.
#'
#' @export
#'
#' @examples
#' d <- data.frame(value = c(29L, 91L, 39L, 28L, 12L),
#'                 name = c("John", "John, Jacob",
#'                          "John, Jacob, Jingleheimer",
#'                          "Jingleheimer, Schmidt",
#'                          "JJJ, Schmidt"))
#' # no prefix
#' split_cols(data = d, col = "name")
#' # with prefix
#' split_cols(data = d, col = "name", col_prefix = "names")
split_cols <- function(data, col, pattern = "[^[:alnum:]]+", col_prefix = "col"){

  # verify inputs
  stopifnot(exprs = {
    "data must be a data.frame or tibble" = is.data.frame(data)
    "'col' must be a character" = is.character(pattern)
    "'col' must be a column in 'data'" = col %in% names(data)
    "'pattern' must be a character" = is.character(pattern)
    "col_prefix must be a character" = is.character(col_prefix)
    })

  in_rgx <- pattern
  in_data <- as.data.frame(data)

  in_col <- as.character(col)

  split_data <- strsplit(in_data[[in_col]], in_rgx)

  max_length <- max(sapply(split_data, length))

  padded_split_data <- lapply(split_data, function(x) {
    c(x, rep(NA, max_length - length(x)))
  })

  out_cols <- do.call(rbind, padded_split_data)

  colnames(out_cols) <- paste(col_prefix, seq_len(max_length), sep = "_")

  out_cols_df <- as.data.frame(out_cols)

  out_data <- cbind(in_data, out_cols_df)

  return(out_data)
}
