# Mechanical gates on the IG and model tables (ig_sdtm, model_sdtm, ig_adam),
# built from the CDISC Library exports by data-raw/build_ig.R. They exist so
# the transcription defects nca.reporter hit when writing XPT v5 files
# (40-character labels, newlines, padded names) cannot recur unnoticed, and so
# a new export cannot be loaded wrongly.

ig_gate_tables <- function() {
  list(
    ig_sdtm    = get_dataset("ig_sdtm"),
    model_sdtm = get_dataset("model_sdtm"),
    ig_adam    = get_dataset("ig_adam")
  )
}

# What identifies a row in each table. dataset is NA for the SDTM model's
# observation-class variables, so its class is part of the key; ADaM-OCCDS
# defines DECDORGw once per dictionary-specific variable set, so the set is
# part of the ADaM key.
ig_keys <- list(
  ig_sdtm    = c("standard", "version", "domain", "variable"),
  model_sdtm = c("standard", "version", "class", "dataset", "variable"),
  ig_adam    = c("standard", "version", "structure", "variable_set", "variable")
)

ig_row_key <- function(tbl, cols) {
  do.call(paste, c(lapply(tbl[cols], as.character), sep = "\r"))
}

test_that("each IG/model table has exactly the documented metadata columns, nothing from the guides' prose", {
  tbls <- ig_gate_tables()
  expect_equal(names(tbls$ig_sdtm),
               c("standard", "version", "class", "domain", "order", "variable",
                 "label", "type", "role", "core", "codelist_code",
                 "codelist_submission_values", "described_value_domain", "value_list"))
  expect_equal(names(tbls$model_sdtm),
               c("standard", "version", "class", "dataset", "order", "variable",
                 "label", "type", "role", "described_value_domain",
                 "variables_qualified", "usage_restrictions", "variable_code"))
  expect_equal(names(tbls$ig_adam),
               c("standard", "version", "structure", "variable_set", "order",
                 "variable", "label", "type", "core", "codelist_code",
                 "codelist_submission_values", "described_value_domain", "value_list"))
  # The prose columns of the exports (CDISC Notes, Description, Definition,
  # Notes, Examples) run to paragraphs; the longest value in anything carried
  # is 85 characters, so a long value means prose has leaked in.
  for (nm in names(tbls)) {
    longest <- vapply(Filter(is.character, tbls[[nm]]),
                      function(v) max(nchar(v), na.rm = TRUE), integer(1L))
    expect_lte(max(longest), 100L, label = paste("longest text value in", nm))
  }
})

test_that("ig_sources lists the 34 exports, each parsed to one distinct standard version", {
  src <- cdiscdata::ig_sources
  expect_equal(nrow(src), 34L)
  expect_setequal(src$version_string, ig_version_strings)
  expect_false(anyDuplicated(src$file) > 0L)
  expect_false(anyDuplicated(paste(src$standard, src$version)) > 0L)
  # the stored parse is the parser's parse
  parsed <- cdiscdata:::.parse_ig_version(src$version_string)
  expect_equal(src$standard, parsed$standard)
  expect_equal(src$version, parsed$version)
  expect_true(all(nchar(src$md5) == 32L))
  expect_equal(sort(unique(src$table)), c("ig_adam", "ig_sdtm", "model_sdtm"))
})

test_that("every export is loaded exactly once, with as many rows as its file has", {
  src <- cdiscdata::ig_sources
  tbls <- ig_gate_tables()
  for (nm in names(tbls)) {
    s <- src[src$table == nm, ]
    got <- table(paste(tbls[[nm]]$standard, tbls[[nm]]$version))
    expect_setequal(names(got), paste(s$standard, s$version))
    expect_equal(as.integer(got[paste(s$standard, s$version)]), s$rows,
                 label = paste("rows loaded into", nm))
  }
  expect_equal(c(nrow(tbls$ig_sdtm), nrow(tbls$model_sdtm), nrow(tbls$ig_adam)),
               c(10064L, 3604L, 1804L))
  expect_equal(sum(src$rows), 10064L + 3604L + 1804L)
})

test_that("each table's standards are the ones the parser table assigns to it", {
  for (nm in names(ig_gate_tables())) {
    expected <- cdiscdata:::.ig_standards$standard[cdiscdata:::.ig_standards$table == nm]
    expect_setequal(unique(ig_gate_tables()[[nm]]$standard), expected)
  }
})

test_that("every row is unique on its key", {
  tbls <- ig_gate_tables()
  for (nm in names(tbls)) {
    key <- ig_row_key(tbls[[nm]], ig_keys[[nm]])
    expect_equal(sum(duplicated(key)), 0L, label = paste("duplicate keys in", nm))
  }
})

test_that("standard, version, variable, and label are never NA, and names are clean", {
  for (nm in names(ig_gate_tables())) {
    tbl <- ig_gate_tables()[[nm]]
    for (col in c("standard", "version", "variable", "label")) {
      expect_false(anyNA(tbl[[col]]), label = paste(nm, col, "has NA"))
    }
    expect_equal(tbl$variable[!nzchar(tbl$variable)], character(0L))
    expect_equal(tbl$variable[grepl("[[:space:]]", tbl$variable)], character(0L),
                 label = paste(nm, "variable names containing whitespace"))
  }
  tbls <- ig_gate_tables()
  expect_false(anyNA(tbls$ig_sdtm$domain))
  expect_false(anyNA(tbls$ig_sdtm$class))
  expect_false(anyNA(tbls$model_sdtm$class))
  expect_false(anyNA(tbls$ig_adam$structure))
  expect_false(anyNA(tbls$ig_adam$variable_set))
})

test_that("labels have no newline and none exceeds 40 characters except the 22 the guides publish longer", {
  found <- do.call(rbind, lapply(names(ig_gate_tables()), function(nm) {
    tbl <- ig_gate_tables()[[nm]]
    expect_false(any(grepl("[\r\n]", tbl$label)), label = paste(nm, "label with a newline"))
    i <- which(nchar(tbl$label) > 40L)
    where <- switch(nm, ig_sdtm = tbl$domain, model_sdtm = tbl$class, ig_adam = tbl$structure)
    data.frame(table = rep(nm, length(i)), standard = tbl$standard[i],
               version = tbl$version[i], where = where[i],
               variable = tbl$variable[i], label = tbl$label[i],
               stringsAsFactors = FALSE)
  }))
  ord <- function(d) d[order(d$table, d$standard, d$version, d$where, d$variable), ]
  # Both directions: a new over-length label fails, and so does an exception
  # that is no longer true.
  expect_equal(nrow(ig_label_exceptions), 22L)
  expect_equal(ord(found), ord(ig_label_exceptions), ignore_attr = TRUE)
})

test_that("type and core hold only the published values, bar the five rows the guides leave blank", {
  tbls <- ig_gate_tables()
  ex <- ig_missing_field_exceptions
  for (nm in names(tbls)) {
    tbl <- tbls[[nm]]
    expect_true(all(tbl$type %in% c("Char", "Num", NA)), label = paste(nm, "type values"))
    if ("core" %in% names(tbl)) {
      expect_true(all(tbl$core %in% c("Req", "Exp", "Perm", "Cond", "Not used", "Not Used", NA)),
                  label = paste(nm, "core values"))
    }
  }
  sd <- tbls$ig_sdtm
  na_type <- sd[is.na(sd$type), c("standard", "version", "domain", "variable")]
  na_core <- sd[is.na(sd$core), c("standard", "version", "domain", "variable")]
  expect_equal(na_type, ex[ex$field == "type", c("standard", "version", "domain", "variable")],
               ignore_attr = TRUE)
  expect_equal(na_core, ex[ex$field == "core", c("standard", "version", "domain", "variable")],
               ignore_attr = TRUE)
  expect_false(anyNA(tbls$model_sdtm$type))
  expect_false(anyNA(tbls$ig_adam$type))
  expect_false(anyNA(tbls$ig_adam$core))
})

test_that("no carried text field has leading, trailing, or doubled whitespace", {
  for (nm in names(ig_gate_tables())) {
    tbl <- ig_gate_tables()[[nm]]
    for (col in names(Filter(is.character, tbl))) {
      v <- tbl[[col]]
      v <- v[!is.na(v)]
      expect_equal(v[v != trimws(v) | grepl("[[:space:]]{2,}|[\r\n]", v)], character(0L),
                   label = paste(nm, col, "values with stray whitespace"))
    }
  }
})

test_that("order is a positive integer and strictly increasing within each standard version's group", {
  tbls <- ig_gate_tables()
  for (nm in names(tbls)) {
    expect_type(tbls[[nm]]$order, "integer")
    expect_true(all(tbls[[nm]]$order >= 1L))
  }
  grp <- function(tbl, cols) split(tbl$order, ig_row_key(tbl, cols))
  inc <- function(g) all(vapply(g, function(o) all(diff(o) > 0L), logical(1L)))
  expect_true(inc(grp(tbls$ig_sdtm, c("standard", "version", "domain"))))
  expect_true(inc(grp(tbls$model_sdtm, c("standard", "version", "class", "dataset"))))
  expect_true(inc(grp(tbls$ig_adam, c("standard", "version"))))
})

test_that("a CSV is never committed under data-raw (the exports must stay out of the repository)", {
  dir <- testthat::test_path("..", "..", "data-raw")
  skip_if_not(dir.exists(dir), "data-raw is not installed with the package")
  csvs <- list.files(dir, pattern = "[.]csv$", recursive = TRUE, ignore.case = TRUE)
  # No CSV fixtures are owned by data-raw; the CDISC Library exports live in
  # CDISC_SOURCES_DIR, outside every repository.
  expect_equal(csvs, character(0L))
})
