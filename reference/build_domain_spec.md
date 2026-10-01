# Build a variable specification for PP, SUPPPP, or ADPP

Combines
[`get_ig`](https://humanpred.github.io/cdiscdata/reference/get_ig.md)
(variable name, label, type, core, order) with
[`get_ct`](https://humanpred.github.io/cdiscdata/reference/get_ct.md)
(codelist id lookup) into a single, ready-to-use variable specification
for one of the three PK datasets. `PP` and `SUPPPP` draw on the SDTMIG
(`SUPPPP` from the generic SUPP– structure, since CDISC has no
domain-specific SUPPPP table); `ADPP` draws on the ADaMIG BDS (Basic
Data Structure) table, since ADPP is a BDS dataset and CDISC has no
ADPP-specific table either, optionally unioned with the ADaMIG ADSL
table (see `adsl` below), since a real ADPP also carries ADSL's
subject-level variables.

## Usage

``` r
build_domain_spec(
  domain = c("PP", "SUPPPP", "ADPP"),
  ig_version = NULL,
  ct_version = NULL,
  adsl = TRUE
)
```

## Arguments

- domain:

  One of `"PP"`, `"SUPPPP"`, or `"ADPP"`.

- ig_version:

  IG version to use: an SDTMIG version (for `PP`/ `SUPPPP`) or an ADaMIG
  version (for `ADPP`). `NULL` uses the newest available for that IG.

- ct_version:

  CT version to resolve codelist ids against; passed to
  [`get_ct`](https://humanpred.github.io/cdiscdata/reference/get_ct.md).
  `NULL` uses the newest available.

- adsl:

  For `domain = "ADPP"` only: whether to union in the ADaMIG ADSL
  variables (default `TRUE`), since a real ADPP dataset carries ADSL's
  subject-level variables (treatment, demographics, ...) alongside its
  own BDS variables. `FALSE` returns the BDS variables alone. Ignored
  (with a warning) for `domain != "ADPP"`.

## Value

A data frame with columns `variable`, `label`, `type`, `length`, `core`,
`order`, `source` (`"SDTMIG"` for `PP`/`SUPPPP`; `"BDS"` or `"ADSL"` for
`ADPP`), and `codelist_id` (the codelist's CT C-code, e.g. `"C85839"`
for PPTESTCD's PKPARMCD codelist; `NA` when the variable has no codelist
or the referenced codelist name is not found in the CT version used).
ADSL-sourced `ADPP` rows have `core` forced to `"Perm"` regardless of
their Core designation in ADSL itself: from ADPP's perspective, merging
in an ADSL variable is a common but optional choice, not a requirement
ADSL's own Core reflects.

## Details

This does not add PP-inherited traceability variables (`PPTESTCD`,
`PPTEST`, and the rest of PP's variables that a BDS dataset built from
PP typically carries forward). Neither the ADaMIG BDS nor ADSL tables
define those; which of PP's variables to carry into ADPP, and under what
names, is a downstream derivation choice (e.g. admiral's own
conventions), not IG metadata this function can source.

## Examples

``` r
build_domain_spec("PP")
#>    variable                                       label type length core order
#> 1   STUDYID                            Study Identifier Char     NA  Req     1
#> 2    DOMAIN                         Domain Abbreviation Char     NA  Req     2
#> 3   USUBJID                   Unique Subject Identifier Char     NA  Req     3
#> 4     PPSEQ                             Sequence Number  Num     NA  Req     4
#> 5   PPGRPID                                    Group ID Char     NA Perm     5
#> 6  PPTESTCD                        Parameter Short Name Char      8  Req     6
#> 7    PPTEST                              Parameter Name Char     NA  Req     7
#> 8     PPCAT                          Parameter Category Char     NA  Exp     8
#> 9    PPSCAT                       Parameter Subcategory Char     NA Perm     9
#> 10  PPORRES        Result or Finding in Original\nUnits Char     NA  Exp    10
#> 11 PPORRESU                              Original Units Char     NA  Exp    11
#> 12 PPSTRESC Character Result/Finding in Standard Format Char     NA  Exp    12
#> 13 PPSTRESN    Numeric Result/Finding in Standard Units  Num     NA  Exp    13
#> 14 PPSTRESU                              Standard Units Char     NA  Exp    14
#> 15   PPSTAT                           Completion Status Char     NA Perm    15
#> 16 PPREASND             Reason Parameter Not Calculated Char     NA Perm    16
#> 17   PPSPEC                      Specimen Material Type Char     NA  Exp    17
#> 18    PPDTC         Date/Time of Parameter Calculations Char     NA Perm    18
#> 19 PPRFTDTC                Date/Time of Reference Point Char     NA  Exp    19
#> 20  PPSTINT       Planned Start of Assessment\nInterval Char     NA Perm    20
#> 21  PPENINT         Planned End of Assessment\nInterval Char     NA Perm    21
#>    source codelist_id
#> 1  SDTMIG        <NA>
#> 2  SDTMIG        <NA>
#> 3  SDTMIG        <NA>
#> 4  SDTMIG        <NA>
#> 5  SDTMIG        <NA>
#> 6  SDTMIG      C85839
#> 7  SDTMIG      C85493
#> 8  SDTMIG        <NA>
#> 9  SDTMIG        <NA>
#> 10 SDTMIG        <NA>
#> 11 SDTMIG      C85494
#> 12 SDTMIG        <NA>
#> 13 SDTMIG        <NA>
#> 14 SDTMIG      C85494
#> 15 SDTMIG      C66789
#> 16 SDTMIG        <NA>
#> 17 SDTMIG      C78734
#> 18 SDTMIG        <NA>
#> 19 SDTMIG        <NA>
#> 20 SDTMIG        <NA>
#> 21 SDTMIG        <NA>
build_domain_spec("SUPPPP")
#>    variable                       label type length core order source
#> 1   STUDYID            Study Identifier Char     NA  Req     1 SDTMIG
#> 2   RDOMAIN Related Domain Abbreviation Char     NA  Req     2 SDTMIG
#> 3   USUBJID  Unique\nSubject Identifier Char     NA  Req     3 SDTMIG
#> 4     IDVAR        Identifying Variable Char     NA  Exp     4 SDTMIG
#> 5  IDVARVAL  Identifying Variable Value Char     NA  Exp     5 SDTMIG
#> 6      QNAM     Qualifier Variable Name Char      8  Req     6 SDTMIG
#> 7    QLABEL    Qualifier Variable Label Char     40  Req     7 SDTMIG
#> 8      QVAL                  Data Value Char     NA  Req     8 SDTMIG
#> 9     QORIG                      Origin Char     NA  Req     9 SDTMIG
#> 10    QEVAL                   Evaluator Char     NA  Exp    10 SDTMIG
#>    codelist_id
#> 1         <NA>
#> 2       C66734
#> 3         <NA>
#> 4         <NA>
#> 5         <NA>
#> 6         <NA>
#> 7         <NA>
#> 8         <NA>
#> 9         <NA>
#> 10        <NA>
build_domain_spec("ADPP")               # BDS + ADSL (default)
#>     variable                                     label type length core order
#> 1      DTYPE                           Derivation Type Char     NA Cond     1
#> 2      CRITy                      Analysis Criterion y Char     NA Perm     1
#> 3    CRITyFL        Criterion y Evaluation Result Flag Char     NA Cond     2
#> 4    CRITyFN    Criterion y Evaluation Result Flag (N)  Num     NA Perm     3
#> 5     MCRITy      Analysis Multi- Response Criterion y Char     NA Perm     4
#> 6   MCRITyML    Multi- Response Criterion y Evaluation Char     NA Cond     5
#> 7   MCRITyMN      Multi- Response Criterion y Eval (N)  Num     NA Perm     6
#> 8      PARAM                                 Parameter Char     NA  Req     1
#> 9    PARAMCD                            Parameter Code Char     NA  Req     2
#> 10    PARAMN                             Parameter (N)  Num     NA Perm     3
#> 11   PARCATy                      Parameter Category y Char     NA Perm     4
#> 12  PARCATyN                  Parameter Category y (N)  Num     NA Perm     5
#> 13      AVAL                            Analysis Value  Num     NA Cond     6
#> 14     AVALC                        Analysis Value (C) Char     NA Cond     7
#> 15  AVALCATy                 Analysis Value Category y Char     NA Perm     8
#> 16  AVALCAyN             Analysis Value Category y (N)  Num     NA Perm     9
#> 17      BASE                            Baseline Value  Num     NA Cond    10
#> 18     BASEC                        Baseline Value (C) Char     NA Perm    11
#> 19  BASECATy                       Baseline Category y Char     NA Perm    12
#> 20  BASECAyN                   Baseline Category y (N)  Num     NA Perm    13
#> 21  BASETYPE                             Baseline Type Char     NA Cond    14
#> 22       CHG                      Change from Baseline  Num     NA Perm    15
#> 23   CHGCATy           Change from Baseline Category y Char     NA Perm    16
#> 24  CHGCATyN       Change from Baseline Category y (N)  Num     NA Perm    17
#> 25      PCHG              Percent Change from Baseline  Num     NA Perm    18
#> 26  PCHGCATy      Percent Chg from Baseline Category y Char     NA Perm    19
#> 27  PCHGCAyN  Percent Chg from Baseline Category y (N)  Num     NA Perm    20
#> 28    R2BASE                         Ratio to Baseline  Num     NA Perm    21
#> 29    R2AyLO     Ratio to Analysis Range y Lower Limit  Num     NA Perm    22
#> 30    R2AyHI     Ratio to Analysis Range y Upper Limit  Num     NA Perm    23
#> 31    SHIFTy                                   Shift y Char     NA Perm    24
#> 32   SHIFTyN                               Shift y (N)  Num     NA Perm    25
#> 33      BCHG                        Change to Baseline  Num     NA Perm    26
#> 34  BCHGCATy             Change to Baseline Category y Char     NA Perm    27
#> 35  BCHGCAyN         Change to Baseline Category y (N)  Num     NA Perm    28
#> 36     PBCHG                Percent Change to Baseline  Num     NA Perm    29
#> 37  PBCHGCAy     Percent Change to Baseline Category y Char     NA Perm    30
#> 38  PBCHGCyN Percent Change to Baseline Category y (N)  Num     NA Perm    31
#> 39   AWRANGE      Analysis Window Valid Relative Range Char     NA Perm     1
#> 40  AWTARGET                    Analysis Window Target  Num     NA Perm     2
#> 41   AWTDIFF          Analysis Window Diff from Target  Num     NA Perm     3
#> 42      AWLO       Analysis Window Beginning Timepoint  Num     NA Perm     4
#> 43      AWHI          Analysis Window Ending Timepoint  Num     NA Perm     5
#> 44       AWU                      Analysis Window Unit Char     NA Perm     6
#> 45    ITTRFL         Intent-To-Treat Record-Level Flag Char     NA Perm     1
#> 46    SAFRFL         Safety Analysis Record-Level Flag Char     NA Perm     2
#> 47    FASRFL       Full Analysis Set Record-Level Flag Char     NA Perm     3
#> 48  PPROTRFL            Per-Protocol Record-Level Flag Char     NA Perm     4
#> 49  COMPLRFL              Completers Record-Level Flag Char     NA Perm     5
#> 50    ITTPFL      Intent-To-Treat Parameter-Level Flag Char     NA Perm     6
#> 51    SAFPFL      Safety Analysis Parameter-Level Flag Char     NA Perm     7
#> 52    FASPFL    Full Analysis Set Parameter-Level Flag Char     NA Perm     8
#> 53  PPROTPFL         Per-Protocol Parameter-Level Flag Char     NA Perm     9
#> 54  COMPLPFL           Completers Parameter-Level Flag Char     NA Perm    10
#> 55    SRCDOM                               Source Data Char     NA Perm     1
#> 56    SRCVAR                           Source Variable Char     NA Perm     2
#> 57    SRCSEQ                    Source Sequence Number  Num     NA Perm     3
#> 58     ABLFL                      Baseline Record Flag Char     NA Cond     1
#> 59     ABLFN                  Baseline Record Flag (N)  Num     NA Perm     2
#> 60   ANLzzFL                          Analysis Flag zz Char     NA Cond     3
#> 61   ANLzzFN                      Analysis Flag zz (N)  Num     NA Perm     4
#> 62   ONTRTFL                  On Treatment Record Flag Char     NA Perm     5
#> 63   ONTRTFN              On Treatment Record Flag (N)  Num     NA Perm     6
#> 64    LVOTFL       Last Value On Treatment Record Flag Char     NA Perm     7
#> 65    LVOTFN   Last Value On Treatment Record Flag (N)  Num     NA Perm     8
#> 66   STUDYID                          Study Identifier Char     NA  Req     1
#> 67   USUBJID                 Unique Subject Identifier Char     NA  Req     2
#> 68    SUBJID          Subject Identifier for the Study Char     NA Perm     3
#> 69    SITEID                     Study Site Identifier Char     NA Perm     4
#> 70      ASEQ                  Analysis Sequence Number  Num     NA Perm     5
#> 71   APERSDT                         Period Start Date  Num     NA Perm     1
#> 72   APERSTM                         Period Start Time  Num     NA Perm     2
#> 73  APERSDTM                     Period Start Datetime  Num     NA Perm     3
#> 74  APERSDTF             Period Start Date Imput. Flag Char     NA Cond     4
#> 75  APERSTMF             Period Start Time Imput. Flag Char     NA Cond     5
#> 76   APEREDT                           Period End Date  Num     NA Perm     6
#> 77   APERETM                           Period End Time  Num     NA Perm     7
#> 78  APEREDTM                       Period End Datetime  Num     NA Perm     8
#> 79  APEREDTF               Period End Date Imput. Flag Char     NA Cond     9
#> 80  APERETMF               Period End Time Imput. Flag Char     NA Cond    10
#> 81   ASPRSDT                      Subperiod Start Date  Num     NA Perm    11
#> 82   ASPRSTM                      Subperiod Start Time  Num     NA Perm    12
#> 83  ASPRSDTM                  Subperiod Start Datetime  Num     NA Perm    13
#> 84  ASPRSDTF          Subperiod Start Date Imput. Flag Char     NA Cond    14
#> 85  ASPRSTMF          Subperiod Start Time Imput. Flag Char     NA Cond    15
#> 86   ASPREDT                        Subperiod End Date  Num     NA Perm    16
#> 87   ASPRETM                        Subperiod End Time  Num     NA Perm    17
#> 88  ASPREDTM                    Subperiod End Datetime  Num     NA Perm    18
#> 89  ASPREDTF            Subperiod End Date Imput. Flag Char     NA Cond    19
#> 90  ASPRETMF            Subperiod End Time Imput. Flag Char     NA Cond    20
#> 91     PHSDT                          Phase Start Date  Num     NA Perm    21
#> 92     PHSTM                          Phase Start Time  Num     NA Perm    22
#> 93    PHSDTM                      Phase Start Datetime  Num     NA Perm    23
#> 94    PHSDTF              Phase Start Date Imput. Flag Char     NA Cond    24
#> 95    PHSTMF              Phase Start Time Imput. Flag Char     NA Cond    25
#> 96     PHEDT                            Phase End Date  Num     NA Perm    26
#> 97     PHETM                            Phase End Time  Num     NA Perm    27
#> 98    PHEDTM                        Phase End Datetime  Num     NA Perm    28
#> 99    PHEDTF                Phase End Date Imput. Flag Char     NA Cond    29
#> 100   PHETMF                Phase End Time Imput. Flag Char     NA Cond    30
#> 101    DOSEP                    Planned Treatment Dose  Num     NA Perm     1
#> 102  DOSCUMP         Cumulative Planned Treatment Dose  Num     NA Perm     2
#> 103    DOSEA                     Actual Treatment Dose  Num     NA Perm     3
#> 104  DOSCUMA          Cumulative Actual Treatment Dose  Num     NA Perm     4
#> 105    DOSEU                      Treatment Dose Units Char     NA Perm     5
#> 106     TRTP                         Planned Treatment Char     NA Cond     1
#> 107    TRTPN                     Planned Treatment (N)  Num     NA Perm     2
#> 108     TRTA                          Actual Treatment Char     NA Cond     3
#> 109    TRTAN                      Actual Treatment (N)  Num     NA Perm     4
#> 110   TRTPGy                Planned Pooled Treatment y Char     NA Perm     5
#> 111  TRTPGyN            Planned Pooled Treatment y (N)  Num     NA Perm     6
#> 112   TRTAGy                 Actual Pooled Treatment y Char     NA Cond     7
#> 113  TRTAGyN             Actual Pooled Treatment y (N)  Num     NA Perm     8
#> 114  APxxSDT                      Period xx Start Date  Num     NA Perm     1
#> 115  APxxSTM                      Period xx Start Time  Num     NA Perm     2
#> 116 APxxSDTM                  Period xx Start Datetime  Num     NA Perm     3
#> 117 APxxSDTF          Period xx Start Date Imput. Flag Char     NA Cond     4
#> 118 APxxSTMF          Period xx Start Time Imput. Flag Char     NA Cond     5
#> 119  APxxEDT                        Period xx End Date  Num     NA Perm     6
#> 120  APxxETM                        Period xx End Time  Num     NA Perm     7
#> 121 APxxEDTM                    Period xx End Datetime  Num     NA Perm     8
#> 122 APxxEDTF            Period xx End Date Imput. Flag Char     NA Cond     9
#> 123 APxxETMF            Period xx End Time Imput. Flag Char     NA Cond    10
#> 124    PxxSw      Description of Period xx Subperiod w Char     NA Perm    11
#> 125 PxxSwSDT          Period xx Subperiod w Start Date  Num     NA Perm    12
#> 126 PxxSwSTM          Period xx Subperiod w Start Time  Num     NA Perm    13
#> 127 PxxSwSDM      Period xx Subperiod w Start Datetime  Num     NA Perm    14
#> 128 PxxSwSDF  Period xx Subper w Start Date Imput Flag Char     NA Cond    15
#> 129 PxxSwSTF  Period xx Subper w Start Time Imput Flag Char     NA Cond    16
#> 130 PxxSwEDT            Period xx Subperiod w End Date  Num     NA Perm    17
#> 131 PxxSwETM            Period xx Subperiod w End Time  Num     NA Perm    18
#> 132 PxxSwEDM        Period xx Subperiod w End Datetime  Num     NA Perm    19
#> 133 PxxSwEDF    Period xx Subper w End Date Imput Flag Char     NA Cond    20
#> 134 PxxSwETF    Period xx Subper w End Time Imput Flag Char     NA Cond    21
#> 135  APHASEw                    Description of Phase w Char     NA Perm    22
#> 136   PHwSDT                        Phase w Start Date  Num     NA Perm    23
#> 137   PHwSTM                        Phase w Start Time  Num     NA Perm    24
#> 138  PHwSDTM                    Phase w Start Datetime  Num     NA Perm    25
#> 139  PHwSDTF        Phase w Start Date Imputation Flag Char     NA Cond    26
#> 140  PHwSTMF        Phase w Start Time Imputation Flag Char     NA Cond    27
#> 141   PHwEDT                          Phase w End Date  Num     NA Perm    28
#> 142   PHwETM                          Phase w End Time  Num     NA Perm    29
#> 143  PHwEDTM                      Phase w End Datetime  Num     NA Perm    30
#> 144  PHwEDTF          Phase w End Date Imputation Flag Char     NA Cond    31
#> 145  PHwETMF          Phase w End Time Imputation Flag Char     NA Cond    32
#> 146      *DT                                    {Date}  Num     NA Perm     1
#> 147      *TM                                    {Time}  Num     NA Perm     2
#> 148     *DTM                                {Datetime}  Num     NA Perm     3
#> 149     *ADY                            {Relative Day}  Num     NA Perm     4
#> 150     *DTF                    {Date Imputation Flag} Char     NA Cond     5
#> 151     *TMF                    {Time Imputation Flag} Char     NA Cond     6
#> 152     *SDT                              {Start Date}  Num     NA Perm     7
#> 153     *STM                              {Start Time}  Num     NA Perm     8
#> 154    *SDTM                          {Start Datetime}  Num     NA Perm     9
#> 155     *SDY                      {Relative Start Day}  Num     NA Perm    10
#> 156    *SDTF              {Start Date Imputation Flag} Char     NA Cond    11
#> 157    *STMF              {Start Time Imputation Flag} Char     NA Cond    12
#> 158     *EDT                                {End Date}  Num     NA Perm    13
#> 159     *ETM                                {End Time}  Num     NA Perm    14
#> 160    *EDTM                            {End Datetime}  Num     NA Perm    15
#> 161     *EDY                        {Relative End Day}  Num     NA Perm    16
#> 162    *EDTF                {End Date Imputation Flag} Char     NA Cond    17
#> 163    *ETMF                {End Time Imputation Flag} Char     NA Cond    18
#> 164  STARTDT    Time-to- Event Origin Date for Subject  Num     NA Perm     1
#> 165 STARTDTM            Time-to- Event Origin Datetime  Num     NA Perm     2
#> 166 STARTDTF               Origin Date Imputation Flag Char     NA Cond     3
#> 167 STARTTMF               Origin Time Imputation Flag Char     NA Cond     4
#> 168     CNSR                                    Censor  Num     NA Cond     5
#> 169 EVNTDESC            Event or Censoring Description Char     NA Perm     6
#> 170 CNSDTDSC                   Censor Date Description Char     NA Perm     7
#> 171      ADT                             Analysis Date  Num     NA Perm     1
#> 172      ATM                             Analysis Time  Num     NA Perm     2
#> 173     ADTM                         Analysis Datetime  Num     NA Perm     3
#> 174      ADY                     Analysis Relative Day  Num     NA Perm     4
#> 175     ADTF             Analysis Date Imputation Flag Char     NA Cond     5
#> 176     ATMF             Analysis Time Imputation Flag Char     NA Cond     6
#> 177    ASTDT                       Analysis Start Date  Num     NA Perm     7
#> 178    ASTTM                       Analysis Start Time  Num     NA Perm     8
#> 179   ASTDTM                   Analysis Start Datetime  Num     NA Perm     9
#> 180    ASTDY               Analysis Start Relative Day  Num     NA Perm    10
#> 181   ASTDTF       Analysis Start Date Imputation Flag Char     NA Cond    11
#> 182   ASTTMF       Analysis Start Time Imputation Flag Char     NA Cond    12
#> 183    AENDT                         Analysis End Date  Num     NA Perm    13
#> 184    AENTM                         Analysis End Time  Num     NA Perm    14
#> 185   AENDTM                     Analysis End Datetime  Num     NA Perm    15
#> 186    AENDY                 Analysis End Relative Day  Num     NA Perm    16
#> 187   AENDTF         Analysis End Date Imputation Flag Char     NA Cond    17
#> 188   AENTMF         Analysis End Time Imputation Flag Char     NA Cond    18
#> 189   AVISIT                            Analysis Visit Char     NA Cond    19
#> 190  AVISITN                        Analysis Visit (N)  Num     NA Perm    20
#> 191     ATPT                        Analysis Timepoint Char     NA Cond    21
#> 192    ATPTN                    Analysis Timepoint (N)  Num     NA Perm    22
#> 193  ATPTREF              Analysis Timepoint Reference Char     NA Perm    23
#> 194   APHASE                                     Phase Char     NA Perm    24
#> 195  APHASEN                                 Phase (N)  Num     NA Perm    25
#> 196  APERIOD                                    Period  Num     NA Cond    26
#> 197 APERIODC                                Period (C) Char     NA Perm    27
#> 198    ASPER                   Subperiod within Period  Num     NA Perm    28
#> 199   ASPERC               Subperiod within Period (C) Char     NA Perm    29
#> 200   ARELTM                    Analysis Relative Time  Num     NA Perm    30
#> 201  ARELTMU               Analysis Relative Time Unit Char     NA Perm    31
#> 202   ATOXGR                   Analysis Toxicity Grade Char     NA Perm     1
#> 203  ATOXGRN               Analysis Toxicity Grade (N)  Num     NA Perm     2
#> 204   BTOXGR                   Baseline Toxicity Grade Char     NA Perm     3
#> 205  BTOXGRN               Baseline Toxicity Grade (N)  Num     NA Perm     4
#> 206   ANRIND        Analysis Reference Range Indicator Char     NA Perm     5
#> 207   BNRIND        Baseline Reference Range Indicator Char     NA Perm     6
#> 208    ANRLO         Analysis Normal Range Lower Limit  Num     NA Perm     7
#> 209   ANRLOC     Analysis Normal Range Lower Limit (C) Char     NA Perm     8
#> 210    ANRHI         Analysis Normal Range Upper Limit  Num     NA Perm     9
#> 211   ANRHIC     Analysis Normal Range Upper Limit (C) Char     NA Perm    10
#> 212     AyLO              Analysis Range y Lower Limit  Num     NA Cond    11
#> 213    AyLOC          Analysis Range y Lower Limit (C) Char     NA Perm    12
#> 214     AyHI              Analysis Range y Upper Limit  Num     NA Cond    13
#> 215    AyHIC          Analysis Range y Upper Limit (C) Char     NA Perm    14
#> 216    AyIND                Analysis Range y Indicator Char     NA Perm    15
#> 217    ByIND       Baseline Analysis Range y Indicator Char     NA Perm    16
#> 218  ATOXGRL               Analysis Toxicity Grade Low Char     NA Perm    17
#> 219 ATOXGRLN           Analysis Toxicity Grade Low (N)  Num     NA Perm    18
#> 220  ATOXGRH              Analysis Toxicity Grade High Char     NA Perm    19
#> 221 ATOXGRHN          Analysis Toxicity Grade High (N)  Num     NA Perm    20
#> 222  BTOXGRL               Baseline Toxicity Grade Low Char     NA Perm    21
#> 223 BTOXGRLN           Baseline Toxicity Grade Low (N)  Num     NA Perm    22
#> 224  BTOXGRH              Baseline Toxicity Grade High Char     NA Perm    23
#> 225 BTOXGRHN          Baseline Toxicity Grade High (N)  Num     NA Perm    24
#> 226 ATOXDSCL         Analysis Toxicity Description Low Char     NA Perm    25
#> 227 ATOXDSCH        Analysis Toxicity Description High Char     NA Perm    26
#> 228  DOSExxP      Planned Treatment Dose for Period xx  Num     NA Perm    33
#> 229  DOSExxA       Actual Treatment Dose for Period xx  Num     NA Perm    34
#> 230  DOSExxU              Units for Dose for Period xx Char     NA Perm    35
#> 231  SITEGRy                       Pooled Site Group y Char     NA Perm    36
#> 232 SITEGRyN                   Pooled Site Group y (N)  Num     NA Perm    37
#> 233  REGIONy                       Geographic Region y Char     NA Perm    38
#> 234 REGIONyN                   Geographic Region y (N)  Num     NA Perm    39
#> 235    FASFL         Full Analysis Set Population Flag Char     NA Perm    40
#> 236    SAFFL                    Safety Population Flag Char     NA Perm    41
#> 237    ITTFL           Intent-To-Treat Population Flag Char     NA Perm    42
#> 238  PPROTFL              Per-Protocol Population Flag Char     NA Perm    43
#> 239  COMPLFL                Completers Population Flag Char     NA Perm    44
#> 240   RANDFL                Randomized Population Flag Char     NA Perm    45
#> 241   ENRLFL                  Enrolled Population Flag Char     NA Perm    46
#> 242  STRATAR             Strata Used for Randomization Char     NA Perm    47
#> 243 STRATARN         Strata Used for Randomization (N)  Num     NA Perm    48
#> 244  STRATwD    Description of Stratification Factor w Char     NA Perm    49
#> 245  STRATwR        Strat Factor w Value Used for Rand Char     NA Perm    50
#> 246 STRATwRN    Strat Factor w Value Used for Rand (N)  Num     NA Perm    51
#> 247  STRATAV           Strata from Verification Source Char     NA Perm    52
#> 248 STRATAVN       Strata from Verification Source (N)  Num     NA Perm    53
#> 249  STRATwV    Strat Factor w Value from Verif Source Char     NA Perm    54
#> 250 STRATwVN   Strat Fact w Val from Verif  Source (N)  Num     NA Perm    55
#> 251      AGE                                       Age  Num     NA Perm    56
#> 252     AGEU                                 Age Units Char     NA Perm    57
#> 253   AGEGRy                        Pooled Age Group y Char     NA Perm    58
#> 254  AGEGRyN                    Pooled Age Group y (N)  Num     NA Perm    59
#> 255     AAGE                              Analysis Age  Num     NA Perm    60
#> 256      SEX                                       Sex Char     NA Perm    61
#> 257     RACE                                      Race Char     NA Perm    62
#> 258  RACEGRy                       Pooled Race Group y Char     NA Perm    63
#> 259 RACEGRyN                   Pooled Race Group y (N)  Num     NA Perm    64
#> 260   EOSSTT                       End of Study Status Char     NA Perm    65
#> 261    EOSDT                         End of Study Date  Num     NA Perm    66
#> 262  DCSREAS     Reason for Discontinuation from Study Char     NA Perm    67
#> 263 DCSREASP        Reason Spec for Discont from Study Char     NA Perm    68
#> 264   EOTSTT                   End of Treatment Status Char     NA Perm    69
#> 265  DCTREAS   Reason for Discontinuation of Treatment Char     NA Perm    70
#> 266 DCTREASP   Reason Specify for Discont of Treatment Char     NA Perm    71
#> 267 EOTxxSTT      End of Treatment Status in Period xx Char     NA Perm    72
#> 268  DCTxxRS  Reason for Discont of Treat in Period xx Char     NA Perm    73
#> 269 DCTxxRSP  Reason Spec for Disc of Trt in Period xx Char     NA Perm    74
#> 270 EOPxxSTT                   End of Period xx Status Char     NA Perm    75
#> 271  DCPxxRS         Reason for Discont from Period xx Char     NA Perm    76
#> 272 DCPxxRSP    Reason Spec for Discont from Period xx Char     NA Perm    77
#> 273   RFICDT                  Date of Informed Consent  Num     NA Perm    78
#> 274   ENRLDT                        Date of Enrollment  Num     NA Perm    79
#> 275   RANDDT                     Date of Randomization  Num     NA Perm    80
#> 276  RFICyDT                Date of Informed Consent y  Num     NA Perm    81
#> 277  ENRLyDT                      Date of Enrollment y  Num     NA Perm    82
#> 278  RANDyDT                   Date of Randomization y  Num     NA Perm    83
#> 279 LSTALVDT                     Date Last Known Alive  Num     NA Perm    84
#> 280    TRCMP                  Treatment Compliance (%)  Num     NA Perm    85
#> 281  TRCMPGy          Treatment Compliance (%) Group y Char     NA Perm    86
#> 282 TRCMPGyN      Treatment Compliance (%) Group y (N)  Num     NA Perm    87
#> 283 TRxxDURD    Treatment Duration in Period xx (Days)  Num     NA Perm    88
#> 284 TRxxDURM  Treatment Duration in Period xx (Months)  Num     NA Perm    89
#> 285 TRxxDURY   Treatment Duration in Period xx (Years)  Num     NA Perm    90
#> 286  TRTDURD           Total Treatment Duration (Days)  Num     NA Perm    91
#> 287  TRTDURM         Total Treatment Duration (Months)  Num     NA Perm    92
#> 288  TRTDURY          Total Treatment Duration (Years)  Num     NA Perm    93
#> 289    DTHDT                             Date of Death  Num     NA Perm    94
#> 290   DTHDTF             Date of Death Imputation Flag Char     NA Perm    95
#> 291  DTHCAUS                            Cause of Death Char     NA Perm    96
#> 292 DTHCAUSN                        Cause of Death (N)  Num     NA Perm    97
#> 293  DTHCGRy                    Cause of Death Group y Char     NA Perm    98
#> 294 DTHCGRyN                Cause of Death Group y (N)  Num     NA Perm    99
#> 295   TRTSDT       Date of First Exposure to Treatment  Num     NA Perm   100
#> 296   TRTSTM       Time of First Exposure to Treatment  Num     NA Perm   101
#> 297  TRTSDTM   Datetime of First Exposure to Treatment  Num     NA Perm   102
#> 298  TRTSDTF        Date of First Exposure Imput. Flag Char     NA Perm   103
#> 299  TRTSTMF        Time of First Exposure Imput. Flag Char     NA Perm   104
#> 300   TRTEDT        Date of Last Exposure to Treatment  Num     NA Perm   105
#> 301   TRTETM        Time of Last Exposure to Treatment  Num     NA Perm   106
#> 302  TRTEDTM    Datetime of Last Exposure to Treatment  Num     NA Perm   107
#> 303  TRTEDTF         Date of Last Exposure Imput. Flag Char     NA Perm   108
#> 304  TRTETMF         Time of Last Exposure Imput. Flag Char     NA Perm   109
#> 305  TRxxSDT       Date of First Exposure in Period xx  Num     NA Perm   110
#> 306  TRxxSTM       Time of First Exposure in Period xx  Num     NA Perm   111
#> 307 TRxxSDTM   Datetime of First Exposure in Period xx  Num     NA Perm   112
#> 308 TRxxSDTF   Date 1st Exposure Period xx Imput. Flag Char     NA Perm   113
#> 309 TRxxSTMF   Time 1st Exposure Period xx Imput. Flag Char     NA Perm   114
#> 310  TRxxEDT        Date of Last Exposure in Period xx  Num     NA Perm   115
#> 311  TRxxETM        Time of Last Exposure in Period xx  Num     NA Perm   116
#> 312 TRxxEDTM    Datetime of Last Exposure in Period xx  Num     NA Perm   117
#> 313 TRxxEDTF  Date Last Exposure Period xx Imput. Flag Char     NA Perm   118
#> 314 TRxxETMF  Time Last Exposure Period xx Imput. Flag Char     NA Perm   119
#> 315      ARM                Description of Planned Arm Char     NA Perm   120
#> 316   ACTARM                 Description of Actual Arm Char     NA Perm   121
#> 317   TRTxxP           Planned Treatment for Period xx Char     NA Perm   122
#> 318  TRTxxPN       Planned Treatment for Period xx (N)  Num     NA Perm   123
#> 319   TRTxxA            Actual Treatment for Period xx Char     NA Perm   124
#> 320  TRTxxAN        Actual Treatment for Period xx (N)  Num     NA Perm   125
#> 321  TRTSEQP            Planned Sequence of Treatments Char     NA Perm   126
#> 322 TRTSEQPN        Planned Sequence of Treatments (N)  Num     NA Perm   127
#> 323  TRTSEQA             Actual Sequence of Treatments Char     NA Perm   128
#> 324 TRTSEQAN         Actual Sequence of Treatments (N)  Num     NA Perm   129
#> 325  TRxxPGy  Planned Pooled Treatment y for Period xx Char     NA Perm   130
#> 326 TRxxPGyN    Planned Pooled Trt y for Period xx (N)  Num     NA Perm   131
#> 327  TRxxAGy   Actual Pooled Treatment y for Period xx Char     NA Perm   132
#> 328 TRxxAGyN     Actual Pooled Trt y for Period xx (N)  Num     NA Perm   133
#> 329  TSEQPGy       Planned Pooled Treatment Sequence y Char     NA Perm   134
#> 330 TSEQPGyN   Planned Pooled Treatment Sequence y (N)  Num     NA Perm   135
#> 331  TSEQAGy        Actual Pooled Treatment Sequence y Char     NA Perm   136
#> 332 TSEQAGyN    Actual Pooled Treatment Sequence y (N)  Num     NA Perm   137
#>     source codelist_id
#> 1      BDS      C81224
#> 2      BDS        <NA>
#> 3      BDS        <NA>
#> 4      BDS        <NA>
#> 5      BDS        <NA>
#> 6      BDS        <NA>
#> 7      BDS        <NA>
#> 8      BDS        <NA>
#> 9      BDS        <NA>
#> 10     BDS        <NA>
#> 11     BDS        <NA>
#> 12     BDS        <NA>
#> 13     BDS        <NA>
#> 14     BDS        <NA>
#> 15     BDS        <NA>
#> 16     BDS        <NA>
#> 17     BDS        <NA>
#> 18     BDS        <NA>
#> 19     BDS        <NA>
#> 20     BDS        <NA>
#> 21     BDS        <NA>
#> 22     BDS        <NA>
#> 23     BDS        <NA>
#> 24     BDS        <NA>
#> 25     BDS        <NA>
#> 26     BDS        <NA>
#> 27     BDS        <NA>
#> 28     BDS        <NA>
#> 29     BDS        <NA>
#> 30     BDS        <NA>
#> 31     BDS        <NA>
#> 32     BDS        <NA>
#> 33     BDS        <NA>
#> 34     BDS        <NA>
#> 35     BDS        <NA>
#> 36     BDS        <NA>
#> 37     BDS        <NA>
#> 38     BDS        <NA>
#> 39     BDS        <NA>
#> 40     BDS        <NA>
#> 41     BDS        <NA>
#> 42     BDS        <NA>
#> 43     BDS        <NA>
#> 44     BDS        <NA>
#> 45     BDS        <NA>
#> 46     BDS        <NA>
#> 47     BDS        <NA>
#> 48     BDS        <NA>
#> 49     BDS        <NA>
#> 50     BDS        <NA>
#> 51     BDS        <NA>
#> 52     BDS        <NA>
#> 53     BDS        <NA>
#> 54     BDS        <NA>
#> 55     BDS        <NA>
#> 56     BDS        <NA>
#> 57     BDS        <NA>
#> 58     BDS        <NA>
#> 59     BDS        <NA>
#> 60     BDS        <NA>
#> 61     BDS        <NA>
#> 62     BDS        <NA>
#> 63     BDS        <NA>
#> 64     BDS        <NA>
#> 65     BDS        <NA>
#> 66     BDS        <NA>
#> 67     BDS        <NA>
#> 68     BDS        <NA>
#> 69     BDS        <NA>
#> 70     BDS        <NA>
#> 71     BDS        <NA>
#> 72     BDS        <NA>
#> 73     BDS        <NA>
#> 74     BDS      C81223
#> 75     BDS      C81226
#> 76     BDS        <NA>
#> 77     BDS        <NA>
#> 78     BDS        <NA>
#> 79     BDS      C81223
#> 80     BDS      C81226
#> 81     BDS        <NA>
#> 82     BDS        <NA>
#> 83     BDS        <NA>
#> 84     BDS      C81223
#> 85     BDS      C81226
#> 86     BDS        <NA>
#> 87     BDS        <NA>
#> 88     BDS        <NA>
#> 89     BDS      C81223
#> 90     BDS      C81226
#> 91     BDS        <NA>
#> 92     BDS        <NA>
#> 93     BDS        <NA>
#> 94     BDS      C81223
#> 95     BDS      C81226
#> 96     BDS        <NA>
#> 97     BDS        <NA>
#> 98     BDS        <NA>
#> 99     BDS      C81223
#> 100    BDS      C81226
#> 101    BDS        <NA>
#> 102    BDS        <NA>
#> 103    BDS        <NA>
#> 104    BDS        <NA>
#> 105    BDS        <NA>
#> 106    BDS        <NA>
#> 107    BDS        <NA>
#> 108    BDS        <NA>
#> 109    BDS        <NA>
#> 110    BDS        <NA>
#> 111    BDS        <NA>
#> 112    BDS        <NA>
#> 113    BDS        <NA>
#> 114    BDS        <NA>
#> 115    BDS        <NA>
#> 116    BDS        <NA>
#> 117    BDS      C81223
#> 118    BDS      C81226
#> 119    BDS        <NA>
#> 120    BDS        <NA>
#> 121    BDS        <NA>
#> 122    BDS      C81223
#> 123    BDS      C81226
#> 124    BDS        <NA>
#> 125    BDS        <NA>
#> 126    BDS        <NA>
#> 127    BDS        <NA>
#> 128    BDS      C81223
#> 129    BDS      C81226
#> 130    BDS        <NA>
#> 131    BDS        <NA>
#> 132    BDS        <NA>
#> 133    BDS      C81223
#> 134    BDS      C81226
#> 135    BDS        <NA>
#> 136    BDS        <NA>
#> 137    BDS        <NA>
#> 138    BDS        <NA>
#> 139    BDS      C81223
#> 140    BDS      C81226
#> 141    BDS        <NA>
#> 142    BDS        <NA>
#> 143    BDS        <NA>
#> 144    BDS      C81223
#> 145    BDS      C81226
#> 146    BDS        <NA>
#> 147    BDS        <NA>
#> 148    BDS        <NA>
#> 149    BDS        <NA>
#> 150    BDS      C81223
#> 151    BDS      C81226
#> 152    BDS        <NA>
#> 153    BDS        <NA>
#> 154    BDS        <NA>
#> 155    BDS        <NA>
#> 156    BDS      C81223
#> 157    BDS      C81226
#> 158    BDS        <NA>
#> 159    BDS        <NA>
#> 160    BDS        <NA>
#> 161    BDS        <NA>
#> 162    BDS      C81223
#> 163    BDS      C81226
#> 164    BDS        <NA>
#> 165    BDS        <NA>
#> 166    BDS      C81223
#> 167    BDS      C81226
#> 168    BDS        <NA>
#> 169    BDS        <NA>
#> 170    BDS        <NA>
#> 171    BDS        <NA>
#> 172    BDS        <NA>
#> 173    BDS        <NA>
#> 174    BDS        <NA>
#> 175    BDS      C81223
#> 176    BDS      C81226
#> 177    BDS        <NA>
#> 178    BDS        <NA>
#> 179    BDS        <NA>
#> 180    BDS        <NA>
#> 181    BDS      C81223
#> 182    BDS      C81226
#> 183    BDS        <NA>
#> 184    BDS        <NA>
#> 185    BDS        <NA>
#> 186    BDS        <NA>
#> 187    BDS      C81223
#> 188    BDS      C81226
#> 189    BDS        <NA>
#> 190    BDS        <NA>
#> 191    BDS        <NA>
#> 192    BDS        <NA>
#> 193    BDS        <NA>
#> 194    BDS        <NA>
#> 195    BDS        <NA>
#> 196    BDS        <NA>
#> 197    BDS        <NA>
#> 198    BDS        <NA>
#> 199    BDS        <NA>
#> 200    BDS        <NA>
#> 201    BDS        <NA>
#> 202    BDS        <NA>
#> 203    BDS        <NA>
#> 204    BDS        <NA>
#> 205    BDS        <NA>
#> 206    BDS        <NA>
#> 207    BDS        <NA>
#> 208    BDS        <NA>
#> 209    BDS        <NA>
#> 210    BDS        <NA>
#> 211    BDS        <NA>
#> 212    BDS        <NA>
#> 213    BDS        <NA>
#> 214    BDS        <NA>
#> 215    BDS        <NA>
#> 216    BDS        <NA>
#> 217    BDS        <NA>
#> 218    BDS        <NA>
#> 219    BDS        <NA>
#> 220    BDS        <NA>
#> 221    BDS        <NA>
#> 222    BDS        <NA>
#> 223    BDS        <NA>
#> 224    BDS        <NA>
#> 225    BDS        <NA>
#> 226    BDS        <NA>
#> 227    BDS        <NA>
#> 228   ADSL        <NA>
#> 229   ADSL        <NA>
#> 230   ADSL        <NA>
#> 231   ADSL        <NA>
#> 232   ADSL        <NA>
#> 233   ADSL        <NA>
#> 234   ADSL        <NA>
#> 235   ADSL        <NA>
#> 236   ADSL        <NA>
#> 237   ADSL        <NA>
#> 238   ADSL        <NA>
#> 239   ADSL        <NA>
#> 240   ADSL        <NA>
#> 241   ADSL        <NA>
#> 242   ADSL        <NA>
#> 243   ADSL        <NA>
#> 244   ADSL        <NA>
#> 245   ADSL        <NA>
#> 246   ADSL        <NA>
#> 247   ADSL        <NA>
#> 248   ADSL        <NA>
#> 249   ADSL        <NA>
#> 250   ADSL        <NA>
#> 251   ADSL        <NA>
#> 252   ADSL      C66781
#> 253   ADSL        <NA>
#> 254   ADSL        <NA>
#> 255   ADSL        <NA>
#> 256   ADSL      C66731
#> 257   ADSL        <NA>
#> 258   ADSL        <NA>
#> 259   ADSL        <NA>
#> 260   ADSL     C124296
#> 261   ADSL        <NA>
#> 262   ADSL        <NA>
#> 263   ADSL        <NA>
#> 264   ADSL     C124296
#> 265   ADSL        <NA>
#> 266   ADSL        <NA>
#> 267   ADSL     C124296
#> 268   ADSL        <NA>
#> 269   ADSL        <NA>
#> 270   ADSL     C124296
#> 271   ADSL        <NA>
#> 272   ADSL        <NA>
#> 273   ADSL        <NA>
#> 274   ADSL        <NA>
#> 275   ADSL        <NA>
#> 276   ADSL        <NA>
#> 277   ADSL        <NA>
#> 278   ADSL        <NA>
#> 279   ADSL        <NA>
#> 280   ADSL        <NA>
#> 281   ADSL        <NA>
#> 282   ADSL        <NA>
#> 283   ADSL        <NA>
#> 284   ADSL        <NA>
#> 285   ADSL        <NA>
#> 286   ADSL        <NA>
#> 287   ADSL        <NA>
#> 288   ADSL        <NA>
#> 289   ADSL        <NA>
#> 290   ADSL      C81223
#> 291   ADSL        <NA>
#> 292   ADSL        <NA>
#> 293   ADSL        <NA>
#> 294   ADSL        <NA>
#> 295   ADSL        <NA>
#> 296   ADSL        <NA>
#> 297   ADSL        <NA>
#> 298   ADSL      C81223
#> 299   ADSL      C81226
#> 300   ADSL        <NA>
#> 301   ADSL        <NA>
#> 302   ADSL        <NA>
#> 303   ADSL      C81223
#> 304   ADSL      C81226
#> 305   ADSL        <NA>
#> 306   ADSL        <NA>
#> 307   ADSL        <NA>
#> 308   ADSL      C81223
#> 309   ADSL      C81226
#> 310   ADSL        <NA>
#> 311   ADSL        <NA>
#> 312   ADSL        <NA>
#> 313   ADSL      C81223
#> 314   ADSL      C81226
#> 315   ADSL        <NA>
#> 316   ADSL        <NA>
#> 317   ADSL        <NA>
#> 318   ADSL        <NA>
#> 319   ADSL        <NA>
#> 320   ADSL        <NA>
#> 321   ADSL        <NA>
#> 322   ADSL        <NA>
#> 323   ADSL        <NA>
#> 324   ADSL        <NA>
#> 325   ADSL        <NA>
#> 326   ADSL        <NA>
#> 327   ADSL        <NA>
#> 328   ADSL        <NA>
#> 329   ADSL        <NA>
#> 330   ADSL        <NA>
#> 331   ADSL        <NA>
#> 332   ADSL        <NA>
build_domain_spec("ADPP", adsl = FALSE) # BDS only
#>     variable                                     label type length core order
#> 1      DTYPE                           Derivation Type Char     NA Cond     1
#> 2      CRITy                      Analysis Criterion y Char     NA Perm     1
#> 3    CRITyFL        Criterion y Evaluation Result Flag Char     NA Cond     2
#> 4    CRITyFN    Criterion y Evaluation Result Flag (N)  Num     NA Perm     3
#> 5     MCRITy      Analysis Multi- Response Criterion y Char     NA Perm     4
#> 6   MCRITyML    Multi- Response Criterion y Evaluation Char     NA Cond     5
#> 7   MCRITyMN      Multi- Response Criterion y Eval (N)  Num     NA Perm     6
#> 8      PARAM                                 Parameter Char     NA  Req     1
#> 9    PARAMCD                            Parameter Code Char     NA  Req     2
#> 10    PARAMN                             Parameter (N)  Num     NA Perm     3
#> 11   PARCATy                      Parameter Category y Char     NA Perm     4
#> 12  PARCATyN                  Parameter Category y (N)  Num     NA Perm     5
#> 13      AVAL                            Analysis Value  Num     NA Cond     6
#> 14     AVALC                        Analysis Value (C) Char     NA Cond     7
#> 15  AVALCATy                 Analysis Value Category y Char     NA Perm     8
#> 16  AVALCAyN             Analysis Value Category y (N)  Num     NA Perm     9
#> 17      BASE                            Baseline Value  Num     NA Cond    10
#> 18     BASEC                        Baseline Value (C) Char     NA Perm    11
#> 19  BASECATy                       Baseline Category y Char     NA Perm    12
#> 20  BASECAyN                   Baseline Category y (N)  Num     NA Perm    13
#> 21  BASETYPE                             Baseline Type Char     NA Cond    14
#> 22       CHG                      Change from Baseline  Num     NA Perm    15
#> 23   CHGCATy           Change from Baseline Category y Char     NA Perm    16
#> 24  CHGCATyN       Change from Baseline Category y (N)  Num     NA Perm    17
#> 25      PCHG              Percent Change from Baseline  Num     NA Perm    18
#> 26  PCHGCATy      Percent Chg from Baseline Category y Char     NA Perm    19
#> 27  PCHGCAyN  Percent Chg from Baseline Category y (N)  Num     NA Perm    20
#> 28    R2BASE                         Ratio to Baseline  Num     NA Perm    21
#> 29    R2AyLO     Ratio to Analysis Range y Lower Limit  Num     NA Perm    22
#> 30    R2AyHI     Ratio to Analysis Range y Upper Limit  Num     NA Perm    23
#> 31    SHIFTy                                   Shift y Char     NA Perm    24
#> 32   SHIFTyN                               Shift y (N)  Num     NA Perm    25
#> 33      BCHG                        Change to Baseline  Num     NA Perm    26
#> 34  BCHGCATy             Change to Baseline Category y Char     NA Perm    27
#> 35  BCHGCAyN         Change to Baseline Category y (N)  Num     NA Perm    28
#> 36     PBCHG                Percent Change to Baseline  Num     NA Perm    29
#> 37  PBCHGCAy     Percent Change to Baseline Category y Char     NA Perm    30
#> 38  PBCHGCyN Percent Change to Baseline Category y (N)  Num     NA Perm    31
#> 39   AWRANGE      Analysis Window Valid Relative Range Char     NA Perm     1
#> 40  AWTARGET                    Analysis Window Target  Num     NA Perm     2
#> 41   AWTDIFF          Analysis Window Diff from Target  Num     NA Perm     3
#> 42      AWLO       Analysis Window Beginning Timepoint  Num     NA Perm     4
#> 43      AWHI          Analysis Window Ending Timepoint  Num     NA Perm     5
#> 44       AWU                      Analysis Window Unit Char     NA Perm     6
#> 45    ITTRFL         Intent-To-Treat Record-Level Flag Char     NA Perm     1
#> 46    SAFRFL         Safety Analysis Record-Level Flag Char     NA Perm     2
#> 47    FASRFL       Full Analysis Set Record-Level Flag Char     NA Perm     3
#> 48  PPROTRFL            Per-Protocol Record-Level Flag Char     NA Perm     4
#> 49  COMPLRFL              Completers Record-Level Flag Char     NA Perm     5
#> 50    ITTPFL      Intent-To-Treat Parameter-Level Flag Char     NA Perm     6
#> 51    SAFPFL      Safety Analysis Parameter-Level Flag Char     NA Perm     7
#> 52    FASPFL    Full Analysis Set Parameter-Level Flag Char     NA Perm     8
#> 53  PPROTPFL         Per-Protocol Parameter-Level Flag Char     NA Perm     9
#> 54  COMPLPFL           Completers Parameter-Level Flag Char     NA Perm    10
#> 55    SRCDOM                               Source Data Char     NA Perm     1
#> 56    SRCVAR                           Source Variable Char     NA Perm     2
#> 57    SRCSEQ                    Source Sequence Number  Num     NA Perm     3
#> 58     ABLFL                      Baseline Record Flag Char     NA Cond     1
#> 59     ABLFN                  Baseline Record Flag (N)  Num     NA Perm     2
#> 60   ANLzzFL                          Analysis Flag zz Char     NA Cond     3
#> 61   ANLzzFN                      Analysis Flag zz (N)  Num     NA Perm     4
#> 62   ONTRTFL                  On Treatment Record Flag Char     NA Perm     5
#> 63   ONTRTFN              On Treatment Record Flag (N)  Num     NA Perm     6
#> 64    LVOTFL       Last Value On Treatment Record Flag Char     NA Perm     7
#> 65    LVOTFN   Last Value On Treatment Record Flag (N)  Num     NA Perm     8
#> 66   STUDYID                          Study Identifier Char     NA  Req     1
#> 67   USUBJID                 Unique Subject Identifier Char     NA  Req     2
#> 68    SUBJID          Subject Identifier for the Study Char     NA Perm     3
#> 69    SITEID                     Study Site Identifier Char     NA Perm     4
#> 70      ASEQ                  Analysis Sequence Number  Num     NA Perm     5
#> 71   APERSDT                         Period Start Date  Num     NA Perm     1
#> 72   APERSTM                         Period Start Time  Num     NA Perm     2
#> 73  APERSDTM                     Period Start Datetime  Num     NA Perm     3
#> 74  APERSDTF             Period Start Date Imput. Flag Char     NA Cond     4
#> 75  APERSTMF             Period Start Time Imput. Flag Char     NA Cond     5
#> 76   APEREDT                           Period End Date  Num     NA Perm     6
#> 77   APERETM                           Period End Time  Num     NA Perm     7
#> 78  APEREDTM                       Period End Datetime  Num     NA Perm     8
#> 79  APEREDTF               Period End Date Imput. Flag Char     NA Cond     9
#> 80  APERETMF               Period End Time Imput. Flag Char     NA Cond    10
#> 81   ASPRSDT                      Subperiod Start Date  Num     NA Perm    11
#> 82   ASPRSTM                      Subperiod Start Time  Num     NA Perm    12
#> 83  ASPRSDTM                  Subperiod Start Datetime  Num     NA Perm    13
#> 84  ASPRSDTF          Subperiod Start Date Imput. Flag Char     NA Cond    14
#> 85  ASPRSTMF          Subperiod Start Time Imput. Flag Char     NA Cond    15
#> 86   ASPREDT                        Subperiod End Date  Num     NA Perm    16
#> 87   ASPRETM                        Subperiod End Time  Num     NA Perm    17
#> 88  ASPREDTM                    Subperiod End Datetime  Num     NA Perm    18
#> 89  ASPREDTF            Subperiod End Date Imput. Flag Char     NA Cond    19
#> 90  ASPRETMF            Subperiod End Time Imput. Flag Char     NA Cond    20
#> 91     PHSDT                          Phase Start Date  Num     NA Perm    21
#> 92     PHSTM                          Phase Start Time  Num     NA Perm    22
#> 93    PHSDTM                      Phase Start Datetime  Num     NA Perm    23
#> 94    PHSDTF              Phase Start Date Imput. Flag Char     NA Cond    24
#> 95    PHSTMF              Phase Start Time Imput. Flag Char     NA Cond    25
#> 96     PHEDT                            Phase End Date  Num     NA Perm    26
#> 97     PHETM                            Phase End Time  Num     NA Perm    27
#> 98    PHEDTM                        Phase End Datetime  Num     NA Perm    28
#> 99    PHEDTF                Phase End Date Imput. Flag Char     NA Cond    29
#> 100   PHETMF                Phase End Time Imput. Flag Char     NA Cond    30
#> 101    DOSEP                    Planned Treatment Dose  Num     NA Perm     1
#> 102  DOSCUMP         Cumulative Planned Treatment Dose  Num     NA Perm     2
#> 103    DOSEA                     Actual Treatment Dose  Num     NA Perm     3
#> 104  DOSCUMA          Cumulative Actual Treatment Dose  Num     NA Perm     4
#> 105    DOSEU                      Treatment Dose Units Char     NA Perm     5
#> 106     TRTP                         Planned Treatment Char     NA Cond     1
#> 107    TRTPN                     Planned Treatment (N)  Num     NA Perm     2
#> 108     TRTA                          Actual Treatment Char     NA Cond     3
#> 109    TRTAN                      Actual Treatment (N)  Num     NA Perm     4
#> 110   TRTPGy                Planned Pooled Treatment y Char     NA Perm     5
#> 111  TRTPGyN            Planned Pooled Treatment y (N)  Num     NA Perm     6
#> 112   TRTAGy                 Actual Pooled Treatment y Char     NA Cond     7
#> 113  TRTAGyN             Actual Pooled Treatment y (N)  Num     NA Perm     8
#> 114  APxxSDT                      Period xx Start Date  Num     NA Perm     1
#> 115  APxxSTM                      Period xx Start Time  Num     NA Perm     2
#> 116 APxxSDTM                  Period xx Start Datetime  Num     NA Perm     3
#> 117 APxxSDTF          Period xx Start Date Imput. Flag Char     NA Cond     4
#> 118 APxxSTMF          Period xx Start Time Imput. Flag Char     NA Cond     5
#> 119  APxxEDT                        Period xx End Date  Num     NA Perm     6
#> 120  APxxETM                        Period xx End Time  Num     NA Perm     7
#> 121 APxxEDTM                    Period xx End Datetime  Num     NA Perm     8
#> 122 APxxEDTF            Period xx End Date Imput. Flag Char     NA Cond     9
#> 123 APxxETMF            Period xx End Time Imput. Flag Char     NA Cond    10
#> 124    PxxSw      Description of Period xx Subperiod w Char     NA Perm    11
#> 125 PxxSwSDT          Period xx Subperiod w Start Date  Num     NA Perm    12
#> 126 PxxSwSTM          Period xx Subperiod w Start Time  Num     NA Perm    13
#> 127 PxxSwSDM      Period xx Subperiod w Start Datetime  Num     NA Perm    14
#> 128 PxxSwSDF  Period xx Subper w Start Date Imput Flag Char     NA Cond    15
#> 129 PxxSwSTF  Period xx Subper w Start Time Imput Flag Char     NA Cond    16
#> 130 PxxSwEDT            Period xx Subperiod w End Date  Num     NA Perm    17
#> 131 PxxSwETM            Period xx Subperiod w End Time  Num     NA Perm    18
#> 132 PxxSwEDM        Period xx Subperiod w End Datetime  Num     NA Perm    19
#> 133 PxxSwEDF    Period xx Subper w End Date Imput Flag Char     NA Cond    20
#> 134 PxxSwETF    Period xx Subper w End Time Imput Flag Char     NA Cond    21
#> 135  APHASEw                    Description of Phase w Char     NA Perm    22
#> 136   PHwSDT                        Phase w Start Date  Num     NA Perm    23
#> 137   PHwSTM                        Phase w Start Time  Num     NA Perm    24
#> 138  PHwSDTM                    Phase w Start Datetime  Num     NA Perm    25
#> 139  PHwSDTF        Phase w Start Date Imputation Flag Char     NA Cond    26
#> 140  PHwSTMF        Phase w Start Time Imputation Flag Char     NA Cond    27
#> 141   PHwEDT                          Phase w End Date  Num     NA Perm    28
#> 142   PHwETM                          Phase w End Time  Num     NA Perm    29
#> 143  PHwEDTM                      Phase w End Datetime  Num     NA Perm    30
#> 144  PHwEDTF          Phase w End Date Imputation Flag Char     NA Cond    31
#> 145  PHwETMF          Phase w End Time Imputation Flag Char     NA Cond    32
#> 146      *DT                                    {Date}  Num     NA Perm     1
#> 147      *TM                                    {Time}  Num     NA Perm     2
#> 148     *DTM                                {Datetime}  Num     NA Perm     3
#> 149     *ADY                            {Relative Day}  Num     NA Perm     4
#> 150     *DTF                    {Date Imputation Flag} Char     NA Cond     5
#> 151     *TMF                    {Time Imputation Flag} Char     NA Cond     6
#> 152     *SDT                              {Start Date}  Num     NA Perm     7
#> 153     *STM                              {Start Time}  Num     NA Perm     8
#> 154    *SDTM                          {Start Datetime}  Num     NA Perm     9
#> 155     *SDY                      {Relative Start Day}  Num     NA Perm    10
#> 156    *SDTF              {Start Date Imputation Flag} Char     NA Cond    11
#> 157    *STMF              {Start Time Imputation Flag} Char     NA Cond    12
#> 158     *EDT                                {End Date}  Num     NA Perm    13
#> 159     *ETM                                {End Time}  Num     NA Perm    14
#> 160    *EDTM                            {End Datetime}  Num     NA Perm    15
#> 161     *EDY                        {Relative End Day}  Num     NA Perm    16
#> 162    *EDTF                {End Date Imputation Flag} Char     NA Cond    17
#> 163    *ETMF                {End Time Imputation Flag} Char     NA Cond    18
#> 164  STARTDT    Time-to- Event Origin Date for Subject  Num     NA Perm     1
#> 165 STARTDTM            Time-to- Event Origin Datetime  Num     NA Perm     2
#> 166 STARTDTF               Origin Date Imputation Flag Char     NA Cond     3
#> 167 STARTTMF               Origin Time Imputation Flag Char     NA Cond     4
#> 168     CNSR                                    Censor  Num     NA Cond     5
#> 169 EVNTDESC            Event or Censoring Description Char     NA Perm     6
#> 170 CNSDTDSC                   Censor Date Description Char     NA Perm     7
#> 171      ADT                             Analysis Date  Num     NA Perm     1
#> 172      ATM                             Analysis Time  Num     NA Perm     2
#> 173     ADTM                         Analysis Datetime  Num     NA Perm     3
#> 174      ADY                     Analysis Relative Day  Num     NA Perm     4
#> 175     ADTF             Analysis Date Imputation Flag Char     NA Cond     5
#> 176     ATMF             Analysis Time Imputation Flag Char     NA Cond     6
#> 177    ASTDT                       Analysis Start Date  Num     NA Perm     7
#> 178    ASTTM                       Analysis Start Time  Num     NA Perm     8
#> 179   ASTDTM                   Analysis Start Datetime  Num     NA Perm     9
#> 180    ASTDY               Analysis Start Relative Day  Num     NA Perm    10
#> 181   ASTDTF       Analysis Start Date Imputation Flag Char     NA Cond    11
#> 182   ASTTMF       Analysis Start Time Imputation Flag Char     NA Cond    12
#> 183    AENDT                         Analysis End Date  Num     NA Perm    13
#> 184    AENTM                         Analysis End Time  Num     NA Perm    14
#> 185   AENDTM                     Analysis End Datetime  Num     NA Perm    15
#> 186    AENDY                 Analysis End Relative Day  Num     NA Perm    16
#> 187   AENDTF         Analysis End Date Imputation Flag Char     NA Cond    17
#> 188   AENTMF         Analysis End Time Imputation Flag Char     NA Cond    18
#> 189   AVISIT                            Analysis Visit Char     NA Cond    19
#> 190  AVISITN                        Analysis Visit (N)  Num     NA Perm    20
#> 191     ATPT                        Analysis Timepoint Char     NA Cond    21
#> 192    ATPTN                    Analysis Timepoint (N)  Num     NA Perm    22
#> 193  ATPTREF              Analysis Timepoint Reference Char     NA Perm    23
#> 194   APHASE                                     Phase Char     NA Perm    24
#> 195  APHASEN                                 Phase (N)  Num     NA Perm    25
#> 196  APERIOD                                    Period  Num     NA Cond    26
#> 197 APERIODC                                Period (C) Char     NA Perm    27
#> 198    ASPER                   Subperiod within Period  Num     NA Perm    28
#> 199   ASPERC               Subperiod within Period (C) Char     NA Perm    29
#> 200   ARELTM                    Analysis Relative Time  Num     NA Perm    30
#> 201  ARELTMU               Analysis Relative Time Unit Char     NA Perm    31
#> 202   ATOXGR                   Analysis Toxicity Grade Char     NA Perm     1
#> 203  ATOXGRN               Analysis Toxicity Grade (N)  Num     NA Perm     2
#> 204   BTOXGR                   Baseline Toxicity Grade Char     NA Perm     3
#> 205  BTOXGRN               Baseline Toxicity Grade (N)  Num     NA Perm     4
#> 206   ANRIND        Analysis Reference Range Indicator Char     NA Perm     5
#> 207   BNRIND        Baseline Reference Range Indicator Char     NA Perm     6
#> 208    ANRLO         Analysis Normal Range Lower Limit  Num     NA Perm     7
#> 209   ANRLOC     Analysis Normal Range Lower Limit (C) Char     NA Perm     8
#> 210    ANRHI         Analysis Normal Range Upper Limit  Num     NA Perm     9
#> 211   ANRHIC     Analysis Normal Range Upper Limit (C) Char     NA Perm    10
#> 212     AyLO              Analysis Range y Lower Limit  Num     NA Cond    11
#> 213    AyLOC          Analysis Range y Lower Limit (C) Char     NA Perm    12
#> 214     AyHI              Analysis Range y Upper Limit  Num     NA Cond    13
#> 215    AyHIC          Analysis Range y Upper Limit (C) Char     NA Perm    14
#> 216    AyIND                Analysis Range y Indicator Char     NA Perm    15
#> 217    ByIND       Baseline Analysis Range y Indicator Char     NA Perm    16
#> 218  ATOXGRL               Analysis Toxicity Grade Low Char     NA Perm    17
#> 219 ATOXGRLN           Analysis Toxicity Grade Low (N)  Num     NA Perm    18
#> 220  ATOXGRH              Analysis Toxicity Grade High Char     NA Perm    19
#> 221 ATOXGRHN          Analysis Toxicity Grade High (N)  Num     NA Perm    20
#> 222  BTOXGRL               Baseline Toxicity Grade Low Char     NA Perm    21
#> 223 BTOXGRLN           Baseline Toxicity Grade Low (N)  Num     NA Perm    22
#> 224  BTOXGRH              Baseline Toxicity Grade High Char     NA Perm    23
#> 225 BTOXGRHN          Baseline Toxicity Grade High (N)  Num     NA Perm    24
#> 226 ATOXDSCL         Analysis Toxicity Description Low Char     NA Perm    25
#> 227 ATOXDSCH        Analysis Toxicity Description High Char     NA Perm    26
#>     source codelist_id
#> 1      BDS      C81224
#> 2      BDS        <NA>
#> 3      BDS        <NA>
#> 4      BDS        <NA>
#> 5      BDS        <NA>
#> 6      BDS        <NA>
#> 7      BDS        <NA>
#> 8      BDS        <NA>
#> 9      BDS        <NA>
#> 10     BDS        <NA>
#> 11     BDS        <NA>
#> 12     BDS        <NA>
#> 13     BDS        <NA>
#> 14     BDS        <NA>
#> 15     BDS        <NA>
#> 16     BDS        <NA>
#> 17     BDS        <NA>
#> 18     BDS        <NA>
#> 19     BDS        <NA>
#> 20     BDS        <NA>
#> 21     BDS        <NA>
#> 22     BDS        <NA>
#> 23     BDS        <NA>
#> 24     BDS        <NA>
#> 25     BDS        <NA>
#> 26     BDS        <NA>
#> 27     BDS        <NA>
#> 28     BDS        <NA>
#> 29     BDS        <NA>
#> 30     BDS        <NA>
#> 31     BDS        <NA>
#> 32     BDS        <NA>
#> 33     BDS        <NA>
#> 34     BDS        <NA>
#> 35     BDS        <NA>
#> 36     BDS        <NA>
#> 37     BDS        <NA>
#> 38     BDS        <NA>
#> 39     BDS        <NA>
#> 40     BDS        <NA>
#> 41     BDS        <NA>
#> 42     BDS        <NA>
#> 43     BDS        <NA>
#> 44     BDS        <NA>
#> 45     BDS        <NA>
#> 46     BDS        <NA>
#> 47     BDS        <NA>
#> 48     BDS        <NA>
#> 49     BDS        <NA>
#> 50     BDS        <NA>
#> 51     BDS        <NA>
#> 52     BDS        <NA>
#> 53     BDS        <NA>
#> 54     BDS        <NA>
#> 55     BDS        <NA>
#> 56     BDS        <NA>
#> 57     BDS        <NA>
#> 58     BDS        <NA>
#> 59     BDS        <NA>
#> 60     BDS        <NA>
#> 61     BDS        <NA>
#> 62     BDS        <NA>
#> 63     BDS        <NA>
#> 64     BDS        <NA>
#> 65     BDS        <NA>
#> 66     BDS        <NA>
#> 67     BDS        <NA>
#> 68     BDS        <NA>
#> 69     BDS        <NA>
#> 70     BDS        <NA>
#> 71     BDS        <NA>
#> 72     BDS        <NA>
#> 73     BDS        <NA>
#> 74     BDS      C81223
#> 75     BDS      C81226
#> 76     BDS        <NA>
#> 77     BDS        <NA>
#> 78     BDS        <NA>
#> 79     BDS      C81223
#> 80     BDS      C81226
#> 81     BDS        <NA>
#> 82     BDS        <NA>
#> 83     BDS        <NA>
#> 84     BDS      C81223
#> 85     BDS      C81226
#> 86     BDS        <NA>
#> 87     BDS        <NA>
#> 88     BDS        <NA>
#> 89     BDS      C81223
#> 90     BDS      C81226
#> 91     BDS        <NA>
#> 92     BDS        <NA>
#> 93     BDS        <NA>
#> 94     BDS      C81223
#> 95     BDS      C81226
#> 96     BDS        <NA>
#> 97     BDS        <NA>
#> 98     BDS        <NA>
#> 99     BDS      C81223
#> 100    BDS      C81226
#> 101    BDS        <NA>
#> 102    BDS        <NA>
#> 103    BDS        <NA>
#> 104    BDS        <NA>
#> 105    BDS        <NA>
#> 106    BDS        <NA>
#> 107    BDS        <NA>
#> 108    BDS        <NA>
#> 109    BDS        <NA>
#> 110    BDS        <NA>
#> 111    BDS        <NA>
#> 112    BDS        <NA>
#> 113    BDS        <NA>
#> 114    BDS        <NA>
#> 115    BDS        <NA>
#> 116    BDS        <NA>
#> 117    BDS      C81223
#> 118    BDS      C81226
#> 119    BDS        <NA>
#> 120    BDS        <NA>
#> 121    BDS        <NA>
#> 122    BDS      C81223
#> 123    BDS      C81226
#> 124    BDS        <NA>
#> 125    BDS        <NA>
#> 126    BDS        <NA>
#> 127    BDS        <NA>
#> 128    BDS      C81223
#> 129    BDS      C81226
#> 130    BDS        <NA>
#> 131    BDS        <NA>
#> 132    BDS        <NA>
#> 133    BDS      C81223
#> 134    BDS      C81226
#> 135    BDS        <NA>
#> 136    BDS        <NA>
#> 137    BDS        <NA>
#> 138    BDS        <NA>
#> 139    BDS      C81223
#> 140    BDS      C81226
#> 141    BDS        <NA>
#> 142    BDS        <NA>
#> 143    BDS        <NA>
#> 144    BDS      C81223
#> 145    BDS      C81226
#> 146    BDS        <NA>
#> 147    BDS        <NA>
#> 148    BDS        <NA>
#> 149    BDS        <NA>
#> 150    BDS      C81223
#> 151    BDS      C81226
#> 152    BDS        <NA>
#> 153    BDS        <NA>
#> 154    BDS        <NA>
#> 155    BDS        <NA>
#> 156    BDS      C81223
#> 157    BDS      C81226
#> 158    BDS        <NA>
#> 159    BDS        <NA>
#> 160    BDS        <NA>
#> 161    BDS        <NA>
#> 162    BDS      C81223
#> 163    BDS      C81226
#> 164    BDS        <NA>
#> 165    BDS        <NA>
#> 166    BDS      C81223
#> 167    BDS      C81226
#> 168    BDS        <NA>
#> 169    BDS        <NA>
#> 170    BDS        <NA>
#> 171    BDS        <NA>
#> 172    BDS        <NA>
#> 173    BDS        <NA>
#> 174    BDS        <NA>
#> 175    BDS      C81223
#> 176    BDS      C81226
#> 177    BDS        <NA>
#> 178    BDS        <NA>
#> 179    BDS        <NA>
#> 180    BDS        <NA>
#> 181    BDS      C81223
#> 182    BDS      C81226
#> 183    BDS        <NA>
#> 184    BDS        <NA>
#> 185    BDS        <NA>
#> 186    BDS        <NA>
#> 187    BDS      C81223
#> 188    BDS      C81226
#> 189    BDS        <NA>
#> 190    BDS        <NA>
#> 191    BDS        <NA>
#> 192    BDS        <NA>
#> 193    BDS        <NA>
#> 194    BDS        <NA>
#> 195    BDS        <NA>
#> 196    BDS        <NA>
#> 197    BDS        <NA>
#> 198    BDS        <NA>
#> 199    BDS        <NA>
#> 200    BDS        <NA>
#> 201    BDS        <NA>
#> 202    BDS        <NA>
#> 203    BDS        <NA>
#> 204    BDS        <NA>
#> 205    BDS        <NA>
#> 206    BDS        <NA>
#> 207    BDS        <NA>
#> 208    BDS        <NA>
#> 209    BDS        <NA>
#> 210    BDS        <NA>
#> 211    BDS        <NA>
#> 212    BDS        <NA>
#> 213    BDS        <NA>
#> 214    BDS        <NA>
#> 215    BDS        <NA>
#> 216    BDS        <NA>
#> 217    BDS        <NA>
#> 218    BDS        <NA>
#> 219    BDS        <NA>
#> 220    BDS        <NA>
#> 221    BDS        <NA>
#> 222    BDS        <NA>
#> 223    BDS        <NA>
#> 224    BDS        <NA>
#> 225    BDS        <NA>
#> 226    BDS        <NA>
#> 227    BDS        <NA>
```
