#' Retrieve any cdiscdata dataset by name and version
#'
#' Generic retrieval gateway. For CT datasets, filters to rows valid at
#' the requested version date. For schemas and stylesheets, returns the
#' file path for the requested Define-XML version. Use \code{\link{list_datasets}}
#' to see available dataset names.
#'
#' @param name Dataset name from \code{\link{list_datasets}()$dataset}.
#' @param version Version string. \code{NULL} returns the latest available
#'   version. For CT: a date string e.g. \code{"2024-09-27"}. For
#'   schemas/stylesheets: a Define-XML version string e.g. \code{"2.1"}.
#' @return A data frame (for CT data) or a file path string (for
#'   schemas/stylesheets).
#' @export
#' @examples
#' get_dataset("ct_sdtm")
#' get_dataset("ct_sdtm", version = "2024-09-27")
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

  cat_row <- datasets_catalogue[datasets_catalogue$dataset == name, ]

  switch(cat_row$type,
    "CT"         = .get_ct_dataset(name, version),
    "Schema"     = schema_path(.resolve_schema_version(version)),
    "Stylesheet" = stylesheet_path(.resolve_schema_version(version))
  )
}

# Internal: filter CT table to a specific version date
.get_ct_dataset <- function(name, version) {
  tbl <- get(name, envir = asNamespace("cdiscdata"))
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
  schema_dir <- system.file("extdata", "schema", package = "cdiscdata")
  dirs <- list.dirs(schema_dir, full.names = FALSE, recursive = FALSE)
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
