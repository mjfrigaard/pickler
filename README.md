
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pickler <a href='https://mjfrigaard.github.io/pickler/'><img src='man/figures/logo.png' align="right" height="150" /></a>

<!-- badges: start -->
<!-- badges: end -->

The goal of `pickler` is to provide [Gherkin
syntax](https://cucumber.io/docs/gherkin/) helpers for [`testthat`’s
`describe()` and `it()`
functions](https://testthat.r-lib.org/reference/describe.html).

## Installation

You can install the development version of pickler from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("mjfrigaard/pickler")
```

``` r
library(pickler)
```

``` r
if (!require(pak)) {
  install.packages("pak",
    repos = "http://cran.us.r-project.org"
  )
}
pak::pkg_install("r-lib/testthat", upgrade = TRUE, ask = FALSE)
library(testthat)
```

## Example

Behavior-driven development (BDD) starts with a clearly defined business
goal (or goals). Developers will collaborate with users to ensure each
feature is aligned with a goal and is captured in a plain-language,
real-life scenario. Scenarios are used to write tests to verify the
feature behaves as expected, creating up-to-date documentation on how
the software works (and what it can do).

`pickler` automates this process by compiling the features (in
`describe()`), scenarios (in `it()` and `test_that()`), and expectations
(`expect_*()` functions) into a `FEATURE.md` markdown report.

`testthat`’s BDD functions allow for more explicit descriptions of
tests:

``` r
describe(description = "verify that you implement the right things", code = {
  it(description = "ensure you do the things right", code = {
    expect_true(TRUE)
  })
})
#> Test passed
```

`pickler` provides a set of helpers for writing
[Gherkin-style](https://cucumber.io/docs/gherkin/reference/) features,
backgrounds and scenarios which can be placed in `describe()` and
`it()`:

``` r
describe(
  feature(
    title = "My thing's feature",
    as_a = "user of this thing",
    i_want = "to verify that I implemented the right thing",
    so_that = "I'm sure I did the thing right"
  ), code = {
  it(
    scenario(
        title = "Example of using thing",
        given = "My package is installed and loaded",
        when = "I do something",
        then = "the right thing happens"
      ), code = {
    expect_true(TRUE)
  })
})
#> Test passed
```

`pickler` functions can also it can be dropped into the `desc` argument
of `test_that()`:

``` r
test_that(
  scenario(
        title = "Example of thing",
        given = "My package is installed and loaded",
        when = "I do something",
        then = "the right thing happens"
      ),
  code = {
    expect_true(TRUE)
  }
)
#> Test passed
```

Check out the [Getting Started
vignette](https://mjfrigaard.github.io/pickler/articles/start.html) to
learn more.
