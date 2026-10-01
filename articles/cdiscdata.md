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
#>                  dataset       type ct_type
#> 1                ct_sdtm         CT    sdtm
#> 2                ct_adam         CT    adam
#> 3                ig_sdtm         IG    <NA>
#> 4             model_sdtm      Model    <NA>
#> 5                ig_adam         IG    <NA>
#> 6            cdash_model      CDASH    <NA>
#> 7               ig_cdash      CDASH    <NA>
#> 8         qrs_supplement        QRS    <NA>
#> 9      define_xml_schema     Schema    <NA>
#> 10 define_xml_stylesheet Stylesheet    <NA>
#>                                                                    description
#> 1                                                  SDTM Controlled Terminology
#> 2                                                  ADaM Controlled Terminology
#> 3  SDTMIG, SENDIG and related SDTM-side implementation-guide variable metadata
#> 4                                                 SDTM model variable metadata
#> 5               ADaMIG and related ADaM implementation-guide variable metadata
#> 6                                                CDASH model variable metadata
#> 7                       CDASH implementation-guide (CDASHIG) variable metadata
#> 8                                      QRS instrument supplement item metadata
#> 9                                                       Define-XML XSD schemas
#> 10                                                 Define-XML XSLT stylesheets
#>                                                                                                                             versions
#> 1                                                                                                           2007-03-06 to 2026-09-25
#> 2                                                                                                           2010-03-05 to 2026-09-25
#> 3  SDTMIG 3.1.2 to 3.4; SDTMIG-AP 1.0; SDTMIG-MD 1.0 to 1.1; SENDIG 3.0 to 3.1.1; SENDIG-AR 1.0; SENDIG-DART 1.1; SENDIG-GeneTox 1.0
#> 4                                                                                                                    SDTM 1.2 to 2.1
#> 5           ADaMIG 1.0 to 1.3; ADaMIG-MD 1.0; ADaMIG-NCA 1.0; ADaM-ADAE 1.0; ADaM-BDS-TTE 1.0; ADaM-OCCDS 1.0 to 1.1; ADaM-popPK 1.0
#> 6                                                                                                                   CDASH 1.0 to 1.3
#> 7                                                                                                                 CDASHIG 1.1 to 2.3
#> 8                      AIMS 2.0; APACHE_II 1.0; ATLAS 1.0; CGI 2.1; HAM-A 2.1; KFSS 2.0; KPS_SCALE 2.0; PGI 1.1; SIX_MINUTE_WALK 1.0
#> 9                                                                                                                         2.0 to 2.1
#> 10                                                                                                                        2.0 to 2.1
#>    n_versions     latest last_updated
#> 1          84 2026-09-25   2026-09-30
#> 2          27 2026-09-25   2026-09-30
#> 3          14       <NA>   2026-09-30
#> 4           9       <NA>   2026-09-30
#> 5          11       <NA>   2026-09-30
#> 6           4       <NA>   2026-09-30
#> 7           5       <NA>   2026-09-30
#> 8           9       <NA>   2026-09-30
#> 9           2        2.1   2026-09-30
#> 10          2        2.1   2026-09-30
cdiscdata_versions()
#>                  dataset       type
#> 1                ct_sdtm         CT
#> 2                ct_adam         CT
#> 3                ig_sdtm         IG
#> 4             model_sdtm      Model
#> 5                ig_adam         IG
#> 6            cdash_model      CDASH
#> 7               ig_cdash      CDASH
#> 8         qrs_supplement        QRS
#> 9      define_xml_schema     Schema
#> 10 define_xml_stylesheet Stylesheet
#>                                                                    description
#> 1                                                  SDTM Controlled Terminology
#> 2                                                  ADaM Controlled Terminology
#> 3  SDTMIG, SENDIG and related SDTM-side implementation-guide variable metadata
#> 4                                                 SDTM model variable metadata
#> 5               ADaMIG and related ADaM implementation-guide variable metadata
#> 6                                                CDASH model variable metadata
#> 7                       CDASH implementation-guide (CDASHIG) variable metadata
#> 8                                      QRS instrument supplement item metadata
#> 9                                                       Define-XML XSD schemas
#> 10                                                 Define-XML XSLT stylesheets
#>        latest n_versions last_updated
#> 1  2026-09-25         84   2026-09-30
#> 2  2026-09-25         27   2026-09-30
#> 3        <NA>         14   2026-09-30
#> 4        <NA>          9   2026-09-30
#> 5        <NA>         11   2026-09-30
#> 6        <NA>          4   2026-09-30
#> 7        <NA>          5   2026-09-30
#> 8        <NA>          9   2026-09-30
#> 9         2.1          2   2026-09-30
#> 10        2.1          2   2026-09-30
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
