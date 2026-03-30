# Getting Started with cdiscdata

## Overview

`cdiscdata` provides versioned CDISC reference data as a standard R
package:

- **Controlled Terminology (CT)**: SDTM and ADaM CT from the NCI EVS FTP
  site, all historical versions in a single compact table.
- **Define-XML schemas (XSD)**: For validating define.xml files.
- **XSLT stylesheets**: For rendering define.xml as HTML.

## Discovering what is available

``` r
list_datasets()
#>                 dataset       type ct_type                 description
#> 1               ct_sdtm         CT    sdtm SDTM Controlled Terminology
#> 2               ct_adam         CT    adam ADaM Controlled Terminology
#> 3     define_xml_schema     Schema    <NA>      Define-XML XSD schemas
#> 4 define_xml_stylesheet Stylesheet    <NA> Define-XML XSLT stylesheets
#>                   versions n_versions     latest last_updated
#> 1 2008-10-09 to 2026-03-27         73 2026-03-27   2026-03-29
#> 2 2010-03-05 to 2026-03-27         26 2026-03-27   2026-03-29
#> 3               2.0 to 2.1          2        2.1   2026-03-29
#> 4               2.0 to 2.1          2        2.1   2026-03-29
cdiscdata_versions()
#>                 dataset       type                 description     latest
#> 1               ct_sdtm         CT SDTM Controlled Terminology 2026-03-27
#> 2               ct_adam         CT ADaM Controlled Terminology 2026-03-27
#> 3     define_xml_schema     Schema      Define-XML XSD schemas        2.1
#> 4 define_xml_stylesheet Stylesheet Define-XML XSLT stylesheets        2.1
#>   n_versions last_updated
#> 1         73   2026-03-29
#> 2         26   2026-03-29
#> 3          2   2026-03-29
#> 4          2   2026-03-29
```

## Controlled Terminology

Retrieve the latest CT:

``` r
ct <- get_ct("sdtm")
nrow(ct)
#> [1] 46774
head(ct[, c("codelist_code", "codelist_name", "term", "decoded_value")])
#>    codelist_code codelist_name     term
#> 4                         <NA>    QSCAT
#> 6                         <NA>   RELSUB
#> 9                         <NA>    ADCTN
#> 12                        <NA>    ADCTC
#> 16                        <NA> BPRSA1TN
#> 20                        <NA> BPRSA1TC
#>                                                         decoded_value
#> 4                            CDISC Questionnaire Category Terminology
#> 6                      CDISC SDTM Relationship to Subject Terminology
#> 9  CDISC Functional Test ADAS-Cog CDISC Version Test Name Terminology
#> 12 CDISC Functional Test ADAS-Cog CDISC Version Test Code Terminology
#> 16  CDISC Clinical Classification BPRS-Anchored Test Name Terminology
#> 20  CDISC Clinical Classification BPRS-Anchored Test Code Terminology
```

Retrieve a specific historical version:

``` r
versions <- available_ct_versions("sdtm")
head(versions)
#> [1] "2026-03-27" "2025-09-26" "2025-03-28" "2024-09-27" "2024-03-29"
#> [6] "2023-12-15"

# Get CT as it was at the second-most-recent release
if (length(versions) >= 2) {
  ct_old <- get_ct("sdtm", version = versions[[2]])
  nrow(ct_old)
}
#> [1] 46011
```

## Define-XML schemas and stylesheets

``` r
schema_path("2.1")
#> [1] "/home/runner/work/_temp/Library/cdiscdata/extdata/schema/define-xml-2.1/define2-1-0.xsd"
stylesheet_path("2.1")
#> [1] "/home/runner/work/_temp/Library/cdiscdata/extdata/stylesheet/define2-1-0.xsl"
```

Use
[`get_dataset()`](https://humanpred.github.io/cdiscdata/reference/get_dataset.md)
as a unified entry point:

``` r
get_dataset("define_xml_schema", version = "2.1")
#> [1] "/home/runner/work/_temp/Library/cdiscdata/extdata/schema/define-xml-2.1/define2-1-0.xsd"

ct_via_generic <- get_dataset("ct_sdtm")
nrow(ct_via_generic)
#> [1] 46774
head(ct_via_generic[, c("codelist_code", "term", "valid_from", "valid_to")])
#>    codelist_code     term valid_from valid_to
#> 4                   QSCAT 2017-06-30     <NA>
#> 6                  RELSUB 2024-09-27     <NA>
#> 9                   ADCTN 2024-09-27     <NA>
#> 12                  ADCTC 2024-09-27     <NA>
#> 16               BPRSA1TN 2022-09-30     <NA>
#> 20               BPRSA1TC 2022-09-30     <NA>
```
