get_scenario_title <- function(txt) {
  browser()
  lines <- readr::read_lines(txt)
  # lines <- readLines(txt)
  unlist(mapply(grep, "^scenario", lines,
    MoreArgs = list(value = TRUE, ignore.case = TRUE),
    SIMPLIFY = TRUE, USE.NAMES = FALSE))
}
get_scenario_given <- function(txt) {
  lines <- readr::read_lines(txt)
  unlist(mapply(grep, "^Given", lines,
    MoreArgs = list(value = TRUE),
    SIMPLIFY = TRUE, USE.NAMES = FALSE))
}


# lines <- readr::read_lines("Scenario: Split a single string with default separator
#   Given a character [string] 'one-two-three'
#   When I pass the [string] to pivot_string_long()
#   Then Then [unique_items] column should contain rows: 'one, two, three'
#   And [string] column should contain the original 'one-two-three'")
#   unlist(mapply(grep, "^Scenario", lines,
#     MoreArgs = list(value = TRUE, ignore.case = TRUE),
#     SIMPLIFY = TRUE, USE.NAMES = FALSE))

