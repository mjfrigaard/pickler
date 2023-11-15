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

#' Pivot a term (sentence) into a data.frame (long)
#'
#' @param term string, term, sentence, etc.
#' @param sep separator pattern (set to `"[^[:alnum:]]+"`)
#'
#' @return data.frame with `unique_items` and `term`
#'
#' @export
#'
#' @examples
#' pivot_term_long("A large size in stockings is hard to sell.")
#' pivot_term_long(c("A large size in stockings is hard to sell.", "The first part of the plan needs changing." ))
pivot_term_long <- function(term, sep = "[^[:alnum:]]+") {

  pivot_term <- function(term, sep) {
      term_items <- unlist(strsplit(term, sep))
      term_col <- c(term, rep(NA_character_, times = length(term_items) - 1))
      data.frame(unique_items = term_items, term = term_col)
  }

  if (length(term) > 1) {
    do.call(rbind, lapply(term, pivot_term, sep = sep))
  } else {
    pivot_term(term = term, sep = sep)
  }

}

#' Process names and text in dataset
#'
#' @param .data `data.frame`, `tibble`, or `data.table`
#' @param fct convert factors to lowercase? If `TRUE`, factors are returned as
#'     character
#'
#' @return processed dataset
#'
#' @export
#'
#' @examples
#' str(process_text(datasets::CO2))
#' str(process_text(datasets::CO2, fct = TRUE))
process_text <- function(raw_data, fct = FALSE) {
  # convert to data.frame
  raw_data <- as.data.frame(raw_data)
  # clean names (make syntactically valid names in base R)
  nms <- make.names(names(raw_data), unique = TRUE)
  # remove separators
  us_nms <- gsub(pattern = "[^[:alnum:]]+", replacement = "_", x = nms)
  # lowercase
  lc_nms <- make.names(tolower(us_nms), unique = TRUE)
  # remove trailing _
  clean_nmns <- gsub(pattern = "_$", replacement = "", x = lc_nms)
  names(raw_data) <- clean_nmns

  # lowercase (convert all character columns to lowercase)
  lowercase <- raw_data
  char_cols <- sapply(lowercase, is.character)
  lowercase[char_cols] <- lapply(lowercase[char_cols], tolower)

  if (fct) {
    # lowercase (convert all factor columns to lowercase)
    fct_cols <- sapply(lowercase, is.factor)
    lowercase[fct_cols] <- lapply(lowercase[fct_cols], tolower)
  }


  # remove carriage return (replace all carriage returns with space in character columns)
  processed <- lowercase
  processed[char_cols] <- lapply(processed[char_cols], function(column) {
    gsub(pattern = "\\r|\\r\\n|\\n", replacement = " ", x = column)
  })

  return(processed)
}

#' Separate column into multiple columns
#'
#' @param data `data.frame` or `tibble`
#' @param col column to separate
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
#' sep_cols_mult(data = d, col = "name", col_prefix = "names")
sep_cols_mult <- function(data, col, pattern = "[^[:alnum:]]+", col_prefix = "col"){
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
