# Internal utilities for cdiscdata

# Suppress R CMD check notes about lazy-loaded package data objects
# that are not visible to the static checker.
utils::globalVariables(c("ct_sdtm", "ct_adam", "ig_sdtm", "ig_adam", "datasets_catalogue"))

# Retrieve one of the package's own lazy-loaded datasets (ct_sdtm, ct_adam,
# datasets_catalogue, ...) regardless of whether cdiscdata is attached.
#
# LazyData promises are only wired into the *search path* when a package is
# attached with library()/require(); loading just the namespace (as `::`
# does, and as every other package's `pkg::fun()` call does) does not make
# an unqualified reference to a lazy dataset resolve, even from inside the
# package's own functions defined in that namespace. utils::data() with an
# explicit envir sidesteps this: it reads the installed data directory
# directly from the package's installation metadata, independent of
# attach/namespace-load state, so it works identically from `library()`,
# `cdiscdata::fn()`, and a fresh callr::r() session with `::` alone.
.pkg_data <- function(name) {
  e <- new.env(parent = emptyenv())
  utils::data(list = name, package = "cdiscdata", envir = e)
  e[[name]]
}

# Validate that a data frame has all required columns.
# Returns the data frame invisibly on success; stops on failure.
.check_columns <- function(df, required, name) {
  missing <- setdiff(required, names(df))
  if (length(missing) > 0L) {
    stop(paste0(
      name, " is missing required columns: ",
      paste(missing, collapse = ", "), "."
    ))
  }
  invisible(df)
}

# Thin wrappers around base functions that perform file-system look-ups.
# Keeping them as one-liners in this file makes them mockable in tests
# via testthat::local_mocked_bindings(.package = "cdiscdata").
.sys_file <- function(...) system.file(...)
.list_dirs <- function(path) list.dirs(path, full.names = FALSE, recursive = FALSE)
