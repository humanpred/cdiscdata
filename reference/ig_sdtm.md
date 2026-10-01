# SDTM implementation-guide variable metadata

Versioned SDTM Model and SDTMIG variable metadata: the Model's Findings
general-observation-class variables (versions 1.4-1.7), the SDTMIG PP
domain, and the SDTMIG generic SUPP– qualifier structure (used for
SUPPPP; version 3.2 only - see `data-raw/ig_source/README.md` for why no
newer SDTMIG version's PP/SUPP– tables were available to source). Use
[`get_ig`](https://humanpred.github.io/cdiscdata/reference/get_ig.md) to
retrieve it, and
[`build_domain_spec`](https://humanpred.github.io/cdiscdata/reference/build_domain_spec.md)
to build a ready-to-use PP/SUPPPP/ADPP variable spec from it (joined to
CT for codelist ids).

## Usage

``` r
ig_sdtm
```

## Format

A data frame with columns:

- source:

  `"SDTM_MODEL"` or `"SDTMIG"`.

- version:

  SDTM Model version (`"1.4"`-`"1.7"`) for `source == "SDTM_MODEL"`
  rows; SDTMIG version (`"3.2"`) for `source == "SDTMIG"` rows. The two
  are independent numbering systems; see
  [`get_ig`](https://humanpred.github.io/cdiscdata/reference/get_ig.md).

- class:

  General observation class, e.g. `"Findings"`. `NA` for `SDTMIG` rows.

- domain:

  `"PP"` or `"SUPPQUAL"` for `SDTMIG` rows. `NA` for `SDTM_MODEL` rows.

- order:

  Row order within its source table, as published.

- variable:

  Variable name, e.g. `"PPTESTCD"`.

- label:

  Variable label.

- type:

  `"Char"` or `"Num"`.

- role:

  CDISC variable role, e.g. `"Topic"`. `NA` for ADaM rows (not
  applicable, and not present in `ig_adam`).

- core:

  SDTMIG Core designation (`"Req"`/`"Exp"`/ `"Perm"`). `NA` for
  `SDTM_MODEL` rows (the model does not designate Core; that is an
  IG-level concept).

- codelist:

  Codelist submission value referenced by this variable (e.g.
  `"PKPARMCD"`), parsed from the IG's free-text "Controlled Terms"
  column. Look up its codelist C-code via
  [`get_ct`](https://humanpred.github.io/cdiscdata/reference/get_ct.md)'s
  `codelist_name`/`codelist_code` columns, as
  [`build_domain_spec`](https://humanpred.github.io/cdiscdata/reference/build_domain_spec.md)
  does. `NA` when the variable has no codelist, or the column instead
  names a format (e.g. "ISO 8601") or an unspecified extensible list
  ("\*").

- length:

  Maximum character length, when the IG text states one explicitly (e.g.
  PPTESTCD's 8-character limit); `NA` otherwise, since CDISC
  implementation guides do not otherwise publish a Length column (length
  is a sponsor/define.xml choice).

- notes:

  CDISC Notes / Description text for the variable.

## Source

<https://github.com/humanpred/Rsdtm>; see `data-raw/ig_source/README.md`
for full attribution.
