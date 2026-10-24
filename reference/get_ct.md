# Retrieve CDISC Controlled Terminology

Convenience wrapper around
[`get_dataset`](https://humanpred.github.io/cdiscdata/reference/get_dataset.md)
for CT data.

## Usage

``` r
get_ct(type = c("sdtm", "adam"), version = NULL)
```

## Arguments

- type:

  One of `"sdtm"` or `"adam"`.

- version:

  CT version date string e.g. `"2024-09-27"`. `NULL` returns the latest
  available version.

## Value

A data frame of CT terms valid at the requested version.

## Examples

``` r
ct <- get_ct("sdtm")
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
ct_2024 <- get_ct("sdtm", version = "2024-09-27")
nrow(ct_2024)
#> [1] 43976
head(get_ct("adam"))
#>    codelist_code codelist_name
#> 17       C124296      SBJTSTAT
#> 18       C124296      SBJTSTAT
#> 21       C124296      SBJTSTAT
#> 22       C124296      SBJTSTAT
#> 23       C158114       GDS02PC
#> 26       C158114       GDS02PC
#>                                                        codelist_label
#> 17                                               Subject Trial Status
#> 18                                               Subject Trial Status
#> 21                                               Subject Trial Status
#> 22                                               Subject Trial Status
#> 23 Geriatric Depression Scale Short Form Questionnaire Parameter Code
#> 26 Geriatric Depression Scale Short Form Questionnaire Parameter Code
#>    extensible term_code         term
#> 17       TRUE      <NA>         <NA>
#> 18         NA    C25250    COMPLETED
#> 21         NA    C25484 DISCONTINUED
#> 22         NA    C53279      ONGOING
#> 23      FALSE      <NA>         <NA>
#> 26         NA   C158155      GDS02TS
#>                                                                                decoded_value
#> 17                                               CDISC ADaM Subject Trial Status Terminology
#> 18                                                                                  Complete
#> 21                                                                               Discontinue
#> 22                                                                                  Continue
#> 23 CDISC ADaM Geriatric Depression Scale Short Form Questionnaire Parameter Code Terminology
#> 26                          Geriatric Depression Scale Short Form - Total Score for Analysis
#>                                                              synonyms
#> 17                                               Subject Trial Status
#> 18                                                                   
#> 21                                                                   
#> 22                                                         Continuous
#> 23 Geriatric Depression Scale Short Form Questionnaire Parameter Code
#> 26                                       GDS02-Total Score - Analysis
#>                                                                                                                                          definition
#> 17                                                                                                Indicates the status of the subject in the trial.
#> 18                               To possess every necessary or normal part or component or step; having come or been brought to a conclusion. (NCI)
#> 21                                                                                                      To stop or end, permanently or temporarily.
#> 22   Remain in force or carry on without letup; keep or maintain in unaltered condition; exist in time or space without stop or interruption. (NCI)
#> 23 A parameter code codelist for the Geriatric Depression Scale Short Form questionnaire (GDS02) to support the calculation of total score in ADaM.
#> 26                                                                           Geriatric Depression Scale Short Form - Total score used for analysis.
#>    valid_from valid_to
#> 17 2016-03-25     <NA>
#> 18 2015-12-18     <NA>
#> 21 2019-01-07     <NA>
#> 22 2015-12-18     <NA>
#> 23 2019-03-29     <NA>
#> 26 2022-06-24     <NA>
```
