describe(description = "Feature 1a: Reverse a Simple String
                        As a user,
                        I want to reverse the characters in a string
                        So that I can have the string displayed in reverse order.", code = {
      test_that(desc = "Scenario 1a: Reverse a simple string 'hello'
                        Given a string 'hello'
                        When I use the rev_string() function
                        Then the output should be 'olleh'", code = {
                          input <- "hello"
                          observed <- rev_string(input)
                          output <- "olleh"
                          expect_equal(object = observed, expected = output)
      })
})
describe("Feature 2a: Reverse Another Simple String
          As a user,
          I want to reverse the characters in a string
          So that I can have the string displayed in reverse order.", code = {
      test_that("Scenario 2a: Reverse another simple string 'goodbye'
                 Given a string 'goodbye''
                 When I use the rev_string() function
                 Then the output should be 'eybdoog'", code = {
                  input <- "goodbye"
                  observed <- rev_string(input)
                  output <- "eybdoog"
                  expect_equal(object = observed, expected = output)
      })
})

describe("Feature: 1b Reverse a Mixed Case String
          As a user,
          I want to reverse the characters in a string
          So that I can have the string displayed in reverse order.", code = {
      it(description = "Scenario: Reverse a mixed case string 'HeLlO'
                        Given a string 'HeLlO'
                        When I use the rev_string() function
                        Then the output should be 'OlLeH'", code = {
                          input <- "HeLlO"
                          observed <- rev_string(input)
                          output <- "OlLeH"
                          expect_equal(object = observed, expected = output)
      })
})
describe("Feature: 2b: Reverse Another Mixed Case String
          As a user,
          I want to reverse the characters in a string
          So that I can have the string displayed in reverse order.", code = {
      it("Scenario: Reverse another mixed case string 'gOoDbYe'
          Given a string 'gOoDbYe'
          When I use the rev_string() function
          Then the output should be 'eYbDoOg'", code = {
            input <- "gOoDbYe"
            observed <- rev_string(input)
            output <- "eYbDoOg"
            expect_equal(object = observed, expected = output)
      })
})
test_that("Feature 3a: Reverse an Already Reversed String
           Scenario: Reverse an already reversed string 'OlLeH'
           Given a string 'OlLeH'
           When I use the rev_string() function
           Then the output should be 'HeLlO'", code = {
            input <- "OlLeH"
            observed <- rev_string(input)
            output <- "HeLlO"
            expect_equal(object = observed, expected = output)
      })
it("Feature 3b: Reverse a Complex String with Spaces
    Scenario: Reverse a complex string with spaces 'OlLeH eYbDoOg'
    Given a string 'OlLeH eYbDoOg'
    When I use the rev_string function
    Then the output should be 'gOoDbYe HeLlO'", code = {
        input <- "OlLeH eYbDoOg"
        observed <- rev_string(input)
        output <- "gOoDbYe HeLlO"
        expect_equal(object = observed, expected = output)
      })
