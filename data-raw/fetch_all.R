#!/usr/bin/env Rscript
# Run all fetch scripts in order. Safe to re-run; each script is idempotent.
# Usage: Rscript data-raw/fetch_all.R
#        (or triggered by GitHub Actions)
#
# Raw NCI text files are cached in data-raw/raw/ (sdtm/ and adam/ subdirs).
# These files are committed to the repository so that:
#   - Re-runs do not need to re-download files that already exist locally.
#   - The complete history of raw source files is preserved alongside the
#     processed .rda data.
# Commit data-raw/raw/ together with the updated data/ after each refresh.

message("=== cdiscdata data refresh ===")
message(Sys.time())

source("data-raw/utils_nci.R")
source("data-raw/utils_diff.R")

# Capture current CT versions before update (for change description)
old_sdtm_versions <- if (file.exists("data/ct_sdtm.rda")) {
  e <- new.env(parent = emptyenv())
  load("data/ct_sdtm.rda", envir = e)
  as.character(unique(e$ct_sdtm$valid_from))
} else {
  character(0)
}
old_adam_versions <- if (file.exists("data/ct_adam.rda")) {
  e <- new.env(parent = emptyenv())
  load("data/ct_adam.rda", envir = e)
  as.character(unique(e$ct_adam$valid_from))
} else {
  character(0)
}

message("\n--- SDTM CT ---")
source("data-raw/fetch_ct_sdtm.R")

message("\n--- ADaM CT ---")
source("data-raw/fetch_ct_adam.R")

message("\n--- XSD Schemas ---")
source("data-raw/fetch_schemas.R")

message("\n--- XSLT Stylesheets ---")
source("data-raw/fetch_stylesheets.R")

message("\n--- Rebuild datasets_catalogue ---")
source("data-raw/build_catalogue.R")

message("\n--- Change summary ---")
source("data-raw/describe_changes.R")
describe_ct_changes(ct_sdtm, prev_versions = old_sdtm_versions, label = "SDTM CT")
describe_ct_changes(ct_adam, prev_versions = old_adam_versions, label = "ADaM CT")

message("\n=== Done ===")
message(Sys.time())
