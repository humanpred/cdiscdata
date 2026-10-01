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

#' SDTM implementation-guide variable metadata
#'
#' Versioned SDTM Model and SDTMIG variable metadata: the Model's Findings
#' general-observation-class variables (versions 1.4-1.7); the SDTMIG PP
#' domain and generic SUPP-- qualifier structure (used for SUPPPP) at
#' versions 3.2 and 3.3, which share the same tables; and every domain of
#' SDTMIG 3.4 (63 domains, 1917 variables), transcribed from a CDISC Library
#' export that is not redistributed (see \code{\link{get_ig}} and
#' \code{data-raw/ig_source/README.md}).
#' Use \code{\link{get_ig}} to retrieve it, and
#' \code{\link{build_domain_spec}} to build a ready-to-use PP/SUPPPP/ADPP
#' variable spec from it (joined to CT for codelist ids).
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{source}{\code{"SDTM_MODEL"} or \code{"SDTMIG"}.}
#'   \item{version}{SDTM Model version (\code{"1.4"}-\code{"1.7"}) for
#'     \code{source == "SDTM_MODEL"} rows; SDTMIG version (\code{"3.2"},
#'     \code{"3.3"}, or \code{"3.4"}) for \code{source == "SDTMIG"} rows. The two are independent numbering
#'     systems; see \code{\link{get_ig}}.}
#'   \item{class}{General observation class, e.g. \code{"Findings"}.
#'     \code{NA} for \code{SDTMIG} 3.2 and 3.3 rows; populated for 3.4.}
#'   \item{domain}{Domain: \code{"PP"} or \code{"SUPPQUAL"} for SDTMIG 3.2
#'     and 3.3; any of the 63 SDTMIG 3.4 domains (\code{"AE"}, \code{"LB"},
#'     \code{"SUPPQUAL"}, ...) for 3.4. \code{NA} for \code{SDTM_MODEL}
#'     rows.}
#'   \item{order}{Row order within its source table, as published.}
#'   \item{variable}{Variable name, e.g. \code{"PPTESTCD"}.}
#'   \item{label}{Variable label.}
#'   \item{type}{\code{"Char"} or \code{"Num"}.}
#'   \item{role}{CDISC variable role, e.g. \code{"Topic"}. \code{NA} for
#'     ADaM rows (not applicable, and not present in \code{ig_adam}).}
#'   \item{core}{SDTMIG Core designation (\code{"Req"}/\code{"Exp"}/
#'     \code{"Perm"}). \code{NA} for \code{SDTM_MODEL} rows (the model does
#'     not designate Core; that is an IG-level concept).}
#'   \item{codelist}{Codelist submission value referenced by this variable
#'     (e.g. \code{"PKPARMCD"}), parsed from the IG's free-text
#'     "Controlled Terms" column. Look up its codelist C-code via
#'     \code{\link{get_ct}}'s \code{codelist_name}/\code{codelist_code}
#'     columns, as \code{\link{build_domain_spec}} does. \code{NA} when the
#'     variable has no codelist, or the column instead names a format
#'     (e.g. "ISO 8601") or an unspecified extensible list ("*").}
#'   \item{length}{Maximum character length, when the IG text states one
#'     explicitly (e.g. PPTESTCD's 8-character limit); \code{NA} otherwise,
#'     since CDISC implementation guides do not otherwise publish a Length
#'     column (length is a sponsor/define.xml choice).}
#'   \item{notes}{CDISC Notes / Description text for the variable.}
#' }
#' @source \url{https://github.com/humanpred/Rsdtm}; see
#'   \code{data-raw/ig_source/README.md} for full attribution.
"ig_sdtm"

#' ADaM implementation-guide variable metadata
#'
#' Versioned ADaMIG variable metadata: the ADSL (subject-level) variable
#' table and the generic BDS (Basic Data Structure) variable table (used for
#' ADPP, a BDS-structured dataset), for ADaMIG versions 1.0, 1.1, and 1.2.
#' Use \code{\link{get_ig}} to retrieve it, and
#' \code{\link{build_domain_spec}} to build a ready-to-use ADPP variable
#' spec from it (joined to CT for codelist ids).
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{dataset}{\code{"ADSL"} or \code{"BDS"}.}
#'   \item{version}{ADaMIG version, e.g. \code{"1.2"}.}
#'   \item{category}{The Rsdtm source file's variable-category name (e.g.
#'     \code{"ADSL_Treatment_Variables"}, \code{"Timing_Variables_BDS_Datasets"}),
#'     kept for provenance; ADaMIG itself does not group these tables this
#'     way.}
#'   \item{order}{Row order within its category file, as published.}
#'   \item{variable}{Variable name, e.g. \code{"AVAL"}.}
#'   \item{label}{Variable label.}
#'   \item{type}{\code{"Char"} or \code{"Num"}.}
#'   \item{core}{ADaMIG Core designation (\code{"Req"}/\code{"Exp"}/
#'     \code{"Perm"}/\code{"Cond"}).}
#'   \item{codelist}{Codelist submission value referenced by this variable,
#'     parsed the same way as \code{\link{ig_sdtm}}'s \code{codelist}
#'     column; see there for details and caveats.}
#'   \item{length}{Maximum character length when the IG text states one
#'     explicitly; \code{NA} otherwise. See \code{\link{ig_sdtm}}.}
#'   \item{notes}{CDISC Notes text for the variable.}
#' }
#' @source \url{https://github.com/humanpred/Rsdtm}; see
#'   \code{data-raw/ig_source/README.md} for full attribution.
"ig_adam"

#' Datasets catalogue
#'
#' Metadata about all datasets bundled in \code{cdiscdata}, including CT
#' tables and Define-XML file-based assets.
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{dataset}{R object name or logical dataset identifier.}
#'   \item{type}{One of \code{"CT"}, \code{"Schema"}, \code{"Stylesheet"}.}
#'   \item{ct_type}{One of \code{"sdtm"}, \code{"adam"}, or \code{NA} for
#'     non-CT datasets.}
#'   \item{description}{Human-readable description.}
#'   \item{versions}{Human-readable version range string.}
#'   \item{n_versions}{Number of distinct versions available.}
#'   \item{latest}{Most recent version string.}
#'   \item{last_updated}{Date this catalogue row was last refreshed.}
#' }
"datasets_catalogue"
