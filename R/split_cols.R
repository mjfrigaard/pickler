#' Split column into multiple columns
#'
#' @param data a `data.frame` or `tibble`
#' @param col column to split
#' @param pattern regular expression pattern passed to `strsplit()`
#' @param col_prefix prefix for new columns
#'
#' @return data.frame with split columns
#'
#' @export
#'
#' @examples
#' d <- data.frame(value = c(29L, 91L, 39L, 28L, 12L),
#'                 name = c("John", "John, Jacob",
#'                          "John, Jacob, Jingleheimer",
#'                          "Jingleheimer, Schmidt",
#'                          "JJJ, Schmidt"))
#' split_cols(data = d, col = "name", col_prefix = "names")
split_cols <- function(data, col, pattern = "[^[:alnum:]]+", col_prefix = "col"){

  # verify inputs
  stopifnot("data must be a data.frame or tibble" = is.data.frame(data))
  stopifnot("'col' must be a character" = is.character(pattern))
  stopifnot("'col' must be a column in 'data'" = col %in% names(data))
  stopifnot("'pattern' must be a character" = is.character(pattern))
  stopifnot("col_prefix must be a character" = is.character(col_prefix))

  # use regex for pattern, or whatever is provided
  in_rgx <- pattern
  # ensure data is a data.frame
  in_data <- as.data.frame(data)
  # ensure col is a character vector
  in_col <- as.character(col)

  # split columns into a list of vectors
  split_data <- strsplit(in_data[[in_col]], in_rgx)

  # find the maximum number of elements in any split
  max_length <- max(sapply(split_data, length))

  # pad the vectors in the list with NAs to have uniform length
  padded_split_data <- lapply(split_data, function(x) {
    c(x, rep(NA, max_length - length(x)))
  })

  # convert the list of vectors to a matrix
  out_cols <- do.call(rbind, padded_split_data)

  # assign column names
  colnames(out_cols) <- paste(col_prefix, seq_len(max_length), sep = "_")

  # convert to data.frame
  out_cols_df <- as.data.frame(out_cols, stringsAsFactors = FALSE)

  # bind cols together
  out_data <- cbind(in_data, out_cols_df)

  # return the final data frame
  return(out_data)
}
