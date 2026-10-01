# Build a variable specification for PP, SUPPPP, or ADPP

Combines
[`get_ig`](https://humanpred.github.io/cdiscdata/reference/get_ig.md)
(variable name, label, type, core, order, codelist) with
[`get_ct`](https://humanpred.github.io/cdiscdata/reference/get_ct.md)
(is that codelist in the controlled terminology release) into a single,
ready-to-use variable specification for one of the three PK datasets.
`PP` and `SUPPPP` draw on an SDTM-side implementation guide (`SUPPPP`
from the generic SUPP– structure, since CDISC has no domain-specific
SUPPPP table); `ADPP` draws on the ADaMIG Basic Data Structure (BDS)
table, since ADPP is a BDS dataset and CDISC has no ADPP-specific table
either. An ADPP spec can optionally be unioned with the ADaMIG ADSL
table (`adsl`), with a BDS extension such as ADaMIG-NCA (`extension`),
and with the SDTM PP domain's variables (`sdtm_domain`).

## Usage

``` r
build_domain_spec(
  domain = c("PP", "SUPPPP", "ADPP"),
  ig_version = NULL,
  ct_version = NULL,
  adsl = TRUE,
  sdtm_domain = NULL,
  sdtmig_version = NULL,
  standard = NULL,
  extension = NULL,
  extension_version = NULL
)
```

## Arguments

- domain:

  One of `"PP"`, `"SUPPPP"`, or `"ADPP"`.

- ig_version:

  Version of `standard` to use. `NULL` uses the newest available.

- ct_version:

  CT version to check codelist ids against; passed to
  [`get_ct`](https://humanpred.github.io/cdiscdata/reference/get_ct.md).
  `NULL` uses the newest available.

- adsl:

  For `domain = "ADPP"` only: whether to union in the ADaMIG ADSL
  variables (default `TRUE`), since a real ADPP dataset carries ADSL's
  subject-level variables (treatment, demographics, ...) alongside its
  own BDS variables. `FALSE` returns the BDS variables alone. Ignored
  (with a warning) for `domain != "ADPP"`.

- sdtm_domain:

  For `domain = "ADPP"` only: `NULL` (the default) adds nothing; `"PP"`
  also unions in the SDTMIG PP domain's variables, the same way
  `adsl = TRUE` unions ADSL's: marked `source = "SDTMIG"`, `core` forced
  to `"Perm"`, a variable already defined keeping that version, and
  codelist ids checked against the ADaM CT first and the SDTM CT second.
  Ignored (with a warning) for `domain != "ADPP"`; any value other than
  `"PP"` is an error.

- sdtmig_version:

  SDTMIG version to take the `sdtm_domain` variables from. `NULL` uses
  the newest available. Ignored (with a warning) unless
  `domain = "ADPP"` and `sdtm_domain` is set.

- standard:

  The implementation guide to take the domain's variables from. `NULL`
  (the default) uses `"SDTMIG"` for `PP` and `SUPPPP` and `"ADaMIG"` for
  `ADPP`; any standard in
  [`get_ig`](https://humanpred.github.io/cdiscdata/reference/get_ig.md)
  that has the domain works (e.g. `"SENDIG"` defines `PP` too).

- extension:

  For `domain = "ADPP"` only: `NULL` (the default) adds nothing;
  `"ADaMIG-NCA"` (or the alias `"NCA"`), `"ADaM-popPK"`, or
  `"ADaM-BDS-TTE"` unions that BDS extension onto the BDS variables.
  Unlike the ADSL and PP unions, the extension's own Core designations
  are kept, as they are the point of the extension: a new variable is
  appended with its published Core, and a variable the BDS already
  defines takes the extension's (stronger) Core (e.g. `AVISIT` becomes
  required in ADaMIG-NCA). Rows the extension touches are marked with
  its name in `source`. Ignored (with a warning) for `domain != "ADPP"`.

- extension_version:

  Version of the `extension`; `NULL` uses the newest. Ignored (with a
  warning) unless `domain = "ADPP"` and `extension` is set.

## Value

A data frame with columns `variable`, `label`, `type`, `length`, `core`,
`order`, `source`, and `codelist_id`. `source` is `"SDTMIG"` (or the
SDTM-side `standard`) for `PP`/`SUPPPP`; `"BDS"`, `"ADSL"`, `"SDTMIG"`,
or the extension's name for `ADPP`. `order` is the published order,
renumbered consecutively, with unioned variables following.
`codelist_id` is the C-code of the first codelist the IG lists for the
variable, when that codelist is in the CT release used, and `NA`
otherwise (no codelist, or one not in that release, e.g. a codelist
since retired). `length` is always `NA`: the CDISC Library exports this
package is built from carry no length, which is a sponsor choice, and
the column is kept so existing code that reads it keeps working.
ADSL-sourced `ADPP` rows have `core` forced to `"Perm"` regardless of
their Core designation in ADSL itself: from ADPP's perspective, merging
in an ADSL variable is a common but optional choice, not a requirement
ADSL's own Core reflects.

## Details

Neither the ADaMIG BDS nor ADSL tables define the PP-inherited
traceability variables (`PPTESTCD`, `PPTEST`, and the rest of PP's
variables that a BDS dataset built from PP typically carries forward);
which of PP's variables to carry into ADPP, and under what names, is a
downstream derivation choice (e.g. admiral's own conventions), so they
are only added when asked for with `sdtm_domain`, and the default leaves
them out.

## Examples

``` r
build_domain_spec("PP")
#>    variable                                    label type length core order
#> 1   STUDYID                         Study Identifier Char     NA  Req     1
#> 2    DOMAIN                      Domain Abbreviation Char     NA  Req     2
#> 3   USUBJID                Unique Subject Identifier Char     NA  Req     3
#> 4     PPSEQ                          Sequence Number  Num     NA  Req     4
#> 5   PPGRPID                                 Group ID Char     NA Perm     5
#> 6  PPTESTCD                     Parameter Short Name Char     NA  Req     6
#> 7    PPTEST                           Parameter Name Char     NA  Req     7
#> 8     PPCAT                       Parameter Category Char     NA  Exp     8
#> 9    PPSCAT                    Parameter Subcategory Char     NA Perm     9
#> 10  PPORRES      Result or Finding in Original Units Char     NA  Exp    10
#> 11 PPORRESU                           Original Units Char     NA  Exp    11
#> 12 PPSTRESC   Character Result/Finding in Std Format Char     NA  Exp    12
#> 13 PPSTRESN Numeric Result/Finding in Standard Units  Num     NA  Exp    13
#> 14 PPSTRESU                           Standard Units Char     NA  Exp    14
#> 15   PPSTAT                        Completion Status Char     NA Perm    15
#> 16 PPREASND          Reason Parameter Not Calculated Char     NA Perm    16
#> 17   PPSPEC                   Specimen Material Type Char     NA  Exp    17
#> 18 PPANMETH                          Analysis Method Char     NA Perm    18
#> 19  TAETORD      Planned Order of Element within Arm  Num     NA Perm    19
#> 20    EPOCH                                    Epoch Char     NA Perm    20
#> 21    PPDTC      Date/Time of Parameter Calculations Char     NA Perm    21
#> 22     PPDY      Study Day of Parameter Calculations  Num     NA Perm    22
#> 23 PPTPTREF                     Time Point Reference Char     NA Perm    23
#> 24 PPRFTDTC             Date/Time of Reference Point Char     NA  Exp    24
#> 25  PPSTINT     Planned Start of Assessment Interval Char     NA Perm    25
#> 26  PPENINT       Planned End of Assessment Interval Char     NA Perm    26
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
#> 18 SDTMIG     C172330
#> 19 SDTMIG        <NA>
#> 20 SDTMIG      C99079
#> 21 SDTMIG        <NA>
#> 22 SDTMIG        <NA>
#> 23 SDTMIG        <NA>
#> 24 SDTMIG        <NA>
#> 25 SDTMIG        <NA>
#> 26 SDTMIG        <NA>
build_domain_spec("SUPPPP")
#>    variable                       label type length core order source
#> 1   STUDYID            Study Identifier Char     NA  Req     1 SDTMIG
#> 2   RDOMAIN Related Domain Abbreviation Char     NA  Req     2 SDTMIG
#> 3   USUBJID   Unique Subject Identifier Char     NA  Req     3 SDTMIG
#> 4     IDVAR        Identifying Variable Char     NA  Exp     4 SDTMIG
#> 5  IDVARVAL  Identifying Variable Value Char     NA  Exp     5 SDTMIG
#> 6      QNAM     Qualifier Variable Name Char     NA  Req     6 SDTMIG
#> 7    QLABEL    Qualifier Variable Label Char     NA  Req     7 SDTMIG
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
#> 10      C78735
build_domain_spec("ADPP")               # BDS + ADSL (default)
#>     variable                                     label type length core order
#> 1       TRTP                         Planned Treatment Char     NA Cond     1
#> 2      TRTPN                     Planned Treatment (N)  Num     NA Perm     2
#> 3       TRTA                          Actual Treatment Char     NA Cond     3
#> 4      TRTAN                      Actual Treatment (N)  Num     NA Perm     4
#> 5     TRTPGy                Planned Pooled Treatment y Char     NA Perm     5
#> 6    TRTPGyN            Planned Pooled Treatment y (N)  Num     NA Perm     6
#> 7     TRTAGy                 Actual Pooled Treatment y Char     NA Cond     7
#> 8    TRTAGyN             Actual Pooled Treatment y (N)  Num     NA Perm     8
#> 9      DOSEP                    Planned Treatment Dose  Num     NA Perm     9
#> 10   DOSCUMP         Cumulative Planned Treatment Dose  Num     NA Perm    10
#> 11     DOSEA                     Actual Treatment Dose  Num     NA Perm    11
#> 12   DOSCUMA          Cumulative Actual Treatment Dose  Num     NA Perm    12
#> 13     DOSEU                      Treatment Dose Units Char     NA Perm    13
#> 14       ADT                             Analysis Date  Num     NA Cond    14
#> 15       ATM                             Analysis Time  Num     NA Cond    15
#> 16      ADTM                         Analysis Datetime  Num     NA Cond    16
#> 17       ADY                     Analysis Relative Day  Num     NA Cond    17
#> 18      ADTF             Analysis Date Imputation Flag Char     NA Cond    18
#> 19      ATMF             Analysis Time Imputation Flag Char     NA Cond    19
#> 20     ASTDT                       Analysis Start Date  Num     NA Cond    20
#> 21     ASTTM                       Analysis Start Time  Num     NA Cond    21
#> 22    ASTDTM                   Analysis Start Datetime  Num     NA Cond    22
#> 23     ASTDY               Analysis Start Relative Day  Num     NA Cond    23
#> 24    ASTDTF       Analysis Start Date Imputation Flag Char     NA Cond    24
#> 25    ASTTMF       Analysis Start Time Imputation Flag Char     NA Cond    25
#> 26     AENDT                         Analysis End Date  Num     NA Cond    26
#> 27     AENTM                         Analysis End Time  Num     NA Cond    27
#> 28    AENDTM                     Analysis End Datetime  Num     NA Cond    28
#> 29     AENDY                 Analysis End Relative Day  Num     NA Cond    29
#> 30    AENDTF         Analysis End Date Imputation Flag Char     NA Cond    30
#> 31    AENTMF         Analysis End Time Imputation Flag Char     NA Cond    31
#> 32    AVISIT                            Analysis Visit Char     NA Cond    32
#> 33   AVISITN                        Analysis Visit (N)  Num     NA Perm    33
#> 34      ATPT                        Analysis Timepoint Char     NA Cond    34
#> 35     ATPTN                    Analysis Timepoint (N)  Num     NA Perm    35
#> 36   ATPTREF              Analysis Timepoint Reference Char     NA Perm    36
#> 37    APHASE                                     Phase Char     NA Perm    37
#> 38   APHASEN                                 Phase (N)  Num     NA Perm    38
#> 39   APERIOD                                    Period  Num     NA Cond    39
#> 40  APERIODC                                Period (C) Char     NA Perm    40
#> 41     ASPER                   Subperiod within Period  Num     NA Perm    41
#> 42    ASPERC               Subperiod within Period (C) Char     NA Perm    42
#> 43    ARELTM                    Analysis Relative Time  Num     NA Perm    43
#> 44   ARELTMU               Analysis Relative Time Unit Char     NA Perm    44
#> 45   APERSDT                         Period Start Date  Num     NA Perm    45
#> 46   APERSTM                         Period Start Time  Num     NA Perm    46
#> 47  APERSDTM                     Period Start Datetime  Num     NA Perm    47
#> 48  APERSDTF             Period Start Date Imput. Flag Char     NA Cond    48
#> 49  APERSTMF             Period Start Time Imput. Flag Char     NA Cond    49
#> 50   APEREDT                           Period End Date  Num     NA Perm    50
#> 51   APERETM                           Period End Time  Num     NA Perm    51
#> 52  APEREDTM                       Period End Datetime  Num     NA Perm    52
#> 53  APEREDTF               Period End Date Imput. Flag Char     NA Cond    53
#> 54  APERETMF               Period End Time Imput. Flag Char     NA Cond    54
#> 55   ASPRSDT                      Subperiod Start Date  Num     NA Perm    55
#> 56   ASPRSTM                      Subperiod Start Time  Num     NA Perm    56
#> 57  ASPRSDTM                  Subperiod Start Datetime  Num     NA Perm    57
#> 58  ASPRSDTF          Subperiod Start Date Imput. Flag Char     NA Cond    58
#> 59  ASPRSTMF          Subperiod Start Time Imput. Flag Char     NA Cond    59
#> 60   ASPREDT                        Subperiod End Date  Num     NA Perm    60
#> 61   ASPRETM                        Subperiod End Time  Num     NA Perm    61
#> 62  ASPREDTM                    Subperiod End Datetime  Num     NA Perm    62
#> 63  ASPREDTF            Subperiod End Date Imput. Flag Char     NA Cond    63
#> 64  ASPRETMF            Subperiod End Time Imput. Flag Char     NA Cond    64
#> 65     PHSDT                          Phase Start Date  Num     NA Perm    65
#> 66     PHSTM                          Phase Start Time  Num     NA Perm    66
#> 67    PHSDTM                      Phase Start Datetime  Num     NA Perm    67
#> 68    PHSDTF              Phase Start Date Imput. Flag Char     NA Cond    68
#> 69    PHSTMF              Phase Start Time Imput. Flag Char     NA Cond    69
#> 70     PHEDT                            Phase End Date  Num     NA Perm    70
#> 71     PHETM                            Phase End Time  Num     NA Perm    71
#> 72    PHEDTM                        Phase End Datetime  Num     NA Perm    72
#> 73    PHEDTF                Phase End Date Imput. Flag Char     NA Cond    73
#> 74    PHETMF                Phase End Time Imput. Flag Char     NA Cond    74
#> 75       *DT                                    {Date}  Num     NA Perm    75
#> 76       *TM                                    {Time}  Num     NA Perm    76
#> 77      *DTM                                {Datetime}  Num     NA Perm    77
#> 78      *ADY                            {Relative Day}  Num     NA Perm    78
#> 79      *DTF                    {Date Imputation Flag} Char     NA Cond    79
#> 80      *TMF                    {Time Imputation Flag} Char     NA Cond    80
#> 81      *SDT                              {Start Date}  Num     NA Perm    81
#> 82      *STM                              {Start Time}  Num     NA Perm    82
#> 83     *SDTM                          {Start Datetime}  Num     NA Perm    83
#> 84      *SDY                      {Relative Start Day}  Num     NA Perm    84
#> 85     *SDTF              {Start Date Imputation Flag} Char     NA Cond    85
#> 86     *STMF              {Start Time Imputation Flag} Char     NA Cond    86
#> 87      *EDT                                {End Date}  Num     NA Perm    87
#> 88      *ETM                                {End Time}  Num     NA Perm    88
#> 89     *EDTM                            {End Datetime}  Num     NA Perm    89
#> 90      *EDY                        {Relative End Day}  Num     NA Perm    90
#> 91     *EDTF                {End Date Imputation Flag} Char     NA Cond    91
#> 92     *ETMF                {End Time Imputation Flag} Char     NA Cond    92
#> 93     PARAM                                 Parameter Char     NA  Req    93
#> 94   PARAMCD                            Parameter Code Char     NA  Req    94
#> 95    PARAMN                             Parameter (N)  Num     NA Perm    95
#> 96   PARCATy                      Parameter Category y Char     NA Perm    96
#> 97  PARCATyN                  Parameter Category y (N)  Num     NA Perm    97
#> 98      AVAL                            Analysis Value  Num     NA Cond    98
#> 99     AVALC                        Analysis Value (C) Char     NA Cond    99
#> 100 AVALCATy                 Analysis Value Category y Char     NA Perm   100
#> 101 AVALCAyN             Analysis Value Category y (N)  Num     NA Perm   101
#> 102     BASE                            Baseline Value  Num     NA Cond   102
#> 103    BASEC                        Baseline Value (C) Char     NA Perm   103
#> 104 BASECATy                       Baseline Category y Char     NA Perm   104
#> 105 BASECAyN                   Baseline Category y (N)  Num     NA Perm   105
#> 106 BASETYPE                             Baseline Type Char     NA Cond   106
#> 107      CHG                      Change from Baseline  Num     NA Perm   107
#> 108  CHGCATy           Change from Baseline Category y Char     NA Perm   108
#> 109 CHGCATyN       Change from Baseline Category y (N)  Num     NA Perm   109
#> 110     PCHG              Percent Change from Baseline  Num     NA Perm   110
#> 111 PCHGCATy      Percent Chg from Baseline Category y Char     NA Perm   111
#> 112 PCHGCAyN  Percent Chg from Baseline Category y (N)  Num     NA Perm   112
#> 113   R2BASE                         Ratio to Baseline  Num     NA Perm   113
#> 114   R2AyLO     Ratio to Analysis Range y Lower Limit  Num     NA Perm   114
#> 115   R2AyHI     Ratio to Analysis Range y Upper Limit  Num     NA Perm   115
#> 116   SHIFTy                                   Shift y Char     NA Perm   116
#> 117  SHIFTyN                               Shift y (N)  Num     NA Perm   117
#> 118     BCHG                        Change to Baseline  Num     NA Perm   118
#> 119 BCHGCATy             Change to Baseline Category y Char     NA Perm   119
#> 120 BCHGCAyN         Change to Baseline Category y (N)  Num     NA Perm   120
#> 121    PBCHG                Percent Change to Baseline  Num     NA Perm   121
#> 122 PBCHGCAy     Percent Change to Baseline Category y Char     NA Perm   122
#> 123 PBCHGCyN Percent Change to Baseline Category y (N)  Num     NA Perm   123
#> 124    CRITy                      Analysis Criterion y Char     NA Perm   124
#> 125  CRITyFL        Criterion y Evaluation Result Flag Char     NA Cond   125
#> 126  CRITyFN    Criterion y Evaluation Result Flag (N)  Num     NA Perm   126
#> 127   MCRITy       Analysis Multi-Response Criterion y Char     NA Perm   127
#> 128 MCRITyML     Multi-Response Criterion y Evaluation Char     NA Cond   128
#> 129 MCRITyMN       Multi-Response Criterion y Eval (N)  Num     NA Perm   129
#> 130    DTYPE                           Derivation Type Char     NA Cond   130
#> 131  AWRANGE      Analysis Window Valid Relative Range Char     NA Perm   131
#> 132 AWTARGET                    Analysis Window Target  Num     NA Perm   132
#> 133  AWTDIFF          Analysis Window Diff from Target  Num     NA Perm   133
#> 134     AWLO       Analysis Window Beginning Timepoint  Num     NA Perm   134
#> 135     AWHI          Analysis Window Ending Timepoint  Num     NA Perm   135
#> 136      AWU                      Analysis Window Unit Char     NA Perm   136
#> 137  STARTDT     Time-to-Event Origin Date for Subject  Num     NA Perm   137
#> 138 STARTDTM             Time-to-Event Origin Datetime  Num     NA Perm   138
#> 139 STARTDTF               Origin Date Imputation Flag Char     NA Cond   139
#> 140 STARTTMF               Origin Time Imputation Flag Char     NA Cond   140
#> 141     CNSR                                    Censor  Num     NA Cond   141
#> 142 EVNTDESC            Event or Censoring Description Char     NA Perm   142
#> 143 CNSDTDSC                   Censor Date Description Char     NA Perm   143
#> 144   ATOXGR                   Analysis Toxicity Grade Char     NA Perm   144
#> 145  ATOXGRN               Analysis Toxicity Grade (N)  Num     NA Perm   145
#> 146   BTOXGR                   Baseline Toxicity Grade Char     NA Perm   146
#> 147  BTOXGRN               Baseline Toxicity Grade (N)  Num     NA Perm   147
#> 148   ANRIND        Analysis Reference Range Indicator Char     NA Perm   148
#> 149   BNRIND        Baseline Reference Range Indicator Char     NA Perm   149
#> 150    ANRLO         Analysis Normal Range Lower Limit  Num     NA Perm   150
#> 151   ANRLOC     Analysis Normal Range Lower Limit (C) Char     NA Perm   151
#> 152    ANRHI         Analysis Normal Range Upper Limit  Num     NA Perm   152
#> 153   ANRHIC     Analysis Normal Range Upper Limit (C) Char     NA Perm   153
#> 154     AyLO              Analysis Range y Lower Limit  Num     NA Cond   154
#> 155    AyLOC          Analysis Range y Lower Limit (C) Char     NA Perm   155
#> 156     AyHI              Analysis Range y Upper Limit  Num     NA Cond   156
#> 157    AyHIC          Analysis Range y Upper Limit (C) Char     NA Perm   157
#> 158    AyIND                Analysis Range y Indicator Char     NA Perm   158
#> 159    ByIND       Baseline Analysis Range y Indicator Char     NA Perm   159
#> 160  ATOXGRL               Analysis Toxicity Grade Low Char     NA Perm   160
#> 161 ATOXGRLN           Analysis Toxicity Grade Low (N)  Num     NA Perm   161
#> 162  ATOXGRH              Analysis Toxicity Grade High Char     NA Perm   162
#> 163 ATOXGRHN          Analysis Toxicity Grade High (N)  Num     NA Perm   163
#> 164  BTOXGRL               Baseline Toxicity Grade Low Char     NA Perm   164
#> 165 BTOXGRLN           Baseline Toxicity Grade Low (N)  Num     NA Perm   165
#> 166  BTOXGRH              Baseline Toxicity Grade High Char     NA Perm   166
#> 167 BTOXGRHN          Baseline Toxicity Grade High (N)  Num     NA Perm   167
#> 168 ATOXDSCL         Analysis Toxicity Description Low Char     NA Perm   168
#> 169 ATOXDSCH        Analysis Toxicity Description High Char     NA Perm   169
#> 170    ABLFL                      Baseline Record Flag Char     NA Cond   170
#> 171    ABLFN                  Baseline Record Flag (N)  Num     NA Perm   171
#> 172  ANLzzFL                          Analysis Flag zz Char     NA Cond   172
#> 173  ANLzzFN                      Analysis Flag zz (N)  Num     NA Perm   173
#> 174  ONTRTFL                  On Treatment Record Flag Char     NA Perm   174
#> 175  ONTRTFN              On Treatment Record Flag (N)  Num     NA Perm   175
#> 176   LVOTFL       Last Value On Treatment Record Flag Char     NA Perm   176
#> 177   LVOTFN   Last Value On Treatment Record Flag (N)  Num     NA Perm   177
#> 178   ITTRFL         Intent-To-Treat Record-Level Flag Char     NA Perm   178
#> 179   SAFRFL         Safety Analysis Record-Level Flag Char     NA Perm   179
#> 180   FASRFL       Full Analysis Set Record-Level Flag Char     NA Perm   180
#> 181 PPROTRFL            Per-Protocol Record-Level Flag Char     NA Perm   181
#> 182 COMPLRFL              Completers Record-Level Flag Char     NA Perm   182
#> 183   ITTPFL      Intent-To-Treat Parameter-Level Flag Char     NA Perm   183
#> 184   SAFPFL      Safety Analysis Parameter-Level Flag Char     NA Perm   184
#> 185   FASPFL    Full Analysis Set Parameter-Level Flag Char     NA Perm   185
#> 186 PPROTPFL         Per-Protocol Parameter-Level Flag Char     NA Perm   186
#> 187 COMPLPFL           Completers Parameter-Level Flag Char     NA Perm   187
#> 188   SRCDOM                               Source Data Char     NA Perm   188
#> 189   SRCVAR                           Source Variable Char     NA Perm   189
#> 190   SRCSEQ                    Source Sequence Number  Num     NA Perm   190
#> 191  STUDYID                          Study Identifier Char     NA  Req   191
#> 192  USUBJID                 Unique Subject Identifier Char     NA  Req   192
#> 193   SUBJID          Subject Identifier for the Study Char     NA Perm   193
#> 194   SITEID                     Study Site Identifier Char     NA Perm   194
#> 195     ASEQ                  Analysis Sequence Number  Num     NA Perm   195
#> 196  SITEGRy                       Pooled Site Group y Char     NA Perm   196
#> 197 SITEGRyN                   Pooled Site Group y (N)  Num     NA Perm   197
#> 198  REGIONy                       Geographic Region y Char     NA Perm   198
#> 199 REGIONyN                   Geographic Region y (N)  Num     NA Perm   199
#> 200      AGE                                       Age  Num     NA Perm   200
#> 201     AGEU                                 Age Units Char     NA Perm   201
#> 202   AGEGRy                        Pooled Age Group y Char     NA Perm   202
#> 203  AGEGRyN                    Pooled Age Group y (N)  Num     NA Perm   203
#> 204     AAGE                              Analysis Age  Num     NA Perm   204
#> 205      SEX                                       Sex Char     NA Perm   205
#> 206     RACE                                      Race Char     NA Perm   206
#> 207  RACEGRy                       Pooled Race Group y Char     NA Perm   207
#> 208 RACEGRyN                   Pooled Race Group y (N)  Num     NA Perm   208
#> 209    FASFL         Full Analysis Set Population Flag Char     NA Perm   209
#> 210    SAFFL                    Safety Population Flag Char     NA Perm   210
#> 211    ITTFL           Intent-To-Treat Population Flag Char     NA Perm   211
#> 212  PPROTFL              Per-Protocol Population Flag Char     NA Perm   212
#> 213  COMPLFL                Completers Population Flag Char     NA Perm   213
#> 214   RANDFL                Randomized Population Flag Char     NA Perm   214
#> 215   ENRLFL                  Enrolled Population Flag Char     NA Perm   215
#> 216      ARM                Description of Planned Arm Char     NA Perm   216
#> 217   ACTARM                 Description of Actual Arm Char     NA Perm   217
#> 218   TRTxxP           Planned Treatment for Period xx Char     NA Perm   218
#> 219  TRTxxPN       Planned Treatment for Period xx (N)  Num     NA Perm   219
#> 220   TRTxxA            Actual Treatment for Period xx Char     NA Perm   220
#> 221  TRTxxAN        Actual Treatment for Period xx (N)  Num     NA Perm   221
#> 222  TRTSEQP            Planned Sequence of Treatments Char     NA Perm   222
#> 223 TRTSEQPN        Planned Sequence of Treatments (N)  Num     NA Perm   223
#> 224  TRTSEQA             Actual Sequence of Treatments Char     NA Perm   224
#> 225 TRTSEQAN         Actual Sequence of Treatments (N)  Num     NA Perm   225
#> 226  TRxxPGy  Planned Pooled Treatment y for Period xx Char     NA Perm   226
#> 227 TRxxPGyN    Planned Pooled Trt y for Period xx (N)  Num     NA Perm   227
#> 228  TRxxAGy   Actual Pooled Treatment y for Period xx Char     NA Perm   228
#> 229 TRxxAGyN     Actual Pooled Trt y for Period xx (N)  Num     NA Perm   229
#> 230  TSEQPGy       Planned Pooled Treatment Sequence y Char     NA Perm   230
#> 231 TSEQPGyN   Planned Pooled Treatment Sequence y (N)  Num     NA Perm   231
#> 232  TSEQAGy        Actual Pooled Treatment Sequence y Char     NA Perm   232
#> 233 TSEQAGyN    Actual Pooled Treatment Sequence y (N)  Num     NA Perm   233
#> 234  DOSExxP      Planned Treatment Dose for Period xx  Num     NA Perm   234
#> 235  DOSExxA       Actual Treatment Dose for Period xx  Num     NA Perm   235
#> 236  DOSExxU              Units for Dose for Period xx Char     NA Perm   236
#> 237   TRTSDT       Date of First Exposure to Treatment  Num     NA Perm   237
#> 238   TRTSTM       Time of First Exposure to Treatment  Num     NA Perm   238
#> 239  TRTSDTM   Datetime of First Exposure to Treatment  Num     NA Perm   239
#> 240  TRTSDTF        Date of First Exposure Imput. Flag Char     NA Perm   240
#> 241  TRTSTMF        Time of First Exposure Imput. Flag Char     NA Perm   241
#> 242   TRTEDT        Date of Last Exposure to Treatment  Num     NA Perm   242
#> 243   TRTETM        Time of Last Exposure to Treatment  Num     NA Perm   243
#> 244  TRTEDTM    Datetime of Last Exposure to Treatment  Num     NA Perm   244
#> 245  TRTEDTF         Date of Last Exposure Imput. Flag Char     NA Perm   245
#> 246  TRTETMF         Time of Last Exposure Imput. Flag Char     NA Perm   246
#> 247  TRxxSDT       Date of First Exposure in Period xx  Num     NA Perm   247
#> 248  TRxxSTM       Time of First Exposure in Period xx  Num     NA Perm   248
#> 249 TRxxSDTM   Datetime of First Exposure in Period xx  Num     NA Perm   249
#> 250 TRxxSDTF   Date 1st Exposure Period xx Imput. Flag Char     NA Perm   250
#> 251 TRxxSTMF   Time 1st Exposure Period xx Imput. Flag Char     NA Perm   251
#> 252  TRxxEDT        Date of Last Exposure in Period xx  Num     NA Perm   252
#> 253  TRxxETM        Time of Last Exposure in Period xx  Num     NA Perm   253
#> 254 TRxxEDTM    Datetime of Last Exposure in Period xx  Num     NA Perm   254
#> 255 TRxxEDTF  Date Last Exposure Period xx Imput. Flag Char     NA Perm   255
#> 256 TRxxETMF  Time Last Exposure Period xx Imput. Flag Char     NA Perm   256
#> 257  APxxSDT                      Period xx Start Date  Num     NA Perm   257
#> 258  APxxSTM                      Period xx Start Time  Num     NA Perm   258
#> 259 APxxSDTM                  Period xx Start Datetime  Num     NA Perm   259
#> 260 APxxSDTF          Period xx Start Date Imput. Flag Char     NA Perm   260
#> 261 APxxSTMF          Period xx Start Time Imput. Flag Char     NA Perm   261
#> 262  APxxEDT                        Period xx End Date  Num     NA Perm   262
#> 263  APxxETM                        Period xx End Time  Num     NA Perm   263
#> 264 APxxEDTM                    Period xx End Datetime  Num     NA Perm   264
#> 265 APxxEDTF            Period xx End Date Imput. Flag Char     NA Perm   265
#> 266 APxxETMF            Period xx End Time Imput. Flag Char     NA Perm   266
#> 267    PxxSw      Description of Period xx Subperiod w Char     NA Perm   267
#> 268 PxxSwSDT          Period xx Subperiod w Start Date  Num     NA Perm   268
#> 269 PxxSwSTM          Period xx Subperiod w Start Time  Num     NA Perm   269
#> 270 PxxSwSDM      Period xx Subperiod w Start Datetime  Num     NA Perm   270
#> 271 PxxSwSDF  Period xx Subper w Start Date Imput Flag Char     NA Perm   271
#> 272 PxxSwSTF  Period xx Subper w Start Time Imput Flag Char     NA Perm   272
#> 273 PxxSwEDT            Period xx Subperiod w End Date  Num     NA Perm   273
#> 274 PxxSwETM            Period xx Subperiod w End Time  Num     NA Perm   274
#> 275 PxxSwEDM        Period xx Subperiod w End Datetime  Num     NA Perm   275
#> 276 PxxSwEDF    Period xx Subper w End Date Imput Flag Char     NA Perm   276
#> 277 PxxSwETF    Period xx Subper w End Time Imput Flag Char     NA Perm   277
#> 278  APHASEw                    Description of Phase w Char     NA Perm   278
#> 279   PHwSDT                        Phase w Start Date  Num     NA Perm   279
#> 280   PHwSTM                        Phase w Start Time  Num     NA Perm   280
#> 281  PHwSDTM                    Phase w Start Datetime  Num     NA Perm   281
#> 282  PHwSDTF        Phase w Start Date Imputation Flag Char     NA Perm   282
#> 283  PHwSTMF        Phase w Start Time Imputation Flag Char     NA Perm   283
#> 284   PHwEDT                          Phase w End Date  Num     NA Perm   284
#> 285   PHwETM                          Phase w End Time  Num     NA Perm   285
#> 286  PHwEDTM                      Phase w End Datetime  Num     NA Perm   286
#> 287  PHwEDTF          Phase w End Date Imputation Flag Char     NA Perm   287
#> 288  PHwETMF          Phase w End Time Imputation Flag Char     NA Perm   288
#> 289   EOSSTT                       End of Study Status Char     NA Perm   289
#> 290    EOSDT                         End of Study Date  Num     NA Perm   290
#> 291  DCSREAS     Reason for Discontinuation from Study Char     NA Perm   291
#> 292 DCSREASP        Reason Spec for Discont from Study Char     NA Perm   292
#> 293   EOTSTT                   End of Treatment Status Char     NA Perm   293
#> 294  DCTREAS   Reason for Discontinuation of Treatment Char     NA Perm   294
#> 295 DCTREASP   Reason Specify for Discont of Treatment Char     NA Perm   295
#> 296 EOTxxSTT      End of Treatment Status in Period xx Char     NA Perm   296
#> 297  DCTxxRS  Reason for Discont of Treat in Period xx Char     NA Perm   297
#> 298 DCTxxRSP  Reason Spec for Disc of Trt in Period xx Char     NA Perm   298
#> 299 EOPxxSTT                   End of Period xx Status Char     NA Perm   299
#> 300  DCPxxRS         Reason for Discont from Period xx Char     NA Perm   300
#> 301 DCPxxRSP    Reason Spec for Discont from Period xx Char     NA Perm   301
#> 302   RFICDT                  Date of Informed Consent  Num     NA Perm   302
#> 303   ENRLDT                        Date of Enrollment  Num     NA Perm   303
#> 304   RANDDT                     Date of Randomization  Num     NA Perm   304
#> 305  RFICyDT                Date of Informed Consent y  Num     NA Perm   305
#> 306  ENRLyDT                      Date of Enrollment y  Num     NA Perm   306
#> 307  RANDyDT                   Date of Randomization y  Num     NA Perm   307
#> 308 LSTALVDT                     Date Last Known Alive  Num     NA Perm   308
#> 309    TRCMP                  Treatment Compliance (%)  Num     NA Perm   309
#> 310  TRCMPGy          Treatment Compliance (%) Group y Char     NA Perm   310
#> 311 TRCMPGyN      Treatment Compliance (%) Group y (N)  Num     NA Perm   311
#> 312 TRxxDURD    Treatment Duration in Period xx (Days)  Num     NA Perm   312
#> 313 TRxxDURM  Treatment Duration in Period xx (Months)  Num     NA Perm   313
#> 314 TRxxDURY   Treatment Duration in Period xx (Years)  Num     NA Perm   314
#> 315  TRTDURD           Total Treatment Duration (Days)  Num     NA Perm   315
#> 316  TRTDURM         Total Treatment Duration (Months)  Num     NA Perm   316
#> 317  TRTDURY          Total Treatment Duration (Years)  Num     NA Perm   317
#> 318    DTHDT                             Date of Death  Num     NA Perm   318
#> 319   DTHDTF             Date of Death Imputation Flag Char     NA Perm   319
#> 320  DTHCAUS                            Cause of Death Char     NA Perm   320
#> 321 DTHCAUSN                        Cause of Death (N)  Num     NA Perm   321
#> 322  DTHCGRy                    Cause of Death Group y Char     NA Perm   322
#> 323 DTHCGRyN                Cause of Death Group y (N)  Num     NA Perm   323
#> 324  STRATAR             Strata Used for Randomization Char     NA Perm   324
#> 325 STRATARN         Strata Used for Randomization (N)  Num     NA Perm   325
#> 326  STRATwD    Description of Stratification Factor w Char     NA Perm   326
#> 327  STRATwR        Strat Factor w Value Used for Rand Char     NA Perm   327
#> 328 STRATwRN    Strat Factor w Value Used for Rand (N)  Num     NA Perm   328
#> 329  STRATAV           Strata from Verification Source Char     NA Perm   329
#> 330 STRATAVN       Strata from Verification Source (N)  Num     NA Perm   330
#> 331  STRATwV    Strat Factor w Value from Verif Source Char     NA Perm   331
#> 332 STRATwVN    Strat Fact w Val from Verif Source (N)  Num     NA Perm   332
#>     source codelist_id
#> 1      BDS        <NA>
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
#> 18     BDS      C81223
#> 19     BDS      C81226
#> 20     BDS        <NA>
#> 21     BDS        <NA>
#> 22     BDS        <NA>
#> 23     BDS        <NA>
#> 24     BDS      C81223
#> 25     BDS      C81226
#> 26     BDS        <NA>
#> 27     BDS        <NA>
#> 28     BDS        <NA>
#> 29     BDS        <NA>
#> 30     BDS      C81223
#> 31     BDS      C81226
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
#> 48     BDS      C81223
#> 49     BDS      C81226
#> 50     BDS        <NA>
#> 51     BDS        <NA>
#> 52     BDS        <NA>
#> 53     BDS      C81223
#> 54     BDS      C81226
#> 55     BDS        <NA>
#> 56     BDS        <NA>
#> 57     BDS        <NA>
#> 58     BDS      C81223
#> 59     BDS      C81226
#> 60     BDS        <NA>
#> 61     BDS        <NA>
#> 62     BDS        <NA>
#> 63     BDS      C81223
#> 64     BDS      C81226
#> 65     BDS        <NA>
#> 66     BDS        <NA>
#> 67     BDS        <NA>
#> 68     BDS      C81223
#> 69     BDS      C81226
#> 70     BDS        <NA>
#> 71     BDS        <NA>
#> 72     BDS        <NA>
#> 73     BDS      C81223
#> 74     BDS      C81226
#> 75     BDS        <NA>
#> 76     BDS        <NA>
#> 77     BDS        <NA>
#> 78     BDS        <NA>
#> 79     BDS      C81223
#> 80     BDS      C81226
#> 81     BDS        <NA>
#> 82     BDS        <NA>
#> 83     BDS        <NA>
#> 84     BDS        <NA>
#> 85     BDS      C81223
#> 86     BDS      C81226
#> 87     BDS        <NA>
#> 88     BDS        <NA>
#> 89     BDS        <NA>
#> 90     BDS        <NA>
#> 91     BDS      C81223
#> 92     BDS      C81226
#> 93     BDS        <NA>
#> 94     BDS        <NA>
#> 95     BDS        <NA>
#> 96     BDS        <NA>
#> 97     BDS        <NA>
#> 98     BDS        <NA>
#> 99     BDS        <NA>
#> 100    BDS        <NA>
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
#> 117    BDS        <NA>
#> 118    BDS        <NA>
#> 119    BDS        <NA>
#> 120    BDS        <NA>
#> 121    BDS        <NA>
#> 122    BDS        <NA>
#> 123    BDS        <NA>
#> 124    BDS        <NA>
#> 125    BDS        <NA>
#> 126    BDS        <NA>
#> 127    BDS        <NA>
#> 128    BDS        <NA>
#> 129    BDS        <NA>
#> 130    BDS      C81224
#> 131    BDS        <NA>
#> 132    BDS        <NA>
#> 133    BDS        <NA>
#> 134    BDS        <NA>
#> 135    BDS        <NA>
#> 136    BDS        <NA>
#> 137    BDS        <NA>
#> 138    BDS        <NA>
#> 139    BDS      C81223
#> 140    BDS      C81226
#> 141    BDS        <NA>
#> 142    BDS        <NA>
#> 143    BDS        <NA>
#> 144    BDS        <NA>
#> 145    BDS        <NA>
#> 146    BDS        <NA>
#> 147    BDS        <NA>
#> 148    BDS        <NA>
#> 149    BDS        <NA>
#> 150    BDS        <NA>
#> 151    BDS        <NA>
#> 152    BDS        <NA>
#> 153    BDS        <NA>
#> 154    BDS        <NA>
#> 155    BDS        <NA>
#> 156    BDS        <NA>
#> 157    BDS        <NA>
#> 158    BDS        <NA>
#> 159    BDS        <NA>
#> 160    BDS        <NA>
#> 161    BDS        <NA>
#> 162    BDS        <NA>
#> 163    BDS        <NA>
#> 164    BDS        <NA>
#> 165    BDS        <NA>
#> 166    BDS        <NA>
#> 167    BDS        <NA>
#> 168    BDS        <NA>
#> 169    BDS        <NA>
#> 170    BDS        <NA>
#> 171    BDS        <NA>
#> 172    BDS        <NA>
#> 173    BDS        <NA>
#> 174    BDS        <NA>
#> 175    BDS        <NA>
#> 176    BDS        <NA>
#> 177    BDS        <NA>
#> 178    BDS        <NA>
#> 179    BDS        <NA>
#> 180    BDS        <NA>
#> 181    BDS        <NA>
#> 182    BDS        <NA>
#> 183    BDS        <NA>
#> 184    BDS        <NA>
#> 185    BDS        <NA>
#> 186    BDS        <NA>
#> 187    BDS        <NA>
#> 188    BDS        <NA>
#> 189    BDS        <NA>
#> 190    BDS        <NA>
#> 191    BDS        <NA>
#> 192    BDS        <NA>
#> 193    BDS        <NA>
#> 194    BDS        <NA>
#> 195    BDS        <NA>
#> 196   ADSL        <NA>
#> 197   ADSL        <NA>
#> 198   ADSL        <NA>
#> 199   ADSL        <NA>
#> 200   ADSL        <NA>
#> 201   ADSL      C66781
#> 202   ADSL        <NA>
#> 203   ADSL        <NA>
#> 204   ADSL        <NA>
#> 205   ADSL      C66731
#> 206   ADSL        <NA>
#> 207   ADSL        <NA>
#> 208   ADSL        <NA>
#> 209   ADSL        <NA>
#> 210   ADSL        <NA>
#> 211   ADSL        <NA>
#> 212   ADSL        <NA>
#> 213   ADSL        <NA>
#> 214   ADSL        <NA>
#> 215   ADSL        <NA>
#> 216   ADSL        <NA>
#> 217   ADSL        <NA>
#> 218   ADSL        <NA>
#> 219   ADSL        <NA>
#> 220   ADSL        <NA>
#> 221   ADSL        <NA>
#> 222   ADSL        <NA>
#> 223   ADSL        <NA>
#> 224   ADSL        <NA>
#> 225   ADSL        <NA>
#> 226   ADSL        <NA>
#> 227   ADSL        <NA>
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
#> 240   ADSL      C81223
#> 241   ADSL      C81226
#> 242   ADSL        <NA>
#> 243   ADSL        <NA>
#> 244   ADSL        <NA>
#> 245   ADSL      C81223
#> 246   ADSL      C81226
#> 247   ADSL        <NA>
#> 248   ADSL        <NA>
#> 249   ADSL        <NA>
#> 250   ADSL      C81223
#> 251   ADSL      C81226
#> 252   ADSL        <NA>
#> 253   ADSL        <NA>
#> 254   ADSL        <NA>
#> 255   ADSL      C81223
#> 256   ADSL      C81226
#> 257   ADSL        <NA>
#> 258   ADSL        <NA>
#> 259   ADSL        <NA>
#> 260   ADSL      C81223
#> 261   ADSL      C81226
#> 262   ADSL        <NA>
#> 263   ADSL        <NA>
#> 264   ADSL        <NA>
#> 265   ADSL      C81223
#> 266   ADSL      C81226
#> 267   ADSL        <NA>
#> 268   ADSL        <NA>
#> 269   ADSL        <NA>
#> 270   ADSL        <NA>
#> 271   ADSL      C81223
#> 272   ADSL      C81226
#> 273   ADSL        <NA>
#> 274   ADSL        <NA>
#> 275   ADSL        <NA>
#> 276   ADSL      C81223
#> 277   ADSL      C81226
#> 278   ADSL        <NA>
#> 279   ADSL        <NA>
#> 280   ADSL        <NA>
#> 281   ADSL        <NA>
#> 282   ADSL      C81223
#> 283   ADSL      C81226
#> 284   ADSL        <NA>
#> 285   ADSL        <NA>
#> 286   ADSL        <NA>
#> 287   ADSL      C81223
#> 288   ADSL      C81226
#> 289   ADSL     C124296
#> 290   ADSL        <NA>
#> 291   ADSL        <NA>
#> 292   ADSL        <NA>
#> 293   ADSL     C124296
#> 294   ADSL        <NA>
#> 295   ADSL        <NA>
#> 296   ADSL     C124296
#> 297   ADSL        <NA>
#> 298   ADSL        <NA>
#> 299   ADSL     C124296
#> 300   ADSL        <NA>
#> 301   ADSL        <NA>
#> 302   ADSL        <NA>
#> 303   ADSL        <NA>
#> 304   ADSL        <NA>
#> 305   ADSL        <NA>
#> 306   ADSL        <NA>
#> 307   ADSL        <NA>
#> 308   ADSL        <NA>
#> 309   ADSL        <NA>
#> 310   ADSL        <NA>
#> 311   ADSL        <NA>
#> 312   ADSL        <NA>
#> 313   ADSL        <NA>
#> 314   ADSL        <NA>
#> 315   ADSL        <NA>
#> 316   ADSL        <NA>
#> 317   ADSL        <NA>
#> 318   ADSL        <NA>
#> 319   ADSL      C81223
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
#> 1       TRTP                         Planned Treatment Char     NA Cond     1
#> 2      TRTPN                     Planned Treatment (N)  Num     NA Perm     2
#> 3       TRTA                          Actual Treatment Char     NA Cond     3
#> 4      TRTAN                      Actual Treatment (N)  Num     NA Perm     4
#> 5     TRTPGy                Planned Pooled Treatment y Char     NA Perm     5
#> 6    TRTPGyN            Planned Pooled Treatment y (N)  Num     NA Perm     6
#> 7     TRTAGy                 Actual Pooled Treatment y Char     NA Cond     7
#> 8    TRTAGyN             Actual Pooled Treatment y (N)  Num     NA Perm     8
#> 9      DOSEP                    Planned Treatment Dose  Num     NA Perm     9
#> 10   DOSCUMP         Cumulative Planned Treatment Dose  Num     NA Perm    10
#> 11     DOSEA                     Actual Treatment Dose  Num     NA Perm    11
#> 12   DOSCUMA          Cumulative Actual Treatment Dose  Num     NA Perm    12
#> 13     DOSEU                      Treatment Dose Units Char     NA Perm    13
#> 14       ADT                             Analysis Date  Num     NA Cond    14
#> 15       ATM                             Analysis Time  Num     NA Cond    15
#> 16      ADTM                         Analysis Datetime  Num     NA Cond    16
#> 17       ADY                     Analysis Relative Day  Num     NA Cond    17
#> 18      ADTF             Analysis Date Imputation Flag Char     NA Cond    18
#> 19      ATMF             Analysis Time Imputation Flag Char     NA Cond    19
#> 20     ASTDT                       Analysis Start Date  Num     NA Cond    20
#> 21     ASTTM                       Analysis Start Time  Num     NA Cond    21
#> 22    ASTDTM                   Analysis Start Datetime  Num     NA Cond    22
#> 23     ASTDY               Analysis Start Relative Day  Num     NA Cond    23
#> 24    ASTDTF       Analysis Start Date Imputation Flag Char     NA Cond    24
#> 25    ASTTMF       Analysis Start Time Imputation Flag Char     NA Cond    25
#> 26     AENDT                         Analysis End Date  Num     NA Cond    26
#> 27     AENTM                         Analysis End Time  Num     NA Cond    27
#> 28    AENDTM                     Analysis End Datetime  Num     NA Cond    28
#> 29     AENDY                 Analysis End Relative Day  Num     NA Cond    29
#> 30    AENDTF         Analysis End Date Imputation Flag Char     NA Cond    30
#> 31    AENTMF         Analysis End Time Imputation Flag Char     NA Cond    31
#> 32    AVISIT                            Analysis Visit Char     NA Cond    32
#> 33   AVISITN                        Analysis Visit (N)  Num     NA Perm    33
#> 34      ATPT                        Analysis Timepoint Char     NA Cond    34
#> 35     ATPTN                    Analysis Timepoint (N)  Num     NA Perm    35
#> 36   ATPTREF              Analysis Timepoint Reference Char     NA Perm    36
#> 37    APHASE                                     Phase Char     NA Perm    37
#> 38   APHASEN                                 Phase (N)  Num     NA Perm    38
#> 39   APERIOD                                    Period  Num     NA Cond    39
#> 40  APERIODC                                Period (C) Char     NA Perm    40
#> 41     ASPER                   Subperiod within Period  Num     NA Perm    41
#> 42    ASPERC               Subperiod within Period (C) Char     NA Perm    42
#> 43    ARELTM                    Analysis Relative Time  Num     NA Perm    43
#> 44   ARELTMU               Analysis Relative Time Unit Char     NA Perm    44
#> 45   APERSDT                         Period Start Date  Num     NA Perm    45
#> 46   APERSTM                         Period Start Time  Num     NA Perm    46
#> 47  APERSDTM                     Period Start Datetime  Num     NA Perm    47
#> 48  APERSDTF             Period Start Date Imput. Flag Char     NA Cond    48
#> 49  APERSTMF             Period Start Time Imput. Flag Char     NA Cond    49
#> 50   APEREDT                           Period End Date  Num     NA Perm    50
#> 51   APERETM                           Period End Time  Num     NA Perm    51
#> 52  APEREDTM                       Period End Datetime  Num     NA Perm    52
#> 53  APEREDTF               Period End Date Imput. Flag Char     NA Cond    53
#> 54  APERETMF               Period End Time Imput. Flag Char     NA Cond    54
#> 55   ASPRSDT                      Subperiod Start Date  Num     NA Perm    55
#> 56   ASPRSTM                      Subperiod Start Time  Num     NA Perm    56
#> 57  ASPRSDTM                  Subperiod Start Datetime  Num     NA Perm    57
#> 58  ASPRSDTF          Subperiod Start Date Imput. Flag Char     NA Cond    58
#> 59  ASPRSTMF          Subperiod Start Time Imput. Flag Char     NA Cond    59
#> 60   ASPREDT                        Subperiod End Date  Num     NA Perm    60
#> 61   ASPRETM                        Subperiod End Time  Num     NA Perm    61
#> 62  ASPREDTM                    Subperiod End Datetime  Num     NA Perm    62
#> 63  ASPREDTF            Subperiod End Date Imput. Flag Char     NA Cond    63
#> 64  ASPRETMF            Subperiod End Time Imput. Flag Char     NA Cond    64
#> 65     PHSDT                          Phase Start Date  Num     NA Perm    65
#> 66     PHSTM                          Phase Start Time  Num     NA Perm    66
#> 67    PHSDTM                      Phase Start Datetime  Num     NA Perm    67
#> 68    PHSDTF              Phase Start Date Imput. Flag Char     NA Cond    68
#> 69    PHSTMF              Phase Start Time Imput. Flag Char     NA Cond    69
#> 70     PHEDT                            Phase End Date  Num     NA Perm    70
#> 71     PHETM                            Phase End Time  Num     NA Perm    71
#> 72    PHEDTM                        Phase End Datetime  Num     NA Perm    72
#> 73    PHEDTF                Phase End Date Imput. Flag Char     NA Cond    73
#> 74    PHETMF                Phase End Time Imput. Flag Char     NA Cond    74
#> 75       *DT                                    {Date}  Num     NA Perm    75
#> 76       *TM                                    {Time}  Num     NA Perm    76
#> 77      *DTM                                {Datetime}  Num     NA Perm    77
#> 78      *ADY                            {Relative Day}  Num     NA Perm    78
#> 79      *DTF                    {Date Imputation Flag} Char     NA Cond    79
#> 80      *TMF                    {Time Imputation Flag} Char     NA Cond    80
#> 81      *SDT                              {Start Date}  Num     NA Perm    81
#> 82      *STM                              {Start Time}  Num     NA Perm    82
#> 83     *SDTM                          {Start Datetime}  Num     NA Perm    83
#> 84      *SDY                      {Relative Start Day}  Num     NA Perm    84
#> 85     *SDTF              {Start Date Imputation Flag} Char     NA Cond    85
#> 86     *STMF              {Start Time Imputation Flag} Char     NA Cond    86
#> 87      *EDT                                {End Date}  Num     NA Perm    87
#> 88      *ETM                                {End Time}  Num     NA Perm    88
#> 89     *EDTM                            {End Datetime}  Num     NA Perm    89
#> 90      *EDY                        {Relative End Day}  Num     NA Perm    90
#> 91     *EDTF                {End Date Imputation Flag} Char     NA Cond    91
#> 92     *ETMF                {End Time Imputation Flag} Char     NA Cond    92
#> 93     PARAM                                 Parameter Char     NA  Req    93
#> 94   PARAMCD                            Parameter Code Char     NA  Req    94
#> 95    PARAMN                             Parameter (N)  Num     NA Perm    95
#> 96   PARCATy                      Parameter Category y Char     NA Perm    96
#> 97  PARCATyN                  Parameter Category y (N)  Num     NA Perm    97
#> 98      AVAL                            Analysis Value  Num     NA Cond    98
#> 99     AVALC                        Analysis Value (C) Char     NA Cond    99
#> 100 AVALCATy                 Analysis Value Category y Char     NA Perm   100
#> 101 AVALCAyN             Analysis Value Category y (N)  Num     NA Perm   101
#> 102     BASE                            Baseline Value  Num     NA Cond   102
#> 103    BASEC                        Baseline Value (C) Char     NA Perm   103
#> 104 BASECATy                       Baseline Category y Char     NA Perm   104
#> 105 BASECAyN                   Baseline Category y (N)  Num     NA Perm   105
#> 106 BASETYPE                             Baseline Type Char     NA Cond   106
#> 107      CHG                      Change from Baseline  Num     NA Perm   107
#> 108  CHGCATy           Change from Baseline Category y Char     NA Perm   108
#> 109 CHGCATyN       Change from Baseline Category y (N)  Num     NA Perm   109
#> 110     PCHG              Percent Change from Baseline  Num     NA Perm   110
#> 111 PCHGCATy      Percent Chg from Baseline Category y Char     NA Perm   111
#> 112 PCHGCAyN  Percent Chg from Baseline Category y (N)  Num     NA Perm   112
#> 113   R2BASE                         Ratio to Baseline  Num     NA Perm   113
#> 114   R2AyLO     Ratio to Analysis Range y Lower Limit  Num     NA Perm   114
#> 115   R2AyHI     Ratio to Analysis Range y Upper Limit  Num     NA Perm   115
#> 116   SHIFTy                                   Shift y Char     NA Perm   116
#> 117  SHIFTyN                               Shift y (N)  Num     NA Perm   117
#> 118     BCHG                        Change to Baseline  Num     NA Perm   118
#> 119 BCHGCATy             Change to Baseline Category y Char     NA Perm   119
#> 120 BCHGCAyN         Change to Baseline Category y (N)  Num     NA Perm   120
#> 121    PBCHG                Percent Change to Baseline  Num     NA Perm   121
#> 122 PBCHGCAy     Percent Change to Baseline Category y Char     NA Perm   122
#> 123 PBCHGCyN Percent Change to Baseline Category y (N)  Num     NA Perm   123
#> 124    CRITy                      Analysis Criterion y Char     NA Perm   124
#> 125  CRITyFL        Criterion y Evaluation Result Flag Char     NA Cond   125
#> 126  CRITyFN    Criterion y Evaluation Result Flag (N)  Num     NA Perm   126
#> 127   MCRITy       Analysis Multi-Response Criterion y Char     NA Perm   127
#> 128 MCRITyML     Multi-Response Criterion y Evaluation Char     NA Cond   128
#> 129 MCRITyMN       Multi-Response Criterion y Eval (N)  Num     NA Perm   129
#> 130    DTYPE                           Derivation Type Char     NA Cond   130
#> 131  AWRANGE      Analysis Window Valid Relative Range Char     NA Perm   131
#> 132 AWTARGET                    Analysis Window Target  Num     NA Perm   132
#> 133  AWTDIFF          Analysis Window Diff from Target  Num     NA Perm   133
#> 134     AWLO       Analysis Window Beginning Timepoint  Num     NA Perm   134
#> 135     AWHI          Analysis Window Ending Timepoint  Num     NA Perm   135
#> 136      AWU                      Analysis Window Unit Char     NA Perm   136
#> 137  STARTDT     Time-to-Event Origin Date for Subject  Num     NA Perm   137
#> 138 STARTDTM             Time-to-Event Origin Datetime  Num     NA Perm   138
#> 139 STARTDTF               Origin Date Imputation Flag Char     NA Cond   139
#> 140 STARTTMF               Origin Time Imputation Flag Char     NA Cond   140
#> 141     CNSR                                    Censor  Num     NA Cond   141
#> 142 EVNTDESC            Event or Censoring Description Char     NA Perm   142
#> 143 CNSDTDSC                   Censor Date Description Char     NA Perm   143
#> 144   ATOXGR                   Analysis Toxicity Grade Char     NA Perm   144
#> 145  ATOXGRN               Analysis Toxicity Grade (N)  Num     NA Perm   145
#> 146   BTOXGR                   Baseline Toxicity Grade Char     NA Perm   146
#> 147  BTOXGRN               Baseline Toxicity Grade (N)  Num     NA Perm   147
#> 148   ANRIND        Analysis Reference Range Indicator Char     NA Perm   148
#> 149   BNRIND        Baseline Reference Range Indicator Char     NA Perm   149
#> 150    ANRLO         Analysis Normal Range Lower Limit  Num     NA Perm   150
#> 151   ANRLOC     Analysis Normal Range Lower Limit (C) Char     NA Perm   151
#> 152    ANRHI         Analysis Normal Range Upper Limit  Num     NA Perm   152
#> 153   ANRHIC     Analysis Normal Range Upper Limit (C) Char     NA Perm   153
#> 154     AyLO              Analysis Range y Lower Limit  Num     NA Cond   154
#> 155    AyLOC          Analysis Range y Lower Limit (C) Char     NA Perm   155
#> 156     AyHI              Analysis Range y Upper Limit  Num     NA Cond   156
#> 157    AyHIC          Analysis Range y Upper Limit (C) Char     NA Perm   157
#> 158    AyIND                Analysis Range y Indicator Char     NA Perm   158
#> 159    ByIND       Baseline Analysis Range y Indicator Char     NA Perm   159
#> 160  ATOXGRL               Analysis Toxicity Grade Low Char     NA Perm   160
#> 161 ATOXGRLN           Analysis Toxicity Grade Low (N)  Num     NA Perm   161
#> 162  ATOXGRH              Analysis Toxicity Grade High Char     NA Perm   162
#> 163 ATOXGRHN          Analysis Toxicity Grade High (N)  Num     NA Perm   163
#> 164  BTOXGRL               Baseline Toxicity Grade Low Char     NA Perm   164
#> 165 BTOXGRLN           Baseline Toxicity Grade Low (N)  Num     NA Perm   165
#> 166  BTOXGRH              Baseline Toxicity Grade High Char     NA Perm   166
#> 167 BTOXGRHN          Baseline Toxicity Grade High (N)  Num     NA Perm   167
#> 168 ATOXDSCL         Analysis Toxicity Description Low Char     NA Perm   168
#> 169 ATOXDSCH        Analysis Toxicity Description High Char     NA Perm   169
#> 170    ABLFL                      Baseline Record Flag Char     NA Cond   170
#> 171    ABLFN                  Baseline Record Flag (N)  Num     NA Perm   171
#> 172  ANLzzFL                          Analysis Flag zz Char     NA Cond   172
#> 173  ANLzzFN                      Analysis Flag zz (N)  Num     NA Perm   173
#> 174  ONTRTFL                  On Treatment Record Flag Char     NA Perm   174
#> 175  ONTRTFN              On Treatment Record Flag (N)  Num     NA Perm   175
#> 176   LVOTFL       Last Value On Treatment Record Flag Char     NA Perm   176
#> 177   LVOTFN   Last Value On Treatment Record Flag (N)  Num     NA Perm   177
#> 178   ITTRFL         Intent-To-Treat Record-Level Flag Char     NA Perm   178
#> 179   SAFRFL         Safety Analysis Record-Level Flag Char     NA Perm   179
#> 180   FASRFL       Full Analysis Set Record-Level Flag Char     NA Perm   180
#> 181 PPROTRFL            Per-Protocol Record-Level Flag Char     NA Perm   181
#> 182 COMPLRFL              Completers Record-Level Flag Char     NA Perm   182
#> 183   ITTPFL      Intent-To-Treat Parameter-Level Flag Char     NA Perm   183
#> 184   SAFPFL      Safety Analysis Parameter-Level Flag Char     NA Perm   184
#> 185   FASPFL    Full Analysis Set Parameter-Level Flag Char     NA Perm   185
#> 186 PPROTPFL         Per-Protocol Parameter-Level Flag Char     NA Perm   186
#> 187 COMPLPFL           Completers Parameter-Level Flag Char     NA Perm   187
#> 188   SRCDOM                               Source Data Char     NA Perm   188
#> 189   SRCVAR                           Source Variable Char     NA Perm   189
#> 190   SRCSEQ                    Source Sequence Number  Num     NA Perm   190
#> 191  STUDYID                          Study Identifier Char     NA  Req   191
#> 192  USUBJID                 Unique Subject Identifier Char     NA  Req   192
#> 193   SUBJID          Subject Identifier for the Study Char     NA Perm   193
#> 194   SITEID                     Study Site Identifier Char     NA Perm   194
#> 195     ASEQ                  Analysis Sequence Number  Num     NA Perm   195
#>     source codelist_id
#> 1      BDS        <NA>
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
#> 18     BDS      C81223
#> 19     BDS      C81226
#> 20     BDS        <NA>
#> 21     BDS        <NA>
#> 22     BDS        <NA>
#> 23     BDS        <NA>
#> 24     BDS      C81223
#> 25     BDS      C81226
#> 26     BDS        <NA>
#> 27     BDS        <NA>
#> 28     BDS        <NA>
#> 29     BDS        <NA>
#> 30     BDS      C81223
#> 31     BDS      C81226
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
#> 48     BDS      C81223
#> 49     BDS      C81226
#> 50     BDS        <NA>
#> 51     BDS        <NA>
#> 52     BDS        <NA>
#> 53     BDS      C81223
#> 54     BDS      C81226
#> 55     BDS        <NA>
#> 56     BDS        <NA>
#> 57     BDS        <NA>
#> 58     BDS      C81223
#> 59     BDS      C81226
#> 60     BDS        <NA>
#> 61     BDS        <NA>
#> 62     BDS        <NA>
#> 63     BDS      C81223
#> 64     BDS      C81226
#> 65     BDS        <NA>
#> 66     BDS        <NA>
#> 67     BDS        <NA>
#> 68     BDS      C81223
#> 69     BDS      C81226
#> 70     BDS        <NA>
#> 71     BDS        <NA>
#> 72     BDS        <NA>
#> 73     BDS      C81223
#> 74     BDS      C81226
#> 75     BDS        <NA>
#> 76     BDS        <NA>
#> 77     BDS        <NA>
#> 78     BDS        <NA>
#> 79     BDS      C81223
#> 80     BDS      C81226
#> 81     BDS        <NA>
#> 82     BDS        <NA>
#> 83     BDS        <NA>
#> 84     BDS        <NA>
#> 85     BDS      C81223
#> 86     BDS      C81226
#> 87     BDS        <NA>
#> 88     BDS        <NA>
#> 89     BDS        <NA>
#> 90     BDS        <NA>
#> 91     BDS      C81223
#> 92     BDS      C81226
#> 93     BDS        <NA>
#> 94     BDS        <NA>
#> 95     BDS        <NA>
#> 96     BDS        <NA>
#> 97     BDS        <NA>
#> 98     BDS        <NA>
#> 99     BDS        <NA>
#> 100    BDS        <NA>
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
#> 117    BDS        <NA>
#> 118    BDS        <NA>
#> 119    BDS        <NA>
#> 120    BDS        <NA>
#> 121    BDS        <NA>
#> 122    BDS        <NA>
#> 123    BDS        <NA>
#> 124    BDS        <NA>
#> 125    BDS        <NA>
#> 126    BDS        <NA>
#> 127    BDS        <NA>
#> 128    BDS        <NA>
#> 129    BDS        <NA>
#> 130    BDS      C81224
#> 131    BDS        <NA>
#> 132    BDS        <NA>
#> 133    BDS        <NA>
#> 134    BDS        <NA>
#> 135    BDS        <NA>
#> 136    BDS        <NA>
#> 137    BDS        <NA>
#> 138    BDS        <NA>
#> 139    BDS      C81223
#> 140    BDS      C81226
#> 141    BDS        <NA>
#> 142    BDS        <NA>
#> 143    BDS        <NA>
#> 144    BDS        <NA>
#> 145    BDS        <NA>
#> 146    BDS        <NA>
#> 147    BDS        <NA>
#> 148    BDS        <NA>
#> 149    BDS        <NA>
#> 150    BDS        <NA>
#> 151    BDS        <NA>
#> 152    BDS        <NA>
#> 153    BDS        <NA>
#> 154    BDS        <NA>
#> 155    BDS        <NA>
#> 156    BDS        <NA>
#> 157    BDS        <NA>
#> 158    BDS        <NA>
#> 159    BDS        <NA>
#> 160    BDS        <NA>
#> 161    BDS        <NA>
#> 162    BDS        <NA>
#> 163    BDS        <NA>
#> 164    BDS        <NA>
#> 165    BDS        <NA>
#> 166    BDS        <NA>
#> 167    BDS        <NA>
#> 168    BDS        <NA>
#> 169    BDS        <NA>
#> 170    BDS        <NA>
#> 171    BDS        <NA>
#> 172    BDS        <NA>
#> 173    BDS        <NA>
#> 174    BDS        <NA>
#> 175    BDS        <NA>
#> 176    BDS        <NA>
#> 177    BDS        <NA>
#> 178    BDS        <NA>
#> 179    BDS        <NA>
#> 180    BDS        <NA>
#> 181    BDS        <NA>
#> 182    BDS        <NA>
#> 183    BDS        <NA>
#> 184    BDS        <NA>
#> 185    BDS        <NA>
#> 186    BDS        <NA>
#> 187    BDS        <NA>
#> 188    BDS        <NA>
#> 189    BDS        <NA>
#> 190    BDS        <NA>
#> 191    BDS        <NA>
#> 192    BDS        <NA>
#> 193    BDS        <NA>
#> 194    BDS        <NA>
#> 195    BDS        <NA>
build_domain_spec("ADPP", sdtm_domain = "PP")  # BDS + ADSL + PP variables
#>     variable                                     label type length core order
#> 1       TRTP                         Planned Treatment Char     NA Cond     1
#> 2      TRTPN                     Planned Treatment (N)  Num     NA Perm     2
#> 3       TRTA                          Actual Treatment Char     NA Cond     3
#> 4      TRTAN                      Actual Treatment (N)  Num     NA Perm     4
#> 5     TRTPGy                Planned Pooled Treatment y Char     NA Perm     5
#> 6    TRTPGyN            Planned Pooled Treatment y (N)  Num     NA Perm     6
#> 7     TRTAGy                 Actual Pooled Treatment y Char     NA Cond     7
#> 8    TRTAGyN             Actual Pooled Treatment y (N)  Num     NA Perm     8
#> 9      DOSEP                    Planned Treatment Dose  Num     NA Perm     9
#> 10   DOSCUMP         Cumulative Planned Treatment Dose  Num     NA Perm    10
#> 11     DOSEA                     Actual Treatment Dose  Num     NA Perm    11
#> 12   DOSCUMA          Cumulative Actual Treatment Dose  Num     NA Perm    12
#> 13     DOSEU                      Treatment Dose Units Char     NA Perm    13
#> 14       ADT                             Analysis Date  Num     NA Cond    14
#> 15       ATM                             Analysis Time  Num     NA Cond    15
#> 16      ADTM                         Analysis Datetime  Num     NA Cond    16
#> 17       ADY                     Analysis Relative Day  Num     NA Cond    17
#> 18      ADTF             Analysis Date Imputation Flag Char     NA Cond    18
#> 19      ATMF             Analysis Time Imputation Flag Char     NA Cond    19
#> 20     ASTDT                       Analysis Start Date  Num     NA Cond    20
#> 21     ASTTM                       Analysis Start Time  Num     NA Cond    21
#> 22    ASTDTM                   Analysis Start Datetime  Num     NA Cond    22
#> 23     ASTDY               Analysis Start Relative Day  Num     NA Cond    23
#> 24    ASTDTF       Analysis Start Date Imputation Flag Char     NA Cond    24
#> 25    ASTTMF       Analysis Start Time Imputation Flag Char     NA Cond    25
#> 26     AENDT                         Analysis End Date  Num     NA Cond    26
#> 27     AENTM                         Analysis End Time  Num     NA Cond    27
#> 28    AENDTM                     Analysis End Datetime  Num     NA Cond    28
#> 29     AENDY                 Analysis End Relative Day  Num     NA Cond    29
#> 30    AENDTF         Analysis End Date Imputation Flag Char     NA Cond    30
#> 31    AENTMF         Analysis End Time Imputation Flag Char     NA Cond    31
#> 32    AVISIT                            Analysis Visit Char     NA Cond    32
#> 33   AVISITN                        Analysis Visit (N)  Num     NA Perm    33
#> 34      ATPT                        Analysis Timepoint Char     NA Cond    34
#> 35     ATPTN                    Analysis Timepoint (N)  Num     NA Perm    35
#> 36   ATPTREF              Analysis Timepoint Reference Char     NA Perm    36
#> 37    APHASE                                     Phase Char     NA Perm    37
#> 38   APHASEN                                 Phase (N)  Num     NA Perm    38
#> 39   APERIOD                                    Period  Num     NA Cond    39
#> 40  APERIODC                                Period (C) Char     NA Perm    40
#> 41     ASPER                   Subperiod within Period  Num     NA Perm    41
#> 42    ASPERC               Subperiod within Period (C) Char     NA Perm    42
#> 43    ARELTM                    Analysis Relative Time  Num     NA Perm    43
#> 44   ARELTMU               Analysis Relative Time Unit Char     NA Perm    44
#> 45   APERSDT                         Period Start Date  Num     NA Perm    45
#> 46   APERSTM                         Period Start Time  Num     NA Perm    46
#> 47  APERSDTM                     Period Start Datetime  Num     NA Perm    47
#> 48  APERSDTF             Period Start Date Imput. Flag Char     NA Cond    48
#> 49  APERSTMF             Period Start Time Imput. Flag Char     NA Cond    49
#> 50   APEREDT                           Period End Date  Num     NA Perm    50
#> 51   APERETM                           Period End Time  Num     NA Perm    51
#> 52  APEREDTM                       Period End Datetime  Num     NA Perm    52
#> 53  APEREDTF               Period End Date Imput. Flag Char     NA Cond    53
#> 54  APERETMF               Period End Time Imput. Flag Char     NA Cond    54
#> 55   ASPRSDT                      Subperiod Start Date  Num     NA Perm    55
#> 56   ASPRSTM                      Subperiod Start Time  Num     NA Perm    56
#> 57  ASPRSDTM                  Subperiod Start Datetime  Num     NA Perm    57
#> 58  ASPRSDTF          Subperiod Start Date Imput. Flag Char     NA Cond    58
#> 59  ASPRSTMF          Subperiod Start Time Imput. Flag Char     NA Cond    59
#> 60   ASPREDT                        Subperiod End Date  Num     NA Perm    60
#> 61   ASPRETM                        Subperiod End Time  Num     NA Perm    61
#> 62  ASPREDTM                    Subperiod End Datetime  Num     NA Perm    62
#> 63  ASPREDTF            Subperiod End Date Imput. Flag Char     NA Cond    63
#> 64  ASPRETMF            Subperiod End Time Imput. Flag Char     NA Cond    64
#> 65     PHSDT                          Phase Start Date  Num     NA Perm    65
#> 66     PHSTM                          Phase Start Time  Num     NA Perm    66
#> 67    PHSDTM                      Phase Start Datetime  Num     NA Perm    67
#> 68    PHSDTF              Phase Start Date Imput. Flag Char     NA Cond    68
#> 69    PHSTMF              Phase Start Time Imput. Flag Char     NA Cond    69
#> 70     PHEDT                            Phase End Date  Num     NA Perm    70
#> 71     PHETM                            Phase End Time  Num     NA Perm    71
#> 72    PHEDTM                        Phase End Datetime  Num     NA Perm    72
#> 73    PHEDTF                Phase End Date Imput. Flag Char     NA Cond    73
#> 74    PHETMF                Phase End Time Imput. Flag Char     NA Cond    74
#> 75       *DT                                    {Date}  Num     NA Perm    75
#> 76       *TM                                    {Time}  Num     NA Perm    76
#> 77      *DTM                                {Datetime}  Num     NA Perm    77
#> 78      *ADY                            {Relative Day}  Num     NA Perm    78
#> 79      *DTF                    {Date Imputation Flag} Char     NA Cond    79
#> 80      *TMF                    {Time Imputation Flag} Char     NA Cond    80
#> 81      *SDT                              {Start Date}  Num     NA Perm    81
#> 82      *STM                              {Start Time}  Num     NA Perm    82
#> 83     *SDTM                          {Start Datetime}  Num     NA Perm    83
#> 84      *SDY                      {Relative Start Day}  Num     NA Perm    84
#> 85     *SDTF              {Start Date Imputation Flag} Char     NA Cond    85
#> 86     *STMF              {Start Time Imputation Flag} Char     NA Cond    86
#> 87      *EDT                                {End Date}  Num     NA Perm    87
#> 88      *ETM                                {End Time}  Num     NA Perm    88
#> 89     *EDTM                            {End Datetime}  Num     NA Perm    89
#> 90      *EDY                        {Relative End Day}  Num     NA Perm    90
#> 91     *EDTF                {End Date Imputation Flag} Char     NA Cond    91
#> 92     *ETMF                {End Time Imputation Flag} Char     NA Cond    92
#> 93     PARAM                                 Parameter Char     NA  Req    93
#> 94   PARAMCD                            Parameter Code Char     NA  Req    94
#> 95    PARAMN                             Parameter (N)  Num     NA Perm    95
#> 96   PARCATy                      Parameter Category y Char     NA Perm    96
#> 97  PARCATyN                  Parameter Category y (N)  Num     NA Perm    97
#> 98      AVAL                            Analysis Value  Num     NA Cond    98
#> 99     AVALC                        Analysis Value (C) Char     NA Cond    99
#> 100 AVALCATy                 Analysis Value Category y Char     NA Perm   100
#> 101 AVALCAyN             Analysis Value Category y (N)  Num     NA Perm   101
#> 102     BASE                            Baseline Value  Num     NA Cond   102
#> 103    BASEC                        Baseline Value (C) Char     NA Perm   103
#> 104 BASECATy                       Baseline Category y Char     NA Perm   104
#> 105 BASECAyN                   Baseline Category y (N)  Num     NA Perm   105
#> 106 BASETYPE                             Baseline Type Char     NA Cond   106
#> 107      CHG                      Change from Baseline  Num     NA Perm   107
#> 108  CHGCATy           Change from Baseline Category y Char     NA Perm   108
#> 109 CHGCATyN       Change from Baseline Category y (N)  Num     NA Perm   109
#> 110     PCHG              Percent Change from Baseline  Num     NA Perm   110
#> 111 PCHGCATy      Percent Chg from Baseline Category y Char     NA Perm   111
#> 112 PCHGCAyN  Percent Chg from Baseline Category y (N)  Num     NA Perm   112
#> 113   R2BASE                         Ratio to Baseline  Num     NA Perm   113
#> 114   R2AyLO     Ratio to Analysis Range y Lower Limit  Num     NA Perm   114
#> 115   R2AyHI     Ratio to Analysis Range y Upper Limit  Num     NA Perm   115
#> 116   SHIFTy                                   Shift y Char     NA Perm   116
#> 117  SHIFTyN                               Shift y (N)  Num     NA Perm   117
#> 118     BCHG                        Change to Baseline  Num     NA Perm   118
#> 119 BCHGCATy             Change to Baseline Category y Char     NA Perm   119
#> 120 BCHGCAyN         Change to Baseline Category y (N)  Num     NA Perm   120
#> 121    PBCHG                Percent Change to Baseline  Num     NA Perm   121
#> 122 PBCHGCAy     Percent Change to Baseline Category y Char     NA Perm   122
#> 123 PBCHGCyN Percent Change to Baseline Category y (N)  Num     NA Perm   123
#> 124    CRITy                      Analysis Criterion y Char     NA Perm   124
#> 125  CRITyFL        Criterion y Evaluation Result Flag Char     NA Cond   125
#> 126  CRITyFN    Criterion y Evaluation Result Flag (N)  Num     NA Perm   126
#> 127   MCRITy       Analysis Multi-Response Criterion y Char     NA Perm   127
#> 128 MCRITyML     Multi-Response Criterion y Evaluation Char     NA Cond   128
#> 129 MCRITyMN       Multi-Response Criterion y Eval (N)  Num     NA Perm   129
#> 130    DTYPE                           Derivation Type Char     NA Cond   130
#> 131  AWRANGE      Analysis Window Valid Relative Range Char     NA Perm   131
#> 132 AWTARGET                    Analysis Window Target  Num     NA Perm   132
#> 133  AWTDIFF          Analysis Window Diff from Target  Num     NA Perm   133
#> 134     AWLO       Analysis Window Beginning Timepoint  Num     NA Perm   134
#> 135     AWHI          Analysis Window Ending Timepoint  Num     NA Perm   135
#> 136      AWU                      Analysis Window Unit Char     NA Perm   136
#> 137  STARTDT     Time-to-Event Origin Date for Subject  Num     NA Perm   137
#> 138 STARTDTM             Time-to-Event Origin Datetime  Num     NA Perm   138
#> 139 STARTDTF               Origin Date Imputation Flag Char     NA Cond   139
#> 140 STARTTMF               Origin Time Imputation Flag Char     NA Cond   140
#> 141     CNSR                                    Censor  Num     NA Cond   141
#> 142 EVNTDESC            Event or Censoring Description Char     NA Perm   142
#> 143 CNSDTDSC                   Censor Date Description Char     NA Perm   143
#> 144   ATOXGR                   Analysis Toxicity Grade Char     NA Perm   144
#> 145  ATOXGRN               Analysis Toxicity Grade (N)  Num     NA Perm   145
#> 146   BTOXGR                   Baseline Toxicity Grade Char     NA Perm   146
#> 147  BTOXGRN               Baseline Toxicity Grade (N)  Num     NA Perm   147
#> 148   ANRIND        Analysis Reference Range Indicator Char     NA Perm   148
#> 149   BNRIND        Baseline Reference Range Indicator Char     NA Perm   149
#> 150    ANRLO         Analysis Normal Range Lower Limit  Num     NA Perm   150
#> 151   ANRLOC     Analysis Normal Range Lower Limit (C) Char     NA Perm   151
#> 152    ANRHI         Analysis Normal Range Upper Limit  Num     NA Perm   152
#> 153   ANRHIC     Analysis Normal Range Upper Limit (C) Char     NA Perm   153
#> 154     AyLO              Analysis Range y Lower Limit  Num     NA Cond   154
#> 155    AyLOC          Analysis Range y Lower Limit (C) Char     NA Perm   155
#> 156     AyHI              Analysis Range y Upper Limit  Num     NA Cond   156
#> 157    AyHIC          Analysis Range y Upper Limit (C) Char     NA Perm   157
#> 158    AyIND                Analysis Range y Indicator Char     NA Perm   158
#> 159    ByIND       Baseline Analysis Range y Indicator Char     NA Perm   159
#> 160  ATOXGRL               Analysis Toxicity Grade Low Char     NA Perm   160
#> 161 ATOXGRLN           Analysis Toxicity Grade Low (N)  Num     NA Perm   161
#> 162  ATOXGRH              Analysis Toxicity Grade High Char     NA Perm   162
#> 163 ATOXGRHN          Analysis Toxicity Grade High (N)  Num     NA Perm   163
#> 164  BTOXGRL               Baseline Toxicity Grade Low Char     NA Perm   164
#> 165 BTOXGRLN           Baseline Toxicity Grade Low (N)  Num     NA Perm   165
#> 166  BTOXGRH              Baseline Toxicity Grade High Char     NA Perm   166
#> 167 BTOXGRHN          Baseline Toxicity Grade High (N)  Num     NA Perm   167
#> 168 ATOXDSCL         Analysis Toxicity Description Low Char     NA Perm   168
#> 169 ATOXDSCH        Analysis Toxicity Description High Char     NA Perm   169
#> 170    ABLFL                      Baseline Record Flag Char     NA Cond   170
#> 171    ABLFN                  Baseline Record Flag (N)  Num     NA Perm   171
#> 172  ANLzzFL                          Analysis Flag zz Char     NA Cond   172
#> 173  ANLzzFN                      Analysis Flag zz (N)  Num     NA Perm   173
#> 174  ONTRTFL                  On Treatment Record Flag Char     NA Perm   174
#> 175  ONTRTFN              On Treatment Record Flag (N)  Num     NA Perm   175
#> 176   LVOTFL       Last Value On Treatment Record Flag Char     NA Perm   176
#> 177   LVOTFN   Last Value On Treatment Record Flag (N)  Num     NA Perm   177
#> 178   ITTRFL         Intent-To-Treat Record-Level Flag Char     NA Perm   178
#> 179   SAFRFL         Safety Analysis Record-Level Flag Char     NA Perm   179
#> 180   FASRFL       Full Analysis Set Record-Level Flag Char     NA Perm   180
#> 181 PPROTRFL            Per-Protocol Record-Level Flag Char     NA Perm   181
#> 182 COMPLRFL              Completers Record-Level Flag Char     NA Perm   182
#> 183   ITTPFL      Intent-To-Treat Parameter-Level Flag Char     NA Perm   183
#> 184   SAFPFL      Safety Analysis Parameter-Level Flag Char     NA Perm   184
#> 185   FASPFL    Full Analysis Set Parameter-Level Flag Char     NA Perm   185
#> 186 PPROTPFL         Per-Protocol Parameter-Level Flag Char     NA Perm   186
#> 187 COMPLPFL           Completers Parameter-Level Flag Char     NA Perm   187
#> 188   SRCDOM                               Source Data Char     NA Perm   188
#> 189   SRCVAR                           Source Variable Char     NA Perm   189
#> 190   SRCSEQ                    Source Sequence Number  Num     NA Perm   190
#> 191  STUDYID                          Study Identifier Char     NA  Req   191
#> 192  USUBJID                 Unique Subject Identifier Char     NA  Req   192
#> 193   SUBJID          Subject Identifier for the Study Char     NA Perm   193
#> 194   SITEID                     Study Site Identifier Char     NA Perm   194
#> 195     ASEQ                  Analysis Sequence Number  Num     NA Perm   195
#> 196  SITEGRy                       Pooled Site Group y Char     NA Perm   196
#> 197 SITEGRyN                   Pooled Site Group y (N)  Num     NA Perm   197
#> 198  REGIONy                       Geographic Region y Char     NA Perm   198
#> 199 REGIONyN                   Geographic Region y (N)  Num     NA Perm   199
#> 200      AGE                                       Age  Num     NA Perm   200
#> 201     AGEU                                 Age Units Char     NA Perm   201
#> 202   AGEGRy                        Pooled Age Group y Char     NA Perm   202
#> 203  AGEGRyN                    Pooled Age Group y (N)  Num     NA Perm   203
#> 204     AAGE                              Analysis Age  Num     NA Perm   204
#> 205      SEX                                       Sex Char     NA Perm   205
#> 206     RACE                                      Race Char     NA Perm   206
#> 207  RACEGRy                       Pooled Race Group y Char     NA Perm   207
#> 208 RACEGRyN                   Pooled Race Group y (N)  Num     NA Perm   208
#> 209    FASFL         Full Analysis Set Population Flag Char     NA Perm   209
#> 210    SAFFL                    Safety Population Flag Char     NA Perm   210
#> 211    ITTFL           Intent-To-Treat Population Flag Char     NA Perm   211
#> 212  PPROTFL              Per-Protocol Population Flag Char     NA Perm   212
#> 213  COMPLFL                Completers Population Flag Char     NA Perm   213
#> 214   RANDFL                Randomized Population Flag Char     NA Perm   214
#> 215   ENRLFL                  Enrolled Population Flag Char     NA Perm   215
#> 216      ARM                Description of Planned Arm Char     NA Perm   216
#> 217   ACTARM                 Description of Actual Arm Char     NA Perm   217
#> 218   TRTxxP           Planned Treatment for Period xx Char     NA Perm   218
#> 219  TRTxxPN       Planned Treatment for Period xx (N)  Num     NA Perm   219
#> 220   TRTxxA            Actual Treatment for Period xx Char     NA Perm   220
#> 221  TRTxxAN        Actual Treatment for Period xx (N)  Num     NA Perm   221
#> 222  TRTSEQP            Planned Sequence of Treatments Char     NA Perm   222
#> 223 TRTSEQPN        Planned Sequence of Treatments (N)  Num     NA Perm   223
#> 224  TRTSEQA             Actual Sequence of Treatments Char     NA Perm   224
#> 225 TRTSEQAN         Actual Sequence of Treatments (N)  Num     NA Perm   225
#> 226  TRxxPGy  Planned Pooled Treatment y for Period xx Char     NA Perm   226
#> 227 TRxxPGyN    Planned Pooled Trt y for Period xx (N)  Num     NA Perm   227
#> 228  TRxxAGy   Actual Pooled Treatment y for Period xx Char     NA Perm   228
#> 229 TRxxAGyN     Actual Pooled Trt y for Period xx (N)  Num     NA Perm   229
#> 230  TSEQPGy       Planned Pooled Treatment Sequence y Char     NA Perm   230
#> 231 TSEQPGyN   Planned Pooled Treatment Sequence y (N)  Num     NA Perm   231
#> 232  TSEQAGy        Actual Pooled Treatment Sequence y Char     NA Perm   232
#> 233 TSEQAGyN    Actual Pooled Treatment Sequence y (N)  Num     NA Perm   233
#> 234  DOSExxP      Planned Treatment Dose for Period xx  Num     NA Perm   234
#> 235  DOSExxA       Actual Treatment Dose for Period xx  Num     NA Perm   235
#> 236  DOSExxU              Units for Dose for Period xx Char     NA Perm   236
#> 237   TRTSDT       Date of First Exposure to Treatment  Num     NA Perm   237
#> 238   TRTSTM       Time of First Exposure to Treatment  Num     NA Perm   238
#> 239  TRTSDTM   Datetime of First Exposure to Treatment  Num     NA Perm   239
#> 240  TRTSDTF        Date of First Exposure Imput. Flag Char     NA Perm   240
#> 241  TRTSTMF        Time of First Exposure Imput. Flag Char     NA Perm   241
#> 242   TRTEDT        Date of Last Exposure to Treatment  Num     NA Perm   242
#> 243   TRTETM        Time of Last Exposure to Treatment  Num     NA Perm   243
#> 244  TRTEDTM    Datetime of Last Exposure to Treatment  Num     NA Perm   244
#> 245  TRTEDTF         Date of Last Exposure Imput. Flag Char     NA Perm   245
#> 246  TRTETMF         Time of Last Exposure Imput. Flag Char     NA Perm   246
#> 247  TRxxSDT       Date of First Exposure in Period xx  Num     NA Perm   247
#> 248  TRxxSTM       Time of First Exposure in Period xx  Num     NA Perm   248
#> 249 TRxxSDTM   Datetime of First Exposure in Period xx  Num     NA Perm   249
#> 250 TRxxSDTF   Date 1st Exposure Period xx Imput. Flag Char     NA Perm   250
#> 251 TRxxSTMF   Time 1st Exposure Period xx Imput. Flag Char     NA Perm   251
#> 252  TRxxEDT        Date of Last Exposure in Period xx  Num     NA Perm   252
#> 253  TRxxETM        Time of Last Exposure in Period xx  Num     NA Perm   253
#> 254 TRxxEDTM    Datetime of Last Exposure in Period xx  Num     NA Perm   254
#> 255 TRxxEDTF  Date Last Exposure Period xx Imput. Flag Char     NA Perm   255
#> 256 TRxxETMF  Time Last Exposure Period xx Imput. Flag Char     NA Perm   256
#> 257  APxxSDT                      Period xx Start Date  Num     NA Perm   257
#> 258  APxxSTM                      Period xx Start Time  Num     NA Perm   258
#> 259 APxxSDTM                  Period xx Start Datetime  Num     NA Perm   259
#> 260 APxxSDTF          Period xx Start Date Imput. Flag Char     NA Perm   260
#> 261 APxxSTMF          Period xx Start Time Imput. Flag Char     NA Perm   261
#> 262  APxxEDT                        Period xx End Date  Num     NA Perm   262
#> 263  APxxETM                        Period xx End Time  Num     NA Perm   263
#> 264 APxxEDTM                    Period xx End Datetime  Num     NA Perm   264
#> 265 APxxEDTF            Period xx End Date Imput. Flag Char     NA Perm   265
#> 266 APxxETMF            Period xx End Time Imput. Flag Char     NA Perm   266
#> 267    PxxSw      Description of Period xx Subperiod w Char     NA Perm   267
#> 268 PxxSwSDT          Period xx Subperiod w Start Date  Num     NA Perm   268
#> 269 PxxSwSTM          Period xx Subperiod w Start Time  Num     NA Perm   269
#> 270 PxxSwSDM      Period xx Subperiod w Start Datetime  Num     NA Perm   270
#> 271 PxxSwSDF  Period xx Subper w Start Date Imput Flag Char     NA Perm   271
#> 272 PxxSwSTF  Period xx Subper w Start Time Imput Flag Char     NA Perm   272
#> 273 PxxSwEDT            Period xx Subperiod w End Date  Num     NA Perm   273
#> 274 PxxSwETM            Period xx Subperiod w End Time  Num     NA Perm   274
#> 275 PxxSwEDM        Period xx Subperiod w End Datetime  Num     NA Perm   275
#> 276 PxxSwEDF    Period xx Subper w End Date Imput Flag Char     NA Perm   276
#> 277 PxxSwETF    Period xx Subper w End Time Imput Flag Char     NA Perm   277
#> 278  APHASEw                    Description of Phase w Char     NA Perm   278
#> 279   PHwSDT                        Phase w Start Date  Num     NA Perm   279
#> 280   PHwSTM                        Phase w Start Time  Num     NA Perm   280
#> 281  PHwSDTM                    Phase w Start Datetime  Num     NA Perm   281
#> 282  PHwSDTF        Phase w Start Date Imputation Flag Char     NA Perm   282
#> 283  PHwSTMF        Phase w Start Time Imputation Flag Char     NA Perm   283
#> 284   PHwEDT                          Phase w End Date  Num     NA Perm   284
#> 285   PHwETM                          Phase w End Time  Num     NA Perm   285
#> 286  PHwEDTM                      Phase w End Datetime  Num     NA Perm   286
#> 287  PHwEDTF          Phase w End Date Imputation Flag Char     NA Perm   287
#> 288  PHwETMF          Phase w End Time Imputation Flag Char     NA Perm   288
#> 289   EOSSTT                       End of Study Status Char     NA Perm   289
#> 290    EOSDT                         End of Study Date  Num     NA Perm   290
#> 291  DCSREAS     Reason for Discontinuation from Study Char     NA Perm   291
#> 292 DCSREASP        Reason Spec for Discont from Study Char     NA Perm   292
#> 293   EOTSTT                   End of Treatment Status Char     NA Perm   293
#> 294  DCTREAS   Reason for Discontinuation of Treatment Char     NA Perm   294
#> 295 DCTREASP   Reason Specify for Discont of Treatment Char     NA Perm   295
#> 296 EOTxxSTT      End of Treatment Status in Period xx Char     NA Perm   296
#> 297  DCTxxRS  Reason for Discont of Treat in Period xx Char     NA Perm   297
#> 298 DCTxxRSP  Reason Spec for Disc of Trt in Period xx Char     NA Perm   298
#> 299 EOPxxSTT                   End of Period xx Status Char     NA Perm   299
#> 300  DCPxxRS         Reason for Discont from Period xx Char     NA Perm   300
#> 301 DCPxxRSP    Reason Spec for Discont from Period xx Char     NA Perm   301
#> 302   RFICDT                  Date of Informed Consent  Num     NA Perm   302
#> 303   ENRLDT                        Date of Enrollment  Num     NA Perm   303
#> 304   RANDDT                     Date of Randomization  Num     NA Perm   304
#> 305  RFICyDT                Date of Informed Consent y  Num     NA Perm   305
#> 306  ENRLyDT                      Date of Enrollment y  Num     NA Perm   306
#> 307  RANDyDT                   Date of Randomization y  Num     NA Perm   307
#> 308 LSTALVDT                     Date Last Known Alive  Num     NA Perm   308
#> 309    TRCMP                  Treatment Compliance (%)  Num     NA Perm   309
#> 310  TRCMPGy          Treatment Compliance (%) Group y Char     NA Perm   310
#> 311 TRCMPGyN      Treatment Compliance (%) Group y (N)  Num     NA Perm   311
#> 312 TRxxDURD    Treatment Duration in Period xx (Days)  Num     NA Perm   312
#> 313 TRxxDURM  Treatment Duration in Period xx (Months)  Num     NA Perm   313
#> 314 TRxxDURY   Treatment Duration in Period xx (Years)  Num     NA Perm   314
#> 315  TRTDURD           Total Treatment Duration (Days)  Num     NA Perm   315
#> 316  TRTDURM         Total Treatment Duration (Months)  Num     NA Perm   316
#> 317  TRTDURY          Total Treatment Duration (Years)  Num     NA Perm   317
#> 318    DTHDT                             Date of Death  Num     NA Perm   318
#> 319   DTHDTF             Date of Death Imputation Flag Char     NA Perm   319
#> 320  DTHCAUS                            Cause of Death Char     NA Perm   320
#> 321 DTHCAUSN                        Cause of Death (N)  Num     NA Perm   321
#> 322  DTHCGRy                    Cause of Death Group y Char     NA Perm   322
#> 323 DTHCGRyN                Cause of Death Group y (N)  Num     NA Perm   323
#> 324  STRATAR             Strata Used for Randomization Char     NA Perm   324
#> 325 STRATARN         Strata Used for Randomization (N)  Num     NA Perm   325
#> 326  STRATwD    Description of Stratification Factor w Char     NA Perm   326
#> 327  STRATwR        Strat Factor w Value Used for Rand Char     NA Perm   327
#> 328 STRATwRN    Strat Factor w Value Used for Rand (N)  Num     NA Perm   328
#> 329  STRATAV           Strata from Verification Source Char     NA Perm   329
#> 330 STRATAVN       Strata from Verification Source (N)  Num     NA Perm   330
#> 331  STRATwV    Strat Factor w Value from Verif Source Char     NA Perm   331
#> 332 STRATwVN    Strat Fact w Val from Verif Source (N)  Num     NA Perm   332
#> 333   DOMAIN                       Domain Abbreviation Char     NA Perm   333
#> 334    PPSEQ                           Sequence Number  Num     NA Perm   334
#> 335  PPGRPID                                  Group ID Char     NA Perm   335
#> 336 PPTESTCD                      Parameter Short Name Char     NA Perm   336
#> 337   PPTEST                            Parameter Name Char     NA Perm   337
#> 338    PPCAT                        Parameter Category Char     NA Perm   338
#> 339   PPSCAT                     Parameter Subcategory Char     NA Perm   339
#> 340  PPORRES       Result or Finding in Original Units Char     NA Perm   340
#> 341 PPORRESU                            Original Units Char     NA Perm   341
#> 342 PPSTRESC    Character Result/Finding in Std Format Char     NA Perm   342
#> 343 PPSTRESN  Numeric Result/Finding in Standard Units  Num     NA Perm   343
#> 344 PPSTRESU                            Standard Units Char     NA Perm   344
#> 345   PPSTAT                         Completion Status Char     NA Perm   345
#> 346 PPREASND           Reason Parameter Not Calculated Char     NA Perm   346
#> 347   PPSPEC                    Specimen Material Type Char     NA Perm   347
#> 348 PPANMETH                           Analysis Method Char     NA Perm   348
#> 349  TAETORD       Planned Order of Element within Arm  Num     NA Perm   349
#> 350    EPOCH                                     Epoch Char     NA Perm   350
#> 351    PPDTC       Date/Time of Parameter Calculations Char     NA Perm   351
#> 352     PPDY       Study Day of Parameter Calculations  Num     NA Perm   352
#> 353 PPTPTREF                      Time Point Reference Char     NA Perm   353
#> 354 PPRFTDTC              Date/Time of Reference Point Char     NA Perm   354
#> 355  PPSTINT      Planned Start of Assessment Interval Char     NA Perm   355
#> 356  PPENINT        Planned End of Assessment Interval Char     NA Perm   356
#>     source codelist_id
#> 1      BDS        <NA>
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
#> 18     BDS      C81223
#> 19     BDS      C81226
#> 20     BDS        <NA>
#> 21     BDS        <NA>
#> 22     BDS        <NA>
#> 23     BDS        <NA>
#> 24     BDS      C81223
#> 25     BDS      C81226
#> 26     BDS        <NA>
#> 27     BDS        <NA>
#> 28     BDS        <NA>
#> 29     BDS        <NA>
#> 30     BDS      C81223
#> 31     BDS      C81226
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
#> 48     BDS      C81223
#> 49     BDS      C81226
#> 50     BDS        <NA>
#> 51     BDS        <NA>
#> 52     BDS        <NA>
#> 53     BDS      C81223
#> 54     BDS      C81226
#> 55     BDS        <NA>
#> 56     BDS        <NA>
#> 57     BDS        <NA>
#> 58     BDS      C81223
#> 59     BDS      C81226
#> 60     BDS        <NA>
#> 61     BDS        <NA>
#> 62     BDS        <NA>
#> 63     BDS      C81223
#> 64     BDS      C81226
#> 65     BDS        <NA>
#> 66     BDS        <NA>
#> 67     BDS        <NA>
#> 68     BDS      C81223
#> 69     BDS      C81226
#> 70     BDS        <NA>
#> 71     BDS        <NA>
#> 72     BDS        <NA>
#> 73     BDS      C81223
#> 74     BDS      C81226
#> 75     BDS        <NA>
#> 76     BDS        <NA>
#> 77     BDS        <NA>
#> 78     BDS        <NA>
#> 79     BDS      C81223
#> 80     BDS      C81226
#> 81     BDS        <NA>
#> 82     BDS        <NA>
#> 83     BDS        <NA>
#> 84     BDS        <NA>
#> 85     BDS      C81223
#> 86     BDS      C81226
#> 87     BDS        <NA>
#> 88     BDS        <NA>
#> 89     BDS        <NA>
#> 90     BDS        <NA>
#> 91     BDS      C81223
#> 92     BDS      C81226
#> 93     BDS        <NA>
#> 94     BDS        <NA>
#> 95     BDS        <NA>
#> 96     BDS        <NA>
#> 97     BDS        <NA>
#> 98     BDS        <NA>
#> 99     BDS        <NA>
#> 100    BDS        <NA>
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
#> 117    BDS        <NA>
#> 118    BDS        <NA>
#> 119    BDS        <NA>
#> 120    BDS        <NA>
#> 121    BDS        <NA>
#> 122    BDS        <NA>
#> 123    BDS        <NA>
#> 124    BDS        <NA>
#> 125    BDS        <NA>
#> 126    BDS        <NA>
#> 127    BDS        <NA>
#> 128    BDS        <NA>
#> 129    BDS        <NA>
#> 130    BDS      C81224
#> 131    BDS        <NA>
#> 132    BDS        <NA>
#> 133    BDS        <NA>
#> 134    BDS        <NA>
#> 135    BDS        <NA>
#> 136    BDS        <NA>
#> 137    BDS        <NA>
#> 138    BDS        <NA>
#> 139    BDS      C81223
#> 140    BDS      C81226
#> 141    BDS        <NA>
#> 142    BDS        <NA>
#> 143    BDS        <NA>
#> 144    BDS        <NA>
#> 145    BDS        <NA>
#> 146    BDS        <NA>
#> 147    BDS        <NA>
#> 148    BDS        <NA>
#> 149    BDS        <NA>
#> 150    BDS        <NA>
#> 151    BDS        <NA>
#> 152    BDS        <NA>
#> 153    BDS        <NA>
#> 154    BDS        <NA>
#> 155    BDS        <NA>
#> 156    BDS        <NA>
#> 157    BDS        <NA>
#> 158    BDS        <NA>
#> 159    BDS        <NA>
#> 160    BDS        <NA>
#> 161    BDS        <NA>
#> 162    BDS        <NA>
#> 163    BDS        <NA>
#> 164    BDS        <NA>
#> 165    BDS        <NA>
#> 166    BDS        <NA>
#> 167    BDS        <NA>
#> 168    BDS        <NA>
#> 169    BDS        <NA>
#> 170    BDS        <NA>
#> 171    BDS        <NA>
#> 172    BDS        <NA>
#> 173    BDS        <NA>
#> 174    BDS        <NA>
#> 175    BDS        <NA>
#> 176    BDS        <NA>
#> 177    BDS        <NA>
#> 178    BDS        <NA>
#> 179    BDS        <NA>
#> 180    BDS        <NA>
#> 181    BDS        <NA>
#> 182    BDS        <NA>
#> 183    BDS        <NA>
#> 184    BDS        <NA>
#> 185    BDS        <NA>
#> 186    BDS        <NA>
#> 187    BDS        <NA>
#> 188    BDS        <NA>
#> 189    BDS        <NA>
#> 190    BDS        <NA>
#> 191    BDS        <NA>
#> 192    BDS        <NA>
#> 193    BDS        <NA>
#> 194    BDS        <NA>
#> 195    BDS        <NA>
#> 196   ADSL        <NA>
#> 197   ADSL        <NA>
#> 198   ADSL        <NA>
#> 199   ADSL        <NA>
#> 200   ADSL        <NA>
#> 201   ADSL      C66781
#> 202   ADSL        <NA>
#> 203   ADSL        <NA>
#> 204   ADSL        <NA>
#> 205   ADSL      C66731
#> 206   ADSL        <NA>
#> 207   ADSL        <NA>
#> 208   ADSL        <NA>
#> 209   ADSL        <NA>
#> 210   ADSL        <NA>
#> 211   ADSL        <NA>
#> 212   ADSL        <NA>
#> 213   ADSL        <NA>
#> 214   ADSL        <NA>
#> 215   ADSL        <NA>
#> 216   ADSL        <NA>
#> 217   ADSL        <NA>
#> 218   ADSL        <NA>
#> 219   ADSL        <NA>
#> 220   ADSL        <NA>
#> 221   ADSL        <NA>
#> 222   ADSL        <NA>
#> 223   ADSL        <NA>
#> 224   ADSL        <NA>
#> 225   ADSL        <NA>
#> 226   ADSL        <NA>
#> 227   ADSL        <NA>
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
#> 240   ADSL      C81223
#> 241   ADSL      C81226
#> 242   ADSL        <NA>
#> 243   ADSL        <NA>
#> 244   ADSL        <NA>
#> 245   ADSL      C81223
#> 246   ADSL      C81226
#> 247   ADSL        <NA>
#> 248   ADSL        <NA>
#> 249   ADSL        <NA>
#> 250   ADSL      C81223
#> 251   ADSL      C81226
#> 252   ADSL        <NA>
#> 253   ADSL        <NA>
#> 254   ADSL        <NA>
#> 255   ADSL      C81223
#> 256   ADSL      C81226
#> 257   ADSL        <NA>
#> 258   ADSL        <NA>
#> 259   ADSL        <NA>
#> 260   ADSL      C81223
#> 261   ADSL      C81226
#> 262   ADSL        <NA>
#> 263   ADSL        <NA>
#> 264   ADSL        <NA>
#> 265   ADSL      C81223
#> 266   ADSL      C81226
#> 267   ADSL        <NA>
#> 268   ADSL        <NA>
#> 269   ADSL        <NA>
#> 270   ADSL        <NA>
#> 271   ADSL      C81223
#> 272   ADSL      C81226
#> 273   ADSL        <NA>
#> 274   ADSL        <NA>
#> 275   ADSL        <NA>
#> 276   ADSL      C81223
#> 277   ADSL      C81226
#> 278   ADSL        <NA>
#> 279   ADSL        <NA>
#> 280   ADSL        <NA>
#> 281   ADSL        <NA>
#> 282   ADSL      C81223
#> 283   ADSL      C81226
#> 284   ADSL        <NA>
#> 285   ADSL        <NA>
#> 286   ADSL        <NA>
#> 287   ADSL      C81223
#> 288   ADSL      C81226
#> 289   ADSL     C124296
#> 290   ADSL        <NA>
#> 291   ADSL        <NA>
#> 292   ADSL        <NA>
#> 293   ADSL     C124296
#> 294   ADSL        <NA>
#> 295   ADSL        <NA>
#> 296   ADSL     C124296
#> 297   ADSL        <NA>
#> 298   ADSL        <NA>
#> 299   ADSL     C124296
#> 300   ADSL        <NA>
#> 301   ADSL        <NA>
#> 302   ADSL        <NA>
#> 303   ADSL        <NA>
#> 304   ADSL        <NA>
#> 305   ADSL        <NA>
#> 306   ADSL        <NA>
#> 307   ADSL        <NA>
#> 308   ADSL        <NA>
#> 309   ADSL        <NA>
#> 310   ADSL        <NA>
#> 311   ADSL        <NA>
#> 312   ADSL        <NA>
#> 313   ADSL        <NA>
#> 314   ADSL        <NA>
#> 315   ADSL        <NA>
#> 316   ADSL        <NA>
#> 317   ADSL        <NA>
#> 318   ADSL        <NA>
#> 319   ADSL      C81223
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
#> 333 SDTMIG        <NA>
#> 334 SDTMIG        <NA>
#> 335 SDTMIG        <NA>
#> 336 SDTMIG      C85839
#> 337 SDTMIG      C85493
#> 338 SDTMIG        <NA>
#> 339 SDTMIG        <NA>
#> 340 SDTMIG        <NA>
#> 341 SDTMIG      C85494
#> 342 SDTMIG        <NA>
#> 343 SDTMIG        <NA>
#> 344 SDTMIG      C85494
#> 345 SDTMIG      C66789
#> 346 SDTMIG        <NA>
#> 347 SDTMIG      C78734
#> 348 SDTMIG     C172330
#> 349 SDTMIG        <NA>
#> 350 SDTMIG      C99079
#> 351 SDTMIG        <NA>
#> 352 SDTMIG        <NA>
#> 353 SDTMIG        <NA>
#> 354 SDTMIG        <NA>
#> 355 SDTMIG        <NA>
#> 356 SDTMIG        <NA>
build_domain_spec("ADPP", extension = "NCA")   # BDS + ADSL + ADaMIG-NCA
#>     variable                                     label type length core order
#> 1       TRTP                         Planned Treatment Char     NA Cond     1
#> 2      TRTPN                     Planned Treatment (N)  Num     NA Perm     2
#> 3       TRTA                          Actual Treatment Char     NA Cond     3
#> 4      TRTAN                      Actual Treatment (N)  Num     NA Perm     4
#> 5     TRTPGy                Planned Pooled Treatment y Char     NA Perm     5
#> 6    TRTPGyN            Planned Pooled Treatment y (N)  Num     NA Perm     6
#> 7     TRTAGy                 Actual Pooled Treatment y Char     NA Cond     7
#> 8    TRTAGyN             Actual Pooled Treatment y (N)  Num     NA Perm     8
#> 9      DOSEP                    Planned Treatment Dose  Num     NA Perm     9
#> 10   DOSCUMP         Cumulative Planned Treatment Dose  Num     NA Perm    10
#> 11     DOSEA                     Actual Treatment Dose  Num     NA  Req    11
#> 12   DOSCUMA          Cumulative Actual Treatment Dose  Num     NA Perm    12
#> 13     DOSEU                      Treatment Dose Units Char     NA  Req    13
#> 14       ADT                             Analysis Date  Num     NA Cond    14
#> 15       ATM                             Analysis Time  Num     NA Cond    15
#> 16      ADTM                         Analysis Datetime  Num     NA Cond    16
#> 17       ADY                     Analysis Relative Day  Num     NA Cond    17
#> 18      ADTF             Analysis Date Imputation Flag Char     NA Cond    18
#> 19      ATMF             Analysis Time Imputation Flag Char     NA Cond    19
#> 20     ASTDT                       Analysis Start Date  Num     NA Cond    20
#> 21     ASTTM                       Analysis Start Time  Num     NA Cond    21
#> 22    ASTDTM                   Analysis Start Datetime  Num     NA Cond    22
#> 23     ASTDY               Analysis Start Relative Day  Num     NA Cond    23
#> 24    ASTDTF       Analysis Start Date Imputation Flag Char     NA Cond    24
#> 25    ASTTMF       Analysis Start Time Imputation Flag Char     NA Cond    25
#> 26     AENDT                         Analysis End Date  Num     NA Cond    26
#> 27     AENTM                         Analysis End Time  Num     NA Cond    27
#> 28    AENDTM                     Analysis End Datetime  Num     NA Cond    28
#> 29     AENDY                 Analysis End Relative Day  Num     NA Cond    29
#> 30    AENDTF         Analysis End Date Imputation Flag Char     NA Cond    30
#> 31    AENTMF         Analysis End Time Imputation Flag Char     NA Cond    31
#> 32    AVISIT                            Analysis Visit Char     NA  Req    32
#> 33   AVISITN                        Analysis Visit (N)  Num     NA Perm    33
#> 34      ATPT                        Analysis Timepoint Char     NA Cond    34
#> 35     ATPTN                    Analysis Timepoint (N)  Num     NA Perm    35
#> 36   ATPTREF              Analysis Timepoint Reference Char     NA Perm    36
#> 37    APHASE                                     Phase Char     NA Perm    37
#> 38   APHASEN                                 Phase (N)  Num     NA Perm    38
#> 39   APERIOD                                    Period  Num     NA Cond    39
#> 40  APERIODC                                Period (C) Char     NA Perm    40
#> 41     ASPER                   Subperiod within Period  Num     NA Perm    41
#> 42    ASPERC               Subperiod within Period (C) Char     NA Perm    42
#> 43    ARELTM                    Analysis Relative Time  Num     NA Perm    43
#> 44   ARELTMU               Analysis Relative Time Unit Char     NA Perm    44
#> 45   APERSDT                         Period Start Date  Num     NA Perm    45
#> 46   APERSTM                         Period Start Time  Num     NA Perm    46
#> 47  APERSDTM                     Period Start Datetime  Num     NA Perm    47
#> 48  APERSDTF             Period Start Date Imput. Flag Char     NA Cond    48
#> 49  APERSTMF             Period Start Time Imput. Flag Char     NA Cond    49
#> 50   APEREDT                           Period End Date  Num     NA Perm    50
#> 51   APERETM                           Period End Time  Num     NA Perm    51
#> 52  APEREDTM                       Period End Datetime  Num     NA Perm    52
#> 53  APEREDTF               Period End Date Imput. Flag Char     NA Cond    53
#> 54  APERETMF               Period End Time Imput. Flag Char     NA Cond    54
#> 55   ASPRSDT                      Subperiod Start Date  Num     NA Perm    55
#> 56   ASPRSTM                      Subperiod Start Time  Num     NA Perm    56
#> 57  ASPRSDTM                  Subperiod Start Datetime  Num     NA Perm    57
#> 58  ASPRSDTF          Subperiod Start Date Imput. Flag Char     NA Cond    58
#> 59  ASPRSTMF          Subperiod Start Time Imput. Flag Char     NA Cond    59
#> 60   ASPREDT                        Subperiod End Date  Num     NA Perm    60
#> 61   ASPRETM                        Subperiod End Time  Num     NA Perm    61
#> 62  ASPREDTM                    Subperiod End Datetime  Num     NA Perm    62
#> 63  ASPREDTF            Subperiod End Date Imput. Flag Char     NA Cond    63
#> 64  ASPRETMF            Subperiod End Time Imput. Flag Char     NA Cond    64
#> 65     PHSDT                          Phase Start Date  Num     NA Perm    65
#> 66     PHSTM                          Phase Start Time  Num     NA Perm    66
#> 67    PHSDTM                      Phase Start Datetime  Num     NA Perm    67
#> 68    PHSDTF              Phase Start Date Imput. Flag Char     NA Cond    68
#> 69    PHSTMF              Phase Start Time Imput. Flag Char     NA Cond    69
#> 70     PHEDT                            Phase End Date  Num     NA Perm    70
#> 71     PHETM                            Phase End Time  Num     NA Perm    71
#> 72    PHEDTM                        Phase End Datetime  Num     NA Perm    72
#> 73    PHEDTF                Phase End Date Imput. Flag Char     NA Cond    73
#> 74    PHETMF                Phase End Time Imput. Flag Char     NA Cond    74
#> 75       *DT                                    {Date}  Num     NA Perm    75
#> 76       *TM                                    {Time}  Num     NA Perm    76
#> 77      *DTM                                {Datetime}  Num     NA Perm    77
#> 78      *ADY                            {Relative Day}  Num     NA Perm    78
#> 79      *DTF                    {Date Imputation Flag} Char     NA Cond    79
#> 80      *TMF                    {Time Imputation Flag} Char     NA Cond    80
#> 81      *SDT                              {Start Date}  Num     NA Perm    81
#> 82      *STM                              {Start Time}  Num     NA Perm    82
#> 83     *SDTM                          {Start Datetime}  Num     NA Perm    83
#> 84      *SDY                      {Relative Start Day}  Num     NA Perm    84
#> 85     *SDTF              {Start Date Imputation Flag} Char     NA Cond    85
#> 86     *STMF              {Start Time Imputation Flag} Char     NA Cond    86
#> 87      *EDT                                {End Date}  Num     NA Perm    87
#> 88      *ETM                                {End Time}  Num     NA Perm    88
#> 89     *EDTM                            {End Datetime}  Num     NA Perm    89
#> 90      *EDY                        {Relative End Day}  Num     NA Perm    90
#> 91     *EDTF                {End Date Imputation Flag} Char     NA Cond    91
#> 92     *ETMF                {End Time Imputation Flag} Char     NA Cond    92
#> 93     PARAM                                 Parameter Char     NA  Req    93
#> 94   PARAMCD                            Parameter Code Char     NA  Req    94
#> 95    PARAMN                             Parameter (N)  Num     NA Perm    95
#> 96   PARCATy                      Parameter Category y Char     NA Perm    96
#> 97  PARCATyN                  Parameter Category y (N)  Num     NA Perm    97
#> 98      AVAL                            Analysis Value  Num     NA Cond    98
#> 99     AVALC                        Analysis Value (C) Char     NA Cond    99
#> 100 AVALCATy                 Analysis Value Category y Char     NA Perm   100
#> 101 AVALCAyN             Analysis Value Category y (N)  Num     NA Perm   101
#> 102     BASE                            Baseline Value  Num     NA Cond   102
#> 103    BASEC                        Baseline Value (C) Char     NA Perm   103
#> 104 BASECATy                       Baseline Category y Char     NA Perm   104
#> 105 BASECAyN                   Baseline Category y (N)  Num     NA Perm   105
#> 106 BASETYPE                             Baseline Type Char     NA Cond   106
#> 107      CHG                      Change from Baseline  Num     NA Perm   107
#> 108  CHGCATy           Change from Baseline Category y Char     NA Perm   108
#> 109 CHGCATyN       Change from Baseline Category y (N)  Num     NA Perm   109
#> 110     PCHG              Percent Change from Baseline  Num     NA Perm   110
#> 111 PCHGCATy      Percent Chg from Baseline Category y Char     NA Perm   111
#> 112 PCHGCAyN  Percent Chg from Baseline Category y (N)  Num     NA Perm   112
#> 113   R2BASE                         Ratio to Baseline  Num     NA Perm   113
#> 114   R2AyLO     Ratio to Analysis Range y Lower Limit  Num     NA Perm   114
#> 115   R2AyHI     Ratio to Analysis Range y Upper Limit  Num     NA Perm   115
#> 116   SHIFTy                                   Shift y Char     NA Perm   116
#> 117  SHIFTyN                               Shift y (N)  Num     NA Perm   117
#> 118     BCHG                        Change to Baseline  Num     NA Perm   118
#> 119 BCHGCATy             Change to Baseline Category y Char     NA Perm   119
#> 120 BCHGCAyN         Change to Baseline Category y (N)  Num     NA Perm   120
#> 121    PBCHG                Percent Change to Baseline  Num     NA Perm   121
#> 122 PBCHGCAy     Percent Change to Baseline Category y Char     NA Perm   122
#> 123 PBCHGCyN Percent Change to Baseline Category y (N)  Num     NA Perm   123
#> 124    CRITy                      Analysis Criterion y Char     NA Perm   124
#> 125  CRITyFL        Criterion y Evaluation Result Flag Char     NA Cond   125
#> 126  CRITyFN    Criterion y Evaluation Result Flag (N)  Num     NA Perm   126
#> 127   MCRITy       Analysis Multi-Response Criterion y Char     NA Perm   127
#> 128 MCRITyML     Multi-Response Criterion y Evaluation Char     NA Cond   128
#> 129 MCRITyMN       Multi-Response Criterion y Eval (N)  Num     NA Perm   129
#> 130    DTYPE                           Derivation Type Char     NA Cond   130
#> 131  AWRANGE      Analysis Window Valid Relative Range Char     NA Perm   131
#> 132 AWTARGET                    Analysis Window Target  Num     NA Perm   132
#> 133  AWTDIFF          Analysis Window Diff from Target  Num     NA Perm   133
#> 134     AWLO       Analysis Window Beginning Timepoint  Num     NA Perm   134
#> 135     AWHI          Analysis Window Ending Timepoint  Num     NA Perm   135
#> 136      AWU                      Analysis Window Unit Char     NA Perm   136
#> 137  STARTDT     Time-to-Event Origin Date for Subject  Num     NA Perm   137
#> 138 STARTDTM             Time-to-Event Origin Datetime  Num     NA Perm   138
#> 139 STARTDTF               Origin Date Imputation Flag Char     NA Cond   139
#> 140 STARTTMF               Origin Time Imputation Flag Char     NA Cond   140
#> 141     CNSR                                    Censor  Num     NA Cond   141
#> 142 EVNTDESC            Event or Censoring Description Char     NA Perm   142
#> 143 CNSDTDSC                   Censor Date Description Char     NA Perm   143
#> 144   ATOXGR                   Analysis Toxicity Grade Char     NA Perm   144
#> 145  ATOXGRN               Analysis Toxicity Grade (N)  Num     NA Perm   145
#> 146   BTOXGR                   Baseline Toxicity Grade Char     NA Perm   146
#> 147  BTOXGRN               Baseline Toxicity Grade (N)  Num     NA Perm   147
#> 148   ANRIND        Analysis Reference Range Indicator Char     NA Perm   148
#> 149   BNRIND        Baseline Reference Range Indicator Char     NA Perm   149
#> 150    ANRLO         Analysis Normal Range Lower Limit  Num     NA Perm   150
#> 151   ANRLOC     Analysis Normal Range Lower Limit (C) Char     NA Perm   151
#> 152    ANRHI         Analysis Normal Range Upper Limit  Num     NA Perm   152
#> 153   ANRHIC     Analysis Normal Range Upper Limit (C) Char     NA Perm   153
#> 154     AyLO              Analysis Range y Lower Limit  Num     NA Cond   154
#> 155    AyLOC          Analysis Range y Lower Limit (C) Char     NA Perm   155
#> 156     AyHI              Analysis Range y Upper Limit  Num     NA Cond   156
#> 157    AyHIC          Analysis Range y Upper Limit (C) Char     NA Perm   157
#> 158    AyIND                Analysis Range y Indicator Char     NA Perm   158
#> 159    ByIND       Baseline Analysis Range y Indicator Char     NA Perm   159
#> 160  ATOXGRL               Analysis Toxicity Grade Low Char     NA Perm   160
#> 161 ATOXGRLN           Analysis Toxicity Grade Low (N)  Num     NA Perm   161
#> 162  ATOXGRH              Analysis Toxicity Grade High Char     NA Perm   162
#> 163 ATOXGRHN          Analysis Toxicity Grade High (N)  Num     NA Perm   163
#> 164  BTOXGRL               Baseline Toxicity Grade Low Char     NA Perm   164
#> 165 BTOXGRLN           Baseline Toxicity Grade Low (N)  Num     NA Perm   165
#> 166  BTOXGRH              Baseline Toxicity Grade High Char     NA Perm   166
#> 167 BTOXGRHN          Baseline Toxicity Grade High (N)  Num     NA Perm   167
#> 168 ATOXDSCL         Analysis Toxicity Description Low Char     NA Perm   168
#> 169 ATOXDSCH        Analysis Toxicity Description High Char     NA Perm   169
#> 170    ABLFL                      Baseline Record Flag Char     NA Cond   170
#> 171    ABLFN                  Baseline Record Flag (N)  Num     NA Perm   171
#> 172  ANLzzFL                          Analysis Flag zz Char     NA Cond   172
#> 173  ANLzzFN                      Analysis Flag zz (N)  Num     NA Perm   173
#> 174  ONTRTFL                  On Treatment Record Flag Char     NA Perm   174
#> 175  ONTRTFN              On Treatment Record Flag (N)  Num     NA Perm   175
#> 176   LVOTFL       Last Value On Treatment Record Flag Char     NA Perm   176
#> 177   LVOTFN   Last Value On Treatment Record Flag (N)  Num     NA Perm   177
#> 178   ITTRFL         Intent-To-Treat Record-Level Flag Char     NA Perm   178
#> 179   SAFRFL         Safety Analysis Record-Level Flag Char     NA Perm   179
#> 180   FASRFL       Full Analysis Set Record-Level Flag Char     NA Perm   180
#> 181 PPROTRFL            Per-Protocol Record-Level Flag Char     NA Perm   181
#> 182 COMPLRFL              Completers Record-Level Flag Char     NA Perm   182
#> 183   ITTPFL      Intent-To-Treat Parameter-Level Flag Char     NA Perm   183
#> 184   SAFPFL      Safety Analysis Parameter-Level Flag Char     NA Perm   184
#> 185   FASPFL    Full Analysis Set Parameter-Level Flag Char     NA Perm   185
#> 186 PPROTPFL         Per-Protocol Parameter-Level Flag Char     NA Perm   186
#> 187 COMPLPFL           Completers Parameter-Level Flag Char     NA Perm   187
#> 188   SRCDOM                               Source Data Char     NA Perm   188
#> 189   SRCVAR                           Source Variable Char     NA Perm   189
#> 190   SRCSEQ                    Source Sequence Number  Num     NA Perm   190
#> 191  STUDYID                          Study Identifier Char     NA  Req   191
#> 192  USUBJID                 Unique Subject Identifier Char     NA  Req   192
#> 193   SUBJID          Subject Identifier for the Study Char     NA Perm   193
#> 194   SITEID                     Study Site Identifier Char     NA Perm   194
#> 195     ASEQ                  Analysis Sequence Number  Num     NA Perm   195
#> 196  SITEGRy                       Pooled Site Group y Char     NA Perm   196
#> 197 SITEGRyN                   Pooled Site Group y (N)  Num     NA Perm   197
#> 198  REGIONy                       Geographic Region y Char     NA Perm   198
#> 199 REGIONyN                   Geographic Region y (N)  Num     NA Perm   199
#> 200      AGE                                       Age  Num     NA Perm   200
#> 201     AGEU                                 Age Units Char     NA Perm   201
#> 202   AGEGRy                        Pooled Age Group y Char     NA Perm   202
#> 203  AGEGRyN                    Pooled Age Group y (N)  Num     NA Perm   203
#> 204     AAGE                              Analysis Age  Num     NA Perm   204
#> 205      SEX                                       Sex Char     NA Perm   205
#> 206     RACE                                      Race Char     NA Perm   206
#> 207  RACEGRy                       Pooled Race Group y Char     NA Perm   207
#> 208 RACEGRyN                   Pooled Race Group y (N)  Num     NA Perm   208
#> 209    FASFL         Full Analysis Set Population Flag Char     NA Perm   209
#> 210    SAFFL                    Safety Population Flag Char     NA Perm   210
#> 211    ITTFL           Intent-To-Treat Population Flag Char     NA Perm   211
#> 212  PPROTFL              Per-Protocol Population Flag Char     NA Perm   212
#> 213  COMPLFL                Completers Population Flag Char     NA Perm   213
#> 214   RANDFL                Randomized Population Flag Char     NA Perm   214
#> 215   ENRLFL                  Enrolled Population Flag Char     NA Perm   215
#> 216      ARM                Description of Planned Arm Char     NA Perm   216
#> 217   ACTARM                 Description of Actual Arm Char     NA Perm   217
#> 218   TRTxxP           Planned Treatment for Period xx Char     NA Perm   218
#> 219  TRTxxPN       Planned Treatment for Period xx (N)  Num     NA Perm   219
#> 220   TRTxxA            Actual Treatment for Period xx Char     NA Perm   220
#> 221  TRTxxAN        Actual Treatment for Period xx (N)  Num     NA Perm   221
#> 222  TRTSEQP            Planned Sequence of Treatments Char     NA Perm   222
#> 223 TRTSEQPN        Planned Sequence of Treatments (N)  Num     NA Perm   223
#> 224  TRTSEQA             Actual Sequence of Treatments Char     NA Perm   224
#> 225 TRTSEQAN         Actual Sequence of Treatments (N)  Num     NA Perm   225
#> 226  TRxxPGy  Planned Pooled Treatment y for Period xx Char     NA Perm   226
#> 227 TRxxPGyN    Planned Pooled Trt y for Period xx (N)  Num     NA Perm   227
#> 228  TRxxAGy   Actual Pooled Treatment y for Period xx Char     NA Perm   228
#> 229 TRxxAGyN     Actual Pooled Trt y for Period xx (N)  Num     NA Perm   229
#> 230  TSEQPGy       Planned Pooled Treatment Sequence y Char     NA Perm   230
#> 231 TSEQPGyN   Planned Pooled Treatment Sequence y (N)  Num     NA Perm   231
#> 232  TSEQAGy        Actual Pooled Treatment Sequence y Char     NA Perm   232
#> 233 TSEQAGyN    Actual Pooled Treatment Sequence y (N)  Num     NA Perm   233
#> 234  DOSExxP      Planned Treatment Dose for Period xx  Num     NA Perm   234
#> 235  DOSExxA       Actual Treatment Dose for Period xx  Num     NA Perm   235
#> 236  DOSExxU              Units for Dose for Period xx Char     NA Perm   236
#> 237   TRTSDT       Date of First Exposure to Treatment  Num     NA Perm   237
#> 238   TRTSTM       Time of First Exposure to Treatment  Num     NA Perm   238
#> 239  TRTSDTM   Datetime of First Exposure to Treatment  Num     NA Perm   239
#> 240  TRTSDTF        Date of First Exposure Imput. Flag Char     NA Perm   240
#> 241  TRTSTMF        Time of First Exposure Imput. Flag Char     NA Perm   241
#> 242   TRTEDT        Date of Last Exposure to Treatment  Num     NA Perm   242
#> 243   TRTETM        Time of Last Exposure to Treatment  Num     NA Perm   243
#> 244  TRTEDTM    Datetime of Last Exposure to Treatment  Num     NA Perm   244
#> 245  TRTEDTF         Date of Last Exposure Imput. Flag Char     NA Perm   245
#> 246  TRTETMF         Time of Last Exposure Imput. Flag Char     NA Perm   246
#> 247  TRxxSDT       Date of First Exposure in Period xx  Num     NA Perm   247
#> 248  TRxxSTM       Time of First Exposure in Period xx  Num     NA Perm   248
#> 249 TRxxSDTM   Datetime of First Exposure in Period xx  Num     NA Perm   249
#> 250 TRxxSDTF   Date 1st Exposure Period xx Imput. Flag Char     NA Perm   250
#> 251 TRxxSTMF   Time 1st Exposure Period xx Imput. Flag Char     NA Perm   251
#> 252  TRxxEDT        Date of Last Exposure in Period xx  Num     NA Perm   252
#> 253  TRxxETM        Time of Last Exposure in Period xx  Num     NA Perm   253
#> 254 TRxxEDTM    Datetime of Last Exposure in Period xx  Num     NA Perm   254
#> 255 TRxxEDTF  Date Last Exposure Period xx Imput. Flag Char     NA Perm   255
#> 256 TRxxETMF  Time Last Exposure Period xx Imput. Flag Char     NA Perm   256
#> 257  APxxSDT                      Period xx Start Date  Num     NA Perm   257
#> 258  APxxSTM                      Period xx Start Time  Num     NA Perm   258
#> 259 APxxSDTM                  Period xx Start Datetime  Num     NA Perm   259
#> 260 APxxSDTF          Period xx Start Date Imput. Flag Char     NA Perm   260
#> 261 APxxSTMF          Period xx Start Time Imput. Flag Char     NA Perm   261
#> 262  APxxEDT                        Period xx End Date  Num     NA Perm   262
#> 263  APxxETM                        Period xx End Time  Num     NA Perm   263
#> 264 APxxEDTM                    Period xx End Datetime  Num     NA Perm   264
#> 265 APxxEDTF            Period xx End Date Imput. Flag Char     NA Perm   265
#> 266 APxxETMF            Period xx End Time Imput. Flag Char     NA Perm   266
#> 267    PxxSw      Description of Period xx Subperiod w Char     NA Perm   267
#> 268 PxxSwSDT          Period xx Subperiod w Start Date  Num     NA Perm   268
#> 269 PxxSwSTM          Period xx Subperiod w Start Time  Num     NA Perm   269
#> 270 PxxSwSDM      Period xx Subperiod w Start Datetime  Num     NA Perm   270
#> 271 PxxSwSDF  Period xx Subper w Start Date Imput Flag Char     NA Perm   271
#> 272 PxxSwSTF  Period xx Subper w Start Time Imput Flag Char     NA Perm   272
#> 273 PxxSwEDT            Period xx Subperiod w End Date  Num     NA Perm   273
#> 274 PxxSwETM            Period xx Subperiod w End Time  Num     NA Perm   274
#> 275 PxxSwEDM        Period xx Subperiod w End Datetime  Num     NA Perm   275
#> 276 PxxSwEDF    Period xx Subper w End Date Imput Flag Char     NA Perm   276
#> 277 PxxSwETF    Period xx Subper w End Time Imput Flag Char     NA Perm   277
#> 278  APHASEw                    Description of Phase w Char     NA Perm   278
#> 279   PHwSDT                        Phase w Start Date  Num     NA Perm   279
#> 280   PHwSTM                        Phase w Start Time  Num     NA Perm   280
#> 281  PHwSDTM                    Phase w Start Datetime  Num     NA Perm   281
#> 282  PHwSDTF        Phase w Start Date Imputation Flag Char     NA Perm   282
#> 283  PHwSTMF        Phase w Start Time Imputation Flag Char     NA Perm   283
#> 284   PHwEDT                          Phase w End Date  Num     NA Perm   284
#> 285   PHwETM                          Phase w End Time  Num     NA Perm   285
#> 286  PHwEDTM                      Phase w End Datetime  Num     NA Perm   286
#> 287  PHwEDTF          Phase w End Date Imputation Flag Char     NA Perm   287
#> 288  PHwETMF          Phase w End Time Imputation Flag Char     NA Perm   288
#> 289   EOSSTT                       End of Study Status Char     NA Perm   289
#> 290    EOSDT                         End of Study Date  Num     NA Perm   290
#> 291  DCSREAS     Reason for Discontinuation from Study Char     NA Perm   291
#> 292 DCSREASP        Reason Spec for Discont from Study Char     NA Perm   292
#> 293   EOTSTT                   End of Treatment Status Char     NA Perm   293
#> 294  DCTREAS   Reason for Discontinuation of Treatment Char     NA Perm   294
#> 295 DCTREASP   Reason Specify for Discont of Treatment Char     NA Perm   295
#> 296 EOTxxSTT      End of Treatment Status in Period xx Char     NA Perm   296
#> 297  DCTxxRS  Reason for Discont of Treat in Period xx Char     NA Perm   297
#> 298 DCTxxRSP  Reason Spec for Disc of Trt in Period xx Char     NA Perm   298
#> 299 EOPxxSTT                   End of Period xx Status Char     NA Perm   299
#> 300  DCPxxRS         Reason for Discont from Period xx Char     NA Perm   300
#> 301 DCPxxRSP    Reason Spec for Discont from Period xx Char     NA Perm   301
#> 302   RFICDT                  Date of Informed Consent  Num     NA Perm   302
#> 303   ENRLDT                        Date of Enrollment  Num     NA Perm   303
#> 304   RANDDT                     Date of Randomization  Num     NA Perm   304
#> 305  RFICyDT                Date of Informed Consent y  Num     NA Perm   305
#> 306  ENRLyDT                      Date of Enrollment y  Num     NA Perm   306
#> 307  RANDyDT                   Date of Randomization y  Num     NA Perm   307
#> 308 LSTALVDT                     Date Last Known Alive  Num     NA Perm   308
#> 309    TRCMP                  Treatment Compliance (%)  Num     NA Perm   309
#> 310  TRCMPGy          Treatment Compliance (%) Group y Char     NA Perm   310
#> 311 TRCMPGyN      Treatment Compliance (%) Group y (N)  Num     NA Perm   311
#> 312 TRxxDURD    Treatment Duration in Period xx (Days)  Num     NA Perm   312
#> 313 TRxxDURM  Treatment Duration in Period xx (Months)  Num     NA Perm   313
#> 314 TRxxDURY   Treatment Duration in Period xx (Years)  Num     NA Perm   314
#> 315  TRTDURD           Total Treatment Duration (Days)  Num     NA Perm   315
#> 316  TRTDURM         Total Treatment Duration (Months)  Num     NA Perm   316
#> 317  TRTDURY          Total Treatment Duration (Years)  Num     NA Perm   317
#> 318    DTHDT                             Date of Death  Num     NA Perm   318
#> 319   DTHDTF             Date of Death Imputation Flag Char     NA Perm   319
#> 320  DTHCAUS                            Cause of Death Char     NA Perm   320
#> 321 DTHCAUSN                        Cause of Death (N)  Num     NA Perm   321
#> 322  DTHCGRy                    Cause of Death Group y Char     NA Perm   322
#> 323 DTHCGRyN                Cause of Death Group y (N)  Num     NA Perm   323
#> 324  STRATAR             Strata Used for Randomization Char     NA Perm   324
#> 325 STRATARN         Strata Used for Randomization (N)  Num     NA Perm   325
#> 326  STRATwD    Description of Stratification Factor w Char     NA Perm   326
#> 327  STRATwR        Strat Factor w Value Used for Rand Char     NA Perm   327
#> 328 STRATwRN    Strat Factor w Value Used for Rand (N)  Num     NA Perm   328
#> 329  STRATAV           Strata from Verification Source Char     NA Perm   329
#> 330 STRATAVN       Strata from Verification Source (N)  Num     NA Perm   330
#> 331  STRATwV    Strat Factor w Value from Verif Source Char     NA Perm   331
#> 332 STRATwVN    Strat Fact w Val from Verif Source (N)  Num     NA Perm   332
#> 333   NCAXFL                     PK NCA Exclusion Flag Char     NA Perm   333
#> 334   NCAXFN                 PK NCA Exclusion Flag (N)  Num     NA Perm   334
#> 335  NCAwXRS             Reason w for PK NCA Exclusion Char     NA Perm   335
#> 336 NCAwXRSN      Reason for PK NCA Exclusion of w (N)  Num     NA Perm   336
#> 337  PKSUMXF                 PK Summary Exclusion Flag Char     NA Perm   337
#> 338 PKSUMXFN             PK Summary Exclusion Flag (N)  Num     NA Perm   338
#> 339  METABFL                           Metabolite Flag Char     NA Cond   339
#> 340   COHORT                            Subject Cohort Char     NA Perm   340
#> 341  COHORTN                        Subject Cohort (N)  Num     NA Perm   341
#> 342    ROUTE                                     Route Char     NA Perm   342
#> 343  TRTRINT                Planned Treatment Interval  Num     NA Perm   343
#> 344 TRTRINTU          Planned Treatment Interval Units Char     NA Perm   344
#> 345 DOSPCTDF     Percent Diff. Nominal vs. Actual Dose  Num     NA Cond   345
#> 346  DOSEFRQ                            Dose Frequency Char     NA Cond   346
#> 347   ACYCLE                            Analysis Cycle  Num     NA Perm   347
#> 348  ACYCLEC                        Analysis Cycle (C) Char     NA Perm   348
#> 349   FANLDT            First Date of Dose for Analyte  Num     NA Perm   349
#> 350   FANLTM            First Time of Dose for Analyte  Num     NA Perm   350
#> 351  FANLDTM        First Datetime of Dose for Analyte  Num     NA Perm   351
#> 352  FANLEDT        First End Date of Dose for Analyte  Num     NA Perm   352
#> 353  FANLETM        First End Time of Dose for Analyte  Num     NA Perm   353
#> 354 FANLEDTM    First End Datetime of Dose for Analyte  Num     NA Perm   354
#> 355  PCRFTDT        Reference Date of Dose for Analyte  Num     NA  Req   355
#> 356  PCRFTTM        Reference Time of Dose for Analyte  Num     NA  Req   356
#> 357 PCRFTDTM    Reference Datetime of Dose for Analyte  Num     NA  Req   357
#> 358  PCRFEDT    Reference End Date of Dose for Analyte  Num     NA Cond   358
#> 359  PCRFETM    Reference End Time of Dose for Analyte  Num     NA Cond   359
#> 360 PCRFEDTM     Ref. End Datetime of Dose for Analyte  Num     NA Cond   360
#> 361    NFRLT    Nom. Rel. Time from Analyte First Dose  Num     NA Perm   361
#> 362    AFRLT    Act. Rel. Time from Analyte First Dose  Num     NA Perm   362
#> 363   NEFRLT        Nom. Rel. End Time from First Dose  Num     NA Perm   363
#> 364   AEFRLT        Act. Rel. End Time from First Dose  Num     NA Perm   364
#> 365    FRLTU            Rel. Time from First Dose Unit Char     NA Perm   365
#> 366    NRRLT          Nominal Rel. Time from Ref. Dose  Num     NA  Req   366
#> 367    ARRLT           Actual Rel. Time from Ref. Dose  Num     NA  Req   367
#> 368    MRRLT         Modified Rel. Time from Ref. Dose  Num     NA Perm   368
#> 369   NERRLT      Nominal Rel. End Time from Ref. Dose  Num     NA Perm   369
#> 370   AERRLT       Actual Rel. End Time from Ref. Dose  Num     NA Perm   370
#> 371   MERRLT     Modified Rel. End Time from Ref. Dose  Num     NA Perm   371
#> 372    RRLTU             Rel. Time from Ref. Dose Unit Char     NA  Req   372
#> 373  TMPCTDF     Percent Diff. Nominal vs. Actual Time  Num     NA Perm   373
#> 374 ADOSEDUR         Actual Duration of Treatment Dose  Num     NA Cond   374
#> 375 NDOSEDUR        Nominal duration of Treatment Dose  Num     NA Cond   375
#> 376 DOSEDURU          Duration of Treatment Dose Units Char     NA Perm   376
#> 377    AVALU                       Analysis Value Unit Char     NA  Req   377
#> 378   PCSPEC                    Specimen Material Type Char     NA Perm   378
#> 379 PCSTRESC    Character Result/Finding in Std Format Char     NA Cond   379
#> 380 PCSTRESU                            Standard Units Char     NA Cond   380
#> 381    ALLOQ      Analysis Lower Limit of Quantitation  Num     NA Cond   381
#> 382   PCLLOQ               Lower Limit of Quantitation  Num     NA Cond   382
#> 383   VOLUME                              Volume Value  Num     NA Cond   383
#> 384  VOLUMEU                         Volume Value Unit Char     NA Cond   384
#> 385 SPWEIGHT                     Specimen Weight Value  Num     NA Cond   385
#> 386 SPWEIGHU                Specimen Weight Value Unit Char     NA Cond   386
#> 387  PCGRPID                                  Group ID Char     NA Perm   387
#> 388    PCSEQ                           Sequence Number  Num     NA Cond   388
#>         source codelist_id
#> 1          BDS        <NA>
#> 2          BDS        <NA>
#> 3          BDS        <NA>
#> 4          BDS        <NA>
#> 5          BDS        <NA>
#> 6          BDS        <NA>
#> 7          BDS        <NA>
#> 8          BDS        <NA>
#> 9          BDS        <NA>
#> 10         BDS        <NA>
#> 11  ADaMIG-NCA        <NA>
#> 12         BDS        <NA>
#> 13  ADaMIG-NCA        <NA>
#> 14         BDS        <NA>
#> 15         BDS        <NA>
#> 16         BDS        <NA>
#> 17         BDS        <NA>
#> 18         BDS      C81223
#> 19         BDS      C81226
#> 20         BDS        <NA>
#> 21         BDS        <NA>
#> 22         BDS        <NA>
#> 23         BDS        <NA>
#> 24         BDS      C81223
#> 25         BDS      C81226
#> 26         BDS        <NA>
#> 27         BDS        <NA>
#> 28         BDS        <NA>
#> 29         BDS        <NA>
#> 30         BDS      C81223
#> 31         BDS      C81226
#> 32  ADaMIG-NCA        <NA>
#> 33         BDS        <NA>
#> 34         BDS        <NA>
#> 35         BDS        <NA>
#> 36         BDS        <NA>
#> 37         BDS        <NA>
#> 38         BDS        <NA>
#> 39         BDS        <NA>
#> 40         BDS        <NA>
#> 41         BDS        <NA>
#> 42         BDS        <NA>
#> 43         BDS        <NA>
#> 44         BDS        <NA>
#> 45         BDS        <NA>
#> 46         BDS        <NA>
#> 47         BDS        <NA>
#> 48         BDS      C81223
#> 49         BDS      C81226
#> 50         BDS        <NA>
#> 51         BDS        <NA>
#> 52         BDS        <NA>
#> 53         BDS      C81223
#> 54         BDS      C81226
#> 55         BDS        <NA>
#> 56         BDS        <NA>
#> 57         BDS        <NA>
#> 58         BDS      C81223
#> 59         BDS      C81226
#> 60         BDS        <NA>
#> 61         BDS        <NA>
#> 62         BDS        <NA>
#> 63         BDS      C81223
#> 64         BDS      C81226
#> 65         BDS        <NA>
#> 66         BDS        <NA>
#> 67         BDS        <NA>
#> 68         BDS      C81223
#> 69         BDS      C81226
#> 70         BDS        <NA>
#> 71         BDS        <NA>
#> 72         BDS        <NA>
#> 73         BDS      C81223
#> 74         BDS      C81226
#> 75         BDS        <NA>
#> 76         BDS        <NA>
#> 77         BDS        <NA>
#> 78         BDS        <NA>
#> 79         BDS      C81223
#> 80         BDS      C81226
#> 81         BDS        <NA>
#> 82         BDS        <NA>
#> 83         BDS        <NA>
#> 84         BDS        <NA>
#> 85         BDS      C81223
#> 86         BDS      C81226
#> 87         BDS        <NA>
#> 88         BDS        <NA>
#> 89         BDS        <NA>
#> 90         BDS        <NA>
#> 91         BDS      C81223
#> 92         BDS      C81226
#> 93         BDS        <NA>
#> 94         BDS        <NA>
#> 95         BDS        <NA>
#> 96         BDS        <NA>
#> 97         BDS        <NA>
#> 98         BDS        <NA>
#> 99         BDS        <NA>
#> 100        BDS        <NA>
#> 101        BDS        <NA>
#> 102        BDS        <NA>
#> 103        BDS        <NA>
#> 104        BDS        <NA>
#> 105        BDS        <NA>
#> 106        BDS        <NA>
#> 107        BDS        <NA>
#> 108        BDS        <NA>
#> 109        BDS        <NA>
#> 110        BDS        <NA>
#> 111        BDS        <NA>
#> 112        BDS        <NA>
#> 113        BDS        <NA>
#> 114        BDS        <NA>
#> 115        BDS        <NA>
#> 116        BDS        <NA>
#> 117        BDS        <NA>
#> 118        BDS        <NA>
#> 119        BDS        <NA>
#> 120        BDS        <NA>
#> 121        BDS        <NA>
#> 122        BDS        <NA>
#> 123        BDS        <NA>
#> 124        BDS        <NA>
#> 125        BDS        <NA>
#> 126        BDS        <NA>
#> 127        BDS        <NA>
#> 128        BDS        <NA>
#> 129        BDS        <NA>
#> 130        BDS      C81224
#> 131        BDS        <NA>
#> 132        BDS        <NA>
#> 133        BDS        <NA>
#> 134        BDS        <NA>
#> 135        BDS        <NA>
#> 136        BDS        <NA>
#> 137        BDS        <NA>
#> 138        BDS        <NA>
#> 139        BDS      C81223
#> 140        BDS      C81226
#> 141        BDS        <NA>
#> 142        BDS        <NA>
#> 143        BDS        <NA>
#> 144        BDS        <NA>
#> 145        BDS        <NA>
#> 146        BDS        <NA>
#> 147        BDS        <NA>
#> 148        BDS        <NA>
#> 149        BDS        <NA>
#> 150        BDS        <NA>
#> 151        BDS        <NA>
#> 152        BDS        <NA>
#> 153        BDS        <NA>
#> 154        BDS        <NA>
#> 155        BDS        <NA>
#> 156        BDS        <NA>
#> 157        BDS        <NA>
#> 158        BDS        <NA>
#> 159        BDS        <NA>
#> 160        BDS        <NA>
#> 161        BDS        <NA>
#> 162        BDS        <NA>
#> 163        BDS        <NA>
#> 164        BDS        <NA>
#> 165        BDS        <NA>
#> 166        BDS        <NA>
#> 167        BDS        <NA>
#> 168        BDS        <NA>
#> 169        BDS        <NA>
#> 170        BDS        <NA>
#> 171        BDS        <NA>
#> 172        BDS        <NA>
#> 173        BDS        <NA>
#> 174        BDS        <NA>
#> 175        BDS        <NA>
#> 176        BDS        <NA>
#> 177        BDS        <NA>
#> 178        BDS        <NA>
#> 179        BDS        <NA>
#> 180        BDS        <NA>
#> 181        BDS        <NA>
#> 182        BDS        <NA>
#> 183        BDS        <NA>
#> 184        BDS        <NA>
#> 185        BDS        <NA>
#> 186        BDS        <NA>
#> 187        BDS        <NA>
#> 188        BDS        <NA>
#> 189        BDS        <NA>
#> 190        BDS        <NA>
#> 191        BDS        <NA>
#> 192        BDS        <NA>
#> 193        BDS        <NA>
#> 194        BDS        <NA>
#> 195        BDS        <NA>
#> 196       ADSL        <NA>
#> 197       ADSL        <NA>
#> 198       ADSL        <NA>
#> 199       ADSL        <NA>
#> 200       ADSL        <NA>
#> 201       ADSL      C66781
#> 202       ADSL        <NA>
#> 203       ADSL        <NA>
#> 204       ADSL        <NA>
#> 205       ADSL      C66731
#> 206       ADSL        <NA>
#> 207       ADSL        <NA>
#> 208       ADSL        <NA>
#> 209       ADSL        <NA>
#> 210       ADSL        <NA>
#> 211       ADSL        <NA>
#> 212       ADSL        <NA>
#> 213       ADSL        <NA>
#> 214       ADSL        <NA>
#> 215       ADSL        <NA>
#> 216       ADSL        <NA>
#> 217       ADSL        <NA>
#> 218       ADSL        <NA>
#> 219       ADSL        <NA>
#> 220       ADSL        <NA>
#> 221       ADSL        <NA>
#> 222       ADSL        <NA>
#> 223       ADSL        <NA>
#> 224       ADSL        <NA>
#> 225       ADSL        <NA>
#> 226       ADSL        <NA>
#> 227       ADSL        <NA>
#> 228       ADSL        <NA>
#> 229       ADSL        <NA>
#> 230       ADSL        <NA>
#> 231       ADSL        <NA>
#> 232       ADSL        <NA>
#> 233       ADSL        <NA>
#> 234       ADSL        <NA>
#> 235       ADSL        <NA>
#> 236       ADSL        <NA>
#> 237       ADSL        <NA>
#> 238       ADSL        <NA>
#> 239       ADSL        <NA>
#> 240       ADSL      C81223
#> 241       ADSL      C81226
#> 242       ADSL        <NA>
#> 243       ADSL        <NA>
#> 244       ADSL        <NA>
#> 245       ADSL      C81223
#> 246       ADSL      C81226
#> 247       ADSL        <NA>
#> 248       ADSL        <NA>
#> 249       ADSL        <NA>
#> 250       ADSL      C81223
#> 251       ADSL      C81226
#> 252       ADSL        <NA>
#> 253       ADSL        <NA>
#> 254       ADSL        <NA>
#> 255       ADSL      C81223
#> 256       ADSL      C81226
#> 257       ADSL        <NA>
#> 258       ADSL        <NA>
#> 259       ADSL        <NA>
#> 260       ADSL      C81223
#> 261       ADSL      C81226
#> 262       ADSL        <NA>
#> 263       ADSL        <NA>
#> 264       ADSL        <NA>
#> 265       ADSL      C81223
#> 266       ADSL      C81226
#> 267       ADSL        <NA>
#> 268       ADSL        <NA>
#> 269       ADSL        <NA>
#> 270       ADSL        <NA>
#> 271       ADSL      C81223
#> 272       ADSL      C81226
#> 273       ADSL        <NA>
#> 274       ADSL        <NA>
#> 275       ADSL        <NA>
#> 276       ADSL      C81223
#> 277       ADSL      C81226
#> 278       ADSL        <NA>
#> 279       ADSL        <NA>
#> 280       ADSL        <NA>
#> 281       ADSL        <NA>
#> 282       ADSL      C81223
#> 283       ADSL      C81226
#> 284       ADSL        <NA>
#> 285       ADSL        <NA>
#> 286       ADSL        <NA>
#> 287       ADSL      C81223
#> 288       ADSL      C81226
#> 289       ADSL     C124296
#> 290       ADSL        <NA>
#> 291       ADSL        <NA>
#> 292       ADSL        <NA>
#> 293       ADSL     C124296
#> 294       ADSL        <NA>
#> 295       ADSL        <NA>
#> 296       ADSL     C124296
#> 297       ADSL        <NA>
#> 298       ADSL        <NA>
#> 299       ADSL     C124296
#> 300       ADSL        <NA>
#> 301       ADSL        <NA>
#> 302       ADSL        <NA>
#> 303       ADSL        <NA>
#> 304       ADSL        <NA>
#> 305       ADSL        <NA>
#> 306       ADSL        <NA>
#> 307       ADSL        <NA>
#> 308       ADSL        <NA>
#> 309       ADSL        <NA>
#> 310       ADSL        <NA>
#> 311       ADSL        <NA>
#> 312       ADSL        <NA>
#> 313       ADSL        <NA>
#> 314       ADSL        <NA>
#> 315       ADSL        <NA>
#> 316       ADSL        <NA>
#> 317       ADSL        <NA>
#> 318       ADSL        <NA>
#> 319       ADSL      C81223
#> 320       ADSL        <NA>
#> 321       ADSL        <NA>
#> 322       ADSL        <NA>
#> 323       ADSL        <NA>
#> 324       ADSL        <NA>
#> 325       ADSL        <NA>
#> 326       ADSL        <NA>
#> 327       ADSL        <NA>
#> 328       ADSL        <NA>
#> 329       ADSL        <NA>
#> 330       ADSL        <NA>
#> 331       ADSL        <NA>
#> 332       ADSL        <NA>
#> 333 ADaMIG-NCA        <NA>
#> 334 ADaMIG-NCA        <NA>
#> 335 ADaMIG-NCA        <NA>
#> 336 ADaMIG-NCA        <NA>
#> 337 ADaMIG-NCA        <NA>
#> 338 ADaMIG-NCA        <NA>
#> 339 ADaMIG-NCA        <NA>
#> 340 ADaMIG-NCA        <NA>
#> 341 ADaMIG-NCA        <NA>
#> 342 ADaMIG-NCA      C66729
#> 343 ADaMIG-NCA        <NA>
#> 344 ADaMIG-NCA      C71620
#> 345 ADaMIG-NCA        <NA>
#> 346 ADaMIG-NCA      C71113
#> 347 ADaMIG-NCA        <NA>
#> 348 ADaMIG-NCA        <NA>
#> 349 ADaMIG-NCA        <NA>
#> 350 ADaMIG-NCA        <NA>
#> 351 ADaMIG-NCA        <NA>
#> 352 ADaMIG-NCA        <NA>
#> 353 ADaMIG-NCA        <NA>
#> 354 ADaMIG-NCA        <NA>
#> 355 ADaMIG-NCA        <NA>
#> 356 ADaMIG-NCA        <NA>
#> 357 ADaMIG-NCA        <NA>
#> 358 ADaMIG-NCA        <NA>
#> 359 ADaMIG-NCA        <NA>
#> 360 ADaMIG-NCA        <NA>
#> 361 ADaMIG-NCA        <NA>
#> 362 ADaMIG-NCA        <NA>
#> 363 ADaMIG-NCA        <NA>
#> 364 ADaMIG-NCA        <NA>
#> 365 ADaMIG-NCA      C85494
#> 366 ADaMIG-NCA        <NA>
#> 367 ADaMIG-NCA        <NA>
#> 368 ADaMIG-NCA        <NA>
#> 369 ADaMIG-NCA        <NA>
#> 370 ADaMIG-NCA        <NA>
#> 371 ADaMIG-NCA        <NA>
#> 372 ADaMIG-NCA      C85494
#> 373 ADaMIG-NCA        <NA>
#> 374 ADaMIG-NCA        <NA>
#> 375 ADaMIG-NCA        <NA>
#> 376 ADaMIG-NCA      C85494
#> 377 ADaMIG-NCA        <NA>
#> 378 ADaMIG-NCA      C78734
#> 379 ADaMIG-NCA        <NA>
#> 380 ADaMIG-NCA      C71620
#> 381 ADaMIG-NCA        <NA>
#> 382 ADaMIG-NCA        <NA>
#> 383 ADaMIG-NCA        <NA>
#> 384 ADaMIG-NCA      C71620
#> 385 ADaMIG-NCA        <NA>
#> 386 ADaMIG-NCA      C71620
#> 387 ADaMIG-NCA        <NA>
#> 388 ADaMIG-NCA        <NA>
```
