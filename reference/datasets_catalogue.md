# Datasets catalogue

Metadata about all datasets bundled in `cdiscdata`, including CT tables
and Define-XML file-based assets.

## Usage

``` r
datasets_catalogue
```

## Format

A data frame with columns:

- dataset:

  R object name or logical dataset identifier.

- type:

  One of `"CT"`, `"Schema"`, `"Stylesheet"`.

- ct_type:

  One of `"sdtm"`, `"adam"`, or `NA` for non-CT datasets.

- description:

  Human-readable description.

- versions:

  Human-readable version range string.

- n_versions:

  Number of distinct versions available.

- latest:

  Most recent version string.

- last_updated:

  Date this catalogue row was last refreshed.
