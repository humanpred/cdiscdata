# data-raw

Scripts that build the data in `data/`. Nothing here is part of the installed
package (`data-raw` is in `.Rbuildignore`).

| Script | Builds | Reads |
|--------|--------|-------|
| `fetch_all.R` (with `fetch_ct_*.R`, `fetch_schemas.R`, `fetch_stylesheets.R`) | `ct_sdtm`, `ct_adam`, the Define-XML schemas and stylesheets, and the catalogue | The NCI EVS FTP site (public) |
| `build_ig.R` | `ig_sdtm`, `model_sdtm`, `ig_adam`, `cdash_model`, `ig_cdash`, `qrs_supplement`, `ig_sources` | The 52 CDISC Library CSV exports described below |
| `build_catalogue.R` | `datasets_catalogue` | `data/*.rda` (run it after either of the first two; `fetch_all.R` runs it itself) |

## The CDISC Library exports

The implementation-guide, model, CDASH, and QRS tables are built from CSV
exports of the CDISC Library. **They are not in this repository, are never
committed, and must not be redistributed.** CDISC provides them under its own
terms and conditions (use within the downloader's organization; no copying,
distribution, posting, or derivative works of the material itself). Only the
variable metadata is transcribed into the package data: names, labels, types,
roles, Core designations, codelists, order, and for CDASH the collection
wording (question text and prompt). The guides' prose is never read.

To obtain them, sign in to the [CDISC Library](https://library.cdisc.org/),
open **Standards**, choose the standard and version, and use the **CSV
export**. Save each file under the name below in one directory, outside any
git repository, and point the build at it:

``` sh
CDISC_SOURCES_DIR=/path/to/cdisc-sources Rscript data-raw/build_ig.R
Rscript data-raw/build_catalogue.R
```

`CDISC_SOURCES_DIR` defaults to `../cdisc-sources`, next to the checkout.
`build_ig.R` stops, listing every file that is missing, if any of the 52 is
not there; and stops on any `*_Supplement_v*.csv` it does not list, so a new
QRS supplement is added on purpose.

| Files | Count |
|-------|------:|
| `SDTM_v1.2.csv` to `SDTM_v1.8.csv`, `SDTM_v2.0.csv`, `SDTM_v2.1.csv` | 9 |
| `SDTMIG_v3.1.2.csv`, `SDTMIG_v3.1.3.csv`, `SDTMIG_v3.2.csv`, `SDTMIG_v3.3.csv`, `SDTMIG_v3.4.csv` | 5 |
| `SDTMIG-AP_v1.0.csv`, `SDTMIG-MD_v1.0.csv`, `SDTMIG-MD_v1.1.csv` | 3 |
| `SENDIG_v3.0.csv`, `SENDIG_v3.1.csv`, `SENDIG_v3.1.1.csv`, `SENDIG-AR_v1.0.csv`, `SENDIG-DART_v1.1.csv`, `SENDIG-GeneTox_v1.0.csv` | 6 |
| `ADaMIG_v1.0.csv` to `ADaMIG_v1.3.csv`, `ADaMIG_MD_v1.0.csv`, `ADaMIG_NCA_v1.0.csv`, `ADaM_ADAE_v1.0.csv`, `ADaM_BDS_for_TTE_v1.0.csv`, `ADaM_OCCDS_v1.0.csv`, `ADaM_OCCDS_v1.1.csv`, `ADaM_popPK_v1.0.csv` | 11 |
| `CDASH_Model_v1.0.csv` to `CDASH_Model_v1.3.csv`, `CDASHIG_v1.1.csv`, `CDASHIG_v2.0.csv` to `CDASHIG_v2.3.csv` | 9 |
| `AIMS_Supplement_v2.0.csv`, `APACHE_II_Supplement_v1.0.csv`, `ATLAS_Supplement_v1.0.csv`, `CGI_Supplement_v2.1.csv`, `HAM-A_Supplement_v2.1.csv`, `KFSS_Supplement_v2.0.csv`, `KPS_SCALE_Supplement_v2.0.csv`, `PGI_Supplement_v1.1.csv`, `SIX_MINUTE_WALK_Supplement_v1.0.csv` | 9 |

Each export holds one standard version and has a `Version` column such as
`ADaMIG MD v1.0`, which the build parses into a standard and a version. The
QRS supplements have no such column, so their instrument and version come
from the file name. `ig_sources` records each file's name, parsed version,
row count, and MD5 checksum, so a rebuild can be checked against the files
that built the committed data.

## What the build checks

`build_ig.R` stops unless every file is loaded exactly once, as many rows are
kept as the file has, every identifying field is present, and every key is
unique. `tests/testthat/test-ig_integrity.R`,
`tests/testthat/test-cdash_integrity.R`, and `tests/testthat/test-ig_versions.R`
repeat those checks on the committed data, and also check that labels are at
most 40 characters except for an explicit, exhaustive list of the ones the
guides publish longer (`tests/testthat/helper-ig-exceptions.R`), and that no
CSV is tracked under `data-raw`.
`tests/testthat/test-data_raw_ig.R` runs the helpers in `utils_ig.R` on small
synthetic exports, including a check that no prose column reaches the data.
