# Regression tests for the "works only after library()" bug: lazy-loaded
# package data (ct_sdtm, ct_adam, datasets_catalogue) is wired into the
# search path only when a package is *attached*. Loading just the namespace
# (as `::` does) does not make an unqualified reference to that data resolve,
# even from inside the package's own functions. See R/utils.R's .pkg_data()
# for the fix and rationale.

# Locate a genuine, buildable package source tree, if one is available in
# this test run. devtools::test()/pkgload::load_all() set the working
# directory to the package root; R CMD check instead runs tests against an
# already-installed copy with no source tree alongside it, in which case the
# ambient installation (found via .libPaths()) already *is* the build under
# test, and there is nothing to rebuild.
locate_pkg_source_root <- function() {
  candidates <- unique(c(
    getwd(),
    tryCatch(
      normalizePath(file.path(testthat::test_path(), "..", ".."), mustWork = FALSE),
      error = function(e) character(0L)
    )
  ))
  for (root in candidates) {
    has_desc <- file.exists(file.path(root, "DESCRIPTION"))
    r_files  <- if (dir.exists(file.path(root, "R"))) {
      list.files(file.path(root, "R"), pattern = "[.]R$")
    } else {
      character(0L)
    }
    if (has_desc && length(r_files) > 0L) return(root)
  }
  NULL
}

test_that("get_ct works via cdiscdata:: alone, no library(), in a fresh subprocess", {
  skip_on_cran()
  skip_if_not_installed("callr")

  root <- locate_pkg_source_root()
  if (is.null(root)) {
    # No source tree alongside the tests (e.g. R CMD check): the ambient
    # installation under .libPaths() is the build under test.
    lib <- .libPaths()
  } else {
    skip_if_not_installed("pkgbuild")
    build_dir <- withr::local_tempdir()
    lib       <- withr::local_tempdir()
    tarball <- pkgbuild::build(
      root, dest_path = build_dir, quiet = TRUE, vignettes = FALSE
    )
    # Installed in a separate subprocess, not in this session: when running
    # under devtools::test(), cdiscdata is already loaded here via pkgload,
    # and install.packages() refuses to (re)install a package that is
    # currently in use in the calling session, even into an unrelated
    # library path.
    callr::r(
      function(tarball, lib) {
        utils::install.packages(tarball, repos = NULL, type = "source",
                                lib = lib, quiet = TRUE)
      },
      args = list(tarball = tarball, lib = lib)
    )
    lib <- c(lib, .libPaths())
  }

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
