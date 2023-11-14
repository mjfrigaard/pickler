#' BDD Feature (build)
#'
#' @param As_a "As a" <user/stakeholder>
#' @param I_want "I want" <to perform some action>
#' @param So_that "So that" <I can reach some business goal>
#'
#' @return A feature (based on [Gherkin](https://cucumber.io/docs/gherkin/) syntax)
#'
#' @keywords internal
#'
feature_build <- function(As_a, I_want, So_that) {
    c("\t Feature:\n\t  As a ", As_a, "\n\t  I want ", I_want, "\n\t  So that ", So_that)
}

#' BDD Feature
#'
#' @param As_a As a <user or stakeholder>
#' @param I_want I want <to perform an action>
#' @param So_that So that <I can reach business goal or deliver value>
#'
#' @return A feature
#'
#' @export feature
#'
#' @examples
#' feature(As_a = "user",
#'     I_want = "to see the changes in the plot",
#'     So_that = "I can visualize the impact of my customizations")
feature <- function(As_a, I_want, So_that) {
  glue::glue_collapse(
    feature_build(As_a = As_a, I_want = I_want, So_that = So_that)
  )
}
