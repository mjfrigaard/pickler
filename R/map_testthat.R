#' Extract Expectations from Parsed R Code
#'
#' The `get_expect()` function is designed to extract expectations from parsed
#'  R code, specifically targeting expressions that begin with `expect_`.
#'
#' @param x A data frame representing parsed R code. The structure should be
#'   what is returned by `utils::getParseData()`, containing columns `token`,
#'   `text`, `line1`, `line2`, and `terminal`.
#' @param token_text A regular expression pattern that identifies the start of
#'   the expectation functions. Defaults to `'^expect_'`.
#'
#' @return A data frame containing the extracted expectation functions and their
#'   respective line numbers. This data.frame has columns `expectation`,
#'   `line1`, and `line2`. If no expectation functions are found, the function
#'   returns `NULL`.
#'
#' @section Technical details:
#' `get_expect()` scans through the provided parsed data structure to identify
#' and extract information related to these expectation expressions, including
#' the line numbers where they are found.
#'
#' @section Related Functions:
#' The function `get_expect()` works in conjunction with other functions like
#' `nest_test()`, `nest_expect()`, and `map_test()` to process and organize
#' test code structures. These functions together help in analyzing and
#' summarizing the test expectations in R packages or scripts.
#'
#' @noRd
#'
# Assuming `parsed_data` is a data frame from `utils::getParseData()`
# path <- system.file("tests", "testthat","test-split_cols.R",
#                                         package = "pickler")
# parsed_data <- utils::getParseData(parse(file = path, keep.source = TRUE),
#                          includeText = TRUE)
# get_expect(parsed_data)
get_expect <- function(x, token_text = "^expect_") {

  idx <- which(grepl("^SYMBOL_FUNCTION_CALL$", x$token) & grepl(token_text, x$text) & x$terminal)

  ret <- x$text[idx]

  if (length(ret) == 0) {
    return(NULL)
  }

  line_ <- lapply(idx, function(y) {
    this_idx <- tail(grep("expr", x$token[1:y]), 2)
    this_exp <- min(grep(sprintf("%s", x$text[y]), x$text[this_idx]))
    x[this_idx[this_exp], c("line1", "line2")]
  })
  # browser()
  line_ <- do.call("rbind", line_)

  ret <- data.frame(
    expectation = ret,
    line1 = line_$line1,
    line2 = line_$line2,
    stringsAsFactors = FALSE
  )

  ret
}

#' Remove Row Names and Append a Label Column
#'
#' The `unrowname()` function is designed to modify a data frame by removing
#' its row names and appending a new column with a specific label.
#'
#' @section Technical details:
#' `unrowname()` is primarily used in the context of processing and
#' restructuring data frames, especially those resulting from parsing
#' and analyzing R test code.
#'
#' @param el The element (typically a string) that will be used as the label
#'  for the new column.
#' @param ret A list of data frames from which the specific data frame (`x`)
#'  is selected using the `el` parameter.
#' @param label The name of the new column to be added to the data frame, which
#'  will contain the value specified by `el`.
#'
#' @return A modified data.frame where the row names have been removed and a
#' new column named as per the `label` parameter is added. This new column
#' contains the value of `el` for all rows.
#'
#'
#' @noRd
#'
unrowname <- function(el, ret, label) {
  x <- ret[[el]]

  nc <- ncol(x)

  x[[label]] <- el

  rownames(x) <- NULL

  x <- x[, c(c(nc + 1), 1:nc)]

  return(x)
}

#' Nest Expectations from Parsed Test Blocks
#'
#' The `nest_expect()` function processes a list of parsed R code blocks,
#' (tests), and extracts expectations from each block using the
#' `get_expect()` function.
#'
#' @param x A list of parsed R code blocks. Each element of the list is expected
#'  to be a `data.frame` with a structure identical to what is returned by
#'  `utils::getParseData()`. These data frames represent parsed R code,
#'  corresponding to test blocks in test files.
#'
#' @return A data.frame consolidating the expectations extracted from each test
#'  block. The data.frame contains merged results from the individual blocks,
#'  with additional columns for labeling and structuring the data. If no
#'  expectations are found in any of the blocks, the function returns `NULL`.
#'
#' @section Technical details:
#' `nest_expect()` compiles the results into a unified data frame, organizing
#' the expectations by their respective test cases.
#'
#'
#'
#' @noRd
#'
#'
# Assuming `parsed_blocks` is a list of parsed R code blocks
# nested_expectations <- nest_expect(parsed_blocks)
nest_expect <- function(x) {
  ret <- lapply(x, get_expect)

  ret <- ret[!sapply(ret, is.null)]

  if (length(ret) == 0) {
    return(NULL)
  }

  ret <- lapply(names(ret), unrowname, ret = ret, label = "test")

  ret <- do.call("rbind", ret)

  ret
}

#' Parse Test Cases in R Code
#'
#' `nest_test` identifies and organizes test cases in R code.
#'
#' @details
#' `nest_test()` parses the provided syntax tree to extract and nest test cases
#' based on specified function calls. The function is part of a larger suite of
#' functions for processing and analyzing test cases.
#'
#' @section Technical details:
#' This function takes a syntax tree as input, typically generated
#' by parsing R code, and organizes test cases based on the occurrence of
#' specified tokens. It is designed to work with test cases written using
#' common testing frameworks like `testthat`. The output is a list of nested
#' data frames, each representing a test case block.
#'
#' @param x A data frame representing a syntax tree of R code, typically
#' obtained from `utils::getParseData()`
#'
#' @param token_text A regular expression as a string, used to match the
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
#' @noRd
#'
# Assuming `x` is a syntax tree obtained from `utils::getParseData()`
# path <- system.file("tests", "testthat","test-split_cols.R",
#                                          package = "pickler")
#  x <- utils::getParseData(parse(file = path, keep.source = TRUE),
#                           includeText = TRUE)
#  nest_test(x)
nest_test <- function(x, token_text = "^context$") {
  rx <- rownames(x)

  idx <- which(rx %in% x$parent[grepl("^SYMBOL_FUNCTION_CALL$", x$token) & grepl(token_text, x$text) & x$terminal])

  idx <- which(rx %in% x$parent[idx])

  x1 <- rep(0, nrow(x))

  x1[idx] <- 1

  x1 <- cumsum(x1)

  x2 <- split(x, x1)

  names(x2) <- sapply(X = x2, FUN = function(x) {
    add_text <- x$text[grep("^SYMBOL_FUNCTION_CALL$", x$token)[1]]
    ret <- eval(parse(text = x$text[grepl("^STR_CONST$", x$token)][1], keep.source = TRUE))

    if (add_text %in% c("test_that", "describe", "it")) {
      ret <- sprintf("%s: %s", add_text, ret)
    }
    ret
  }, simplify = TRUE, USE.NAMES = TRUE)

  x2 <- lapply(X = x2, FUN = function(x) {
    idx <- utils::tail(utils::head(which(x$parent == 0), 2), 1)
    if (length(idx) == 0) {
      idx <- 1
    }
    x[idx:nrow(x), ]
  })

  x2
}


#' @title Map the hierarchy structure of a testthat test file
#'
#' @description Query a test file to see what expectations are defined in it.
#'
#' @param path character, path to file
#'
#' @details Return data.frame containing which expectations are in the test file
#'  by context/description/test/expectation/linerange
#'
#' @return data.frame
#'
#' @seealso
#'  \code{\link[utils]{getParseData}}
#'
#' @rdname map_test
#'
#' @noRd
#'
#' @importFrom utils getParseData
map_test <- function(path) {

  x <- utils::getParseData(x = parse(file = path, keep.source = TRUE), includeText = TRUE)

  if (is.null(x)) {
    return(NULL)
  }
  ret <- lapply(nest_test(x), function(xx) {
    ret_ <- lapply(
      nest_test(xx, token_text = "^test_that$|^describe$"),
      function(y) {
        SYMB <- y$text[grep("^SYMBOL_FUNCTION_CALL$", y$token)[1]]

        switch(SYMB,
          describe = {
            nest_expect(nest_test(y, token_text = "^it$"))
          },
          test_that = {
            nest_expect(setNames(list(y), " "))
          },
          {
            list()
          }
        )
      }
    )

    ret_ <- ret_[sapply(ret_, length) > 0]

    if (length(ret_) == 0) {
      return(NULL)
    }

    ret_ <- lapply(names(ret_), unrowname, ret = ret_, label = "description")

    ret_ <- do.call("rbind", ret_)

    ret_
  })

  ret <- ret[sapply(ret, length) > 0]

  if (length(ret) == 0) {
    return(NULL)
  }

  ret <- lapply(names(ret), unrowname, ret = ret, label = "context")

  ret <- do.call("rbind", ret)

  return(ret)
}

#' @title Map the hierarchy structure of testthat directory
#' @description Query a testthat directory for the unit test structure.
#' @param path character, path to tests, Default: 'tests/testthat'
#' @details Return data.frame containing which expecations are in the testthat directory
#'  by file/context/description/test/expectation/linerange
#' @return data.frame
#' @seealso
#'  \code{\link[stats]{setNames}}
#' @rdname map_testthat
#' @family utility
#' @noRd
#' @importFrom stats setNames
map_testthat <- function(path = "tests/testthat") {

  FILES <- list.files(path, full.names = TRUE, pattern = "^test(.*?)R$")

  ret <- stats::setNames(lapply(FILES, map_test), basename(FILES))

  ret <- ret[sapply(ret, length) > 0]

  if (length(ret) == 0) {
    return(NULL)
  }

  ret <- lapply(names(ret), unrowname, ret = ret, label = "file")

  ret <- do.call("rbind", ret)

  idx <- !(ret$test == " ")

  ret$description <- gsub("describe: |test_that: ", "", ret$description)
  ret$test <- gsub("it: ", "", ret$test)

  ret$test[!idx] <- ret$description[!idx]

  ret$test[idx] <- sprintf("%s: %s", ret$description[idx], ret$test[idx])

  ret$description <- NULL

  ret
}

