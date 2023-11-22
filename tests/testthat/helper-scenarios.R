output <- data.frame(
  value = 1:3,
  name = c("John", "John, Jacob", "John, Jacob, Jingleheimer"),
  col_1 = c("John", "John", "John"),
  col_2 = c(NA, "Jacob", "Jacob"),
  col_3 = c(NA, NA, "Jingleheimer"))

with_table(output)
