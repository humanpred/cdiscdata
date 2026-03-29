# Download CDISC XSLT stylesheets for define.html rendering.
# Safe to re-run; existing files are not re-downloaded.
#
# Sources (both publicly available, open-source licensed):
#   Define-XML 2.1: cdisc-org/data-definition-engine (Apache License 2.0)
#   Define-XML 2.0: dbosak01/defineR CRAN package (MIT License)

STYLESHEET_URLS <- c(
  "define2-1-0.xsl" =
    "https://raw.githubusercontent.com/cdisc-org/data-definition-engine/main/src/generators/define/define2-1.xsl",
  "define2-0-0.xsl" =
    "https://raw.githubusercontent.com/dbosak01/defineR/master/inst/extdata/2.0.0/cdisc-xsl/define2-0.xsl"
)

dir.create("inst/extdata/stylesheet", recursive = TRUE, showWarnings = FALSE)

for (fname in names(STYLESHEET_URLS)) {
  dest <- file.path("inst/extdata/stylesheet", fname)
  if (!file.exists(dest)) {
    message(sprintf("Downloading stylesheet %s...", fname))
    download.file(STYLESHEET_URLS[[fname]], dest, quiet = TRUE, mode = "wb")
  }
}
message("Stylesheets are in place.")
