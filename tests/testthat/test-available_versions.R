test_that("available_ct_versions returns character vector for sdtm", {
  v <- available_ct_versions("sdtm")
  expect_type(v, "character")
  expect_gt(length(v), 0L)
})

test_that("available_ct_versions is in descending order", {
  v <- available_ct_versions("sdtm")
  expect_equal(v, sort(v, decreasing = TRUE))
})

test_that("available_ct_versions returns character vector for adam", {
  v <- available_ct_versions("adam")
  expect_type(v, "character")
  expect_gt(length(v), 0L)
})

test_that("available_ct_versions rejects invalid type", {
  expect_error(available_ct_versions("other"))
})

test_that("available_ct_versions sdtm contains no NA values", {
  v <- available_ct_versions("sdtm")
  expect_false(anyNA(v))
})
