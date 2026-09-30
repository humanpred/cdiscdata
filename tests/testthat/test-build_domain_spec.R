test_that("build_domain_spec rejects invalid domain", {
  expect_error(build_domain_spec("XX"))
})

test_that("build_domain_spec returns expected columns for PP", {
  pp <- build_domain_spec("PP")
  expect_s3_class(pp, "data.frame")
  expect_equal(names(pp),
               c("variable", "label", "type", "length", "core", "order",
                 "source", "codelist_id"))
  expect_gt(nrow(pp), 0L)
  expect_true(all(pp$source == "SDTMIG"))
})

test_that("build_domain_spec resolves PPTESTCD/PPTEST/PPSTAT codelist ids against CT", {
  pp <- build_domain_spec("PP")
  expect_equal(pp$codelist_id[pp$variable == "PPTESTCD"], "C85839")
  expect_equal(pp$codelist_id[pp$variable == "PPTEST"], "C85493")
  expect_equal(pp$codelist_id[pp$variable == "PPSTAT"], "C66789")
  expect_equal(pp$length[pp$variable == "PPTESTCD"], 8L)
})

test_that("build_domain_spec SUPPPP returns the 10 standard SUPP-- variables", {
  supp <- build_domain_spec("SUPPPP")
  expect_setequal(
    supp$variable,
    c("STUDYID", "RDOMAIN", "USUBJID", "IDVAR", "IDVARVAL", "QNAM",
      "QLABEL", "QVAL", "QORIG", "QEVAL")
  )
})

test_that("build_domain_spec ADPP defaults to exactly one (the newest) ADaMIG version", {
  adpp <- build_domain_spec("ADPP")
  expect_gt(nrow(adpp), 0L)
  expect_equal(sum(duplicated(adpp$variable)), 0L)
})

test_that("build_domain_spec ADPP with an explicit older version differs from the default", {
  adpp_latest <- build_domain_spec("ADPP", ig_version = "1.0")
  adpp_default <- build_domain_spec("ADPP")
  expect_false(identical(sort(adpp_latest$variable), sort(adpp_default$variable)))
})

test_that("build_domain_spec ADPP defaults to adsl = TRUE and unions ADSL variables", {
  adpp <- build_domain_spec("ADPP")
  expect_true(all(c("BDS", "ADSL") %in% adpp$source))
  # ADSL-only variables (not also defined by BDS) are present...
  expect_true("ARM" %in% adpp$variable[adpp$source == "ADSL"])
  # ...marked Perm regardless of their Core designation in ADSL itself
  # (ARM is "Req" in ADSL_Treatment_Variables.csv)
  expect_equal(adpp$core[adpp$variable == "ARM"], "Perm")
  # no duplicates even though BDS and ADSL share base identifier variables
  expect_equal(sum(duplicated(adpp$variable)), 0L)
})

test_that("build_domain_spec ADPP with adsl = FALSE returns BDS variables only", {
  adpp <- build_domain_spec("ADPP", adsl = FALSE)
  expect_true(all(adpp$source == "BDS"))
  expect_false("ARM" %in% adpp$variable)
})

test_that("shared BDS/ADSL variables keep the BDS version, not duplicated", {
  adpp <- build_domain_spec("ADPP")
  expect_equal(adpp$source[adpp$variable == "STUDYID"], "BDS")
  expect_equal(sum(adpp$variable == "STUDYID"), 1L)
})

test_that("build_domain_spec warns (classed) when adsl is passed for a non-ADPP domain", {
  w <- expect_warning(
    build_domain_spec("PP", adsl = FALSE),
    class = "cdiscdata_warning_adsl_ignored"
  )
  expect_match(conditionMessage(w), "ignored", fixed = TRUE)
})

test_that("build_domain_spec aborts (classed) on unknown ig_version", {
  e_pp <- expect_error(
    build_domain_spec("PP", ig_version = "9.9"),
    class = "cdiscdata_error_ig_version_unavailable"
  )
  expect_match(conditionMessage(e_pp), "not available", fixed = TRUE)

  e_adpp <- expect_error(
    build_domain_spec("ADPP", ig_version = "9.9"),
    class = "cdiscdata_error_ig_version_unavailable"
  )
  expect_match(conditionMessage(e_adpp), "not available", fixed = TRUE)
})

test_that("build_domain_spec aborts informatively on unknown ct_version", {
  expect_error(build_domain_spec("PP", ct_version = "1900-01-01"), regexp = "not available")
})

test_that("build_domain_spec aborts (classed) when an SDTMIG version has no PP/SUPPQUAL rows", {
  # Not reachable via the public API with the currently bundled ig_sdtm
  # (SDTMIG's one version, 3.2, always has both PP and SUPPQUAL rows); this
  # exercises the defensive check directly by mocking get_ig() to return a
  # version that validates but has no rows for either domain.
  fake_sdtm <- data.frame(
    source = "SDTMIG", version = "9.9", class = NA_character_,
    domain = "OTHER", order = 1L, variable = "X", label = "X", type = "Char",
    role = NA_character_, core = "Req", codelist = NA_character_,
    length = NA_integer_, notes = NA_character_, stringsAsFactors = FALSE
  )
  testthat::local_mocked_bindings(
    get_ig = function(standard, version = NULL) {
      if (standard == "sdtm") fake_sdtm else get_ig(standard, version)
    },
    .package = "cdiscdata"
  )
  e <- expect_error(
    build_domain_spec("PP"),
    class = "cdiscdata_error_no_ig_variables"
  )
  expect_match(conditionMessage(e), "No SDTMIG 'PP' variables found", fixed = TRUE)
})

test_that("build_domain_spec aborts (classed) when an ADaMIG version has no BDS rows", {
  # Same rationale as the SDTMIG test above: not reachable with the
  # currently bundled ig_adam (every version has BDS rows), so mocked.
  fake_adam <- data.frame(
    dataset = "OTHER", version = "9.9", category = "X", order = 1L,
    variable = "X", label = "X", type = "Char", core = "Req",
    codelist = NA_character_, length = NA_integer_, notes = NA_character_,
    stringsAsFactors = FALSE
  )
  testthat::local_mocked_bindings(
    get_ig = function(standard, version = NULL) {
      if (standard == "adam") fake_adam else get_ig(standard, version)
    },
    .package = "cdiscdata"
  )
  e <- expect_error(
    build_domain_spec("ADPP"),
    class = "cdiscdata_error_no_ig_variables"
  )
  expect_match(conditionMessage(e), "No ADaMIG BDS variables found", fixed = TRUE)
})
