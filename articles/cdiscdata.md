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
#>                 dataset       type ct_type
#> 1               ct_sdtm         CT    sdtm
#> 2               ct_adam         CT    adam
#> 3               ig_sdtm         IG    <NA>
#> 4               ig_adam         IG    <NA>
#> 5     define_xml_schema     Schema    <NA>
#> 6 define_xml_stylesheet Stylesheet    <NA>
#>                             description                      versions
#> 1           SDTM Controlled Terminology      2007-03-06 to 2026-09-25
#> 2           ADaM Controlled Terminology      2010-03-05 to 2026-09-25
#> 3 SDTM Model + SDTMIG variable metadata Model 1.4 to 1.7 (SDTMIG 3.2)
#> 4   ADaMIG ADSL + BDS variable metadata                    1.0 to 1.2
#> 5                Define-XML XSD schemas                    2.0 to 2.1
#> 6           Define-XML XSLT stylesheets                    2.0 to 2.1
#>   n_versions     latest last_updated
#> 1         84 2026-09-25   2026-09-30
#> 2         27 2026-09-25   2026-09-30
#> 3          5        1.7   2026-09-30
#> 4          3        1.2   2026-09-30
#> 5          2        2.1   2026-09-30
#> 6          2        2.1   2026-09-30
cdiscdata_versions()
#>                 dataset       type                           description
#> 1               ct_sdtm         CT           SDTM Controlled Terminology
#> 2               ct_adam         CT           ADaM Controlled Terminology
#> 3               ig_sdtm         IG SDTM Model + SDTMIG variable metadata
#> 4               ig_adam         IG   ADaMIG ADSL + BDS variable metadata
#> 5     define_xml_schema     Schema                Define-XML XSD schemas
#> 6 define_xml_stylesheet Stylesheet           Define-XML XSLT stylesheets
#>       latest n_versions last_updated
#> 1 2026-09-25         84   2026-09-30
#> 2 2026-09-25         27   2026-09-30
#> 3        1.7          5   2026-09-30
#> 4        1.2          3   2026-09-30
#> 5        2.1          2   2026-09-30
#> 6        2.1          2   2026-09-30
```

## Controlled Terminology

Retrieve the latest CT:

``` r

ct <- get_ct("sdtm")
nrow(ct)
#> [1] 47242
head(ct[, c("codelist_code", "codelist_name", "term", "decoded_value")])
#>    codelist_code codelist_name            term
#> 13       C100129         QSCAT            <NA>
#> 18       C100129         QSCAT             BPI
#> 23       C100129         QSCAT  BPI SHORT FORM
#> 42       C100129         QSCAT            COMM
#> 47       C100129         QSCAT C-SSRS BASELINE
#> 52       C100129         QSCAT            FPSR
#>                                                    decoded_value
#> 13                      CDISC Questionnaire Category Terminology
#> 18                            Brief Pain Inventory Questionnaire
#> 23                 Brief Pain Inventory Short Form Questionnaire
#> 42                   Current Opioid Misuse Measure Questionnaire
#> 47 Columbia-Suicide Severity Rating Scale Baseline Questionnaire
#> 52                        Faces Pain Scale Revised Questionnaire
```

Retrieve a specific historical version:

``` r

versions <- available_ct_versions("sdtm")
head(versions)
#> [1] "2026-09-25" "2026-03-27" "2025-09-26" "2025-03-28" "2024-09-27"
#> [6] "2024-03-29"

# Get CT as it was at the second-most-recent release
if (length(versions) >= 2) {
  ct_old <- get_ct("sdtm", version = versions[[2]])
  nrow(ct_old)
}
#> [1] 46774
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
#> [1] 47242
head(ct_via_generic[, c("codelist_code", "term", "valid_from", "valid_to")])
#>    codelist_code            term valid_from valid_to
#> 13       C100129            <NA> 2017-06-30     <NA>
#> 18       C100129             BPI 2019-09-27     <NA>
#> 23       C100129  BPI SHORT FORM 2019-09-27     <NA>
#> 42       C100129            COMM 2019-09-27     <NA>
#> 47       C100129 C-SSRS BASELINE 2019-09-27     <NA>
#> 52       C100129            FPSR 2019-09-27     <NA>
```
