#' Retrieve CDASH model or implementation-guide variable metadata
#'
#' Accessor over the two CDASH (collection-side) tables,
#' \code{\link{cdash_model}} and \code{\link{ig_cdash}}, with the same
#' conventions as \code{\link{get_ig}}: the standard is chosen with
#' \code{standard} and the version defaults to its newest. CDASH is kept apart
#' from \code{get_ig()} because its tables describe case report form
#' collection (question text, prompts, the SDTM variable each field maps to),
#' not a dataset's structure, and so have different columns.
#'
#' The standards: \code{"CDASH"} (the CDASH model, versions 1.0 to 1.3, in
#' \code{\link{cdash_model}}) and \code{"CDASHIG"} (the CDASH implementation
#' guide, 1.1 and 2.0 to 2.3, in \code{\link{ig_cdash}}).
#'
#' Like the other implementation-guide data these come from CDISC Library CSV
#' exports that are not part of this package or repository (see
#' \code{\link{ig_sources}}); the guides' definitions, CRF completion
#' instructions, mapping instructions, and implementation notes are not carried.
#' The collection wording the guides publish (\code{question_text},
#' \code{prompt}) is.
#'
#' @param standard \code{"CDASHIG"} (default) or \code{"CDASH"}.
#' @param version A version string of that standard (e.g. \code{"2.3"}).
#'   \code{NULL} (the default) uses the newest, compared numerically.
#' @param domain Restrict to one domain (e.g. \code{"LB"}); for
#'   \code{"CDASH"} a \code{class} (e.g. \code{"Findings"}) is accepted too.
#'   \code{NULL} (the default) applies no filter.
#' @return A data frame: the rows of \code{\link{cdash_model}} or
#'   \code{\link{ig_cdash}} for that standard, version, and domain. An unknown
#'   standard, version, or domain is a classed error
#'   (\code{cdiscdata_error_ig_standard_unavailable},
#'   \code{cdiscdata_error_ig_version_unavailable},
#'   \code{cdiscdata_error_ig_domain_unavailable}).
#' @export
#' @examples
#' get_cdash()                                  # newest CDASHIG (2.3)
#' get_cdash("CDASHIG", version = "2.1", domain = "LB")
#' get_cdash("CDASH", domain = "Findings")
get_cdash <- function(standard = "CDASHIG", version = NULL, domain = NULL) {
  standard <- .resolve_ig_standard(standard, .cdash_standards$standard, character(0L))
  .library_rows(standard, version, domain, .cdash_standards)
}
