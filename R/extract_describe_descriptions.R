#' Extract Describe Descriptions from Test Content
#'
#' This function searches through the test contents for any `describe()`
#' functions, indicative of BDD tests in test frameworks like `testthat`.
#'
#' @param test_content A character string representing the content of a test
#'                     file, containing one or more `describe()` functions
#'
#' @return A character vector containing all the `descriptions` in the
#' `describe()` function calls extracted from the test content. If no
#' `describe()` functions, an empty vector is returned.
#'
#' @section More Information:
#' The function uses regular expressions to identify `describe()` functions.
#'
#' @export
#'
#'
#' @param test_content output from `read_test_file()`
#'
#' @return named string of describe descriptions
#'
#' @export
#'
extract_describe_descriptions <- function(test_content) {

    pattern <- "describe\\s*\\(\\s*(description\\s*=\\s*)?\"(.*?)\""

    matches <- gregexpr(pattern, test_content, perl = TRUE)

    description_matches <- regmatches(test_content, matches)

    description_matches <- unlist(description_matches)

    description_arguments <- sapply(description_matches, function(x) {
        m <- regmatches(x, regexec(pattern, x))
        if (length(m[[1]]) > 2) {
            return(m[[1]][3]) # return the unnamed desc argument
        }
        return(m[[1]][2]) # return the named desc argument
    })

    return(description_arguments)
}
