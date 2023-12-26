describe(description = "Feature 1a: Reverse a Simple String", code = {
      it(description = "Scenario 1a: Reverse a simple string 'hello'", code = {
                          input <- "hello"
                          observed <- rev_string(input)
                          output <- "olleh"
                          expect_equal(object = observed, expected = output)
      })
      it("Scenario 2a: Reverse another simple string 'goodbye'", code = {
                  input <- "goodbye"
                  observed <- rev_string(input)
                  output <- "eybdoog"
                  expect_equal(object = observed, expected = output)
      })
})

describe("Feature: 1b Reverse a Mixed Case String", code = {
      it(description = "Scenario: Reverse a mixed case string 'HeLlO'", code = {
                          input <- "HeLlO"
                          observed <- rev_string(input)
                          output <- "OlLeH"
                          expect_equal(object = observed, expected = output)
      })
})
describe("Feature: 2b: Reverse Another Mixed Case String", code = {
      it("Scenario: Reverse another mixed case string 'gOoDbYe'", code = {
            input <- "gOoDbYe"
            observed <- rev_string(input)
            output <- "eYbDoOg"
            expect_equal(object = observed, expected = output)
      })
})
test_that("Feature 3a: Reverse an Already Reversed String", code = {
            input <- "OlLeH"
            observed <- rev_string(input)
            output <- "HeLlO"
            expect_equal(object = observed, expected = output)
      })
it("Feature 3b: Reverse a Complex String with Spaces", code = {
        input <- "OlLeH eYbDoOg"
        observed <- rev_string(input)
        output <- "gOoDbYe HeLlO"
        expect_equal(object = observed, expected = output)
      })
