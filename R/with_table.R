#' Add Gherkin-style table
#'
#' [Tables in Gherkin](https://cucumber.io/docs/gherkin/reference/#scenario-outline) are essentially markdown tables, so this is a wrapper for `knitr::kable(format = "pipe")`
#'
#' @param tbl data.frame or tibble
#'
#' @return a table in `knitr::kable(format = "pipe", align = "l")`
#'
#' @export
#'
#' @examples
#'# with_table(data.frame(value = c(29L, 91L, 39L, 28L, 12L),
#'#                       name = c("John", "John, Jacob",
#'#                                "John, Jacob, Jingleheimer",
#'#                                "Jingleheimer, Schmidt",
#'#                                "JJJ, Schmidt")))
with_table <- function(tbl) {
  kable_pipe <- knitr::kable(tbl, format = "pipe", align = "l")
  tbl_pipe <- gsub(pattern = ":", replacement = "-", kable_pipe)
  glue::glue("{tbl_pipe}")
}


