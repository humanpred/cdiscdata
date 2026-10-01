# Helpers for building versioned SDTM/ADaM implementation-guide (IG) variable
# metadata from the CSV transcriptions under data-raw/ig_source/.
# Sourced by build_ig_sdtm.R and build_ig_adam.R.
#
# Those source CSVs are column-inconsistent in minor ways across files and
# CDISC versions (a stray blank header cell here, "Codelist/ Controlled
# Terms" vs "Codelist / Controlled Terms" there, "Variable" vs
# "Variable Name"), evidently from how each was originally transcribed from
# a CDISC PDF/Word table. read_ig_csv() normalises all of that by matching
# column *names* (not position) against the canonical fields every one of
# these tables can carry, rather than assuming a fixed column order.

# Read one IG source CSV and return it with canonical column names:
# variable, label, type, core, codelist, role, notes. Any canonical column
# absent from this particular file (e.g. "role" in an ADaM spec) is filled
# with NA. Blank/duplicate header cells (transcription artifacts) are
# dropped before matching.
read_ig_csv <- function(path) {
  # These CSVs are transcriptions of CDISC Word/PDF tables and are encoded
  # as Windows-1252 (smart quotes, non-breaking spaces), not UTF-8; reading
  # as UTF-8 silently mangles those characters into mojibake instead of
  # erroring, so the encoding must be stated explicitly.
  raw <- utils::read.csv(path, check.names = FALSE, stringsAsFactors = FALSE,
                          na.strings = "", fileEncoding = "windows-1252")
  # Collapse embedded newlines/extra whitespace in header cells so matching
  # is robust to how the CSV happened to wrap a multi-word header.
  nm <- gsub("\\s+", " ", trimws(names(raw)))
  nm[is.na(nm) | !nzchar(nm)] <- NA_character_
  names(raw) <- nm
  raw <- raw[, !is.na(names(raw)) & !duplicated(names(raw)), drop = FALSE]

  pick <- function(pattern, exclude = NULL) {
    hit <- grepl(pattern, names(raw), ignore.case = TRUE)
    if (!is.null(exclude)) hit <- hit & !grepl(exclude, names(raw), ignore.case = TRUE)
    if (!any(hit)) return(rep(NA_character_, nrow(raw)))
    as.character(raw[[which(hit)[1L]]])
  }

  data.frame(
    variable = tidy_text(pick("^Variable( Name)?$", exclude = "Label")),
    label    = tidy_text(pick("Variable Label")),
    type     = tidy_text(pick("^Type$")),
    core     = tidy_text(pick("^Core$")),
    codelist = tidy_text(pick("Codelist|Controlled Terms")),
    role     = tidy_text(pick("^Role$")),
    notes    = pick("CDISC Notes|^Description$"),
    stringsAsFactors = FALSE
  )
}

# Collapse every run of whitespace (including the hard line breaks and
# non-breaking spaces left by transcribing a wrapped Word/PDF table cell)
# to a single space and trim the ends. Without this, a table cell that wrapped
# across lines in the source document keeps a literal newline in the value, and
# a cell with a trailing space in the source becomes e.g. the variable name
# "--TESTCD " that never equals "--TESTCD". Applied to every identifying or
# categorical field; not to `notes`, which is free text meant to keep its
# paragraph breaks.
tidy_text <- function(x) {
  trimws(gsub("[[:space:] ]+", " ", x, perl = TRUE))
}

# Apply documented label overrides to a built IG table.
#
# A handful of labels as published in a CDISC IG exceed the 40-character
# limit for a SAS v5 transport (XPT) variable label, which the same IGs state
# for every variable they define (SDTMIG 3.3 section 4.2.1, "Variable
# descriptive names (labels), up to 40 characters"). The IGs deal with this
# by abbreviating in the domain tables themselves while leaving the generic
# model table or a sibling row at its long form, so the long form is what
# transcribes. `overrides` carries, for each such row, the published
# abbreviation to use instead (or, where the IG publishes none, a sibling-
# consistent one) and `evidence` naming the table checked; this stops, rather
# than silently skipping, if an override does not match exactly the rows it is
# written for.
apply_label_overrides <- function(tbl, overrides, by) {
  stopifnot(all(c(by, "label", "evidence") %in% names(overrides)))
  for (i in seq_len(nrow(overrides))) {
    hit <- rep(TRUE, nrow(tbl))
    for (col in by) hit <- hit & !is.na(tbl[[col]]) & tbl[[col]] == overrides[[col]][i]
    if (!any(hit)) {
      stop("Label override matched no rows: ",
           paste(by, unlist(overrides[i, by]), sep = "=", collapse = ", "))
    }
    tbl$label[hit] <- overrides$label[i]
  }
  tbl
}

# Extract a codelist submission value (e.g. "PKPARMCD") from the free-text
# "Codelist/Controlled Terms" column, e.g. "(PKPARMCD)" -> "PKPARMCD". CDISC
# also uses this column for a non-codelist marker ("*" = extensible list not
# further specified in the IG) or a format note ("ISO 8601"); neither names
# an actual codelist, so both return NA.
parse_codelist_token <- function(x) {
  text  <- ifelse(is.na(x), "", x)
  pos   <- regexpr("\\(([A-Za-z0-9_]+)\\)", text)
  hit   <- pos > 0L
  token <- rep(NA_character_, length(x))
  # regmatches(text, pos) returns matches only for the TRUE positions of
  # `hit`, in order, so it lines up with token[hit] element-for-element.
  matched <- regmatches(text, pos)
  token[hit] <- sub("^\\((.*)\\)$", "\\1", matched)
  # A handful of IG tables reference a codelist by bare name (no
  # parentheses), e.g. SUPP--'s RDOMAIN -> "DOMAIN".
  bare_ok <- is.na(token) & grepl("^[A-Z][A-Z0-9_]*$", text)
  token[bare_ok] <- text[bare_ok]
  token
}

# Recover a documented maximum character length from CDISC Notes text, e.g.
# "cannot be longer than 8 characters" -> 8L. CDISC implementation guides do
# not publish a Length column at all (length is a sponsor/define.xml
# choice); this recovers the few lengths the IG text states explicitly as a
# hard rule, rather than guessing one for every variable.
parse_documented_length <- function(notes) {
  text <- ifelse(is.na(notes), "", notes)
  pos  <- regexpr("longer than (\\d+) character", text, ignore.case = TRUE)
  hit  <- pos > 0L
  len  <- rep(NA_integer_, length(notes))
  # regmatches(text, pos) returns matches only for the TRUE positions of
  # `hit`, in order, so it lines up with len[hit] element-for-element.
  matched <- regmatches(text, pos)
  len[hit] <- suppressWarnings(as.integer(sub("\\D*(\\d+).*", "\\1", matched)))
  len
}

# Path to a CDISC source file that is NOT part of this repository.
#
# The SDTMIG 3.4 export is a CDISC Library download made under CDISC's own
# terms and conditions (use within the downloader's organization only; no
# copying, distribution, or derivative works of the material itself). The
# file is therefore never committed here: it is read from CDISC_SOURCES_DIR
# (default "../cdisc-sources", relative to the checkout), and only variable
# metadata is transcribed from it into data/. Anyone reproducing the build
# obtains the export under their own CDISC terms and places it there.
cdisc_sources_file <- function(file) {
  dir  <- Sys.getenv("CDISC_SOURCES_DIR", "../cdisc-sources")
  path <- file.path(dir, file)
  if (!file.exists(path)) {
    stop(
      "Cannot find the CDISC source file '", file, "'.\n",
      "Expected it at: ", normalizePath(path, winslash = "/", mustWork = FALSE), "\n",
      "It is a CDISC Library export that is not part of this repository; obtain it ",
      "under your own CDISC terms and put it there, or set the CDISC_SOURCES_DIR ",
      "environment variable to the directory that holds it.",
      call. = FALSE
    )
  }
  path
}
