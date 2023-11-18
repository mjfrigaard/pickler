# describe(
#   feature(title = "Text-based Logo Generation",
#     as_a = "As a user who calls the text_logo() function",
#     i_want = "to generate a text-based logo",
#     so_that = "I can quickly insert the pickler logo"
#     ), {
#       test_that("pickler_logo", code = {
#         expect_snapshot(pickler_logo())
#       })
# })
test_that("Feature: Text-based Logo Generation
  As a As a user who calls the text_logo() function
  I want to generate a text-based logo
  So that I can quickly insert the pickler logo", code = {
        expect_snapshot(pickler_logo())
      })
