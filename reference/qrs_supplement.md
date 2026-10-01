# CDISC QRS supplement item metadata

One row per item of each of nine questionnaire, rating-scale, and
functional-test (QRS) instrument supplements: AIMS (2.0), APACHE_II
(1.0), ATLAS (1.0), CGI (2.1), HAM-A (2.1), KFSS (2.0), KPS_SCALE (2.0),
PGI (1.1), and SIX_MINUTE_WALK (1.0). Built from CDISC Library CSV
exports not redistributed with this package (see
[`ig_sources`](https://humanpred.github.io/cdiscdata/reference/ig_sources.md));
only the identifiers that map an item to SDTM controlled terminology are
carried, not the item text. Reach it with
`get_dataset("qrs_supplement")`.

## Usage

``` r
qrs_supplement
```

## Format

A data frame with columns:

- instrument:

  The instrument, as in the file name, e.g. `"HAM-A"`,
  `"SIX_MINUTE_WALK"`.

- version:

  The supplement's version, e.g. `"2.1"`.

- item_order:

  Position of the item within the instrument.

- test_name:

  The item's `--TEST` value, e.g.
  `"AIMS01-Muscles of Facial Expression"`; at most 40 characters.

- testcd_codelist_code:

  C-code of the `--TESTCD` codelist for the instrument.

- testcd_code:

  The item's `--TESTCD` term C-code.

- test_codelist_code:

  C-code of the `--TEST` codelist for the instrument.

- test_code:

  The item's `--TEST` term C-code.

- response_group:

  The response (value list) group the item uses, or `NA` for the few
  items that have none.

## Source

CDISC Library CSV exports, downloaded under CDISC's terms and not
redistributed; see `data-raw/README.md`.

## Details

The exports have no `Version` column; `instrument` and `version` are
taken from the file name (`HAM-A_Supplement_v2.1.csv`). A (instrument,
version, item_order) is unique.
