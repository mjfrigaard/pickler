#' BDD Feature (build)
#'
#' @param title The feature title
#' @param as_a "As a" <user/stakeholder>
#' @param i_want "I want" <to perform some action>
#' @param so_that "So that" <I can reach some business goal>
#'
#' @return A feature (based on [Gherkin](https://cucumber.io/docs/gherkin/) syntax)
#'
#' @keywords internal
#'
feature_build <- function(title, as_a, i_want, so_that) {
    # c("Feature:", title, "\n  As a ", as_a, "\n  I want ", i_want, "\n  So that ", so_that)
    glue::glue("
              Feature: {title}
                As a {as_a}
                I want {i_want}
                So that {so_that}")
}

#' BDD Feature
#'
#' Write a test feature.
#'
#' @param title The feature title
#' @param as_a "As a" <user/stakeholder>
#' @param i_want "I want" <to perform some action>
#' @param so_that "So that" <I can reach some business goal>
#'
#' @section Technical details:
#' The contents of feature are returned as a `'glue' chr`, but retain
#' [Gherkin-style indentation](https://cucumber.io/docs/gherkin/reference/#feature).
#' These can be passed to `testthat`'s [`it()`](https://testthat.r-lib.org/reference/describe.html) or [`test_that()`](https://testthat.r-lib.org/reference/test_that.html) testing functions.
#'
#' @seealso [scenario()]
#'
#' @return A feature (based on [Gherkin](https://cucumber.io/docs/gherkin/) syntax)
#'
#' @family {"BDD helpers"}
#'
#' @export feature
#'
#' @examples
#' feature(title = "Visualization",
#'         as_a = "user",
#'         i_want = "to see the changes in the plot",
#'         so_that = "I can visualize the impact of my customizations")
feature <- function(title, as_a, i_want, so_that) {
  glue::glue_collapse(
    feature_build(title = title,
                  as_a = as_a,
                  i_want = i_want,
                  so_that = so_that)
  )
}
