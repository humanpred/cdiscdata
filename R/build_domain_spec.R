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
#' also carries ADSL's subject-level variables.
#'
#' This does not add PP-inherited traceability variables (\code{PPTESTCD},
#' \code{PPTEST}, and the rest of PP's variables that a BDS dataset built
#' from PP typically carries forward). Neither the ADaMIG BDS nor ADSL
#' tables define those; which of PP's variables to carry into ADPP, and
#' under what names, is a downstream derivation choice (e.g. admiral's own
#' conventions), not IG metadata this function can source.
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
#' @return A data frame with columns \code{variable}, \code{label},
#'   \code{type}, \code{length}, \code{core}, \code{order}, \code{source}
#'   (\code{"SDTMIG"} for \code{PP}/\code{SUPPPP}; \code{"BDS"} or
#'   \code{"ADSL"} for \code{ADPP}), and \code{codelist_id} (the codelist's
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
build_domain_spec <- function(domain = c("PP", "SUPPPP", "ADPP"),
                              ig_version = NULL, ct_version = NULL,
                              adsl = TRUE) {
  domain <- match.arg(domain)
  if (domain != "ADPP" && !isTRUE(adsl)) {
    .cdiscdata_warn(
      "`adsl` is ignored for domain != \"ADPP\".",
      "adsl_ignored"
    )
  }

  if (domain %in% c("PP", "SUPPPP")) {
    ig_domain <- if (domain == "PP") "PP" else "SUPPQUAL"
    sdtmig_all <- get_ig("sdtm")
    sdtmig_all <- sdtmig_all[sdtmig_all$source == "SDTMIG", ]
    version <- .resolve_ig_version(ig_version, sdtmig_all$version, "SDTMIG")
    sub <- sdtmig_all[sdtmig_all$domain == ig_domain & sdtmig_all$version == version, ]
    if (nrow(sub) == 0L) {
      .cdiscdata_abort(
        paste0("No SDTMIG '", ig_domain, "' variables found for version '", version, "'."),
        "no_ig_variables"
      )
    }
    ct <- get_ct("sdtm", version = ct_version)
    sub$source <- "SDTMIG"
    codelist_id <- .lookup_codelist_id(sub$codelist, ct)
  } else {
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

    if (isTRUE(adsl)) {
      adsl_tbl <- adamig_all[adamig_all$dataset == "ADSL" & adamig_all$version == version, ]
      # ADSL and BDS both define several shared base variables (STUDYID,
      # USUBJID, ...); a real ADPP carries each once, so ADSL contributes
      # only the variables BDS does not already define, keeping BDS's
      # version (and its own Core) for anything in both.
      adsl_tbl <- adsl_tbl[!adsl_tbl$variable %in% bds$variable, ]
      adsl_tbl$source <- "ADSL"
      adsl_tbl$core <- "Perm"
      adsl_tbl$order <- max(bds$order) + seq_len(nrow(adsl_tbl))
      sub <- rbind(bds, adsl_tbl)
      # ADSL variables carried from SDTM DM (SEX, RACE, AGEU, ...) reuse
      # SDTM's codelists, not ADaM's much smaller CT; ADaM CT is checked
      # first (matching the BDS-only behaviour), SDTM CT second.
      ct_sdtm <- get_ct("sdtm", version = ct_version)
      codelist_id <- .lookup_codelist_id(sub$codelist, ct_adam)
      fallback <- is.na(codelist_id) & !is.na(sub$codelist)
      codelist_id[fallback] <- .lookup_codelist_id(sub$codelist[fallback], ct_sdtm)
    } else {
      sub <- bds
      codelist_id <- .lookup_codelist_id(sub$codelist, ct_adam)
    }
  }

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
