#' Get path to a Define-XML XSD schema file
#'
#' @param define_version One of \code{"2.1"} or \code{"2.0"}.
#' @return Full file path to the primary XSD file.
#' @export
#' @examples
#' schema_path("2.1")
#' schema_path("2.0")
schema_path <- function(define_version = c("2.1", "2.0")) {
  define_version <- match.arg(define_version)
  dir <- paste0("define-xml-", define_version)
  xsd <- paste0("define", gsub("\\.", "-", define_version), "-0.xsd")
  path <- .sys_file("extdata", "schema", dir, xsd, package = "cdiscdata")
  if (!nzchar(path)) {
    stop(paste0("Schema file for Define-XML ", define_version,
                " not found in package."))
  }
  path
}

#' Get path to a Define-XML XSLT stylesheet
#'
#' @param define_version One of \code{"2.1"} or \code{"2.0"}.
#' @return Full file path to the XSL stylesheet.
#' @export
#' @examples
#' stylesheet_path("2.1")
#' stylesheet_path("2.0")
stylesheet_path <- function(define_version = c("2.1", "2.0")) {
  define_version <- match.arg(define_version)
  xsl <- paste0("define", gsub("\\.", "-", define_version), "-0.xsl")
  path <- .sys_file("extdata", "stylesheet", xsl, package = "cdiscdata")
  if (!nzchar(path)) {
    stop(paste0("Stylesheet for Define-XML ", define_version,
                " not found in package."))
  }
  path
}
