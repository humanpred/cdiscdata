# IG source data: provenance and attribution

The CSV files under this directory are transcriptions of tables published in
CDISC's own SDTM Model, SDTMIG, and ADaMIG specification documents
(https://www.cdisc.org/standards), copied **read-only** from
[Bill Denney's Rsdtm package](https://github.com/humanpred/Rsdtm) (private,
`data-raw/`), where they were originally transcribed for that package's own
use. They are reproduced here, with this attribution, as the implementation
guide variable metadata behind `ig_sdtm`, `ig_adam`, and `get_ig()`; built by
`data-raw/build_ig_sdtm.R` and `data-raw/build_ig_adam.R`.

This differs from `cdiscdata`'s original design note that "Data that require
a CDISC Library API key (SDTM IG, ADaM IG) will be handled by a separate
`cdiscapi` package" (see the package README and `cran-comments.md`): no API
key is used here, only these public-source transcriptions, but the IG
metadata this enables is broader than the originally-scoped "public domain
only" CT/schema data. Flagged for Bill's review; the README has been updated
to describe this sourcing.

## Coverage

| Directory | Standard | Version(s) | Content |
|---|---|---|---|
| `sdtm_model/1.4` .. `1.7` | SDTM Model | 1.4, 1.5, 1.6, 1.7 | `Findings_Observation_Class.csv`: the Findings general-observation-class variables (PP and ADPP are Findings-class datasets) |
| `sdtmig_3.2` | SDTMIG | 3.2, and 3.3 (reuses these) | `PP-specification.csv` (the PP domain); `PP-additions.csv` (three PP rows missing from the Rsdtm transcription); `Supplemental_Qualifiers-specification.csv` (the generic SUPP-- structure used for SUPPPP) |
| `adamig_1.0`, `adamig_1.1`, `adamig_1.2` | ADaMIG | 1.0, 1.1, 1.2 | ADSL (subject-level) and BDS (Basic Data Structure, used by ADPP) variable tables, each split by Rsdtm into several category files (`ADSL_*` = ADSL, everything else = BDS) |

**SDTMIG coverage is limited to versions 3.2 and 3.3.** Rsdtm's
`SDTMIG_3.3` copy covers only CO, DM, SE, SM, and SV, not PP or Supplemental
Qualifiers, so the PP/SUPP-- tables come from its 3.2 transcription, and
`ig_sdtm` carries them for 3.3 as well because the published SDTMIG v3.3
(CDISC wiki PDF, https://wiki.cdisc.org/download/attachments/66274516/sdtmig_v3.3.pdf)
shows they did not change: its section 6.3.11.2 PP specification is stamped
"Version 3.2" and the revision history lists no PP change, and its section
8.4.1 SUPP-- specification has the same ten variables, labels, and types.

That PDF is a browser print of the web page and is cropped on the right, so it
shows each variable's name, label, type, codelist, and role but not Core or
the CDISC Notes. It also shows `TAETORD`, `EPOCH`, and `PPDY` in the PP table,
which the Rsdtm 3.2 transcription (21 of the 24 rows) lacks;
`sdtmig_3.2/PP-additions.csv` adds them in their published positions, with
Core "Permissible" taken from the Certara PKSubmit SDTM_3.2 appendix
(https://onlinehelp.certara.com/pksubmit/2.1/PKSubmit/Appendix/SDTM_3.2.htm)
because the PDF does not show it. Existing rows keep their Core from the
Rsdtm transcription.

## SDTMIG 3.4 (every domain, from a CDISC Library export)

SDTMIG 3.4 comes from `SDTMIG_v3.4.csv`, a CDISC Library CSV export (one row
per variable: Version, Variable Order, Class, Dataset Name, Variable Name,
Variable Label, Type, CDISC CT Codelist Code(s), Codelist Submission Values,
Described Value Domain(s), Value List, Role, CDISC Notes, Core; 1917 rows,
63 domains) that was downloaded under CDISC's own terms and conditions. That
file is **not in this repository and must never be committed or copied into
any repository**; `build_ig_sdtm.R` reads it from `CDISC_SOURCES_DIR`
(default `../cdisc-sources`, relative to the checkout) and stops with a
message naming the expected file if it is absent. Anyone reproducing the
build obtains the export under their own CDISC terms.

Only variable metadata is transcribed into `ig_sdtm`: order, class, domain,
variable name, label, type, role, Core, and the codelist. The CDISC Notes
column is not carried into the package data (`notes` is `NA` for these rows);
it is read only to recover, as an integer, a maximum length a note states.
The export gives codelists only as CDISC CT C-codes, so each variable's first
code is mapped to its submission value (e.g. `C85839` to `PKPARMCD`) from the
stored CT, using the most recent header row that carries the code because a
few codes (4 of the 135 distinct first codes) are for codelists since retired
from the CT; a code with no header anywhere stops the build. Where a variable
lists several codelists (e.g. PPORRESU: PKUNIT, PKUWG, ...) only the first is
kept, as for 3.2 and 3.3.

A newer SDTMIG's PP/SUPP-- tables from public sources can be added by copying
the equivalent CSVs into a new `sdtmig_<version>/` directory and adding the
version to `sdtmig_sources` in `data-raw/build_ig_sdtm.R`.

## Encoding

These files are Windows-1252 encoded (smart quotes, non-breaking spaces),
not UTF-8, as transcribed from Word/PDF source documents; `read_ig_csv()` in
`data-raw/utils_ig.R` reads them with `fileEncoding = "windows-1252"`
accordingly.

## Length

None of these source tables publish a variable Length column; CDISC
implementation guides do not fix one (length is a sponsor/define.xml
choice). `ig_sdtm$length` / `ig_adam$length` are `NA` except for the small
number of variables (PPTESTCD, PPTEST, ...) whose IG text explicitly states
a maximum character count, which `parse_documented_length()` recovers from
that text.

## Whitespace and labels

`read_ig_csv()` collapses every run of whitespace (hard line breaks and
non-breaking spaces from wrapped Word/PDF table cells included) in the
`variable`, `label`, `type`, `core`, `codelist`, and `role` fields, because a
wrapped cell otherwise keeps a literal newline and a cell with a trailing
space becomes a variable name such as `"--TESTCD "`. `notes` is left as is.

Labels in the IGs are limited to 40 characters (SDTMIG 3.3 section 4.2.1);
the few that transcribe longer are set in `sdtm_label_overrides`
(`build_ig_sdtm.R`) to the shorter form the guide itself publishes, with the
IG table each was checked against. The one label the guides publish longer
than 40 characters, ADaMIG 1.2 PBCHGCyN ("Percent Change to Baseline Category
y (N)", 41 characters), is kept as published and is the documented exception
in the gate: shortening a label is the dataset writer's job, not this
package's. `tests/testthat/test-data_integrity.R` gates all of this.
