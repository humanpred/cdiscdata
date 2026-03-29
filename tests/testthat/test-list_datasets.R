test_that("list_datasets returns a data frame", {
  result <- list_datasets()
  expect_s3_class(result, "data.frame")
})

test_that("list_datasets contains expected dataset names", {
  ds <- list_datasets()$dataset
  expect_true(all(c("ct_sdtm", "ct_adam",
                    "define_xml_schema", "define_xml_stylesheet") %in% ds))
})

test_that("list_datasets has required columns", {
  ds <- list_datasets()
  expect_true(all(c("dataset", "type", "ct_type", "description",
                    "versions", "n_versions", "latest", "last_updated") %in%
                    names(ds)))
})

test_that("list_datasets type values are expected set", {
  types <- unique(list_datasets()$type)
  expect_true(all(types %in% c("CT", "Schema", "Stylesheet")))
})
