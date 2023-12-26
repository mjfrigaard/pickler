#' Extract the testthat calls from test files
#'
#' @description
#' `parse_tests_dir()` searches the tests in the `tests/testthat/` folder
#' and creates a `data.frame` from the test calls.
#'
#' @param path character, path to file
#'
#' @return data.frame
#'
#'
#' @export
parse_tests_dir <- function(path = "tests/testthat") {

  FILES <- list.files(path = path, full.names = TRUE, pattern = "^test(.*?)R$")

  ret <- stats::setNames(
    object = lapply(X = FILES,
                    FUN = parse_test_file),
    nm = basename(FILES))

  ret <- ret[sapply(ret, length) > 0]

  if (length(ret) == 0) {
    return(NULL)
  }

  ret <- lapply(
    X = names(ret),
    FUN = add_lbl_col,
    parsed_data_list = ret,
    col_name = "file"
    )

  ret <- do.call("rbind", ret)

  idx <- !(ret$test == " ")

  ret$description <- gsub(
    pattern = "describe: |test_that: ",
    replacement = "",
    x = ret$description)

  ret$test <- gsub(
    pattern = "it: ",
    replacement = "",
    x = ret$test)

  ret$test[!idx] <- ret$description[!idx]

  ret$test[idx] <- sprintf(
    fmt = "%s: %s",
    ret$description[idx],
    ret$test[idx])

  ret$description <- NULL

  ret
}
