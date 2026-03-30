# cdiscdata

`cdiscdata` provides versioned CDISC reference data as a standard R
package, with zero runtime dependencies. It bundles:

- **Controlled Terminology (CT)**: all historical SDTM and ADaM CT
  releases from the [NCI EVS FTP
  site](https://evs.nci.nih.gov/ftp1/CDISC/), stored compactly using a
  validity-date design (one row per term-state, not one copy per
  release).
- **Define-XML XSD schemas**: for validating `define.xml` files
  (versions 2.0 and 2.1).
- **XSLT stylesheets**: for rendering `define.xml` as HTML (versions 2.0
  and 2.1).

All data are sourced exclusively from publicly available, license-free
sources. Data that require a CDISC Library API key (SDTM IG, ADaM IG)
will be handled by a separate `cdiscapi` package.

## Installation

Install the development version from
[GitHub](https://github.com/humanpred/cdiscdata):

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

The validity-date design means historical data is stored without
duplication: each row carries a `valid_from` date and an `valid_to` date
(`NA` = still current).
[`get_ct()`](https://humanpred.github.io/cdiscdata/reference/get_ct.md)
reconstructs the state of any release on the fly.

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

`cdiscdata` is intended as a **shared data dependency** for
pharmaverse-aligned packages (e.g. `cdisclib`, `defineauto`). Key design
decisions:

| Decision                                 | Rationale                                                                 |
|------------------------------------------|---------------------------------------------------------------------------|
| Zero runtime dependencies                | Easier deployment in locked/air-gapped environments; CRAN friendly        |
| Validity-date CT storage                 | Compact representation of all historical releases without row duplication |
| Public data only                         | No API key or license required to install or use the package              |
| Per-release RDS cache in `data-raw/raw/` | Fast incremental rebuilds; preserves full audit trail                     |

## Data sources

| Data                  | Source                                                                                                                                            | License          |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------|------------------|
| SDTM CT               | [NCI EVS FTP](https://evs.nci.nih.gov/ftp1/CDISC/SDTM/)                                                                                           | Public domain    |
| ADaM CT               | [NCI EVS FTP](https://evs.nci.nih.gov/ftp1/CDISC/ADaM/)                                                                                           | Public domain    |
| Define-XML 2.1 schema | [cdisc-org/DataExchange-RWD-Lineage](https://github.com/cdisc-org/DataExchange-RWD-Lineage)                                                       | Apache 2.0       |
| Define-XML 2.0 schema | [dbosak01/defineR](https://github.com/dbosak01/defineR)                                                                                           | MIT              |
| XSLT stylesheets      | [cdisc-org/data-definition-engine](https://github.com/cdisc-org/data-definition-engine) / [dbosak01/defineR](https://github.com/dbosak01/defineR) | Apache 2.0 / MIT |

## Related packages

- **`cdiscapi`** *(forthcoming)*: SDTM IG and ADaM IG metadata via the
  CDISC Library API (requires API key).
- **`cdisclib`**: Core utilities built on top of `cdiscdata`.
- **`defineauto`**: Automated Define-XML generation.

## License

MIT + file LICENSE
