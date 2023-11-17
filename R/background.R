#' BDD background (build)
#'
#' BDD backgrounds are listed **before** the first `scenario()`, at the same
#' level of indentation.
#'
#' @param title Background title
#' @param given Preconditions/initial context
#' @param and Additional 'and' arguments
#'
#' @return A BDD background
#'
#' @keywords internal
#'
background_build <- function(title, given, and = NULL) {
  if (is.null(and)) {
  glue::glue("
      Background: {title}
        Given {given}
      ")
  } else if (length(and) == 1) {
  glue::glue("
      Background: {title}
        Given {given}
        And {and}
      ")
  } else {
  add_ands <- unlist(lapply("And ", paste0, and))
  ands_chr <- as.character(glue::glue("{add_ands}"))
  ands <- paste0(ands_chr, collapse = "\n  ")
  glue::glue("
      Background: {title}
        Given {given}
        {ands}
        \t
        ")
  }
}

#' BDD background
#'
#' BDD backgrounds provide context and pre-existing conditions for features and
#' scenarios.
#'
#' @param title Background title
#' @param given Preconditions for scenario/feature.
#' @param ... additional `and` arguments for initial context (provided in a
#' `list()`)
#'
#' @section Technical details:
#' Use `background()` to reduce repetitive information in scenarios or features.
#'
#'
#' @return A BDD background (based on [Gherkin](https://cucumber.io/docs/gherkin/) syntax)
#'
#' @family {"BDD helpers"}
#'
#' @export background
#'
#' @examples
#' background(title = "Launching the application",
#'            given = "I have launched the application")
#' background(title = "Launching the application",
#'            given = "I have launched the application",
#'            and = "it contains movie review data from IMDB and Rotten Tomatoes")
#' background(title = "Launching the application",
#'            given = "I have launched the application",
#'            and = list("it contains movie review data from IMDB and Rotten Tomatoes",
#'                       "the data contains variables like 'Critics Score' and 'MPAA'",
#'                       "the data contains variables like 'Audience Score' and 'Genre'"))
background <- function(title, given, ...) {
  glue::glue_collapse(
      background_build(title = title, given = given, ...)
    )
}
