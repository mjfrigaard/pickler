#' Read Test File Contents
#'
#' Reads the content of a specified test file and returns it in a structured
#' format.
#'
#' @param test_file A string specifying the path to the test file to be read.
#'                  The function checks if the file exists before attempting to
#'                  read it.
#'
#' @return A data frame with two columns: `test_file` containing the name of
#'         the test file and `test_contents` containing a string of the file's
#'         contents. If the file does not exist, the function returns an
#'         invisible empty result.
#'
#' @export
#'
#' @section More Information:
#' The function consolidates the contents of the test file into a single string,
#' which facilitates further processing, such as pattern matching. It is
#' particularly useful for analyzing test files in the context of automated
#' testing frameworks. `read_test_file()` is primarily used in conjunction with
#' the `extract_` functions.
#'
#' @examples
#' tests <- read_test_file(test_file = system.file("tests", "testthat",
#'                                                 "test-rev_string.R",
#'                                                 package = "pickler"))
#' tests
read_test_file <- function(test_file) {

    if (!file.exists(test_file)) {
        message("No installed testthat tests found in ", test_file)
        return(invisible())
    }

    file_name <- file.path(test_file)

    contents <- unlist(
        lapply(X = file_name, FUN = function(file) {
            paste0(readLines(file), collapse = "")
        })
    )

    data.frame(
        test_file = basename(file_name),
        test_contents = as.character(contents)
    )
}
