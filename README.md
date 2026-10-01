# cdiscdata

<!-- badges: start -->
[![R-CMD-check](https://github.com/humanpred/cdiscdata/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/humanpred/cdiscdata/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/humanpred/cdiscdata/graph/badge.svg)](https://app.codecov.io/gh/humanpred/cdiscdata)
<!-- badges: end -->

`cdiscdata` provides versioned CDISC reference data as a standard R package,
with zero runtime dependencies. It bundles:

- **Controlled Terminology (CT)**: all historical SDTM and ADaM CT releases from
  the [NCI EVS FTP site](https://evs.nci.nih.gov/ftp1/CDISC/), stored compactly
  using a validity-date design (one row per term-state, not one copy per release).
  Current as of the 2026-09-25 NCI release.
- **Implementation-guide (IG) variable metadata**: SDTM Model and SDTMIG
  variable tables (the Findings general-observation-class variables; the PP
  domain and generic SUPP-- structure used for SUPPPP at SDTMIG 3.2 and 3.3;
  every domain of SDTMIG 3.4) and ADaMIG ADSL and BDS variable tables (BDS
  covers ADPP, a BDS-structured dataset). See `get_ig()` and
  `build_domain_spec()`.
- **Define-XML XSD schemas**: for validating `define.xml` files (versions 2.0 and
  2.1).
- **XSLT stylesheets**: for rendering `define.xml` as HTML (versions 2.0 and 2.1).

CT, Define-XML schemas, and XSLT stylesheets are sourced exclusively from
publicly available, license-free sources, with no CDISC Library API key
needed. IG variable metadata is sourced from CDISC's own published SDTM
Model/SDTMIG/ADaMIG specification tables (also without an API key) - see
[Data sources](#data-sources) below, which supersedes this package's
original plan to leave all IG metadata to a separate `cdiscapi` package.

## Installation

Install the development version from [GitHub](https://github.com/humanpred/cdiscdata):

``` r
# install.packages("pak")
pak::pak("humanpred/cdiscdata")
```

## Usage

### Discover what is available

``` r
library(cdiscdata)

# List all bundled datasets with version counts and latest release dates
list_datasets()

# See package-level version metadata
cdiscdata_versions()
```

### Controlled Terminology

``` r
# Latest SDTM CT (all codelists and terms as a data frame)
ct <- get_ct("sdtm")
nrow(ct)
head(ct[, c("codelist_code", "codelist_name", "term", "decoded_value")])

# All available CT release dates, most recent first
versions <- available_ct_versions("sdtm")
head(versions)

# CT as it existed at a specific historical release
ct_prev <- get_ct("sdtm", version = versions[[2]])

# ADaM CT works the same way
ct_adam <- get_ct("adam")
```

The validity-date design means historical data is stored without duplication:
each row carries a `valid_from` date and an `valid_to` date (`NA` = still
current). `get_ct()` reconstructs the state of any release on the fly.

### Implementation-guide variable metadata

``` r
# All SDTM Model + SDTMIG variable metadata (every source and version)
ig_sdtm <- get_ig("sdtm")

# Just the SDTMIG PP domain
pp_ig <- get_ig("sdtm", version = "3.3", domain = "PP")

# A ready-to-use variable spec (name, label, type, length, core, order,
# codelist id) for PP, SUPPPP, or ADPP, joined to CT for codelist ids
build_domain_spec("PP")
build_domain_spec("SUPPPP")
build_domain_spec("ADPP")
```

### Define-XML schemas and stylesheets

``` r
# File paths to the bundled XSD and XSLT assets
schema_path("2.1")       # path to the Define-XML 2.1 XSD directory
stylesheet_path("2.1")   # path to the Define-XML 2.1 XSLT file

# Validate a define.xml with xml2 (example)
library(xml2)
doc    <- read_xml("path/to/define.xml")
schema <- read_xml(file.path(schema_path("2.1"), "define2-1-0.xsd"))
xml_validate(doc, schema)
```

### Unified access via `get_dataset()`

``` r
# get_dataset() is a single entry point for all bundled assets
get_dataset("ct_sdtm")                          # latest SDTM CT
get_dataset("ct_adam", version = "2024-03-29")  # historical ADaM CT
get_dataset("define_xml_schema",     version = "2.1")
get_dataset("define_xml_stylesheet", version = "2.0")
```

## Design

`cdiscdata` is intended as a **shared data dependency** for pharmaverse-aligned
packages (e.g. `cdisclib`, `defineauto`). Key design decisions:

| Decision | Rationale |
|----------|-----------|
| Zero runtime dependencies | Easier deployment in locked/air-gapped environments; CRAN friendly |
| Validity-date CT storage | Compact representation of all historical releases without row duplication |
| No CDISC Library API key required | CT, schemas, and stylesheets are public domain / open-source licensed; IG metadata is transcribed from CDISC's published specification documents (see Data sources) |
| Per-release RDS cache in `data-raw/raw/` | Fast incremental rebuilds; preserves full audit trail |

## Data sources

| Data | Source | License |
|------|--------|---------|
| SDTM CT | [NCI EVS FTP](https://evs.nci.nih.gov/ftp1/CDISC/SDTM/) | Public domain |
| ADaM CT | [NCI EVS FTP](https://evs.nci.nih.gov/ftp1/CDISC/ADaM/) | Public domain |
| SDTM Model / SDTMIG 3.2-3.3 / ADaMIG variable metadata | CDISC's published specification documents, transcribed via [Bill Denney's Rsdtm package](https://github.com/humanpred/Rsdtm) (private); see `data-raw/ig_source/README.md` for full provenance/attribution | CDISC published standards |
| SDTMIG 3.4 variable metadata | A CDISC Library CSV export, downloaded under CDISC's terms and **not redistributed**; only variable metadata is transcribed (not the CDISC Notes text); see `data-raw/ig_source/README.md` | CDISC terms and conditions |
| Define-XML 2.1 schema | [cdisc-org/DataExchange-RWD-Lineage](https://github.com/cdisc-org/DataExchange-RWD-Lineage) | Apache 2.0 |
| Define-XML 2.0 schema | [dbosak01/defineR](https://github.com/dbosak01/defineR) | MIT |
| XSLT stylesheets | [cdisc-org/data-definition-engine](https://github.com/cdisc-org/data-definition-engine) / [dbosak01/defineR](https://github.com/dbosak01/defineR) | Apache 2.0 / MIT |

## Related packages

- **`cdiscapi`** *(forthcoming)*: CDISC Library API access (requires API key)
  for metadata not available from public sources - e.g. newer SDTMIG/ADaMIG
  versions than `get_ig()` currently covers.
- **`cdisclib`**: Core utilities built on top of `cdiscdata`.
- **`defineauto`**: Automated Define-XML generation.

## License

MIT + file LICENSE
