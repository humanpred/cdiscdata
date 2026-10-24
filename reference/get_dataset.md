# Retrieve any cdiscdata dataset by name and version

Generic retrieval gateway. For CT datasets, filters to rows valid at the
requested version date. For the implementation-guide, model, CDASH, and
QRS datasets (`ig_sdtm`, `model_sdtm`, `ig_adam`, `cdash_model`,
`ig_cdash`, `qrs_supplement`), returns the whole table, or the rows
whose `version` column equals `version` (across every standard or
instrument in it; use
[`get_ig`](https://humanpred.github.io/cdiscdata/reference/get_ig.md) or
[`get_cdash`](https://humanpred.github.io/cdiscdata/reference/get_cdash.md)
to pick one standard). For schemas and stylesheets, returns the file
path for the requested Define-XML version. Use
[`list_datasets`](https://humanpred.github.io/cdiscdata/reference/list_datasets.md)
to see available dataset names.

## Usage

``` r
get_dataset(name, version = NULL)
```

## Arguments

- name:

  Dataset name from
  [`list_datasets`](https://humanpred.github.io/cdiscdata/reference/list_datasets.md)`()$dataset`.

- version:

  Version string. For CT, `NULL` returns the latest available version
  and a value is a date string e.g. `"2024-09-27"`. For
  schemas/stylesheets, `NULL` is the latest and a value is a Define-XML
  version string e.g. `"2.1"`. For the IG, model, CDASH, and QRS
  datasets, `NULL` returns every version.

## Value

A data frame (for CT, IG, model, CDASH, and QRS data) or a file path
string (for schemas/stylesheets).

## Examples

``` r
ct <- get_dataset("ct_sdtm")
head(ct)
#>    codelist_code codelist_name            codelist_label extensible term_code
#> 13       C100129         QSCAT Category of Questionnaire       TRUE      <NA>
#> 18       C100129         QSCAT Category of Questionnaire         NA   C100759
#> 23       C100129         QSCAT Category of Questionnaire         NA   C100760
#> 42       C100129         QSCAT Category of Questionnaire         NA   C100764
#> 47       C100129         QSCAT Category of Questionnaire         NA   C100765
#> 52       C100129         QSCAT Category of Questionnaire         NA   C100766
#>               term
#> 13            <NA>
#> 18             BPI
#> 23  BPI SHORT FORM
#> 42            COMM
#> 47 C-SSRS BASELINE
#> 52            FPSR
#>                                                    decoded_value
#> 13                      CDISC Questionnaire Category Terminology
#> 18                            Brief Pain Inventory Questionnaire
#> 23                 Brief Pain Inventory Short Form Questionnaire
#> 42                   Current Opioid Misuse Measure Questionnaire
#> 47 Columbia-Suicide Severity Rating Scale Baseline Questionnaire
#> 52                        Faces Pain Scale Revised Questionnaire
#>                     synonyms
#> 13 Category of Questionnaire
#> 18                      BPI1
#> 23                      BPI2
#> 42                     COMM1
#> 47                     CSS01
#> 52                     FPSR1
#>                                                                                                                                                                                                                                                                        definition
#> 13                                                                                                                                                                                                                   A grouping of observations within the Questionnaires domain.
#> 18                                                                                                                                                                 Brief Pain Inventory (BPI) (copyright 1991 Charles S. Cleeland, PhD, Pain Research Group, All Right Reserved).
#> 23                                                                                                                                                     Brief Pain Inventory Short Form (BPI2) (copyright 1991 Charles S. Cleeland, PhD, Pain Research Group, All Right Reserved).
#> 42                                                                                                                                                                                   Current Opioid Misuse Measure (COMM) (copyright 2010 Inflexxion, Inc., All rights reserved).
#> 47 Columbia-Suicide Severity Rating Scale (C-SSRS) Baseline Version 2009-01-14 (Posner, K.; Brent, D.; Lucas, C.; Gould, M.; Stanley, B.; Brown, G.; Fisher, P.; Zelazny, J.; Burke, A.; Oquendo, M.; Mann, J.; copyright 2008 The Research Foundation for Mental Hygiene, Inc.).
#> 52                                                                              Faces Pain Scale - Revised (FPS-R) (Hicks CL, von Baeyer CL, van Korlaar I, Goodenough B. Faces Pain Scale-Revised: Toward a Common Metric in Pediatric Pain Measurement. Pain 2001; 93:173-183).
#>    valid_from valid_to
#> 13 2017-06-30     <NA>
#> 18 2019-09-27     <NA>
#> 23 2019-09-27     <NA>
#> 42 2019-09-27     <NA>
#> 47 2019-09-27     <NA>
#> 52 2019-09-27     <NA>
ct_2024 <- get_dataset("ct_sdtm", version = "2024-09-27")
nrow(ct_2024)
#> [1] 43976
ig_adam_1_3 <- get_dataset("ig_adam", version = "1.3")
nrow(ig_adam_1_3)
#> [1] 336
get_dataset("define_xml_schema", version = "2.1")
#> [1] "/home/runner/work/_temp/Library/cdiscdata/extdata/schema/define-xml-2.1/define2-1-0.xsd"
get_dataset("define_xml_stylesheet", version = "2.0")
#> [1] "/home/runner/work/_temp/Library/cdiscdata/extdata/stylesheet/define2-0-0.xsl"
```
