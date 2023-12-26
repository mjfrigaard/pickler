#' Extract `desc` from `test_that()`
#'
#' @param test_content output from `read_test_file()`
#'
#' @return named string of `test_that()` descriptions (`desc`)
#'
#' @export
#'
extract_test_that_desc <- function(test_content) {
    # Regular expression to match 'desc' argument in test_that function
    # It handles both named and unnamed 'desc' arguments
    pattern <- "test_that\\s*\\(\\s*(desc\\s*=\\s*)?\"(.*?)\""

    # Find all matches
    matches <- gregexpr(pattern, test_content, perl = TRUE)

    # Extract matched strings
    desc_matches <- regmatches(test_content, matches)

    # Flatten the list (if multiple matches are found)
    desc_matches <- unlist(desc_matches)

    # Extract the actual descriptions from the matched strings
    desc_arguments <- sapply(desc_matches, function(x) {
        m <- regmatches(x, regexec(pattern, x))
        if (length(m[[1]]) > 2) {
            return(m[[1]][3]) # Return the unnamed desc argument
        }
        return(m[[1]][2]) # Return the named desc argument
    })

    return(desc_arguments)
}

#' Read `test_that()` descriptions (context) from test file
#'
#' @param test_file path to test file
#'
#' @return data.frame with `test_file`, `test_that` and `desc`
#'
#' @export
#'
#' @examples
#' get_test_thats(test_file = system.file("tests", "testthat",
#'                                       "test-rev_string.R",
#'                                       package = "pickler"))
#' get_test_thats(test_file = system.file("tests", "testthat",
#'                                       "test-logo.R",
#'                                       package = "pickler"))
#'
get_test_thats <- function(test_file) {

    # Read test file
    tests <- read_test_file(test_file = test_file)

    # check for test_thats
    if (!grepl(pattern = "test_that", x = tests$test_contents, perl = TRUE)) {
      return(invisible())
    }

    desc_arguments <- extract_test_that_desc(test_content = tests$test_contents)

    test_files <- rep(x = tests$test_file, times = length(desc_arguments))
    test_thats <- names(desc_arguments)
    descs <- unname(desc_arguments)

    # Create a data frame for results
    results <- data.frame(
        test_file = test_files,
        call = test_thats,
        string = descs
    )

    return(results)
}
