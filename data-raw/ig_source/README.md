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
| `sdtmig_3.2` | SDTMIG | 3.2 | `PP-specification.csv` (the PP domain); `Supplemental_Qualifiers-specification.csv` (the generic SUPP-- structure used for SUPPPP) |
| `adamig_1.0`, `adamig_1.1`, `adamig_1.2` | ADaMIG | 1.0, 1.1, 1.2 | ADSL (subject-level) and BDS (Basic Data Structure, used by ADPP) variable tables, each split by Rsdtm into several category files (`ADSL_*` = ADSL, everything else = BDS) |

**SDTMIG coverage is limited to version 3.2.** Rsdtm's `SDTMIG_3.3` copy
covers only CO, DM, SE, SM, and SV — not PP or Supplemental Qualifiers — so
no newer SDTMIG version's PP/SUPP-- tables could be sourced this way. A
newer version can be added later by copying the equivalent
`PP-specification.csv` / `Supplemental_Qualifiers-specification.csv` into a
new `sdtmig_<version>/` directory here and extending the version list in
`data-raw/build_ig_sdtm.R`.

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
(`build_ig_sdtm.R`) and `adam_label_overrides` (`build_ig_adam.R`), each with
the IG table it was checked against. The ADaMIG 1.2 PBCHGCyN override is a
derived abbreviation, since the IG itself publishes 41 characters there.
`tests/testthat/test-data_integrity.R` gates all of this.
