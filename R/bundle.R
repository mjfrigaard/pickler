#' Bundle BDD functions
#'
#' @param ... features, scenarios, background, etc.
#'
#' @return glue/character
#'
#' @export bundle
#'
#' @examples
#' bundle(
#'   list(
#'   feature(title = "Visualization",
#'           as_a = "user",
#'           i_want = "to see the changes in the plot",
#'           so_that = "I can visualize the impact of my customizations"),
#'   background(title = "Launching the application",
#'              given = "I have launched the application",
#'              and = "it contains movie review data from IMDB and Rotten Tomatoes"),
#'   scenario(title = "Viewing the Data Visualization",
#'            given = "I have launched the application",
#'            when = "I interact with the sidebar controls",
#'            then = "the graph should update with the selected options")
#'   )
#' )
bundle <- function(...) {

  # browser()

    x <- list(...)

    nms <- names(x)
    nms_chrs <- unlist(lapply(nms, nchar)) > 1
    list_names <- nms[nms_chrs]

    fpos <- grep(pattern = "Feature", x = x)
    bpos <- grep(pattern = "Background", x = x)
    spos <- grep(pattern = "Scenario", x = x)

    if (sum(fpos) >= 1 & sum(bpos) >= 1 & sum(spos) >= 1) {
      names(x)[fpos] <- "Feature"
      names(x)[fpos] <- "Background"
      names(x)[spos] <- "Scenario"
    } else if (sum(fpos) >= 1 & sum(bpos) >= 1 & sum(spos) < 1) {
      names(x)[fpos] <- "Feature"
      names(x)[bpos] <- "Background"
    } else if (sum(fpos) >= 1 & sum(bpos) < 1 & sum(spos) >= 1) {
      names(x)[fpos] <- "Feature"
      names(x)[spos] <- "Scenario"
    } else if (sum(fpos) < 1 & sum(bpos) >= 1 & sum(spos) >= 1) {
      names(x)[bpos] <- "Background"
      names(x)[spos] <- "Scenario"
    } else if (sum(fpos) >= 1 & sum(bpos) < 1 & sum(spos) < 1) {
      names(x)[fpos] <- "Feature"
    } else if (sum(fpos) < 1 & sum(bpos) >= 1 & sum(spos) < 1) {
      names(x)[bpos] <- "Background"
    } else if (sum(fpos) < 1 & sum(bpos) < 1 & sum(spos) >= 1) {
      names(x)[spos] <- "Scenario"
    } else {
      names(x) <- NULL
    }

    glue::glue_collapse(
      x,
      sep = "\n")
}


# x <- list(
#   background(
#     title = "Input dataframe with text data",
#     given = "a dataframe with text data",
#     and = list(
#                "a column prefix",
#                "a specified column")),
#
# input_data = c("
#                |value |name                      |
#                |------|--------------------------|
#                |1     |John                      |
#                |2     |John, Jacob               |
#                |3     |John, Jacob, Jingleheimer |
#                "),
#
# output_data = c("
#                |value |name                      |
#                |------|--------------------------|
#                |1     |John                      |
#                |2     |John, Jacob               |
#                |3     |John, Jacob, Jingleheimer |
#                "),
# feature(
#   title = "Separate single column into multiple based on pattern",
#   as_a = "user of split_cols() ",
#   i_want = "to specify a separate column and a pattern to separate on",
#   so_that = "a resulting dataframe contains the new separated columns.")
# )
#
# nms <- names(x)
# nms_chrs <- unlist(lapply(nms, nchar)) > 1
# list_names <- nms[nms_chrs]
#
# list_names
#
# nms_pos <- grep(pattern = paste0(list_names, collapse = "|"), x = names(x))
#
# nms_pos
#
# x[nms_pos]

