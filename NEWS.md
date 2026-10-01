# cdiscdata (development version)

* `inst/COPYRIGHTS` lists the source, copyright holder and licence of every bundled file and data table, including the standards metadata tables added in this version.

## Every CDISC Library implementation-guide export, replacing the Rsdtm tables

* `ig_sdtm`, `ig_adam`, and the new `model_sdtm` are rebuilt from 34 CDISC
  Library CSV exports and carry every standard and version in them, replacing
  every row transcribed from the Rsdtm package:

  | Table | Standards | Standard versions | Rows |
  |-------|-----------|------------------:|-----:|
  | `model_sdtm` | SDTM model | 9 | 3,604 |
  | `ig_sdtm` | SDTMIG, SDTMIG-AP, SDTMIG-MD, SENDIG, SENDIG-AR, SENDIG-DART, SENDIG-GeneTox | 14 | 10,064 |
  | `ig_adam` | ADaMIG, ADaMIG-MD, ADaMIG-NCA, ADaM-ADAE, ADaM-BDS-TTE, ADaM-OCCDS, ADaM-popPK | 11 | 1,804 |

  Only variable metadata is carried. The guides' prose (CDISC Notes,
  Description, Definition, Notes, Examples) is not in the package data.
* **Breaking: new columns.** `ig_sdtm` is now `standard`, `version`, `class`,
  `domain`, `order`, `variable`, `label`, `type`, `role`, `core`,
  `codelist_code`, `codelist_submission_values`, `described_value_domain`,
  `value_list`. `ig_adam` is `standard`, `version`, `structure`,
  `variable_set`, `order`, `variable`, `label`, `type`, `core`,
  `codelist_code`, `codelist_submission_values`, `described_value_domain`,
  `value_list`. `model_sdtm` is `standard`, `version`, `class`, `dataset`,
  `order`, `variable`, `label`, `type`, `role`, `described_value_domain`,
  `variables_qualified`, `usage_restrictions`, `variable_code`. The old
  `source` (now `standard`), `dataset` and `category` (ADaM; now `structure`
  and `variable_set`), `codelist` (now `codelist_code`, a C-code rather than a
  submission value), `length`, and `notes` columns are gone. The SDTM model
  moved out of `ig_sdtm` into `model_sdtm`.
* `ig_sources` lists the exports each table was built from: file name, the
  export's version string, the parsed standard and version, the dataset it was
  loaded into, its row count, and its MD5 checksum.

## CDASH and QRS supplement metadata

* New `cdash_model` (CDASH model 1.0 to 1.3, 1,138 rows), `ig_cdash` (CDASHIG
  1.1 and 2.0 to 2.3, 4,483 rows), and `qrs_supplement` (75 items of nine
  questionnaire, rating-scale, and functional-test supplements, 9 instrument
  versions), from 18 more CDISC Library exports. The CDASH tables carry the
  collection wording (`question_text`, `prompt`) and the SDTM target of each
  field, but not the definitions, CRF completion instructions, mapping
  instructions, or implementation notes. `qrs_supplement` carries the
  `--TEST`/`--TESTCD` names and codes of each item but not the item text. The
  QRS exports have no version column, so the instrument and version are read
  from the file name.
* New `get_cdash(standard, version, domain)` for the CDASH tables, with the
  same conventions as `get_ig()`. It is a separate function because the CDASH
  tables describe data collection, not a dataset's structure, and so have
  different columns. The QRS supplements are reached with
  `get_dataset("qrs_supplement")`.

## Retrieval functions

* **Breaking: `get_ig(standard, version, domain)`.** `standard` now names one
  of 15 standards (`"SDTM"`, `"SDTMIG"`, `"SDTMIG-AP"`, `"SDTMIG-MD"`,
  `"SENDIG"`, `"SENDIG-AR"`, `"SENDIG-DART"`, `"SENDIG-GeneTox"`, `"ADaMIG"`,
  `"ADaMIG-MD"`, `"ADaMIG-NCA"`, `"ADaM-ADAE"`, `"ADaM-BDS-TTE"`,
  `"ADaM-OCCDS"`, `"ADaM-popPK"`). The default is `"SDTMIG"`, and a `NULL`
  `version` now returns that standard's newest version (compared numerically)
  where it used to return every version. The lower-case `"sdtm"` and `"adam"`
  are kept as aliases for `"SDTMIG"` and `"ADaMIG"`; capital `"SDTM"` is the
  model. `domain` filters by domain (SDTMIG), class or dataset (SDTM model),
  or structure (ADaM, where `"BDS"` and `"ADSL"` are accepted). An unknown
  standard, version, or domain is a classed error
  (`cdiscdata_error_ig_standard_unavailable`,
  `cdiscdata_error_ig_version_unavailable`,
  `cdiscdata_error_ig_domain_unavailable`) listing what is available.
* **Fixed: `get_dataset("ig_sdtm")` and `get_dataset("ig_adam")`.** They
  silently returned `NULL`. They now return the table, whole or restricted to
  the rows of one version string, and `get_dataset("model_sdtm")`,
  `get_dataset("cdash_model")`, `get_dataset("ig_cdash")` and
  `get_dataset("qrs_supplement")` work the same way. `list_datasets()` reports
  the new tables with types `"Model"`, `"CDASH"`, and `"QRS"`, and counts
  versions per standard.

## Variable specs

* `build_domain_spec()` takes a `standard` (any SDTM-side standard that
  defines the domain, e.g. `"SENDIG"` for PP) and an `extension` for ADPP:
  `"ADaMIG-NCA"` (or `"NCA"`), `"ADaM-popPK"`, or `"ADaM-BDS-TTE"` is unioned
  onto the BDS variables, as `adsl = TRUE` unions ADSL, with `extension_version`
  to pick its version. Unlike the ADSL and PP unions, the extension keeps its
  own Core designations: a variable the BDS already defines takes the
  extension's Core (`DOSEA`, `DOSEU`, and `AVISIT` become required in
  ADaMIG-NCA) and is marked with the extension's name in `source`. Existing
  calls keep working.
* The default specs now follow the newest guides: PP is the 26 variables of
  SDTMIG 3.4, and ADPP is the 195 ADaMIG 1.3 BDS variables plus the 137 ADSL
  variables not already there (332 in all). `build_domain_spec("ADPP",
  extension = "NCA")` has 388 variables. `sdtm_domain = "PP"` adds 24 variables
  (22 with `sdtmig_version = "3.3"`).
* The `length` column is kept but is always `NA`: the exports carry no
  length, which is a sponsor choice. `codelist_id` takes the first C-code of an
  IG codelist list, kept only when that codelist is in the CT release used.

## Data gates

* New tests in `test-ig_integrity.R` and `test-cdash_integrity.R`: every
  export is loaded exactly once and with as many rows as its file has; every
  row is unique on its key; no name or label is `NA` or contains a newline;
  no text field has stray whitespace; no value is long enough to be prose;
  `type` and `core` hold only published values; and no CSV is tracked under
  `data-raw`. The version-string parser is tested on all 43 version strings
  and on the nine QRS file names.
* Labels are limited to 40 characters (the XPT v5 limit, SDTMIG section 4.2.1)
  except for the labels the guides themselves publish longer, kept as
  published and listed in full in `helper-ig-exceptions.R`: 22 in the SDTM and
  ADaM tables (SDTMIG 3.2 and SDTMIG-MD 1.0 long forms that later versions
  abbreviate, the SDTM model `--TESTCD` before 1.7, and ADaMIG `PBCHGCyN`), 6
  in the CDASH model, and 71 in CDASHIG 2.0. Both directions are checked, so a
  new over-length label fails and so does an exception that is no longer
  true. CDASHIG 1.1 publishes no variable labels at all (`NA`). Five SDTMIG and
  SDTMIG-MD rows have no `type` or `core` in the guide and are listed the same way.
  Shortening a label to fit an XPT file is for whoever writes the dataset, not
  for this package.
* `data-raw/utils_ig.R` is tested on synthetic exports written to a
  temporary directory, including that no prose column of any export layout
  reaches the data.

## Corrections to earlier notes

* The SDTMIG PP domain has 19 variables in 3.1.2 and 3.1.3, 21 in 3.2, 24 in
  3.3, and 26 in 3.4, as the CDISC Library publishes them. Earlier development
  notes said 3.2 and 3.3 were the same 24-variable table; that was inferred
  from a version stamp in the published PDF and was wrong. `EPOCH`,
  `TAETORD` and `PPDY` first appear in 3.3, and `PPANMETH` and `PPTPTREF` in
  3.4. `PPDTC`, not `PPPDTC`, is the published name, and nca.reporter's
  `PTAETORD`, `PPPDTC` and `PPPDY` are not published SDTMIG variables.
* SDTMIG 3.2 `PPSTRESC` is published as "Character Result/Finding in
  Standard Format" (43 characters; 3.3 abbreviates it). It is now carried as
  published and is one of the exceptions above, where an earlier development
  version had abbreviated it.

## Sources

* The exports are downloaded under CDISC's own terms and conditions. They are
  not in this repository, are never committed, and are read from
  `CDISC_SOURCES_DIR` (default `../cdisc-sources`) by `data-raw/build_ig.R`,
  which stops with a message listing every expected file if any is missing
  and refuses a QRS supplement it does not list. `data-raw/README.md` says how
  to obtain them. The Rsdtm copies in `data-raw/ig_source/` and the scripts
  that read them are removed.

# cdiscdata 0.2.0

## Classed conditions and coverage

* Every error and warning `get_ig()` and `build_domain_spec()` raise is now
  classed (e.g. `cdiscdata_error_ig_version_unavailable`,
  `cdiscdata_error_no_ig_variables`, `cdiscdata_warning_adsl_ignored`), so
  they can be caught or asserted on by class rather than by matching
  message text. Implemented with a small internal `.cdiscdata_abort()`/
  `.cdiscdata_warn()` helper rather than a new dependency (e.g. rlang), to
  keep the package's zero-runtime-dependency design.
* `build_domain_spec()` is now at 100% line coverage; two defensive checks
  (an SDTMIG/ADaMIG version with no rows for the requested domain/dataset -
  not reachable via the public API with the currently bundled `ig_sdtm`/
  `ig_adam`, since every version there has PP/SUPPQUAL/BDS rows) are
  exercised directly via mocking `get_ig()`.

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
