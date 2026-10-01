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
#' \strong{SDTMIG coverage.} SDTMIG 3.2 and 3.3 carry only the PP domain and
#' the generic SUPP-- structure; version 3.3 reuses the 3.2 tables, since the
#' published SDTMIG v3.3 stamps its PP specification "Version 3.2" (unchanged
#' since 3.2) and its SUPP-- specification has the same ten variables. Both
#' include \code{TAETORD}, \code{EPOCH}, and \code{PPDY}, which the Rsdtm
#' transcription of 3.2 this package copies from omitted. SDTMIG 3.4 carries
#' every one of its 63 domains, from a CDISC Library export (names, labels,
#' types, codelists, roles, Core, and order; the export's CDISC Notes text is
#' not included, so \code{notes} is \code{NA} for those rows). Its PP table
#' adds \code{PPANMETH} and \code{PPTPTREF}. \code{PPDTC} (not
#' \code{PPPDTC}) is the published name of the date/time-of-calculation
#' variable in all three versions. See \code{data-raw/ig_source/README.md}.
#'
#' @param standard One of \code{"sdtm"} or \code{"adam"}.
#' @param version A version string present in the \code{version} column
#'   (e.g. \code{"3.2"} for SDTMIG, \code{"1.7"} for the SDTM Model,
#'   \code{"1.2"} for ADaMIG). \code{NULL} (the default) returns all
#'   versions.
#' @param domain Restrict to one domain/dataset: for \code{"sdtm"}, the
#'   \code{domain} column (\code{"PP"} or \code{"SUPPQUAL"} at SDTMIG
#'   3.2 and 3.3, any of 63 domains at 3.4; SDTM Model rows have no domain
#'   and are excluded); for \code{"adam"}, the
#'   \code{dataset} column (\code{"ADSL"} or \code{"BDS"}). \code{NULL}
#'   (the default) applies no domain filter.
#' @return A data frame: \code{\link{ig_sdtm}} or \code{\link{ig_adam}},
#'   optionally filtered to one version and/or domain.
#' @export
#' @examples
#' get_ig("sdtm")
#' get_ig("sdtm", version = "3.3", domain = "PP")
#' get_ig("adam", version = "1.2", domain = "BDS")
get_ig <- function(standard = c("sdtm", "adam"), version = NULL, domain = NULL) {
  standard <- match.arg(standard)
  tbl <- .pkg_data(paste0("ig_", standard))

  if (!is.null(version)) {
    avail <- sort(unique(tbl$version))
    if (!version %in% avail) {
      .cdiscdata_abort(
        paste0(
          "Version '", version, "' is not available for standard '", standard, "'. ",
          "Available versions: ", paste(avail, collapse = ", "), "."
        ),
        "ig_version_unavailable"
      )
    }
    tbl <- tbl[tbl$version == version, ]
  }

  if (!is.null(domain)) {
    domain_col <- if (standard == "sdtm") "domain" else "dataset"
    avail <- sort(unique(tbl[[domain_col]]))
    if (!domain %in% avail) {
      .cdiscdata_abort(
        paste0(
          "Domain '", domain, "' is not available for standard '", standard, "'",
          if (!is.null(version)) paste0(" at version '", version, "'"),
          ". Available: ", if (length(avail)) paste(avail, collapse = ", ") else "none", "."
        ),
        "ig_domain_unavailable"
      )
    }
    tbl <- tbl[tbl[[domain_col]] %in% domain, ]
  }
  tbl
}
