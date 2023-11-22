get_scenario_title <- function(txt) {
  lines <- readr::read_lines(txt)
  unlist(mapply(grep, "^Scenario", lines,
    MoreArgs = list(value = TRUE),
    SIMPLIFY = TRUE, USE.NAMES = FALSE))
}


lines <- readr::read_lines("Scenario: Split a single string with default separator
  Given a character [string] 'one-two-three'
  When I pass the [string] to pivot_string_long()
  Then Then [unique_items] column should contain rows: 'one, two, three'
And [string] column should contain the original 'one-two-three'")
  unlist(mapply(grep, "^Scenario", lines,
    MoreArgs = list(value = TRUE),
    SIMPLIFY = TRUE, USE.NAMES = FALSE))
