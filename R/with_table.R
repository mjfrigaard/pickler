#' Add table Gherkin sytax
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


