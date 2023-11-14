
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bddR

<!-- badges: start -->
<!-- badges: end -->

The goal of `bddR` is to …

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

``` r
testthat::test_that("
  Feature:
      As a user
      I want to see the changes in the plot
      So that I can visualize the impact of my customizations
  ", code = {
  testthat::expect_true(TRUE)
})
#> Test passed 🎊
```

``` r
my_feature <- feature(
    As_a = "user",
    I_want = "to see the changes in the plot", 
   So_that = "I can visualize the impact of my customizations")
```

``` r
my_feature
#>   Feature:
#>    As a user
#>    I want to see the changes in the plot
#>    So that I can visualize the impact of my customizations
```

``` r
class(my_feature)
#> [1] "glue"      "character"
```

``` r
testthat::test_that(my_feature, code = {
  testthat::expect_true(TRUE)
})
#> Test passed 😸
```

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
#> Test passed 🥳
```

``` r
my_scenario <- scenario(
                 Given = "I have launched the application",
                 And = list("it contains movie review data from IMDB and Rotten Tomatoes",
                            "the data contains variables like 'Critics Score' and 'MPAA'"),
                 When = "I interact with the sidebar controls",
                 Then = "the graph should update with the selected options")
my_scenario
#>   Scenario:
#>    Given I have launched the application
#>    And it contains movie review data from IMDB and Rotten Tomatoes
#>    And the data contains variables like 'Critics Score' and 'MPAA'
#>    When I interact with the sidebar controls
#>    Then the graph should update with the selected options
```

``` r
testthat::describe(
  my_feature, 
  code = {
    testthat::it(my_scenario, 
      code = {
      testthat::expect_true(TRUE)
    })
  })
#> Test passed 😸
```
