# Build ig_sdtm, model_sdtm, ig_adam, cdash_model, ig_cdash, qrs_supplement,
# and ig_sources from 52 CDISC Library CSV exports: the SDTM model and the
# SDTMIG, SENDIG, and ADaMIG families (34), the CDASH model and CDASHIG (9),
# and nine QRS instrument supplements (9).
#
# Run from the package root:
#   CDISC_SOURCES_DIR=/path/to/exports Rscript data-raw/build_ig.R
#
# The exports are NOT in this repository and are never committed: they were
# downloaded under CDISC's own terms and conditions (see data-raw/README.md).
# This script reads them from CDISC_SOURCES_DIR (default "../cdisc-sources")
# and stops with a message listing the expected files if any is missing. Only
# variable metadata is transcribed (names, labels, types, roles, Core,
# codelists, order, and the CDASH collection wording); the guide prose columns
# (CDISC Notes, Description, Definition, Notes, Examples, Mapping and CRF
# Completion Instructions, Implementation Notes, QRS Item Text) are never read
# into the data.
#
# Sourced by nothing else; the output is data/ig_sdtm.rda, data/model_sdtm.rda,
# data/ig_adam.rda, data/cdash_model.rda, data/ig_cdash.rda,
# data/qrs_supplement.rda, and data/ig_sources.rda. Re-run build_catalogue.R
# after.

# The version parsers and the classed-condition helpers live in the package
# (R/ig_versions.R, R/utils.R) so tests can exercise them.
pkgload::load_all(".", quiet = TRUE)
source("data-raw/utils_ig.R")

all_files <- c(ig_source_files, cdash_source_files, qrs_source_files)
check_qrs_exports()
paths <- cdisc_source_paths(all_files)

# The dataset each export shape is loaded into.
shape_table <- c(
  ig_sdtm = "ig_sdtm", model_v1 = "model_sdtm", model_v2 = "model_sdtm",
  ig_adam = "ig_adam", cdash_model = "cdash_model", cdash_ig = "ig_cdash",
  qrs = "qrs_supplement"
)

read_one <- function(file) {
  e <- read_library_export(paths[[file]])
  if (e$shape == "qrs") {
    parsed <- .parse_qrs_filename(file)
    standard <- parsed$instrument
    table <- "qrs_supplement"
  } else {
    parsed <- .parse_ig_version(e$version_string)
    standard <- parsed$standard
    table <- .library_standards$table[match(standard, .library_standards$standard)]
  }
  # the layout of the file must be the layout its standard's dataset expects
  stopifnot(identical(unname(shape_table[[e$shape]]), table))
  rows <- switch(
    e$shape,
    ig_sdtm     = ig_sdtm_rows(e$data, parsed),
    model_v1    = model_sdtm_rows(e$data, parsed),
    model_v2    = model_sdtm_rows(e$data, parsed),
    ig_adam     = ig_adam_rows(e$data, parsed),
    cdash_model = cdash_model_rows(e$data, parsed),
    cdash_ig    = cdash_ig_rows(e$data, parsed),
    qrs         = qrs_rows(e$data, parsed)
  )
  stopifnot(nrow(rows) == nrow(e$data))
  list(
    rows = rows,
    source = data.frame(
      file = file,
      version_string = e$version_string,
      standard = standard,
      version = parsed$version,
      table = table,
      rows = nrow(e$data),
      md5 = unname(tools::md5sum(paths[[file]])),
      stringsAsFactors = FALSE
    )
  )
}

loaded <- lapply(all_files, read_one)
ig_sources <- do.call(rbind, lapply(loaded, `[[`, "source"))
rownames(ig_sources) <- NULL

# Every file is one distinct (standard or instrument, version): none loaded
# twice or missing.
stopifnot(
  length(loaded) == 52L,
  !anyDuplicated(paste(ig_sources$standard, ig_sources$version)),
  !anyDuplicated(ig_sources$file)
)

# Order the standards as in the parser table (the QRS instruments last, by
# name) and versions numerically.
is_qrs <- ig_sources$table == "qrs_supplement"
std_rank <- ifelse(is_qrs, nrow(.library_standards) + 1L,
                   match(ig_sources$standard, .library_standards$standard))
ig_sources <- ig_sources[order(std_rank, ig_sources$standard,
                               package_version(ig_sources$version)), ]
rownames(ig_sources) <- NULL
loaded <- loaded[match(ig_sources$file, all_files)]

bind_table <- function(table) {
  parts <- loaded[ig_sources$table == table]
  out <- do.call(rbind, lapply(parts, `[[`, "rows"))
  rownames(out) <- NULL
  out
}
ig_sdtm        <- bind_table("ig_sdtm")
model_sdtm     <- bind_table("model_sdtm")
ig_adam        <- bind_table("ig_adam")
cdash_model    <- bind_table("cdash_model")
ig_cdash       <- bind_table("ig_cdash")
qrs_supplement <- bind_table("qrs_supplement")

# Rows kept per (standard, version) equal the rows in the file it came from.
check_rows <- function(tbl, which_table, by = "standard") {
  src <- ig_sources[ig_sources$table == which_table, ]
  got <- table(paste(tbl[[by]], tbl$version))
  stopifnot(identical(
    as.integer(got[paste(src$standard, src$version)]), as.integer(src$rows)
  ))
}
check_rows(ig_sdtm, "ig_sdtm")
check_rows(model_sdtm, "model_sdtm")
check_rows(ig_adam, "ig_adam")
check_rows(cdash_model, "cdash_model")
check_rows(ig_cdash, "ig_cdash")
check_rows(qrs_supplement, "qrs_supplement", by = "instrument")

# Identifying fields are never NA, and every key is unique. Keys:
# - ig_sdtm: (standard, version, domain, variable)
# - model_sdtm: (standard, version, class, dataset, variable); dataset is NA
#   for the observation-class variables, so the class is part of the key
# - ig_adam: (standard, version, structure, variable_set, variable); OCCDS
#   defines DECDORGw once per dictionary-specific variable set, so the set is
#   part of the key
# - cdash_model: (standard, version, class, domain, variable)
# - ig_cdash: (standard, version, domain, scenario, variable); scenario is NA
#   for the variables common to a domain
# - qrs_supplement: (instrument, version, item_order)
# CDASHIG 1.1 publishes no variable label, so its label is the one NA allowed.
key <- function(tbl, cols) do.call(paste, c(lapply(tbl[cols], as.character), sep = "\r"))
stopifnot(
  !anyNA(ig_sdtm[c("standard", "version", "domain", "variable", "label")]),
  !anyNA(model_sdtm[c("standard", "version", "class", "variable", "label")]),
  !anyNA(ig_adam[c("standard", "version", "structure", "variable_set", "variable", "label")]),
  !anyNA(cdash_model[c("standard", "version", "class", "variable", "label", "type")]),
  !anyNA(ig_cdash[c("standard", "version", "class", "domain", "variable", "type", "core")]),
  !anyNA(ig_cdash$label[ig_cdash$version != "1.1"]),
  all(is.na(ig_cdash$label[ig_cdash$version == "1.1"])),
  !anyNA(qrs_supplement[c("instrument", "version", "item_order", "test_name", "testcd_code",
                          "test_code", "testcd_codelist_code", "test_codelist_code")]),
  !anyDuplicated(key(ig_sdtm, c("standard", "version", "domain", "variable"))),
  !anyDuplicated(key(model_sdtm, c("standard", "version", "class", "dataset", "variable"))),
  !anyDuplicated(key(ig_adam, c("standard", "version", "structure", "variable_set", "variable"))),
  !anyDuplicated(key(cdash_model, c("standard", "version", "class", "domain", "variable"))),
  !anyDuplicated(key(ig_cdash, c("standard", "version", "domain", "scenario", "variable"))),
  !anyDuplicated(key(qrs_supplement, c("instrument", "version", "item_order")))
)

usethis::use_data(ig_sdtm, model_sdtm, ig_adam, cdash_model, ig_cdash,
                  qrs_supplement, ig_sources,
                  overwrite = TRUE, compress = "xz")
message(sprintf(
  paste0("ig_sdtm: %d rows (%d standard versions); model_sdtm: %d rows (%d); ",
         "ig_adam: %d rows (%d); cdash_model: %d rows (%d); ig_cdash: %d rows (%d); ",
         "qrs_supplement: %d rows (%d); ig_sources: %d files."),
  nrow(ig_sdtm), sum(ig_sources$table == "ig_sdtm"),
  nrow(model_sdtm), sum(ig_sources$table == "model_sdtm"),
  nrow(ig_adam), sum(ig_sources$table == "ig_adam"),
  nrow(cdash_model), sum(ig_sources$table == "cdash_model"),
  nrow(ig_cdash), sum(ig_sources$table == "ig_cdash"),
  nrow(qrs_supplement), sum(ig_sources$table == "qrs_supplement"),
  nrow(ig_sources)
))
