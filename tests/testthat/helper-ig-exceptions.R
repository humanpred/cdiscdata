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
