# CDASH model variable metadata

One row per variable of the CDISC Clinical Data Acquisition Standards
Harmonization (CDASH) model, at every version: 1.0, 1.1, 1.2, and 1.3.
Built from CDISC Library CSV exports not redistributed with this package
(see
[`ig_sources`](https://humanpred.github.io/cdiscdata/reference/ig_sources.md));
only variable metadata and the collection wording (question text,
prompt) is carried, not the model's definitions, mapping instructions,
or implementation notes. Retrieve it with
[`get_cdash`](https://humanpred.github.io/cdiscdata/reference/get_cdash.md)`("CDASH")`.

## Usage

``` r
cdash_model
```

## Format

A data frame with columns:

- standard:

  Always `"CDASH"`.

- version:

  Model version, e.g. `"1.3"`.

- class:

  Observation or special-purpose class, e.g. `"Findings"`,
  `"Identifiers"`.

- domain:

  The domain a domain-specific variable belongs to (e.g. `"AE"`), or
  `NA` for class-level variables.

- order:

  Position within the class and domain, as published.

- variable:

  CDASH variable name, e.g. `"--TERM"`.

- label:

  Variable label. At most 40 characters except for 6 labels the model
  publishes longer (`--TESTCD` in 1.0 and 1.1; `--ENDATF` in all four
  versions).

- domain_specific:

  `TRUE` where the model flags the variable as domain specific; `NA`
  where it does not say.

- question_text:

  The CRF question text the model suggests.

- prompt:

  The CRF field prompt the model suggests.

- type:

  `"Char"` or `"Num"`.

- sdtm_target:

  The SDTM variable or variables the collected value maps to.

- codelist_code:

  The CDISC CT codelist C-code the variable uses; `NA` when none.

## Source

CDISC Library CSV exports, downloaded under CDISC's terms and not
redistributed; see `data-raw/README.md`.

## Details

A (standard, version, class, domain, variable) is unique. The model
defines most variables once per class with a `--` prefix (`domain` is
`NA`) and some per domain.
