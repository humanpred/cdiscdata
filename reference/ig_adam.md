# ADaM implementation-guide variable metadata

One row per variable of seven ADaM standards, at every version: ADaMIG
(1.0, 1.1, 1.2, 1.3), ADaMIG-MD (1.0), ADaMIG-NCA (1.0), ADaM-ADAE
(1.0), ADaM-BDS-TTE (1.0), ADaM-OCCDS (1.0, 1.1), and ADaM-popPK (1.0);
11 standard versions in all. Built from CDISC Library CSV exports that
are not part of this package or repository (see
[`ig_sources`](https://humanpred.github.io/cdiscdata/reference/ig_sources.md)
and `data-raw/README.md`); only variable metadata is carried, not the
guides' prose. Use
[`get_ig`](https://humanpred.github.io/cdiscdata/reference/get_ig.md) to
retrieve a standard, and
[`build_domain_spec`](https://humanpred.github.io/cdiscdata/reference/build_domain_spec.md)
to build an ADPP variable spec from it (ADPP is a Basic Data Structure
dataset; ADaMIG-NCA extends it).

## Usage

``` r
ig_adam
```

## Format

A data frame with columns:

- standard:

  The standard, e.g. `"ADaMIG"` or `"ADaMIG-NCA"`.

- version:

  The standard's version, e.g. `"1.3"`.

- structure:

  The data structure, as named in the export, e.g.
  `"Basic Data Structure"` or `"Subject-Level Analysis Dataset"` (ADSL).

- variable_set:

  The variable set within the structure, e.g. `"Timing"`.

- order:

  Row order within the export for that standard version.

- variable:

  Variable name, e.g. `"AVAL"`.

- label:

  Variable label. At most 40 characters except `PBCHGCyN` in ADaMIG 1.2
  and 1.3, which the guide publishes at 41.

- type:

  `"Char"` or `"Num"`.

- core:

  Core designation (`"Req"`, `"Perm"`, `"Cond"`, ...).

- codelist_code:

  CDISC CT codelist C-code(s) the variable uses; several are separated
  by `"; "`. `NA` when none.

- codelist_submission_values:

  The codelist submission value(s), where the export gives them.

- described_value_domain:

  A described value domain, where the variable has one rather than a
  codelist.

- value_list:

  A fixed list of allowed values, where there is one.

## Source

CDISC Library CSV exports, downloaded under CDISC's terms and not
redistributed; see `data-raw/README.md`.

## Details

A (standard, version, structure, variable_set, variable) is unique: the
variable set is part of the key because ADaM-OCCDS defines `DECDORGw`
twice, once for each dictionary-specific variable set, with different
labels.
