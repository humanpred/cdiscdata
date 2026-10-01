test_that("list_datasets returns a data frame", {
  result <- list_datasets()
  expect_s3_class(result, "data.frame")
})

test_that("list_datasets contains expected dataset names", {
  ds <- list_datasets()$dataset
  expect_true(all(c("ct_sdtm", "ct_adam", "ig_sdtm", "model_sdtm", "ig_adam",
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
  expect_true(all(types %in% c("CT", "IG", "Model", "Schema", "Stylesheet")))
})

test_that("list_datasets describes the IG and model tables by standard, counting standard versions", {
  ds <- list_datasets()
  row <- function(name) ds[ds$dataset == name, ]
  expect_equal(row("ig_sdtm")$type, "IG")
  expect_equal(row("model_sdtm")$type, "Model")
  expect_equal(row("ig_adam")$type, "IG")
  expect_equal(c(row("ig_sdtm")$n_versions, row("model_sdtm")$n_versions,
                 row("ig_adam")$n_versions), c(14L, 9L, 11L))
  expect_equal(row("model_sdtm")$versions, "SDTM 1.2 to 2.1")
  expect_match(row("ig_sdtm")$versions, "SDTMIG 3.1.2 to 3.4; SDTMIG-AP 1.0;", fixed = TRUE)
  expect_match(row("ig_adam")$versions, "ADaMIG 1.0 to 1.3; ADaMIG-MD 1.0; ADaMIG-NCA 1.0;",
               fixed = TRUE)
  # one row per standard version, so the counts add up to the 34 exports
  expect_equal(sum(ds$n_versions[ds$type %in% c("IG", "Model")]), 34L)
})
