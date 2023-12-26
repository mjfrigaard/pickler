#' Drop Row Names and Add a Label Column
#'
#' The `add_lbl_col()` function is designed to modify a data frame
#' by removing its row names and appending a new column with a specific label.
#'
#' @param element_name string element to be used as the label for new column.
#' @param parsed_data_list A list of `data.frame`s from which the `element_data`
#' data.frame is selected using `element_name`
#' @param col_name name of the new column to be added to the data.frame,
#' which will contain the value specified by `element_name`.
#'
#' @export
#'
add_lbl_col <- function(element_name, parsed_data_list, col_name, drop_rownames = TRUE) {

  browser()

  element_data <- parsed_data_list[[element_name]]

  num_columns <- ncol(element_data)

  element_data[[col_name]] <- element_name

  if (drop_rownames) {
    rownames(element_data) <- NULL
  }

  reordered_element_data <- element_data[, c(num_columns + 1, 1:num_columns)]

  return(reordered_element_data)

}
