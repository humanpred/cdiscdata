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
