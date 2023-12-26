describe("Feature: Pivot Single String into Long Format" , code = {
    it("Scenario 1: Pivot a single string using a default separator", code = {
    input_string <- "a-b-c"
    observed <- pivot_string_long(input_string)

    expect_true(is.data.frame(observed))
    expect_equal(names(observed), c("unique_items", "string"))
    expect_equal(nrow(observed), 3)
    expect_equal(observed$unique_items, c("a", "b", "c"))
    expect_equal(observed$string, c("a-b-c", NA, NA))
    })
})
