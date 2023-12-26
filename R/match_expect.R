#' Match test expectations
#'
#' **match**: 'verb (used with object): to equal or be equal to'
#'
#' @param code_data A parse data data.frame representing parsed R code. The
#'   structure should be what is returned by `utils::getParseData()`, containing
#'   columns `token`,  `text`, `line1`, `line2`, `terminal`, and `text`.
#'
#' @param expectation_pattern The regular expression pattern that identifies
#'   the start of the expectation functions defaults to `'^expect_'`.
#'
#' @return A data frame containing the extracted expectation functions and their
#'   respective line numbers. This data.frame has columns `expectation`,
#'   `line1`, and `line2`. If no expectation functions are found, the function
#'   returns `NULL`.
#'
#' @export
#'
match_expect <- function(code_data, expectation_pattern = '^expect_') {

  # Identify indices where function calls match the expectation pattern
  function_call_indices <- which(grepl("^SYMBOL_FUNCTION_CALL$", code_data[['token']]) &
                                 grepl(expectation_pattern, code_data[['text']]) &
                                 code_data[['terminal']])

  expectation_functions <- code_data[['text']][function_call_indices]

  # Return NULL if no expectation functions are found
  if (length(expectation_functions) == 0) {
    return(NULL)
  }

  # Find line numbers for each expectation function
  line_information <- lapply(function_call_indices, function(current_index) {
    indices_up_to_current <- tail(grep("expr", code_data[['token']][1:current_index]), 2)
    relevant_expr_index <- min(grep(sprintf("%s", code_data[['text']][current_index]),
                                    code_data[['text']][indices_up_to_current]))
    code_data[indices_up_to_current[relevant_expr_index], c("line1", "line2")]
  })

  # Combine line information into a single data frame
  combined_line_information <- do.call("rbind", line_information)

  # Create a data frame with expectation functions and their line numbers
  expectation_info <- data.frame(
    expectation = expectation_functions,
    line1 = combined_line_information$line1,
    line2 = combined_line_information$line2,
    stringsAsFactors = FALSE
  )

  expectation_info

}
