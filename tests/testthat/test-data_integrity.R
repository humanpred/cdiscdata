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
