#' @title Map the hierarchy structure of a testthat test file
#'
#' @description Query a test file to see what expectations are defined in it.
#'
#' @param path character, path to file
#'
#' @return data.frame
#'
#'
#' @export
parse_test_file <- function(path) {

  parsed_tests <- utils::getParseData(x = parse(file = path, keep.source = TRUE), includeText = TRUE)

  if (is.null(parsed_tests)) {
    return(NULL)
  }

  ret <- lapply(
    match_tests(parsed_tests), FUN = function(xx) {
    ret_ <- lapply(
      match_tests(test_data = xx, context_pattern = "^test_that$|^describe$"),
      FUN = function(y) {
        SYMB <- y$text[grep(pattern = "^SYMBOL_FUNCTION_CALL$", x = y$token)[1]]
        switch(SYMB,
          describe = {
            extract_expects(
              test_code_list =
                match_tests(test_data = y, context_pattern = "^it$"))
          },
          test_that = {
            extract_expects(test_code_list = setNames(list(y), nm = " "))
          },
          {
            list()
          }
        )
      }
    )

    ret_ <- ret_[sapply(X = ret_, FUN = length) > 0]

    if (length(ret_) == 0) {
      return(NULL)
    }

    ret_ <- lapply(X = names(ret_),
                  FUN = add_lbl_col,
                  parsed_data_list = ret_,
                  col_name = "description"
      )

    ret_ <- do.call("rbind", ret_)

    ret_
  })

  ret <- ret[sapply(X = ret, FUN = length) > 0]

  if (length(ret) == 0) {
    return(NULL)
  }

  ret <- lapply(X = names(ret),
    FUN = add_lbl_col,
    parsed_data_list = ret,
    col_name = "context")

  ret <- do.call("rbind", ret)

  return(ret)
}
