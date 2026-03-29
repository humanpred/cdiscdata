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
