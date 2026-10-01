# CDASH implementation-guide variable metadata

One row per variable of every domain and data collection scenario of the
CDASH implementation guide (CDASHIG), at every version: 1.1, 2.0, 2.1,
2.2, and 2.3. Built from CDISC Library CSV exports not redistributed
with this package (see
[`ig_sources`](https://humanpred.github.io/cdiscdata/reference/ig_sources.md));
only variable metadata and the collection wording (question text,
prompt) is carried, not the guide's definitions, CRF completion
instructions, mapping instructions, or implementation notes. Retrieve it
with
[`get_cdash`](https://humanpred.github.io/cdiscdata/reference/get_cdash.md).

## Usage

``` r
ig_cdash
```

## Format

A data frame with columns:

- standard:

  Always `"CDASHIG"`.

- version:

  Guide version, e.g. `"2.3"`.

- class:

  General observation class, e.g. `"Findings"`.

- domain:

  Domain, e.g. `"LB"`.

- scenario:

  The data collection scenario or implementation option the row belongs
  to (e.g. `"Local Processing"`), or `NA` for variables common to the
  domain.

- order:

  Position within the domain and scenario, as published.

- variable:

  CDASHIG variable name, e.g. `"LBORRES"`.

- label:

  Variable label. Not published in version 1.1 (`NA` for all of its
  rows); at most 40 characters except for 71 labels in version 2.0,
  which the guide publishes longer.

- question_text:

  The CRF question text the guide suggests.

- prompt:

  The CRF field prompt the guide suggests.

- type:

  As published: `"Char"`, `"Num"`, `"Date (dd-MON-yyyy)"`, or
  `"Time (24 hour)"`.

- core:

  CDASHIG Core designation, as published: `"HR"` (highly recommended),
  `"R/C"` (recommended or conditional), or `"O"` (optional).

- sdtmig_target:

  The SDTMIG variable the collected value maps to.

- codelist_code:

  The CDISC CT codelist C-code(s) or subset code(s) the variable uses;
  `NA` when none.

- codelist_submission_value:

  The codelist submission value, where the export gives one.

## Source

CDISC Library CSV exports, downloaded under CDISC's terms and not
redistributed; see `data-raw/README.md`.

## Details

A (standard, version, domain, scenario, variable) is unique.
