# The standards the IG/model datasets cover, how each is written in the
# "Version" column of a CDISC Library CSV export, and which dataset holds it.
#
# The export writes the standard with spaces ("ADaMIG MD v1.0", "ADaM BDS for
# TTE v1.0"), not the hyphenated names CDISC uses elsewhere; this table is the
# one place those are mapped to the canonical name stored in `standard`.
.ig_standards <- data.frame(
  raw = c(
    "SDTM",
    "SDTMIG", "SDTMIG-AP", "SDTMIG-MD",
    "SENDIG", "SENDIG-AR", "SENDIG-DART", "SENDIG-GeneTox",
    "ADaMIG", "ADaMIG MD", "ADaMIG NCA", "ADaM ADAE", "ADaM BDS for TTE",
    "ADaM OCCDS", "ADaM popPK"
  ),
  standard = c(
    "SDTM",
    "SDTMIG", "SDTMIG-AP", "SDTMIG-MD",
    "SENDIG", "SENDIG-AR", "SENDIG-DART", "SENDIG-GeneTox",
    "ADaMIG", "ADaMIG-MD", "ADaMIG-NCA", "ADaM-ADAE", "ADaM-BDS-TTE",
    "ADaM-OCCDS", "ADaM-popPK"
  ),
  table = c(
    "model_sdtm",
    rep("ig_sdtm", 7L),
    rep("ig_adam", 7L)
  ),
  stringsAsFactors = FALSE
)

# The CDASH standards, which the CDISC Library exports in the same layout but
# which are collection-side, not SDTM or ADaM guides, so get_ig() does not
# reach them (get_cdash() does).
.cdash_standards <- data.frame(
  raw      = c("CDASH Model", "CDASHIG"),
  standard = c("CDASH", "CDASHIG"),
  table    = c("cdash_model", "ig_cdash"),
  stringsAsFactors = FALSE
)

# Every standard whose export carries a "Version" column; the parser's
# vocabulary.
.library_standards <- rbind(.ig_standards, .cdash_standards)

# Split "Version" strings such as "SDTMIG-MD v1.1" or "ADaM BDS for TTE v1.0"
# into the canonical standard and the version number. Vectorised; an
# unrecognised string is an error, never a guess.
.parse_ig_version <- function(x) {
  parts <- regmatches(x, regexec("^(.+) v([0-9]+([.][0-9]+)*)$", x))
  raw <- vapply(parts, function(p) if (length(p)) p[[2L]] else NA_character_, "")
  version <- vapply(parts, function(p) if (length(p)) p[[3L]] else NA_character_, "")
  standard <- .library_standards$standard[match(raw, .library_standards$raw)]

  bad <- is.na(x) | is.na(standard)
  if (any(bad)) {
    .cdiscdata_abort(
      paste0(
        "Cannot parse IG version string(s): ",
        paste0("'", x[bad], "'", collapse = ", "),
        ". Expected '<standard> v<version>' with a standard in: ",
        paste(.library_standards$raw, collapse = ", "), "."
      ),
      "ig_version_unparsable"
    )
  }
  data.frame(standard = standard, version = version, stringsAsFactors = FALSE)
}

# Resolve version = NULL to the newest version present in `versions`
# (numeric comparison via package_version, so "1.10" ranks above "1.9" and
# "3.1.3" below "3.2"); abort with the available list, in numeric order, on an
# unknown explicit version.
.resolve_ig_version <- function(version, versions, label) {
  avail <- unique(versions)
  avail <- avail[order(package_version(avail))]
  if (is.null(version)) {
    return(avail[[length(avail)]])
  }
  if (!version %in% avail) {
    .cdiscdata_abort(
      paste0(
        "Version '", version, "' is not available for ", label, ". ",
        "Available versions: ", paste(avail, collapse = ", "), "."
      ),
      "ig_version_unavailable"
    )
  }
  version
}

# The QRS supplement exports carry no "Version" column: the instrument and its
# version are in the file name ("HAM-A_Supplement_v2.1.csv" is instrument
# "HAM-A", version "2.1"; "SIX_MINUTE_WALK_Supplement_v1.0.csv" keeps its
# underscores). Vectorised; a name that does not fit is an error.
.parse_qrs_filename <- function(x) {
  file <- basename(x)
  parts <- regmatches(file, regexec("^(.+)_Supplement_v([0-9]+([.][0-9]+)*)[.]csv$", file))
  ok <- lengths(parts) > 0L
  if (!all(ok)) {
    .cdiscdata_abort(
      paste0(
        "Cannot parse QRS supplement file name(s): ",
        paste0("'", file[!ok], "'", collapse = ", "),
        ". Expected '<instrument>_Supplement_v<version>.csv'."
      ),
      "qrs_filename_unparsable"
    )
  }
  data.frame(
    instrument = vapply(parts, `[[`, "", 2L),
    version    = vapply(parts, `[[`, "", 3L),
    stringsAsFactors = FALSE
  )
}
