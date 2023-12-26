Tests and Coverage
================
11 December, 2023 21:55:29

- [Coverage](#coverage)
- [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                                                    | Coverage (%) |
|:--------------------------------------------------------------------------|:------------:|
| pickler                                                                   |    100.00    |
| [R/pivot_string_long.R](../R/pivot_string_long.R)                         |    100.00    |
| [R/rev_string.R](../R/rev_string.R)                                       |    100.00    |
| [R/split_cols.R](../R/split_cols.R)                                       |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                                          |   n |  time | error | failed | skipped | warning |
|:--------------------------------------------------------------|----:|------:|------:|-------:|--------:|--------:|
| [test-pivot_string_long.R](testthat/test-pivot_string_long.R) |  13 | 0.196 |     0 |      0 |       0 |       0 |
| [test-rev_string.R](testthat/test-rev_string.R)               |   6 | 0.062 |     0 |      0 |       0 |       0 |
| [test-split_cols.R](testthat/test-split_cols.R)               |  17 | 0.159 |     0 |      0 |       0 |       0 |

<details closed>
<summary>
Show Detailed Test Results
</summary>

| file                                                              | context           | test                                          | status |   n | time |
|:------------------------------------------------------------------|:------------------|:----------------------------------------------|:-------|----:|-----:|
| [test-pivot_string_long.R](testthat/test-pivot_string_long.R#L17) | pivot_string_long | Feature: Pivot Single String into Long Format |        |     |      |

As a user, I want to pivot a single string into a long-format data.frame
based on a separator So that I can analyze each unique item in the
string separately.: Scenario 1: Pivot a single string using a default
separator Given a single string ‘a-b-c’ And a default separator:
\[^\[:alnum:\]\]+ When I call the pivot_string_long() function with this
string Then pivot_string_long() should return a data.frame with
‘unique_items’ and ‘string’ columns And the data.frame should contain
each unique item from the string And the ‘string’ column should contain
the original string for each unique item \|PASS \| 5\| 0.104\|
\|[test-pivot_string_long.R](testthat/test-pivot_string_long.R#L34)\|pivot_string_long
\|Feature: Pivot Single String into Long Format As a user, I want to
pivot a single string into a long-format data.frame based on a separator
So that I can analyze each unique item in the string separately.:
Scenario 2: Pivot multiple strings using a default separator Given a
vector of strings: c(‘a-b-c’, ‘d-e-f’) And a default separator
\[^\[:alnum:\]\]+ When I call the pivot_string_long() function with
these strings Then pivot_string_long() should return a combined
data.frame for all strings And each unique item from each string should
be in the ‘unique_items’ column And the corresponding original strings
should be in the ‘string’ column \|PASS \| 4\| 0.039\|
\|[test-pivot_string_long.R](testthat/test-pivot_string_long.R#L50)\|pivot_string_long
\|Feature: Pivot Single String into Long Format As a user, I want to
pivot a single string into a long-format data.frame based on a separator
So that I can analyze each unique item in the string separately.:
Scenario 3: Pivot a string using a custom separator Given a single
string ‘a1b2c’ And a custom separator ‘ When I call pivot_string_long()
with this string and separator Then the returned data.frame should
contain the unique items split by the custom separator And the ’string’
column should contain the original string for each unique item \|PASS \|
3\| 0.025\|
\|[test-pivot_string_long.R](testthat/test-pivot_string_long.R#L64_L65)\|pivot_string_long
\|Feature: Pivot Single String into Long Format As a user, I want to
pivot a single string into a long-format data.frame based on a separator
So that I can analyze each unique item in the string separately.:
Scenario 4: Provide an error message when an invalid separator is used
Given a single string ‘a-b-c’ And an invalid separator ’(\*)’ When I
call the pivot_string_long() function with this string and separator
Then the returned error should be ‘invalid regular expression’ \|PASS \|
1\| 0.028\|
\|[test-rev_string.R](testthat/test-rev_string.R#L12)\|rev_string
\|Scenario 1a: Reverse a simple string ‘hello’ Given a string ‘hello’
When I use the rev_string() function Then the output should be ‘olleh’
\|PASS \| 1\| 0.010\|
\|[test-rev_string.R](testthat/test-rev_string.R#L26)\|rev_string
\|Scenario 2a: Reverse another simple string ‘goodbye’ Given a string
‘goodbye’’ When I use the rev_string() function Then the output should
be ‘eybdoog’ \|PASS \| 1\| 0.011\|
\|[test-rev_string.R](testthat/test-rev_string.R#L41)\|rev_string
\|Feature: 1b Reverse a Mixed Case String As a user, I want to reverse
the characters in a string So that I can have the string displayed in
reverse order.: Scenario: Reverse a mixed case string ‘HeLlO’ Given a
string ‘HeLlO’ When I use the rev_string() function Then the output
should be ‘OlLeH’ \|PASS \| 1\| 0.011\|
\|[test-rev_string.R](testthat/test-rev_string.R#L55)\|rev_string
\|Feature: 2b: Reverse Another Mixed Case String As a user, I want to
reverse the characters in a string So that I can have the string
displayed in reverse order.: Scenario: Reverse another mixed case string
‘gOoDbYe’ Given a string ‘gOoDbYe’ When I use the rev_string() function
Then the output should be ‘eYbDoOg’ \|PASS \| 1\| 0.010\|
\|[test-rev_string.R](testthat/test-rev_string.R#L66)\|rev_string
\|Feature 3a: Reverse an Already Reversed String Scenario: Reverse an
already reversed string ‘OlLeH’ Given a string ‘OlLeH’ When I use the
rev_string() function Then the output should be ‘HeLlO’ \|PASS \| 1\|
0.010\|
\|[test-rev_string.R](testthat/test-rev_string.R#L76)\|rev_string
\|Feature 3b: Reverse a Complex String with Spaces Scenario: Reverse a
complex string with spaces ‘OlLeH eYbDoOg’ Given a string ‘OlLeH
eYbDoOg’ When I use the rev_string function Then the output should be
‘gOoDbYe HeLlO’ \|PASS \| 1\| 0.010\|
\|[test-split_cols.R](testthat/test-split_cols.R#L19)\|split_cols
\|Feature: Splitting Columns in data.frame As a data analyst, I want to
split a specified column into multiple columns based on a pattern So
that I can analyze the separated data more effectively.: Scenario A:
Split a column using the default pattern and prefix Given a data.frame
with a specific column And a default pattern ‘\[^\[:alnum:\]\]+’ And a
default column prefix ‘col’ When I call the split_cols() function on
this column Then the column should be split into multiple columns based
on the pattern And each new column should have the ‘col’ prefix followed
by a sequence number And the new columns should be appended to the
original data.frame \|PASS \| 5\| 0.043\|
\|[test-split_cols.R](testthat/test-split_cols.R#L38)\|split_cols
\|Feature: Splitting Columns in data.frame As a data analyst, I want to
split a specified column into multiple columns based on a pattern So
that I can analyze the separated data more effectively.: Scenario B:
Split a column in a data.frame using a custom pattern Given a data.frame
with a specific column And a custom pattern specified by the user When I
call the split_cols() function on this column with the custom pattern
Then the column should be split into multiple columns based on the
custom pattern And each new column should be prefixed with ‘col’
followed by a sequence number And the new columns should be appended to
the original data.frame \|PASS \| 5\| 0.043\|
\|[test-split_cols.R](testthat/test-split_cols.R#L56)\|split_cols
\|Feature: Splitting Columns in data.frame As a data analyst, I want to
split a specified column into multiple columns based on a pattern So
that I can analyze the separated data more effectively.: Scenario C:
Split a column in a data.frame using a custom column prefix Given a
data.frame with a specific column And a custom column prefix specified
by the user When I call the split_cols() function on this column with
the custom prefix Then the column should be split into multiple columns
based on the default pattern And each new column have the custom prefix
followed by a sequence number And the new columns should be appended to
the original data.frame \|PASS \| 5\| 0.036\|
\|[test-split_cols.R](testthat/test-split_cols.R#L69_L70)\|split_cols
\|Feature: Splitting Columns in data.frame As a data analyst, I want to
split a specified column into multiple columns based on a pattern So
that I can analyze the separated data more effectively.: Scenario D:
Provide an error message when the input data is not a data frame Given a
non-data frame input When I call the split_cols() function Then
split_cols() should returned an error \|PASS \| 1\| 0.022\|
\|[test-split_cols.R](testthat/test-split_cols.R#L79_L80)\|split_cols
\|Feature: Splitting Columns in data.frame As a data analyst, I want to
split a specified column into multiple columns based on a pattern So
that I can analyze the separated data more effectively.: Scenario E:
Provide an error message when the specified column is not in the
data.frame Given a data.frame without a specified column When I call the
split_cols() function with this column name Then split_cols() should
returned an error \|PASS \| 1\| 0.015\|

</details>
<details>
<summary>
Session Info
</summary>

| Field    | Value                          |
|:---------|:-------------------------------|
| Version  | R version 4.3.1 (2023-06-16)   |
| Platform | x86_64-apple-darwin20 (64-bit) |
| Running  | macOS Sonoma 14.1.2            |
| Language | en_US                          |
| Timezone | America/Phoenix                |

| Package  | Version    |
|:---------|:-----------|
| testthat | 3.2.1.9000 |
| covr     | 3.6.4      |
| covrpage | 0.2        |

</details>
<!--- Final Status : pass --->
