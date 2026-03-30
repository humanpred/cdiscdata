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
```
