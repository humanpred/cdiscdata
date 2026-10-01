# Helpers for building the IG and model datasets (ig_sdtm, model_sdtm, ig_adam,
# ig_sources) from CDISC Library CSV exports. Sourced by build_ig.R.
#
# The exports are downloaded under CDISC's own terms and conditions (use within
# the downloader's organization only; no copying, distribution, or derivative
# works of the material itself). They are therefore never committed here: they
# are read from CDISC_SOURCES_DIR (default "../cdisc-sources", relative to the
# checkout), and only variable metadata is transcribed into data/. See
# data-raw/README.md for how to obtain them.

# The 34 exports this build reads, one standard version per file.
ig_source_files <- c(
  "SDTM_v1.2.csv", "SDTM_v1.3.csv", "SDTM_v1.4.csv", "SDTM_v1.5.csv",
  "SDTM_v1.6.csv", "SDTM_v1.7.csv", "SDTM_v1.8.csv", "SDTM_v2.0.csv",
  "SDTM_v2.1.csv",
  "SDTMIG_v3.1.2.csv", "SDTMIG_v3.1.3.csv", "SDTMIG_v3.2.csv",
  "SDTMIG_v3.3.csv", "SDTMIG_v3.4.csv", "SDTMIG-AP_v1.0.csv",
  "SDTMIG-MD_v1.0.csv", "SDTMIG-MD_v1.1.csv",
  "SENDIG_v3.0.csv", "SENDIG_v3.1.csv", "SENDIG_v3.1.1.csv",
  "SENDIG-AR_v1.0.csv", "SENDIG-DART_v1.1.csv", "SENDIG-GeneTox_v1.0.csv",
  "ADaMIG_v1.0.csv", "ADaMIG_v1.1.csv", "ADaMIG_v1.2.csv", "ADaMIG_v1.3.csv",
  "ADaMIG_MD_v1.0.csv", "ADaMIG_NCA_v1.0.csv", "ADaM_ADAE_v1.0.csv",
  "ADaM_BDS_for_TTE_v1.0.csv", "ADaM_OCCDS_v1.0.csv", "ADaM_OCCDS_v1.1.csv",
  "ADaM_popPK_v1.0.csv"
)

# The four column layouts the exports come in, and the dataset each feeds.
ig_source_shapes <- list(
  ig_sdtm = c(
    "Version", "Variable Order", "Class", "Dataset Name", "Variable Name",
    "Variable Label", "Type", "CDISC CT Codelist Code(s)",
    "Codelist Submission Values", "Described Value Domain(s)", "Value List",
    "Role", "CDISC Notes", "Core"
  ),
  model_v1 = c(
    "Version", "Variable Order", "Class", "Dataset Name", "Variable Name",
    "Variable Label", "Type", "Described Value Domain", "Role",
    "Variables Qualified", "Description"
  ),
  model_v2 = c(
    "Version", "Variable Order", "Class", "Dataset Name", "Variable Name",
    "Variable Label", "Type", "Described Value Domain", "Role",
    "Variables Qualified", "Usage Restrictions", "Variable C-Code",
    "Definition", "Notes", "Examples"
  ),
  ig_adam = c(
    "Version", "Data Structure Name", "Variable Set", "Variable Name",
    "Variable Label", "Type", "CDISC CT Codelist Code(s)",
    "CDISC CT Codelist Submission Value(s)", "Described Value Domain(s)",
    "Value List Value", "Core", "CDISC Notes"
  )
)

# Collapse every run of whitespace (hard line breaks and non-breaking spaces
# from a wrapped table cell included) to one space, trim the ends, and turn
# the empty result into NA. Applied to every field that is carried into the
# data; the guide prose columns (CDISC Notes, Description, Definition, Notes,
# Examples) are never read into it.
tidy_text <- function(x) {
  x <- trimws(gsub("[[:space:] ]+", " ", x, perl = TRUE))
  x[!is.na(x) & !nzchar(x)] <- NA_character_
  x
}

# Absolute path of the CDISC sources directory (not part of this repository).
cdisc_sources_dir <- function() {
  Sys.getenv("CDISC_SOURCES_DIR", "../cdisc-sources")
}

# Paths of all expected export files; stops with a message that lists every
# one that is missing, so a partial download is obvious.
cdisc_source_paths <- function(files = ig_source_files) {
  dir <- cdisc_sources_dir()
  paths <- file.path(dir, files)
  missing <- files[!file.exists(paths)]
  if (length(missing)) {
    stop(
      length(missing), " of the ", length(files), " expected CDISC Library ",
      "export file(s) are missing from ",
      normalizePath(dir, winslash = "/", mustWork = FALSE), ":\n  ",
      paste(missing, collapse = "\n  "), "\n",
      "They are not part of this repository; obtain them under your own CDISC ",
      "terms (see data-raw/README.md) and put them there, or set the ",
      "CDISC_SOURCES_DIR environment variable to the directory that holds them.",
      call. = FALSE
    )
  }
  stats::setNames(paths, files)
}

# Read one export and say which of the four shapes it is.
read_library_export <- function(path) {
  x <- utils::read.csv(path, check.names = FALSE, stringsAsFactors = FALSE,
                       na.strings = "", fileEncoding = "UTF-8")
  shape <- names(ig_source_shapes)[vapply(
    ig_source_shapes, function(cols) identical(sort(cols), sort(names(x))), logical(1L)
  )]
  if (length(shape) != 1L) {
    stop(basename(path), " has columns that match none of the four known export ",
         "shapes: ", paste(names(x), collapse = " | "), call. = FALSE)
  }
  versions <- unique(x$Version)
  if (length(versions) != 1L) {
    stop(basename(path), " must carry exactly one Version value, found ",
         length(versions), ": ", paste(versions, collapse = "; "), call. = FALSE)
  }
  list(data = x, shape = shape, version_string = versions)
}

# ---- one converter per shape: only metadata fields are read ----------------

ig_sdtm_rows <- function(x, parsed) {
  data.frame(
    standard   = parsed$standard,
    version    = parsed$version,
    class      = tidy_text(x$Class),
    domain     = tidy_text(x[["Dataset Name"]]),
    order      = as.integer(x[["Variable Order"]]),
    variable   = tidy_text(x[["Variable Name"]]),
    label      = tidy_text(x[["Variable Label"]]),
    type       = tidy_text(x$Type),
    role       = tidy_text(x$Role),
    core       = tidy_text(x$Core),
    codelist_code              = tidy_text(x[["CDISC CT Codelist Code(s)"]]),
    codelist_submission_values = tidy_text(x[["Codelist Submission Values"]]),
    described_value_domain     = tidy_text(x[["Described Value Domain(s)"]]),
    value_list                 = tidy_text(x[["Value List"]]),
    stringsAsFactors = FALSE
  )
}

model_sdtm_rows <- function(x, parsed) {
  chr_or_na <- function(col) {
    if (col %in% names(x)) tidy_text(x[[col]]) else rep(NA_character_, nrow(x))
  }
  data.frame(
    standard   = parsed$standard,
    version    = parsed$version,
    class      = tidy_text(x$Class),
    dataset    = tidy_text(x[["Dataset Name"]]),
    order      = as.integer(x[["Variable Order"]]),
    variable   = tidy_text(x[["Variable Name"]]),
    label      = tidy_text(x[["Variable Label"]]),
    type       = tidy_text(x$Type),
    role       = tidy_text(x$Role),
    described_value_domain = tidy_text(x[["Described Value Domain"]]),
    variables_qualified    = tidy_text(x[["Variables Qualified"]]),
    usage_restrictions     = chr_or_na("Usage Restrictions"),
    variable_code          = chr_or_na("Variable C-Code"),
    stringsAsFactors = FALSE
  )
}

ig_adam_rows <- function(x, parsed) {
  data.frame(
    standard     = parsed$standard,
    version      = parsed$version,
    structure    = tidy_text(x[["Data Structure Name"]]),
    variable_set = tidy_text(x[["Variable Set"]]),
    order        = seq_len(nrow(x)),
    variable     = tidy_text(x[["Variable Name"]]),
    label        = tidy_text(x[["Variable Label"]]),
    type         = tidy_text(x$Type),
    core         = tidy_text(x$Core),
    codelist_code              = tidy_text(x[["CDISC CT Codelist Code(s)"]]),
    codelist_submission_values = tidy_text(x[["CDISC CT Codelist Submission Value(s)"]]),
    described_value_domain     = tidy_text(x[["Described Value Domain(s)"]]),
    value_list                 = tidy_text(x[["Value List Value"]]),
    stringsAsFactors = FALSE
  )
}
