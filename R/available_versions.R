#' List available CT versions
#'
#' @param type One of \code{"sdtm"} or \code{"adam"}.
#' @return Character vector of version date strings, newest first,
#'   e.g. \code{c("2026-03-27", "2025-09-27", ...)}.
#' @export
#' @examples
#' available_ct_versions("sdtm")
#' available_ct_versions("adam")
available_ct_versions <- function(type = c("sdtm", "adam")) {
  type <- match.arg(type)
  tbl <- switch(type, sdtm = ct_sdtm, adam = ct_adam)
  # valid_from must never be NA — enforced at ingestion time in data-raw/
  dates <- sort(unique(tbl$valid_from), decreasing = TRUE)
  as.character(dates)
}
