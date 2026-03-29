check_cols <- cdiscdata:::.check_columns

test_that(".check_columns returns df invisibly when all columns present", {
  df <- data.frame(a = 1L, b = "x", stringsAsFactors = FALSE)
  result <- check_cols(df, c("a", "b"), "test_df")
  expect_identical(result, df)
})

test_that(".check_columns errors with informative message when column is missing", {
  df <- data.frame(a = 1L)
  expect_error(
    check_cols(df, c("a", "b", "c"), "my_df"),
    regexp = "my_df is missing required columns: b, c"
  )
})
