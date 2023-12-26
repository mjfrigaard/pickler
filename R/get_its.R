#' Extract `description` from `it()`
#'
#'
#' @param test_content output from `read_test_file()`
#'
#' @return named string of `it()` `descriptions`.
#'
#'
extract_it_descriptions <- function(test_content) {
    # Regular expression to match 'description' argument in it() function
    # It handles both named and unnamed 'description' arguments
    pattern <- "it\\s*\\(\\s*(description\\s*=\\s*)?\"(.*?)\""

    # Find all matches
    matches <- gregexpr(pattern, test_content, perl = TRUE)

    # Extract matched strings
    description_matches <- regmatches(test_content, matches)

    # Flatten the list (if multiple matches are found)
    description_matches <- unlist(description_matches)

    # Extract the actual descriptions from the matched strings
    description_arguments <- sapply(description_matches, function(x) {
        m <- regmatches(x, regexec(pattern, x))
        if (length(m[[1]]) > 2) {
            return(m[[1]][3]) # Return the unnamed desc argument
        }
        return(m[[1]][2]) # Return the named desc argument
    })

    return(description_arguments)
}

#' Read `it()` descriptions (contexts) from test file
#'
#' @param test_file path to test file
#'
#' @return data.frame with `test_file`, `it` and `description`
#'
#'
#' @examples
#' get_its(test_file = system.file("tests", "testthat",
#'                                       "test-rev_string.R",
#'                                       package = "pickler"))
#' get_its(test_file = system.file("tests", "testthat",
#'                                       "test-logo.R",
#'                                       package = "pickler"))
get_its <- function(test_file) {

    # Read test file
    tests <- read_test_file(test_file)

    # check for test_thats
    if (!grepl(pattern = "test_that", x = tests$test_contents, perl = TRUE)) {
      return(invisible())
    }

    description_arguments <- extract_it_descriptions(tests$test_contents)

    test_files <- rep(x = tests$test_file, times = length(description_arguments))
    its <- names(description_arguments)
    descriptions <- unname(description_arguments)

    # Create a data frame for results
    results <- data.frame(
        test_file = test_files,
        call = its,
        string = descriptions
    )

    return(results)
}

