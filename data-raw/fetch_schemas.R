# Download Define-XML XSD schema files.
# Safe to re-run; existing files are not re-downloaded.
#
# Sources (both publicly available, open-source licensed):
#   Define-XML 2.1: cdisc-org/DataExchange-RWD-Lineage (MIT License)
#   Define-XML 2.0: dbosak01/defineR CRAN package (MIT License)

RWD_BASE   <- "https://raw.githubusercontent.com/cdisc-org/DataExchange-RWD-Lineage/main/tools/schema"
DEFR_BASE  <- "https://raw.githubusercontent.com/dbosak01/defineR/master/inst/extdata/2.0.0/cdisc-define-2.0"

SCHEMA_URLS <- list(
  "2.1" = list(
    dir = "inst/extdata/schema/define-xml-2.1",
    files = c(
      "define2-1-0.xsd"         = paste0(RWD_BASE, "/define2-1-0.xsd"),
      "define-enumerations.xsd" = paste0(RWD_BASE, "/define-enumerations.xsd"),
      "define-extension.xsd"    = paste0(RWD_BASE, "/define-extension.xsd"),
      "define-ns.xsd"           = paste0(RWD_BASE, "/define-ns.xsd")
    )
  ),
  "2.0" = list(
    dir = "inst/extdata/schema/define-xml-2.0",
    files = c(
      "define2-0-0.xsd"      = paste0(DEFR_BASE, "/define2-0-0.xsd"),
      "define-extension.xsd" = paste0(DEFR_BASE, "/define-extension.xsd"),
      "define-ns.xsd"        = paste0(DEFR_BASE, "/define-ns.xsd")
    )
  )
)

for (ver in names(SCHEMA_URLS)) {
  spec <- SCHEMA_URLS[[ver]]
  dir.create(spec$dir, recursive = TRUE, showWarnings = FALSE)
  for (fname in names(spec$files)) {
    dest <- file.path(spec$dir, fname)
    if (!file.exists(dest)) {
      message(sprintf("Downloading schema %s (Define-XML %s)...", fname, ver))
      download.file(spec$files[[fname]], dest, quiet = TRUE, mode = "wb")
    }
  }
}
message("XSD schemas are in place.")
