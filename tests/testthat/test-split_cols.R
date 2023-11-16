describe(
  bundle(
    feature(
    title = "Split a single column into multiple columns using a pattern",
    as_a = "user of split_cols()",
    i_want = "to specify a column and a pattern",
    so_that = "I can quickly generate multiple columns."
  ),
    background(
    title = "Input dataframe with text data",
    given = "a dataframe [data] with text columns",
    and = list(
               "a column prefix [default]",
               "a specified column [name]")),

  input = c("
           |value |name                      |
           |------|--------------------------|
           |1     |John                      |
           |2     |John, Jacob               |
           |3     |John, Jacob, Jingleheimer |
           ")), code = {

  it(
  bundle(
    scenario(
      title = "Split column with a default pattern",
      given = "a dataframe [data] with a specified column [name]",
      when = "I split the [name] column using the default [[^[:alnum:]]+]",
      then = "the [name] column should be split into multiple columns",
      and = "the new columns should be named with the default prefix [cols_]"
  ),
  output = c("
          |value |name                      |col_1 |col_2 |col_3        |
          |------|--------------------------|------|------|-------------|
          |1     |John                      |John  |NA    |NA           |
          |2     |John, Jacob               |John  |Jacob |NA           |
          |3     |John, Jacob, Jingleheimer |John  |Jacob |Jingleheimer |
        ")
  ), code = {

  # create observed output
  observed <- split_cols(data = input, col = 'name')
  # compare against output
  expect_equal(object = observed, expected = output)

})
})
