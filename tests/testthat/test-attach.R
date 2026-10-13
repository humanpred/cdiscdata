# Regression tests for the "works only after library()" bug: lazy-loaded
# package data (ct_sdtm, ct_adam, datasets_catalogue) is wired into the
# search path only when a package is *attached*. Loading just the namespace
# (as `::` does) does not make an unqualified reference to that data resolve,
# even from inside the package's own functions. See R/utils.R's .pkg_data()
# for the fix and rationale.

# Whether the tests run from a package source tree (devtools::test() and
# pkgload::load_all() set the working directory to the package root), rather
# than against an installed copy as under R CMD check
running_from_source <- function() {
  candidates <- unique(c(
    getwd(),
    tryCatch(
      normalizePath(file.path(testthat::test_path(), "..", ".."), mustWork = FALSE),
      error = function(e) character(0L)
    )
  ))
  for (root in candidates) {
    has_desc <- file.exists(file.path(root, "DESCRIPTION"))
    has_r <- dir.exists(file.path(root, "R")) && length(list.files(file.path(root, "R"), pattern = "[.]R$")) > 0L
    if (has_desc && has_r) {
      return(TRUE)
    }
  }
  FALSE
}

# The subprocess must load cdiscdata from an installed copy that is the build
# under test.  Under R CMD check, the installed copy under .libPaths() is that
# build; from a source tree, the installed copy (if any) may be older, and the
# test does not install one, so it skips.
test_that("get_ct works via cdiscdata:: alone, no library(), in a fresh subprocess", {
  skip_on_cran()
  skip_if_not_installed("callr")
  skip_if(running_from_source(), "Needs the installed build under test (run under R CMD check)")
  lib <- .libPaths()

  sdtm <- callr::r(function() cdiscdata::get_ct("sdtm"), libpath = lib)
  expect_s3_class(sdtm, "data.frame")
  expect_gt(nrow(sdtm), 0L)
  expect_true("C66731" %in% sdtm$codelist_code)

  adam <- callr::r(function() cdiscdata::get_ct("adam"), libpath = lib)
  expect_s3_class(adam, "data.frame")
  expect_gt(nrow(adam), 0L)

  datasets <- callr::r(function() cdiscdata::list_datasets(), libpath = lib)
  expect_s3_class(datasets, "data.frame")
  expect_gt(nrow(datasets), 0L)

  versions <- callr::r(function() cdiscdata::cdiscdata_versions(), libpath = lib)
  expect_s3_class(versions, "data.frame")

  avail <- callr::r(function() cdiscdata::available_ct_versions("sdtm"), libpath = lib)
  expect_type(avail, "character")
  expect_gt(length(avail), 0L)
})
