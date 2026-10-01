#' Build a variable specification for PP, SUPPPP, or ADPP
#'
#' Combines \code{\link{get_ig}} (variable name, label, type, core, order,
#' codelist) with \code{\link{get_ct}} (is that codelist in the controlled
#' terminology release) into a single, ready-to-use variable specification for
#' one of the three PK datasets. \code{PP} and \code{SUPPPP} draw on an
#' SDTM-side implementation guide (\code{SUPPPP} from the generic SUPP--
#' structure, since CDISC has no domain-specific SUPPPP table); \code{ADPP}
#' draws on the ADaMIG Basic Data Structure (BDS) table, since ADPP is a BDS
#' dataset and CDISC has no ADPP-specific table either. An ADPP spec can
#' optionally be unioned with the ADaMIG ADSL table (\code{adsl}), with a BDS
#' extension such as ADaMIG-NCA (\code{extension}), and with the SDTM PP
#' domain's variables (\code{sdtm_domain}).
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
#' @param ig_version Version of \code{standard} to use. \code{NULL} uses the
#'   newest available.
#' @param ct_version CT version to check codelist ids against; passed to
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
#'   a variable already defined keeping that version, and codelist ids
#'   checked against the ADaM CT first and the SDTM CT second. Ignored (with
#'   a warning) for \code{domain != "ADPP"}; any value other than
#'   \code{"PP"} is an error.
#' @param sdtmig_version SDTMIG version to take the \code{sdtm_domain}
#'   variables from. \code{NULL} uses the newest available. Ignored (with a
#'   warning) unless \code{domain = "ADPP"} and \code{sdtm_domain} is set.
#' @param standard The implementation guide to take the domain's variables
#'   from. \code{NULL} (the default) uses \code{"SDTMIG"} for \code{PP} and
#'   \code{SUPPPP} and \code{"ADaMIG"} for \code{ADPP}; any standard in
#'   \code{\link{get_ig}} that has the domain works (e.g. \code{"SENDIG"}
#'   defines \code{PP} too).
#' @param extension For \code{domain = "ADPP"} only: \code{NULL} (the
#'   default) adds nothing; \code{"ADaMIG-NCA"} (or the alias \code{"NCA"}),
#'   \code{"ADaM-popPK"}, or \code{"ADaM-BDS-TTE"} unions that BDS extension
#'   onto the BDS variables. Unlike the ADSL and PP unions, the extension's
#'   own Core designations are kept, as they are the point of the extension: a
#'   new variable is appended with its published Core, and a variable the BDS
#'   already defines takes the extension's (stronger) Core (e.g. \code{AVISIT}
#'   becomes required in ADaMIG-NCA). Rows the extension touches are marked
#'   with its name in \code{source}. Ignored (with a warning) for
#'   \code{domain != "ADPP"}.
#' @param extension_version Version of the \code{extension}; \code{NULL} uses
#'   the newest. Ignored (with a warning) unless \code{domain = "ADPP"} and
#'   \code{extension} is set.
#' @return A data frame with columns \code{variable}, \code{label},
#'   \code{type}, \code{length}, \code{core}, \code{order}, \code{source}, and
#'   \code{codelist_id}. \code{source} is \code{"SDTMIG"} (or the SDTM-side
#'   \code{standard}) for \code{PP}/\code{SUPPPP}; \code{"BDS"},
#'   \code{"ADSL"}, \code{"SDTMIG"}, or the extension's name for \code{ADPP}.
#'   \code{order} is the published order, renumbered consecutively, with
#'   unioned variables following. \code{codelist_id} is the C-code of the
#'   first codelist the IG lists for the variable, when that codelist is in
#'   the CT release used, and \code{NA} otherwise (no codelist, or one not in
#'   that release, e.g. a codelist since retired). \code{length} is always
#'   \code{NA}: the CDISC Library exports this package is built from carry no
#'   length, which is a sponsor choice, and the column is kept so existing
#'   code that reads it keeps working. ADSL-sourced \code{ADPP} rows have
#'   \code{core} forced to \code{"Perm"} regardless of their Core designation
#'   in ADSL itself: from ADPP's perspective, merging in an ADSL variable is a
#'   common but optional choice, not a requirement ADSL's own Core reflects.
#' @export
#' @examples
#' build_domain_spec("PP")
#' build_domain_spec("SUPPPP")
#' build_domain_spec("ADPP")               # BDS + ADSL (default)
#' build_domain_spec("ADPP", adsl = FALSE) # BDS only
#' build_domain_spec("ADPP", sdtm_domain = "PP")  # BDS + ADSL + PP variables
#' build_domain_spec("ADPP", extension = "NCA")   # BDS + ADSL + ADaMIG-NCA
build_domain_spec <- function(domain = c("PP", "SUPPPP", "ADPP"),
                              ig_version = NULL, ct_version = NULL,
                              adsl = TRUE, sdtm_domain = NULL,
                              sdtmig_version = NULL, standard = NULL,
                              extension = NULL, extension_version = NULL) {
  domain <- match.arg(domain)
  if (domain == "ADPP") {
    return(.spec_adpp(
      standard %||% "ADaMIG", ig_version, ct_version, adsl, sdtm_domain,
      sdtmig_version, extension, extension_version
    ))
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
  if (!is.null(extension) || !is.null(extension_version)) {
    .cdiscdata_warn(
      "`extension` and `extension_version` are ignored for domain != \"ADPP\".",
      "extension_ignored"
    )
  }
  rows <- .sdtmig_domain_rows(if (domain == "PP") "PP" else "SUPPQUAL",
                              standard %||% "SDTMIG", ig_version)
  ct <- get_ct("sdtm", version = ct_version)
  .spec_frame(rows, .codelist_ids(rows$codelist_code, list(ct)))
}

# The columns of a variable spec, from any IG table's rows.
.spec_columns <- c("variable", "label", "type", "core", "order", "source",
                   "codelist_code")

.spec_frame <- function(sub, codelist_id) {
  data.frame(
    variable    = sub$variable,
    label       = sub$label,
    type        = sub$type,
    length      = rep(NA_integer_, nrow(sub)),
    core        = sub$core,
    order       = sub$order,
    source      = sub$source,
    codelist_id = codelist_id,
    stringsAsFactors = FALSE
  )
}

# The first codelist code of each IG codelist cell ("C85494; C128684" lists
# several), kept only if that codelist is in a controlled-terminology release:
# the first release in `cts` that has it decides, NA when none does.
.codelist_ids <- function(codelist_code, cts) {
  first <- trimws(sub(";.*$", "", codelist_code))
  id <- rep(NA_character_, length(first))
  for (ct in cts) {
    known <- unique(ct$codelist_code[is.na(ct$term_code)])
    hit <- is.na(id) & first %in% known
    id[hit] <- first[hit]
  }
  id
}

# SDTM-side IG variables for one domain ("PP" or "SUPPQUAL") of `standard` at
# `ig_version` (NULL = newest), marked with the standard as their source.
.sdtmig_domain_rows <- function(ig_domain, standard, ig_version) {
  tbl <- get_ig(standard, version = ig_version)
  rows <- tbl[tbl$domain == ig_domain, ]
  if (nrow(rows) == 0L) {
    .cdiscdata_abort(
      paste0("No ", standard, " '", ig_domain, "' variables found for version '",
             unique(tbl$version), "'."),
      "no_ig_variables"
    )
  }
  rows$source <- standard
  rows$order <- seq_len(nrow(rows))
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

# The BDS extensions that can be unioned onto an ADaMIG BDS spec; "NCA" is
# accepted as a short name for the first.
.adam_extensions <- c("ADaMIG-NCA", "ADaM-popPK", "ADaM-BDS-TTE")

# Union a BDS extension onto `base`. Its Core designations are kept (they are
# the point of an extension): a variable `base` already has takes the
# extension's Core and is marked with the extension's name, a new one is
# appended with its published Core.
.apply_extension <- function(base, ext, source) {
  ext$source <- source
  hit <- match(ext$variable, base$variable)
  known <- !is.na(hit)
  base$core[hit[known]] <- ext$core[known]
  base$source[hit[known]] <- source
  new <- ext[!known, ]
  new$order <- max(base$order) + seq_len(nrow(new))
  rbind(base[, .spec_columns], new[, .spec_columns])
}

.extension_rows <- function(extension, extension_version) {
  extension <- switch(extension, NCA = "ADaMIG-NCA", extension)
  if (!extension %in% .adam_extensions) {
    .cdiscdata_abort(
      paste0(
        "`extension` must be NULL or one of ",
        paste0("\"", c(.adam_extensions, "NCA"), "\"", collapse = ", "),
        ", not '", extension, "'."
      ),
      "extension_unavailable"
    )
  }
  list(name = extension, rows = get_ig(extension, version = extension_version))
}

.spec_adpp <- function(standard, ig_version, ct_version, adsl, sdtm_domain,
                       sdtmig_version, extension, extension_version) {
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
  if (is.null(extension) && !is.null(extension_version)) {
    .cdiscdata_warn("`extension_version` is ignored when `extension` is NULL.",
                    "extension_ignored")
  }
  ext <- if (is.null(extension)) NULL else .extension_rows(extension, extension_version)

  adam <- get_ig(standard, version = ig_version)
  bds <- adam[adam$structure == .adam_structure_aliases[["BDS"]], ]
  if (nrow(bds) == 0L) {
    .cdiscdata_abort(
      paste0("No ", standard, " BDS variables found for version '",
             unique(adam$version), "'."),
      "no_ig_variables"
    )
  }
  ct_adam <- get_ct("adam", version = ct_version)

  bds$source <- "BDS"
  bds$order <- seq_len(nrow(bds))
  sub <- bds[, .spec_columns]
  if (isTRUE(adsl)) {
    adsl_tbl <- adam[adam$structure == .adam_structure_aliases[["ADSL"]], ]
    sub <- .append_unique(sub, adsl_tbl, "ADSL")
  }
  if (!is.null(ext)) {
    sub <- .apply_extension(sub, ext$rows, ext$name)
  }
  if (!is.null(sdtm_domain)) {
    sub <- .append_unique(sub, .sdtmig_domain_rows(sdtm_domain, "SDTMIG", sdtmig_version),
                          "SDTMIG")
  }

  cts <- list(ct_adam)
  if (isTRUE(adsl) || !is.null(sdtm_domain) || !is.null(ext)) {
    # ADSL variables carried from SDTM DM (SEX, RACE, AGEU, ...), PP's own
    # codelists (PKPARMCD, PKUNIT, ...), and an extension's are SDTM CT, not
    # ADaM's much smaller CT; ADaM CT is checked first, SDTM CT second.
    cts <- c(cts, list(get_ct("sdtm", version = ct_version)))
  }
  .spec_frame(sub, .codelist_ids(sub$codelist_code, cts))
}

# NULL-coalescing, for optional arguments with a computed default.
`%||%` <- function(x, y) if (is.null(x)) y else x
