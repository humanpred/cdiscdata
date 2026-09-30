#' Build a variable specification for PP, SUPPPP, or ADPP
#'
#' Combines \code{\link{get_ig}} (variable name, label, type, core, order)
#' with \code{\link{get_ct}} (codelist id lookup) into a single, ready-to-use
#' variable specification for one of the three PK datasets. \code{PP} and
#' \code{SUPPPP} draw on the SDTMIG (\code{SUPPPP} from the generic SUPP--
#' structure, since CDISC has no domain-specific SUPPPP table); \code{ADPP}
#' draws on the ADaMIG BDS (Basic Data Structure) table, since ADPP is a BDS
#' dataset and CDISC has no ADPP-specific table either.
#'
#' @param domain One of \code{"PP"}, \code{"SUPPPP"}, or \code{"ADPP"}.
#' @param ig_version IG version to use: an SDTMIG version (for \code{PP}/
#'   \code{SUPPPP}) or an ADaMIG version (for \code{ADPP}).
#'   \code{NULL} uses the newest available for that IG.
#' @param ct_version CT version to resolve codelist ids against; passed to
#'   \code{\link{get_ct}}. \code{NULL} uses the newest available.
#' @return A data frame with columns \code{variable}, \code{label},
#'   \code{type}, \code{length}, \code{core}, \code{order}, and
#'   \code{codelist_id} (the codelist's CT C-code, e.g. \code{"C85839"} for
#'   PPTESTCD's PKPARMCD codelist; \code{NA} when the variable has no
#'   codelist or the referenced codelist name is not found in the CT version
#'   used).
#' @export
#' @examples
#' build_domain_spec("PP")
#' build_domain_spec("SUPPPP")
#' build_domain_spec("ADPP")
build_domain_spec <- function(domain = c("PP", "SUPPPP", "ADPP"),
                              ig_version = NULL, ct_version = NULL) {
  domain <- match.arg(domain)

  if (domain %in% c("PP", "SUPPPP")) {
    ig_domain <- if (domain == "PP") "PP" else "SUPPQUAL"
    sdtmig_all <- get_ig("sdtm")
    sdtmig_all <- sdtmig_all[sdtmig_all$source == "SDTMIG", ]
    version <- .resolve_ig_version(ig_version, sdtmig_all$version, "SDTMIG")
    sub <- sdtmig_all[sdtmig_all$domain == ig_domain & sdtmig_all$version == version, ]
    if (nrow(sub) == 0L) {
      stop(paste0(
        "No SDTMIG '", ig_domain, "' variables found for version '", version, "'."
      ))
    }
    ct <- get_ct("sdtm", version = ct_version)
  } else {
    adamig_all <- get_ig("adam")
    version <- .resolve_ig_version(ig_version, adamig_all$version, "ADaMIG")
    sub <- adamig_all[adamig_all$dataset == "BDS" & adamig_all$version == version, ]
    if (nrow(sub) == 0L) {
      stop(paste0("No ADaMIG BDS variables found for version '", version, "'."))
    }
    ct <- get_ct("adam", version = ct_version)
  }

  codelist_id <- .lookup_codelist_id(sub$codelist, ct)

  data.frame(
    variable    = sub$variable,
    label       = sub$label,
    type        = sub$type,
    length      = sub$length,
    core        = sub$core,
    order       = sub$order,
    codelist_id = codelist_id,
    stringsAsFactors = FALSE
  )
}

# Resolve ig_version = NULL to the newest version present in `versions`
# (numeric comparison via package_version, so "1.10" would correctly rank
# above "1.9"); abort with the available list on an unknown explicit version.
.resolve_ig_version <- function(ig_version, versions, label) {
  avail <- sort(unique(versions))
  if (is.null(ig_version)) {
    return(as.character(max(package_version(avail))))
  }
  if (!ig_version %in% avail) {
    stop(paste0(
      "Version '", ig_version, "' is not available for ", label, ". ",
      "Available versions: ", paste(avail, collapse = ", "), "."
    ))
  }
  ig_version
}

# Map codelist submission values (e.g. "PKPARMCD") to their CT C-code (e.g.
# "C85839") via the codelist header rows (term_code is NA for those).
# NA in `codelist_names` (no codelist referenced) and names not found in
# this CT version (e.g. a codelist introduced in a CT release older/newer
# than the one used) both resolve to NA, not an error: the caller decides
# whether an unresolved codelist id is acceptable.
.lookup_codelist_id <- function(codelist_names, ct) {
  headers <- ct[is.na(ct$term_code), ]
  headers <- headers[!duplicated(headers$codelist_name), ]
  headers$codelist_code[match(codelist_names, headers$codelist_name)]
}
