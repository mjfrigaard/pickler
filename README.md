
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bddR

<!-- badges: start -->
<!-- badges: end -->

The goal of `bddR` is to provide [Gherkin
syntax](https://cucumber.io/docs/gherkin/) helpers for [`testthat`’s
`describe()` and `it()`
functions](https://testthat.r-lib.org/reference/describe.html).

## Installation

You can install the development version of bddR from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("mjfrigaard/bddR")
```

``` r
library(bddR)
```

``` r
if (!require(pak)) {
   install.packages("pak", 
     repos = "http://cran.us.r-project.org")
}
pak::pak("testthat")
library(testthat)
```

## Feature

Adding [Gherkin keywords](https://cucumber.io/docs/gherkin/reference/)
to `describe()` and `it()` can be tiresome.

``` r
testthat::test_that("
  Feature:
      As a user
      I want to see the changes in the plot
      So that I can visualize the impact of my customizations
  ", code = {
  testthat::expect_true(TRUE)
})
#> Test passed 🌈
```

`feature()` allows you to simply fill in the arguments:

``` r
feature(
    As_a = "user",
    I_want = "to see the changes in the plot", 
   So_that = "I can visualize the impact of my customizations")
#>   Feature:
#>    As a user
#>    I want to see the changes in the plot
#>    So that I can visualize the impact of my customizations
```

It returns a `glue`/`character` string:

``` r
class(feature(
    As_a = "user",
    I_want = "to see the changes in the plot", 
   So_that = "I can visualize the impact of my customizations"))
#> [1] "glue"      "character"
```

So it can be dropped into a test `description`:

``` r
testthat::test_that(
  feature(
    As_a = "user",
    I_want = "to see the changes in the plot", 
   So_that = "I can visualize the impact of my customizations"), code = {
  testthat::expect_true(TRUE)
})
#> Test passed 🥳
```

## Scenario

Scenarios have `Given`, `When`, `Then` (and sometimes `And`) statements:

``` r
testthat::describe(
  feature(
    As_a = "user",
    I_want = "to see the changes in the plot", 
   So_that = "I can visualize the impact of my customizations"), 
  code = {
    testthat::it("
      Scenario: 
          Given 
          When 
          Then 
      ", code = {
      testthat::expect_true(TRUE)
    })
  })
#> Test passed 😀
```

``` r
testthat::describe(
    feature(As_a = "user",
            I_want = "to see the changes in the plot", 
            So_that = "I can visualize the impact of my customizations"),
  code = {
    testthat::it(
      scenario(Given = "I have launched the application",
         When = "I interact with the sidebar controls",
         Then = "the graph should update with the selected options"),
      code = {
      testthat::expect_true(TRUE)
    })
  })
#> Test passed 🥳
```

We can add an `And` statement for more background/context:

``` r
testthat::describe(
    feature(As_a = "user",
            I_want = "to see the changes in the plot", 
            So_that = "I can visualize the impact of my customizations"),
  code = {
    testthat::it(
      scenario(Given = "I have launched the application",
               And = "it contains movie review data from IMDB and Rotten Tomatoes",
               When = "I interact with the sidebar controls",
               Then = "the graph should update with the selected options"),
      code = {
      testthat::expect_true(TRUE)
    })
  })
#> Test passed 🎉
```

More than one `And`? Just drop them in a `list()`:

``` r
testthat::describe(
  feature(As_a = "user",
            I_want = "to see the changes in the plot", 
            So_that = "I can visualize the impact of my customizations"), 
  code = {
    testthat::it(
      scenario(Given = "I have launched the application",
               And = list("it contains movie review data from IMDB and Rotten Tomatoes",
                          "the data contains variables like 'Critics Score' and 'MPAA'"),
               When = "I interact with the sidebar controls",
               Then = "the graph should update with the selected options"),
      code = {
      testthat::expect_true(TRUE)
    })
  })
#> Test passed 🎊
```
