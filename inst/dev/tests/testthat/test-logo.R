test_that("Scenario: User stores the output of logo()",
  code = {
        # Then the contents of x should be NULL
        x <- logo()
        expect_null(x)
        # And the output if logo() is NULL
        expect_true(is.null(logo()))
})
