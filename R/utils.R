# Internal utilities for cdiscdata

# Suppress R CMD check notes about lazy-loaded package data objects
# that are not visible to the static checker.
utils::globalVariables(c("ct_sdtm", "ct_adam", "datasets_catalogue"))

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
