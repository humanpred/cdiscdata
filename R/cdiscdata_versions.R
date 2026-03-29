#' Summarise all bundled data versions
#'
#' @return A data frame with one row per data type showing the latest version,
#'   number of versions available, and when the data was last updated.
#' @export
#' @examples
#' cdiscdata_versions()
cdiscdata_versions <- function() {
  cat_cols <- c("dataset", "type", "description", "latest", "n_versions",
                "last_updated")
  datasets_catalogue[, cat_cols]
}
