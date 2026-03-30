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
