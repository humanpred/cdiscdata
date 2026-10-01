#' Retrieve any cdiscdata dataset by name and version
#'
#' Generic retrieval gateway. For CT datasets, filters to rows valid at
#' the requested version date. For the implementation-guide and model datasets
#' (\code{ig_sdtm}, \code{model_sdtm}, \code{ig_adam}), returns the whole
#' table, or the rows whose \code{version} column equals \code{version} (across
#' every standard in it; use \code{\link{get_ig}} to pick one standard). For
#' schemas and stylesheets, returns the file path for the requested Define-XML
#' version. Use \code{\link{list_datasets}} to see available dataset names.
#'
#' @param name Dataset name from \code{\link{list_datasets}()$dataset}.
#' @param version Version string. For CT, \code{NULL} returns the latest
#'   available version and a value is a date string e.g. \code{"2024-09-27"}.
#'   For schemas/stylesheets, \code{NULL} is the latest and a value is a
#'   Define-XML version string e.g. \code{"2.1"}. For the IG and model datasets,
#'   \code{NULL} returns every version.
#' @return A data frame (for CT, IG, and model data) or a file path string
#'   (for schemas/stylesheets).
#' @export
#' @examples
#' get_dataset("ct_sdtm")
#' get_dataset("ct_sdtm", version = "2024-09-27")
#' get_dataset("ig_adam", version = "1.3")
#' get_dataset("define_xml_schema", version = "2.1")
#' get_dataset("define_xml_stylesheet", version = "2.0")
get_dataset <- function(name, version = NULL) {
  valid_names <- list_datasets()$dataset
  if (!name %in% valid_names) {
    stop(paste0(
      "'", name, "' is not a valid dataset name. ",
      "Run list_datasets() to see available datasets."
    ))
  }

  catalogue <- .pkg_data("datasets_catalogue")
  cat_row <- catalogue[catalogue$dataset == name, ]

  switch(cat_row$type,
    "CT"         = .get_ct_dataset(name, version),
    "IG"         = .get_ig_dataset(name, version),
    "Model"      = .get_ig_dataset(name, version),
    "Schema"     = schema_path(.resolve_schema_version(version)),
    "Stylesheet" = stylesheet_path(.resolve_schema_version(version))
  )
}

# Internal: an IG or model table, whole or restricted to one version string
.get_ig_dataset <- function(name, version) {
  tbl <- .pkg_data(name)
  if (is.null(version)) {
    return(tbl)
  }
  avail <- unique(tbl$version)
  avail <- avail[order(package_version(avail))]
  if (!version %in% avail) {
    .cdiscdata_abort(
      paste0(
        "Version '", version, "' is not available in ", name, ". ",
        "Available versions: ", paste(avail, collapse = ", "), "."
      ),
      "ig_version_unavailable"
    )
  }
  tbl[tbl$version == version, ]
}

# Internal: filter CT table to a specific version date
.get_ct_dataset <- function(name, version) {
  tbl <- .pkg_data(name)
  ct_type <- if (grepl("sdtm", name, fixed = TRUE)) "sdtm" else "adam"
  version_date <- .resolve_ct_version(version, ct_type)
  tbl[tbl$valid_from <= version_date &
        (is.na(tbl$valid_to) | tbl$valid_to >= version_date), ]
}

# Internal: resolve version = NULL to latest; abort on unknown version
.resolve_ct_version <- function(version, ct_type) {
  avail <- available_ct_versions(ct_type)
  if (is.null(version)) return(as.Date(avail[[1L]]))
  version_date <- tryCatch(as.Date(version), error = function(e) NULL)
  if (is.null(version_date) || !as.character(version_date) %in% avail) {
    stop(paste0(
      "Version '", version, "' is not available. ",
      "Available versions: ", paste(avail, collapse = ", "), "."
    ))
  }
  version_date
}

# Internal: resolve schema/stylesheet version from disk; NULL returns latest
.resolve_schema_version <- function(version) {
  schema_dir <- .sys_file("extdata", "schema", package = "cdiscdata")
  dirs <- .list_dirs(schema_dir)
  avail <- sort(
    sub("^define-xml-", "", dirs[grepl("^define-xml-", dirs)]),
    decreasing = TRUE
  )
  if (length(avail) == 0L) {
    stop("No Define-XML schemas found in package.")
  }
  if (is.null(version)) return(avail[[1L]])
  if (!version %in% avail) {
    stop(paste0(
      "Version '", version, "' is not available for Define-XML schemas/stylesheets. ",
      "Available versions: ", paste(avail, collapse = ", "), "."
    ))
  }
  version
}
