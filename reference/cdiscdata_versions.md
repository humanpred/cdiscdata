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
