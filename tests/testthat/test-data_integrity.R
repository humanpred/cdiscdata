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

# Mechanical gate on the IG tables' identifying text, so the transcription
# problems found by nca.reporter when writing XPT v5 files (40-character
# variable-label limit, SDTMIG 3.3 section 4.2.1) cannot recur unnoticed:
# hard-wrapped labels with embedded newlines, over-length labels, section
# sub-headings transcribed as variables (NA label), and variable names with
# trailing whitespace (e.g. "--TESTCD " never equals "--TESTCD").
ig_tables_for_gate <- function() {
  list(ig_sdtm = get_ig("sdtm"), ig_adam = get_ig("adam"))
}

# The one label the guides themselves publish longer than 40 characters, kept
# as published (decision: shortening a label for an XPT file is the dataset
# writer's job, not cdiscdata's). An exact match on table, version, variable
# and text, so any other over-length label, or this one changing, still fails.
ig_over_length_allowed <- data.frame(
  table    = "ig_adam",
  dataset  = "BDS",
  version  = "1.2",
  variable = "PBCHGCyN",
  label    = "Percent Change to Baseline Category y (N)",
  reason   = paste("Published at 41 characters in ADaMIG v1.2 (draft, CDISC wiki),",
                   "section 3.3.4.1, Table 3.3.4.1.1 Analysis Parameter Variables",
                   "for BDS Datasets; the sibling PCHGCAyN is published abbreviated."),
  stringsAsFactors = FALSE
)

test_that("no IG label is NA, contains a newline, or exceeds 40 characters (bar the documented exception)", {
  for (nm in names(ig_tables_for_gate())) {
    tbl <- ig_tables_for_gate()[[nm]]
    expect_false(anyNA(tbl$label), label = paste(nm, "has an NA label"))
    expect_false(any(grepl("[\r\n]", tbl$label)),
                 label = paste(nm, "has a label containing a newline"))
    too_long <- nchar(tbl$label) > 40L
    if ("dataset" %in% names(tbl)) {
      key <- paste(tbl$dataset, tbl$version, tbl$variable, tbl$label, sep = "\r")
      allowed <- ig_over_length_allowed[ig_over_length_allowed$table == nm, ]
      allowed_key <- paste(allowed$dataset, allowed$version, allowed$variable,
                           allowed$label, sep = "\r")
      too_long <- too_long & !key %in% allowed_key
    }
    expect_equal(tbl$variable[too_long], character(0L),
                 label = paste(nm, "variables whose label exceeds 40 characters"))
  }
})

test_that("the over-length allow-list is exactly the published 41-character PBCHGCyN label and nothing stale", {
  adam <- get_ig("adam")
  row <- adam[adam$dataset == "BDS" & adam$version == "1.2" & adam$variable == "PBCHGCyN", ]
  expect_equal(nrow(row), 1L)
  expect_equal(row$label, ig_over_length_allowed$label)
  expect_equal(nchar(row$label), 41L)
  # every other ig_adam / ig_sdtm label is within the limit
  expect_equal(sum(nchar(adam$label) > 40L), 1L)
  expect_equal(sum(nchar(get_ig("sdtm")$label) > 40L), 0L)
})

test_that("no IG variable name is NA, blank, or contains whitespace", {
  for (nm in names(ig_tables_for_gate())) {
    tbl <- ig_tables_for_gate()[[nm]]
    expect_false(anyNA(tbl$variable), label = paste(nm, "has an NA variable"))
    expect_equal(tbl$variable[!nzchar(tbl$variable)], character(0L))
    expect_equal(tbl$variable[grepl("[[:space:]]", tbl$variable)], character(0L),
                 label = paste(nm, "variable names containing whitespace"))
  }
})

test_that("IG categorical fields carry no leading/trailing or doubled whitespace", {
  for (nm in names(ig_tables_for_gate())) {
    tbl <- ig_tables_for_gate()[[nm]]
    for (col in intersect(c("type", "core", "codelist", "role"), names(tbl))) {
      v <- tbl[[col]]
      v <- v[!is.na(v)]
      expect_equal(v[v != trimws(v) | grepl("[[:space:]]{2,}|[\r\n]", v)], character(0L),
                   label = paste(nm, col, "values with stray whitespace"))
    }
  }
})

test_that("the SDTM IG labels that exceeded 40 characters are the abbreviated published forms", {
  sdtm <- get_ig("sdtm")
  testcd <- sdtm[sdtm$source == "SDTM_MODEL" & sdtm$variable == "--TESTCD" &
                   sdtm$version %in% c("1.4", "1.5", "1.6"), ]
  expect_equal(sort(testcd$version), c("1.4", "1.5", "1.6"))
  expect_equal(testcd$label, rep("Short Name of Measurement, Test or Exam", 3L))
  ppstresc <- sdtm[sdtm$variable == "PPSTRESC" & sdtm$source == "SDTMIG", ]
  expect_equal(sort(ppstresc$version), c("3.2", "3.3"))
  expect_equal(ppstresc$label, rep("Character Result/Finding in Std Format", 2L))

})

test_that("ADaMIG 1.0 ADSL section sub-headings are not transcribed as variables", {
  adsl_10 <- get_ig("adam", version = "1.0")
  adsl_10 <- adsl_10[adsl_10$dataset == "ADSL", ]
  expect_false(any(c("Study Identifiers", "Subject Demographics",
                     "Population Indicator(s)", "Treatment Variables",
                     "Trial Dates") %in% adsl_10$variable))
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
