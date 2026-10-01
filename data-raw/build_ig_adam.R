# Build the versioned `ig_adam` dataset: the ADaMIG ADSL (subject-level)
# variable table and the generic BDS (Basic Data Structure) variable table
# that ADPP, as a BDS-structured dataset, uses.
#
# Source: CSV transcriptions of CDISC's published ADaMIG specification
# tables, copied read-only from Bill Denney's Rsdtm package
# (github.com/humanpred/Rsdtm, private) into data-raw/ig_source/adamig_*/ so
# this build has no dependency on that package's checkout being present. See
# data-raw/ig_source/README.md for the full source/attribution note.
#
# Rsdtm splits each version's ADSL and BDS variables across several
# category files (e.g. ADSL_Dose_Variables.csv, Timing_Variables_BDS_Datasets.csv)
# rather than one file per dataset; every file in a version's directory
# whose name starts with "ADSL" is an ADSL category, everything else is a
# BDS category (true for all three transcribed versions: 1.0, 1.1, 1.2).

source("data-raw/utils_ig.R")

adamig_versions <- c("1.0", "1.1", "1.2")

build_adamig_version <- function(version) {
  dir <- file.path("data-raw/ig_source", paste0("adamig_", version))
  files <- sort(list.files(dir, pattern = "[.]csv$", full.names = FALSE))
  is_adsl <- startsWith(files, "ADSL")

  rows_for <- function(file, dataset) {
    tbl <- read_ig_csv(file.path(dir, file))
    # ADaMIG 1.0's combined ADSL-specification.csv carries five section
    # sub-headings as rows ("Study Identifiers", "Subject Demographics",
    # "Population Indicator(s)", "Treatment Variables", "Trial Dates"):
    # no Type, Core, or label, because they are not variables.
    tbl <- tbl[!is.na(tbl$type), ]
    category <- tools::file_path_sans_ext(file)
    data.frame(
      dataset  = dataset,
      version  = version,
      category = category,
      order    = seq_len(nrow(tbl)),
      variable = tbl$variable,
      label    = tbl$label,
      type     = tbl$type,
      core     = tbl$core,
      codelist = parse_codelist_token(tbl$codelist),
      length   = parse_documented_length(tbl$notes),
      notes    = tbl$notes,
      stringsAsFactors = FALSE
    )
  }

  do.call(rbind, c(
    Map(rows_for, files[is_adsl], "ADSL"),
    Map(rows_for, files[!is_adsl], "BDS")
  ))
}

ig_adam <- do.call(rbind, lapply(adamig_versions, build_adamig_version))
rownames(ig_adam) <- NULL

# ── Labels over the 40-character XPT limit ─────────────────────────────────
# Checked against the published ADaMIG v1.2 (draft) on the CDISC wiki
# (https://wiki.cdisc.org/download/attachments/54282867/ADaMIG-ADaMIG-compiled-191217-0027-11448.pdf),
# section 3.3.4.1, Table 3.3.4.1.1 "Analysis Parameter Variables for BDS
# Datasets": PBCHGCyN is published as "Percent Change to Baseline Category y
# (N)" (41 characters), so the IG itself exceeds the limit there. Its sibling
# rows in the same table abbreviate "Change" to "Chg" for the same reason
# (PCHGCATy "Percent Chg from Baseline Category y", PCHGCAyN "Percent Chg from
# Baseline Category y (N)"); this applies the same abbreviation, which is a
# derived label, not one the IG publishes.
adam_label_overrides <- data.frame(
  dataset  = "BDS",
  version  = "1.2",
  variable = "PBCHGCyN",
  label    = "Percent Chg to Baseline Category y (N)",
  evidence = "ADaMIG v1.2 draft Table 3.3.4.1.1 (PBCHGCyN 41 chars; sibling PCHGCAyN abbreviates Chg)",
  stringsAsFactors = FALSE
)
ig_adam <- apply_label_overrides(ig_adam, adam_label_overrides,
                                 by = c("dataset", "version", "variable"))

stopifnot(
  all(c("dataset", "version", "category", "order", "variable", "label", "type",
        "core", "codelist", "length", "notes") %in% names(ig_adam)),
  !anyNA(ig_adam$variable), !anyNA(ig_adam$version), !anyNA(ig_adam$label)
)

usethis::use_data(ig_adam, overwrite = TRUE, compress = "xz")
message(sprintf(
  "ig_adam saved: %d rows across %d versions (%d ADSL, %d BDS).",
  nrow(ig_adam), length(adamig_versions),
  sum(ig_adam$dataset == "ADSL"), sum(ig_adam$dataset == "BDS")
))
