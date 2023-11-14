#' BDD scenario (build)
#'
#' @param Given Some initial context
#' @param When An action occurs
#' @param Then The expected outcome or behavior
#' @param And additional 'And' arguments
#'
#' @return A BDD scenario
#'
#' @keywords internal
#'
scenario_build <- function(Given, When, Then, And = NULL) {
  if (is.null(And)) {
    c("\t Scenario:\n\t  Given ", Given, "\n\t  When ", When, "\n\t  Then ", Then)
  } else if (length(And) == 1) {
    c("\t Scenario:\n\t  Given ", Given, "\n\t  And ", And, "\n\t  When ", When, "\n\t  Then ", Then)
  } else {
    ands_list <- lapply("And ", paste0, And)
    ands_vector <- unlist(ands_list)
    ands_clean <- paste0("  ", ands_vector, collapse =  "\n\t")
    c("\t Scenario:\n\t  Given ", Given, "\n\t", ands_clean, "\n\t  When ", When, "\n\t  Then ", Then)
  }

}
# scenario_build(Given = "I have launched the application",
#                And = list("it contains movie review data from IMDB and Rotten Tomatoes",
#                           "the data contains variables like 'Critics Score' and 'MPAA'"),
#                When = "I interact with the sidebar controls",
#                Then = "the graph should update with the selected options")

#' BDD scenario
#'
#' @param Given Some initial context
#' @param When An action occurs
#' @param Then The expected outcome or behavior
#' @param And additional 'And' arguments
#'
#' @return A BDD scenario
#'
#' @export scenario
#'
#' @examples
#' scenario(Given = "I have launched the application",
#'          When = "I interact with the sidebar controls",
#'          Then = "the graph should update with the selected options")
#' scenario(Given = "I have launched the application",
#'          And = "it contains movie review data from IMDB and Rotten Tomatoes",
#'          When = "I interact with the sidebar controls",
#'          Then = "the graph should update with the selected options")
#' scenario(Given = "I have launched the application",
#'          And = list("it contains movie review data from IMDB and Rotten Tomatoes",
#'                     "the data contains variables like 'Critics Score' and 'MPAA'"),
#'          When = "I interact with the sidebar controls",
#'          Then = "the graph should update with the selected options")
scenario <- function(Given, When, Then, ...) {
  glue::glue_collapse(
      scenario_build(Given = Given, When = When, Then = Then, ...)
    )
}
