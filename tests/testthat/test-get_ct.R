test_that("get_ct returns data frame with correct columns", {
  ct <- get_ct("sdtm")
  expect_s3_class(ct, "data.frame")
  expect_true(all(c("codelist_code", "codelist_name", "term",
                    "decoded_value", "valid_from") %in% names(ct)))
})

test_that("get_ct NULL returns only current rows (valid_to = NA)", {
  # With the validity-date design, apply_ct_update() closes retired rows with
  # valid_to = release_date - 1. So for the latest release date, all returned
  # rows are those that are still active (valid_to = NA).
  ct <- get_ct("sdtm")
  expect_true(all(is.na(ct$valid_to)))
})

test_that("get_ct with specific version returns rows valid at that date", {
  v <- available_ct_versions("sdtm")
  if (length(v) >= 2L) {
    second_latest <- v[[2L]]
    ct <- get_ct("sdtm", version = second_latest)
    expect_true(all(ct$valid_from <= as.Date(second_latest)))
    expect_true(all(is.na(ct$valid_to) | ct$valid_to >= as.Date(second_latest)))
  } else {
    skip("Only one CT version available; skipping multi-version test.")
  }
})

test_that("get_ct aborts informatively on unknown version", {
  expect_error(
    get_ct("sdtm", version = "1999-01-01"),
    regexp = "not available"
  )
})

test_that("get_ct produces no warning on NULL version", {
  expect_no_warning(get_ct("sdtm"))
})

test_that("get_ct works for adam", {
  ct <- get_ct("adam")
  expect_s3_class(ct, "data.frame")
  expect_gt(nrow(ct), 0L)
})
