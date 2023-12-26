describe("Feature: Splitting Columns in Data Frame", code = {
    it("Scenario A: Split a column using the default pattern and prefix", code = {
      input_data <- data.frame(example_col = c("a-b-c", "d-e-f", "g-h-i"))

      observed <- split_cols(input_data, col = "example_col")

      expect_true(is.data.frame(observed))
      expect_true(all(c("example_col", "col_1", "col_2", "col_3") %in% names(observed)))
      expect_equal(observed$col_1, c("a", "d", "g"))
      expect_equal(observed$col_2, c("b", "e", "h"))
      expect_equal(observed$col_3, c("c", "f", "i"))

    })
  it("Scenario B: Split a column in a data frame using a custom pattern", code = {
      input_data <- data.frame(example_col = c("a1b2c", "d3e4f", "g5h6i"))

      observed <- split_cols(input_data, col = "example_col", pattern = "\\d")

      expect_true(is.data.frame(observed))
      expect_true(all(c("example_col", "col_1", "col_2", "col_3") %in% names(observed)))
      expect_equal(observed$col_1, c("a", "d", "g"))
      expect_equal(observed$col_2, c("b", "e", "h"))
      expect_equal(observed$col_3, c("c", "f", "i"))
    })
  it("Scenario C: Split a column in a data frame using a custom column prefix", code = {
      input_data <- data.frame(example_col = c("a:b:c", "d:e:f", "g:h:i"))
      observed <- split_cols(input_data, col = "example_col", col_prefix = "split")

      expect_true(is.data.frame(observed))
      expect_true(all(c("example_col", "split_1", "split_2", "split_3") %in% names(observed)))
      expect_equal(observed$split_1, c("a", "d", "g"))
      expect_equal(observed$split_2, c("b", "e", "h"))
      expect_equal(observed$split_3, c("c", "f", "i"))
    })

  it("Scenario D: Provide an error message when the input data is not a data frame", code = {
      input_data <- list(a = 1, b = 2)
      expect_error(object = split_cols(input_data, col = "a"),
                   regexp = NULL)
    })

  it("Scenario E: Provide an error message when the specified column is not in the data.frame", code = {
    input_data <- data.frame(a = 1:3, b = 4:6)
    expect_error(object = split_cols(input_data, col = "nonexistent_col"),
                 regexp = NULL)
    })
})









