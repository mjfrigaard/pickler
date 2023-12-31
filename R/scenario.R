#' BDD scenario (build)
#'
#' @param title Scenario title
#' @param given Some initial context
#' @param when An action occurs
#' @param then The expected outcome or behavior
#' @param and additional 'and' arguments
#'
#' @return A BDD scenario
#'
#' @keywords internal
#'
scenario_build <- function(title, given, when, then, and = NULL) {
  if (is.null(and)) {
    glue::glue("
        Scenario: {title}
          Given {given}
          When {when}
          Then {then}")
  } else if (length(and) == 1) {
    glue::glue("
        Scenario: {title}
          Given {given}
          When {when}
          Then {then}
          And {and}
               ")
  } else {
    add_ands_list <- lapply("And ", paste0, and)
    add_ands_vector <- unlist(add_ands_list)
    ands_chr <- as.character(glue::glue("{add_ands_vector}"))
    ands <- paste0(ands_chr, collapse = "\n  ")
    glue::glue("
        Scenario: {title}
          Given {given}
          When {when}
          Then {then}
          {ands}
          ")
  }

}

#' BDD scenario
#'
#' @description
#' Scenarios illustrate a concrete example of a specific behavior.
#'
#' @section Keywords:
#' Scenarios include 'Given', 'When', and 'Then' keywords (and sometimes
#' additional 'And' statements).
#'
#' @seealso [feature()]
#'
#' @param title Scenario title
#' @param given Preconditions or initial context
#' @param when An action occurs
#' @param then The expected outcome or behavior
#' @param and additional 'and' arguments
#'
#' @return A scenario (based on [Gherkin](https://cucumber.io/docs/gherkin/) syntax)
#'
#' @family {"BDD helpers"}
#'
#' @export scenario
#'
#' @examples
#' scenario(
#'     title = "Split column with a default pattern",
#'     given = "a dataframe with a specified column [name]",
#'     when = "I split the [name] column using the default [pattern]",
#'     then = "Then the [name] column should be split into multiple columns",
#'     and = "the new columns should be named with the default prefix [cols]"
#'   )
scenario <- function(title, given, when, then, and = NULL) {
  glue::glue_collapse(
      scenario_build(title = title,
                     given = given, when = when, then = then,
                     and = and)
    )
}
