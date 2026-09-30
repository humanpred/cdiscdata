test_that("SEX codelist is present in latest SDTM CT", {
  ct <- get_ct("sdtm")
  expect_true("C66731" %in% ct$codelist_code)
})

test_that("no SDTM CT version has zero rows", {
  for (v in available_ct_versions("sdtm")) {
    ct <- get_ct("sdtm", version = v)
    expect_gt(nrow(ct), 0L, label = paste("SDTM CT version", v))
  }
})

test_that("no ADaM CT version has zero rows", {
  for (v in available_ct_versions("adam")) {
    ct <- get_ct("adam", version = v)
    expect_gt(nrow(ct), 0L, label = paste("ADaM CT version", v))
  }
})

test_that("valid_from is always <= valid_to when valid_to is not NA", {
  closed <- ct_sdtm[!is.na(ct_sdtm$valid_to), ]
  if (nrow(closed) > 0L) {
    expect_true(all(closed$valid_from <= closed$valid_to))
  }
})

test_that("no NA values in ct_sdtm$valid_from", {
  expect_false(anyNA(ct_sdtm$valid_from))
})

test_that("no NA values in ct_adam$valid_from", {
  expect_false(anyNA(ct_adam$valid_from))
})

test_that("no duplicate current rows for same codelist+term key in SDTM CT", {
  ct <- get_ct("sdtm")  # current rows only (valid_to = NA)
  key <- paste(ct$codelist_code,
               ifelse(is.na(ct$term_code), "<NA>", ct$term_code),
               sep = "||")
  expect_equal(length(key), length(unique(key)))
})

test_that("no duplicate current rows for same codelist+term key in ADaM CT", {
  ct <- get_ct("adam")
  key <- paste(ct$codelist_code,
               ifelse(is.na(ct$term_code), "<NA>", ct$term_code),
               sep = "||")
  expect_equal(length(key), length(unique(key)))
})

test_that("ct_sdtm has expected columns", {
  expect_true(all(c("codelist_code", "codelist_name", "codelist_label",
                    "extensible", "term_code", "term", "decoded_value",
                    "synonyms", "definition", "valid_from", "valid_to") %in%
                    names(ct_sdtm)))
})

test_that("PK parameter and PK unit codelists are present in the latest SDTM CT", {
  ct <- get_ct("sdtm")
  headers <- ct[is.na(ct$term_code), ]
  pk <- headers[headers$codelist_name %in% c("PKPARMCD", "PKPARM", "PKUNIT"), ]
  expect_equal(nrow(pk), 3L)
  expect_equal(pk$codelist_code[pk$codelist_name == "PKPARMCD"], "C85839")
  expect_equal(pk$codelist_code[pk$codelist_name == "PKPARM"], "C85493")
  expect_equal(pk$codelist_code[pk$codelist_name == "PKUNIT"], "C85494")
})

test_that("the current (latest) SDTM and ADaM CT release has no codelist_name/codelist_code gaps", {
  # The NCI SDTM archive has several old (2007-2010, plus one 2017) releases
  # with source-data-level header-row quirks this parser cannot always
  # recover from (see data-raw/utils_nci.R): an unrecognised third
  # header-row convention, and a handful of genuinely malformed lines. Every
  # instance found so far is confined to those archival releases (pinned by
  # the loose historical bound below); what actually matters for any real
  # use of this package - the current release - is asserted strictly here.
  current_sdtm <- get_ct("sdtm")
  expect_false(anyNA(current_sdtm$codelist_name))
  expect_false(anyNA(current_sdtm$codelist_code))
  expect_true(all(nzchar(current_sdtm$codelist_code)))

  current_adam <- get_ct("adam")
  expect_false(anyNA(current_adam$codelist_name))
  expect_false(anyNA(current_adam$codelist_code))
})

test_that("historical codelist_name/codelist_code gaps stay within a known bound", {
  # Loose regression guard (not a precise historical audit - see the
  # previous test) against a future parser change silently reintroducing
  # the 2012-on regression this fix addressed, which affected 100% of rows.
  expect_lt(sum(is.na(ct_sdtm$codelist_name)), 3000L)
  expect_lt(sum(is.na(ct_sdtm$term_code) & is.na(ct_sdtm$codelist_code)), 200L)
})
