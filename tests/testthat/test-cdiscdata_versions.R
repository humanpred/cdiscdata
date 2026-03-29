test_that("cdiscdata_versions returns a data frame", {
  v <- cdiscdata_versions()
  expect_s3_class(v, "data.frame")
})

test_that("cdiscdata_versions has required columns", {
  v <- cdiscdata_versions()
  expect_true(all(c("dataset", "type", "description", "latest",
                    "n_versions", "last_updated") %in% names(v)))
})

test_that("cdiscdata_versions includes CT and schema rows", {
  v <- cdiscdata_versions()
  expect_true("CT" %in% v$type)
  expect_true("Schema" %in% v$type)
})

test_that("cdiscdata_versions n_versions is positive for all rows", {
  v <- cdiscdata_versions()
  expect_true(all(v$n_versions > 0L))
})
