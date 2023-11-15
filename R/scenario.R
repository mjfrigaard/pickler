#' BDD scenario (build)
#'
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
          And {and}
          Then {then}
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
          {ands}
          Then {then}
          ")
  }

}

# title <- "Viewing the Data Visualization"
# given <- "I have launched the application"
# and <- c("it contains movie review data from IMDB and Rotten Tomatoes",
#           "the data contains variables like 'Critics Score' and 'MPAA'")
# when <- "I interact with the sidebar controls"
# then <- "the graph should update with the selected options"
#
# ands_want <- c("  And it contains movie review data from IMDB and Rotten Tomatoes",
#   "  And the data contains variables like 'Critics Score' and 'MPAA'")
#
# add_ands_list <- lapply("And ", paste0, and)
# add_ands_vector <- unlist(add_ands_list)
# ands_chr <- as.character(glue::glue("
#                   {add_ands_vector}
#                   "))
# ands <- paste0(ands_chr, collapse = "\n    ")
# glue::glue("
#            Scenario: {title}
#              Given {given}
#              When {when}
#              {ands}
#              Then {then}
#          ")
# scenario_build(title = "Viewing the Data Visualization",
#          given = "I have launched the application",
#          and = list("it contains movie review data from IMDB and Rotten Tomatoes",
#                     "the data contains variables like 'Critics Score' and 'MPAA'"),
#          when = "I interact with the sidebar controls",
#          then = "the graph should update with the selected options")

#' BDD scenario
#'
#' @description
#' Scenarios illustrate a concrete example of a specific behavior.
#'
#' @section Keywords:
#' Scenarios include 'Given', 'When', and 'Then' keywords (and sometimes
#' additional 'And' statements).
#'
#'
#' @param title Scenario title
#' @param given Preconditions or initial context
#' @param when An action occurs
#' @param then The expected outcome or behavior
#' @param and additional 'and' arguments
#'
#' @return A BDD scenario
#'
#' @export scenario
#'
#' @examples
#' scenario(title = "Viewing the Data Visualization",
#'          given = "I have launched the application",
#'          when = "I interact with the sidebar controls",
#'          then = "the graph should update with the selected options")
#' scenario(title = "Viewing the Data Visualization",
#'          given = "I have launched the application",
#'          and = "it contains movie review data from IMDB and Rotten Tomatoes",
#'          when = "I interact with the sidebar controls",
#'          then = "the graph should update with the selected options")
#' scenario(title = "Viewing the Data Visualization",
#'          given = "I have launched the application",
#'          and = list("it contains movie review data from IMDB and Rotten Tomatoes",
#'                     "the data contains variables like 'Critics Score' and 'MPAA'"),
#'          when = "I interact with the sidebar controls",
#'          then = "the graph should update with the selected options")
scenario <- function(title, given, when, then, ...) {
  glue::glue_collapse(
      scenario_build(title = title, given = given, when = when, then = then, ...)
    )
}
