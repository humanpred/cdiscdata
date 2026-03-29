#' List all available datasets in cdiscdata
#'
#' @return A data frame with one row per dataset describing its type, version
#'   range, and latest available version.
#' @export
#' @examples
#' list_datasets()
list_datasets <- function() {
  datasets_catalogue
}
