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
```
