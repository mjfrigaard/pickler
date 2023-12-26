#' Cull Test Calls from Tests
#'
#' Identifies and organizes test cases in R code.
#'
#' @section Technical details:
#' This function takes a syntax tree as input, typically generated
#' by parsing R code, and organizes test cases based on the occurrence of
#' specified tokens. It is designed to work with test cases written using
#' common testing frameworks like `testthat`. The output is a list of nested
#' data frames, each representing a test case block.
#'
#' @param test_data A data frame representing a syntax tree of R code,
#' typically obtained from `utils::getParseData()`
#'
#' @param context_pattern A regular expression as a string, used to match the
#' text content of tokens in the syntax tree that signify the start of a
#' test case. Defaults to `"^context$"` which is a placeholder for actual
#' test function names like `test_that`.
#'
#' @return A list of data frames, each corresponding to a nested test case.
#' The list is named using the first `SYMBOL_FUNCTION_CALL` token text in
#' each nested case. Each data frame in the list contains a subset of the
#' original syntax tree, corresponding to a specific test case.
#'
#'
#'
#' @export
match_tests <- function(test_data, context_pattern = "^context$") {
  row_ids <- rownames(test_data)

  # Find indices of context function calls
  context_indices <- which(row_ids %in% test_data$parent[grepl("^SYMBOL_FUNCTION_CALL$", test_data$token) & grepl(context_pattern, test_data$text) & test_data$terminal])

  # Get indices of all rows that are children of the context
  child_indices <- which(row_ids %in% test_data$parent[context_indices])

  # Create a vector indicating the start of new context groups
  context_group_starts <- rep(0, nrow(test_data))
  context_group_starts[child_indices] <- 1

  # Cumulative sum to create group identifiers
  context_group_ids <- cumsum(context_group_starts)

  # Split the data by context groups
  grouped_test_data <- split(test_data, context_group_ids)

  # Assign names to each group based on their context
  names(grouped_test_data) <- sapply(grouped_test_data, function(single_test_data) {
    context_call_text <- single_test_data$text[grep("^SYMBOL_FUNCTION_CALL$", single_test_data$token)[1]]
    context_description <- eval(parse(text = single_test_data$text[grepl("^STR_CONST$", single_test_data$token)][1], keep.source = TRUE))

    if (context_call_text %in% c("test_that", "describe", "it")) {
      context_description <- sprintf("%s: %s", context_call_text, context_description)
    }
    context_description
  }, simplify = TRUE, USE.NAMES = TRUE)

  # Refine each group to include only relevant test data
  refined_grouped_test_data <- lapply(grouped_test_data, function(single_group_data) {
    relevant_index <- utils::tail(utils::head(which(single_group_data$parent == 0), 2), 1)
    if (length(relevant_index) == 0) {
      relevant_index <- 1
    }
    single_group_data[relevant_index:nrow(single_group_data), ]
  })

  refined_grouped_test_data
}
