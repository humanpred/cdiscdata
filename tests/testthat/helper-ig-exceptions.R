# Reviewed, explicit exceptions to the IG data gates (test-ig_integrity.R).
#
# Every row here is a defect the CDISC guides themselves publish, kept as
# published: shortening a label to fit an XPT file, or filling in a missing
# type or Core, is the job of whoever writes a dataset, not of this package.
# The gates compare against these lists in both directions, so a new
# over-length label fails, and so does an entry that is no longer true.

# Labels over 40 characters (the SAS v5 transport limit the guides themselves
# state, SDTMIG 3.3 section 4.2.1). 22 rows across four standards.
ig_label_exceptions <- local({
  rows <- list(
    # SDTMIG 3.2 (the long forms were abbreviated in 3.3)
    c("ig_sdtm", "SDTMIG", "3.2", "HO", "HOTERM"),
    c("ig_sdtm", "SDTMIG", "3.2", "HO", "HODECOD"),
    c("ig_sdtm", "SDTMIG", "3.2", "HO", "HOSTDY"),
    c("ig_sdtm", "SDTMIG", "3.2", "MH", "MHREASND"),
    c("ig_sdtm", "SDTMIG", "3.2", "IS", "ISSTRESC"),
    c("ig_sdtm", "SDTMIG", "3.2", "MI", "MISTRESC"),
    c("ig_sdtm", "SDTMIG", "3.2", "PC", "PCSTRESC"),
    c("ig_sdtm", "SDTMIG", "3.2", "PP", "PPSTRESC"),
    c("ig_sdtm", "SDTMIG", "3.2", "PE", "PESTRESC"),
    c("ig_sdtm", "SDTMIG", "3.2", "QS", "QSSTRESC"),
    c("ig_sdtm", "SDTMIG", "3.2", "FA", "FALAT"),
    c("ig_sdtm", "SDTMIG", "3.2", "SR", "SRSTRESC"),
    # SDTMIG-MD 1.0 (abbreviated in 1.1)
    c("ig_sdtm", "SDTMIG-MD", "1.0", "DE", "DEDY"),
    c("ig_sdtm", "SDTMIG-MD", "1.0", "DE", "DESTDY"),
    c("ig_sdtm", "SDTMIG-MD", "1.0", "DT", "DTDTC"),
    # SDTM model 1.2 to 1.6 (abbreviated from 1.7)
    c("model_sdtm", "SDTM", "1.2", "Findings", "--TESTCD"),
    c("model_sdtm", "SDTM", "1.3", "Findings", "--TESTCD"),
    c("model_sdtm", "SDTM", "1.4", "Findings", "--TESTCD"),
    c("model_sdtm", "SDTM", "1.5", "Findings", "--TESTCD"),
    c("model_sdtm", "SDTM", "1.6", "Findings", "--TESTCD"),
    # ADaMIG 1.2 and 1.3
    c("ig_adam", "ADaMIG", "1.2", "Basic Data Structure", "PBCHGCyN"),
    c("ig_adam", "ADaMIG", "1.3", "Basic Data Structure", "PBCHGCyN")
  )
  labels <- c(
    rep(c("Reported Term for the Healthcare Encounter",
          "Dictionary-Derived Term for the Healthcare Encounter",
          "Study Day of Start of Healthcare Encounter",
          "Reason Medical History Not Done or Not Occurred",
          "Character Results/Findings in Std. Format"), 1L),
    rep("Character Result/Finding in Standard Format", 5L),
    "Laterality of Location of the Finding About",
    "Character Results/Findings in Std. Format",
    "Study Day of Device Event Data Collection",
    "Study Day of Device Event Start Date/Time",
    "Date/Time of Device Tracking Event Collection",
    rep("Short Name of Measurement, Test or Examination", 5L),
    rep("Percent Change to Baseline Category y (N)", 2L)
  )
  m <- do.call(rbind, rows)
  data.frame(table = m[, 1L], standard = m[, 2L], version = m[, 3L],
             where = m[, 4L], variable = m[, 5L], label = labels,
             stringsAsFactors = FALSE)
})

# The only rows whose type or Core the guides leave blank.
ig_missing_field_exceptions <- data.frame(
  table    = "ig_sdtm",
  standard = c("SDTMIG", "SDTMIG", "SDTMIG", "SDTMIG", "SDTMIG-MD"),
  version  = c("3.1.3", "3.2", "3.2", "3.2", "1.0"),
  domain   = c("TR", "TR", "PR", "FA", "DX"),
  variable = c("TRMETHOD", "TRMETHOD", "PRLNKGRP", "FALAT", "DXLAT"),
  field    = c("type", "type", "core", "core", "core"),
  stringsAsFactors = FALSE
)

# The 34 "Version" strings of the exports the tables are built from.
ig_version_strings <- c(
  paste("SDTM v", c("1.2", "1.3", "1.4", "1.5", "1.6", "1.7", "1.8", "2.0", "2.1"), sep = ""),
  paste("SDTMIG v", c("3.1.2", "3.1.3", "3.2", "3.3", "3.4"), sep = ""),
  "SDTMIG-AP v1.0", "SDTMIG-MD v1.0", "SDTMIG-MD v1.1",
  paste("SENDIG v", c("3.0", "3.1", "3.1.1"), sep = ""),
  "SENDIG-AR v1.0", "SENDIG-DART v1.1", "SENDIG-GeneTox v1.0",
  paste("ADaMIG v", c("1.0", "1.1", "1.2", "1.3"), sep = ""),
  "ADaMIG MD v1.0", "ADaMIG NCA v1.0", "ADaM ADAE v1.0", "ADaM BDS for TTE v1.0",
  "ADaM OCCDS v1.0", "ADaM OCCDS v1.1", "ADaM popPK v1.0"
)

# Short codes for the CDASHIG scenarios named in cdash_label_exceptions.
cdash_scenarios <- c(
  "-"       = NA_character_,
  da_denorm = "DA - Denormalized - Implementation Options: Horizontal-Example",
  da_horiz  = "DA - Implementation Options: Horizontal-Generic",
  pe_trad   = "PE Traditional Scenario",
  sc_horiz  = "SC - Implementation Options: Horizontal-Generic",
  sr_horiz  = "SR - Implementation Options: Horizontal-Generic",
  local_2   = "Scenario 2: Local Processing",
  vs_denorm = "VS - Denormalized - Implementation Options: Horizontal-Example"
)

# Labels over 40 characters in the CDASH tables. A variable is keyed with its
# scenario (NA when common to the domain), as a CDASHIG domain can define a
# variable once per scenario; the length is part of the entry so that a label
# that changes is noticed.
# 6 rows in cdash_model (--TESTCD in 1.0 and 1.1, --ENDATF in all four) and
# 71 in ig_cdash (all in CDASHIG 2.0).
cdash_label_exceptions <- local({
  rows <- list(
    c("cdash_model", "CDASH", "1.0", "Findings", "-", "--TESTCD", "46"),
    c("cdash_model", "CDASH", "1.0", "Findings", "-", "--ENDATF", "44"),
    c("cdash_model", "CDASH", "1.1", "Findings", "-", "--TESTCD", "46"),
    c("cdash_model", "CDASH", "1.1", "Findings", "-", "--ENDATF", "44"),
    c("cdash_model", "CDASH", "1.2", "Findings", "-", "--ENDATF", "44"),
    c("cdash_model", "CDASH", "1.3", "Findings", "-", "--ENDATF", "44"),
    c("ig_cdash", "CDASHIG", "2.0", "CM", "-", "CMSPID", "43"),
    c("ig_cdash", "CDASHIG", "2.0", "CM", "-", "CMDOSFRQ", "46"),
    c("ig_cdash", "CDASHIG", "2.0", "CM", "-", "CMDECOD", "48"),
    c("ig_cdash", "CDASHIG", "2.0", "PR", "-", "PRDECOD", "41"),
    c("ig_cdash", "CDASHIG", "2.0", "PR", "-", "PRSOCCD", "41"),
    c("ig_cdash", "CDASHIG", "2.0", "SU", "-", "SUCSTAT", "41"),
    c("ig_cdash", "CDASHIG", "2.0", "SU", "-", "SUDECOD", "45"),
    c("ig_cdash", "CDASHIG", "2.0", "AE", "-", "AEPORTOT", "42"),
    c("ig_cdash", "CDASHIG", "2.0", "AE", "-", "AEDIS", "42"),
    c("ig_cdash", "CDASHIG", "2.0", "AE", "-", "AERELNST", "49"),
    c("ig_cdash", "CDASHIG", "2.0", "AE", "-", "AEDECOD", "50"),
    c("ig_cdash", "CDASHIG", "2.0", "AE", "-", "AESOCCD", "45"),
    c("ig_cdash", "CDASHIG", "2.0", "CE", "-", "CESPID", "41"),
    c("ig_cdash", "CDASHIG", "2.0", "CE", "-", "CEPORTOT", "43"),
    c("ig_cdash", "CDASHIG", "2.0", "CE", "-", "CEDECOD", "51"),
    c("ig_cdash", "CDASHIG", "2.0", "CE", "-", "CEHLGTCD", "41"),
    c("ig_cdash", "CDASHIG", "2.0", "CE", "-", "CESOC", "41"),
    c("ig_cdash", "CDASHIG", "2.0", "CE", "-", "CESOCCD", "46"),
    c("ig_cdash", "CDASHIG", "2.0", "DS", "-", "DSDECOD", "54"),
    c("ig_cdash", "CDASHIG", "2.0", "DV", "-", "DVDECOD", "46"),
    c("ig_cdash", "CDASHIG", "2.0", "DV", "-", "DVSPID", "45"),
    c("ig_cdash", "CDASHIG", "2.0", "HO", "-", "HOCSTAT", "49"),
    c("ig_cdash", "CDASHIG", "2.0", "HO", "-", "HOSPID", "47"),
    c("ig_cdash", "CDASHIG", "2.0", "HO", "-", "HODECOD", "52"),
    c("ig_cdash", "CDASHIG", "2.0", "HO", "-", "HOCDURU", "44"),
    c("ig_cdash", "CDASHIG", "2.0", "HO", "-", "HOREAS", "41"),
    c("ig_cdash", "CDASHIG", "2.0", "MH", "-", "MHSPID", "48"),
    c("ig_cdash", "CDASHIG", "2.0", "MH", "-", "MHCTRL", "48"),
    c("ig_cdash", "CDASHIG", "2.0", "MH", "-", "MHPORTOT", "50"),
    c("ig_cdash", "CDASHIG", "2.0", "MH", "-", "MHDECOD", "58"),
    c("ig_cdash", "CDASHIG", "2.0", "MH", "-", "MHLLTCD", "44"),
    c("ig_cdash", "CDASHIG", "2.0", "MH", "-", "MHPTCD", "41"),
    c("ig_cdash", "CDASHIG", "2.0", "MH", "-", "MHHLTCD", "42"),
    c("ig_cdash", "CDASHIG", "2.0", "MH", "-", "MHHLGT", "43"),
    c("ig_cdash", "CDASHIG", "2.0", "MH", "-", "MHHLGTCD", "48"),
    c("ig_cdash", "CDASHIG", "2.0", "MH", "-", "MHSOC", "48"),
    c("ig_cdash", "CDASHIG", "2.0", "MH", "-", "MHSOCCD", "53"),
    c("ig_cdash", "CDASHIG", "2.0", "DA", "-", "DACAT", "42"),
    c("ig_cdash", "CDASHIG", "2.0", "DA", "-", "DASCAT", "45"),
    c("ig_cdash", "CDASHIG", "2.0", "IE", "-", "IEYN", "41"),
    c("ig_cdash", "CDASHIG", "2.0", "IE", "-", "IESCAT", "43"),
    c("ig_cdash", "CDASHIG", "2.0", "SC", "-", "SCPERF", "43"),
    c("ig_cdash", "CDASHIG", "2.0", "SC", "-", "SCSPID", "49"),
    c("ig_cdash", "CDASHIG", "2.0", "SC", "-", "SCDAT", "42"),
    c("ig_cdash", "CDASHIG", "2.0", "RP", "-", "RPCAT", "41"),
    c("ig_cdash", "CDASHIG", "2.0", "RP", "-", "RPSCAT", "44"),
    c("ig_cdash", "CDASHIG", "2.0", "RP", "-", "RPSPID", "55"),
    c("ig_cdash", "CDASHIG", "2.0", "RP", "-", "RPREASND", "44"),
    c("ig_cdash", "CDASHIG", "2.0", "SR", "-", "SRRFTDAT", "42"),
    c("ig_cdash", "CDASHIG", "2.0", "SR", "-", "SRRFTTIM", "42"),
    c("ig_cdash", "CDASHIG", "2.0", "SR", "-", "SRLOC", "43"),
    c("ig_cdash", "CDASHIG", "2.0", "FA", "-", "FAORNRLO", "54"),
    c("ig_cdash", "CDASHIG", "2.0", "FA", "-", "FAORNRHI", "54"),
    c("ig_cdash", "CDASHIG", "2.0", "FA", "-", "FAPORTOT", "43"),
    c("ig_cdash", "CDASHIG", "2.0", "DA", "da_denorm", "DISPAMT_DACAT", "42"),
    c("ig_cdash", "CDASHIG", "2.0", "DA", "da_denorm", "DISPAMT_DASCAT", "45"),
    c("ig_cdash", "CDASHIG", "2.0", "DA", "da_denorm", "RETAMT_DACAT", "42"),
    c("ig_cdash", "CDASHIG", "2.0", "DA", "da_denorm", "RETAMT_DASCAT", "45"),
    c("ig_cdash", "CDASHIG", "2.0", "DA", "da_horiz", "[DATESTCD]_DACAT", "42"),
    c("ig_cdash", "CDASHIG", "2.0", "DA", "da_horiz", "[DATESTCD]_DASCAT", "45"),
    c("ig_cdash", "CDASHIG", "2.0", "LB", "local_2", "LBORNRLO", "43"),
    c("ig_cdash", "CDASHIG", "2.0", "LB", "local_2", "LBORNRHI", "43"),
    c("ig_cdash", "CDASHIG", "2.0", "MI", "local_2", "MISPID", "47"),
    c("ig_cdash", "CDASHIG", "2.0", "PE", "pe_trad", "PEPORTOT", "42"),
    c("ig_cdash", "CDASHIG", "2.0", "SC", "sc_horiz", "[SCTESTCD]_SCPERF", "43"),
    c("ig_cdash", "CDASHIG", "2.0", "SR", "sr_horiz", "[SRTESTCD]_SRRFTDAT", "42"),
    c("ig_cdash", "CDASHIG", "2.0", "SR", "sr_horiz", "[SRTESTCD]_SRRFTTIM", "42"),
    c("ig_cdash", "CDASHIG", "2.0", "VS", "vs_denorm", "SYSBP_VSCLSIG", "45"),
    c("ig_cdash", "CDASHIG", "2.0", "VS", "vs_denorm", "SYSBP_VSPOS", "43"),
    c("ig_cdash", "CDASHIG", "2.0", "VS", "vs_denorm", "DIABP_VSCLSIG", "46"),
    c("ig_cdash", "CDASHIG", "2.0", "VS", "vs_denorm", "DIABP_VSPOS", "44")
  )
  m <- do.call(rbind, rows)
  data.frame(table = m[, 1L], standard = m[, 2L], version = m[, 3L],
             where = m[, 4L], scenario = unname(cdash_scenarios[m[, 5L]]),
             variable = m[, 6L],
             nchar = as.integer(m[, 7L]), stringsAsFactors = FALSE)
})

# CDASHIG 1.1 publishes no variable label at all: every one of its rows has an
# NA label, and no other CDASH row does.
cdash_missing_label_exceptions <- data.frame(
  table = "ig_cdash", standard = "CDASHIG", version = "1.1", rows = 370L,
  stringsAsFactors = FALSE
)

# The nine CDASH "Version" strings and the nine QRS supplement file names whose
# instrument and version are parsed from the name.
cdash_version_strings <- c(
  paste("CDASH Model v", c("1.0", "1.1", "1.2", "1.3"), sep = ""),
  paste("CDASHIG v", c("1.1", "2.0", "2.1", "2.2", "2.3"), sep = "")
)
qrs_files <- c(
  "AIMS_Supplement_v2.0.csv", "APACHE_II_Supplement_v1.0.csv",
  "ATLAS_Supplement_v1.0.csv", "CGI_Supplement_v2.1.csv",
  "HAM-A_Supplement_v2.1.csv", "KFSS_Supplement_v2.0.csv",
  "KPS_SCALE_Supplement_v2.0.csv", "PGI_Supplement_v1.1.csv",
  "SIX_MINUTE_WALK_Supplement_v1.0.csv"
)

# The rows of ig_sources for the three SDTM- and ADaM-side tables that get_ig()
# reaches (the CDASH and QRS exports are covered by test-cdash_integrity.R).
ig_standard_sources <- function() {
  src <- cdiscdata::ig_sources
  src[src$table %in% c("ig_sdtm", "model_sdtm", "ig_adam"), ]
}

# One string per row, made of the key columns (NA shows as "NA"), to test that
# a key is unique.
ig_row_key <- function(tbl, cols) {
  do.call(paste, c(lapply(tbl[cols], as.character), sep = "\r"))
}
