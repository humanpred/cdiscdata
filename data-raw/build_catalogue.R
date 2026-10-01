# Rebuild the datasets_catalogue object after any data update.
# Called at the end of fetch_all.R (CT), and after build_ig.R (IG and model
# metadata, which fetch_all.R does not touch).
# Requires ct_sdtm, ct_adam, ig_sdtm, model_sdtm, and ig_adam to be loaded in
# the environment (e.g. via load("data/ct_sdtm.rda") or a prior build script).

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

# ── IG and model entries ──────────────────────────────────────────────────────
# Each of these tables holds several standards, each with its own version
# numbering, so the version range is reported per standard ("SDTMIG 3.1.2 to
# 3.4; SDTMIG-AP 1.0; ..."), n_versions counts (standard, version) pairs, and
# `latest` is NA because there is no single latest across standards.
describe_standards <- function(tbl) {
  parts <- vapply(split(tbl$version, tbl$standard), function(v) {
    v <- unique(v)
    v <- v[order(package_version(v))]
    if (length(v) == 1L) v else paste(v[[1L]], "to", v[[length(v)]])
  }, character(1L))
  parts <- parts[unique(tbl$standard)]
  paste(paste(names(parts), parts), collapse = "; ")
}
count_versions <- function(tbl) nrow(unique(tbl[c("standard", "version")]))

ig_entries <- data.frame(
  dataset = c("ig_sdtm", "model_sdtm", "ig_adam"),
  type    = c("IG", "Model", "IG"),
  ct_type = NA_character_,
  description = c(
    "SDTMIG, SENDIG and related SDTM-side implementation-guide variable metadata",
    "SDTM model variable metadata",
    "ADaMIG and related ADaM implementation-guide variable metadata"
  ),
  versions = c(
    describe_standards(ig_sdtm),
    describe_standards(model_sdtm),
    describe_standards(ig_adam)
  ),
  n_versions = c(
    count_versions(ig_sdtm),
    count_versions(model_sdtm),
    count_versions(ig_adam)
  ),
  latest = NA_character_,
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
