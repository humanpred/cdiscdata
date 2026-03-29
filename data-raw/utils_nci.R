# NCI EVS FTP parsing helpers
# Sourced by fetch_ct_sdtm.R, fetch_ct_adam.R, and fetch_all.R

NCI_BASE     <- "https://evs.nci.nih.gov/ftp1/CDISC"
SDTM_CURRENT <- paste0(NCI_BASE, "/SDTM/SDTM%20Terminology.txt")
SDTM_ARCHIVE <- paste0(NCI_BASE, "/SDTM/Archive/")
ADAM_CURRENT <- paste0(NCI_BASE, "/ADaM/ADaM%20Terminology.txt")
ADAM_ARCHIVE <- paste0(NCI_BASE, "/ADaM/Archive/")

# Raw-file cache directory (relative to package root)
NCI_RAW_DIR <- "data-raw/raw"

# Return the canonical local cache path for a CT release (RDS of parsed data frame).
# Files are stored as data-raw/raw/{type}/{TYPE}_Terminology_{YYYY-MM-DD}.rds
raw_ct_path <- function(type, date) {
  type     <- match.arg(type, c("sdtm", "adam"))
  date_str <- format(as.Date(date), "%Y-%m-%d")
  label    <- switch(type, sdtm = "SDTM", adam = "ADaM")
  file.path(NCI_RAW_DIR, type,
            sprintf("%s_Terminology_%s.rds", label, date_str))
}

# Return the parsed CT data frame for a release, using the local RDS cache.
# If the RDS does not exist, downloads the NCI text file to a tempfile,
# parses it, saves the result as an RDS, and returns the data frame.
fetch_raw_ct_tbl <- function(url, type, date) {
  dest <- raw_ct_path(type, date)
  if (file.exists(dest)) {
    message(sprintf("    Using cached RDS: %s", dest))
    return(readRDS(dest))
  }
  dir.create(dirname(dest), recursive = TRUE, showWarnings = FALSE)
  tmp <- tempfile(fileext = ".txt")
  on.exit(unlink(tmp))
  message(sprintf("    Downloading -> %s", dest))
  download.file(url, tmp, quiet = TRUE, mode = "wb")
  tbl <- parse_nci_ct_txt(tmp, date)
  saveRDS(tbl, dest, compress = "xz")
  tbl
}

# Parse a local NCI CT text file into a data frame.
# The tab-delimited format has 7-8 columns depending on vintage:
# Code | Codelist Code | Codelist Extensible | Codelist Name |
# CDISC Submission Value | CDISC Synonym(s) | CDISC Definition |
# NCI Preferred Term (col 8, present in files from ~2012+)
parse_nci_ct_txt <- function(local_path, release_date) {
  raw <- readLines(local_path, encoding = "UTF-8", warn = FALSE)
  data_lines <- raw[-1L]  # skip header

  parsed <- strsplit(data_lines, "\t", fixed = TRUE)
  n_cols <- max(lengths(parsed))

  mat <- do.call(rbind, lapply(parsed, function(x) {
    length(x) <- n_cols
    x
  }))

  df <- as.data.frame(mat, stringsAsFactors = FALSE)
  # Standardise to 8 columns
  if (ncol(df) < 8L) df[, 8L] <- NA_character_

  names(df) <- c(
    "raw_code", "raw_clst_code", "raw_extensible",
    "raw_clst_label", "raw_submission_value",
    "raw_synonyms", "raw_definition", "raw_nci_term"
  )

  # Identify codelist-level rows (Code == Codelist Code)
  is_list_row <- df$raw_code == df$raw_clst_code

  extensible <- rep(NA, nrow(df))
  extensible[df$raw_extensible == "Yes"] <- TRUE
  extensible[df$raw_extensible == "No"]  <- FALSE

  result <- data.frame(
    codelist_code  = df$raw_clst_code,
    codelist_name  = ifelse(is_list_row, df$raw_submission_value, NA_character_),
    codelist_label = df$raw_clst_label,
    extensible     = extensible,
    term_code      = ifelse(is_list_row, NA_character_, df$raw_code),
    term           = ifelse(is_list_row, NA_character_, df$raw_submission_value),
    decoded_value  = df$raw_nci_term,
    synonyms       = df$raw_synonyms,
    definition     = df$raw_definition,
    valid_from     = as.Date(release_date),
    valid_to       = as.Date(NA_character_),
    stringsAsFactors = FALSE
  )

  # Forward-fill codelist_name to term rows (base R)
  cl_name <- result$codelist_name
  for (i in seq_along(cl_name)) {
    if (i > 1L && is.na(cl_name[i])) cl_name[i] <- cl_name[i - 1L]
  }
  result$codelist_name <- cl_name

  result
}

# Extract the release date from the NCI Publication Date Stamp text file
fetch_current_release_date <- function(type = c("sdtm", "adam")) {
  type <- match.arg(type)
  stamp_url <- switch(type,
    sdtm = paste0(NCI_BASE, "/SDTM/SDTM%20Publication%20Date%20Stamp.txt"),
    adam = paste0(NCI_BASE, "/ADaM/ADaM%20Publication%20Date%20Stamp.txt")
  )
  tmp <- tempfile()
  on.exit(unlink(tmp))
  download.file(stamp_url, tmp, quiet = TRUE)
  stamp <- readLines(tmp, warn = FALSE)[[1L]]
  # Format is typically "SDTM Terminology YYYY-MM-DD" or just "YYYY-MM-DD"
  as.Date(regmatches(stamp, regexpr("\\d{4}-\\d{2}-\\d{2}", stamp)))
}

# List all archived version dates for a CT type by parsing the Apache
# directory listing HTML
list_archive_dates <- function(type = c("sdtm", "adam")) {
  type <- match.arg(type)
  archive_url <- switch(type, sdtm = SDTM_ARCHIVE, adam = ADAM_ARCHIVE)
  html <- tryCatch(
    readLines(archive_url, warn = FALSE),
    error = function(e) character(0)
  )
  dates <- regmatches(html, gregexpr("\\d{4}-\\d{2}-\\d{2}", html))
  dates <- unique(unlist(dates))
  sort(as.Date(dates))
}

# Build URL for an archived CT file
archive_url <- function(type, date) {
  date_str <- format(as.Date(date), "%Y-%m-%d")
  switch(type,
    sdtm = sprintf(
      "%s/SDTM/Archive/SDTM%%20Terminology%%20%s.txt",
      NCI_BASE, date_str
    ),
    adam = sprintf(
      "%s/ADaM/Archive/ADaM%%20Terminology%%20%s.txt",
      NCI_BASE, date_str
    )
  )
}
