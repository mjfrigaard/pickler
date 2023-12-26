#' Read describes in test file
#'
#' @param test_file path to test file
#'
#' @return data.frame with `test_file`, `test_contents`, `describe` and `type`
#'
#' @export
#'
#' @return data.frame with `test_file`, `describe` and `description`
#'
#' @examples
#' get_describes(test_file = system.file("tests", "testthat",
#'                                       "test-rev_string.R",
#'                                       package = "pickler"))
get_describes <- function(test_file) {

    # Read test file
    tests <- read_test_file(test_file = test_file)

    # check for describes
    if (!grepl(pattern = "describe", x = tests$test_contents, perl = TRUE)) {
      return(invisible())
    }

    description_arguments <- extract_describe_descriptions(tests$test_contents)

    test_files <- rep(tests$test_file, length(description_arguments))
    describes <- names(description_arguments)
    descriptions <- unname(description_arguments)

    # Create a data frame for results
    results <- data.frame(
        test_file = test_files,
        call = describes,
        string = descriptions
    )

    return(results)
}
