# Build ig_sdtm, model_sdtm, ig_adam, and ig_sources from the 34 CDISC Library
# CSV exports (SDTM model, SDTMIG family, SENDIG family, ADaMIG family).
#
# Run from the package root:
#   CDISC_SOURCES_DIR=/path/to/exports Rscript data-raw/build_ig.R
#
# The exports are NOT in this repository and are never committed: they were
# downloaded under CDISC's own terms and conditions (see data-raw/README.md).
# This script reads them from CDISC_SOURCES_DIR (default "../cdisc-sources")
# and stops with a message listing the expected files if any is missing. Only
# variable metadata is transcribed (names, labels, types, roles, Core,
# codelists, order); the guide prose columns (CDISC Notes, Description,
# Definition, Notes, Examples) are never read into the data.
#
# Sourced by nothing else; the output is data/ig_sdtm.rda, data/model_sdtm.rda,
# data/ig_adam.rda, and data/ig_sources.rda. Re-run build_catalogue.R after.

# The version parser and the classed-condition helpers live in the package
# (R/ig_versions.R, R/utils.R) so tests can exercise them.
pkgload::load_all(".", quiet = TRUE)
source("data-raw/utils_ig.R")

paths <- cdisc_source_paths()

read_one <- function(file) {
  e <- read_library_export(paths[[file]])
  parsed <- .parse_ig_version(e$version_string)
  rows <- switch(
    e$shape,
    ig_sdtm  = ig_sdtm_rows(e$data, parsed),
    model_v1 = model_sdtm_rows(e$data, parsed),
    model_v2 = model_sdtm_rows(e$data, parsed),
    ig_adam  = ig_adam_rows(e$data, parsed)
  )
  stopifnot(nrow(rows) == nrow(e$data))
  list(
    rows = rows,
    source = data.frame(
      file = file,
      version_string = e$version_string,
      standard = parsed$standard,
      version = parsed$version,
      table = .ig_standards$table[match(parsed$standard, .ig_standards$standard)],
      rows = nrow(e$data),
      md5 = unname(tools::md5sum(paths[[file]])),
      stringsAsFactors = FALSE
    )
  )
}

loaded <- lapply(ig_source_files, read_one)
ig_sources <- do.call(rbind, lapply(loaded, `[[`, "source"))
rownames(ig_sources) <- NULL

# Every file is one distinct (standard, version): none loaded twice or missing.
stopifnot(
  length(loaded) == 34L,
  !anyDuplicated(paste(ig_sources$standard, ig_sources$version)),
  !anyDuplicated(ig_sources$file)
)

# Order standards as in the parser table and versions numerically.
std_rank <- match(ig_sources$standard, .ig_standards$standard)
ig_sources <- ig_sources[order(std_rank, package_version(ig_sources$version)), ]
rownames(ig_sources) <- NULL
loaded <- loaded[match(ig_sources$file, ig_source_files)]

bind_table <- function(table) {
  parts <- loaded[ig_sources$table == table]
  out <- do.call(rbind, lapply(parts, `[[`, "rows"))
  rownames(out) <- NULL
  out
}
ig_sdtm    <- bind_table("ig_sdtm")
model_sdtm <- bind_table("model_sdtm")
ig_adam    <- bind_table("ig_adam")

# Rows kept per (standard, version) equal the rows in the file it came from.
check_rows <- function(tbl, which_table) {
  src <- ig_sources[ig_sources$table == which_table, ]
  got <- table(paste(tbl$standard, tbl$version))
  stopifnot(identical(
    as.integer(got[paste(src$standard, src$version)]), as.integer(src$rows)
  ))
}
check_rows(ig_sdtm, "ig_sdtm")
check_rows(model_sdtm, "model_sdtm")
check_rows(ig_adam, "ig_adam")

# Identifying fields are never NA, and every key is unique. Keys:
# - ig_sdtm: (standard, version, domain, variable)
# - model_sdtm: (standard, version, class, dataset, variable); dataset is NA
#   for the observation-class variables, so the class is part of the key
# - ig_adam: (standard, version, structure, variable_set, variable); OCCDS
#   defines DECDORGw once per dictionary-specific variable set, so the set is
#   part of the key
key <- function(tbl, cols) do.call(paste, c(lapply(tbl[cols], as.character), sep = "\r"))
stopifnot(
  !anyNA(ig_sdtm[c("standard", "version", "domain", "variable", "label")]),
  !anyNA(model_sdtm[c("standard", "version", "class", "variable", "label")]),
  !anyNA(ig_adam[c("standard", "version", "structure", "variable_set", "variable", "label")]),
  !anyDuplicated(key(ig_sdtm, c("standard", "version", "domain", "variable"))),
  !anyDuplicated(key(model_sdtm, c("standard", "version", "class", "dataset", "variable"))),
  !anyDuplicated(key(ig_adam, c("standard", "version", "structure", "variable_set", "variable")))
)

usethis::use_data(ig_sdtm, model_sdtm, ig_adam, ig_sources,
                  overwrite = TRUE, compress = "xz")
message(sprintf(
  "ig_sdtm: %d rows (%d standard versions); model_sdtm: %d rows (%d); ig_adam: %d rows (%d); ig_sources: %d files.",
  nrow(ig_sdtm), sum(ig_sources$table == "ig_sdtm"),
  nrow(model_sdtm), sum(ig_sources$table == "model_sdtm"),
  nrow(ig_adam), sum(ig_sources$table == "ig_adam"),
  nrow(ig_sources)
))
