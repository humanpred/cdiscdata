#' Retrieve CDISC implementation-guide or model variable metadata
#'
#' One accessor over every standard in \code{\link{ig_sdtm}},
#' \code{\link{model_sdtm}}, and \code{\link{ig_adam}}, mirroring
#' \code{\link{get_ct}}. The standard is chosen with \code{standard}; the
#' version defaults to that standard's newest.
#'
#' The standards, and the dataset each is stored in:
#' \itemize{
#'   \item \code{"SDTM"} (model versions 1.2 to 2.1): \code{\link{model_sdtm}}.
#'   \item \code{"SDTMIG"} (3.1.2 to 3.4), \code{"SDTMIG-AP"},
#'     \code{"SDTMIG-MD"}, \code{"SENDIG"} (3.0 to 3.1.1),
#'     \code{"SENDIG-AR"}, \code{"SENDIG-DART"}, \code{"SENDIG-GeneTox"}:
#'     \code{\link{ig_sdtm}}.
#'   \item \code{"ADaMIG"} (1.0 to 1.3), \code{"ADaMIG-MD"},
#'     \code{"ADaMIG-NCA"}, \code{"ADaM-ADAE"}, \code{"ADaM-BDS-TTE"},
#'     \code{"ADaM-OCCDS"}, \code{"ADaM-popPK"}: \code{\link{ig_adam}}.
#' }
#' The lower-case names \code{"sdtm"} and \code{"adam"}, the only values the
#' first argument took before it named a standard, are kept as aliases for the
#' defaults \code{"SDTMIG"} and \code{"ADaMIG"} (note \code{"SDTM"} in capitals
#' is the model, not the implementation guide).
#'
#' All of this comes from CDISC Library CSV exports that are not part of this
#' package or repository (see \code{\link{ig_sources}} for exactly which
#' files, and \code{data-raw/README.md}). Only variable metadata is carried;
#' the guides' prose (CDISC Notes, Description, Definition, Examples) is not.
#'
#' @param standard One standard from the list above (default
#'   \code{"SDTMIG"}), or the alias \code{"sdtm"} or \code{"adam"}.
#' @param version A version string of that standard (e.g. \code{"3.4"}).
#'   \code{NULL} (the default) uses the newest, compared numerically, so
#'   \code{"3.1.3"} ranks below \code{"3.2"}.
#' @param domain Restrict to one domain or structure. For the
#'   implementation-guide standards in \code{\link{ig_sdtm}}, the
#'   \code{domain} column (e.g. \code{"PP"}); for \code{"SDTM"}, a
#'   \code{class} (e.g. \code{"Findings"}) or a \code{dataset} (e.g.
#'   \code{"DM"}); for the ADaM standards, the \code{structure} column, where
#'   \code{"BDS"} and \code{"ADSL"} are accepted as aliases for
#'   \code{"Basic Data Structure"} and \code{"Subject-Level Analysis
#'   Dataset"}. \code{NULL} (the default) applies no filter.
#' @return A data frame: the rows of \code{\link{ig_sdtm}},
#'   \code{\link{model_sdtm}}, or \code{\link{ig_adam}} for that standard,
#'   version, and domain. An unknown standard, version, or domain is a classed
#'   error (\code{cdiscdata_error_ig_standard_unavailable},
#'   \code{cdiscdata_error_ig_version_unavailable},
#'   \code{cdiscdata_error_ig_domain_unavailable}).
#' @export
#' @examples
#' get_ig()                                          # newest SDTMIG (3.4)
#' get_ig("SDTMIG", version = "3.3", domain = "PP")
#' get_ig("SENDIG", domain = "PP")
#' get_ig("ADaMIG", domain = "BDS")
#' get_ig("ADaMIG-NCA")
#' get_ig("SDTM", version = "2.1", domain = "Findings")
get_ig <- function(standard = "SDTMIG", version = NULL, domain = NULL) {
  standard <- .resolve_ig_standard(standard)
  table <- .ig_standards$table[match(standard, .ig_standards$standard)]
  tbl <- .pkg_data(table)
  tbl <- tbl[tbl$standard == standard, ]

  version <- .resolve_ig_version(version, tbl$version, standard)
  tbl <- tbl[tbl$version == version, ]

  if (is.null(domain)) {
    return(tbl)
  }
  .filter_ig_domain(tbl, table, domain, standard, version)
}

# "sdtm"/"adam" are the pre-redesign first-argument values; any other value
# must be one of the canonical standard names.
.resolve_ig_standard <- function(standard) {
  if (!is.character(standard) || length(standard) != 1L || is.na(standard)) {
    .cdiscdata_abort("`standard` must be a single string.", "ig_standard_unavailable")
  }
  standard <- switch(standard, sdtm = "SDTMIG", adam = "ADaMIG", standard)
  if (!standard %in% .ig_standards$standard) {
    .cdiscdata_abort(
      paste0(
        "Standard '", standard, "' is not available. Available standards: ",
        paste(.ig_standards$standard, collapse = ", "), "."
      ),
      "ig_standard_unavailable"
    )
  }
  standard
}

# Short names for the two ADaM structures people ask for most.
.adam_structure_aliases <- c(
  BDS  = "Basic Data Structure",
  ADSL = "Subject-Level Analysis Dataset"
)

.filter_ig_domain <- function(tbl, table, domain, standard, version) {
  if (table == "model_sdtm") {
    avail <- sort(unique(c(tbl$class, tbl$dataset)))
    keep <- tbl$class %in% domain | tbl$dataset %in% domain
  } else {
    column <- if (table == "ig_adam") "structure" else "domain"
    if (table == "ig_adam") {
      domain <- ifelse(domain %in% names(.adam_structure_aliases),
                       .adam_structure_aliases[domain], domain)
    }
    avail <- sort(unique(tbl[[column]]))
    keep <- tbl[[column]] %in% domain
  }
  if (!all(domain %in% avail)) {
    .cdiscdata_abort(
      paste0(
        "Domain '", paste(setdiff(domain, avail), collapse = "', '"),
        "' is not available for standard '", standard, "' at version '", version,
        "'. Available: ", paste(avail, collapse = ", "), "."
      ),
      "ig_domain_unavailable"
    )
  }
  tbl[keep, ]
}
