#' SDTM Controlled Terminology
#'
#' Versioned CDISC SDTM Controlled Terminology from the NCI EVS FTP site.
#' Uses a validity-date design: one row per unique term-state across all
#' versions. A term is "current" when \code{valid_to} is \code{NA}.
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{codelist_code}{NCI C-code for the codelist, e.g. \code{"C66731"}.}
#'   \item{codelist_name}{Submission value for the codelist, e.g. \code{"SEX"}.}
#'   \item{codelist_label}{Long name, e.g. \code{"Sex"}.}
#'   \item{extensible}{Logical; whether sponsor extensions are allowed.}
#'   \item{term_code}{NCI C-code for the term, e.g. \code{"C16576"}.
#'     \code{NA} for codelist-level rows.}
#'   \item{term}{Submission value, e.g. \code{"F"}.
#'     \code{NA} for codelist-level rows.}
#'   \item{decoded_value}{NCI preferred term / decoded value, e.g.
#'     \code{"Female"}.}
#'   \item{synonyms}{Pipe-separated synonyms.}
#'   \item{definition}{NCI definition text.}
#'   \item{valid_from}{Date of the first CT release in which this row's
#'     content appeared.}
#'   \item{valid_to}{Date of the last CT release in which this row's content
#'     was present; \code{NA} if still current.}
#' }
#' @source \url{https://evs.nci.nih.gov/ftp1/CDISC/SDTM/}
"ct_sdtm"

#' ADaM Controlled Terminology
#'
#' Versioned CDISC ADaM Controlled Terminology from the NCI EVS FTP site.
#' Same validity-date design as \code{\link{ct_sdtm}}.
#'
#' @format A data frame with the same columns as \code{\link{ct_sdtm}}.
#' @source \url{https://evs.nci.nih.gov/ftp1/CDISC/ADaM/}
"ct_adam"

#' SDTM-side implementation-guide variable metadata
#'
#' One row per variable of every domain of seven implementation-guide
#' standards, at every version: SDTMIG (3.1.2, 3.1.3, 3.2, 3.3, 3.4),
#' SDTMIG-AP (1.0), SDTMIG-MD (1.0, 1.1), SENDIG (3.0, 3.1, 3.1.1),
#' SENDIG-AR (1.0), SENDIG-DART (1.1), and SENDIG-GeneTox (1.0); 14 standard
#' versions in all. Built from CDISC Library CSV exports that are not part of
#' this package or repository (see \code{\link{ig_sources}} and
#' \code{data-raw/README.md}); only variable metadata is carried, not the
#' guides' prose. Use \code{\link{get_ig}} to retrieve a standard, and
#' \code{\link{build_domain_spec}} to build a ready-to-use PP/SUPPPP/ADPP
#' variable spec from it. The SDTM model itself is in
#' \code{\link{model_sdtm}}.
#'
#' A (standard, version, domain, variable) is unique.
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{standard}{The standard, e.g. \code{"SDTMIG"} or \code{"SENDIG-AR"}.}
#'   \item{version}{The standard's version, e.g. \code{"3.4"}.}
#'   \item{class}{General observation class, e.g. \code{"Findings"}.}
#'   \item{domain}{Domain, e.g. \code{"PP"}, \code{"LB"}, \code{"SUPPQUAL"}.}
#'   \item{order}{Position within the domain, as published.}
#'   \item{variable}{Variable name, e.g. \code{"PPTESTCD"}.}
#'   \item{label}{Variable label. At most 40 characters except for 22 labels
#'     the guides themselves publish longer (see the data-integrity tests).}
#'   \item{type}{\code{"Char"} or \code{"Num"}.}
#'   \item{role}{CDISC variable role, e.g. \code{"Topic"}.}
#'   \item{core}{Core designation (\code{"Req"}, \code{"Exp"},
#'     \code{"Perm"}, \code{"Cond"}, or the published \code{"Not used"}).}
#'   \item{codelist_code}{CDISC CT codelist C-code(s) the variable uses, as
#'     published; several are separated by \code{"; "} (e.g. PPORRESU lists
#'     PKUNIT and four normalised-unit codelists). \code{NA} when none.}
#'   \item{codelist_submission_values}{The codelist submission value(s),
#'     where the export gives them (the SEND guides do; the SDTMIG exports do
#'     not, so look the code up in \code{\link{get_ct}}).}
#'   \item{described_value_domain}{A described value domain such as
#'     \code{"ISO 8601"}, where the variable has one rather than a codelist.}
#'   \item{value_list}{A fixed list of allowed values, e.g. the domain
#'     abbreviation for \code{DOMAIN}.}
#' }
#' @source CDISC Library CSV exports, downloaded under CDISC's terms and not
#'   redistributed; see \code{data-raw/README.md}.
"ig_sdtm"

#' SDTM model variable metadata
#'
#' One row per variable of the CDISC SDTM model, at every version: 1.2, 1.3,
#' 1.4, 1.5, 1.6, 1.7, 1.8, 2.0, and 2.1. Built from CDISC Library CSV exports
#' not redistributed with this package (see \code{\link{ig_sources}}); only
#' variable metadata is carried, not the model's descriptions, definitions,
#' notes, or examples. Retrieve it with \code{\link{get_ig}("SDTM")}.
#'
#' A (standard, version, class, dataset, variable) is unique. \code{dataset}
#' is \code{NA} for the general-observation-class variables (Events,
#' Findings, ...), which are defined once per class with a \code{--} prefix,
#' and set for the datasets the model defines outright (e.g. \code{"DM"}).
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{standard}{Always \code{"SDTM"}.}
#'   \item{version}{Model version, e.g. \code{"2.1"}.}
#'   \item{class}{Observation class or dataset class, e.g.
#'     \code{"Findings"}, \code{"Trial Design"}.}
#'   \item{dataset}{Dataset name, or \code{NA} for class-level variables.}
#'   \item{order}{Position within the class/dataset, as published.}
#'   \item{variable}{Variable name, e.g. \code{"--TESTCD"}.}
#'   \item{label}{Variable label. \code{"--TESTCD"} is published at 46
#'     characters in model versions 1.2 to 1.6.}
#'   \item{type}{\code{"Char"} or \code{"Num"}.}
#'   \item{role}{CDISC variable role.}
#'   \item{described_value_domain}{A described value domain, e.g.
#'     \code{"ISO 8601"}; sparse before version 2.0.}
#'   \item{variables_qualified}{The variable(s) this one qualifies.}
#'   \item{usage_restrictions}{Usage restrictions on the variable; version
#'     2.0 and later, \code{NA} before.}
#'   \item{variable_code}{The variable's NCI C-code; version 2.0 and later,
#'     \code{NA} before.}
#' }
#' @source CDISC Library CSV exports, downloaded under CDISC's terms and not
#'   redistributed; see \code{data-raw/README.md}.
"model_sdtm"

#' ADaM implementation-guide variable metadata
#'
#' One row per variable of seven ADaM standards, at every version: ADaMIG
#' (1.0, 1.1, 1.2, 1.3), ADaMIG-MD (1.0), ADaMIG-NCA (1.0), ADaM-ADAE (1.0),
#' ADaM-BDS-TTE (1.0), ADaM-OCCDS (1.0, 1.1), and ADaM-popPK (1.0); 11 standard
#' versions in all. Built from CDISC Library CSV exports that are not part of
#' this package or repository (see \code{\link{ig_sources}} and
#' \code{data-raw/README.md}); only variable metadata is carried, not the
#' guides' prose. Use \code{\link{get_ig}} to retrieve a standard, and
#' \code{\link{build_domain_spec}} to build an ADPP variable spec from it
#' (ADPP is a Basic Data Structure dataset; ADaMIG-NCA extends it).
#'
#' A (standard, version, structure, variable_set, variable) is unique: the
#' variable set is part of the key because ADaM-OCCDS defines \code{DECDORGw}
#' twice, once for each dictionary-specific variable set, with different
#' labels.
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{standard}{The standard, e.g. \code{"ADaMIG"} or
#'     \code{"ADaMIG-NCA"}.}
#'   \item{version}{The standard's version, e.g. \code{"1.3"}.}
#'   \item{structure}{The data structure, as named in the export, e.g.
#'     \code{"Basic Data Structure"} or \code{"Subject-Level Analysis
#'     Dataset"} (ADSL).}
#'   \item{variable_set}{The variable set within the structure, e.g.
#'     \code{"Timing"}.}
#'   \item{order}{Row order within the export for that standard version.}
#'   \item{variable}{Variable name, e.g. \code{"AVAL"}.}
#'   \item{label}{Variable label. At most 40 characters except
#'     \code{PBCHGCyN} in ADaMIG 1.2 and 1.3, which the guide publishes at 41.}
#'   \item{type}{\code{"Char"} or \code{"Num"}.}
#'   \item{core}{Core designation (\code{"Req"}, \code{"Perm"},
#'     \code{"Cond"}, ...).}
#'   \item{codelist_code}{CDISC CT codelist C-code(s) the variable uses;
#'     several are separated by \code{"; "}. \code{NA} when none.}
#'   \item{codelist_submission_values}{The codelist submission value(s),
#'     where the export gives them.}
#'   \item{described_value_domain}{A described value domain, where the
#'     variable has one rather than a codelist.}
#'   \item{value_list}{A fixed list of allowed values, where there is one.}
#' }
#' @source CDISC Library CSV exports, downloaded under CDISC's terms and not
#'   redistributed; see \code{data-raw/README.md}.
"ig_adam"

#' CDASH model variable metadata
#'
#' One row per variable of the CDISC Clinical Data Acquisition Standards
#' Harmonization (CDASH) model, at every version: 1.0, 1.1, 1.2, and 1.3.
#' Built from CDISC Library CSV exports not redistributed with this package
#' (see \code{\link{ig_sources}}); only variable metadata and the collection
#' wording (question text, prompt) is carried, not the model's definitions,
#' mapping instructions, or implementation notes. Retrieve it with
#' \code{\link{get_cdash}("CDASH")}.
#'
#' A (standard, version, class, domain, variable) is unique. The model defines
#' most variables once per class with a \code{--} prefix (\code{domain} is
#' \code{NA}) and some per domain.
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{standard}{Always \code{"CDASH"}.}
#'   \item{version}{Model version, e.g. \code{"1.3"}.}
#'   \item{class}{Observation or special-purpose class, e.g.
#'     \code{"Findings"}, \code{"Identifiers"}.}
#'   \item{domain}{The domain a domain-specific variable belongs to (e.g.
#'     \code{"AE"}), or \code{NA} for class-level variables.}
#'   \item{order}{Position within the class and domain, as published.}
#'   \item{variable}{CDASH variable name, e.g. \code{"--TERM"}.}
#'   \item{label}{Variable label. At most 40 characters except for 6 labels
#'     the model publishes longer (\code{--TESTCD} in 1.0 and 1.1;
#'     \code{--ENDATF} in all four versions).}
#'   \item{domain_specific}{\code{TRUE} where the model flags the variable as
#'     domain specific; \code{NA} where it does not say.}
#'   \item{question_text}{The CRF question text the model suggests.}
#'   \item{prompt}{The CRF field prompt the model suggests.}
#'   \item{type}{\code{"Char"} or \code{"Num"}.}
#'   \item{sdtm_target}{The SDTM variable or variables the collected value
#'     maps to.}
#'   \item{codelist_code}{The CDISC CT codelist C-code the variable uses;
#'     \code{NA} when none.}
#' }
#' @source CDISC Library CSV exports, downloaded under CDISC's terms and not
#'   redistributed; see \code{data-raw/README.md}.
"cdash_model"

#' CDASH implementation-guide variable metadata
#'
#' One row per variable of every domain and data collection scenario of the
#' CDASH implementation guide (CDASHIG), at every version: 1.1, 2.0, 2.1, 2.2,
#' and 2.3. Built from CDISC Library CSV exports not redistributed with this
#' package (see \code{\link{ig_sources}}); only variable metadata and the
#' collection wording (question text, prompt) is carried, not the guide's
#' definitions, CRF completion instructions, mapping instructions, or
#' implementation notes. Retrieve it with \code{\link{get_cdash}}.
#'
#' A (standard, version, domain, scenario, variable) is unique.
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{standard}{Always \code{"CDASHIG"}.}
#'   \item{version}{Guide version, e.g. \code{"2.3"}.}
#'   \item{class}{General observation class, e.g. \code{"Findings"}.}
#'   \item{domain}{Domain, e.g. \code{"LB"}.}
#'   \item{scenario}{The data collection scenario or implementation option
#'     the row belongs to (e.g. \code{"Local Processing"}), or \code{NA} for
#'     variables common to the domain.}
#'   \item{order}{Position within the domain and scenario, as published.}
#'   \item{variable}{CDASHIG variable name, e.g. \code{"LBORRES"}.}
#'   \item{label}{Variable label. Not published in version 1.1 (\code{NA}
#'     for all of its rows); at most 40 characters except for 71 labels in
#'     version 2.0, which the guide publishes longer.}
#'   \item{question_text}{The CRF question text the guide suggests.}
#'   \item{prompt}{The CRF field prompt the guide suggests.}
#'   \item{type}{As published: \code{"Char"}, \code{"Num"},
#'     \code{"Date (dd-MON-yyyy)"}, or \code{"Time (24 hour)"}.}
#'   \item{core}{CDASHIG Core designation, as published: \code{"HR"} (highly
#'     recommended), \code{"R/C"} (recommended or conditional), or \code{"O"}
#'     (optional).}
#'   \item{sdtmig_target}{The SDTMIG variable the collected value maps to.}
#'   \item{codelist_code}{The CDISC CT codelist C-code(s) or subset code(s)
#'     the variable uses; \code{NA} when none.}
#'   \item{codelist_submission_value}{The codelist submission value, where the
#'     export gives one.}
#' }
#' @source CDISC Library CSV exports, downloaded under CDISC's terms and not
#'   redistributed; see \code{data-raw/README.md}.
"ig_cdash"

#' CDISC QRS supplement item metadata
#'
#' One row per item of each of nine questionnaire, rating-scale, and
#' functional-test (QRS) instrument supplements: AIMS (2.0), APACHE_II (1.0),
#' ATLAS (1.0), CGI (2.1), HAM-A (2.1), KFSS (2.0), KPS_SCALE (2.0), PGI (1.1),
#' and SIX_MINUTE_WALK (1.0). Built from CDISC Library CSV exports not
#' redistributed with this package (see \code{\link{ig_sources}}); only the
#' identifiers that map an item to SDTM controlled terminology are carried,
#' not the item text. Reach it with \code{get_dataset("qrs_supplement")}.
#'
#' The exports have no \code{Version} column; \code{instrument} and
#' \code{version} are taken from the file name (\code{HAM-A_Supplement_v2.1.csv}).
#' A (instrument, version, item_order) is unique.
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{instrument}{The instrument, as in the file name, e.g.
#'     \code{"HAM-A"}, \code{"SIX_MINUTE_WALK"}.}
#'   \item{version}{The supplement's version, e.g. \code{"2.1"}.}
#'   \item{item_order}{Position of the item within the instrument.}
#'   \item{test_name}{The item's \code{--TEST} value, e.g.
#'     \code{"AIMS01-Muscles of Facial Expression"}; at most 40 characters.}
#'   \item{testcd_codelist_code}{C-code of the \code{--TESTCD} codelist for
#'     the instrument.}
#'   \item{testcd_code}{The item's \code{--TESTCD} term C-code.}
#'   \item{test_codelist_code}{C-code of the \code{--TEST} codelist for the
#'     instrument.}
#'   \item{test_code}{The item's \code{--TEST} term C-code.}
#'   \item{response_group}{The response (value list) group the item uses, or
#'     \code{NA} for the few items that have none.}
#' }
#' @source CDISC Library CSV exports, downloaded under CDISC's terms and not
#'   redistributed; see \code{data-raw/README.md}.
"qrs_supplement"

#' The CDISC Library exports the datasets were built from
#'
#' One row per export file read by \code{data-raw/build_ig.R}, so which
#' standard versions are bundled, and from exactly which files, is itself
#' data. The files are not part of this package or repository.
#'
#' @format A data frame with 52 rows (34 implementation-guide and model
#'   exports, 9 CDASH, 9 QRS supplements) and columns:
#' \describe{
#'   \item{file}{The export's file name.}
#'   \item{version_string}{The export's \code{Version} value, e.g.
#'     \code{"ADaMIG MD v1.0"}; \code{NA} for the QRS supplements, whose
#'     exports have none.}
#'   \item{standard}{The canonical standard name parsed from the version
#'     string (for a QRS supplement, the instrument parsed from the file
#'     name).}
#'   \item{version}{The version number parsed from the version string (for a
#'     QRS supplement, from the file name).}
#'   \item{table}{The dataset it was loaded into: \code{"ig_sdtm"},
#'     \code{"model_sdtm"}, \code{"ig_adam"}, \code{"cdash_model"},
#'     \code{"ig_cdash"}, or \code{"qrs_supplement"}.}
#'   \item{rows}{Data rows in the file, equal to the rows loaded from it.}
#'   \item{md5}{MD5 checksum of the file, to tell whether a rebuild used the
#'     same export.}
#' }
#' @source CDISC Library CSV exports; see \code{data-raw/README.md}.
"ig_sources"

#' Datasets catalogue
#'
#' Metadata about all datasets bundled in \code{cdiscdata}, including CT
#' tables and Define-XML file-based assets.
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{dataset}{R object name or logical dataset identifier.}
#'   \item{type}{One of \code{"CT"}, \code{"IG"}, \code{"Model"},
#'     \code{"CDASH"}, \code{"QRS"}, \code{"Schema"}, \code{"Stylesheet"}.}
#'   \item{ct_type}{One of \code{"sdtm"}, \code{"adam"}, or \code{NA} for
#'     non-CT datasets.}
#'   \item{description}{Human-readable description.}
#'   \item{versions}{Human-readable version range string.}
#'   \item{n_versions}{Number of distinct versions available.}
#'   \item{latest}{Most recent version string.}
#'   \item{last_updated}{Date this catalogue row was last refreshed.}
#' }
"datasets_catalogue"
