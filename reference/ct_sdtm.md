# SDTM Controlled Terminology

Versioned CDISC SDTM Controlled Terminology from the NCI EVS FTP site.
Uses a validity-date design: one row per unique term-state across all
versions. A term is "current" when `valid_to` is `NA`.

## Usage

``` r
ct_sdtm
```

## Format

A data frame with columns:

- codelist_code:

  NCI C-code for the codelist, e.g. `"C66731"`.

- codelist_name:

  Submission value for the codelist, e.g. `"SEX"`.

- codelist_label:

  Long name, e.g. `"Sex"`.

- extensible:

  Logical; whether sponsor extensions are allowed.

- term_code:

  NCI C-code for the term, e.g. `"C16576"`. `NA` for codelist-level
  rows.

- term:

  Submission value, e.g. `"F"`. `NA` for codelist-level rows.

- decoded_value:

  NCI preferred term / decoded value, e.g. `"Female"`.

- synonyms:

  Pipe-separated synonyms.

- definition:

  NCI definition text.

- valid_from:

  Date of the first CT release in which this row's content appeared.

- valid_to:

  Date of the last CT release in which this row's content was present;
  `NA` if still current.

## Source

<https://evs.nci.nih.gov/ftp1/CDISC/SDTM/>
