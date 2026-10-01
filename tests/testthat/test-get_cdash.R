test_that("get_cdash() defaults to the newest CDASHIG (2.3)", {
  x <- get_cdash()
  expect_s3_class(x, "data.frame")
  expect_equal(unique(x$standard), "CDASHIG")
  expect_equal(unique(x$version), "2.3")
  expect_equal(nrow(x), 1253L)
  expect_equal(names(x), names(get_dataset("ig_cdash")))
  expect_identical(x, get_cdash("CDASHIG"))
})

test_that("get_cdash reaches the CDASH model, newest version 1.3", {
  x <- get_cdash("CDASH")
  expect_equal(unique(x$standard), "CDASH")
  expect_equal(unique(x$version), "1.3")
  expect_equal(nrow(x), 314L)
  expect_equal(names(x), names(get_dataset("cdash_model")))
})

test_that("get_cdash reaches every standard version, with exactly the rows of its export", {
  src <- cdiscdata::ig_sources
  src <- src[src$table %in% c("cdash_model", "ig_cdash"), ]
  expect_equal(nrow(src), 9L)
  for (i in seq_len(nrow(src))) {
    x <- get_cdash(src$standard[i], version = src$version[i])
    expect_equal(nrow(x), src$rows[i], label = paste(src$standard[i], src$version[i]))
    expect_true(all(x$standard == src$standard[i] & x$version == src$version[i]))
  }
  expect_equal(unique(get_cdash("CDASHIG", "1.1")$version), "1.1")
})

test_that("get_cdash filters by domain, and the CDASH model also by class", {
  lb <- get_cdash("CDASHIG", "2.1", "LB")
  expect_equal(nrow(lb), 59L)
  expect_equal(unique(lb$domain), "LB")
  expect_equal(nrow(get_cdash("CDASHIG", "2.3", c("LB", "VS"))),
               nrow(get_cdash("CDASHIG", "2.3", "LB")) + nrow(get_cdash("CDASHIG", "2.3", "VS")))
  findings <- get_cdash("CDASH", domain = "Findings")
  expect_equal(unique(findings$class), "Findings")
  ae <- get_cdash("CDASH", "1.3", "AE")
  expect_gt(nrow(ae), 0L)
  expect_equal(unique(ae$domain), "AE")
})

test_that("get_cdash aborts (classed) on an unknown standard, version, or domain", {
  e <- expect_error(get_cdash("SDTMIG"), class = "cdiscdata_error_ig_standard_unavailable")
  expect_equal(conditionMessage(e),
               "Standard 'SDTMIG' is not available. Available standards: CDASH, CDASHIG.")
  # the lower-case get_ig() aliases mean nothing here
  expect_error(get_cdash("sdtm"), class = "cdiscdata_error_ig_standard_unavailable")
  expect_error(get_cdash(c("CDASH", "CDASHIG")), class = "cdiscdata_error_ig_standard_unavailable")
  expect_error(get_cdash(NA_character_), class = "cdiscdata_error_ig_standard_unavailable")

  ev <- expect_error(get_cdash("CDASHIG", version = "9.9"),
                     class = "cdiscdata_error_ig_version_unavailable")
  expect_equal(conditionMessage(ev),
               "Version '9.9' is not available for CDASHIG. Available versions: 1.1, 2.0, 2.1, 2.2, 2.3.")
  expect_error(get_cdash("CDASH", version = "2.0"), class = "cdiscdata_error_ig_version_unavailable")

  ed <- expect_error(get_cdash("CDASHIG", domain = "ZZ"),
                     class = "cdiscdata_error_ig_domain_unavailable")
  expect_match(conditionMessage(ed),
               "Domain 'ZZ' is not available for standard 'CDASHIG' at version '2.3'. Available: AE, AG, CE,",
               fixed = TRUE)
  ec <- expect_error(get_cdash("CDASH", domain = "ZZ"),
                     class = "cdiscdata_error_ig_domain_unavailable")
  # the CDASH model names classes and domains alike
  expect_match(conditionMessage(ec), "Available: AE, Associated Persons - Identifiers,", fixed = TRUE)
})

test_that("get_ig does not reach the CDASH standards, and get_cdash does not reach the SDTM ones", {
  expect_error(get_ig("CDASHIG"), class = "cdiscdata_error_ig_standard_unavailable")
  expect_error(get_ig("CDASH"), class = "cdiscdata_error_ig_standard_unavailable")
  expect_false(any(c("CDASH", "CDASHIG") %in% get_ig("SDTMIG")$standard))
})

test_that("get_dataset reaches the CDASH and QRS tables whole or by version string", {
  expect_identical(get_dataset("cdash_model"), cdiscdata::cdash_model)
  expect_identical(get_dataset("ig_cdash"), cdiscdata::ig_cdash)
  expect_identical(get_dataset("qrs_supplement"), cdiscdata::qrs_supplement)
  expect_equal(nrow(get_dataset("ig_cdash", version = "2.3")), 1253L)
  expect_equal(nrow(get_dataset("cdash_model", version = "1.1")), 276L)
  # "2.0" is shared by AIMS, KFSS, KPS_SCALE, and the CDASHIG 2.0 is a different table
  q20 <- get_dataset("qrs_supplement", version = "2.0")
  expect_equal(sort(unique(q20$instrument)), c("AIMS", "KFSS", "KPS_SCALE"))
  expect_equal(nrow(q20), 12L + 11L + 1L)
  e <- expect_error(get_dataset("qrs_supplement", version = "9.9"),
                    class = "cdiscdata_error_ig_version_unavailable")
  expect_equal(conditionMessage(e),
               "Version '9.9' is not available in qrs_supplement. Available versions: 1.0, 1.1, 2.0, 2.1.")
})

test_that("list_datasets describes the CDASH and QRS tables by standard or instrument", {
  ds <- list_datasets()
  row <- function(name) ds[ds$dataset == name, ]
  expect_equal(c(row("cdash_model")$type, row("ig_cdash")$type, row("qrs_supplement")$type),
               c("CDASH", "CDASH", "QRS"))
  expect_equal(row("cdash_model")$versions, "CDASH 1.0 to 1.3")
  expect_equal(row("ig_cdash")$versions, "CDASHIG 1.1 to 2.3")
  expect_equal(row("qrs_supplement")$versions,
               paste("AIMS 2.0; APACHE_II 1.0; ATLAS 1.0; CGI 2.1; HAM-A 2.1; KFSS 2.0;",
                     "KPS_SCALE 2.0; PGI 1.1; SIX_MINUTE_WALK 1.0"))
  expect_equal(c(row("cdash_model")$n_versions, row("ig_cdash")$n_versions,
                 row("qrs_supplement")$n_versions), c(4L, 5L, 9L))
  expect_true(all(is.na(c(row("cdash_model")$latest, row("ig_cdash")$latest,
                          row("qrs_supplement")$latest))))
  # one row per export: 34 IG and model, 9 CDASH, 9 QRS
  expect_equal(sum(ds$n_versions[ds$type %in% c("IG", "Model", "CDASH", "QRS")]), 52L)
})
