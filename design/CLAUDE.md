# cdiscdata — Claude Code Instructions

## Package purpose

`cdiscdata` is a **data-only R package** with zero runtime dependencies. It
provides versioned CDISC reference data to downstream packages (`cdisclib`,
`defineauto`) and is part of the humanpred CDISC ecosystem:

```
cdiscdata  →  cdisclib  →  defineauto
                           (+ future cdiscapi for licensed API data)
```

## Critical constraints

- **Zero runtime dependencies.** No `Imports:` in DESCRIPTION. All `R/` code
  uses only base R. `data-raw/` scripts may use dplyr/tidyverse freely (they
  are excluded from the built package via `.Rbuildignore`).
- **Public data only.** Only data available without a license or API key is
  bundled. SDTM IG / ADaM IG variable metadata requires the CDISC Library API
  key — that belongs in the separate `cdiscapi` package.
- **`valid_from` must never be NA.** Enforced by `assert_no_na_valid_from()`
  after every `apply_ct_update()` call. Do not silently filter NAs.

## Repository location

`/home/bill/github/cdisc_define/cdiscdata/`
GitHub: `github.com/humanpred/cdiscdata`

## Data sources

| Asset | Source | License |
|-------|--------|---------|
| SDTM CT | NCI EVS FTP (`evs.nci.nih.gov/ftp1/CDISC/SDTM/`) | Public domain |
| ADaM CT | NCI EVS FTP (`evs.nci.nih.gov/ftp1/CDISC/ADaM/`) | Public domain |
| Define-XML 2.1 XSD | `cdisc-org/DataExchange-RWD-Lineage` (`tools/schema/`) | MIT |
| Define-XML 2.0 XSD | `dbosak01/defineR` (`inst/extdata/2.0.0/cdisc-define-2.0/`) | MIT |
| Define-XML 2.1 XSL | `cdisc-org/data-definition-engine` (`src/generators/define/define2-1.xsl`) | Apache 2.0 |
| Define-XML 2.0 XSL | `dbosak01/defineR` (`inst/extdata/2.0.0/cdisc-xsl/define2-0.xsl`) | MIT |

Note: `github.com/cdisc-org/DataExchange-DefineXML` does **not** exist —
do not attempt to use it as a source.

## Raw cache design

NCI CT text files are downloaded once and saved as compressed `.rds` files:
- `data-raw/raw/sdtm/SDTM_Terminology_YYYY-MM-DD.rds`
- `data-raw/raw/adam/ADaM_Terminology_YYYY-MM-DD.rds`

A date is considered "processed" if its `.rds` file exists (even if it
produced 0 new rows, i.e. was identical to the prior release).

## Key files

| File | Purpose |
|------|---------|
| `R/get_dataset.R` | Main retrieval gateway + all internal version resolvers |
| `R/available_versions.R` | `available_ct_versions()` — CT only |
| `R/paths.R` | `schema_path()`, `stylesheet_path()` |
| `data-raw/utils_nci.R` | NCI FTP helpers, `fetch_raw_ct_tbl()`, `parse_nci_ct_txt()` |
| `data-raw/utils_diff.R` | Validity-date diff logic, `apply_ct_update()`, `assert_no_na_valid_from()` |
| `data-raw/fetch_all.R` | Orchestrator — run this to refresh all data |

## How to refresh data

```r
# From cdiscdata/ directory
source("data-raw/fetch_all.R")
devtools::document()
devtools::check(vignettes = FALSE)
```

## How to run checks

```r
devtools::document()          # regenerate man/ from roxygen
devtools::check(vignettes = FALSE)   # fast check
devtools::test()              # tests only
```
