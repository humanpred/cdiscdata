#' Build a variable specification for PP, SUPPPP, or ADPP
#'
#' Combines \code{\link{get_ig}} (variable name, label, type, core, order)
#' with \code{\link{get_ct}} (codelist id lookup) into a single, ready-to-use
#' variable specification for one of the three PK datasets. \code{PP} and
#' \code{SUPPPP} draw on the SDTMIG (\code{SUPPPP} from the generic SUPP--
#' structure, since CDISC has no domain-specific SUPPPP table); \code{ADPP}
#' draws on the ADaMIG BDS (Basic Data Structure) table, since ADPP is a BDS
#' dataset and CDISC has no ADPP-specific table either, optionally unioned
#' with the ADaMIG ADSL table (see \code{adsl} below), since a real ADPP
#' also carries ADSL's subject-level variables, and optionally with the SDTM
#' PP domain's variables (see \code{sdtm_domain} below).
#'
#' Neither the ADaMIG BDS nor ADSL tables define the PP-inherited
#' traceability variables (\code{PPTESTCD}, \code{PPTEST}, and the rest of
#' PP's variables that a BDS dataset built from PP typically carries
#' forward); which of PP's variables to carry into ADPP, and under what
#' names, is a downstream derivation choice (e.g. admiral's own
#' conventions), so they are only added when asked for with
#' \code{sdtm_domain}, and the default leaves them out.
#'
#' @param domain One of \code{"PP"}, \code{"SUPPPP"}, or \code{"ADPP"}.
#' @param ig_version IG version to use: an SDTMIG version (for \code{PP}/
#'   \code{SUPPPP}) or an ADaMIG version (for \code{ADPP}).
#'   \code{NULL} uses the newest available for that IG.
#' @param ct_version CT version to resolve codelist ids against; passed to
#'   \code{\link{get_ct}}. \code{NULL} uses the newest available.
#' @param adsl For \code{domain = "ADPP"} only: whether to union in the
#'   ADaMIG ADSL variables (default \code{TRUE}), since a real ADPP dataset
#'   carries ADSL's subject-level variables (treatment, demographics, ...)
#'   alongside its own BDS variables. \code{FALSE} returns the BDS variables
#'   alone. Ignored (with a warning) for \code{domain != "ADPP"}.
#' @param sdtm_domain For \code{domain = "ADPP"} only: \code{NULL} (the
#'   default) adds nothing; \code{"PP"} also unions in the SDTMIG PP
#'   domain's variables, the same way \code{adsl = TRUE} unions ADSL's:
#'   marked \code{source = "SDTMIG"}, \code{core} forced to \code{"Perm"},
#'   a variable already defined by BDS or ADSL (e.g. \code{STUDYID},
#'   \code{USUBJID}) keeping that version, and codelist ids resolved against
#'   the ADaM CT first and the SDTM CT second. Ignored (with a warning) for
#'   \code{domain != "ADPP"}; any value other than \code{"PP"} is an error.
#' @param sdtmig_version SDTMIG version to take the \code{sdtm_domain}
#'   variables from. \code{NULL} uses the newest available. Ignored (with a
#'   warning) unless \code{domain = "ADPP"} and \code{sdtm_domain} is set.
#' @return A data frame with columns \code{variable}, \code{label},
#'   \code{type}, \code{length}, \code{core}, \code{order}, \code{source}
#'   (\code{"SDTMIG"} for \code{PP}/\code{SUPPPP}; \code{"BDS"},
#'   \code{"ADSL"}, or \code{"SDTMIG"} for \code{ADPP}), and \code{codelist_id} (the codelist's
#'   CT C-code, e.g. \code{"C85839"} for PPTESTCD's PKPARMCD codelist;
#'   \code{NA} when the variable has no codelist or the referenced codelist
#'   name is not found in the CT version used). ADSL-sourced \code{ADPP} rows
#'   have \code{core} forced to \code{"Perm"} regardless of their Core
#'   designation in ADSL itself: from ADPP's perspective, merging in an
#'   ADSL variable is a common but optional choice, not a requirement ADSL's
#'   own Core reflects.
#' @export
#' @examples
#' build_domain_spec("PP")
#' build_domain_spec("SUPPPP")
#' build_domain_spec("ADPP")               # BDS + ADSL (default)
#' build_domain_spec("ADPP", adsl = FALSE) # BDS only
#' build_domain_spec("ADPP", sdtm_domain = "PP") # BDS + ADSL + PP variables
build_domain_spec <- function(domain = c("PP", "SUPPPP", "ADPP"),
                              ig_version = NULL, ct_version = NULL,
                              adsl = TRUE, sdtm_domain = NULL,
                              sdtmig_version = NULL) {
  domain <- match.arg(domain)
  if (domain == "ADPP") {
    return(.spec_adpp(ig_version, ct_version, adsl, sdtm_domain, sdtmig_version))
  }

  if (!isTRUE(adsl)) {
    .cdiscdata_warn(
      "`adsl` is ignored for domain != \"ADPP\".",
      "adsl_ignored"
    )
  }
  if (!is.null(sdtm_domain) || !is.null(sdtmig_version)) {
    .cdiscdata_warn(
      "`sdtm_domain` and `sdtmig_version` are ignored for domain != \"ADPP\".",
      "sdtm_domain_ignored"
    )
  }
  rows <- .sdtmig_domain_rows(if (domain == "PP") "PP" else "SUPPQUAL", ig_version)
  ct <- get_ct("sdtm", version = ct_version)
  .spec_frame(rows, .lookup_codelist_id(rows$codelist, ct))
}

# The columns of a variable spec, from any IG table's rows.
.spec_columns <- c("variable", "label", "type", "length", "core", "order",
                   "source", "codelist")

.spec_frame <- function(sub, codelist_id) {
  data.frame(
    variable    = sub$variable,
    label       = sub$label,
    type        = sub$type,
    length      = sub$length,
    core        = sub$core,
    order       = sub$order,
    source      = sub$source,
    codelist_id = codelist_id,
    stringsAsFactors = FALSE
  )
}

# SDTMIG variables for one domain ("PP" or "SUPPQUAL") at `ig_version`
# (NULL = newest SDTMIG), marked source = "SDTMIG".
.sdtmig_domain_rows <- function(ig_domain, ig_version) {
  sdtmig_all <- get_ig("sdtm")
  sdtmig_all <- sdtmig_all[sdtmig_all$source == "SDTMIG", ]
  version <- .resolve_ig_version(ig_version, sdtmig_all$version, "SDTMIG")
  rows <- sdtmig_all[sdtmig_all$domain == ig_domain & sdtmig_all$version == version, ]
  if (nrow(rows) == 0L) {
    .cdiscdata_abort(
      paste0("No SDTMIG '", ig_domain, "' variables found for version '", version, "'."),
      "no_ig_variables"
    )
  }
  rows$source <- "SDTMIG"
  rows
}

# Append `extra`'s variables to `base` that `base` does not already define,
# marked with `source`, core forced to "Perm" (from ADPP's perspective,
# merging a variable in from ADSL or SDTM is always optional, whatever Core
# that table gives it for itself), and ordered after everything in `base`.
# A variable both define keeps `base`'s version, as a real ADPP carries it once.
.append_unique <- function(base, extra, source) {
  extra <- extra[!extra$variable %in% base$variable, ]
  extra$source <- source
  extra$core <- "Perm"
  extra$order <- max(base$order) + seq_len(nrow(extra))
  rbind(base[, .spec_columns], extra[, .spec_columns])
}

.spec_adpp <- function(ig_version, ct_version, adsl, sdtm_domain, sdtmig_version) {
  if (!is.null(sdtm_domain) && !identical(sdtm_domain, "PP")) {
    .cdiscdata_abort(
      paste0(
        "`sdtm_domain` must be NULL or \"PP\" (the SDTMIG domain an ADPP is built from), not '",
        paste(sdtm_domain, collapse = "', '"), "'."
      ),
      "sdtm_domain_unavailable"
    )
  }
  if (is.null(sdtm_domain) && !is.null(sdtmig_version)) {
    .cdiscdata_warn("`sdtmig_version` is ignored when `sdtm_domain` is NULL.",
                    "sdtm_domain_ignored")
  }

  adamig_all <- get_ig("adam")
  version <- .resolve_ig_version(ig_version, adamig_all$version, "ADaMIG")
  bds <- adamig_all[adamig_all$dataset == "BDS" & adamig_all$version == version, ]
  if (nrow(bds) == 0L) {
    .cdiscdata_abort(
      paste0("No ADaMIG BDS variables found for version '", version, "'."),
      "no_ig_variables"
    )
  }
  bds$source <- "BDS"
  ct_adam <- get_ct("adam", version = ct_version)

  sub <- bds[, .spec_columns]
  if (isTRUE(adsl)) {
    adsl_tbl <- adamig_all[adamig_all$dataset == "ADSL" & adamig_all$version == version, ]
    sub <- .append_unique(sub, adsl_tbl, "ADSL")
  }
  if (!is.null(sdtm_domain)) {
    sub <- .append_unique(sub, .sdtmig_domain_rows(sdtm_domain, sdtmig_version), "SDTMIG")
  }

  codelist_id <- .lookup_codelist_id(sub$codelist, ct_adam)
  if (isTRUE(adsl) || !is.null(sdtm_domain)) {
    # ADSL variables carried from SDTM DM (SEX, RACE, AGEU, ...) and PP's own
    # codelists (PKPARMCD, PKUNIT, ...) are SDTM CT, not ADaM's much smaller
    # CT; ADaM CT is checked first (matching the BDS-only behaviour), SDTM CT
    # second.
    ct_sdtm <- get_ct("sdtm", version = ct_version)
    fallback <- is.na(codelist_id) & !is.na(sub$codelist)
    codelist_id[fallback] <- .lookup_codelist_id(sub$codelist[fallback], ct_sdtm)
  }
  .spec_frame(sub, codelist_id)
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
    .cdiscdata_abort(
      paste0(
        "Version '", ig_version, "' is not available for ", label, ". ",
        "Available versions: ", paste(avail, collapse = ", "), "."
      ),
      "ig_version_unavailable"
    )
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
