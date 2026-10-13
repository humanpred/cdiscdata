test_that("get_dataset aborts on invalid name", {
  expect_error(
    get_dataset("not_a_real_dataset"),
    regexp = "not a valid dataset name"
  )
})

test_that("get_dataset returns data frame for ct_sdtm", {
  result <- get_dataset("ct_sdtm")
  expect_s3_class(result, "data.frame")
  expect_gt(nrow(result), 0L)
})

test_that("get_dataset returns data frame for ct_adam", {
  result <- get_dataset("ct_adam")
  expect_s3_class(result, "data.frame")
  expect_gt(nrow(result), 0L)
})

test_that("get_dataset returns file path for define_xml_schema", {
  path <- get_dataset("define_xml_schema")
  expect_type(path, "character")
  expect_true(file.exists(path))
})

test_that("get_dataset returns file path for define_xml_stylesheet", {
  path <- get_dataset("define_xml_stylesheet")
  expect_type(path, "character")
  expect_true(file.exists(path))
})

test_that("get_dataset schema version argument is respected", {
  path_21 <- get_dataset("define_xml_schema", version = "2.1")
  path_20 <- get_dataset("define_xml_schema", version = "2.0")
  expect_false(identical(path_21, path_20))
})

test_that("get_dataset returns the whole IG and model tables when no version is given", {
  expect_identical(get_dataset("ig_sdtm"), cdiscdata::ig_sdtm)
  expect_identical(get_dataset("model_sdtm"), cdiscdata::model_sdtm)
  expect_identical(get_dataset("ig_adam"), cdiscdata::ig_adam)
  expect_equal(c(nrow(get_dataset("ig_sdtm")), nrow(get_dataset("model_sdtm")),
                 nrow(get_dataset("ig_adam"))), c(10064L, 3604L, 1804L))
})

test_that("get_dataset(version =) restricts an IG or model table to that version string, across standards", {
  a13 <- get_dataset("ig_adam", version = "1.3")
  expect_equal(unique(a13$version), "1.3")
  expect_equal(unique(a13$standard), "ADaMIG")
  expect_equal(nrow(a13), nrow(get_ig("ADaMIG", "1.3")))
  expect_equal(nrow(a13), 195L + 141L)
  # "1.0" is shared by many standards, and all of them come back
  a10 <- get_dataset("ig_adam", version = "1.0")
  expect_equal(unique(a10$version), "1.0")
  expect_gt(length(unique(a10$standard)), 1L)
  m21 <- get_dataset("model_sdtm", version = "2.1")
  expect_equal(unique(m21$standard), "SDTM")
  expect_equal(nrow(m21), nrow(get_ig("SDTM", "2.1")))
  # only SDTMIG has a 3.4
  expect_equal(nrow(get_dataset("ig_sdtm", version = "3.4")), 1917L)
})

test_that("get_dataset aborts (classed) on a version no standard in the IG table has", {
  e <- expect_error(get_dataset("ig_adam", version = "9.9"),
                    class = "cdiscdata_error_ig_version_unavailable")
  expect_equal(conditionMessage(e),
               "Version '9.9' is not available in ig_adam. Available versions: 1.0, 1.1, 1.2, 1.3.")
  expect_error(get_dataset("model_sdtm", version = "3.4"),
               class = "cdiscdata_error_ig_version_unavailable")
})
