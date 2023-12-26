#' Extract Expectation Details from a Test File
#'
#' `get_expectations()` reads a specified test file and extracts detailed
#' information about each `expect_` function call.
#'
#' @param test_file A string specifying the path to the test file to be analyzed.
#'
#' @return A data frame with columns `test_file`, `call`, and `string`, where
#'         `test_file` is the name of the test file, `call` is the `expect_`
#'         function call, and `string` identifies if the `expect_` function
#'         creates a snapshot. If no `expect_` calls are found or if the file
#'         does not exist, the function returns an invisible empty result.
#'
#' @section More Information:
#' `get_expectations()` function first checks for the existence of the test file
#'  and then scans for `expect_` function calls. It utilizes regular expressions
#'  for pattern matching and iterates over each expectation to construct a
#'  detailed summary. `get_expectations()` uses `read_test_file()` to read the
#'  contents of the test file and `extract_expects()` to identify `expect_`
#'  function calls. `get_expectations()` returns a data frame containing details
#'  about each expectation call.
#'
#' @seealso \code{\link{read_test_file}} for reading test file contents and
#' \code{\link{extract_expects}} for extracting `expect_` calls from test
#'  content.
#'
#' @export
#'
#' @examples
#' get_expectations(test_file = system.file("tests", "testthat",
#'                                           "test-rev_string.R",
#'                                           package = "pickler"))
get_expectations <- function(test_file) {

    # Read test file
    tests <- read_test_file(test_file)

    # check for test_thats
    if (!grepl(pattern = "expect_", x = tests$test_contents, perl = TRUE)) {
      return(invisible())
    }

    expectations <- extract_expects(tests$test_contents)

    test_files <- rep(x = tests$test_file, times = length(expectations))
    expects <- as.character(expectations)
    snaps <- paste0("snapshot = ", grepl("snapshot", expects))

    # Create a data frame for results
    results <- data.frame(
        test_file = test_files,
        call = expects,
        string = snaps
    )

    return(results)
}

