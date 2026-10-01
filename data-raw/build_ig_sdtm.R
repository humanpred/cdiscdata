# Build the versioned `ig_sdtm` dataset: SDTM Model class-level variables
# (Findings observation class) plus SDTMIG domain-specific variables (PP,
# and the generic SUPP-- qualifier structure used for SUPPPP).
#
# Source: CSV transcriptions of CDISC's published SDTM Model and SDTMIG
# specification tables, copied read-only from Bill Denney's Rsdtm package
# (github.com/humanpred/Rsdtm, private) into data-raw/ig_source/ so this
# build has no dependency on that package's checkout being present. See
# data-raw/ig_source/README.md for the full source/attribution note.
#
# Coverage is limited by what Rsdtm's data-raw/ happens to have transcribed:
# the SDTM Model is available for versions 1.4-1.7 (Findings class only, the
# class PP/SUPPPP need); the SDTMIG PP and Supplemental Qualifiers domain
# specifications are only transcribed for version 3.2 (Rsdtm's SDTMIG_3.3
# copy covers a different, unrelated set of domains).
#
# SDTMIG 3.3 reuses the 3.2 tables: the published SDTMIG v3.3 stamps its PP
# specification "Version 3.2" (so it is unchanged since 3.2; its revision
# history lists no PP change) and its SUPP-- specification, while stamped
# 3.3, has the same ten variables with the same labels and types. See
# `sdtmig_sources` below and data-raw/ig_source/README.md. A newer SDTMIG's
# tables can be added by copying the equivalent CSVs into
# data-raw/ig_source/sdtmig_<version>/ and adding the version to
# `sdtmig_sources`.

source("data-raw/utils_ig.R")

# ── SDTM Model: Findings observation class ─────────────────────────────────
model_versions <- c("1.4", "1.5", "1.6", "1.7")

model_rows <- do.call(rbind, lapply(model_versions, function(v) {
  path <- file.path("data-raw/ig_source/sdtm_model", v, "Findings_Observation_Class.csv")
  tbl  <- read_ig_csv(path)
  # Rows with no Type are section sub-headings embedded in the source table
  # ("Topic Variable", "Qualifier Variables", ...), not real variables.
  tbl  <- tbl[!is.na(tbl$type), ]
  data.frame(
    source   = "SDTM_MODEL",
    version  = v,
    class    = "Findings",
    domain   = NA_character_,
    order    = seq_len(nrow(tbl)),
    variable = tbl$variable,
    label    = tbl$label,
    type     = tbl$type,
    role     = tbl$role,
    core     = NA_character_,
    codelist = NA_character_,
    length   = NA_integer_,
    notes    = tbl$notes,
    stringsAsFactors = FALSE
  )
}))

# ── SDTMIG: PP and Supplemental Qualifiers (SUPP--) ─────────────────────────
# SDTMIG version -> data-raw/ig_source/sdtmig_<dir> its tables are read from.
sdtmig_sources <- c("3.2" = "3.2", "3.3" = "3.2")
sdtmig_versions <- names(sdtmig_sources)

# PP variables the SDTMIG v3.3 PDF (section 6.3.11.2, PP specification table)
# shows that Rsdtm's SDTMIG 3.2 transcription lacks (it has 21 of the 24 rows,
# evidently dropping the ones straddling a page break). Each row names the
# variable it follows, so the published order is kept.
read_pp_additions <- function() {
  utils::read.csv("data-raw/ig_source/sdtmig_3.2/PP-additions.csv",
                  stringsAsFactors = FALSE, na.strings = "")
}

insert_pp_additions <- function(tbl, additions) {
  for (i in seq_len(nrow(additions))) {
    a <- additions[i, ]
    pos <- match(a$after, tbl$variable)
    stopifnot(!is.na(pos), !a$variable %in% tbl$variable)
    new <- data.frame(
      variable = a$variable, label = a$label, type = a$type,
      core = a$core, codelist = a$codelist, role = a$role,
      notes = NA_character_, stringsAsFactors = FALSE
    )
    tbl <- rbind(tbl[seq_len(pos), names(new)], new,
                 tbl[seq_len(nrow(tbl))[-seq_len(pos)], names(new)])
  }
  tbl
}

build_sdtmig_domain <- function(version, domain, file) {
  path <- file.path("data-raw/ig_source",
                    paste0("sdtmig_", sdtmig_sources[[version]]), file)
  tbl  <- read_ig_csv(path)
  if (domain == "PP") {
    tbl <- insert_pp_additions(tbl, read_pp_additions())
  }
  data.frame(
    source   = "SDTMIG",
    version  = version,
    class    = NA_character_,
    domain   = domain,
    order    = seq_len(nrow(tbl)),
    variable = tbl$variable,
    label    = tbl$label,
    type     = tbl$type,
    role     = tbl$role,
    core     = tbl$core,
    codelist = parse_codelist_token(tbl$codelist),
    length   = parse_documented_length(tbl$notes),
    notes    = tbl$notes,
    stringsAsFactors = FALSE
  )
}

sdtmig_rows <- do.call(rbind, c(
  lapply(sdtmig_versions, build_sdtmig_domain,
         domain = "PP", file = "PP-specification.csv"),
  lapply(sdtmig_versions, build_sdtmig_domain,
         domain = "SUPPQUAL", file = "Supplemental_Qualifiers-specification.csv")
))

# ── SDTMIG 3.4: every domain, from the CDISC Library export ─────────────────
# SDTMIG_v3.4.csv (CDISC Library CSV: Version, Variable Order, Class, Dataset
# Name, Variable Name, Variable Label, Type, CDISC CT Codelist Code(s),
# Codelist Submission Values, Described Value Domain(s), Value List, Role,
# CDISC Notes, Core). Read from outside the repository (see
# cdisc_sources_file()); only names, labels, types, codelists, roles, Core, and
# order are transcribed. The CDISC Notes column is NOT carried into the package
# data (`notes` is NA for these rows); it is read only to recover the maximum
# length a note states, as an integer, the same way as for 3.2/3.3.
#
# The export gives codelists as CDISC CT C-codes only ("Codelist Submission
# Values" is empty throughout). `ig_sdtm$codelist` holds the submission value
# (e.g. "PKPARMCD"), so each first code is mapped to its name from the stored CT.
# A code may be retired from the current CT (4 of the 135 distinct first codes
# are), so the name comes from the most recent CT header row that carries it,
# not only a current one; a code with no header anywhere stops the build.
build_sdtmig_34 <- function() {
  x <- utils::read.csv(cdisc_sources_file("SDTMIG_v3.4.csv"), check.names = FALSE,
                       stringsAsFactors = FALSE, na.strings = "",
                       fileEncoding = "UTF-8")
  need <- c("Version", "Variable Order", "Class", "Dataset Name", "Variable Name",
            "Variable Label", "Type", "CDISC CT Codelist Code(s)", "Role",
            "CDISC Notes", "Core")
  if (!all(need %in% names(x))) {
    stop("SDTMIG_v3.4.csv is missing column(s): ",
         paste(setdiff(need, names(x)), collapse = ", "), call. = FALSE)
  }
  stopifnot(all(x$Version == "SDTMIG v3.4"))

  e <- new.env(parent = emptyenv())
  load("data/ct_sdtm.rda", envir = e)
  hdr <- e$ct_sdtm[is.na(e$ct_sdtm$term_code) & !is.na(e$ct_sdtm$codelist_code) &
                     !is.na(e$ct_sdtm$codelist_name), ]
  hdr <- hdr[order(hdr$codelist_code, hdr$valid_from, decreasing = TRUE), ]
  hdr <- hdr[!duplicated(hdr$codelist_code), c("codelist_code", "codelist_name")]

  first_code <- trimws(sub(";.*$", "", x[["CDISC CT Codelist Code(s)"]]))
  codelist   <- hdr$codelist_name[match(first_code, hdr$codelist_code)]
  unmapped   <- unique(first_code[!is.na(first_code) & is.na(codelist)])
  if (length(unmapped)) {
    stop("SDTMIG 3.4 codelist code(s) with no header row in the stored CT: ",
         paste(unmapped, collapse = ", "), call. = FALSE)
  }

  data.frame(
    source   = "SDTMIG",
    version  = "3.4",
    class    = tidy_text(x$Class),
    domain   = tidy_text(x[["Dataset Name"]]),
    order    = as.integer(x[["Variable Order"]]),
    variable = tidy_text(x[["Variable Name"]]),
    label    = tidy_text(x[["Variable Label"]]),
    type     = tidy_text(x$Type),
    role     = tidy_text(x$Role),
    core     = tidy_text(x$Core),
    codelist = codelist,
    length   = parse_documented_length(x[["CDISC Notes"]]),
    notes    = NA_character_,
    stringsAsFactors = FALSE
  )
}

sdtmig_34_rows <- build_sdtmig_34()
stopifnot(
  !anyDuplicated(paste(sdtmig_34_rows$domain, sdtmig_34_rows$variable)),
  all(c("PP", "SUPPQUAL") %in% sdtmig_34_rows$domain)
)

ig_sdtm <- rbind(model_rows, sdtmig_rows, sdtmig_34_rows)
rownames(ig_sdtm) <- NULL

# ── Labels over the 40-character XPT limit ─────────────────────────────────
# Checked against the published SDTMIG v3.3 (CDISC wiki PDF
# https://wiki.cdisc.org/download/attachments/66274516/sdtmig_v3.3.pdf):
# - section 4.2.1: "Variable descriptive names (labels), up to 40
#   characters, should be provided as data variable labels for all
#   variables, including Supplemental Qualifier variables."
# - section 6.3.11.2 (Pharmacokinetics Parameters), PP specification table:
#   PPSTRESC is labelled "Character Result/Finding in Std Format".
# - section 6.3.10.1 (Generic Morphology/Physiology Specification), generic
#   table: --TESTCD is labelled "Short Name of Measurement, Test or Exam".
#   Model 1.7 as transcribed already uses a 40-character form of this
#   (with an Oxford comma); Model 1.4-1.6 transcribe the long form
#   "Short Name of Measurement, Test or Examination" (46 characters).
sdtm_label_overrides <- data.frame(
  source   = c("SDTM_MODEL", "SDTM_MODEL", "SDTM_MODEL", "SDTMIG", "SDTMIG"),
  version  = c("1.4", "1.5", "1.6", "3.2", "3.3"),
  variable = c("--TESTCD", "--TESTCD", "--TESTCD", "PPSTRESC", "PPSTRESC"),
  label    = c(rep("Short Name of Measurement, Test or Exam", 3),
               rep("Character Result/Finding in Std Format", 2)),
  evidence = c(rep("SDTMIG v3.3 6.3.10.1 generic table; 4.2.1 label limit", 3),
               rep("SDTMIG v3.3 6.3.11.2 PP specification table", 2)),
  stringsAsFactors = FALSE
)
ig_sdtm <- apply_label_overrides(ig_sdtm, sdtm_label_overrides,
                                 by = c("source", "version", "variable"))

stopifnot(
  all(c("source", "version", "class", "domain", "order", "variable", "label",
        "type", "role", "core", "codelist", "length", "notes") %in% names(ig_sdtm)),
  !anyNA(ig_sdtm$variable), !anyNA(ig_sdtm$version), !anyNA(ig_sdtm$label)
)

usethis::use_data(ig_sdtm, overwrite = TRUE, compress = "xz")
message(sprintf(
  "ig_sdtm saved: %d rows (%d SDTM_MODEL, %d SDTMIG).",
  nrow(ig_sdtm), sum(ig_sdtm$source == "SDTM_MODEL"), sum(ig_sdtm$source == "SDTMIG")
))
