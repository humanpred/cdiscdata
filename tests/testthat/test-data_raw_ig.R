# The data-raw builder helpers (data-raw/utils_ig.R) read licensed CDISC
# Library exports that are never in this repository, so CI cannot run the
# build. These tests run its helpers on small synthetic exports written to a
# temporary directory, so the build logic (shape detection, missing-file and
# unexpected-file checks, and above all that no prose column reaches the data)
# is exercised without the real files.

load_utils_ig <- function() {
  path <- testthat::test_path("..", "..", "data-raw", "utils_ig.R")
  testthat::skip_if_not(file.exists(path), "data-raw is not installed with the package")
  env <- new.env(parent = globalenv())
  sys.source(path, envir = env)
  env
}

# A synthetic export of a given shape: every cell is "<column>:<row>" except
# the numeric and flag columns, which get values the converters can parse.
synthetic_export <- function(env, shape, rows = 2L) {
  cols <- env$ig_source_shapes[[shape]]
  x <- as.data.frame(lapply(stats::setNames(cols, cols), function(col) {
    paste0(col, ":", seq_len(rows))
  }), check.names = FALSE, stringsAsFactors = FALSE)
  for (col in intersect(cols, c("Variable Order", "Item Order"))) {
    x[[col]] <- as.character(seq_len(rows))
  }
  if ("Domain Specific" %in% cols) x[["Domain Specific"]] <- c("true", NA)[seq_len(rows)]
  x
}

# The prose columns of each shape, which must never be carried.
prose_columns <- list(
  ig_sdtm     = "CDISC Notes",
  model_v1    = "Description",
  model_v2    = c("Definition", "Notes", "Examples"),
  ig_adam     = "CDISC Notes",
  cdash_model = c("DRAFT CDASH Definition", "Mapping Instructions", "Implementation Notes"),
  cdash_ig    = c("DRAFT CDASHIG Definition", "Case Report Form Completion Instructions",
                  "Mapping Instructions", "Implementation Notes"),
  qrs         = "Item Text"
)

test_that("tidy_text collapses whitespace, including non-breaking spaces, and turns empty into NA", {
  env <- load_utils_ig()
  expect_equal(env$tidy_text(c("  a   b ", "c\n d", "e  f", "", "   ", NA)),
               c("a b", "c d", "e f", NA, NA, NA))
})

test_that("no prose column of any export shape reaches the data", {
  env <- load_utils_ig()
  parsed <- data.frame(standard = "S", version = "1.0", stringsAsFactors = FALSE)
  qrs_parsed <- data.frame(instrument = "I", version = "1.0", stringsAsFactors = FALSE)
  converters <- list(
    ig_sdtm = env$ig_sdtm_rows, model_v1 = env$model_sdtm_rows,
    model_v2 = env$model_sdtm_rows, ig_adam = env$ig_adam_rows,
    cdash_model = env$cdash_model_rows, cdash_ig = env$cdash_ig_rows, qrs = env$qrs_rows
  )
  for (shape in names(converters)) {
    x <- synthetic_export(env, shape)
    out <- converters[[shape]](x, if (shape == "qrs") qrs_parsed else parsed)
    expect_equal(nrow(out), 2L, label = shape)
    values <- unlist(Filter(is.character, out), use.names = FALSE)
    for (col in prose_columns[[shape]]) {
      expect_false(any(grepl(paste0(col, ":"), values, fixed = TRUE)),
                   label = paste(shape, "carries the", col, "column"))
    }
    # and the metadata columns do arrive
    carried <- setdiff(env$ig_source_shapes[[shape]], c(prose_columns[[shape]], "Version"))
    for (col in setdiff(carried, c("Variable Order", "Item Order", "Domain Specific"))) {
      expect_true(any(startsWith(values, paste0(col, ":"))), label = paste(shape, "drops", col))
    }
  }
})

test_that("the CDASH converters keep the flag, the wording, and the QRS names under their own columns", {
  env <- load_utils_ig()
  cm <- env$cdash_model_rows(synthetic_export(env, "cdash_model"),
                             data.frame(standard = "CDASH", version = "1.3"))
  expect_equal(cm$domain_specific, c(TRUE, NA))
  expect_equal(cm$question_text, c("Question Text:1", "Question Text:2"))
  expect_equal(cm$sdtm_target, c("SDTM Target:1", "SDTM Target:2"))
  expect_equal(cm$order, 1:2)
  ig <- env$cdash_ig_rows(synthetic_export(env, "cdash_ig"),
                          data.frame(standard = "CDASHIG", version = "2.3"))
  expect_equal(ig$scenario[1L], "Data Collection Scenario/Implementation Option:1")
  expect_equal(ig$codelist_submission_value[2L], "Codelist Submission Value:2")
  qrs <- env$qrs_rows(synthetic_export(env, "qrs"),
                      data.frame(instrument = "HAM-A", version = "2.1"))
  expect_equal(qrs$instrument, c("HAM-A", "HAM-A"))
  expect_equal(qrs$test_name[1L], "Item Test Name:1")
  expect_equal(qrs$testcd_code[1L], "Code for '--TESTCD':1")
  expect_equal(qrs$test_code[1L], "Code for '--TEST':1")
  expect_equal(qrs$testcd_codelist_code[1L], "Codelist Code for '--TESTCD':1")
  expect_equal(qrs$test_codelist_code[1L], "Codelist Code for '--TEST':1")
})

test_that("read_library_export recognises each shape and its single Version value", {
  env <- load_utils_ig()
  dir <- withr::local_tempdir()
  for (shape in names(env$ig_source_shapes)) {
    x <- synthetic_export(env, shape)
    if ("Version" %in% names(x)) x$Version <- "ADaMIG v1.3"
    path <- file.path(dir, paste0(shape, ".csv"))
    utils::write.csv(x, path, row.names = FALSE, na = "")
    got <- env$read_library_export(path)
    expect_equal(got$shape, shape)
    expect_equal(nrow(got$data), 2L)
    expect_equal(got$version_string, if (shape == "qrs") NA_character_ else "ADaMIG v1.3")
  }
})

test_that("read_library_export stops on an unknown layout and on a file with two versions", {
  env <- load_utils_ig()
  dir <- withr::local_tempdir()
  utils::write.csv(data.frame(a = 1, b = 2), file.path(dir, "odd.csv"), row.names = FALSE)
  expect_error(env$read_library_export(file.path(dir, "odd.csv")),
               "odd.csv has columns that match none of the known export shapes", fixed = TRUE)
  x <- synthetic_export(env, "ig_adam")
  x$Version <- c("ADaMIG v1.2", "ADaMIG v1.3")
  utils::write.csv(x, file.path(dir, "two.csv"), row.names = FALSE)
  expect_error(env$read_library_export(file.path(dir, "two.csv")),
               "must carry exactly one Version value, found 2: ADaMIG v1.2; ADaMIG v1.3",
               fixed = TRUE)
})

test_that("a missing export is an error that lists every missing file and points at the README", {
  env <- load_utils_ig()
  dir <- withr::local_tempdir()
  file.create(file.path(dir, env$ig_source_files[1:30]))
  withr::local_envvar(CDISC_SOURCES_DIR = dir)
  e <- expect_error(env$cdisc_source_paths(env$ig_source_files), "4 of the 34 expected")
  msg <- conditionMessage(e)
  for (f in env$ig_source_files[31:34]) expect_match(msg, f, fixed = TRUE)
  expect_false(grepl(env$ig_source_files[1L], msg, fixed = TRUE))
  expect_match(msg, "data-raw/README.md", fixed = TRUE)
  expect_match(msg, "CDISC_SOURCES_DIR", fixed = TRUE)
  file.create(file.path(dir, env$ig_source_files[31:34]))
  expect_equal(names(env$cdisc_source_paths(env$ig_source_files)), env$ig_source_files)
})

test_that("the sources directory defaults to ../cdisc-sources and follows CDISC_SOURCES_DIR", {
  env <- load_utils_ig()
  withr::local_envvar(CDISC_SOURCES_DIR = NA)
  expect_equal(env$cdisc_sources_dir(), "../cdisc-sources")
  withr::local_envvar(CDISC_SOURCES_DIR = "somewhere/else")
  expect_equal(env$cdisc_sources_dir(), "somewhere/else")
})

test_that("a QRS supplement the build does not list is an error, not silently loaded or skipped", {
  env <- load_utils_ig()
  dir <- withr::local_tempdir()
  file.create(file.path(dir, env$qrs_source_files))
  withr::local_envvar(CDISC_SOURCES_DIR = dir)
  expect_equal(sort(env$check_qrs_exports()), sort(env$qrs_source_files))
  file.create(file.path(dir, "NEW_SCALE_Supplement_v1.0.csv"))
  expect_error(env$check_qrs_exports(),
               "not listed in qrs_source_files: NEW_SCALE_Supplement_v1.0.csv", fixed = TRUE)
})

test_that("the file lists hold 34 IG and model, 9 CDASH, and 9 QRS exports, none twice", {
  env <- load_utils_ig()
  expect_equal(c(length(env$ig_source_files), length(env$cdash_source_files),
                 length(env$qrs_source_files)), c(34L, 9L, 9L))
  all_files <- c(env$ig_source_files, env$cdash_source_files, env$qrs_source_files)
  expect_false(anyDuplicated(all_files) > 0L)
  expect_setequal(env$qrs_source_files, qrs_files)
})
