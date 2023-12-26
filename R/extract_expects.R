#' Extract and Combine Expectations from Parsed Test Blocks
#'
#' **extract**: 'verb as in physically remove, draw out'
#'
#' @param test_code_list A list of parsed test code blocks. Each element of the
#'  list is expected to be a `data.frame` with a structure identical to what is
#'  returned by `utils::getParseData()`. These data frames represent parsed R
#'  code, corresponding to test blocks in the test files.
#'
#' @return `extract_expects()` returns a `data.frame` that consolidates the
#' expectations extracted from each test file in the `tests/testthat/` folder.
#' The `data.frame` contains merged results from the individual tests, with
#' additional columns for labeling and structuring the data. If no expectations
#'are found in any of the blocks, the function returns `NULL`.
#'
#' @export
#'
extract_expects <- function(test_code_list) {

  expectations_list <- lapply(test_code_list, match_expect)

  non_null_expectations_list <- expectations_list[!sapply(X = expectations_list, FUN = is.null)]

  # Return NULL if there are no non-null expectations
  if (length(non_null_expectations_list) == 0) {
    return(NULL)
  }

  # Remove row names and add a label column to each element in the list
  labeled_expectations_list <- lapply(X = names(non_null_expectations_list),
                                      FUN = function(test_name) {
                                        add_lbl_col(
                                          element_name = test_name,
                                          parsed_data_list = non_null_expectations_list,
                                          col_name = "test")
  })

  # Combine all labeled expectations into a single data frame
  combined_and_labeled_expectations <- do.call("rbind", labeled_expectations_list)

  combined_and_labeled_expectations
}

