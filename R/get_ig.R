#' Retrieve CDISC implementation-guide variable metadata
#'
#' Mirrors \code{\link{get_ct}}, but for implementation-guide (IG) variable
#' metadata rather than controlled terminology. Unlike CT, which uses a
#' single validity-date timeline per standard, \code{ig_sdtm} bundles two
#' independently-versioned sources (the SDTM Model and the SDTMIG; see
#' \code{\link{ig_sdtm}}), so there is no single "latest" snapshot to default
#' to: \code{version = NULL} returns every source and version, for the
#' caller to filter further (by \code{source}/\code{domain}/\code{class} for
#' \code{ig_sdtm}, or \code{dataset}/\code{category} for \code{ig_adam}).
#' \code{\link{build_domain_spec}} does this filtering for the PP, SUPPPP,
#' and ADPP datasets specifically.
#'
#' @param standard One of \code{"sdtm"} or \code{"adam"}.
#' @param version A version string present in the \code{version} column
#'   (e.g. \code{"3.2"} for SDTMIG, \code{"1.7"} for the SDTM Model,
#'   \code{"1.2"} for ADaMIG). \code{NULL} (the default) returns all
#'   versions.
#' @return A data frame: \code{\link{ig_sdtm}} or \code{\link{ig_adam}},
#'   optionally filtered to one version.
#' @export
#' @examples
#' get_ig("sdtm")
#' get_ig("sdtm", version = "3.2")
#' get_ig("adam", version = "1.2")
get_ig <- function(standard = c("sdtm", "adam"), version = NULL) {
  standard <- match.arg(standard)
  tbl <- .pkg_data(paste0("ig_", standard))
  if (is.null(version)) return(tbl)

  avail <- sort(unique(tbl$version))
  if (!version %in% avail) {
    stop(paste0(
      "Version '", version, "' is not available for standard '", standard, "'. ",
      "Available versions: ", paste(avail, collapse = ", "), "."
    ))
  }
  tbl[tbl$version == version, ]
}
