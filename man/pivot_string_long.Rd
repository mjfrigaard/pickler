% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pivot_string_long.R
\name{pivot_string_long}
\alias{pivot_string_long}
\title{Pivot a string into a long data frame format}
\usage{
pivot_string_long(string, sep = "[^[:alnum:]]+")
}
\arguments{
\item{string}{A character vector; the string or strings to split.}

\item{sep}{A regular expression used as the separator to split the string(s)
into items. The default is "[^\link{:alnum:}]+", which splits based on one or
more non-alphanumeric characters.}
}
\value{
A data frame with two columns: \code{unique_items}, containing the unique
items extracted from the string(s), and \code{string}, containing the original
string(s).  Each row represents a unique item from the string(s), with the
original string(s) placed at the first row of each \code{unique_item}.
}
\description{
\code{pivot_string_long()} splits a string (or vector of strings) into its
constituent parts based on a specified regex pattern and returns a 'tidy'
(long) \code{data.frame}.
}
\section{Note}{

The function handles vectors of strings by applying the splitting and data
frame creation process to each element of the vector and then row-binding
the individual data frames into a single data frame. The returned \code{string}
column contains the original string and \code{length(unlist(strsplit(x))) - 1}
missing values
}

\section{Details}{

If a single string is provided, the function will split that string into
items and return a \code{data.frame} with each item and the original string. If a
vector of strings is provided, the function applies the splitting process
to each string in the vector and combines the results into a single
\code{data.frame}.
}

\examples{
pivot_string_long("one-two-three")
# include white space
pivot_string_long(
  c("apple, orange, banana", "cat-dog"),
   sep = ",?\\\\s*-?\\\\s*")
# longer strings
pivot_string_long("A large size in stockings is hard to sell.")
# larger strings
pivot_string_long(c("A large size in stockings is hard to sell.",
                    "The first part of the plan needs changing." ))
}
