# Internal utilities for cdiscdata

# Suppress R CMD check notes about lazy-loaded package data objects
# that are not visible to the static checker.
utils::globalVariables(c("ct_sdtm", "ct_adam", "datasets_catalogue"))

# Validate that a data frame has all required columns.
# Used in data integrity checks.
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
