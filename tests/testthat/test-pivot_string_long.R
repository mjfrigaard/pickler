describe(
bundle(
  feature(
    title = "Pivot String Long",
    as_a = "user of pivot_string_long()",
    i_want = "to specify a text column and a pattern",
    so_that = "peform computations on the unique items."
  ),
  background(
    title = "Input text data",
    given = "a string or vector [string] with text columns",
    and = "a specified pattern [sep]"),

  input = c("one-two-three")), code = {

it(
 bundle(
  scenario(
    title = "Split a single string with default separator",
    given = "a character [string] 'one-two-three'",
    when = "I pass the [string] to pivot_string_long()",
    then = "Then [unique_items] column should contain rows: 'one, two, three'",
    and = "[string] column should contain the original 'one-two-three'"
  ),
  output = c(
          "
      |unique_items |string        |
      |-------------|--------------|
      |one          |one-two-three |
      |two          |NA            |
      |three        |NA            |
          ")), code = {
  input <- c("one-two-three")
  # create observed output
  observed <- pivot_string_long(input)
  # compare against output
  output <- data.frame(
    unique_items = c("one", "two", "three"),
    string = c("one-two-three", NA, NA))
  expect_equal(object = observed, expected = output)

})

})
