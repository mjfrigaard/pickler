test_that("Scenario: User stores the output of logo()
    Given a user has access to the pickler package
    When the output from logo() is assigned to x
    Then the contents of x should be NULL",
  code = {
        x <- logo()
        expect_null(x)
})
