# cdiscdata (development version)

## IG label and identifier fixes

* Fixed transcription defects in `ig_sdtm` and `ig_adam` found by nca.reporter
  when writing XPT v5 files (labels are limited to 40 characters; SDTMIG 3.3
  section 4.2.1):
  - 62 `ig_sdtm` and 271 `ig_adam` labels carried literal newlines from
    hard-wrapped Word table cells; whitespace is now collapsed for every
    identifying field (`variable`, `label`, `type`, `core`, `codelist`,
    `role`).
  - 112 `ig_sdtm` and 7 `ig_adam` variable names had trailing spaces (so
    `"--TESTCD "` never equalled `"--TESTCD"`, and
    `build_domain_spec("ADPP", ig_version = "1.1")` returned seven ADSL
    names padded this way: `FASFL`, `SAFFL`, `ITTFL`, `PPROTFL`, `COMPLFL`,
    `RANDFL`, `ENRLFL`); `type` values such as `"Char "` were padded the
    same way. The default `build_domain_spec("ADPP")` variable set is
    unchanged.
  - Labels over 40 characters now use the abbreviated form the guide
    publishes: SDTM Model 1.4-1.6 `--TESTCD` ("Short Name of Measurement,
    Test or Exam", as in SDTMIG 3.3 section 6.3.10.1) and `PPSTRESC` in
    SDTMIG 3.2 and 3.3 ("Character Result/Finding in Std Format", as in
    SDTMIG 3.3 section 6.3.11.2).
  - ADaMIG 1.2 `PBCHGCyN` is kept as the guide publishes it, "Percent Change
    to Baseline Category y (N)", which is 41 characters (ADaMIG v1.2 draft,
    section 3.3.4.1, Table 3.3.4.1.1; the sibling `PCHGCAyN` is published
    abbreviated). It is the one documented exception in the 40-character
    gate, an exact-match allow-list in `test-data_integrity.R`, so any other
    over-length label still fails. Shortening a label to fit an XPT file is
    for whoever writes the dataset, not for this package.
  - Five section sub-headings in the ADaMIG 1.0 combined ADSL table
    ("Study Identifiers", "Subject Demographics", ...) were transcribed as
    variables with no label; they are dropped (`ig_adam` is 851 rows, was
    856).
  - New gates in `tests/testthat/test-data_integrity.R`: no label in
    `ig_sdtm`/`ig_adam` is `NA`, contains a newline, or exceeds 40
    characters (bar the exception above); no variable name is `NA`, blank, or contains whitespace; no
    `type`/`core`/`codelist`/`role` value has stray whitespace.

## Newer SDTMIG PP and SUPP-- tables, and `get_ig` by domain

* `ig_sdtm` now carries the SDTMIG PP domain and generic SUPP-- structure at
  version 3.3 as well as 3.2, and `get_ig()` gains a `domain` argument
  (`get_ig("sdtm", version = "3.3", domain = "PP")`; for `"adam"` it matches
  the `dataset` column, `"ADSL"` or `"BDS"`). An unknown domain is a classed
  `cdiscdata_error_ig_domain_unavailable`.
* Checked against the published SDTMIG v3.3 (CDISC wiki PDF): its section
  6.3.11.2 PP specification is stamped "Version 3.2" and its revision history
  lists no PP change, so the PP table is unchanged between 3.2 and 3.3; the
  section 8.4.1 SUPP-- specification has the same ten variables. The 3.3
  tables are therefore the 3.2 ones.
* **Correction to the 0.2.0 notes.** They said `PPANMETH`, `EPOCH`,
  `PTAETORD`, and a `PPPDTC` rename were missing because only SDTMIG 3.2 was
  available. Checked against the published SDTMIG v3.3, that was wrong in
  three ways: `EPOCH`, `TAETORD` (not `PTAETORD`), and `PPDY` are in the PP
  table and were simply dropped from the Rsdtm 3.2 transcription (21 of 24
  rows), now added to both 3.2 and 3.3 in their published positions;
  `PPDTC` (not `PPPDTC`) is the published name; and `PPANMETH` is not in the
  3.3 PP table. `PPANMETH` and `PPTPTREF` are SDTMIG 3.4 additions, now
  confirmed against the 3.4 export below. nca.reporter's `PTAETORD`,
  `PPPDTC`, and `PPPDY` (seeded from aNCA) are not published SDTMIG names.

## Every domain of the newest SDTMIG

* `ig_sdtm` now carries all 63 domains of SDTMIG 3.4 (1917 variables), so
  `get_ig("sdtm", version = "3.4", domain = "PP")` works, and
  `build_domain_spec("PP")`, `build_domain_spec("SUPPPP")` and
  `build_domain_spec("ADPP", sdtm_domain = "PP")` default to 3.4. The 3.4 PP
  table has 26 variables: the 24 of 3.2/3.3 plus `PPANMETH` (Analysis
  Method, codelist `PKANMET`) and `PPTPTREF` (Time Point Reference), both
  Permissible; the default PP spec therefore grows from 24 to 26 variables,
  and the `sdtm_domain = "PP"` union adds 24 variables (22 with
  `sdtmig_version = "3.3"`). `class` is populated for the 3.4 rows.
* Source: a CDISC Library CSV export downloaded under CDISC's own terms and
  conditions, which is **not in this repository** and is never committed.
  `data-raw/build_ig_sdtm.R` reads it from `CDISC_SOURCES_DIR` (default
  `../cdisc-sources`) and stops with a message naming the expected file if it
  is absent, so the build is reproducible by anyone who obtains the export
  under their own CDISC terms. Only variable metadata is transcribed (order,
  class, domain, name, label, type, role, Core, codelist); the export's CDISC
  Notes text is not carried into the package data (`notes` is `NA` for the 3.4
  rows) and is read only to recover a stated maximum length as an integer.
  The export lists codelists as CDISC CT C-codes only; each first code is
  mapped to its submission value from the stored CT (4 of the 135 distinct
  first codes are for codelists since retired from the CT, and are named from
  their most recent historical header).
* All the existing gates (labels non-`NA`, newline-free and at most 40
  characters; names non-blank and whitespace-free; no stray whitespace in
  `type`/`core`/`codelist`/`role`) pass on every one of the 1917 rows with
  no problems found. New tests pin the 3.4 PP table, the domain count, that
  `notes` is empty, and that each domain's order is 1..n.

## ADPP: optional PP variables via `sdtm_domain`

* `build_domain_spec("ADPP", sdtm_domain = "PP")` also unions the SDTMIG PP
  domain's variables into the ADPP spec, the same way `adsl = TRUE` unions
  ADSL's, because a real ADPP carries PP's variables (`PPTESTCD`, `PPTEST`,
  ...). They are marked `source = "SDTMIG"` with `core = "Perm"`, a variable
  BDS or ADSL already defines (`STUDYID`, `USUBJID`) keeps that version, they
  are ordered after the existing rows, and their codelist ids resolve against
  the SDTM CT (the ADaM CT has none of PP's codelists): `PPTESTCD` C85839,
  `PPTEST` C85493, `PPORRESU`/`PPSTRESU` C85494, `PPSTAT` C66789, `PPSPEC`
  C78734, `EPOCH` C99079. 22 variables are added. `sdtmig_version` picks the
  SDTMIG version (default: newest). The default is `NULL`, which leaves the
  output unchanged. A value other than `"PP"` is a classed
  `cdiscdata_error_sdtm_domain_unavailable`; passing `sdtm_domain` or
  `sdtmig_version` where it has no effect is a classed
  `cdiscdata_warning_sdtm_domain_ignored`.

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
