# ADaM implementation-guide variable metadata

Versioned ADaMIG variable metadata: the ADSL (subject-level) variable
table and the generic BDS (Basic Data Structure) variable table (used
for ADPP, a BDS-structured dataset), for ADaMIG versions 1.0, 1.1, and
1.2. Use
[`get_ig`](https://humanpred.github.io/cdiscdata/reference/get_ig.md) to
retrieve it, and
[`build_domain_spec`](https://humanpred.github.io/cdiscdata/reference/build_domain_spec.md)
to build a ready-to-use ADPP variable spec from it (joined to CT for
codelist ids).

## Usage

``` r
ig_adam
```

## Format

A data frame with columns:

- dataset:

  `"ADSL"` or `"BDS"`.

- version:

  ADaMIG version, e.g. `"1.2"`.

- category:

  The Rsdtm source file's variable-category name (e.g.
  `"ADSL_Treatment_Variables"`, `"Timing_Variables_BDS_Datasets"`), kept
  for provenance; ADaMIG itself does not group these tables this way.

- order:

  Row order within its category file, as published.

- variable:

  Variable name, e.g. `"AVAL"`.

- label:

  Variable label.

- type:

  `"Char"` or `"Num"`.

- core:

  ADaMIG Core designation (`"Req"`/`"Exp"`/ `"Perm"`/`"Cond"`).

- codelist:

  Codelist submission value referenced by this variable, parsed the same
  way as
  [`ig_sdtm`](https://humanpred.github.io/cdiscdata/reference/ig_sdtm.md)'s
  `codelist` column; see there for details and caveats.

- length:

  Maximum character length when the IG text states one explicitly; `NA`
  otherwise. See
  [`ig_sdtm`](https://humanpred.github.io/cdiscdata/reference/ig_sdtm.md).

- notes:

  CDISC Notes text for the variable.

## Source

<https://github.com/humanpred/Rsdtm>; see `data-raw/ig_source/README.md`
for full attribution.
