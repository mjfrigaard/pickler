describe("Feature: Pivot Single String into Long Format
  As a user,
  I want to pivot a single string into a long-format data.frame based on a separator
  So that I can analyze each unique item in the string separately",
  code = {
    it("Scenario 1: Pivot a single string using a default separator
               Given a single string 'a-b-c'
               And a default separator: [^[:alnum:]]+
               When I call the pivot_string_long() function with this string
               Then pivot_string_long() should return a data.frame with 'unique_items' and 'string' columns
               And the data.frame should contain each unique item from the string
               And the 'string' column should contain the original string for each unique item",
      code = {
          input_string <- "a-b-c"
          observed <- pivot_string_long(input_string)

          expect_true(is.data.frame(observed)) #L17
          expect_equal(names(observed), c("unique_items", "string"))
          expect_equal(nrow(observed), 3)
          expect_equal(observed$unique_items, c("a", "b", "c"))
          expect_equal(observed$string, c("a-b-c", NA, NA))
    })
})
