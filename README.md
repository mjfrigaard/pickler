
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
    repos = "http://cran.us.r-project.org"
  )
}
#> Loading required package: pak
pak::pkg_install("r-lib/testthat", upgrade = TRUE, ask = FALSE)
#> ℹ Loading metadata database
#> ✔ Loading metadata database ... done
#>  
#> ℹ No downloads are needed
#> ✔ 1 pkg + 32 deps: kept 33 [8s]
library(testthat)
```

## Features

Adding [Gherkin keywords](https://cucumber.io/docs/gherkin/reference/)
to `describe()` and `it()` can be tiresome.

``` r
test_that("
  Feature: Visualization
      As a user
      I want to see the changes in the plot
      So that I can visualize the impact of my customizations
  ", code = {
  testthat::expect_true(TRUE)
})
#> Test passed
```

`feature()` allows you to simply fill in the arguments:

``` r
feature(
  title = "Visualization",
  as_a = "user",
  i_want = "to see the changes in the plot",
  so_that = "I can visualize the impact of my customizations"
)
#> Feature: Visualization
#>   As a user
#>   I want to see the changes in the plot
#>   So that I can visualize the impact of my customizations
```

It returns a `glue`/`character` string:

``` r
class(
  feature(
    title = "Visualization",
    as_a = "user",
    i_want = "to see the changes in the plot",
    so_that = "I can visualize the impact of my customizations"
  )
)
#> [1] "glue"      "character"
```

So it can be dropped into a test `description`:

``` r
test_that(
  feature(
    title = "Visualization",
    as_a = "user",
    i_want = "to see the changes in the plot",
    so_that = "I can visualize the impact of my customizations"
  ),
  code = {
    expect_true(TRUE)
  }
)
#> Test passed
```

## Scenarios

Scenarios have a `title` with `given`, `when`, `then` (and sometimes
`and`) statements:

``` r
describe(
  feature(
    title = "Visualization",
    as_a = "user",
    i_want = "to see the changes in the plot",
    so_that = "I can visualize the impact of my customizations"
  ),
  code = {
    testthat::it("
      Scenario:
          given
          when
          then
      ", code = {
      testthat::expect_true(TRUE)
    })
  }
)
#> Test passed
```

``` r
describe(
  feature(
    title = "Visualization",
    as_a = "user",
    i_want = "to see the changes in the plot",
    so_that = "I can visualize the impact of my customizations"
  ),
  code = {
    it(
      scenario(
        title = "Viewing the Data Visualization",
        given = "I have launched the application",
        when = "I interact with the sidebar controls",
        then = "the graph should update with the selected options"
      ),
      code = {
        testthat::expect_true(TRUE)
      }
    )
  }
)
#> Test passed
```

We can add an `and` statement for more background/context:

``` r
describe(
  feature(
    title = "Visualization",
    as_a = "user",
    i_want = "to see the changes in the plot",
    so_that = "I can visualize the impact of my customizations"
  ),
  code = {
    it(
      scenario(
        title = "Viewing the Data Visualization",
        given = "I have launched the application",
        and = "it contains movie review data from IMDB and Rotten Tomatoes",
        when = "I interact with the sidebar controls",
        then = "the graph should update with the selected options"
      ),
      code = {
        testthat::expect_true(TRUE)
      }
    )
  }
)
#> Test passed
```

More than one `and`? Just drop them in a `list()`:

``` r
describe(
  feature(
    title = "Visualization",
    as_a = "user",
    i_want = "to see the changes in the plot",
    so_that = "I can visualize the impact of my customizations"
  ),
  code = {
    it(
      scenario(
        title = "Viewing the Data Visualization",
        given = "I have launched the application",
        and = list(
          "it contains movie review data from IMDB and Rotten Tomatoes",
          "the data contains variables like 'Critics Score' and 'MPAA'"
        ),
        when = "I interact with the sidebar controls",
        then = "the graph should update with the selected options"
      ),
      code = {
        testthat::expect_true(TRUE)
      }
    )
  }
)
#> Test passed
```
