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

# Return the local cache path for a release's raw (unparsed) NCI text file.
# Used only transiently during a re-parse (see rebuild_ct.R style scripts);
# ordinary fetches use a tempfile instead (below), since the parsed,
# XZ-compressed RDS cache is ~10x more compact and serves the same
# avoid-re-download purpose for everyday use. A full re-download (as was
# done when the 2012-on codelist_name bug below was fixed) is an acceptable,
# infrequent cost for the rare case of a future parser fix.
raw_ct_text_path <- function(type, date) {
  sub("\\.rds$", ".txt", raw_ct_path(type, date))
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

  # Identify codelist-level (header) rows. Two NCI file conventions are seen
  # across vintages: files from ~2012 onward leave "Codelist Code" blank on
  # a codelist's own header row (its Code is the codelist's C-code, with
  # nothing "above" it to reference); files through ~2011 instead repeat the
  # codelist's C-code in both Code and Codelist Code. Testing for either
  # covers the whole archive. (A header-row Codelist Code that is blank, not
  # self-referential, was previously undetected here, which silently left
  # codelist_name NA for every row of every release from 2012 on.)
  # A handful of old SDTM archive releases (scattered across 2007-2010, plus
  # one in 2017) use further, rarer header-row conventions this cannot
  # detect - e.g. the 2008-08-26 file's header rows carry a stray,
  # non-blank Codelist Code (so is_list_row is FALSE for them, leaving
  # codelist_name NA on their term rows); a few individual lines elsewhere
  # are outright malformed at the source (e.g. an embedded newline or a
  # missing tab), producing garbage - full sentences, not C-codes - in
  # codelist_code. No further rule here recovers those without risking a
  # false match on genuine data elsewhere. test-data_integrity.R asserts the
  # *current* release is unaffected and bounds the historical total, rather
  # than enumerating every affected release precisely. None are PK-related.
  is_list_row <- df$raw_clst_code == "" | is.na(df$raw_clst_code) |
    df$raw_code == df$raw_clst_code

  extensible <- rep(NA, nrow(df))
  extensible[df$raw_extensible == "Yes"] <- TRUE
  extensible[df$raw_extensible == "No"]  <- FALSE

  result <- data.frame(
    # A header row's own Codelist Code field is blank (or self-referential);
    # its own C-code is always in Code.
    codelist_code  = ifelse(is_list_row, df$raw_code, df$raw_clst_code),
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

# Extract the release date from the NCI Publication Date Stamp text file.
# The format has changed over time (plain "YYYY-MM-DD" on line 1; later a
# "SDTM Terminology YYYY-MM-DD" line; as of 2026 a tab-separated
# Quarter/Release Date/Modified date/Reason table with the date on a row
# other than the first). Rather than assume the date's position, every line
# is scanned for a date pattern and the newest one found is returned, which
# is robust to all of the above and to any future reordering of the table.
fetch_current_release_date <- function(type = c("sdtm", "adam")) {
  type <- match.arg(type)
  stamp_url <- switch(type,
    sdtm = paste0(NCI_BASE, "/SDTM/SDTM%20Publication%20Date%20Stamp.txt"),
    adam = paste0(NCI_BASE, "/ADaM/ADaM%20Publication%20Date%20Stamp.txt")
  )
  tmp <- tempfile()
  on.exit(unlink(tmp))
  download.file(stamp_url, tmp, quiet = TRUE)
  stamp <- readLines(tmp, warn = FALSE)
  dates <- unlist(regmatches(stamp, gregexpr("\\d{4}-\\d{2}-\\d{2}", stamp)))
  if (length(dates) == 0L) {
    stop(paste0(
      "Could not find a release date (YYYY-MM-DD) anywhere in the NCI ",
      "publication date stamp file at ", stamp_url, "."
    ))
  }
  max(as.Date(dates))
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
