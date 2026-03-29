# Rebuild the datasets_catalogue object after any data update.
# Called at the end of fetch_all.R.
# Requires ct_sdtm and ct_adam to be loaded in the environment.

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
datasets_catalogue <- rbind(ct_entries, file_entries)

usethis::use_data(datasets_catalogue, overwrite = TRUE, compress = "xz")
message("datasets_catalogue saved.")
