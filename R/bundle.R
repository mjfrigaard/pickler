#' Bundle BDD functions
#'
#' @param ... features, scenarios, background, etc.
#'
#' @return bundled features, scenarios, background, etc. to be passed into tests.
#'
#' @export bundle
#'
#' @examples
#' bundle(
#'   feature(
#'     title = "Visualization",
#'     as_a = "user",
#'     i_want = "to see the changes in the plot",
#'     so_that = "I can visualize the impact of my customizations"
#'   ),
#'   background(
#'     title = "Launching the application",
#'     given = "I have launched the application",
#'     and = "it contains movie review data from IMDB and Rotten Tomatoes"
#'   ),
#'   scenario(
#'     title = "Viewing the Data Visualization",
#'     given = "I have launched the application",
#'     when = "I interact with the sidebar controls",
#'     then = "the graph should update with the selected options"
#'   )
#' )
bundle <- function(...) {
  x <- list(...)
  assign_list_names <- function(input_list) {
    # get current names
    nms <- names(input_list)
    # get names as characters
    nms_chrs <- unlist(lapply(nms, nchar)) > 1
    # subset list with names
    list_names <- nms[nms_chrs]
    # get existing name positions
    nms_pos <- grep(pattern = paste0(list_names, collapse = "|"),
                    x = names(input_list))

    # check for feature names
    fpos <- grep(pattern = "Feature", x = input_list)
    # check for background names
    bpos <- grep(pattern = "Background", x = input_list)
    # check for scenario names
    spos <- grep(pattern = "Scenario", x = input_list)

    unnamed_list_items <- c(
      "feature" = fpos,
      "background" = bpos,
      "scenario" = spos
    )
    named_list_items <- nms_pos
    names(named_list_items) <- list_names

    orig_item_order <- as.list(sort(c(unnamed_list_items, named_list_items)))

    # build list with item order
    output_list <- list()

    # use existing positions to assign previous names
    if (sum(nms_pos) > 0) {
      output_list <- sapply(
        X = input_list[nms_pos],
        FUN = append,
        output_list,
        simplify = TRUE,
        USE.NAMES = FALSE
      )
    }
    # use position to set name
    if (sum(fpos) > 0) {
      output_list$feature <- input_list[[fpos]]
    }
    # use position to set name
    if (sum(bpos) > 0) {
      output_list$background <- input_list[[bpos]]
    }
    # use position to set name
    if (sum(spos) > 0) {
      output_list$scenario <- input_list[[spos]]
    }
    # reorder items
    output_list[match(names(orig_item_order), names(output_list))]
  }
  glue::glue_collapse(
    assign_list_names(input_list = x),
    sep = "\n"
  )
}
