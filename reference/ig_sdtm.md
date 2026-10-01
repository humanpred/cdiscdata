# SDTM-side implementation-guide variable metadata

One row per variable of every domain of seven implementation-guide
standards, at every version: SDTMIG (3.1.2, 3.1.3, 3.2, 3.3, 3.4),
SDTMIG-AP (1.0), SDTMIG-MD (1.0, 1.1), SENDIG (3.0, 3.1, 3.1.1),
SENDIG-AR (1.0), SENDIG-DART (1.1), and SENDIG-GeneTox (1.0); 14
standard versions in all. Built from CDISC Library CSV exports that are
not part of this package or repository (see
[`ig_sources`](https://humanpred.github.io/cdiscdata/reference/ig_sources.md)
and `data-raw/README.md`); only variable metadata is carried, not the
guides' prose. Use
[`get_ig`](https://humanpred.github.io/cdiscdata/reference/get_ig.md) to
retrieve a standard, and
[`build_domain_spec`](https://humanpred.github.io/cdiscdata/reference/build_domain_spec.md)
to build a ready-to-use PP/SUPPPP/ADPP variable spec from it. The SDTM
model itself is in
[`model_sdtm`](https://humanpred.github.io/cdiscdata/reference/model_sdtm.md).

## Usage

``` r
ig_sdtm
```

## Format

A data frame with columns:

- standard:

  The standard, e.g. `"SDTMIG"` or `"SENDIG-AR"`.

- version:

  The standard's version, e.g. `"3.4"`.

- class:

  General observation class, e.g. `"Findings"`.

- domain:

  Domain, e.g. `"PP"`, `"LB"`, `"SUPPQUAL"`.

- order:

  Position within the domain, as published.

- variable:

  Variable name, e.g. `"PPTESTCD"`.

- label:

  Variable label. At most 40 characters except for 22 labels the guides
  themselves publish longer (see the data-integrity tests).

- type:

  `"Char"` or `"Num"`.

- role:

  CDISC variable role, e.g. `"Topic"`.

- core:

  Core designation (`"Req"`, `"Exp"`, `"Perm"`, `"Cond"`, or the
  published `"Not used"`).

- codelist_code:

  CDISC CT codelist C-code(s) the variable uses, as published; several
  are separated by `"; "` (e.g. PPORRESU lists PKUNIT and four
  normalised-unit codelists). `NA` when none.

- codelist_submission_values:

  The codelist submission value(s), where the export gives them (the
  SEND guides do; the SDTMIG exports do not, so look the code up in
  [`get_ct`](https://humanpred.github.io/cdiscdata/reference/get_ct.md)).

- described_value_domain:

  A described value domain such as `"ISO 8601"`, where the variable has
  one rather than a codelist.

- value_list:

  A fixed list of allowed values, e.g. the domain abbreviation for
  `DOMAIN`.

## Source

CDISC Library CSV exports, downloaded under CDISC's terms and not
redistributed; see `data-raw/README.md`.

## Details

A (standard, version, domain, variable) is unique.
