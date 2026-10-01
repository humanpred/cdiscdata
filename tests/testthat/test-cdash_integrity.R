# Mechanical gates on the CDASH and QRS tables (cdash_model, ig_cdash,
# qrs_supplement), built from the CDISC Library exports by
# data-raw/build_ig.R. The same hazards as the IG tables apply (over-length
# labels, stray whitespace, a file loaded twice or not at all), plus one
# specific to these exports: the guides' prose columns run to paragraphs and
# must not land in the data.

cdash_gate_tables <- function() {
  list(
    cdash_model    = get_dataset("cdash_model"),
    ig_cdash       = get_dataset("ig_cdash"),
    qrs_supplement = get_dataset("qrs_supplement")
  )
}

cdash_keys <- list(
  cdash_model    = c("standard", "version", "class", "domain", "variable"),
  ig_cdash       = c("standard", "version", "domain", "scenario", "variable"),
  qrs_supplement = c("instrument", "version", "item_order")
)

# What a table's version is grouped by: the standard, or for the QRS
# supplements the instrument.
cdash_group_col <- c(cdash_model = "standard", ig_cdash = "standard",
                     qrs_supplement = "instrument")

cdash_sources <- function() {
  src <- cdiscdata::ig_sources
  src[src$table %in% names(cdash_keys), ]
}

test_that("each CDASH and QRS table has exactly the documented metadata columns, nothing from the prose", {
  tbls <- cdash_gate_tables()
  expect_equal(names(tbls$cdash_model),
               c("standard", "version", "class", "domain", "order", "variable",
                 "label", "domain_specific", "question_text", "prompt", "type",
                 "sdtm_target", "codelist_code"))
  expect_equal(names(tbls$ig_cdash),
               c("standard", "version", "class", "domain", "scenario", "order",
                 "variable", "label", "question_text", "prompt", "type", "core",
                 "sdtmig_target", "codelist_code", "codelist_submission_value"))
  expect_equal(names(tbls$qrs_supplement),
               c("instrument", "version", "item_order", "test_name",
                 "testcd_codelist_code", "testcd_code", "test_codelist_code",
                 "test_code", "response_group"))
  # The longest value in anything carried is the 274-character question text;
  # the prose columns (definitions, mapping and completion instructions,
  # implementation notes) run to 518, 722, 1408, and 1435, and the QRS item
  # text to 305, so a value past these caps means prose has leaked in.
  caps <- c(cdash_model = 300L, ig_cdash = 300L, qrs_supplement = 60L)
  for (nm in names(tbls)) {
    longest <- vapply(Filter(is.character, tbls[[nm]]),
                      function(v) max(nchar(v), na.rm = TRUE), integer(1L))
    expect_lte(max(longest), caps[[nm]], label = paste("longest text value in", nm))
  }
  expect_equal(max(nchar(tbls$cdash_model$question_text), na.rm = TRUE), 274L)
})

test_that("ig_sources lists the 52 exports: 34 IG and model, 9 CDASH, 9 QRS, none twice", {
  src <- cdiscdata::ig_sources
  expect_equal(nrow(src), 52L)
  by_table <- c(table(src$table))
  expect_equal(by_table[c("ig_sdtm", "model_sdtm", "ig_adam", "cdash_model", "ig_cdash",
                          "qrs_supplement")],
               c(ig_sdtm = 14L, model_sdtm = 9L, ig_adam = 11L, cdash_model = 4L,
                 ig_cdash = 5L, qrs_supplement = 9L))
  expect_false(anyDuplicated(src$file) > 0L)
  expect_false(anyDuplicated(paste(src$table, src$standard, src$version)) > 0L)
  expect_true(all(nchar(src$md5) == 32L))

  cd <- src[src$table %in% c("cdash_model", "ig_cdash"), ]
  expect_setequal(cd$version_string, cdash_version_strings)
  parsed <- cdiscdata:::.parse_ig_version(cd$version_string)
  expect_equal(cd$standard, parsed$standard)
  expect_equal(cd$version, parsed$version)

  qrs <- src[src$table == "qrs_supplement", ]
  expect_setequal(qrs$file, qrs_files)
  expect_true(all(is.na(qrs$version_string)))
  from_name <- cdiscdata:::.parse_qrs_filename(qrs$file)
  expect_equal(qrs$standard, from_name$instrument)
  expect_equal(qrs$version, from_name$version)
  # the version strings of everything that has one all parse
  has <- src[!is.na(src$version_string), ]
  expect_equal(nrow(has), 43L)
  expect_equal(cdiscdata:::.parse_ig_version(has$version_string)$standard, has$standard)
})

test_that("every CDASH and QRS export is loaded exactly once, with as many rows as its file has", {
  src <- cdash_sources()
  tbls <- cdash_gate_tables()
  for (nm in names(tbls)) {
    s <- src[src$table == nm, ]
    col <- cdash_group_col[[nm]]
    got <- table(paste(tbls[[nm]][[col]], tbls[[nm]]$version))
    expect_setequal(names(got), paste(s$standard, s$version))
    expect_equal(as.integer(got[paste(s$standard, s$version)]), s$rows,
                 label = paste("rows loaded into", nm))
  }
  expect_equal(c(nrow(tbls$cdash_model), nrow(tbls$ig_cdash), nrow(tbls$qrs_supplement)),
               c(1138L, 4483L, 75L))
  expect_equal(src$rows[src$table == "cdash_model"], c(270L, 276L, 278L, 314L))
  expect_equal(src$rows[src$table == "ig_cdash"], c(370L, 858L, 927L, 1075L, 1253L))
  expect_equal(src$rows[src$table == "qrs_supplement"], c(12L, 18L, 6L, 3L, 15L, 11L, 1L, 3L, 6L))
  expect_equal(src$standard[src$table == "qrs_supplement"],
               c("AIMS", "APACHE_II", "ATLAS", "CGI", "HAM-A", "KFSS", "KPS_SCALE", "PGI",
                 "SIX_MINUTE_WALK"))
})

test_that("every CDASH and QRS row is unique on its key", {
  tbls <- cdash_gate_tables()
  for (nm in names(tbls)) {
    key <- ig_row_key(tbls[[nm]], cdash_keys[[nm]])
    expect_equal(sum(duplicated(key)), 0L, label = paste("duplicate keys in", nm))
  }
  q <- tbls$qrs_supplement
  expect_false(anyDuplicated(paste(q$instrument, q$test_name)) > 0L)
  expect_false(anyDuplicated(q$test_code) > 0L)
})

test_that("identifying fields are never NA, bar the CDASHIG 1.1 labels, which the guide leaves out", {
  tbls <- cdash_gate_tables()
  expect_false(anyNA(tbls$cdash_model[c("standard", "version", "class", "order", "variable",
                                        "label", "type")]))
  ig <- tbls$ig_cdash
  expect_false(anyNA(ig[c("standard", "version", "class", "domain", "order", "variable",
                          "type", "core")]))
  ex <- cdash_missing_label_exceptions
  na_label <- ig[is.na(ig$label), ]
  expect_equal(nrow(na_label), ex$rows)
  expect_equal(unique(na_label$version), ex$version)
  expect_equal(sum(ig$version == ex$version), ex$rows)
  expect_false(anyNA(tbls$qrs_supplement[c("instrument", "version", "item_order", "test_name",
                                           "testcd_codelist_code", "testcd_code",
                                           "test_codelist_code", "test_code")]))
  for (nm in names(tbls)) {
    v <- tbls[[nm]]$variable
    if (!is.null(v)) {
      expect_equal(v[!nzchar(v) | grepl("[[:space:]]", v)], character(0L), label = nm)
    }
  }
})

test_that("labels have no newline and none exceeds 40 characters except the 77 the guides publish longer", {
  tbls <- cdash_gate_tables()
  found <- do.call(rbind, lapply(c("cdash_model", "ig_cdash"), function(nm) {
    tbl <- tbls[[nm]]
    expect_false(any(grepl("[\r\n]", tbl$label)), label = paste(nm, "label with a newline"))
    i <- which(nchar(tbl$label) > 40L)
    where <- if (nm == "cdash_model") tbl$class else tbl$domain
    scenario <- if (nm == "ig_cdash") tbl$scenario else rep(NA_character_, nrow(tbl))
    data.frame(table = rep(nm, length(i)), standard = tbl$standard[i],
               version = tbl$version[i], where = where[i], scenario = scenario[i],
               variable = tbl$variable[i], nchar = nchar(tbl$label[i]),
               stringsAsFactors = FALSE)
  }))
  ord <- function(d) {
    d <- d[order(d$table, d$version, d$where, d$scenario, d$variable), ]
    rownames(d) <- NULL
    d
  }
  # Both directions: a new over-length label fails, and so does an exception
  # that is no longer true (or whose label changed length).
  expect_equal(nrow(cdash_label_exceptions), 77L)
  expect_equal(c(table(cdash_label_exceptions$table)), c(cdash_model = 6L, ig_cdash = 71L))
  expect_equal(ord(found), ord(cdash_label_exceptions))
  expect_equal(unique(cdash_label_exceptions$version[cdash_label_exceptions$table == "ig_cdash"]), "2.0")
  # the QRS test names are --TEST values: SDTM's 40 characters apply without exception
  q <- tbls$qrs_supplement
  expect_lte(max(nchar(q$test_name)), 40L)
  expect_false(any(grepl("[\r\n]", q$test_name)))
})

test_that("type, core, and the flag column hold only the published values", {
  tbls <- cdash_gate_tables()
  expect_equal(sort(unique(tbls$cdash_model$type)), c("Char", "Num"))
  expect_equal(sort(unique(tbls$ig_cdash$type)),
               c("Char", "Date (dd-MON-yyyy)", "Num", "Time (24 hour)"))
  expect_equal(sort(unique(tbls$ig_cdash$core)), c("HR", "O", "R/C"))
  # the date and time types are the CDASHIG 1.1 conventions, dropped from 2.0
  ig <- tbls$ig_cdash
  expect_equal(unique(ig$version[ig$type %in% c("Date (dd-MON-yyyy)", "Time (24 hour)")]), "1.1")
  cm <- tbls$cdash_model
  expect_type(cm$domain_specific, "logical")
  expect_equal(sum(cm$domain_specific, na.rm = TRUE), 65L)
  expect_equal(sum(!is.na(cm$domain_specific) & !cm$domain_specific), 0L)
  expect_false(anyNA(cm$domain[cm$domain_specific %in% TRUE]))
})

test_that("codelist codes are C-codes, and a QRS item's TEST and TESTCD terms share one code", {
  tbls <- cdash_gate_tables()
  expect_true(all(grepl("^C[0-9]+$", tbls$cdash_model$codelist_code[!is.na(tbls$cdash_model$codelist_code)])))
  ig <- tbls$ig_cdash$codelist_code
  expect_true(all(grepl("^C[0-9]+(; C[0-9]+)*$", ig[!is.na(ig)])))
  q <- tbls$qrs_supplement
  for (col in c("testcd_codelist_code", "testcd_code", "test_codelist_code", "test_code")) {
    expect_true(all(grepl("^C[0-9]+$", q[[col]])), label = col)
  }
  expect_equal(q$testcd_code, q$test_code)
  # one --TEST and one --TESTCD codelist per instrument
  expect_equal(c(unname(tapply(q$test_codelist_code, q$instrument, function(v) length(unique(v))))),
               rep(1L, 9L))
  expect_equal(c(unname(tapply(q$testcd_codelist_code, q$instrument, function(v) length(unique(v))))),
               rep(1L, 9L))
  expect_equal(length(unique(q$test_codelist_code)), 9L)
  # only two instruments have items without a response group (6 items)
  expect_equal(c(table(q$instrument[is.na(q$response_group)])), c(CGI = 3L, PGI = 3L))
})

test_that("no carried CDASH or QRS text field has leading, trailing, or doubled whitespace", {
  tbls <- cdash_gate_tables()
  for (nm in names(tbls)) {
    for (col in names(Filter(is.character, tbls[[nm]]))) {
      v <- tbls[[nm]][[col]]
      v <- v[!is.na(v)]
      expect_equal(v[v != trimws(v) | grepl("[[:space:]]{2,}|[\r\n]", v)], character(0L),
                   label = paste(nm, col, "values with stray whitespace"))
    }
  }
})

test_that("order is a positive integer, and QRS items are numbered consecutively within an instrument", {
  tbls <- cdash_gate_tables()
  expect_type(tbls$cdash_model$order, "integer")
  expect_type(tbls$ig_cdash$order, "integer")
  expect_type(tbls$qrs_supplement$item_order, "integer")
  expect_true(all(tbls$cdash_model$order >= 1L))
  expect_true(all(tbls$ig_cdash$order >= 1L))
  q <- tbls$qrs_supplement
  expect_true(all(vapply(split(q$item_order, q$instrument),
                         function(o) identical(o, seq_along(o)), logical(1L))))
})
