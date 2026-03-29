# cdiscdata — Package Decision Log

Decisions are listed newest-first within each section.

---

## Data scope

### Only public data bundled; SDTM/ADaM IG → cdiscapi (2026-03-29)

**Decision:** SDTM IG and ADaM IG variable/domain/class metadata are excluded
from this package and will be part of a future `cdiscapi` package.

**Reason:** IG metadata requires the CDISC Library API key and an associated
license. Bundling licensed data would prevent open distribution and CRAN
submission.

**Impact:** Functions `get_sdtmig()`, `get_adamig()`,
`available_sdtmig_versions()`, `available_adamig_versions()` are not
implemented here. The `datasets_catalogue` contains only CT and file-based
assets.

---

## Dependencies

### Zero runtime dependencies (2026-03-29)

**Decision:** `DESCRIPTION` has no `Imports:`. All `R/` code uses only base R.

**Reason:** A data package with dependencies forces downstream packages to
install those dependencies too. Base R equivalents exist for everything needed:
`match.arg()` for argument matching, `stop(paste0(...))` for errors, base
subsetting for filtering.

**Impact:** `dplyr`, `rlang`, `cli`, `tibble` were removed from `Imports`.
`data-raw/` scripts may freely use tidyverse (they are not shipped).

### tidyr::fill replaced with base R loop (2026-03-29)

**Decision:** The `codelist_name` forward-fill in `parse_nci_ct_txt()` uses a
base R `for` loop instead of `tidyr::fill()`.

**Reason:** Consistent with zero-dependency goal; `tidyr` was not in
`Imports`. The forward-fill loop is simple and operates on a single column.

---

## Data storage

### Per-release RDS cache in data-raw/raw/ (2026-03-29)

**Decision:** Each NCI CT release is cached as a compressed `.rds` file
(`data-raw/raw/{type}/{TYPE}_Terminology_YYYY-MM-DD.rds`) rather than the
original `.txt` file.

**Reason:** Raw NCI `.txt` files total ~402 MB for the full archive.
Compressed `.rds` files (parsed data frames, `compress = "xz"`) total ~39 MB
— a 90% reduction. The `.rds` format also loads faster on re-runs.

**Impact:** `fetch_raw_ct_tbl()` downloads to a tempfile, parses immediately,
saves `.rds`, and returns the data frame. The `.txt` file is never persisted.

### Diffs not stored separately; full per-release snapshots kept (2026-03-29)

**Decision:** Each `.rds` cache file is the full parsed snapshot for that
release, not just the diff from the prior release.

**Reason:** Full snapshots allow the diff logic (`apply_ct_update`) to be
re-run with modified logic without re-downloading. They also enable auditing
individual release content. At ~39 MB total for 85+ SDTM releases, the size
is acceptable.

### Validity-date design for CT (initial design)

**Decision:** All CT versions are stored in a single table with `valid_from`
and `valid_to` columns rather than one table/file per version.

**Reason:** CDISC CT has 70+ historical releases. Storing one table per
release would mean either shipping 70+ `.rda` files or requiring network
access at query time. The validity-date design keeps the package to a single
`.rda` per CT type while supporting queries at any historical version.

**Invariant:** `valid_from` must never be `NA`. This is enforced by
`assert_no_na_valid_from()` after every `apply_ct_update()` call.

---

## Schema and stylesheet sources

### Sources for XSD/XSL files (2026-03-29)

**Decision:** Schemas and stylesheets are sourced from:
- Define-XML 2.1 XSD: `cdisc-org/DataExchange-RWD-Lineage` (MIT)
- Define-XML 2.0 XSD: `dbosak01/defineR` CRAN package (MIT)
- Define-XML 2.1 XSL: `cdisc-org/data-definition-engine` (Apache 2.0)
- Define-XML 2.0 XSL: `dbosak01/defineR` CRAN package (MIT)

**Reason:** The originally planned repository (`cdisc-org/DataExchange-DefineXML`)
does not exist. These alternative sources contain the same CDISC-published
files and are publicly available under open-source licenses.

---

## API design

### `get_dataset()` routes schema/stylesheet by version discovered from disk (2026-03-29)

**Decision:** `.resolve_schema_version()` reads available versions by listing
`inst/extdata/schema/` subdirectories at runtime rather than a hard-coded
vector.

**Reason:** Hard-coding `c("2.1", "2.0")` would require a code change whenever
a new Define-XML version is added. Disk-based discovery means only adding files
is required.

### Schemas/stylesheets exposed in datasets_catalogue (2026-03-29)

**Decision:** `datasets_catalogue` includes rows for `define_xml_schema` and
`define_xml_stylesheet` alongside the CT rows.

**Reason:** `list_datasets()` and `cdiscdata_versions()` should return a
complete inventory of everything the package provides, including file assets.

### Schema/stylesheet accessible via `get_dataset()` (2026-03-29)

**Decision:** `get_dataset("define_xml_schema", version = "2.1")` returns a
file path, not a data frame. This is a deliberate mixed return type.

**Reason:** File assets cannot be returned as data frames. The `type` column
in `datasets_catalogue` (Schema / Stylesheet vs CT) documents the distinction.
`schema_path()` and `stylesheet_path()` remain as direct convenience functions.
