% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_describes.R
\name{get_describes}
\alias{get_describes}
\title{Read describes in test file}
\usage{
get_describes(test_file)
}
\arguments{
\item{test_file}{path to test file}
}
\value{
data.frame with \code{test_file}, \code{test_contents}, \code{describe} and \code{type}

data.frame with \code{test_file}, \code{describe} and \code{description}
}
\description{
Read describes in test file
}
\examples{
get_describes(test_file = system.file("tests", "testthat",
                                      "test-rev_string.R",
                                      package = "pickler"))
}
