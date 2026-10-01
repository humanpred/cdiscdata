# List all available datasets in cdiscdata

List all available datasets in cdiscdata

## Usage

``` r
list_datasets()
```

## Value

A data frame with one row per dataset describing its type, version
range, and latest available version.

## Examples

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
```
