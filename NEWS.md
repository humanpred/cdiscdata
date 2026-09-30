# cdiscdata 0.2.0

## CT refresh

* Added the 2026-09-25 NCI SDTM and ADaM CT releases (previous latest:
  2026-03-27), while keeping every historical release already bundled.
  - SDTM CT 2026-09-25: 41 new/changed codelists, 765 new/changed terms.
  - ADaM CT 2026-09-25: 2 new/changed codelists, 11 new/changed terms.
* Fixed a parser bug (`data-raw/utils_nci.R`) that had silently left
  `codelist_name` `NA` for every row of `ct_sdtm`/`ct_adam` for every NCI
  release from 2012 onward (`codelist_name` and `codelist_code` are used to
  look up a codelist by name, e.g. by `get_ig()`/`build_domain_spec()`, so
  this previously made resolving PKPARMCD/PKPARM/PKUNIT - or any other
  codelist by name - unreliable). The header-row detection this relied on
  assumed the NCI source file repeats a codelist's own C-code in both its
  "Code" and "Codelist Code" columns; from 2012 on, NCI instead leaves
  "Codelist Code" blank on that row, which the previous logic never
  matched. All bundled historical releases were re-parsed from scratch with
  the fix (re-downloading the ~110 archived releases involved, now cached
  as raw text going forward so a future parser fix would not need to). A
  handful of older (2007-2010, plus one 2017) archival releases have
  further, rarer source-data quirks this could not fully resolve; the
  *current* release is verified clean, and the historical gap is bounded by
  `tests/testthat/test-data_integrity.R` rather than silently tolerated.
* Fixed `list_archive_dates()`, which had been silently returning zero
  dates: NCI rebuilt evs.nci.nih.gov as a JavaScript single-page app at some
  point in 2024-2025, so the Archive/ directory URL this scraped for file
  names now serves that app's empty HTML shell instead of a plain listing.
  It now calls the JSON API the app itself uses
  (`GET /ftp1/folder?folder=<path>`) instead; see the comment above
  `list_archive_dates()` in `data-raw/utils_nci.R` for that API's one
  limitation (no working pagination past 1000 entries) and why it does not
  affect finding every release date in practice. `fetch_current_release_date()`
  (previously reading NCI's Publication Date Stamp file, which changed
  format at least twice - a bare date, then "SDTM Terminology YYYY-MM-DD",
  then, as of 2026, a small table - and 403'd from GitHub Actions in
  between) was replaced with a derivation from this same, now-working
  archive listing (`origin/main` PR "fix/nci-stamp-403-fallback", merged
  into this branch).
* Investigated a reported gap in `available_ct_versions()` - SDTM CT
  appeared to be missing the 2024-06, 2024-12, 2025-06, 2025-12, and
  2026-06 quarterly releases. Verified directly against NCI's own file
  listing (not assumed): none of these five releases exist for either
  SDTM or ADaM - NCI shifted SDTM CT from quarterly to semi-annual
  (March/September) releases starting in 2024, and ADaM CT has never been
  reliably quarterly (gaps of 266-448 days recur from 2017 on, long before
  2024). There was nothing to backfill. Added
  `tests/testthat/test-data_integrity.R` gap tests calibrated to each
  type's actual verified history (200 days for SDTM, 500 days for ADaM;
  not a single ~120-day bound, which would flag the genuine 2024-on
  semi-annual gaps as failures) plus a freshness check, so a release that
  is *actually* skipped or a fetch workflow that silently stops running
  would still fail loudly.
* Verified `PKPARMCD` (C85839), `PKPARM` (C85493), and `PKUNIT` (C85494)
  are present in the 2026-09-25 release and returned by `get_ct("sdtm")`.

## Attach-only bug fix

* Fixed `get_ct()`, `get_dataset()`, `list_datasets()`,
  `cdiscdata_versions()`, and `available_ct_versions()` to work via
  `cdiscdata::` alone, without `library(cdiscdata)` first. Lazy-loaded
  package data (`ct_sdtm`, `ct_adam`, `ig_sdtm`, `ig_adam`,
  `datasets_catalogue`) is only wired into the search path when the package
  is *attached*; loading just the namespace (as `::` does) left an
  unqualified reference to that data unresolved, even from inside the
  package's own functions - e.g. `cdiscdata::get_ct("sdtm")` without a
  prior `library()` call errored with `object 'datasets_catalogue' not
  found`. Fixed via an internal `.pkg_data()` helper that loads a dataset
  explicitly with `utils::data()`, independent of attach state. Verified by
  a dedicated test (`tests/testthat/test-attach.R`) that builds and
  installs the package into a fresh library and calls it via `callr::r()`
  in a brand-new subprocess with no `library()` call.

## New: implementation-guide (IG) variable metadata

* Added `ig_sdtm`: SDTM Model Findings general-observation-class variables
  (versions 1.4-1.7), plus the SDTMIG PP domain and the generic SUPP--
  qualifier structure (version 3.2 only - see
  `data-raw/ig_source/README.md` for why no newer SDTMIG version's PP/SUPP--
  tables were available to source).
* Added `ig_adam`: ADaMIG ADSL (subject-level) and BDS (Basic Data
  Structure, used by ADPP) variable tables, for versions 1.0, 1.1, and 1.2.
* Added `get_ig(standard, version)`, mirroring `get_ct()`.
* Added `build_domain_spec(domain, ig_version, ct_version, adsl)`, returning
  a ready-to-use variable spec (name, label, type, length, core, order,
  source, codelist id) for `"PP"`, `"SUPPPP"` (via the generic SUPP--
  structure), or `"ADPP"` (via the generic BDS structure, joined against CT
  for codelist ids). For `"ADPP"`, `adsl = TRUE` (the default) also unions
  in the ADaMIG ADSL variables - a real ADPP carries ADSL's subject-level
  variables alongside its own BDS variables - marked `source = "ADSL"` and
  `core = "Perm"` (ADSL's own Core reflects requirements for ADSL itself,
  not for merging a variable into ADPP, which is always optional); a
  variable defined by both tables (e.g. `STUDYID`, `USUBJID`) keeps its BDS
  version rather than being duplicated. `adsl = FALSE` returns the BDS
  variables alone, as before. Neither table carries PP's own variables
  (`PPTESTCD` and the rest) forward into ADPP; that remains a downstream
  derivation choice, not IG metadata this function sources.
* `get_ig()`/`ig_sdtm`'s SDTMIG-3.2-only coverage of the PP domain and
  SUPP-- structure is now called out explicitly in `get_ig()`'s
  documentation, including the specific known gaps versus a newer SDTMIG
  (`PPANMETH`, `EPOCH`, `PTAETORD` not yet added; SDTMIG 3.2 still has
  `PPDTC`, not the later `PPPDTC` rename).
* IG metadata is transcribed from CDISC's own published SDTM
  Model/SDTMIG/ADaMIG specification tables, copied read-only (with
  attribution) from Bill Denney's private Rsdtm package - see
  `data-raw/ig_source/README.md`. This supersedes the package's original
  plan to leave all IG metadata to a separate `cdiscapi` package; the
  README has been updated accordingly.

# cdiscdata 0.1.0

* First release of `cdiscdata`.
* Bundles versioned CDISC SDTM and ADaM Controlled Terminology from the NCI
  EVS FTP site using a compact validity-date design.
* Includes Define-XML XSD schemas (2.0, 2.1) and XSLT stylesheets.
* Key functions: `get_ct()`, `get_dataset()`, `available_ct_versions()`,
  `schema_path()`, `stylesheet_path()`, `list_datasets()`,
  `cdiscdata_versions()`.
