#' Retrieve CDISC Controlled Terminology
#'
#' Convenience wrapper around \code{\link{get_dataset}} for CT data.
#'
#' @param type One of \code{"sdtm"} or \code{"adam"}.
#' @param version CT version date string e.g. \code{"2024-09-27"}.
#'   \code{NULL} returns the latest available version.
#' @return A data frame of CT terms valid at the requested version.
#' @export
#' @examples
#' ct <- get_ct("sdtm")
#' head(ct)
#' ct_2024 <- get_ct("sdtm", version = "2024-09-27")
#' nrow(ct_2024)
#' head(get_ct("adam"))
get_ct <- function(type = c("sdtm", "adam"), version = NULL) {
  type <- match.arg(type)
  get_dataset(paste0("ct_", type), version = version)
}
