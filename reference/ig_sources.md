# The CDISC Library exports the datasets were built from

One row per export file read by `data-raw/build_ig.R`, so which standard
versions are bundled, and from exactly which files, is itself data. The
files are not part of this package or repository.

## Usage

``` r
ig_sources
```

## Format

A data frame with 52 rows (34 implementation-guide and model exports, 9
CDASH, 9 QRS supplements) and columns:

- file:

  The export's file name.

- version_string:

  The export's `Version` value, e.g. `"ADaMIG MD v1.0"`; `NA` for the
  QRS supplements, whose exports have none.

- standard:

  The canonical standard name parsed from the version string (for a QRS
  supplement, the instrument parsed from the file name).

- version:

  The version number parsed from the version string (for a QRS
  supplement, from the file name).

- table:

  The dataset it was loaded into: `"ig_sdtm"`, `"model_sdtm"`,
  `"ig_adam"`, `"cdash_model"`, `"ig_cdash"`, or `"qrs_supplement"`.

- rows:

  Data rows in the file, equal to the rows loaded from it.

- md5:

  MD5 checksum of the file, to tell whether a rebuild used the same
  export.

## Source

CDISC Library CSV exports; see `data-raw/README.md`.
