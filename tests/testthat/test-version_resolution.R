# Unit tests for internal version resolution helpers.
# These reach into the package namespace to test unexported functions.

resolve_ct  <- cdiscdata:::.resolve_ct_version
resolve_sch <- cdiscdata:::.resolve_schema_version

test_that(".resolve_ct_version NULL returns latest (first element)", {
  result <- resolve_ct(NULL, "sdtm")
  avail  <- available_ct_versions("sdtm")
  expect_equal(as.character(result), avail[[1L]])
})

test_that(".resolve_ct_version valid string returns that date", {
  avail  <- available_ct_versions("sdtm")
  if (length(avail) >= 2L) {
    target <- avail[[2L]]
    result <- resolve_ct(target, "sdtm")
    expect_equal(as.character(result), target)
  } else {
    skip("Fewer than two SDTM CT versions available.")
  }
})

test_that(".resolve_ct_version unknown version gives informative error", {
  expect_error(
    resolve_ct("1900-01-01", "sdtm"),
    regexp = "not available"
  )
})

test_that(".resolve_ct_version non-date string gives error", {
  expect_error(resolve_ct("not-a-date", "sdtm"))
})

test_that(".resolve_schema_version NULL returns latest schema version", {
  result <- resolve_sch(NULL)
  expect_type(result, "character")
  expect_match(result, "^[0-9]\\.[0-9]$")
})

test_that(".resolve_schema_version valid version is returned unchanged", {
  result <- resolve_sch("2.1")
  expect_equal(result, "2.1")
})

test_that(".resolve_schema_version invalid version gives informative error", {
  expect_error(
    resolve_sch("9.9"),
    regexp = "not available"
  )
})
