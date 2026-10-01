# Summarise all bundled data versions

Summarise all bundled data versions

## Usage

``` r
cdiscdata_versions()
```

## Value

A data frame with one row per data type showing the latest version,
number of versions available, and when the data was last updated.

## Examples

``` r
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
