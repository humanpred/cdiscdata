# Rebuild the datasets_catalogue object after any data update.
# Called at the end of fetch_all.R (CT), and after build_ig_sdtm.R /
# build_ig_adam.R (IG metadata, which fetch_all.R does not touch).
# Requires ct_sdtm, ct_adam, ig_sdtm, and ig_adam to be loaded in the
# environment (e.g. via load("data/ct_sdtm.rda") or a prior build script).

build_version_range <- function(x) {
  x <- sort(unique(x))
  if (length(x) == 0L) return(NA_character_)
  if (length(x) == 1L) return(as.character(x))
  paste(min(x), "to", max(x))
}

# ── CT entries ────────────────────────────────────────────────────────────────
ct_entries <- data.frame(
  dataset = c("ct_sdtm", "ct_adam"),
  type    = c("CT", "CT"),
  ct_type = c("sdtm", "adam"),
  description = c(
    "SDTM Controlled Terminology",
    "ADaM Controlled Terminology"
  ),
  versions = c(
    build_version_range(ct_sdtm$valid_from),
    build_version_range(ct_adam$valid_from)
  ),
  n_versions = c(
    length(unique(ct_sdtm$valid_from)),
    length(unique(ct_adam$valid_from))
  ),
  latest = c(
    as.character(max(ct_sdtm$valid_from, na.rm = TRUE)),
    as.character(max(ct_adam$valid_from, na.rm = TRUE))
  ),
  last_updated = Sys.Date(),
  stringsAsFactors = FALSE
)

# ── IG entries ────────────────────────────────────────────────────────────────
# ig_sdtm bundles two independently-versioned sources (SDTM Model, SDTMIG;
# see R/data.R), so its version range is reported per source rather than as
# one min/max across both numbering systems.
ig_sdtm_model_versions <- sort(unique(ig_sdtm$version[ig_sdtm$source == "SDTM_MODEL"]))
ig_sdtm_ig_versions    <- sort(unique(ig_sdtm$version[ig_sdtm$source == "SDTMIG"]))
ig_adam_versions       <- sort(unique(ig_adam$version))

ig_entries <- data.frame(
  dataset = c("ig_sdtm", "ig_adam"),
  type    = c("IG", "IG"),
  ct_type = NA_character_,
  description = c(
    "SDTM Model + SDTMIG variable metadata",
    "ADaMIG ADSL + BDS variable metadata"
  ),
  versions = c(
    sprintf("Model %s (SDTMIG %s)",
            build_version_range(ig_sdtm_model_versions),
            paste(ig_sdtm_ig_versions, collapse = ", ")),
    build_version_range(ig_adam_versions)
  ),
  n_versions = c(
    length(ig_sdtm_model_versions) + length(ig_sdtm_ig_versions),
    length(ig_adam_versions)
  ),
  latest = c(
    max(ig_sdtm_model_versions),
    as.character(max(package_version(ig_adam_versions)))
  ),
  last_updated = Sys.Date(),
  stringsAsFactors = FALSE
)

# ── Schema / stylesheet entries ───────────────────────────────────────────────
schema_dir <- "inst/extdata/schema"
schema_dirs <- list.dirs(schema_dir, full.names = FALSE, recursive = FALSE)
schema_vers <- sort(
  sub("^define-xml-", "", schema_dirs[grepl("^define-xml-", schema_dirs)]),
  decreasing = TRUE
)

file_entries <- data.frame(
  dataset = c("define_xml_schema", "define_xml_stylesheet"),
  type    = c("Schema", "Stylesheet"),
  ct_type = NA_character_,
  description = c(
    "Define-XML XSD schemas",
    "Define-XML XSLT stylesheets"
  ),
  versions   = build_version_range(schema_vers),
  n_versions = length(schema_vers),
  latest     = if (length(schema_vers) > 0L) schema_vers[[1L]] else NA_character_,
  last_updated = Sys.Date(),
  stringsAsFactors = FALSE
)

# ── Combine and save ─────────────────────────────────────────────────────────
datasets_catalogue <- rbind(ct_entries, ig_entries, file_entries)

usethis::use_data(datasets_catalogue, overwrite = TRUE, compress = "xz")
message("datasets_catalogue saved.")
