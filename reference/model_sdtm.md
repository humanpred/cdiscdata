# SDTM model variable metadata

One row per variable of the CDISC SDTM model, at every version: 1.2,
1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 2.0, and 2.1. Built from CDISC Library CSV
exports not redistributed with this package (see
[`ig_sources`](https://humanpred.github.io/cdiscdata/reference/ig_sources.md));
only variable metadata is carried, not the model's descriptions,
definitions, notes, or examples. Retrieve it with
[`get_ig`](https://humanpred.github.io/cdiscdata/reference/get_ig.md)`("SDTM")`.

## Usage

``` r
model_sdtm
```

## Format

A data frame with columns:

- standard:

  Always `"SDTM"`.

- version:

  Model version, e.g. `"2.1"`.

- class:

  Observation class or dataset class, e.g. `"Findings"`,
  `"Trial Design"`.

- dataset:

  Dataset name, or `NA` for class-level variables.

- order:

  Position within the class/dataset, as published.

- variable:

  Variable name, e.g. `"--TESTCD"`.

- label:

  Variable label. `"--TESTCD"` is published at 46 characters in model
  versions 1.2 to 1.6.

- type:

  `"Char"` or `"Num"`.

- role:

  CDISC variable role.

- described_value_domain:

  A described value domain, e.g. `"ISO 8601"`; sparse before version
  2.0.

- variables_qualified:

  The variable(s) this one qualifies.

- usage_restrictions:

  Usage restrictions on the variable; version 2.0 and later, `NA`
  before.

- variable_code:

  The variable's NCI C-code; version 2.0 and later, `NA` before.

## Source

CDISC Library CSV exports, downloaded under CDISC's terms and not
redistributed; see `data-raw/README.md`.

## Details

A (standard, version, class, dataset, variable) is unique. `dataset` is
`NA` for the general-observation-class variables (Events, Findings,
...), which are defined once per class with a `--` prefix, and set for
the datasets the model defines outright (e.g. `"DM"`).
