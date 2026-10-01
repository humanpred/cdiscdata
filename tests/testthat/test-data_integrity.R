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

# Gap-detection thresholds below are calibrated against verified NCI
# publishing history (checked directly against NCI's own file listing API;
# see data-raw/utils_nci.R's list_archive_dates()), not against an assumed
# fixed cadence, because that assumption does not hold:
#
# - SDTM CT was reliably quarterly (~90-day gaps) from 2015 through
#   2024-03-29, then NCI cleanly shifted to semi-annual releases
#   (March/September, ~182-day gaps) from 2024-09-27 on. No release between
#   2024-03-29 and today is missing - confirmed by directly querying NCI's
#   file-listing API for every "SDTM Terminology <date>.txt" key in the
#   archive - so a bound has to clear the real 182-day gap, not flag it.
# - ADaM CT has never been reliably quarterly even historically: gaps of
#   266-448 days appear repeatedly from 2017 to 2023, well before the 2024
#   SDTM cadence change, because NCI does not publish an ADaM CT release
#   every time it publishes an SDTM one.
#
# A single ~120-day bound (the originally proposed threshold) would treat
# essentially every 2024-on SDTM gap, and most ADaM gaps in any era, as a
# skipped release; each type's threshold instead clears its own real
# maximum observed gap by a comfortable margin while still catching a
# release skipped outright (e.g. a full year with no new SDTM release, or
# no ADaM release for well over its historical worst case).
test_that("no gap between consecutive SDTM CT release dates exceeds 200 days since 2015", {
  dates <- sort(unique(ct_sdtm$valid_from[ct_sdtm$valid_from >= as.Date("2015-01-01")]))
  gaps <- as.numeric(diff(dates))
  worst <- which.max(gaps)
  expect_lt(gaps[worst], 200,
            label = sprintf("gap from %s to %s", dates[worst], dates[worst + 1L]))
})

test_that("no gap between consecutive ADaM CT release dates exceeds 500 days since 2015", {
  dates <- sort(unique(ct_adam$valid_from[ct_adam$valid_from >= as.Date("2015-01-01")]))
  gaps <- as.numeric(diff(dates))
  worst <- which.max(gaps)
  expect_lt(gaps[worst], 500,
            label = sprintf("gap from %s to %s", dates[worst], dates[worst + 1L]))
})

test_that("the latest available SDTM and ADaM CT release is not implausibly stale", {
  # A freshness check independent of the gap tests above: whichever release
  # is newest should be recent (allowing generously for this package's own
  # refresh cadence, not NCI's), so a long-broken fetch workflow is still
  # caught even if every individual historical gap happens to look fine.
  expect_lt(as.numeric(Sys.Date() - max(ct_sdtm$valid_from)), 365)
  expect_lt(as.numeric(Sys.Date() - max(ct_adam$valid_from)), 365)
})
