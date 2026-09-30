test_that("get_ig returns a data frame for sdtm and adam", {
  expect_s3_class(get_ig("sdtm"), "data.frame")
  expect_s3_class(get_ig("adam"), "data.frame")
})

test_that("get_ig rejects invalid standard", {
  expect_error(get_ig("other"))
})

test_that("get_ig(version = NULL) returns every source/version", {
  sdtm <- get_ig("sdtm")
  expect_setequal(unique(sdtm$source), c("SDTM_MODEL", "SDTMIG"))
  expect_setequal(sdtm$version[sdtm$source == "SDTM_MODEL"], c("1.4", "1.5", "1.6", "1.7"))
  expect_setequal(sdtm$version[sdtm$source == "SDTMIG"], "3.2")

  adam <- get_ig("adam")
  expect_setequal(unique(adam$version), c("1.0", "1.1", "1.2"))
  expect_setequal(unique(adam$dataset), c("ADSL", "BDS"))
})

test_that("get_ig filters to one version when given", {
  sdtm_32 <- get_ig("sdtm", version = "3.2")
  expect_true(all(sdtm_32$version == "3.2"))
  expect_true(all(sdtm_32$source == "SDTMIG"))

  adam_10 <- get_ig("adam", version = "1.0")
  expect_true(all(adam_10$version == "1.0"))
})

test_that("get_ig aborts (classed) on unknown version", {
  e_sdtm <- expect_error(
    get_ig("sdtm", version = "9.9"),
    class = "cdiscdata_error_ig_version_unavailable"
  )
  expect_match(conditionMessage(e_sdtm), "not available", fixed = TRUE)

  e_adam <- expect_error(
    get_ig("adam", version = "9.9"),
    class = "cdiscdata_error_ig_version_unavailable"
  )
  expect_match(conditionMessage(e_adam), "not available", fixed = TRUE)
})

test_that("ig_sdtm has expected columns and no NA variable/version", {
  ig <- get_ig("sdtm")
  expect_true(all(c("source", "version", "class", "domain", "order",
                    "variable", "label", "type", "role", "core", "codelist",
                    "length", "notes") %in% names(ig)))
  expect_false(anyNA(ig$variable))
  expect_false(anyNA(ig$version))
})

test_that("ig_adam has expected columns and no NA variable/version", {
  ig <- get_ig("adam")
  expect_true(all(c("dataset", "version", "category", "order", "variable",
                    "label", "type", "core", "codelist", "length", "notes") %in%
                    names(ig)))
  expect_false(anyNA(ig$variable))
  expect_false(anyNA(ig$version))
})

test_that("SDTMIG PP domain contains PPTESTCD with the PKPARMCD codelist token", {
  pp <- get_ig("sdtm", version = "3.2")
  pp <- pp[pp$domain == "PP", ]
  expect_true("PPTESTCD" %in% pp$variable)
  expect_equal(pp$codelist[pp$variable == "PPTESTCD"], "PKPARMCD")
  expect_equal(pp$length[pp$variable == "PPTESTCD"], 8L)
})

test_that("SUPPQUAL structure has the 10 standard SUPP-- variables", {
  supp <- get_ig("sdtm", version = "3.2")
  supp <- supp[supp$domain == "SUPPQUAL", ]
  expect_setequal(
    supp$variable,
    c("STUDYID", "RDOMAIN", "USUBJID", "IDVAR", "IDVARVAL", "QNAM",
      "QLABEL", "QVAL", "QORIG", "QEVAL")
  )
})
