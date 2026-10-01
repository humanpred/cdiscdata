# cdiscdata

`cdiscdata` provides versioned CDISC reference data as a standard R
package, with zero runtime dependencies. It bundles:

- **Controlled Terminology (CT)**: all historical SDTM and ADaM CT
  releases from the [NCI EVS FTP
  site](https://evs.nci.nih.gov/ftp1/CDISC/), stored compactly using a
  validity-date design (one row per term-state, not one copy per
  release). Current as of the 2026-09-25 NCI release.
- **Implementation-guide, model, CDASH, and QRS variable metadata**: the
  variables of 34 SDTM-, SEND-, and ADaM-side guides (the SDTM model;
  SDTMIG 3.1.2 to 3.4, -AP, -MD; SENDIG 3.0 to 3.1.1, -AR, -DART,
  -GeneTox; ADaMIG 1.0 to 1.3, -MD, -NCA, ADaM-ADAE, -BDS-TTE, -OCCDS,
  -popPK), the CDASH model and CDASHIG, and the items of nine QRS
  instrument supplements, at every version. See
  [`get_ig()`](https://humanpred.github.io/cdiscdata/reference/get_ig.md),
  [`get_cdash()`](https://humanpred.github.io/cdiscdata/reference/get_cdash.md),
  and
  [`build_domain_spec()`](https://humanpred.github.io/cdiscdata/reference/build_domain_spec.md).
- **Define-XML XSD schemas**: for validating `define.xml` files
  (versions 2.0 and 2.1).
- **XSLT stylesheets**: for rendering `define.xml` as HTML (versions 2.0
  and 2.1).

CT, Define-XML schemas, and XSLT stylesheets are sourced exclusively
from publicly available, license-free sources, with no CDISC Library API
key needed. The IG, model, CDASH, and QRS metadata is transcribed from
CDISC Library CSV exports that were downloaded under CDISC’s own terms
and conditions. **Those exports are not in this repository and are not
redistributed**; only variable metadata is carried, not the guides’
prose. See [Data sources](#data-sources) and `data-raw/README.md`.

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

### Implementation-guide variable metadata

``` r

# The newest SDTMIG (3.4), every domain
get_ig()

# One standard, one version, one domain
get_ig("SDTMIG", version = "3.3", domain = "PP")
get_ig("SENDIG", domain = "PP")

# The SDTM model, and the ADaM guides and their extensions
get_ig("SDTM", version = "2.1", domain = "Findings")
get_ig("ADaMIG", domain = "BDS")
get_ig("ADaMIG-NCA")

# The CDASH model and implementation guide
get_cdash()
get_cdash("CDASHIG", version = "2.1", domain = "LB")

# A ready-to-use variable spec (name, label, type, core, order, source,
# codelist id) for PP, SUPPPP, or ADPP, joined to CT for codelist ids
build_domain_spec("PP")
build_domain_spec("SUPPPP")
build_domain_spec("ADPP")                       # ADaMIG BDS + ADSL
build_domain_spec("ADPP", extension = "NCA")    # ... + ADaMIG-NCA
```

Every standard and version bundled, and the export each was built from:

| Dataset | Standards | Standard versions | Rows |
|----|----|---:|---:|
| `ig_sdtm` | SDTMIG 3.1.2 to 3.4, SDTMIG-AP, SDTMIG-MD, SENDIG 3.0 to 3.1.1, SENDIG-AR, SENDIG-DART, SENDIG-GeneTox | 14 | 10,064 |
| `model_sdtm` | SDTM model 1.2 to 2.1 | 9 | 3,604 |
| `ig_adam` | ADaMIG 1.0 to 1.3, ADaMIG-MD, ADaMIG-NCA, ADaM-ADAE, ADaM-BDS-TTE, ADaM-OCCDS, ADaM-popPK | 11 | 1,804 |
| `cdash_model` | CDASH model 1.0 to 1.3 | 4 | 1,138 |
| `ig_cdash` | CDASHIG 1.1, 2.0 to 2.3 | 5 | 4,483 |
| `qrs_supplement` | AIMS, APACHE_II, ATLAS, CGI, HAM-A, KFSS, KPS_SCALE, PGI, SIX_MINUTE_WALK | 9 | 75 |

`ig_sources` lists each export, its parsed standard and version, its row
count, and its checksum.

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
get_dataset("ig_adam", version = "1.3")         # IG, model, CDASH, QRS tables
get_dataset("qrs_supplement")
get_dataset("define_xml_schema",     version = "2.1")
get_dataset("define_xml_stylesheet", version = "2.0")
```

## Design

`cdiscdata` is intended as a **shared data dependency** for
pharmaverse-aligned packages (e.g. `cdisclib`, `defineauto`). Key design
decisions:

| Decision | Rationale |
|----|----|
| Zero runtime dependencies | Easier deployment in locked/air-gapped environments; CRAN friendly |
| Validity-date CT storage | Compact representation of all historical releases without row duplication |
| No CDISC Library API key required | CT, schemas, and stylesheets are public domain / open-source licensed; the IG, model, CDASH, and QRS metadata is transcribed from CDISC Library CSV exports downloaded under CDISC’s terms and not redistributed (see Data sources) |
| Per-release RDS cache in `data-raw/raw/` | Fast incremental rebuilds; preserves full audit trail |

## Data sources

| Data | Source | License |
|----|----|----|
| SDTM CT | [NCI EVS FTP](https://evs.nci.nih.gov/ftp1/CDISC/SDTM/) | Public domain |
| ADaM CT | [NCI EVS FTP](https://evs.nci.nih.gov/ftp1/CDISC/ADaM/) | Public domain |
| SDTM model, SDTMIG, SENDIG, ADaMIG, and related guides: variable metadata | 34 CDISC Library CSV exports, downloaded under CDISC’s terms and **not redistributed**; only variable metadata is transcribed (not the CDISC Notes, Description, Definition, Notes, or Examples text); see `data-raw/README.md` | CDISC terms and conditions |
| CDASH model and CDASHIG variable metadata | 9 CDISC Library CSV exports, as above; the collection wording (question text, prompt) is carried, the definitions, mapping and CRF completion instructions, and implementation notes are not | CDISC terms and conditions |
| QRS supplement item metadata | 9 CDISC Library CSV exports, as above; the `--TEST` and `--TESTCD` names and codes are carried, the item text is not | CDISC terms and conditions |
| Define-XML 2.1 schema | [cdisc-org/DataExchange-RWD-Lineage](https://github.com/cdisc-org/DataExchange-RWD-Lineage) | Apache 2.0 |
| Define-XML 2.0 schema | [dbosak01/defineR](https://github.com/dbosak01/defineR) | MIT |
| XSLT stylesheets | [cdisc-org/data-definition-engine](https://github.com/cdisc-org/data-definition-engine) / [dbosak01/defineR](https://github.com/dbosak01/defineR) | Apache 2.0 / MIT |

## Related packages

- **`cdiscapi`** *(forthcoming)*: CDISC Library API access (requires API
  key) for metadata not available from public sources or from the
  exports bundled here - e.g. guides and versions newer than those
  [`get_ig()`](https://humanpred.github.io/cdiscdata/reference/get_ig.md)
  and
  [`get_cdash()`](https://humanpred.github.io/cdiscdata/reference/get_cdash.md)
  cover.
- **`cdisclib`**: Core utilities built on top of `cdiscdata`.
- **`defineauto`**: Automated Define-XML generation.

## License

MIT + file LICENSE
