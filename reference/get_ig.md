# Retrieve CDISC implementation-guide or model variable metadata

One accessor over every standard in
[`ig_sdtm`](https://humanpred.github.io/cdiscdata/reference/ig_sdtm.md),
[`model_sdtm`](https://humanpred.github.io/cdiscdata/reference/model_sdtm.md),
and
[`ig_adam`](https://humanpred.github.io/cdiscdata/reference/ig_adam.md),
mirroring
[`get_ct`](https://humanpred.github.io/cdiscdata/reference/get_ct.md).
The standard is chosen with `standard`; the version defaults to that
standard's newest.

## Usage

``` r
get_ig(standard = "SDTMIG", version = NULL, domain = NULL)
```

## Arguments

- standard:

  One standard from the list above (default `"SDTMIG"`), or the alias
  `"sdtm"` or `"adam"`.

- version:

  A version string of that standard (e.g. `"3.4"`). `NULL` (the default)
  uses the newest, compared numerically, so `"3.1.3"` ranks below
  `"3.2"`.

- domain:

  Restrict to one domain or structure. For the implementation-guide
  standards in
  [`ig_sdtm`](https://humanpred.github.io/cdiscdata/reference/ig_sdtm.md),
  the `domain` column (e.g. `"PP"`); for `"SDTM"`, a `class` (e.g.
  `"Findings"`) or a `dataset` (e.g. `"DM"`); for the ADaM standards,
  the `structure` column, where `"BDS"` and `"ADSL"` are accepted as
  aliases for `"Basic Data Structure"` and
  `"Subject-Level Analysis Dataset"`. `NULL` (the default) applies no
  filter.

## Value

A data frame: the rows of
[`ig_sdtm`](https://humanpred.github.io/cdiscdata/reference/ig_sdtm.md),
[`model_sdtm`](https://humanpred.github.io/cdiscdata/reference/model_sdtm.md),
or
[`ig_adam`](https://humanpred.github.io/cdiscdata/reference/ig_adam.md)
for that standard, version, and domain. An unknown standard, version, or
domain is a classed error (`cdiscdata_error_ig_standard_unavailable`,
`cdiscdata_error_ig_version_unavailable`,
`cdiscdata_error_ig_domain_unavailable`).

## Details

The standards, and the dataset each is stored in:

- `"SDTM"` (model versions 1.2 to 2.1):
  [`model_sdtm`](https://humanpred.github.io/cdiscdata/reference/model_sdtm.md).

- `"SDTMIG"` (3.1.2 to 3.4), `"SDTMIG-AP"`, `"SDTMIG-MD"`, `"SENDIG"`
  (3.0 to 3.1.1), `"SENDIG-AR"`, `"SENDIG-DART"`, `"SENDIG-GeneTox"`:
  [`ig_sdtm`](https://humanpred.github.io/cdiscdata/reference/ig_sdtm.md).

- `"ADaMIG"` (1.0 to 1.3), `"ADaMIG-MD"`, `"ADaMIG-NCA"`, `"ADaM-ADAE"`,
  `"ADaM-BDS-TTE"`, `"ADaM-OCCDS"`, `"ADaM-popPK"`:
  [`ig_adam`](https://humanpred.github.io/cdiscdata/reference/ig_adam.md).

The lower-case names `"sdtm"` and `"adam"`, the only values the first
argument took before it named a standard, are kept as aliases for the
defaults `"SDTMIG"` and `"ADaMIG"` (note `"SDTM"` in capitals is the
model, not the implementation guide).

All of this comes from CDISC Library CSV exports that are not part of
this package or repository (see
[`ig_sources`](https://humanpred.github.io/cdiscdata/reference/ig_sources.md)
for exactly which files, and `data-raw/README.md`). Only variable
metadata is carried; the guides' prose (CDISC Notes, Description,
Definition, Examples) is not.

## Examples

``` r
get_ig()                                          # newest SDTMIG (3.4)
#>      standard version           class   domain order variable
#> 4398   SDTMIG     3.4   Interventions       AG     1  STUDYID
#> 4399   SDTMIG     3.4   Interventions       AG     2   DOMAIN
#> 4400   SDTMIG     3.4   Interventions       AG     3  USUBJID
#> 4401   SDTMIG     3.4   Interventions       AG     4    AGSEQ
#> 4402   SDTMIG     3.4   Interventions       AG     5  AGGRPID
#> 4403   SDTMIG     3.4   Interventions       AG     6   AGSPID
#> 4404   SDTMIG     3.4   Interventions       AG     7  AGLNKID
#> 4405   SDTMIG     3.4   Interventions       AG     8 AGLNKGRP
#> 4406   SDTMIG     3.4   Interventions       AG     9    AGTRT
#> 4407   SDTMIG     3.4   Interventions       AG    10 AGMODIFY
#> 4408   SDTMIG     3.4   Interventions       AG    11  AGDECOD
#> 4409   SDTMIG     3.4   Interventions       AG    12    AGCAT
#> 4410   SDTMIG     3.4   Interventions       AG    13   AGSCAT
#> 4411   SDTMIG     3.4   Interventions       AG    14  AGPRESP
#> 4412   SDTMIG     3.4   Interventions       AG    15  AGOCCUR
#> 4413   SDTMIG     3.4   Interventions       AG    16   AGSTAT
#> 4414   SDTMIG     3.4   Interventions       AG    17 AGREASND
#> 4415   SDTMIG     3.4   Interventions       AG    18   AGCLAS
#> 4416   SDTMIG     3.4   Interventions       AG    19 AGCLASCD
#> 4417   SDTMIG     3.4   Interventions       AG    20   AGDOSE
#> 4418   SDTMIG     3.4   Interventions       AG    21 AGDOSTXT
#> 4419   SDTMIG     3.4   Interventions       AG    22   AGDOSU
#> 4420   SDTMIG     3.4   Interventions       AG    23 AGDOSFRM
#> 4421   SDTMIG     3.4   Interventions       AG    24 AGDOSFRQ
#> 4422   SDTMIG     3.4   Interventions       AG    25  AGROUTE
#> 4423   SDTMIG     3.4   Interventions       AG    26 VISITNUM
#> 4424   SDTMIG     3.4   Interventions       AG    27    VISIT
#> 4425   SDTMIG     3.4   Interventions       AG    28  VISITDY
#> 4426   SDTMIG     3.4   Interventions       AG    29  TAETORD
#> 4427   SDTMIG     3.4   Interventions       AG    30    EPOCH
#> 4428   SDTMIG     3.4   Interventions       AG    31  AGSTDTC
#> 4429   SDTMIG     3.4   Interventions       AG    32  AGENDTC
#> 4430   SDTMIG     3.4   Interventions       AG    33   AGSTDY
#> 4431   SDTMIG     3.4   Interventions       AG    34   AGENDY
#> 4432   SDTMIG     3.4   Interventions       AG    35    AGDUR
#> 4433   SDTMIG     3.4   Interventions       AG    36   AGSTRF
#> 4434   SDTMIG     3.4   Interventions       AG    37   AGENRF
#> 4435   SDTMIG     3.4   Interventions       AG    38 AGSTRTPT
#> 4436   SDTMIG     3.4   Interventions       AG    39  AGSTTPT
#> 4437   SDTMIG     3.4   Interventions       AG    40 AGENRTPT
#> 4438   SDTMIG     3.4   Interventions       AG    41  AGENTPT
#> 4439   SDTMIG     3.4   Interventions       CM     1  STUDYID
#> 4440   SDTMIG     3.4   Interventions       CM     2   DOMAIN
#> 4441   SDTMIG     3.4   Interventions       CM     3  USUBJID
#> 4442   SDTMIG     3.4   Interventions       CM     4    CMSEQ
#> 4443   SDTMIG     3.4   Interventions       CM     5  CMGRPID
#> 4444   SDTMIG     3.4   Interventions       CM     6   CMSPID
#> 4445   SDTMIG     3.4   Interventions       CM     7    CMTRT
#> 4446   SDTMIG     3.4   Interventions       CM     8 CMMODIFY
#> 4447   SDTMIG     3.4   Interventions       CM     9  CMDECOD
#> 4448   SDTMIG     3.4   Interventions       CM    10    CMCAT
#> 4449   SDTMIG     3.4   Interventions       CM    11   CMSCAT
#> 4450   SDTMIG     3.4   Interventions       CM    12  CMPRESP
#> 4451   SDTMIG     3.4   Interventions       CM    13  CMOCCUR
#> 4452   SDTMIG     3.4   Interventions       CM    14   CMSTAT
#> 4453   SDTMIG     3.4   Interventions       CM    15 CMREASND
#> 4454   SDTMIG     3.4   Interventions       CM    16   CMINDC
#> 4455   SDTMIG     3.4   Interventions       CM    17   CMCLAS
#> 4456   SDTMIG     3.4   Interventions       CM    18 CMCLASCD
#> 4457   SDTMIG     3.4   Interventions       CM    19   CMDOSE
#> 4458   SDTMIG     3.4   Interventions       CM    20 CMDOSTXT
#> 4459   SDTMIG     3.4   Interventions       CM    21   CMDOSU
#> 4460   SDTMIG     3.4   Interventions       CM    22 CMDOSFRM
#> 4461   SDTMIG     3.4   Interventions       CM    23 CMDOSFRQ
#> 4462   SDTMIG     3.4   Interventions       CM    24 CMDOSTOT
#> 4463   SDTMIG     3.4   Interventions       CM    25 CMDOSRGM
#> 4464   SDTMIG     3.4   Interventions       CM    26  CMROUTE
#> 4465   SDTMIG     3.4   Interventions       CM    27    CMADJ
#> 4466   SDTMIG     3.4   Interventions       CM    28 CMRSDISC
#> 4467   SDTMIG     3.4   Interventions       CM    29  TAETORD
#> 4468   SDTMIG     3.4   Interventions       CM    30    EPOCH
#> 4469   SDTMIG     3.4   Interventions       CM    31  CMSTDTC
#> 4470   SDTMIG     3.4   Interventions       CM    32  CMENDTC
#> 4471   SDTMIG     3.4   Interventions       CM    33   CMSTDY
#> 4472   SDTMIG     3.4   Interventions       CM    34   CMENDY
#> 4473   SDTMIG     3.4   Interventions       CM    35    CMDUR
#> 4474   SDTMIG     3.4   Interventions       CM    36   CMSTRF
#> 4475   SDTMIG     3.4   Interventions       CM    37   CMENRF
#> 4476   SDTMIG     3.4   Interventions       CM    38 CMSTRTPT
#> 4477   SDTMIG     3.4   Interventions       CM    39  CMSTTPT
#> 4478   SDTMIG     3.4   Interventions       CM    40 CMENRTPT
#> 4479   SDTMIG     3.4   Interventions       CM    41  CMENTPT
#> 4480   SDTMIG     3.4   Interventions       EC     1  STUDYID
#> 4481   SDTMIG     3.4   Interventions       EC     2   DOMAIN
#> 4482   SDTMIG     3.4   Interventions       EC     3  USUBJID
#> 4483   SDTMIG     3.4   Interventions       EC     4    ECSEQ
#> 4484   SDTMIG     3.4   Interventions       EC     5  ECGRPID
#> 4485   SDTMIG     3.4   Interventions       EC     6  ECREFID
#> 4486   SDTMIG     3.4   Interventions       EC     7   ECSPID
#> 4487   SDTMIG     3.4   Interventions       EC     8  ECLNKID
#> 4488   SDTMIG     3.4   Interventions       EC     9 ECLNKGRP
#> 4489   SDTMIG     3.4   Interventions       EC    10    ECTRT
#> 4490   SDTMIG     3.4   Interventions       EC    11   ECMOOD
#> 4491   SDTMIG     3.4   Interventions       EC    12    ECCAT
#> 4492   SDTMIG     3.4   Interventions       EC    13   ECSCAT
#> 4493   SDTMIG     3.4   Interventions       EC    14  ECPRESP
#> 4494   SDTMIG     3.4   Interventions       EC    15  ECOCCUR
#> 4495   SDTMIG     3.4   Interventions       EC    16 ECREASOC
#> 4496   SDTMIG     3.4   Interventions       EC    17   ECDOSE
#> 4497   SDTMIG     3.4   Interventions       EC    18 ECDOSTXT
#> 4498   SDTMIG     3.4   Interventions       EC    19   ECDOSU
#> 4499   SDTMIG     3.4   Interventions       EC    20 ECDOSFRM
#> 4500   SDTMIG     3.4   Interventions       EC    21 ECDOSFRQ
#> 4501   SDTMIG     3.4   Interventions       EC    22 ECDOSTOT
#> 4502   SDTMIG     3.4   Interventions       EC    23 ECDOSRGM
#> 4503   SDTMIG     3.4   Interventions       EC    24  ECROUTE
#> 4504   SDTMIG     3.4   Interventions       EC    25    ECLOT
#> 4505   SDTMIG     3.4   Interventions       EC    26    ECLOC
#> 4506   SDTMIG     3.4   Interventions       EC    27    ECLAT
#> 4507   SDTMIG     3.4   Interventions       EC    28    ECDIR
#> 4508   SDTMIG     3.4   Interventions       EC    29 ECPORTOT
#> 4509   SDTMIG     3.4   Interventions       EC    30   ECFAST
#> 4510   SDTMIG     3.4   Interventions       EC    31  ECPSTRG
#> 4511   SDTMIG     3.4   Interventions       EC    32 ECPSTRGU
#> 4512   SDTMIG     3.4   Interventions       EC    33    ECADJ
#> 4513   SDTMIG     3.4   Interventions       EC    34  TAETORD
#> 4514   SDTMIG     3.4   Interventions       EC    35    EPOCH
#> 4515   SDTMIG     3.4   Interventions       EC    36  ECSTDTC
#> 4516   SDTMIG     3.4   Interventions       EC    37  ECENDTC
#> 4517   SDTMIG     3.4   Interventions       EC    38   ECSTDY
#> 4518   SDTMIG     3.4   Interventions       EC    39   ECENDY
#> 4519   SDTMIG     3.4   Interventions       EC    40    ECDUR
#> 4520   SDTMIG     3.4   Interventions       EC    41    ECTPT
#> 4521   SDTMIG     3.4   Interventions       EC    42 ECTPTNUM
#> 4522   SDTMIG     3.4   Interventions       EC    43   ECELTM
#> 4523   SDTMIG     3.4   Interventions       EC    44 ECTPTREF
#> 4524   SDTMIG     3.4   Interventions       EC    45 ECRFTDTC
#> 4525   SDTMIG     3.4   Interventions       EX     1  STUDYID
#> 4526   SDTMIG     3.4   Interventions       EX     2   DOMAIN
#> 4527   SDTMIG     3.4   Interventions       EX     3  USUBJID
#> 4528   SDTMIG     3.4   Interventions       EX     4    EXSEQ
#> 4529   SDTMIG     3.4   Interventions       EX     5  EXGRPID
#> 4530   SDTMIG     3.4   Interventions       EX     6  EXREFID
#> 4531   SDTMIG     3.4   Interventions       EX     7   EXSPID
#> 4532   SDTMIG     3.4   Interventions       EX     8  EXLNKID
#> 4533   SDTMIG     3.4   Interventions       EX     9 EXLNKGRP
#> 4534   SDTMIG     3.4   Interventions       EX    10    EXTRT
#> 4535   SDTMIG     3.4   Interventions       EX    11    EXCAT
#> 4536   SDTMIG     3.4   Interventions       EX    12   EXSCAT
#> 4537   SDTMIG     3.4   Interventions       EX    13   EXDOSE
#> 4538   SDTMIG     3.4   Interventions       EX    14 EXDOSTXT
#> 4539   SDTMIG     3.4   Interventions       EX    15   EXDOSU
#> 4540   SDTMIG     3.4   Interventions       EX    16 EXDOSFRM
#> 4541   SDTMIG     3.4   Interventions       EX    17 EXDOSFRQ
#> 4542   SDTMIG     3.4   Interventions       EX    18 EXDOSRGM
#> 4543   SDTMIG     3.4   Interventions       EX    19  EXROUTE
#> 4544   SDTMIG     3.4   Interventions       EX    20    EXLOT
#> 4545   SDTMIG     3.4   Interventions       EX    21    EXLOC
#> 4546   SDTMIG     3.4   Interventions       EX    22    EXLAT
#> 4547   SDTMIG     3.4   Interventions       EX    23    EXDIR
#> 4548   SDTMIG     3.4   Interventions       EX    24   EXFAST
#> 4549   SDTMIG     3.4   Interventions       EX    25    EXADJ
#> 4550   SDTMIG     3.4   Interventions       EX    26  TAETORD
#> 4551   SDTMIG     3.4   Interventions       EX    27    EPOCH
#> 4552   SDTMIG     3.4   Interventions       EX    28  EXSTDTC
#> 4553   SDTMIG     3.4   Interventions       EX    29  EXENDTC
#> 4554   SDTMIG     3.4   Interventions       EX    30   EXSTDY
#> 4555   SDTMIG     3.4   Interventions       EX    31   EXENDY
#> 4556   SDTMIG     3.4   Interventions       EX    32    EXDUR
#> 4557   SDTMIG     3.4   Interventions       EX    33    EXTPT
#> 4558   SDTMIG     3.4   Interventions       EX    34 EXTPTNUM
#> 4559   SDTMIG     3.4   Interventions       EX    35   EXELTM
#> 4560   SDTMIG     3.4   Interventions       EX    36 EXTPTREF
#> 4561   SDTMIG     3.4   Interventions       EX    37 EXRFTDTC
#> 4562   SDTMIG     3.4   Interventions       ML     1  STUDYID
#> 4563   SDTMIG     3.4   Interventions       ML     2   DOMAIN
#> 4564   SDTMIG     3.4   Interventions       ML     3  USUBJID
#> 4565   SDTMIG     3.4   Interventions       ML     4    MLSEQ
#> 4566   SDTMIG     3.4   Interventions       ML     5  MLGRPID
#> 4567   SDTMIG     3.4   Interventions       ML     6   MLSPID
#> 4568   SDTMIG     3.4   Interventions       ML     7    MLTRT
#> 4569   SDTMIG     3.4   Interventions       ML     8    MLCAT
#> 4570   SDTMIG     3.4   Interventions       ML     9   MLSCAT
#> 4571   SDTMIG     3.4   Interventions       ML    10  MLPRESP
#> 4572   SDTMIG     3.4   Interventions       ML    11  MLOCCUR
#> 4573   SDTMIG     3.4   Interventions       ML    12   MLSTAT
#> 4574   SDTMIG     3.4   Interventions       ML    13 MLREASND
#> 4575   SDTMIG     3.4   Interventions       ML    14   MLDOSE
#> 4576   SDTMIG     3.4   Interventions       ML    15 MLDOSTXT
#> 4577   SDTMIG     3.4   Interventions       ML    16   MLDOSU
#> 4578   SDTMIG     3.4   Interventions       ML    17 MLDOSFRM
#> 4579   SDTMIG     3.4   Interventions       ML    18 VISITNUM
#> 4580   SDTMIG     3.4   Interventions       ML    19    VISIT
#> 4581   SDTMIG     3.4   Interventions       ML    20  VISITDY
#> 4582   SDTMIG     3.4   Interventions       ML    21  TAETORD
#> 4583   SDTMIG     3.4   Interventions       ML    22    EPOCH
#> 4584   SDTMIG     3.4   Interventions       ML    23    MLDTC
#> 4585   SDTMIG     3.4   Interventions       ML    24  MLSTDTC
#> 4586   SDTMIG     3.4   Interventions       ML    25  MLENDTC
#> 4587   SDTMIG     3.4   Interventions       ML    26     MLDY
#> 4588   SDTMIG     3.4   Interventions       ML    27   MLSTDY
#> 4589   SDTMIG     3.4   Interventions       ML    28   MLENDY
#> 4590   SDTMIG     3.4   Interventions       ML    29    MLDUR
#> 4591   SDTMIG     3.4   Interventions       ML    30    MLTPT
#> 4592   SDTMIG     3.4   Interventions       ML    31 MLTPTNUM
#> 4593   SDTMIG     3.4   Interventions       ML    32   MLELTM
#> 4594   SDTMIG     3.4   Interventions       ML    33 MLTPTREF
#> 4595   SDTMIG     3.4   Interventions       ML    34 MLRFTDTC
#> 4596   SDTMIG     3.4   Interventions       ML    35     MIDS
#> 4597   SDTMIG     3.4   Interventions       ML    36  RELMIDS
#> 4598   SDTMIG     3.4   Interventions       ML    37  MIDSDTC
#> 4599   SDTMIG     3.4   Interventions       PR     1  STUDYID
#> 4600   SDTMIG     3.4   Interventions       PR     2   DOMAIN
#> 4601   SDTMIG     3.4   Interventions       PR     3  USUBJID
#> 4602   SDTMIG     3.4   Interventions       PR     4    PRSEQ
#> 4603   SDTMIG     3.4   Interventions       PR     5  PRGRPID
#> 4604   SDTMIG     3.4   Interventions       PR     6   PRSPID
#> 4605   SDTMIG     3.4   Interventions       PR     7  PRLNKID
#> 4606   SDTMIG     3.4   Interventions       PR     8 PRLNKGRP
#> 4607   SDTMIG     3.4   Interventions       PR     9    PRTRT
#> 4608   SDTMIG     3.4   Interventions       PR    10  PRDECOD
#> 4609   SDTMIG     3.4   Interventions       PR    11    PRCAT
#> 4610   SDTMIG     3.4   Interventions       PR    12   PRSCAT
#> 4611   SDTMIG     3.4   Interventions       PR    13  PRPRESP
#> 4612   SDTMIG     3.4   Interventions       PR    14  PROCCUR
#> 4613   SDTMIG     3.4   Interventions       PR    15   PRINDC
#> 4614   SDTMIG     3.4   Interventions       PR    16   PRDOSE
#> 4615   SDTMIG     3.4   Interventions       PR    17 PRDOSTXT
#> 4616   SDTMIG     3.4   Interventions       PR    18   PRDOSU
#> 4617   SDTMIG     3.4   Interventions       PR    19 PRDOSFRM
#> 4618   SDTMIG     3.4   Interventions       PR    20 PRDOSFRQ
#> 4619   SDTMIG     3.4   Interventions       PR    21 PRDOSRGM
#> 4620   SDTMIG     3.4   Interventions       PR    22  PRROUTE
#> 4621   SDTMIG     3.4   Interventions       PR    23    PRLOC
#> 4622   SDTMIG     3.4   Interventions       PR    24    PRLAT
#> 4623   SDTMIG     3.4   Interventions       PR    25    PRDIR
#> 4624   SDTMIG     3.4   Interventions       PR    26 PRPORTOT
#> 4625   SDTMIG     3.4   Interventions       PR    27 VISITNUM
#> 4626   SDTMIG     3.4   Interventions       PR    28    VISIT
#> 4627   SDTMIG     3.4   Interventions       PR    29  VISITDY
#> 4628   SDTMIG     3.4   Interventions       PR    30  TAETORD
#> 4629   SDTMIG     3.4   Interventions       PR    31    EPOCH
#> 4630   SDTMIG     3.4   Interventions       PR    32  PRSTDTC
#> 4631   SDTMIG     3.4   Interventions       PR    33  PRENDTC
#> 4632   SDTMIG     3.4   Interventions       PR    34   PRSTDY
#> 4633   SDTMIG     3.4   Interventions       PR    35   PRENDY
#> 4634   SDTMIG     3.4   Interventions       PR    36    PRDUR
#> 4635   SDTMIG     3.4   Interventions       PR    37    PRTPT
#> 4636   SDTMIG     3.4   Interventions       PR    38 PRTPTNUM
#> 4637   SDTMIG     3.4   Interventions       PR    39   PRELTM
#> 4638   SDTMIG     3.4   Interventions       PR    40 PRTPTREF
#> 4639   SDTMIG     3.4   Interventions       PR    41 PRRFTDTC
#> 4640   SDTMIG     3.4   Interventions       PR    42 PRSTRTPT
#> 4641   SDTMIG     3.4   Interventions       PR    43  PRSTTPT
#> 4642   SDTMIG     3.4   Interventions       PR    44 PRENRTPT
#> 4643   SDTMIG     3.4   Interventions       PR    45  PRENTPT
#> 4644   SDTMIG     3.4   Interventions       SU     1  STUDYID
#> 4645   SDTMIG     3.4   Interventions       SU     2   DOMAIN
#> 4646   SDTMIG     3.4   Interventions       SU     3  USUBJID
#> 4647   SDTMIG     3.4   Interventions       SU     4    SUSEQ
#> 4648   SDTMIG     3.4   Interventions       SU     5  SUGRPID
#> 4649   SDTMIG     3.4   Interventions       SU     6   SUSPID
#> 4650   SDTMIG     3.4   Interventions       SU     7    SUTRT
#> 4651   SDTMIG     3.4   Interventions       SU     8 SUMODIFY
#> 4652   SDTMIG     3.4   Interventions       SU     9  SUDECOD
#> 4653   SDTMIG     3.4   Interventions       SU    10    SUCAT
#> 4654   SDTMIG     3.4   Interventions       SU    11   SUSCAT
#> 4655   SDTMIG     3.4   Interventions       SU    12  SUPRESP
#> 4656   SDTMIG     3.4   Interventions       SU    13  SUOCCUR
#> 4657   SDTMIG     3.4   Interventions       SU    14   SUSTAT
#> 4658   SDTMIG     3.4   Interventions       SU    15 SUREASND
#> 4659   SDTMIG     3.4   Interventions       SU    16   SUCLAS
#> 4660   SDTMIG     3.4   Interventions       SU    17 SUCLASCD
#> 4661   SDTMIG     3.4   Interventions       SU    18   SUDOSE
#> 4662   SDTMIG     3.4   Interventions       SU    19 SUDOSTXT
#> 4663   SDTMIG     3.4   Interventions       SU    20   SUDOSU
#> 4664   SDTMIG     3.4   Interventions       SU    21 SUDOSFRM
#> 4665   SDTMIG     3.4   Interventions       SU    22 SUDOSFRQ
#> 4666   SDTMIG     3.4   Interventions       SU    23 SUDOSTOT
#> 4667   SDTMIG     3.4   Interventions       SU    24  SUROUTE
#> 4668   SDTMIG     3.4   Interventions       SU    25  TAETORD
#> 4669   SDTMIG     3.4   Interventions       SU    26    EPOCH
#> 4670   SDTMIG     3.4   Interventions       SU    27  SUSTDTC
#> 4671   SDTMIG     3.4   Interventions       SU    28  SUENDTC
#> 4672   SDTMIG     3.4   Interventions       SU    29   SUSTDY
#> 4673   SDTMIG     3.4   Interventions       SU    30   SUENDY
#> 4674   SDTMIG     3.4   Interventions       SU    31    SUDUR
#> 4675   SDTMIG     3.4   Interventions       SU    32   SUSTRF
#> 4676   SDTMIG     3.4   Interventions       SU    33   SUENRF
#> 4677   SDTMIG     3.4   Interventions       SU    34 SUSTRTPT
#> 4678   SDTMIG     3.4   Interventions       SU    35  SUSTTPT
#> 4679   SDTMIG     3.4   Interventions       SU    36 SUENRTPT
#> 4680   SDTMIG     3.4   Interventions       SU    37  SUENTPT
#> 4681   SDTMIG     3.4          Events       AE     1  STUDYID
#> 4682   SDTMIG     3.4          Events       AE     2   DOMAIN
#> 4683   SDTMIG     3.4          Events       AE     3  USUBJID
#> 4684   SDTMIG     3.4          Events       AE     4  SPDEVID
#> 4685   SDTMIG     3.4          Events       AE     5    AESEQ
#> 4686   SDTMIG     3.4          Events       AE     6  AEGRPID
#> 4687   SDTMIG     3.4          Events       AE     7  AEREFID
#> 4688   SDTMIG     3.4          Events       AE     8   AESPID
#> 4689   SDTMIG     3.4          Events       AE     9   AETERM
#> 4690   SDTMIG     3.4          Events       AE    10 AEMODIFY
#> 4691   SDTMIG     3.4          Events       AE    11    AELLT
#> 4692   SDTMIG     3.4          Events       AE    12  AELLTCD
#> 4693   SDTMIG     3.4          Events       AE    13  AEDECOD
#> 4694   SDTMIG     3.4          Events       AE    14   AEPTCD
#> 4695   SDTMIG     3.4          Events       AE    15    AEHLT
#> 4696   SDTMIG     3.4          Events       AE    16  AEHLTCD
#> 4697   SDTMIG     3.4          Events       AE    17   AEHLGT
#> 4698   SDTMIG     3.4          Events       AE    18 AEHLGTCD
#> 4699   SDTMIG     3.4          Events       AE    19    AECAT
#> 4700   SDTMIG     3.4          Events       AE    20   AESCAT
#> 4701   SDTMIG     3.4          Events       AE    21  AEPRESP
#> 4702   SDTMIG     3.4          Events       AE    22 AEBODSYS
#> 4703   SDTMIG     3.4          Events       AE    23 AEBDSYCD
#> 4704   SDTMIG     3.4          Events       AE    24    AESOC
#> 4705   SDTMIG     3.4          Events       AE    25  AESOCCD
#> 4706   SDTMIG     3.4          Events       AE    26    AELOC
#> 4707   SDTMIG     3.4          Events       AE    27    AESEV
#> 4708   SDTMIG     3.4          Events       AE    28    AESER
#> 4709   SDTMIG     3.4          Events       AE    29    AEACN
#> 4710   SDTMIG     3.4          Events       AE    30 AEACNOTH
#> 4711   SDTMIG     3.4          Events       AE    31 AEACNDEV
#> 4712   SDTMIG     3.4          Events       AE    32    AEREL
#> 4713   SDTMIG     3.4          Events       AE    33  AERLDEV
#> 4714   SDTMIG     3.4          Events       AE    34 AERELNST
#> 4715   SDTMIG     3.4          Events       AE    35   AEPATT
#> 4716   SDTMIG     3.4          Events       AE    36    AEOUT
#> 4717   SDTMIG     3.4          Events       AE    37   AESCAN
#> 4718   SDTMIG     3.4          Events       AE    38  AESCONG
#> 4719   SDTMIG     3.4          Events       AE    39 AESDISAB
#> 4720   SDTMIG     3.4          Events       AE    40   AESDTH
#> 4721   SDTMIG     3.4          Events       AE    41  AESHOSP
#> 4722   SDTMIG     3.4          Events       AE    42  AESLIFE
#> 4723   SDTMIG     3.4          Events       AE    43    AESOD
#> 4724   SDTMIG     3.4          Events       AE    44   AESMIE
#> 4725   SDTMIG     3.4          Events       AE    45  AESINTV
#> 4726   SDTMIG     3.4          Events       AE    46  AEUNANT
#> 4727   SDTMIG     3.4          Events       AE    47  AERLPRT
#> 4728   SDTMIG     3.4          Events       AE    48  AERLPRC
#> 4729   SDTMIG     3.4          Events       AE    49 AECONTRT
#> 4730   SDTMIG     3.4          Events       AE    50  AETOXGR
#> 4731   SDTMIG     3.4          Events       AE    51  TAETORD
#> 4732   SDTMIG     3.4          Events       AE    52    EPOCH
#> 4733   SDTMIG     3.4          Events       AE    53  AESTDTC
#> 4734   SDTMIG     3.4          Events       AE    54  AEENDTC
#> 4735   SDTMIG     3.4          Events       AE    55   AESTDY
#> 4736   SDTMIG     3.4          Events       AE    56   AEENDY
#> 4737   SDTMIG     3.4          Events       AE    57    AEDUR
#> 4738   SDTMIG     3.4          Events       AE    58   AEENRF
#> 4739   SDTMIG     3.4          Events       AE    59 AEENRTPT
#> 4740   SDTMIG     3.4          Events       AE    60  AEENTPT
#> 4741   SDTMIG     3.4          Events       BE     1  STUDYID
#> 4742   SDTMIG     3.4          Events       BE     2   DOMAIN
#> 4743   SDTMIG     3.4          Events       BE     3  USUBJID
#> 4744   SDTMIG     3.4          Events       BE     4  SPDEVID
#> 4745   SDTMIG     3.4          Events       BE     5    BESEQ
#> 4746   SDTMIG     3.4          Events       BE     6  BEGRPID
#> 4747   SDTMIG     3.4          Events       BE     7  BEREFID
#> 4748   SDTMIG     3.4          Events       BE     8   BESPID
#> 4749   SDTMIG     3.4          Events       BE     9   BETERM
#> 4750   SDTMIG     3.4          Events       BE    10 BEMODIFY
#> 4751   SDTMIG     3.4          Events       BE    11  BEDECOD
#> 4752   SDTMIG     3.4          Events       BE    12    BECAT
#> 4753   SDTMIG     3.4          Events       BE    13   BESCAT
#> 4754   SDTMIG     3.4          Events       BE    14    BELOC
#> 4755   SDTMIG     3.4          Events       BE    15  BEPARTY
#> 4756   SDTMIG     3.4          Events       BE    16 BEPRTYID
#> 4757   SDTMIG     3.4          Events       BE    17 VISITNUM
#> 4758   SDTMIG     3.4          Events       BE    18    VISIT
#> 4759   SDTMIG     3.4          Events       BE    19  VISITDY
#> 4760   SDTMIG     3.4          Events       BE    20    BEDTC
#> 4761   SDTMIG     3.4          Events       BE    21  BESTDTC
#> 4762   SDTMIG     3.4          Events       BE    22  BEENDTC
#> 4763   SDTMIG     3.4          Events       BE    23   BESTDY
#> 4764   SDTMIG     3.4          Events       BE    24   BEENDY
#> 4765   SDTMIG     3.4          Events       BE    25    BEDUR
#> 4766   SDTMIG     3.4          Events       CE     1  STUDYID
#> 4767   SDTMIG     3.4          Events       CE     2   DOMAIN
#> 4768   SDTMIG     3.4          Events       CE     3  USUBJID
#> 4769   SDTMIG     3.4          Events       CE     4    CESEQ
#> 4770   SDTMIG     3.4          Events       CE     5  CEGRPID
#> 4771   SDTMIG     3.4          Events       CE     6  CEREFID
#> 4772   SDTMIG     3.4          Events       CE     7   CESPID
#> 4773   SDTMIG     3.4          Events       CE     8   CETERM
#> 4774   SDTMIG     3.4          Events       CE     9  CEDECOD
#> 4775   SDTMIG     3.4          Events       CE    10    CECAT
#> 4776   SDTMIG     3.4          Events       CE    11   CESCAT
#> 4777   SDTMIG     3.4          Events       CE    12  CEPRESP
#> 4778   SDTMIG     3.4          Events       CE    13  CEOCCUR
#> 4779   SDTMIG     3.4          Events       CE    14   CESTAT
#> 4780   SDTMIG     3.4          Events       CE    15 CEREASND
#> 4781   SDTMIG     3.4          Events       CE    16 CEBODSYS
#> 4782   SDTMIG     3.4          Events       CE    17    CESEV
#> 4783   SDTMIG     3.4          Events       CE    18  CETOXGR
#> 4784   SDTMIG     3.4          Events       CE    19  TAETORD
#> 4785   SDTMIG     3.4          Events       CE    20    EPOCH
#> 4786   SDTMIG     3.4          Events       CE    21    CEDTC
#> 4787   SDTMIG     3.4          Events       CE    22  CESTDTC
#> 4788   SDTMIG     3.4          Events       CE    23  CEENDTC
#> 4789   SDTMIG     3.4          Events       CE    24     CEDY
#> 4790   SDTMIG     3.4          Events       CE    25   CESTDY
#> 4791   SDTMIG     3.4          Events       CE    26   CEENDY
#> 4792   SDTMIG     3.4          Events       CE    27   CESTRF
#> 4793   SDTMIG     3.4          Events       CE    28   CEENRF
#> 4794   SDTMIG     3.4          Events       CE    29 CESTRTPT
#> 4795   SDTMIG     3.4          Events       CE    30  CESTTPT
#> 4796   SDTMIG     3.4          Events       CE    31 CEENRTPT
#> 4797   SDTMIG     3.4          Events       CE    32  CEENTPT
#> 4798   SDTMIG     3.4          Events       DS     1  STUDYID
#> 4799   SDTMIG     3.4          Events       DS     2   DOMAIN
#> 4800   SDTMIG     3.4          Events       DS     3  USUBJID
#> 4801   SDTMIG     3.4          Events       DS     4    DSSEQ
#> 4802   SDTMIG     3.4          Events       DS     5  DSGRPID
#> 4803   SDTMIG     3.4          Events       DS     6  DSREFID
#> 4804   SDTMIG     3.4          Events       DS     7   DSSPID
#> 4805   SDTMIG     3.4          Events       DS     8   DSTERM
#> 4806   SDTMIG     3.4          Events       DS     9  DSDECOD
#> 4807   SDTMIG     3.4          Events       DS    10    DSCAT
#> 4808   SDTMIG     3.4          Events       DS    11   DSSCAT
#> 4809   SDTMIG     3.4          Events       DS    12    EPOCH
#> 4810   SDTMIG     3.4          Events       DS    13    DSDTC
#> 4811   SDTMIG     3.4          Events       DS    14  DSSTDTC
#> 4812   SDTMIG     3.4          Events       DS    15     DSDY
#> 4813   SDTMIG     3.4          Events       DS    16   DSSTDY
#> 4814   SDTMIG     3.4          Events       DV     1  STUDYID
#> 4815   SDTMIG     3.4          Events       DV     2   DOMAIN
#> 4816   SDTMIG     3.4          Events       DV     3  USUBJID
#> 4817   SDTMIG     3.4          Events       DV     4    DVSEQ
#> 4818   SDTMIG     3.4          Events       DV     5  DVREFID
#> 4819   SDTMIG     3.4          Events       DV     6   DVSPID
#> 4820   SDTMIG     3.4          Events       DV     7   DVTERM
#> 4821   SDTMIG     3.4          Events       DV     8  DVDECOD
#> 4822   SDTMIG     3.4          Events       DV     9    DVCAT
#> 4823   SDTMIG     3.4          Events       DV    10   DVSCAT
#> 4824   SDTMIG     3.4          Events       DV    11  TAETORD
#> 4825   SDTMIG     3.4          Events       DV    12    EPOCH
#> 4826   SDTMIG     3.4          Events       DV    13  DVSTDTC
#> 4827   SDTMIG     3.4          Events       DV    14  DVENDTC
#> 4828   SDTMIG     3.4          Events       DV    15   DVSTDY
#> 4829   SDTMIG     3.4          Events       DV    16   DVENDY
#> 4830   SDTMIG     3.4          Events       HO     1  STUDYID
#> 4831   SDTMIG     3.4          Events       HO     2   DOMAIN
#> 4832   SDTMIG     3.4          Events       HO     3  USUBJID
#> 4833   SDTMIG     3.4          Events       HO     4    HOSEQ
#> 4834   SDTMIG     3.4          Events       HO     5  HOGRPID
#> 4835   SDTMIG     3.4          Events       HO     6  HOREFID
#> 4836   SDTMIG     3.4          Events       HO     7   HOSPID
#> 4837   SDTMIG     3.4          Events       HO     8   HOTERM
#> 4838   SDTMIG     3.4          Events       HO     9  HODECOD
#> 4839   SDTMIG     3.4          Events       HO    10    HOCAT
#> 4840   SDTMIG     3.4          Events       HO    11   HOSCAT
#> 4841   SDTMIG     3.4          Events       HO    12  HOPRESP
#> 4842   SDTMIG     3.4          Events       HO    13  HOOCCUR
#> 4843   SDTMIG     3.4          Events       HO    14   HOSTAT
#> 4844   SDTMIG     3.4          Events       HO    15 HOREASND
#> 4845   SDTMIG     3.4          Events       HO    16  TAETORD
#> 4846   SDTMIG     3.4          Events       HO    17    EPOCH
#> 4847   SDTMIG     3.4          Events       HO    18    HODTC
#> 4848   SDTMIG     3.4          Events       HO    19  HOSTDTC
#> 4849   SDTMIG     3.4          Events       HO    20  HOENDTC
#> 4850   SDTMIG     3.4          Events       HO    21     HODY
#> 4851   SDTMIG     3.4          Events       HO    22   HOSTDY
#> 4852   SDTMIG     3.4          Events       HO    23   HOENDY
#> 4853   SDTMIG     3.4          Events       HO    24    HODUR
#> 4854   SDTMIG     3.4          Events       HO    25 HOSTRTPT
#> 4855   SDTMIG     3.4          Events       HO    26  HOSTTPT
#> 4856   SDTMIG     3.4          Events       HO    27 HOENRTPT
#> 4857   SDTMIG     3.4          Events       HO    28  HOENTPT
#> 4858   SDTMIG     3.4          Events       MH     1  STUDYID
#> 4859   SDTMIG     3.4          Events       MH     2   DOMAIN
#> 4860   SDTMIG     3.4          Events       MH     3  USUBJID
#> 4861   SDTMIG     3.4          Events       MH     4    MHSEQ
#> 4862   SDTMIG     3.4          Events       MH     5  MHGRPID
#> 4863   SDTMIG     3.4          Events       MH     6  MHREFID
#> 4864   SDTMIG     3.4          Events       MH     7   MHSPID
#> 4865   SDTMIG     3.4          Events       MH     8   MHTERM
#> 4866   SDTMIG     3.4          Events       MH     9 MHMODIFY
#> 4867   SDTMIG     3.4          Events       MH    10  MHDECOD
#> 4868   SDTMIG     3.4          Events       MH    11 MHEVDTYP
#> 4869   SDTMIG     3.4          Events       MH    12    MHCAT
#> 4870   SDTMIG     3.4          Events       MH    13   MHSCAT
#> 4871   SDTMIG     3.4          Events       MH    14  MHPRESP
#> 4872   SDTMIG     3.4          Events       MH    15  MHOCCUR
#> 4873   SDTMIG     3.4          Events       MH    16   MHSTAT
#> 4874   SDTMIG     3.4          Events       MH    17 MHREASND
#> 4875   SDTMIG     3.4          Events       MH    18 MHBODSYS
#> 4876   SDTMIG     3.4          Events       MH    19  TAETORD
#> 4877   SDTMIG     3.4          Events       MH    20    EPOCH
#> 4878   SDTMIG     3.4          Events       MH    21    MHDTC
#> 4879   SDTMIG     3.4          Events       MH    22  MHSTDTC
#> 4880   SDTMIG     3.4          Events       MH    23  MHENDTC
#> 4881   SDTMIG     3.4          Events       MH    24     MHDY
#> 4882   SDTMIG     3.4          Events       MH    25   MHENRF
#> 4883   SDTMIG     3.4          Events       MH    26 MHENRTPT
#> 4884   SDTMIG     3.4          Events       MH    27  MHENTPT
#> 4885   SDTMIG     3.4        Findings       BS     1  STUDYID
#> 4886   SDTMIG     3.4        Findings       BS     2   DOMAIN
#> 4887   SDTMIG     3.4        Findings       BS     3  USUBJID
#> 4888   SDTMIG     3.4        Findings       BS     4  SPDEVID
#> 4889   SDTMIG     3.4        Findings       BS     5    BSSEQ
#> 4890   SDTMIG     3.4        Findings       BS     6  BSGRPID
#> 4891   SDTMIG     3.4        Findings       BS     7  BSREFID
#> 4892   SDTMIG     3.4        Findings       BS     8   BSSPID
#> 4893   SDTMIG     3.4        Findings       BS     9 BSTESTCD
#> 4894   SDTMIG     3.4        Findings       BS    10   BSTEST
#> 4895   SDTMIG     3.4        Findings       BS    11    BSCAT
#> 4896   SDTMIG     3.4        Findings       BS    12   BSSCAT
#> 4897   SDTMIG     3.4        Findings       BS    13  BSORRES
#> 4898   SDTMIG     3.4        Findings       BS    14 BSORRESU
#> 4899   SDTMIG     3.4        Findings       BS    15 BSSTRESC
#> 4900   SDTMIG     3.4        Findings       BS    16 BSSTRESN
#> 4901   SDTMIG     3.4        Findings       BS    17 BSSTRESU
#> 4902   SDTMIG     3.4        Findings       BS    18   BSSTAT
#> 4903   SDTMIG     3.4        Findings       BS    19 BSREASND
#> 4904   SDTMIG     3.4        Findings       BS    20    BSNAM
#> 4905   SDTMIG     3.4        Findings       BS    21   BSSPEC
#> 4906   SDTMIG     3.4        Findings       BS    22 BSANTREG
#> 4907   SDTMIG     3.4        Findings       BS    23 BSSPCCND
#> 4908   SDTMIG     3.4        Findings       BS    24 BSMETHOD
#> 4909   SDTMIG     3.4        Findings       BS    25   BSBLFL
#> 4910   SDTMIG     3.4        Findings       BS    26 VISITNUM
#> 4911   SDTMIG     3.4        Findings       BS    27    VISIT
#> 4912   SDTMIG     3.4        Findings       BS    28  VISITDY
#> 4913   SDTMIG     3.4        Findings       BS    29    BSDTC
#> 4914   SDTMIG     3.4        Findings       BS    30     BSDY
#> 4915   SDTMIG     3.4        Findings       BS    31    BSTPT
#> 4916   SDTMIG     3.4        Findings       BS    32 BSTPTNUM
#> 4917   SDTMIG     3.4        Findings       BS    33   BSELTM
#> 4918   SDTMIG     3.4        Findings       BS    34 BSTPTREF
#> 4919   SDTMIG     3.4        Findings       BS    35 BSRFTDTC
#> 4920   SDTMIG     3.4        Findings       CP     1  STUDYID
#> 4921   SDTMIG     3.4        Findings       CP     2   DOMAIN
#> 4922   SDTMIG     3.4        Findings       CP     3  USUBJID
#> 4923   SDTMIG     3.4        Findings       CP     4    CPSEQ
#> 4924   SDTMIG     3.4        Findings       CP     5  CPGRPID
#> 4925   SDTMIG     3.4        Findings       CP     6  CPREFID
#> 4926   SDTMIG     3.4        Findings       CP     7   CPSPID
#> 4927   SDTMIG     3.4        Findings       CP     8  CPLNKID
#> 4928   SDTMIG     3.4        Findings       CP     9 CPLNKGRP
#> 4929   SDTMIG     3.4        Findings       CP    10 CPTESTCD
#> 4930   SDTMIG     3.4        Findings       CP    11   CPTEST
#> 4931   SDTMIG     3.4        Findings       CP    12 CPSBMRKS
#> 4932   SDTMIG     3.4        Findings       CP    13 CPCELSTA
#> 4933   SDTMIG     3.4        Findings       CP    14 CPCSMRKS
#> 4934   SDTMIG     3.4        Findings       CP    15 CPTSTCND
#> 4935   SDTMIG     3.4        Findings       CP    16 CPCNDAGT
#> 4936   SDTMIG     3.4        Findings       CP    17 CPBDAGNT
#> 4937   SDTMIG     3.4        Findings       CP    18 CPABCLID
#> 4938   SDTMIG     3.4        Findings       CP    19 CPMRKSTR
#> 4939   SDTMIG     3.4        Findings       CP    20   CPGATE
#> 4940   SDTMIG     3.4        Findings       CP    21 CPGATDEF
#> 4941   SDTMIG     3.4        Findings       CP    22 CPSPTSTD
#> 4942   SDTMIG     3.4        Findings       CP    23    CPCAT
#> 4943   SDTMIG     3.4        Findings       CP    24   CPSCAT
#> 4944   SDTMIG     3.4        Findings       CP    25 CPTSTPNL
#> 4945   SDTMIG     3.4        Findings       CP    26  CPORRES
#> 4946   SDTMIG     3.4        Findings       CP    27 CPORRESU
#> 4947   SDTMIG     3.4        Findings       CP    28 CPRESSCL
#> 4948   SDTMIG     3.4        Findings       CP    29 CPRESTYP
#> 4949   SDTMIG     3.4        Findings       CP    30 CPCOLSRT
#> 4950   SDTMIG     3.4        Findings       CP    31 CPORNRLO
#> 4951   SDTMIG     3.4        Findings       CP    32 CPORNRHI
#> 4952   SDTMIG     3.4        Findings       CP    33 CPSTRESC
#> 4953   SDTMIG     3.4        Findings       CP    34 CPSTRESN
#> 4954   SDTMIG     3.4        Findings       CP    35 CPSTRESU
#> 4955   SDTMIG     3.4        Findings       CP    36 CPSTNRLO
#> 4956   SDTMIG     3.4        Findings       CP    37 CPSTNRHI
#> 4957   SDTMIG     3.4        Findings       CP    38  CPNRIND
#> 4958   SDTMIG     3.4        Findings       CP    39   CPSTAT
#> 4959   SDTMIG     3.4        Findings       CP    40 CPREASND
#> 4960   SDTMIG     3.4        Findings       CP    41    CPNAM
#> 4961   SDTMIG     3.4        Findings       CP    42  CPLOINC
#> 4962   SDTMIG     3.4        Findings       CP    43   CPSPEC
#> 4963   SDTMIG     3.4        Findings       CP    44 CPSPCCND
#> 4964   SDTMIG     3.4        Findings       CP    45 CPMETHOD
#> 4965   SDTMIG     3.4        Findings       CP    46 CPANMETH
#> 4966   SDTMIG     3.4        Findings       CP    47 CPLOBXFL
#> 4967   SDTMIG     3.4        Findings       CP    48   CPBLFL
#> 4968   SDTMIG     3.4        Findings       CP    49  CPDRVFL
#> 4969   SDTMIG     3.4        Findings       CP    50  CPCLSIG
#> 4970   SDTMIG     3.4        Findings       CP    51 VISITNUM
#> 4971   SDTMIG     3.4        Findings       CP    52    VISIT
#> 4972   SDTMIG     3.4        Findings       CP    53  VISITDY
#> 4973   SDTMIG     3.4        Findings       CP    54  TAETORD
#> 4974   SDTMIG     3.4        Findings       CP    55    EPOCH
#> 4975   SDTMIG     3.4        Findings       CP    56    CPDTC
#> 4976   SDTMIG     3.4        Findings       CP    57     CPDY
#> 4977   SDTMIG     3.4        Findings       CP    58    CPTPT
#> 4978   SDTMIG     3.4        Findings       CP    59 CPTPTNUM
#> 4979   SDTMIG     3.4        Findings       CP    60   CPELTM
#> 4980   SDTMIG     3.4        Findings       CP    61 CPTPTREF
#> 4981   SDTMIG     3.4        Findings       CP    62 CPRFTDTC
#> 4982   SDTMIG     3.4        Findings       CV     1  STUDYID
#> 4983   SDTMIG     3.4        Findings       CV     2   DOMAIN
#> 4984   SDTMIG     3.4        Findings       CV     3  USUBJID
#> 4985   SDTMIG     3.4        Findings       CV     4    CVSEQ
#> 4986   SDTMIG     3.4        Findings       CV     5  CVGRPID
#> 4987   SDTMIG     3.4        Findings       CV     6  CVREFID
#> 4988   SDTMIG     3.4        Findings       CV     7   CVSPID
#> 4989   SDTMIG     3.4        Findings       CV     8  CVLNKID
#> 4990   SDTMIG     3.4        Findings       CV     9 CVLNKGRP
#> 4991   SDTMIG     3.4        Findings       CV    10 CVTESTCD
#> 4992   SDTMIG     3.4        Findings       CV    11   CVTEST
#> 4993   SDTMIG     3.4        Findings       CV    12    CVCAT
#> 4994   SDTMIG     3.4        Findings       CV    13   CVSCAT
#> 4995   SDTMIG     3.4        Findings       CV    14    CVPOS
#> 4996   SDTMIG     3.4        Findings       CV    15  CVORRES
#> 4997   SDTMIG     3.4        Findings       CV    16 CVORRESU
#> 4998   SDTMIG     3.4        Findings       CV    17 CVSTRESC
#> 4999   SDTMIG     3.4        Findings       CV    18 CVSTRESN
#> 5000   SDTMIG     3.4        Findings       CV    19 CVSTRESU
#> 5001   SDTMIG     3.4        Findings       CV    20   CVSTAT
#> 5002   SDTMIG     3.4        Findings       CV    21 CVREASND
#> 5003   SDTMIG     3.4        Findings       CV    22    CVLOC
#> 5004   SDTMIG     3.4        Findings       CV    23    CVLAT
#> 5005   SDTMIG     3.4        Findings       CV    24    CVDIR
#> 5006   SDTMIG     3.4        Findings       CV    25 CVMETHOD
#> 5007   SDTMIG     3.4        Findings       CV    26 CVLOBXFL
#> 5008   SDTMIG     3.4        Findings       CV    27   CVBLFL
#> 5009   SDTMIG     3.4        Findings       CV    28  CVDRVFL
#> 5010   SDTMIG     3.4        Findings       CV    29   CVEVAL
#> 5011   SDTMIG     3.4        Findings       CV    30 CVEVALID
#> 5012   SDTMIG     3.4        Findings       CV    31 VISITNUM
#> 5013   SDTMIG     3.4        Findings       CV    32    VISIT
#> 5014   SDTMIG     3.4        Findings       CV    33  VISITDY
#> 5015   SDTMIG     3.4        Findings       CV    34  TAETORD
#> 5016   SDTMIG     3.4        Findings       CV    35    EPOCH
#> 5017   SDTMIG     3.4        Findings       CV    36    CVDTC
#> 5018   SDTMIG     3.4        Findings       CV    37     CVDY
#> 5019   SDTMIG     3.4        Findings       CV    38    CVTPT
#> 5020   SDTMIG     3.4        Findings       CV    39 CVTPTNUM
#> 5021   SDTMIG     3.4        Findings       CV    40   CVELTM
#> 5022   SDTMIG     3.4        Findings       CV    41 CVTPTREF
#> 5023   SDTMIG     3.4        Findings       CV    42 CVRFTDTC
#> 5024   SDTMIG     3.4        Findings       DA     1  STUDYID
#> 5025   SDTMIG     3.4        Findings       DA     2   DOMAIN
#> 5026   SDTMIG     3.4        Findings       DA     3  USUBJID
#> 5027   SDTMIG     3.4        Findings       DA     4    DASEQ
#> 5028   SDTMIG     3.4        Findings       DA     5  DAGRPID
#> 5029   SDTMIG     3.4        Findings       DA     6  DAREFID
#> 5030   SDTMIG     3.4        Findings       DA     7   DASPID
#> 5031   SDTMIG     3.4        Findings       DA     8  DALNKID
#> 5032   SDTMIG     3.4        Findings       DA     9 DALNKGRP
#> 5033   SDTMIG     3.4        Findings       DA    10 DATESTCD
#> 5034   SDTMIG     3.4        Findings       DA    11   DATEST
#> 5035   SDTMIG     3.4        Findings       DA    12    DACAT
#> 5036   SDTMIG     3.4        Findings       DA    13   DASCAT
#> 5037   SDTMIG     3.4        Findings       DA    14  DAORRES
#> 5038   SDTMIG     3.4        Findings       DA    15 DAORRESU
#> 5039   SDTMIG     3.4        Findings       DA    16 DASTRESC
#> 5040   SDTMIG     3.4        Findings       DA    17 DASTRESN
#> 5041   SDTMIG     3.4        Findings       DA    18 DASTRESU
#> 5042   SDTMIG     3.4        Findings       DA    19   DASTAT
#> 5043   SDTMIG     3.4        Findings       DA    20 DAREASND
#> 5044   SDTMIG     3.4        Findings       DA    21 VISITNUM
#> 5045   SDTMIG     3.4        Findings       DA    22    VISIT
#> 5046   SDTMIG     3.4        Findings       DA    23  VISITDY
#> 5047   SDTMIG     3.4        Findings       DA    24  TAETORD
#> 5048   SDTMIG     3.4        Findings       DA    25    EPOCH
#> 5049   SDTMIG     3.4        Findings       DA    26    DADTC
#> 5050   SDTMIG     3.4        Findings       DA    27     DADY
#> 5051   SDTMIG     3.4        Findings       DD     1  STUDYID
#> 5052   SDTMIG     3.4        Findings       DD     2   DOMAIN
#> 5053   SDTMIG     3.4        Findings       DD     3  USUBJID
#> 5054   SDTMIG     3.4        Findings       DD     4    DDSEQ
#> 5055   SDTMIG     3.4        Findings       DD     5 DDTESTCD
#> 5056   SDTMIG     3.4        Findings       DD     6   DDTEST
#> 5057   SDTMIG     3.4        Findings       DD     7  DDORRES
#> 5058   SDTMIG     3.4        Findings       DD     8 DDSTRESC
#> 5059   SDTMIG     3.4        Findings       DD     9 DDRESCAT
#> 5060   SDTMIG     3.4        Findings       DD    10   DDEVAL
#> 5061   SDTMIG     3.4        Findings       DD    11    DDDTC
#> 5062   SDTMIG     3.4        Findings       DD    12     DDDY
#> 5063   SDTMIG     3.4        Findings       EG     1  STUDYID
#> 5064   SDTMIG     3.4        Findings       EG     2   DOMAIN
#> 5065   SDTMIG     3.4        Findings       EG     3  USUBJID
#> 5066   SDTMIG     3.4        Findings       EG     4  SPDEVID
#> 5067   SDTMIG     3.4        Findings       EG     5    EGSEQ
#> 5068   SDTMIG     3.4        Findings       EG     6  EGGRPID
#> 5069   SDTMIG     3.4        Findings       EG     7  EGREFID
#> 5070   SDTMIG     3.4        Findings       EG     8   EGSPID
#> 5071   SDTMIG     3.4        Findings       EG     9 EGBEATNO
#> 5072   SDTMIG     3.4        Findings       EG    10 EGTESTCD
#> 5073   SDTMIG     3.4        Findings       EG    11   EGTEST
#> 5074   SDTMIG     3.4        Findings       EG    12    EGCAT
#> 5075   SDTMIG     3.4        Findings       EG    13   EGSCAT
#> 5076   SDTMIG     3.4        Findings       EG    14    EGPOS
#> 5077   SDTMIG     3.4        Findings       EG    15  EGORRES
#> 5078   SDTMIG     3.4        Findings       EG    16 EGORRESU
#> 5079   SDTMIG     3.4        Findings       EG    17 EGSTRESC
#> 5080   SDTMIG     3.4        Findings       EG    18 EGSTRESN
#> 5081   SDTMIG     3.4        Findings       EG    19 EGSTRESU
#> 5082   SDTMIG     3.4        Findings       EG    20   EGSTAT
#> 5083   SDTMIG     3.4        Findings       EG    21 EGREASND
#> 5084   SDTMIG     3.4        Findings       EG    22    EGXFN
#> 5085   SDTMIG     3.4        Findings       EG    23    EGNAM
#> 5086   SDTMIG     3.4        Findings       EG    24 EGMETHOD
#> 5087   SDTMIG     3.4        Findings       EG    25   EGLEAD
#> 5088   SDTMIG     3.4        Findings       EG    26 EGLOBXFL
#> 5089   SDTMIG     3.4        Findings       EG    27   EGBLFL
#> 5090   SDTMIG     3.4        Findings       EG    28  EGDRVFL
#> 5091   SDTMIG     3.4        Findings       EG    29   EGEVAL
#> 5092   SDTMIG     3.4        Findings       EG    30 EGEVALID
#> 5093   SDTMIG     3.4        Findings       EG    31  EGCLSIG
#> 5094   SDTMIG     3.4        Findings       EG    32 EGREPNUM
#> 5095   SDTMIG     3.4        Findings       EG    33 VISITNUM
#> 5096   SDTMIG     3.4        Findings       EG    34    VISIT
#> 5097   SDTMIG     3.4        Findings       EG    35  VISITDY
#> 5098   SDTMIG     3.4        Findings       EG    36  TAETORD
#> 5099   SDTMIG     3.4        Findings       EG    37    EPOCH
#> 5100   SDTMIG     3.4        Findings       EG    38    EGDTC
#> 5101   SDTMIG     3.4        Findings       EG    39     EGDY
#> 5102   SDTMIG     3.4        Findings       EG    40    EGTPT
#> 5103   SDTMIG     3.4        Findings       EG    41 EGTPTNUM
#> 5104   SDTMIG     3.4        Findings       EG    42   EGELTM
#> 5105   SDTMIG     3.4        Findings       EG    43 EGTPTREF
#> 5106   SDTMIG     3.4        Findings       EG    44 EGRFTDTC
#> 5107   SDTMIG     3.4        Findings       FT     1  STUDYID
#> 5108   SDTMIG     3.4        Findings       FT     2   DOMAIN
#> 5109   SDTMIG     3.4        Findings       FT     3  USUBJID
#> 5110   SDTMIG     3.4        Findings       FT     4    FTSEQ
#> 5111   SDTMIG     3.4        Findings       FT     5  FTGRPID
#> 5112   SDTMIG     3.4        Findings       FT     6  FTREFID
#> 5113   SDTMIG     3.4        Findings       FT     7   FTSPID
#> 5114   SDTMIG     3.4        Findings       FT     8 FTTESTCD
#> 5115   SDTMIG     3.4        Findings       FT     9   FTTEST
#> 5116   SDTMIG     3.4        Findings       FT    10    FTCAT
#> 5117   SDTMIG     3.4        Findings       FT    11   FTSCAT
#> 5118   SDTMIG     3.4        Findings       FT    12    FTPOS
#> 5119   SDTMIG     3.4        Findings       FT    13  FTORRES
#> 5120   SDTMIG     3.4        Findings       FT    14 FTORRESU
#> 5121   SDTMIG     3.4        Findings       FT    15 FTSTRESC
#> 5122   SDTMIG     3.4        Findings       FT    16 FTSTRESN
#> 5123   SDTMIG     3.4        Findings       FT    17 FTSTRESU
#> 5124   SDTMIG     3.4        Findings       FT    18   FTSTAT
#> 5125   SDTMIG     3.4        Findings       FT    19 FTREASND
#> 5126   SDTMIG     3.4        Findings       FT    20    FTXFN
#> 5127   SDTMIG     3.4        Findings       FT    21    FTNAM
#> 5128   SDTMIG     3.4        Findings       FT    22 FTMETHOD
#> 5129   SDTMIG     3.4        Findings       FT    23 FTLOBXFL
#> 5130   SDTMIG     3.4        Findings       FT    24   FTBLFL
#> 5131   SDTMIG     3.4        Findings       FT    25  FTDRVFL
#> 5132   SDTMIG     3.4        Findings       FT    26 FTREPNUM
#> 5133   SDTMIG     3.4        Findings       FT    27 VISITNUM
#> 5134   SDTMIG     3.4        Findings       FT    28    VISIT
#> 5135   SDTMIG     3.4        Findings       FT    29  VISITDY
#> 5136   SDTMIG     3.4        Findings       FT    30  TAETORD
#> 5137   SDTMIG     3.4        Findings       FT    31    EPOCH
#> 5138   SDTMIG     3.4        Findings       FT    32    FTDTC
#> 5139   SDTMIG     3.4        Findings       FT    33     FTDY
#> 5140   SDTMIG     3.4        Findings       FT    34    FTTPT
#> 5141   SDTMIG     3.4        Findings       FT    35 FTTPTNUM
#> 5142   SDTMIG     3.4        Findings       FT    36   FTELTM
#> 5143   SDTMIG     3.4        Findings       FT    37 FTTPTREF
#> 5144   SDTMIG     3.4        Findings       FT    38 FTRFTDTC
#> 5145   SDTMIG     3.4        Findings       GF     1  STUDYID
#> 5146   SDTMIG     3.4        Findings       GF     2   DOMAIN
#> 5147   SDTMIG     3.4        Findings       GF     3  USUBJID
#> 5148   SDTMIG     3.4        Findings       GF     4  SPDEVID
#> 5149   SDTMIG     3.4        Findings       GF     5    NHOID
#> 5150   SDTMIG     3.4        Findings       GF     6    GFSEQ
#> 5151   SDTMIG     3.4        Findings       GF     7  GFGRPID
#> 5152   SDTMIG     3.4        Findings       GF     8  GFREFID
#> 5153   SDTMIG     3.4        Findings       GF     9   GFSPID
#> 5154   SDTMIG     3.4        Findings       GF    10  GFLNKID
#> 5155   SDTMIG     3.4        Findings       GF    11 GFLNKGRP
#> 5156   SDTMIG     3.4        Findings       GF    12 GFTESTCD
#> 5157   SDTMIG     3.4        Findings       GF    13   GFTEST
#> 5158   SDTMIG     3.4        Findings       GF    14 GFTSTDTL
#> 5159   SDTMIG     3.4        Findings       GF    15    GFCAT
#> 5160   SDTMIG     3.4        Findings       GF    16   GFSCAT
#> 5161   SDTMIG     3.4        Findings       GF    17  GFORRES
#> 5162   SDTMIG     3.4        Findings       GF    18 GFORRESU
#> 5163   SDTMIG     3.4        Findings       GF    19  GFORREF
#> 5164   SDTMIG     3.4        Findings       GF    20 GFSTRESC
#> 5165   SDTMIG     3.4        Findings       GF    21 GFSTRESN
#> 5166   SDTMIG     3.4        Findings       GF    22 GFSTRESU
#> 5167   SDTMIG     3.4        Findings       GF    23 GFSTREFC
#> 5168   SDTMIG     3.4        Findings       GF    24 GFSTREFN
#> 5169   SDTMIG     3.4        Findings       GF    25 GFRESCAT
#> 5170   SDTMIG     3.4        Findings       GF    26 GFINHERT
#> 5171   SDTMIG     3.4        Findings       GF    27 GFGENREF
#> 5172   SDTMIG     3.4        Findings       GF    28  GFCHROM
#> 5173   SDTMIG     3.4        Findings       GF    29    GFSYM
#> 5174   SDTMIG     3.4        Findings       GF    30 GFSYMTYP
#> 5175   SDTMIG     3.4        Findings       GF    31 GFGENLOC
#> 5176   SDTMIG     3.4        Findings       GF    32  GFGENSR
#> 5177   SDTMIG     3.4        Findings       GF    33  GFSEQID
#> 5178   SDTMIG     3.4        Findings       GF    34  GFPVRID
#> 5179   SDTMIG     3.4        Findings       GF    35 GFCOPYID
#> 5180   SDTMIG     3.4        Findings       GF    36   GFSTAT
#> 5181   SDTMIG     3.4        Findings       GF    37 GFREASND
#> 5182   SDTMIG     3.4        Findings       GF    38    GFXFN
#> 5183   SDTMIG     3.4        Findings       GF    39    GFNAM
#> 5184   SDTMIG     3.4        Findings       GF    40   GFSPEC
#> 5185   SDTMIG     3.4        Findings       GF    41 GFMETHOD
#> 5186   SDTMIG     3.4        Findings       GF    42  GFRUNID
#> 5187   SDTMIG     3.4        Findings       GF    43 GFANMETH
#> 5188   SDTMIG     3.4        Findings       GF    44   GFBLFL
#> 5189   SDTMIG     3.4        Findings       GF    45  GFDRVFL
#> 5190   SDTMIG     3.4        Findings       GF    46   GFLLOQ
#> 5191   SDTMIG     3.4        Findings       GF    47 GFREPNUM
#> 5192   SDTMIG     3.4        Findings       GF    48 VISITNUM
#> 5193   SDTMIG     3.4        Findings       GF    49    VISIT
#> 5194   SDTMIG     3.4        Findings       GF    50  VISITDY
#> 5195   SDTMIG     3.4        Findings       GF    51    GFDTC
#> 5196   SDTMIG     3.4        Findings       GF    52     GFDY
#> 5197   SDTMIG     3.4        Findings       GF    53    GFTPT
#> 5198   SDTMIG     3.4        Findings       GF    54 GFTPTNUM
#> 5199   SDTMIG     3.4        Findings       GF    55   GFELTM
#> 5200   SDTMIG     3.4        Findings       GF    56 GFTPTREF
#> 5201   SDTMIG     3.4        Findings       GF    57 GFRFTDTC
#> 5202   SDTMIG     3.4        Findings       IE     1  STUDYID
#> 5203   SDTMIG     3.4        Findings       IE     2   DOMAIN
#> 5204   SDTMIG     3.4        Findings       IE     3  USUBJID
#> 5205   SDTMIG     3.4        Findings       IE     4    IESEQ
#> 5206   SDTMIG     3.4        Findings       IE     5   IESPID
#> 5207   SDTMIG     3.4        Findings       IE     6 IETESTCD
#> 5208   SDTMIG     3.4        Findings       IE     7   IETEST
#> 5209   SDTMIG     3.4        Findings       IE     8    IECAT
#> 5210   SDTMIG     3.4        Findings       IE     9   IESCAT
#> 5211   SDTMIG     3.4        Findings       IE    10  IEORRES
#> 5212   SDTMIG     3.4        Findings       IE    11 IESTRESC
#> 5213   SDTMIG     3.4        Findings       IE    12 VISITNUM
#> 5214   SDTMIG     3.4        Findings       IE    13    VISIT
#> 5215   SDTMIG     3.4        Findings       IE    14  VISITDY
#> 5216   SDTMIG     3.4        Findings       IE    15  TAETORD
#> 5217   SDTMIG     3.4        Findings       IE    16    EPOCH
#> 5218   SDTMIG     3.4        Findings       IE    17    IEDTC
#> 5219   SDTMIG     3.4        Findings       IE    18     IEDY
#> 5220   SDTMIG     3.4        Findings       IS     1  STUDYID
#> 5221   SDTMIG     3.4        Findings       IS     2   DOMAIN
#> 5222   SDTMIG     3.4        Findings       IS     3  USUBJID
#> 5223   SDTMIG     3.4        Findings       IS     4    NHOID
#> 5224   SDTMIG     3.4        Findings       IS     5    ISSEQ
#> 5225   SDTMIG     3.4        Findings       IS     6  ISGRPID
#> 5226   SDTMIG     3.4        Findings       IS     7  ISREFID
#> 5227   SDTMIG     3.4        Findings       IS     8   ISSPID
#> 5228   SDTMIG     3.4        Findings       IS     9 ISTESTCD
#> 5229   SDTMIG     3.4        Findings       IS    10   ISTEST
#> 5230   SDTMIG     3.4        Findings       IS    11 ISTSTCND
#> 5231   SDTMIG     3.4        Findings       IS    12 ISCNDAGT
#> 5232   SDTMIG     3.4        Findings       IS    13 ISBDAGNT
#> 5233   SDTMIG     3.4        Findings       IS    14 ISTSTOPO
#> 5234   SDTMIG     3.4        Findings       IS    15 ISMSCBCE
#> 5235   SDTMIG     3.4        Findings       IS    16 ISTSTDTL
#> 5236   SDTMIG     3.4        Findings       IS    17    ISCAT
#> 5237   SDTMIG     3.4        Findings       IS    18   ISSCAT
#> 5238   SDTMIG     3.4        Findings       IS    19  ISORRES
#> 5239   SDTMIG     3.4        Findings       IS    20 ISORRESU
#> 5240   SDTMIG     3.4        Findings       IS    21 ISORNRLO
#> 5241   SDTMIG     3.4        Findings       IS    22 ISORNRHI
#> 5242   SDTMIG     3.4        Findings       IS    23 ISSTRESC
#> 5243   SDTMIG     3.4        Findings       IS    24 ISSTRESN
#> 5244   SDTMIG     3.4        Findings       IS    25 ISSTRESU
#> 5245   SDTMIG     3.4        Findings       IS    26 ISSTNRLO
#> 5246   SDTMIG     3.4        Findings       IS    27 ISSTNRHI
#> 5247   SDTMIG     3.4        Findings       IS    28  ISSTNRC
#> 5248   SDTMIG     3.4        Findings       IS    29  ISNRIND
#> 5249   SDTMIG     3.4        Findings       IS    30   ISSTAT
#> 5250   SDTMIG     3.4        Findings       IS    31 ISREASND
#> 5251   SDTMIG     3.4        Findings       IS    32    ISNAM
#> 5252   SDTMIG     3.4        Findings       IS    33   ISSPEC
#> 5253   SDTMIG     3.4        Findings       IS    34 ISSPCCND
#> 5254   SDTMIG     3.4        Findings       IS    35 ISSPCUFL
#> 5255   SDTMIG     3.4        Findings       IS    36 ISMETHOD
#> 5256   SDTMIG     3.4        Findings       IS    37 ISLOBXFL
#> 5257   SDTMIG     3.4        Findings       IS    38   ISBLFL
#> 5258   SDTMIG     3.4        Findings       IS    39  ISDRVFL
#> 5259   SDTMIG     3.4        Findings       IS    40   ISLLOQ
#> 5260   SDTMIG     3.4        Findings       IS    41 VISITNUM
#> 5261   SDTMIG     3.4        Findings       IS    42    VISIT
#> 5262   SDTMIG     3.4        Findings       IS    43  VISITDY
#> 5263   SDTMIG     3.4        Findings       IS    44  TAETORD
#> 5264   SDTMIG     3.4        Findings       IS    45    EPOCH
#> 5265   SDTMIG     3.4        Findings       IS    46    ISDTC
#> 5266   SDTMIG     3.4        Findings       IS    47  ISENDTC
#> 5267   SDTMIG     3.4        Findings       IS    48     ISDY
#> 5268   SDTMIG     3.4        Findings       IS    49   ISENDY
#> 5269   SDTMIG     3.4        Findings       IS    50    ISTPT
#> 5270   SDTMIG     3.4        Findings       IS    51 ISTPTNUM
#> 5271   SDTMIG     3.4        Findings       IS    52   ISELTM
#> 5272   SDTMIG     3.4        Findings       IS    53 ISTPTREF
#> 5273   SDTMIG     3.4        Findings       IS    54 ISRFTDTC
#> 5274   SDTMIG     3.4        Findings       LB     1  STUDYID
#> 5275   SDTMIG     3.4        Findings       LB     2   DOMAIN
#> 5276   SDTMIG     3.4        Findings       LB     3  USUBJID
#> 5277   SDTMIG     3.4        Findings       LB     4    LBSEQ
#> 5278   SDTMIG     3.4        Findings       LB     5  LBGRPID
#> 5279   SDTMIG     3.4        Findings       LB     6  LBREFID
#> 5280   SDTMIG     3.4        Findings       LB     7   LBSPID
#> 5281   SDTMIG     3.4        Findings       LB     8 LBTESTCD
#> 5282   SDTMIG     3.4        Findings       LB     9   LBTEST
#> 5283   SDTMIG     3.4        Findings       LB    10 LBTSTCND
#> 5284   SDTMIG     3.4        Findings       LB    11 LBBDAGNT
#> 5285   SDTMIG     3.4        Findings       LB    12 LBTSTOPO
#> 5286   SDTMIG     3.4        Findings       LB    13    LBCAT
#> 5287   SDTMIG     3.4        Findings       LB    14   LBSCAT
#> 5288   SDTMIG     3.4        Findings       LB    15  LBORRES
#> 5289   SDTMIG     3.4        Findings       LB    16 LBORRESU
#> 5290   SDTMIG     3.4        Findings       LB    17 LBRESSCL
#> 5291   SDTMIG     3.4        Findings       LB    18 LBRESTYP
#> 5292   SDTMIG     3.4        Findings       LB    19 LBCOLSRT
#> 5293   SDTMIG     3.4        Findings       LB    20 LBORNRLO
#> 5294   SDTMIG     3.4        Findings       LB    21 LBORNRHI
#> 5295   SDTMIG     3.4        Findings       LB    22   LBLLOD
#> 5296   SDTMIG     3.4        Findings       LB    23 LBSTRESC
#> 5297   SDTMIG     3.4        Findings       LB    24 LBSTRESN
#> 5298   SDTMIG     3.4        Findings       LB    25 LBSTRESU
#> 5299   SDTMIG     3.4        Findings       LB    26 LBSTNRLO
#> 5300   SDTMIG     3.4        Findings       LB    27 LBSTNRHI
#> 5301   SDTMIG     3.4        Findings       LB    28  LBSTNRC
#> 5302   SDTMIG     3.4        Findings       LB    29  LBNRIND
#> 5303   SDTMIG     3.4        Findings       LB    30   LBSTAT
#> 5304   SDTMIG     3.4        Findings       LB    31 LBREASND
#> 5305   SDTMIG     3.4        Findings       LB    32    LBNAM
#> 5306   SDTMIG     3.4        Findings       LB    33  LBLOINC
#> 5307   SDTMIG     3.4        Findings       LB    34   LBSPEC
#> 5308   SDTMIG     3.4        Findings       LB    35 LBSPCCND
#> 5309   SDTMIG     3.4        Findings       LB    36 LBSPCUFL
#> 5310   SDTMIG     3.4        Findings       LB    37 LBMETHOD
#> 5311   SDTMIG     3.4        Findings       LB    38 LBANMETH
#> 5312   SDTMIG     3.4        Findings       LB    39 LBTMTHSN
#> 5313   SDTMIG     3.4        Findings       LB    40 LBLOBXFL
#> 5314   SDTMIG     3.4        Findings       LB    41   LBBLFL
#> 5315   SDTMIG     3.4        Findings       LB    42   LBFAST
#> 5316   SDTMIG     3.4        Findings       LB    43  LBDRVFL
#> 5317   SDTMIG     3.4        Findings       LB    44    LBTOX
#> 5318   SDTMIG     3.4        Findings       LB    45  LBTOXGR
#> 5319   SDTMIG     3.4        Findings       LB    46  LBCLSIG
#> 5320   SDTMIG     3.4        Findings       LB    47 VISITNUM
#> 5321   SDTMIG     3.4        Findings       LB    48    VISIT
#> 5322   SDTMIG     3.4        Findings       LB    49  VISITDY
#> 5323   SDTMIG     3.4        Findings       LB    50  TAETORD
#> 5324   SDTMIG     3.4        Findings       LB    51    EPOCH
#> 5325   SDTMIG     3.4        Findings       LB    52    LBDTC
#> 5326   SDTMIG     3.4        Findings       LB    53  LBENDTC
#> 5327   SDTMIG     3.4        Findings       LB    54     LBDY
#> 5328   SDTMIG     3.4        Findings       LB    55   LBENDY
#> 5329   SDTMIG     3.4        Findings       LB    56    LBTPT
#> 5330   SDTMIG     3.4        Findings       LB    57 LBTPTNUM
#> 5331   SDTMIG     3.4        Findings       LB    58   LBELTM
#> 5332   SDTMIG     3.4        Findings       LB    59 LBTPTREF
#> 5333   SDTMIG     3.4        Findings       LB    60 LBRFTDTC
#> 5334   SDTMIG     3.4        Findings       LB    61   LBPTFL
#> 5335   SDTMIG     3.4        Findings       LB    62   LBPDUR
#> 5336   SDTMIG     3.4        Findings       MB     1  STUDYID
#> 5337   SDTMIG     3.4        Findings       MB     2   DOMAIN
#> 5338   SDTMIG     3.4        Findings       MB     3  USUBJID
#> 5339   SDTMIG     3.4        Findings       MB     4    FOCID
#> 5340   SDTMIG     3.4        Findings       MB     5    MBSEQ
#> 5341   SDTMIG     3.4        Findings       MB     6  MBGRPID
#> 5342   SDTMIG     3.4        Findings       MB     7  MBREFID
#> 5343   SDTMIG     3.4        Findings       MB     8   MBSPID
#> 5344   SDTMIG     3.4        Findings       MB     9  MBLNKID
#> 5345   SDTMIG     3.4        Findings       MB    10 MBLNKGRP
#> 5346   SDTMIG     3.4        Findings       MB    11 MBTESTCD
#> 5347   SDTMIG     3.4        Findings       MB    12   MBTEST
#> 5348   SDTMIG     3.4        Findings       MB    13 MBTSTDTL
#> 5349   SDTMIG     3.4        Findings       MB    14    MBCAT
#> 5350   SDTMIG     3.4        Findings       MB    15   MBSCAT
#> 5351   SDTMIG     3.4        Findings       MB    16  MBORRES
#> 5352   SDTMIG     3.4        Findings       MB    17 MBORRESU
#> 5353   SDTMIG     3.4        Findings       MB    18 MBSTRESC
#> 5354   SDTMIG     3.4        Findings       MB    19 MBSTRESN
#> 5355   SDTMIG     3.4        Findings       MB    20 MBSTRESU
#> 5356   SDTMIG     3.4        Findings       MB    21 MBRESCAT
#> 5357   SDTMIG     3.4        Findings       MB    22   MBSTAT
#> 5358   SDTMIG     3.4        Findings       MB    23 MBREASND
#> 5359   SDTMIG     3.4        Findings       MB    24    MBNAM
#> 5360   SDTMIG     3.4        Findings       MB    25  MBLOINC
#> 5361   SDTMIG     3.4        Findings       MB    26   MBSPEC
#> 5362   SDTMIG     3.4        Findings       MB    27 MBSPCCND
#> 5363   SDTMIG     3.4        Findings       MB    28    MBLOC
#> 5364   SDTMIG     3.4        Findings       MB    29    MBLAT
#> 5365   SDTMIG     3.4        Findings       MB    30    MBDIR
#> 5366   SDTMIG     3.4        Findings       MB    31 MBMETHOD
#> 5367   SDTMIG     3.4        Findings       MB    32 MBLOBXFL
#> 5368   SDTMIG     3.4        Findings       MB    33   MBBLFL
#> 5369   SDTMIG     3.4        Findings       MB    34   MBFAST
#> 5370   SDTMIG     3.4        Findings       MB    35  MBDRVFL
#> 5371   SDTMIG     3.4        Findings       MB    36 VISITNUM
#> 5372   SDTMIG     3.4        Findings       MB    37    VISIT
#> 5373   SDTMIG     3.4        Findings       MB    38  VISITDY
#> 5374   SDTMIG     3.4        Findings       MB    39  TAETORD
#> 5375   SDTMIG     3.4        Findings       MB    40    EPOCH
#> 5376   SDTMIG     3.4        Findings       MB    41    MBDTC
#> 5377   SDTMIG     3.4        Findings       MB    42     MBDY
#> 5378   SDTMIG     3.4        Findings       MB    43    MBTPT
#> 5379   SDTMIG     3.4        Findings       MB    44 MBTPTNUM
#> 5380   SDTMIG     3.4        Findings       MB    45   MBELTM
#> 5381   SDTMIG     3.4        Findings       MB    46 MBTPTREF
#> 5382   SDTMIG     3.4        Findings       MB    47 MBRFTDTC
#> 5383   SDTMIG     3.4        Findings       MI     1  STUDYID
#> 5384   SDTMIG     3.4        Findings       MI     2   DOMAIN
#> 5385   SDTMIG     3.4        Findings       MI     3  USUBJID
#> 5386   SDTMIG     3.4        Findings       MI     4    MISEQ
#> 5387   SDTMIG     3.4        Findings       MI     5  MIGRPID
#> 5388   SDTMIG     3.4        Findings       MI     6  MIREFID
#> 5389   SDTMIG     3.4        Findings       MI     7   MISPID
#> 5390   SDTMIG     3.4        Findings       MI     8 MITESTCD
#> 5391   SDTMIG     3.4        Findings       MI     9   MITEST
#> 5392   SDTMIG     3.4        Findings       MI    10 MITSTDTL
#> 5393   SDTMIG     3.4        Findings       MI    11    MICAT
#> 5394   SDTMIG     3.4        Findings       MI    12   MISCAT
#> 5395   SDTMIG     3.4        Findings       MI    13  MIORRES
#> 5396   SDTMIG     3.4        Findings       MI    14 MIORRESU
#> 5397   SDTMIG     3.4        Findings       MI    15 MISTRESC
#> 5398   SDTMIG     3.4        Findings       MI    16 MISTRESN
#> 5399   SDTMIG     3.4        Findings       MI    17 MISTRESU
#> 5400   SDTMIG     3.4        Findings       MI    18 MIRESCAT
#> 5401   SDTMIG     3.4        Findings       MI    19   MISTAT
#> 5402   SDTMIG     3.4        Findings       MI    20 MIREASND
#> 5403   SDTMIG     3.4        Findings       MI    21    MINAM
#> 5404   SDTMIG     3.4        Findings       MI    22   MISPEC
#> 5405   SDTMIG     3.4        Findings       MI    23 MISPCCND
#> 5406   SDTMIG     3.4        Findings       MI    24    MILOC
#> 5407   SDTMIG     3.4        Findings       MI    25    MILAT
#> 5408   SDTMIG     3.4        Findings       MI    26    MIDIR
#> 5409   SDTMIG     3.4        Findings       MI    27 MIMETHOD
#> 5410   SDTMIG     3.4        Findings       MI    28 MILOBXFL
#> 5411   SDTMIG     3.4        Findings       MI    29   MIBLFL
#> 5412   SDTMIG     3.4        Findings       MI    30   MIEVAL
#> 5413   SDTMIG     3.4        Findings       MI    31 VISITNUM
#> 5414   SDTMIG     3.4        Findings       MI    32    VISIT
#> 5415   SDTMIG     3.4        Findings       MI    33  VISITDY
#> 5416   SDTMIG     3.4        Findings       MI    34  TAETORD
#> 5417   SDTMIG     3.4        Findings       MI    35    EPOCH
#> 5418   SDTMIG     3.4        Findings       MI    36    MIDTC
#> 5419   SDTMIG     3.4        Findings       MI    37     MIDY
#> 5420   SDTMIG     3.4        Findings       MK     1  STUDYID
#> 5421   SDTMIG     3.4        Findings       MK     2   DOMAIN
#> 5422   SDTMIG     3.4        Findings       MK     3  USUBJID
#> 5423   SDTMIG     3.4        Findings       MK     4    MKSEQ
#> 5424   SDTMIG     3.4        Findings       MK     5  MKGRPID
#> 5425   SDTMIG     3.4        Findings       MK     6  MKREFID
#> 5426   SDTMIG     3.4        Findings       MK     7   MKSPID
#> 5427   SDTMIG     3.4        Findings       MK     8  MKLNKID
#> 5428   SDTMIG     3.4        Findings       MK     9 MKLNKGRP
#> 5429   SDTMIG     3.4        Findings       MK    10 MKTESTCD
#> 5430   SDTMIG     3.4        Findings       MK    11   MKTEST
#> 5431   SDTMIG     3.4        Findings       MK    12    MKCAT
#> 5432   SDTMIG     3.4        Findings       MK    13   MKSCAT
#> 5433   SDTMIG     3.4        Findings       MK    14    MKPOS
#> 5434   SDTMIG     3.4        Findings       MK    15  MKORRES
#> 5435   SDTMIG     3.4        Findings       MK    16 MKORRESU
#> 5436   SDTMIG     3.4        Findings       MK    17 MKSTRESC
#> 5437   SDTMIG     3.4        Findings       MK    18 MKSTRESN
#> 5438   SDTMIG     3.4        Findings       MK    19 MKSTRESU
#> 5439   SDTMIG     3.4        Findings       MK    20   MKSTAT
#> 5440   SDTMIG     3.4        Findings       MK    21 MKREASND
#> 5441   SDTMIG     3.4        Findings       MK    22    MKLOC
#> 5442   SDTMIG     3.4        Findings       MK    23    MKLAT
#> 5443   SDTMIG     3.4        Findings       MK    24    MKDIR
#> 5444   SDTMIG     3.4        Findings       MK    25 MKMETHOD
#> 5445   SDTMIG     3.4        Findings       MK    26 MKLOBXFL
#> 5446   SDTMIG     3.4        Findings       MK    27   MKBLFL
#> 5447   SDTMIG     3.4        Findings       MK    28  MKDRVFL
#> 5448   SDTMIG     3.4        Findings       MK    29   MKEVAL
#> 5449   SDTMIG     3.4        Findings       MK    30 MKEVALID
#> 5450   SDTMIG     3.4        Findings       MK    31 VISITNUM
#> 5451   SDTMIG     3.4        Findings       MK    32    VISIT
#> 5452   SDTMIG     3.4        Findings       MK    33  VISITDY
#> 5453   SDTMIG     3.4        Findings       MK    34  TAETORD
#> 5454   SDTMIG     3.4        Findings       MK    35    EPOCH
#> 5455   SDTMIG     3.4        Findings       MK    36    MKDTC
#> 5456   SDTMIG     3.4        Findings       MK    37     MKDY
#> 5457   SDTMIG     3.4        Findings       MK    38    MKTPT
#> 5458   SDTMIG     3.4        Findings       MK    39 MKTPTNUM
#> 5459   SDTMIG     3.4        Findings       MK    40   MKELTM
#> 5460   SDTMIG     3.4        Findings       MK    41 MKTPTREF
#> 5461   SDTMIG     3.4        Findings       MK    42 MKRFTDTC
#> 5462   SDTMIG     3.4        Findings       MS     1  STUDYID
#> 5463   SDTMIG     3.4        Findings       MS     2   DOMAIN
#> 5464   SDTMIG     3.4        Findings       MS     3  USUBJID
#> 5465   SDTMIG     3.4        Findings       MS     4    NHOID
#> 5466   SDTMIG     3.4        Findings       MS     5    MSSEQ
#> 5467   SDTMIG     3.4        Findings       MS     6  MSGRPID
#> 5468   SDTMIG     3.4        Findings       MS     7  MSREFID
#> 5469   SDTMIG     3.4        Findings       MS     8   MSSPID
#> 5470   SDTMIG     3.4        Findings       MS     9  MSLNKID
#> 5471   SDTMIG     3.4        Findings       MS    10 MSTESTCD
#> 5472   SDTMIG     3.4        Findings       MS    11   MSTEST
#> 5473   SDTMIG     3.4        Findings       MS    12  MSAGENT
#> 5474   SDTMIG     3.4        Findings       MS    13   MSCONC
#> 5475   SDTMIG     3.4        Findings       MS    14  MSCONCU
#> 5476   SDTMIG     3.4        Findings       MS    15 MSTSTDTL
#> 5477   SDTMIG     3.4        Findings       MS    16    MSCAT
#> 5478   SDTMIG     3.4        Findings       MS    17   MSSCAT
#> 5479   SDTMIG     3.4        Findings       MS    18  MSORRES
#> 5480   SDTMIG     3.4        Findings       MS    19 MSORRESU
#> 5481   SDTMIG     3.4        Findings       MS    20 MSSTRESC
#> 5482   SDTMIG     3.4        Findings       MS    21 MSSTRESN
#> 5483   SDTMIG     3.4        Findings       MS    22 MSSTRESU
#> 5484   SDTMIG     3.4        Findings       MS    23  MSNRIND
#> 5485   SDTMIG     3.4        Findings       MS    24 MSRESCAT
#> 5486   SDTMIG     3.4        Findings       MS    25   MSSTAT
#> 5487   SDTMIG     3.4        Findings       MS    26 MSREASND
#> 5488   SDTMIG     3.4        Findings       MS    27    MSXFN
#> 5489   SDTMIG     3.4        Findings       MS    28    MSNAM
#> 5490   SDTMIG     3.4        Findings       MS    29  MSLOINC
#> 5491   SDTMIG     3.4        Findings       MS    30   MSSPEC
#> 5492   SDTMIG     3.4        Findings       MS    31 MSSPCCND
#> 5493   SDTMIG     3.4        Findings       MS    32    MSLOC
#> 5494   SDTMIG     3.4        Findings       MS    33    MSLAT
#> 5495   SDTMIG     3.4        Findings       MS    34    MSDIR
#> 5496   SDTMIG     3.4        Findings       MS    35 MSMETHOD
#> 5497   SDTMIG     3.4        Findings       MS    36 MSANMETH
#> 5498   SDTMIG     3.4        Findings       MS    37 MSLOBXFL
#> 5499   SDTMIG     3.4        Findings       MS    38   MSBLFL
#> 5500   SDTMIG     3.4        Findings       MS    39   MSFAST
#> 5501   SDTMIG     3.4        Findings       MS    40  MSDRVFL
#> 5502   SDTMIG     3.4        Findings       MS    41   MSEVAL
#> 5503   SDTMIG     3.4        Findings       MS    42 MSEVALID
#> 5504   SDTMIG     3.4        Findings       MS    43 MSACPTFL
#> 5505   SDTMIG     3.4        Findings       MS    44   MSLLOQ
#> 5506   SDTMIG     3.4        Findings       MS    45   MSULOQ
#> 5507   SDTMIG     3.4        Findings       MS    46 MSREPNUM
#> 5508   SDTMIG     3.4        Findings       MS    47 VISITNUM
#> 5509   SDTMIG     3.4        Findings       MS    48    VISIT
#> 5510   SDTMIG     3.4        Findings       MS    49  VISITDY
#> 5511   SDTMIG     3.4        Findings       MS    50  TAETORD
#> 5512   SDTMIG     3.4        Findings       MS    51    EPOCH
#> 5513   SDTMIG     3.4        Findings       MS    52    MSDTC
#> 5514   SDTMIG     3.4        Findings       MS    53     MSDY
#> 5515   SDTMIG     3.4        Findings       MS    54    MSDUR
#> 5516   SDTMIG     3.4        Findings       MS    55    MSTPT
#> 5517   SDTMIG     3.4        Findings       MS    56 MSTPTNUM
#> 5518   SDTMIG     3.4        Findings       MS    57   MSELTM
#> 5519   SDTMIG     3.4        Findings       MS    58 MSTPTREF
#> 5520   SDTMIG     3.4        Findings       MS    59 MSRFTDTC
#> 5521   SDTMIG     3.4        Findings       MS    60 MSEVLINT
#> 5522   SDTMIG     3.4        Findings       MS    61 MSEVINTX
#> 5523   SDTMIG     3.4        Findings       NV     1  STUDYID
#> 5524   SDTMIG     3.4        Findings       NV     2   DOMAIN
#> 5525   SDTMIG     3.4        Findings       NV     3  USUBJID
#> 5526   SDTMIG     3.4        Findings       NV     4    FOCID
#> 5527   SDTMIG     3.4        Findings       NV     5    NVSEQ
#> 5528   SDTMIG     3.4        Findings       NV     6  NVGRPID
#> 5529   SDTMIG     3.4        Findings       NV     7  NVREFID
#> 5530   SDTMIG     3.4        Findings       NV     8   NVSPID
#> 5531   SDTMIG     3.4        Findings       NV     9  NVLNKID
#> 5532   SDTMIG     3.4        Findings       NV    10 NVLNKGRP
#> 5533   SDTMIG     3.4        Findings       NV    11 NVTESTCD
#> 5534   SDTMIG     3.4        Findings       NV    12   NVTEST
#> 5535   SDTMIG     3.4        Findings       NV    13    NVCAT
#> 5536   SDTMIG     3.4        Findings       NV    14   NVSCAT
#> 5537   SDTMIG     3.4        Findings       NV    15  NVORRES
#> 5538   SDTMIG     3.4        Findings       NV    16 NVORRESU
#> 5539   SDTMIG     3.4        Findings       NV    17 NVSTRESC
#> 5540   SDTMIG     3.4        Findings       NV    18 NVSTRESN
#> 5541   SDTMIG     3.4        Findings       NV    19 NVSTRESU
#> 5542   SDTMIG     3.4        Findings       NV    20   NVSTAT
#> 5543   SDTMIG     3.4        Findings       NV    21 NVREASND
#> 5544   SDTMIG     3.4        Findings       NV    22    NVLOC
#> 5545   SDTMIG     3.4        Findings       NV    23    NVLAT
#> 5546   SDTMIG     3.4        Findings       NV    24    NVDIR
#> 5547   SDTMIG     3.4        Findings       NV    25 NVMETHOD
#> 5548   SDTMIG     3.4        Findings       NV    26 NVLOBXFL
#> 5549   SDTMIG     3.4        Findings       NV    27   NVBLFL
#> 5550   SDTMIG     3.4        Findings       NV    28  NVDRVFL
#> 5551   SDTMIG     3.4        Findings       NV    29   NVEVAL
#> 5552   SDTMIG     3.4        Findings       NV    30 NVEVALID
#> 5553   SDTMIG     3.4        Findings       NV    31 VISITNUM
#> 5554   SDTMIG     3.4        Findings       NV    32    VISIT
#> 5555   SDTMIG     3.4        Findings       NV    33  VISITDY
#> 5556   SDTMIG     3.4        Findings       NV    34  TAETORD
#> 5557   SDTMIG     3.4        Findings       NV    35    EPOCH
#> 5558   SDTMIG     3.4        Findings       NV    36    NVDTC
#> 5559   SDTMIG     3.4        Findings       NV    37     NVDY
#> 5560   SDTMIG     3.4        Findings       NV    38    NVTPT
#> 5561   SDTMIG     3.4        Findings       NV    39 NVTPTNUM
#> 5562   SDTMIG     3.4        Findings       NV    40   NVELTM
#> 5563   SDTMIG     3.4        Findings       NV    41 NVTPTREF
#> 5564   SDTMIG     3.4        Findings       NV    42 NVRFTDTC
#> 5565   SDTMIG     3.4        Findings       OE     1  STUDYID
#> 5566   SDTMIG     3.4        Findings       OE     2   DOMAIN
#> 5567   SDTMIG     3.4        Findings       OE     3  USUBJID
#> 5568   SDTMIG     3.4        Findings       OE     4    FOCID
#> 5569   SDTMIG     3.4        Findings       OE     5    OESEQ
#> 5570   SDTMIG     3.4        Findings       OE     6  OEGRPID
#> 5571   SDTMIG     3.4        Findings       OE     7  OELNKID
#> 5572   SDTMIG     3.4        Findings       OE     8 OELNKGRP
#> 5573   SDTMIG     3.4        Findings       OE     9 OETESTCD
#> 5574   SDTMIG     3.4        Findings       OE    10   OETEST
#> 5575   SDTMIG     3.4        Findings       OE    11 OETSTDTL
#> 5576   SDTMIG     3.4        Findings       OE    12    OECAT
#> 5577   SDTMIG     3.4        Findings       OE    13   OESCAT
#> 5578   SDTMIG     3.4        Findings       OE    14  OEORRES
#> 5579   SDTMIG     3.4        Findings       OE    15 OEORRESU
#> 5580   SDTMIG     3.4        Findings       OE    16 OEORNRLO
#> 5581   SDTMIG     3.4        Findings       OE    17 OEORNRHI
#> 5582   SDTMIG     3.4        Findings       OE    18 OESTRESC
#> 5583   SDTMIG     3.4        Findings       OE    19 OESTRESN
#> 5584   SDTMIG     3.4        Findings       OE    20 OESTRESU
#> 5585   SDTMIG     3.4        Findings       OE    21 OESTNRLO
#> 5586   SDTMIG     3.4        Findings       OE    22 OESTNRHI
#> 5587   SDTMIG     3.4        Findings       OE    23  OESTNRC
#> 5588   SDTMIG     3.4        Findings       OE    24  OENRIND
#> 5589   SDTMIG     3.4        Findings       OE    25 OERESCAT
#> 5590   SDTMIG     3.4        Findings       OE    26   OESTAT
#> 5591   SDTMIG     3.4        Findings       OE    27 OEREASND
#> 5592   SDTMIG     3.4        Findings       OE    28    OEXFN
#> 5593   SDTMIG     3.4        Findings       OE    29    OELOC
#> 5594   SDTMIG     3.4        Findings       OE    30    OELAT
#> 5595   SDTMIG     3.4        Findings       OE    31    OEDIR
#> 5596   SDTMIG     3.4        Findings       OE    32 OEPORTOT
#> 5597   SDTMIG     3.4        Findings       OE    33 OEMETHOD
#> 5598   SDTMIG     3.4        Findings       OE    34 OELOBXFL
#> 5599   SDTMIG     3.4        Findings       OE    35   OEBLFL
#> 5600   SDTMIG     3.4        Findings       OE    36  OEDRVFL
#> 5601   SDTMIG     3.4        Findings       OE    37   OEEVAL
#> 5602   SDTMIG     3.4        Findings       OE    38 OEEVALID
#> 5603   SDTMIG     3.4        Findings       OE    39 OEACPTFL
#> 5604   SDTMIG     3.4        Findings       OE    40 OEREPNUM
#> 5605   SDTMIG     3.4        Findings       OE    41 VISITNUM
#> 5606   SDTMIG     3.4        Findings       OE    42    VISIT
#> 5607   SDTMIG     3.4        Findings       OE    43  VISITDY
#> 5608   SDTMIG     3.4        Findings       OE    44  TAETORD
#> 5609   SDTMIG     3.4        Findings       OE    45    EPOCH
#> 5610   SDTMIG     3.4        Findings       OE    46    OEDTC
#> 5611   SDTMIG     3.4        Findings       OE    47     OEDY
#> 5612   SDTMIG     3.4        Findings       OE    48    OETPT
#> 5613   SDTMIG     3.4        Findings       OE    49 OETPTNUM
#> 5614   SDTMIG     3.4        Findings       OE    50   OEELTM
#> 5615   SDTMIG     3.4        Findings       OE    51 OETPTREF
#> 5616   SDTMIG     3.4        Findings       OE    52 OERFTDTC
#> 5617   SDTMIG     3.4        Findings       PC     1  STUDYID
#> 5618   SDTMIG     3.4        Findings       PC     2   DOMAIN
#> 5619   SDTMIG     3.4        Findings       PC     3  USUBJID
#> 5620   SDTMIG     3.4        Findings       PC     4    PCSEQ
#> 5621   SDTMIG     3.4        Findings       PC     5  PCGRPID
#> 5622   SDTMIG     3.4        Findings       PC     6  PCREFID
#> 5623   SDTMIG     3.4        Findings       PC     7   PCSPID
#> 5624   SDTMIG     3.4        Findings       PC     8 PCTESTCD
#> 5625   SDTMIG     3.4        Findings       PC     9   PCTEST
#> 5626   SDTMIG     3.4        Findings       PC    10    PCCAT
#> 5627   SDTMIG     3.4        Findings       PC    11   PCSCAT
#> 5628   SDTMIG     3.4        Findings       PC    12  PCORRES
#> 5629   SDTMIG     3.4        Findings       PC    13 PCORRESU
#> 5630   SDTMIG     3.4        Findings       PC    14 PCSTRESC
#> 5631   SDTMIG     3.4        Findings       PC    15 PCSTRESN
#> 5632   SDTMIG     3.4        Findings       PC    16 PCSTRESU
#> 5633   SDTMIG     3.4        Findings       PC    17   PCSTAT
#> 5634   SDTMIG     3.4        Findings       PC    18 PCREASND
#> 5635   SDTMIG     3.4        Findings       PC    19    PCNAM
#> 5636   SDTMIG     3.4        Findings       PC    20   PCSPEC
#> 5637   SDTMIG     3.4        Findings       PC    21 PCSPCCND
#> 5638   SDTMIG     3.4        Findings       PC    22 PCMETHOD
#> 5639   SDTMIG     3.4        Findings       PC    23   PCFAST
#> 5640   SDTMIG     3.4        Findings       PC    24  PCDRVFL
#> 5641   SDTMIG     3.4        Findings       PC    25   PCLLOQ
#> 5642   SDTMIG     3.4        Findings       PC    26   PCULOQ
#> 5643   SDTMIG     3.4        Findings       PC    27 VISITNUM
#> 5644   SDTMIG     3.4        Findings       PC    28    VISIT
#> 5645   SDTMIG     3.4        Findings       PC    29  VISITDY
#> 5646   SDTMIG     3.4        Findings       PC    30  TAETORD
#> 5647   SDTMIG     3.4        Findings       PC    31    EPOCH
#> 5648   SDTMIG     3.4        Findings       PC    32    PCDTC
#> 5649   SDTMIG     3.4        Findings       PC    33  PCENDTC
#> 5650   SDTMIG     3.4        Findings       PC    34     PCDY
#> 5651   SDTMIG     3.4        Findings       PC    35   PCENDY
#> 5652   SDTMIG     3.4        Findings       PC    36    PCTPT
#> 5653   SDTMIG     3.4        Findings       PC    37 PCTPTNUM
#> 5654   SDTMIG     3.4        Findings       PC    38   PCELTM
#> 5655   SDTMIG     3.4        Findings       PC    39 PCTPTREF
#> 5656   SDTMIG     3.4        Findings       PC    40 PCRFTDTC
#> 5657   SDTMIG     3.4        Findings       PC    41 PCEVLINT
#> 5658   SDTMIG     3.4        Findings       PE     1  STUDYID
#> 5659   SDTMIG     3.4        Findings       PE     2   DOMAIN
#> 5660   SDTMIG     3.4        Findings       PE     3  USUBJID
#> 5661   SDTMIG     3.4        Findings       PE     4    PESEQ
#> 5662   SDTMIG     3.4        Findings       PE     5  PEGRPID
#> 5663   SDTMIG     3.4        Findings       PE     6   PESPID
#> 5664   SDTMIG     3.4        Findings       PE     7 PETESTCD
#> 5665   SDTMIG     3.4        Findings       PE     8   PETEST
#> 5666   SDTMIG     3.4        Findings       PE     9 PEMODIFY
#> 5667   SDTMIG     3.4        Findings       PE    10    PECAT
#> 5668   SDTMIG     3.4        Findings       PE    11   PESCAT
#> 5669   SDTMIG     3.4        Findings       PE    12 PEBODSYS
#> 5670   SDTMIG     3.4        Findings       PE    13  PEORRES
#> 5671   SDTMIG     3.4        Findings       PE    14 PEORRESU
#> 5672   SDTMIG     3.4        Findings       PE    15 PESTRESC
#> 5673   SDTMIG     3.4        Findings       PE    16   PESTAT
#> 5674   SDTMIG     3.4        Findings       PE    17 PEREASND
#> 5675   SDTMIG     3.4        Findings       PE    18    PELOC
#> 5676   SDTMIG     3.4        Findings       PE    19    PELAT
#> 5677   SDTMIG     3.4        Findings       PE    20 PEMETHOD
#> 5678   SDTMIG     3.4        Findings       PE    21 PELOBXFL
#> 5679   SDTMIG     3.4        Findings       PE    22   PEBLFL
#> 5680   SDTMIG     3.4        Findings       PE    23   PEEVAL
#> 5681   SDTMIG     3.4        Findings       PE    24 VISITNUM
#> 5682   SDTMIG     3.4        Findings       PE    25    VISIT
#> 5683   SDTMIG     3.4        Findings       PE    26  VISITDY
#> 5684   SDTMIG     3.4        Findings       PE    27  TAETORD
#> 5685   SDTMIG     3.4        Findings       PE    28    EPOCH
#> 5686   SDTMIG     3.4        Findings       PE    29    PEDTC
#> 5687   SDTMIG     3.4        Findings       PE    30     PEDY
#> 5688   SDTMIG     3.4        Findings       PP     1  STUDYID
#> 5689   SDTMIG     3.4        Findings       PP     2   DOMAIN
#> 5690   SDTMIG     3.4        Findings       PP     3  USUBJID
#> 5691   SDTMIG     3.4        Findings       PP     4    PPSEQ
#> 5692   SDTMIG     3.4        Findings       PP     5  PPGRPID
#> 5693   SDTMIG     3.4        Findings       PP     6 PPTESTCD
#> 5694   SDTMIG     3.4        Findings       PP     7   PPTEST
#> 5695   SDTMIG     3.4        Findings       PP     8    PPCAT
#> 5696   SDTMIG     3.4        Findings       PP     9   PPSCAT
#> 5697   SDTMIG     3.4        Findings       PP    10  PPORRES
#> 5698   SDTMIG     3.4        Findings       PP    11 PPORRESU
#> 5699   SDTMIG     3.4        Findings       PP    12 PPSTRESC
#> 5700   SDTMIG     3.4        Findings       PP    13 PPSTRESN
#> 5701   SDTMIG     3.4        Findings       PP    14 PPSTRESU
#> 5702   SDTMIG     3.4        Findings       PP    15   PPSTAT
#> 5703   SDTMIG     3.4        Findings       PP    16 PPREASND
#> 5704   SDTMIG     3.4        Findings       PP    17   PPSPEC
#> 5705   SDTMIG     3.4        Findings       PP    18 PPANMETH
#> 5706   SDTMIG     3.4        Findings       PP    19  TAETORD
#> 5707   SDTMIG     3.4        Findings       PP    20    EPOCH
#> 5708   SDTMIG     3.4        Findings       PP    21    PPDTC
#> 5709   SDTMIG     3.4        Findings       PP    22     PPDY
#> 5710   SDTMIG     3.4        Findings       PP    23 PPTPTREF
#> 5711   SDTMIG     3.4        Findings       PP    24 PPRFTDTC
#> 5712   SDTMIG     3.4        Findings       PP    25  PPSTINT
#> 5713   SDTMIG     3.4        Findings       PP    26  PPENINT
#> 5714   SDTMIG     3.4        Findings       QS     1  STUDYID
#> 5715   SDTMIG     3.4        Findings       QS     2   DOMAIN
#> 5716   SDTMIG     3.4        Findings       QS     3  USUBJID
#> 5717   SDTMIG     3.4        Findings       QS     4    QSSEQ
#> 5718   SDTMIG     3.4        Findings       QS     5  QSGRPID
#> 5719   SDTMIG     3.4        Findings       QS     6   QSSPID
#> 5720   SDTMIG     3.4        Findings       QS     7 QSTESTCD
#> 5721   SDTMIG     3.4        Findings       QS     8   QSTEST
#> 5722   SDTMIG     3.4        Findings       QS     9    QSCAT
#> 5723   SDTMIG     3.4        Findings       QS    10   QSSCAT
#> 5724   SDTMIG     3.4        Findings       QS    11  QSORRES
#> 5725   SDTMIG     3.4        Findings       QS    12 QSORRESU
#> 5726   SDTMIG     3.4        Findings       QS    13 QSSTRESC
#> 5727   SDTMIG     3.4        Findings       QS    14 QSSTRESN
#> 5728   SDTMIG     3.4        Findings       QS    15 QSSTRESU
#> 5729   SDTMIG     3.4        Findings       QS    16   QSSTAT
#> 5730   SDTMIG     3.4        Findings       QS    17 QSREASND
#> 5731   SDTMIG     3.4        Findings       QS    18 QSMETHOD
#> 5732   SDTMIG     3.4        Findings       QS    19 QSLOBXFL
#> 5733   SDTMIG     3.4        Findings       QS    20   QSBLFL
#> 5734   SDTMIG     3.4        Findings       QS    21  QSDRVFL
#> 5735   SDTMIG     3.4        Findings       QS    22 VISITNUM
#> 5736   SDTMIG     3.4        Findings       QS    23    VISIT
#> 5737   SDTMIG     3.4        Findings       QS    24  VISITDY
#> 5738   SDTMIG     3.4        Findings       QS    25  TAETORD
#> 5739   SDTMIG     3.4        Findings       QS    26    EPOCH
#> 5740   SDTMIG     3.4        Findings       QS    27    QSDTC
#> 5741   SDTMIG     3.4        Findings       QS    28     QSDY
#> 5742   SDTMIG     3.4        Findings       QS    29    QSTPT
#> 5743   SDTMIG     3.4        Findings       QS    30 QSTPTNUM
#> 5744   SDTMIG     3.4        Findings       QS    31   QSELTM
#> 5745   SDTMIG     3.4        Findings       QS    32 QSTPTREF
#> 5746   SDTMIG     3.4        Findings       QS    33 QSRFTDTC
#> 5747   SDTMIG     3.4        Findings       QS    34 QSEVLINT
#> 5748   SDTMIG     3.4        Findings       QS    35 QSEVINTX
#> 5749   SDTMIG     3.4        Findings       RE     1  STUDYID
#> 5750   SDTMIG     3.4        Findings       RE     2   DOMAIN
#> 5751   SDTMIG     3.4        Findings       RE     3  USUBJID
#> 5752   SDTMIG     3.4        Findings       RE     4  SPDEVID
#> 5753   SDTMIG     3.4        Findings       RE     5    RESEQ
#> 5754   SDTMIG     3.4        Findings       RE     6  REGRPID
#> 5755   SDTMIG     3.4        Findings       RE     7  REREFID
#> 5756   SDTMIG     3.4        Findings       RE     8   RESPID
#> 5757   SDTMIG     3.4        Findings       RE     9  RELNKID
#> 5758   SDTMIG     3.4        Findings       RE    10 RELNKGRP
#> 5759   SDTMIG     3.4        Findings       RE    11 RETESTCD
#> 5760   SDTMIG     3.4        Findings       RE    12   RETEST
#> 5761   SDTMIG     3.4        Findings       RE    13    RECAT
#> 5762   SDTMIG     3.4        Findings       RE    14   RESCAT
#> 5763   SDTMIG     3.4        Findings       RE    15    REPOS
#> 5764   SDTMIG     3.4        Findings       RE    16  REORRES
#> 5765   SDTMIG     3.4        Findings       RE    17 REORRESU
#> 5766   SDTMIG     3.4        Findings       RE    18  REORREF
#> 5767   SDTMIG     3.4        Findings       RE    19 RESTRESC
#> 5768   SDTMIG     3.4        Findings       RE    20 RESTRESN
#> 5769   SDTMIG     3.4        Findings       RE    21 RESTRESU
#> 5770   SDTMIG     3.4        Findings       RE    22 RESTREFC
#> 5771   SDTMIG     3.4        Findings       RE    23 RESTREFN
#> 5772   SDTMIG     3.4        Findings       RE    24   RESTAT
#> 5773   SDTMIG     3.4        Findings       RE    25 REREASND
#> 5774   SDTMIG     3.4        Findings       RE    26    RELOC
#> 5775   SDTMIG     3.4        Findings       RE    27    RELAT
#> 5776   SDTMIG     3.4        Findings       RE    28    REDIR
#> 5777   SDTMIG     3.4        Findings       RE    29 REMETHOD
#> 5778   SDTMIG     3.4        Findings       RE    30 RELOBXFL
#> 5779   SDTMIG     3.4        Findings       RE    31   REBLFL
#> 5780   SDTMIG     3.4        Findings       RE    32  REDRVFL
#> 5781   SDTMIG     3.4        Findings       RE    33   REEVAL
#> 5782   SDTMIG     3.4        Findings       RE    34 REEVALID
#> 5783   SDTMIG     3.4        Findings       RE    35 REREPNUM
#> 5784   SDTMIG     3.4        Findings       RE    36 VISITNUM
#> 5785   SDTMIG     3.4        Findings       RE    37    VISIT
#> 5786   SDTMIG     3.4        Findings       RE    38  VISITDY
#> 5787   SDTMIG     3.4        Findings       RE    39  TAETORD
#> 5788   SDTMIG     3.4        Findings       RE    40    EPOCH
#> 5789   SDTMIG     3.4        Findings       RE    41    REDTC
#> 5790   SDTMIG     3.4        Findings       RE    42     REDY
#> 5791   SDTMIG     3.4        Findings       RE    43    RETPT
#> 5792   SDTMIG     3.4        Findings       RE    44 RETPTNUM
#> 5793   SDTMIG     3.4        Findings       RE    45   REELTM
#> 5794   SDTMIG     3.4        Findings       RE    46 RETPTREF
#> 5795   SDTMIG     3.4        Findings       RE    47 RERFTDTC
#> 5796   SDTMIG     3.4        Findings       RP     1  STUDYID
#> 5797   SDTMIG     3.4        Findings       RP     2   DOMAIN
#> 5798   SDTMIG     3.4        Findings       RP     3  USUBJID
#> 5799   SDTMIG     3.4        Findings       RP     4    RPSEQ
#> 5800   SDTMIG     3.4        Findings       RP     5  RPGRPID
#> 5801   SDTMIG     3.4        Findings       RP     6  RPREFID
#> 5802   SDTMIG     3.4        Findings       RP     7   RPSPID
#> 5803   SDTMIG     3.4        Findings       RP     8  RPLNKID
#> 5804   SDTMIG     3.4        Findings       RP     9 RPLNKGRP
#> 5805   SDTMIG     3.4        Findings       RP    10 RPTESTCD
#> 5806   SDTMIG     3.4        Findings       RP    11   RPTEST
#> 5807   SDTMIG     3.4        Findings       RP    12    RPCAT
#> 5808   SDTMIG     3.4        Findings       RP    13   RPSCAT
#> 5809   SDTMIG     3.4        Findings       RP    14  RPORRES
#> 5810   SDTMIG     3.4        Findings       RP    15 RPORRESU
#> 5811   SDTMIG     3.4        Findings       RP    16 RPSTRESC
#> 5812   SDTMIG     3.4        Findings       RP    17 RPSTRESN
#> 5813   SDTMIG     3.4        Findings       RP    18 RPSTRESU
#> 5814   SDTMIG     3.4        Findings       RP    19   RPSTAT
#> 5815   SDTMIG     3.4        Findings       RP    20 RPREASND
#> 5816   SDTMIG     3.4        Findings       RP    21 RPLOBXFL
#> 5817   SDTMIG     3.4        Findings       RP    22   RPBLFL
#> 5818   SDTMIG     3.4        Findings       RP    23  RPDRVFL
#> 5819   SDTMIG     3.4        Findings       RP    24 VISITNUM
#> 5820   SDTMIG     3.4        Findings       RP    25    VISIT
#> 5821   SDTMIG     3.4        Findings       RP    26  VISITDY
#> 5822   SDTMIG     3.4        Findings       RP    27  TAETORD
#> 5823   SDTMIG     3.4        Findings       RP    28    EPOCH
#> 5824   SDTMIG     3.4        Findings       RP    29    RPDTC
#> 5825   SDTMIG     3.4        Findings       RP    30     RPDY
#> 5826   SDTMIG     3.4        Findings       RP    31    RPDUR
#> 5827   SDTMIG     3.4        Findings       RP    32    RPTPT
#> 5828   SDTMIG     3.4        Findings       RP    33 RPTPTNUM
#> 5829   SDTMIG     3.4        Findings       RP    34   RPELTM
#> 5830   SDTMIG     3.4        Findings       RP    35 RPTPTREF
#> 5831   SDTMIG     3.4        Findings       RP    36 RPRFTDTC
#> 5832   SDTMIG     3.4        Findings       RS     1  STUDYID
#> 5833   SDTMIG     3.4        Findings       RS     2   DOMAIN
#> 5834   SDTMIG     3.4        Findings       RS     3  USUBJID
#> 5835   SDTMIG     3.4        Findings       RS     4    RSSEQ
#> 5836   SDTMIG     3.4        Findings       RS     5  RSGRPID
#> 5837   SDTMIG     3.4        Findings       RS     6  RSREFID
#> 5838   SDTMIG     3.4        Findings       RS     7   RSSPID
#> 5839   SDTMIG     3.4        Findings       RS     8  RSLNKID
#> 5840   SDTMIG     3.4        Findings       RS     9 RSLNKGRP
#> 5841   SDTMIG     3.4        Findings       RS    10 RSTESTCD
#> 5842   SDTMIG     3.4        Findings       RS    11   RSTEST
#> 5843   SDTMIG     3.4        Findings       RS    12    RSCAT
#> 5844   SDTMIG     3.4        Findings       RS    13   RSSCAT
#> 5845   SDTMIG     3.4        Findings       RS    14  RSORRES
#> 5846   SDTMIG     3.4        Findings       RS    15 RSORRESU
#> 5847   SDTMIG     3.4        Findings       RS    16 RSSTRESC
#> 5848   SDTMIG     3.4        Findings       RS    17 RSSTRESN
#> 5849   SDTMIG     3.4        Findings       RS    18 RSSTRESU
#> 5850   SDTMIG     3.4        Findings       RS    19   RSSTAT
#> 5851   SDTMIG     3.4        Findings       RS    20 RSREASND
#> 5852   SDTMIG     3.4        Findings       RS    21    RSNAM
#> 5853   SDTMIG     3.4        Findings       RS    22 RSMETHOD
#> 5854   SDTMIG     3.4        Findings       RS    23 RSLOBXFL
#> 5855   SDTMIG     3.4        Findings       RS    24   RSBLFL
#> 5856   SDTMIG     3.4        Findings       RS    25  RSDRVFL
#> 5857   SDTMIG     3.4        Findings       RS    26   RSEVAL
#> 5858   SDTMIG     3.4        Findings       RS    27 RSEVALID
#> 5859   SDTMIG     3.4        Findings       RS    28 RSACPTFL
#> 5860   SDTMIG     3.4        Findings       RS    29 VISITNUM
#> 5861   SDTMIG     3.4        Findings       RS    30    VISIT
#> 5862   SDTMIG     3.4        Findings       RS    31  VISITDY
#> 5863   SDTMIG     3.4        Findings       RS    32  TAETORD
#> 5864   SDTMIG     3.4        Findings       RS    33    EPOCH
#> 5865   SDTMIG     3.4        Findings       RS    34    RSDTC
#> 5866   SDTMIG     3.4        Findings       RS    35     RSDY
#> 5867   SDTMIG     3.4        Findings       RS    36    RSTPT
#> 5868   SDTMIG     3.4        Findings       RS    37 RSTPTNUM
#> 5869   SDTMIG     3.4        Findings       RS    38   RSELTM
#> 5870   SDTMIG     3.4        Findings       RS    39 RSTPTREF
#> 5871   SDTMIG     3.4        Findings       RS    40 RSRFTDTC
#> 5872   SDTMIG     3.4        Findings       RS    41 RSEVLINT
#> 5873   SDTMIG     3.4        Findings       RS    42 RSEVINTX
#> 5874   SDTMIG     3.4        Findings       RS    43 RSSTRTPT
#> 5875   SDTMIG     3.4        Findings       RS    44  RSSTTPT
#> 5876   SDTMIG     3.4        Findings       RS    45 RSENRTPT
#> 5877   SDTMIG     3.4        Findings       RS    46  RSENTPT
#> 5878   SDTMIG     3.4        Findings       SC     1  STUDYID
#> 5879   SDTMIG     3.4        Findings       SC     2   DOMAIN
#> 5880   SDTMIG     3.4        Findings       SC     3  USUBJID
#> 5881   SDTMIG     3.4        Findings       SC     4    SCSEQ
#> 5882   SDTMIG     3.4        Findings       SC     5  SCGRPID
#> 5883   SDTMIG     3.4        Findings       SC     6   SCSPID
#> 5884   SDTMIG     3.4        Findings       SC     7 SCTESTCD
#> 5885   SDTMIG     3.4        Findings       SC     8   SCTEST
#> 5886   SDTMIG     3.4        Findings       SC     9    SCCAT
#> 5887   SDTMIG     3.4        Findings       SC    10   SCSCAT
#> 5888   SDTMIG     3.4        Findings       SC    11  SCORRES
#> 5889   SDTMIG     3.4        Findings       SC    12 SCORRESU
#> 5890   SDTMIG     3.4        Findings       SC    13 SCSTRESC
#> 5891   SDTMIG     3.4        Findings       SC    14 SCSTRESN
#> 5892   SDTMIG     3.4        Findings       SC    15 SCSTRESU
#> 5893   SDTMIG     3.4        Findings       SC    16   SCSTAT
#> 5894   SDTMIG     3.4        Findings       SC    17 SCREASND
#> 5895   SDTMIG     3.4        Findings       SC    18 VISITNUM
#> 5896   SDTMIG     3.4        Findings       SC    19    VISIT
#> 5897   SDTMIG     3.4        Findings       SC    20  VISITDY
#> 5898   SDTMIG     3.4        Findings       SC    21  TAETORD
#> 5899   SDTMIG     3.4        Findings       SC    22    EPOCH
#> 5900   SDTMIG     3.4        Findings       SC    23    SCDTC
#> 5901   SDTMIG     3.4        Findings       SC    24     SCDY
#> 5902   SDTMIG     3.4        Findings       SS     1  STUDYID
#> 5903   SDTMIG     3.4        Findings       SS     2   DOMAIN
#> 5904   SDTMIG     3.4        Findings       SS     3  USUBJID
#> 5905   SDTMIG     3.4        Findings       SS     4    SSSEQ
#> 5906   SDTMIG     3.4        Findings       SS     5  SSGRPID
#> 5907   SDTMIG     3.4        Findings       SS     6   SSSPID
#> 5908   SDTMIG     3.4        Findings       SS     7 SSTESTCD
#> 5909   SDTMIG     3.4        Findings       SS     8   SSTEST
#> 5910   SDTMIG     3.4        Findings       SS     9    SSCAT
#> 5911   SDTMIG     3.4        Findings       SS    10   SSSCAT
#> 5912   SDTMIG     3.4        Findings       SS    11  SSORRES
#> 5913   SDTMIG     3.4        Findings       SS    12 SSSTRESC
#> 5914   SDTMIG     3.4        Findings       SS    13   SSSTAT
#> 5915   SDTMIG     3.4        Findings       SS    14 SSREASND
#> 5916   SDTMIG     3.4        Findings       SS    15   SSEVAL
#> 5917   SDTMIG     3.4        Findings       SS    16 VISITNUM
#> 5918   SDTMIG     3.4        Findings       SS    17    VISIT
#> 5919   SDTMIG     3.4        Findings       SS    18  VISITDY
#> 5920   SDTMIG     3.4        Findings       SS    19  TAETORD
#> 5921   SDTMIG     3.4        Findings       SS    20    EPOCH
#> 5922   SDTMIG     3.4        Findings       SS    21    SSDTC
#> 5923   SDTMIG     3.4        Findings       SS    22     SSDY
#> 5924   SDTMIG     3.4        Findings       TR     1  STUDYID
#> 5925   SDTMIG     3.4        Findings       TR     2   DOMAIN
#> 5926   SDTMIG     3.4        Findings       TR     3  USUBJID
#> 5927   SDTMIG     3.4        Findings       TR     4    TRSEQ
#> 5928   SDTMIG     3.4        Findings       TR     5  TRGRPID
#> 5929   SDTMIG     3.4        Findings       TR     6  TRREFID
#> 5930   SDTMIG     3.4        Findings       TR     7   TRSPID
#> 5931   SDTMIG     3.4        Findings       TR     8  TRLNKID
#> 5932   SDTMIG     3.4        Findings       TR     9 TRLNKGRP
#> 5933   SDTMIG     3.4        Findings       TR    10 TRTESTCD
#> 5934   SDTMIG     3.4        Findings       TR    11   TRTEST
#> 5935   SDTMIG     3.4        Findings       TR    12  TRORRES
#> 5936   SDTMIG     3.4        Findings       TR    13 TRORRESU
#> 5937   SDTMIG     3.4        Findings       TR    14 TRSTRESC
#> 5938   SDTMIG     3.4        Findings       TR    15 TRSTRESN
#> 5939   SDTMIG     3.4        Findings       TR    16 TRSTRESU
#> 5940   SDTMIG     3.4        Findings       TR    17   TRSTAT
#> 5941   SDTMIG     3.4        Findings       TR    18 TRREASND
#> 5942   SDTMIG     3.4        Findings       TR    19    TRNAM
#> 5943   SDTMIG     3.4        Findings       TR    20 TRMETHOD
#> 5944   SDTMIG     3.4        Findings       TR    21 TRLOBXFL
#> 5945   SDTMIG     3.4        Findings       TR    22   TRBLFL
#> 5946   SDTMIG     3.4        Findings       TR    23   TREVAL
#> 5947   SDTMIG     3.4        Findings       TR    24 TREVALID
#> 5948   SDTMIG     3.4        Findings       TR    25 TRACPTFL
#> 5949   SDTMIG     3.4        Findings       TR    26 VISITNUM
#> 5950   SDTMIG     3.4        Findings       TR    27    VISIT
#> 5951   SDTMIG     3.4        Findings       TR    28  VISITDY
#> 5952   SDTMIG     3.4        Findings       TR    29  TAETORD
#> 5953   SDTMIG     3.4        Findings       TR    30    EPOCH
#> 5954   SDTMIG     3.4        Findings       TR    31    TRDTC
#> 5955   SDTMIG     3.4        Findings       TR    32     TRDY
#> 5956   SDTMIG     3.4        Findings       TU     1  STUDYID
#> 5957   SDTMIG     3.4        Findings       TU     2   DOMAIN
#> 5958   SDTMIG     3.4        Findings       TU     3  USUBJID
#> 5959   SDTMIG     3.4        Findings       TU     4    TUSEQ
#> 5960   SDTMIG     3.4        Findings       TU     5  TUGRPID
#> 5961   SDTMIG     3.4        Findings       TU     6  TUREFID
#> 5962   SDTMIG     3.4        Findings       TU     7   TUSPID
#> 5963   SDTMIG     3.4        Findings       TU     8  TULNKID
#> 5964   SDTMIG     3.4        Findings       TU     9 TULNKGRP
#> 5965   SDTMIG     3.4        Findings       TU    10 TUTESTCD
#> 5966   SDTMIG     3.4        Findings       TU    11   TUTEST
#> 5967   SDTMIG     3.4        Findings       TU    12  TUORRES
#> 5968   SDTMIG     3.4        Findings       TU    13 TUSTRESC
#> 5969   SDTMIG     3.4        Findings       TU    14    TUNAM
#> 5970   SDTMIG     3.4        Findings       TU    15    TULOC
#> 5971   SDTMIG     3.4        Findings       TU    16    TULAT
#> 5972   SDTMIG     3.4        Findings       TU    17    TUDIR
#> 5973   SDTMIG     3.4        Findings       TU    18 TUPORTOT
#> 5974   SDTMIG     3.4        Findings       TU    19 TUMETHOD
#> 5975   SDTMIG     3.4        Findings       TU    20 TULOBXFL
#> 5976   SDTMIG     3.4        Findings       TU    21   TUBLFL
#> 5977   SDTMIG     3.4        Findings       TU    22   TUEVAL
#> 5978   SDTMIG     3.4        Findings       TU    23 TUEVALID
#> 5979   SDTMIG     3.4        Findings       TU    24 TUACPTFL
#> 5980   SDTMIG     3.4        Findings       TU    25 VISITNUM
#> 5981   SDTMIG     3.4        Findings       TU    26    VISIT
#> 5982   SDTMIG     3.4        Findings       TU    27  VISITDY
#> 5983   SDTMIG     3.4        Findings       TU    28  TAETORD
#> 5984   SDTMIG     3.4        Findings       TU    29    EPOCH
#> 5985   SDTMIG     3.4        Findings       TU    30    TUDTC
#> 5986   SDTMIG     3.4        Findings       TU    31     TUDY
#> 5987   SDTMIG     3.4        Findings       UR     1  STUDYID
#> 5988   SDTMIG     3.4        Findings       UR     2   DOMAIN
#> 5989   SDTMIG     3.4        Findings       UR     3  USUBJID
#> 5990   SDTMIG     3.4        Findings       UR     4    URSEQ
#> 5991   SDTMIG     3.4        Findings       UR     5  URGRPID
#> 5992   SDTMIG     3.4        Findings       UR     6  URREFID
#> 5993   SDTMIG     3.4        Findings       UR     7   URSPID
#> 5994   SDTMIG     3.4        Findings       UR     8  URLNKID
#> 5995   SDTMIG     3.4        Findings       UR     9 URLNKGRP
#> 5996   SDTMIG     3.4        Findings       UR    10 URTESTCD
#> 5997   SDTMIG     3.4        Findings       UR    11   URTEST
#> 5998   SDTMIG     3.4        Findings       UR    12 URTSTDTL
#> 5999   SDTMIG     3.4        Findings       UR    13    URCAT
#> 6000   SDTMIG     3.4        Findings       UR    14   URSCAT
#> 6001   SDTMIG     3.4        Findings       UR    15  URORRES
#> 6002   SDTMIG     3.4        Findings       UR    16 URORRESU
#> 6003   SDTMIG     3.4        Findings       UR    17 URSTRESC
#> 6004   SDTMIG     3.4        Findings       UR    18 URSTRESN
#> 6005   SDTMIG     3.4        Findings       UR    19 URSTRESU
#> 6006   SDTMIG     3.4        Findings       UR    20 URRESCAT
#> 6007   SDTMIG     3.4        Findings       UR    21   URSTAT
#> 6008   SDTMIG     3.4        Findings       UR    22 URREASND
#> 6009   SDTMIG     3.4        Findings       UR    23    URLOC
#> 6010   SDTMIG     3.4        Findings       UR    24    URLAT
#> 6011   SDTMIG     3.4        Findings       UR    25    URDIR
#> 6012   SDTMIG     3.4        Findings       UR    26 URMETHOD
#> 6013   SDTMIG     3.4        Findings       UR    27 URLOBXFL
#> 6014   SDTMIG     3.4        Findings       UR    28   URBLFL
#> 6015   SDTMIG     3.4        Findings       UR    29  URDRVFL
#> 6016   SDTMIG     3.4        Findings       UR    30   UREVAL
#> 6017   SDTMIG     3.4        Findings       UR    31 UREVALID
#> 6018   SDTMIG     3.4        Findings       UR    32 VISITNUM
#> 6019   SDTMIG     3.4        Findings       UR    33    VISIT
#> 6020   SDTMIG     3.4        Findings       UR    34  VISITDY
#> 6021   SDTMIG     3.4        Findings       UR    35  TAETORD
#> 6022   SDTMIG     3.4        Findings       UR    36    EPOCH
#> 6023   SDTMIG     3.4        Findings       UR    37    URDTC
#> 6024   SDTMIG     3.4        Findings       UR    38     URDY
#> 6025   SDTMIG     3.4        Findings       UR    39    URTPT
#> 6026   SDTMIG     3.4        Findings       UR    40 URTPTNUM
#> 6027   SDTMIG     3.4        Findings       UR    41   URELTM
#> 6028   SDTMIG     3.4        Findings       UR    42 URTPTREF
#> 6029   SDTMIG     3.4        Findings       UR    43 URRFTDTC
#> 6030   SDTMIG     3.4        Findings       VS     1  STUDYID
#> 6031   SDTMIG     3.4        Findings       VS     2   DOMAIN
#> 6032   SDTMIG     3.4        Findings       VS     3  USUBJID
#> 6033   SDTMIG     3.4        Findings       VS     4    VSSEQ
#> 6034   SDTMIG     3.4        Findings       VS     5  VSGRPID
#> 6035   SDTMIG     3.4        Findings       VS     6   VSSPID
#> 6036   SDTMIG     3.4        Findings       VS     7 VSTESTCD
#> 6037   SDTMIG     3.4        Findings       VS     8   VSTEST
#> 6038   SDTMIG     3.4        Findings       VS     9    VSCAT
#> 6039   SDTMIG     3.4        Findings       VS    10   VSSCAT
#> 6040   SDTMIG     3.4        Findings       VS    11    VSPOS
#> 6041   SDTMIG     3.4        Findings       VS    12  VSORRES
#> 6042   SDTMIG     3.4        Findings       VS    13 VSORRESU
#> 6043   SDTMIG     3.4        Findings       VS    14 VSSTRESC
#> 6044   SDTMIG     3.4        Findings       VS    15 VSSTRESN
#> 6045   SDTMIG     3.4        Findings       VS    16 VSSTRESU
#> 6046   SDTMIG     3.4        Findings       VS    17   VSSTAT
#> 6047   SDTMIG     3.4        Findings       VS    18 VSREASND
#> 6048   SDTMIG     3.4        Findings       VS    19    VSLOC
#> 6049   SDTMIG     3.4        Findings       VS    20    VSLAT
#> 6050   SDTMIG     3.4        Findings       VS    21 VSLOBXFL
#> 6051   SDTMIG     3.4        Findings       VS    22   VSBLFL
#> 6052   SDTMIG     3.4        Findings       VS    23  VSDRVFL
#> 6053   SDTMIG     3.4        Findings       VS    24    VSTOX
#> 6054   SDTMIG     3.4        Findings       VS    25  VSTOXGR
#> 6055   SDTMIG     3.4        Findings       VS    26  VSCLSIG
#> 6056   SDTMIG     3.4        Findings       VS    27 VISITNUM
#> 6057   SDTMIG     3.4        Findings       VS    28    VISIT
#> 6058   SDTMIG     3.4        Findings       VS    29  VISITDY
#> 6059   SDTMIG     3.4        Findings       VS    30  TAETORD
#> 6060   SDTMIG     3.4        Findings       VS    31    EPOCH
#> 6061   SDTMIG     3.4        Findings       VS    32    VSDTC
#> 6062   SDTMIG     3.4        Findings       VS    33     VSDY
#> 6063   SDTMIG     3.4        Findings       VS    34    VSTPT
#> 6064   SDTMIG     3.4        Findings       VS    35 VSTPTNUM
#> 6065   SDTMIG     3.4        Findings       VS    36   VSELTM
#> 6066   SDTMIG     3.4        Findings       VS    37 VSTPTREF
#> 6067   SDTMIG     3.4        Findings       VS    38 VSRFTDTC
#> 6068   SDTMIG     3.4  Findings About       FA     1  STUDYID
#> 6069   SDTMIG     3.4  Findings About       FA     2   DOMAIN
#> 6070   SDTMIG     3.4  Findings About       FA     3  USUBJID
#> 6071   SDTMIG     3.4  Findings About       FA     4    FASEQ
#> 6072   SDTMIG     3.4  Findings About       FA     5  FAGRPID
#> 6073   SDTMIG     3.4  Findings About       FA     6   FASPID
#> 6074   SDTMIG     3.4  Findings About       FA     7 FATESTCD
#> 6075   SDTMIG     3.4  Findings About       FA     8   FATEST
#> 6076   SDTMIG     3.4  Findings About       FA     9    FAOBJ
#> 6077   SDTMIG     3.4  Findings About       FA    10    FACAT
#> 6078   SDTMIG     3.4  Findings About       FA    11   FASCAT
#> 6079   SDTMIG     3.4  Findings About       FA    12  FAORRES
#> 6080   SDTMIG     3.4  Findings About       FA    13 FAORRESU
#> 6081   SDTMIG     3.4  Findings About       FA    14 FASTRESC
#> 6082   SDTMIG     3.4  Findings About       FA    15 FASTRESN
#> 6083   SDTMIG     3.4  Findings About       FA    16 FASTRESU
#> 6084   SDTMIG     3.4  Findings About       FA    17   FASTAT
#> 6085   SDTMIG     3.4  Findings About       FA    18 FAREASND
#> 6086   SDTMIG     3.4  Findings About       FA    19    FALOC
#> 6087   SDTMIG     3.4  Findings About       FA    20    FALAT
#> 6088   SDTMIG     3.4  Findings About       FA    21 FALOBXFL
#> 6089   SDTMIG     3.4  Findings About       FA    22   FABLFL
#> 6090   SDTMIG     3.4  Findings About       FA    23   FAEVAL
#> 6091   SDTMIG     3.4  Findings About       FA    24 VISITNUM
#> 6092   SDTMIG     3.4  Findings About       FA    25    VISIT
#> 6093   SDTMIG     3.4  Findings About       FA    26  VISITDY
#> 6094   SDTMIG     3.4  Findings About       FA    27  TAETORD
#> 6095   SDTMIG     3.4  Findings About       FA    28    EPOCH
#> 6096   SDTMIG     3.4  Findings About       FA    29    FADTC
#> 6097   SDTMIG     3.4  Findings About       FA    30     FADY
#> 6098   SDTMIG     3.4  Findings About       SR     1  STUDYID
#> 6099   SDTMIG     3.4  Findings About       SR     2   DOMAIN
#> 6100   SDTMIG     3.4  Findings About       SR     3  USUBJID
#> 6101   SDTMIG     3.4  Findings About       SR     4    SRSEQ
#> 6102   SDTMIG     3.4  Findings About       SR     5  SRGRPID
#> 6103   SDTMIG     3.4  Findings About       SR     6  SRREFID
#> 6104   SDTMIG     3.4  Findings About       SR     7   SRSPID
#> 6105   SDTMIG     3.4  Findings About       SR     8 SRTESTCD
#> 6106   SDTMIG     3.4  Findings About       SR     9   SRTEST
#> 6107   SDTMIG     3.4  Findings About       SR    10    SROBJ
#> 6108   SDTMIG     3.4  Findings About       SR    11    SRCAT
#> 6109   SDTMIG     3.4  Findings About       SR    12   SRSCAT
#> 6110   SDTMIG     3.4  Findings About       SR    13  SRORRES
#> 6111   SDTMIG     3.4  Findings About       SR    14 SRORRESU
#> 6112   SDTMIG     3.4  Findings About       SR    15 SRSTRESC
#> 6113   SDTMIG     3.4  Findings About       SR    16 SRSTRESN
#> 6114   SDTMIG     3.4  Findings About       SR    17 SRSTRESU
#> 6115   SDTMIG     3.4  Findings About       SR    18   SRSTAT
#> 6116   SDTMIG     3.4  Findings About       SR    19 SRREASND
#> 6117   SDTMIG     3.4  Findings About       SR    20    SRNAM
#> 6118   SDTMIG     3.4  Findings About       SR    21   SRSPEC
#> 6119   SDTMIG     3.4  Findings About       SR    22    SRLOC
#> 6120   SDTMIG     3.4  Findings About       SR    23    SRLAT
#> 6121   SDTMIG     3.4  Findings About       SR    24 SRMETHOD
#> 6122   SDTMIG     3.4  Findings About       SR    25 SRLOBXFL
#> 6123   SDTMIG     3.4  Findings About       SR    26   SRBLFL
#> 6124   SDTMIG     3.4  Findings About       SR    27   SREVAL
#> 6125   SDTMIG     3.4  Findings About       SR    28 VISITNUM
#> 6126   SDTMIG     3.4  Findings About       SR    29    VISIT
#> 6127   SDTMIG     3.4  Findings About       SR    30  VISITDY
#> 6128   SDTMIG     3.4  Findings About       SR    31  TAETORD
#> 6129   SDTMIG     3.4  Findings About       SR    32    EPOCH
#> 6130   SDTMIG     3.4  Findings About       SR    33    SRDTC
#> 6131   SDTMIG     3.4  Findings About       SR    34     SRDY
#> 6132   SDTMIG     3.4  Findings About       SR    35    SRTPT
#> 6133   SDTMIG     3.4  Findings About       SR    36 SRTPTNUM
#> 6134   SDTMIG     3.4  Findings About       SR    37   SRELTM
#> 6135   SDTMIG     3.4  Findings About       SR    38 SRTPTREF
#> 6136   SDTMIG     3.4  Findings About       SR    39 SRRFTDTC
#> 6137   SDTMIG     3.4 Special-Purpose       CO     1  STUDYID
#> 6138   SDTMIG     3.4 Special-Purpose       CO     2   DOMAIN
#> 6139   SDTMIG     3.4 Special-Purpose       CO     3  RDOMAIN
#> 6140   SDTMIG     3.4 Special-Purpose       CO     4  USUBJID
#> 6141   SDTMIG     3.4 Special-Purpose       CO     5    COSEQ
#> 6142   SDTMIG     3.4 Special-Purpose       CO     6    IDVAR
#> 6143   SDTMIG     3.4 Special-Purpose       CO     7 IDVARVAL
#> 6144   SDTMIG     3.4 Special-Purpose       CO     8    COREF
#> 6145   SDTMIG     3.4 Special-Purpose       CO     9    COVAL
#> 6146   SDTMIG     3.4 Special-Purpose       CO    10   COEVAL
#> 6147   SDTMIG     3.4 Special-Purpose       CO    11 COEVALID
#> 6148   SDTMIG     3.4 Special-Purpose       CO    12    CODTC
#> 6149   SDTMIG     3.4 Special-Purpose       CO    13     CODY
#> 6150   SDTMIG     3.4 Special-Purpose       DM     1  STUDYID
#> 6151   SDTMIG     3.4 Special-Purpose       DM     2   DOMAIN
#> 6152   SDTMIG     3.4 Special-Purpose       DM     3  USUBJID
#> 6153   SDTMIG     3.4 Special-Purpose       DM     4   SUBJID
#> 6154   SDTMIG     3.4 Special-Purpose       DM     5  RFSTDTC
#> 6155   SDTMIG     3.4 Special-Purpose       DM     6  RFENDTC
#> 6156   SDTMIG     3.4 Special-Purpose       DM     7 RFXSTDTC
#> 6157   SDTMIG     3.4 Special-Purpose       DM     8 RFXENDTC
#> 6158   SDTMIG     3.4 Special-Purpose       DM     9 RFCSTDTC
#> 6159   SDTMIG     3.4 Special-Purpose       DM    10 RFCENDTC
#> 6160   SDTMIG     3.4 Special-Purpose       DM    11  RFICDTC
#> 6161   SDTMIG     3.4 Special-Purpose       DM    12 RFPENDTC
#> 6162   SDTMIG     3.4 Special-Purpose       DM    13   DTHDTC
#> 6163   SDTMIG     3.4 Special-Purpose       DM    14    DTHFL
#> 6164   SDTMIG     3.4 Special-Purpose       DM    15   SITEID
#> 6165   SDTMIG     3.4 Special-Purpose       DM    16    INVID
#> 6166   SDTMIG     3.4 Special-Purpose       DM    17   INVNAM
#> 6167   SDTMIG     3.4 Special-Purpose       DM    18  BRTHDTC
#> 6168   SDTMIG     3.4 Special-Purpose       DM    19      AGE
#> 6169   SDTMIG     3.4 Special-Purpose       DM    20     AGEU
#> 6170   SDTMIG     3.4 Special-Purpose       DM    21      SEX
#> 6171   SDTMIG     3.4 Special-Purpose       DM    22     RACE
#> 6172   SDTMIG     3.4 Special-Purpose       DM    23   ETHNIC
#> 6173   SDTMIG     3.4 Special-Purpose       DM    24    ARMCD
#> 6174   SDTMIG     3.4 Special-Purpose       DM    25      ARM
#> 6175   SDTMIG     3.4 Special-Purpose       DM    26 ACTARMCD
#> 6176   SDTMIG     3.4 Special-Purpose       DM    27   ACTARM
#> 6177   SDTMIG     3.4 Special-Purpose       DM    28   ARMNRS
#> 6178   SDTMIG     3.4 Special-Purpose       DM    29 ACTARMUD
#> 6179   SDTMIG     3.4 Special-Purpose       DM    30  COUNTRY
#> 6180   SDTMIG     3.4 Special-Purpose       DM    31    DMDTC
#> 6181   SDTMIG     3.4 Special-Purpose       DM    32     DMDY
#> 6182   SDTMIG     3.4 Special-Purpose       SE     1  STUDYID
#> 6183   SDTMIG     3.4 Special-Purpose       SE     2   DOMAIN
#> 6184   SDTMIG     3.4 Special-Purpose       SE     3  USUBJID
#> 6185   SDTMIG     3.4 Special-Purpose       SE     4    SESEQ
#> 6186   SDTMIG     3.4 Special-Purpose       SE     5     ETCD
#> 6187   SDTMIG     3.4 Special-Purpose       SE     6  ELEMENT
#> 6188   SDTMIG     3.4 Special-Purpose       SE     7  TAETORD
#> 6189   SDTMIG     3.4 Special-Purpose       SE     8    EPOCH
#> 6190   SDTMIG     3.4 Special-Purpose       SE     9  SESTDTC
#> 6191   SDTMIG     3.4 Special-Purpose       SE    10  SEENDTC
#> 6192   SDTMIG     3.4 Special-Purpose       SE    11   SESTDY
#> 6193   SDTMIG     3.4 Special-Purpose       SE    12   SEENDY
#> 6194   SDTMIG     3.4 Special-Purpose       SE    13  SEUPDES
#> 6195   SDTMIG     3.4 Special-Purpose       SM     1  STUDYID
#> 6196   SDTMIG     3.4 Special-Purpose       SM     2   DOMAIN
#> 6197   SDTMIG     3.4 Special-Purpose       SM     3  USUBJID
#> 6198   SDTMIG     3.4 Special-Purpose       SM     4    SMSEQ
#> 6199   SDTMIG     3.4 Special-Purpose       SM     5     MIDS
#> 6200   SDTMIG     3.4 Special-Purpose       SM     6 MIDSTYPE
#> 6201   SDTMIG     3.4 Special-Purpose       SM     7  SMSTDTC
#> 6202   SDTMIG     3.4 Special-Purpose       SM     8  SMENDTC
#> 6203   SDTMIG     3.4 Special-Purpose       SM     9   SMSTDY
#> 6204   SDTMIG     3.4 Special-Purpose       SM    10   SMENDY
#> 6205   SDTMIG     3.4 Special-Purpose       SV     1  STUDYID
#> 6206   SDTMIG     3.4 Special-Purpose       SV     2   DOMAIN
#> 6207   SDTMIG     3.4 Special-Purpose       SV     3  USUBJID
#> 6208   SDTMIG     3.4 Special-Purpose       SV     4 VISITNUM
#> 6209   SDTMIG     3.4 Special-Purpose       SV     5    VISIT
#> 6210   SDTMIG     3.4 Special-Purpose       SV     6  SVPRESP
#> 6211   SDTMIG     3.4 Special-Purpose       SV     7  SVOCCUR
#> 6212   SDTMIG     3.4 Special-Purpose       SV     8 SVREASOC
#> 6213   SDTMIG     3.4 Special-Purpose       SV     9 SVCNTMOD
#> 6214   SDTMIG     3.4 Special-Purpose       SV    10 SVEPCHGI
#> 6215   SDTMIG     3.4 Special-Purpose       SV    11  VISITDY
#> 6216   SDTMIG     3.4 Special-Purpose       SV    12  SVSTDTC
#> 6217   SDTMIG     3.4 Special-Purpose       SV    13  SVENDTC
#> 6218   SDTMIG     3.4 Special-Purpose       SV    14   SVSTDY
#> 6219   SDTMIG     3.4 Special-Purpose       SV    15   SVENDY
#> 6220   SDTMIG     3.4 Special-Purpose       SV    16  SVUPDES
#> 6221   SDTMIG     3.4    Trial Design       TA     1  STUDYID
#> 6222   SDTMIG     3.4    Trial Design       TA     2   DOMAIN
#> 6223   SDTMIG     3.4    Trial Design       TA     3    ARMCD
#> 6224   SDTMIG     3.4    Trial Design       TA     4      ARM
#> 6225   SDTMIG     3.4    Trial Design       TA     5  TAETORD
#> 6226   SDTMIG     3.4    Trial Design       TA     6     ETCD
#> 6227   SDTMIG     3.4    Trial Design       TA     7  ELEMENT
#> 6228   SDTMIG     3.4    Trial Design       TA     8 TABRANCH
#> 6229   SDTMIG     3.4    Trial Design       TA     9  TATRANS
#> 6230   SDTMIG     3.4    Trial Design       TA    10    EPOCH
#> 6231   SDTMIG     3.4    Trial Design       TD     1  STUDYID
#> 6232   SDTMIG     3.4    Trial Design       TD     2   DOMAIN
#> 6233   SDTMIG     3.4    Trial Design       TD     3  TDORDER
#> 6234   SDTMIG     3.4    Trial Design       TD     4 TDANCVAR
#> 6235   SDTMIG     3.4    Trial Design       TD     5  TDSTOFF
#> 6236   SDTMIG     3.4    Trial Design       TD     6 TDTGTPAI
#> 6237   SDTMIG     3.4    Trial Design       TD     7 TDMINPAI
#> 6238   SDTMIG     3.4    Trial Design       TD     8 TDMAXPAI
#> 6239   SDTMIG     3.4    Trial Design       TD     9 TDNUMRPT
#> 6240   SDTMIG     3.4    Trial Design       TE     1  STUDYID
#> 6241   SDTMIG     3.4    Trial Design       TE     2   DOMAIN
#> 6242   SDTMIG     3.4    Trial Design       TE     3     ETCD
#> 6243   SDTMIG     3.4    Trial Design       TE     4  ELEMENT
#> 6244   SDTMIG     3.4    Trial Design       TE     5   TESTRL
#> 6245   SDTMIG     3.4    Trial Design       TE     6   TEENRL
#> 6246   SDTMIG     3.4    Trial Design       TE     7    TEDUR
#> 6247   SDTMIG     3.4    Trial Design       TI     1  STUDYID
#> 6248   SDTMIG     3.4    Trial Design       TI     2   DOMAIN
#> 6249   SDTMIG     3.4    Trial Design       TI     3 IETESTCD
#> 6250   SDTMIG     3.4    Trial Design       TI     4   IETEST
#> 6251   SDTMIG     3.4    Trial Design       TI     5    IECAT
#> 6252   SDTMIG     3.4    Trial Design       TI     6   IESCAT
#> 6253   SDTMIG     3.4    Trial Design       TI     7     TIRL
#> 6254   SDTMIG     3.4    Trial Design       TI     8   TIVERS
#> 6255   SDTMIG     3.4    Trial Design       TM     1  STUDYID
#> 6256   SDTMIG     3.4    Trial Design       TM     2   DOMAIN
#> 6257   SDTMIG     3.4    Trial Design       TM     3 MIDSTYPE
#> 6258   SDTMIG     3.4    Trial Design       TM     4    TMDEF
#> 6259   SDTMIG     3.4    Trial Design       TM     5    TMRPT
#> 6260   SDTMIG     3.4    Trial Design       TS     1  STUDYID
#> 6261   SDTMIG     3.4    Trial Design       TS     2   DOMAIN
#> 6262   SDTMIG     3.4    Trial Design       TS     3    TSSEQ
#> 6263   SDTMIG     3.4    Trial Design       TS     4  TSGRPID
#> 6264   SDTMIG     3.4    Trial Design       TS     5 TSPARMCD
#> 6265   SDTMIG     3.4    Trial Design       TS     6   TSPARM
#> 6266   SDTMIG     3.4    Trial Design       TS     7    TSVAL
#> 6267   SDTMIG     3.4    Trial Design       TS     8  TSVALNF
#> 6268   SDTMIG     3.4    Trial Design       TS     9  TSVALCD
#> 6269   SDTMIG     3.4    Trial Design       TS    10 TSVCDREF
#> 6270   SDTMIG     3.4    Trial Design       TS    11 TSVCDVER
#> 6271   SDTMIG     3.4    Trial Design       TV     1  STUDYID
#> 6272   SDTMIG     3.4    Trial Design       TV     2   DOMAIN
#> 6273   SDTMIG     3.4    Trial Design       TV     3 VISITNUM
#> 6274   SDTMIG     3.4    Trial Design       TV     4    VISIT
#> 6275   SDTMIG     3.4    Trial Design       TV     5  VISITDY
#> 6276   SDTMIG     3.4    Trial Design       TV     6    ARMCD
#> 6277   SDTMIG     3.4    Trial Design       TV     7      ARM
#> 6278   SDTMIG     3.4    Trial Design       TV     8   TVSTRL
#> 6279   SDTMIG     3.4    Trial Design       TV     9   TVENRL
#> 6280   SDTMIG     3.4 Study Reference       OI     1  STUDYID
#> 6281   SDTMIG     3.4 Study Reference       OI     2   DOMAIN
#> 6282   SDTMIG     3.4 Study Reference       OI     3    NHOID
#> 6283   SDTMIG     3.4 Study Reference       OI     4    OISEQ
#> 6284   SDTMIG     3.4 Study Reference       OI     5 OIPARMCD
#> 6285   SDTMIG     3.4 Study Reference       OI     6   OIPARM
#> 6286   SDTMIG     3.4 Study Reference       OI     7    OIVAL
#> 6287   SDTMIG     3.4    Relationship   RELREC     1  STUDYID
#> 6288   SDTMIG     3.4    Relationship   RELREC     2  RDOMAIN
#> 6289   SDTMIG     3.4    Relationship   RELREC     3  USUBJID
#> 6290   SDTMIG     3.4    Relationship   RELREC     4    IDVAR
#> 6291   SDTMIG     3.4    Relationship   RELREC     5 IDVARVAL
#> 6292   SDTMIG     3.4    Relationship   RELREC     6  RELTYPE
#> 6293   SDTMIG     3.4    Relationship   RELREC     7    RELID
#> 6294   SDTMIG     3.4    Relationship  RELSPEC     1  STUDYID
#> 6295   SDTMIG     3.4    Relationship  RELSPEC     2  USUBJID
#> 6296   SDTMIG     3.4    Relationship  RELSPEC     3    REFID
#> 6297   SDTMIG     3.4    Relationship  RELSPEC     4     SPEC
#> 6298   SDTMIG     3.4    Relationship  RELSPEC     5   PARENT
#> 6299   SDTMIG     3.4    Relationship  RELSPEC     6    LEVEL
#> 6300   SDTMIG     3.4    Relationship   RELSUB     1  STUDYID
#> 6301   SDTMIG     3.4    Relationship   RELSUB     2  USUBJID
#> 6302   SDTMIG     3.4    Relationship   RELSUB     3   POOLID
#> 6303   SDTMIG     3.4    Relationship   RELSUB     4  RSUBJID
#> 6304   SDTMIG     3.4    Relationship   RELSUB     5     SREL
#> 6305   SDTMIG     3.4    Relationship SUPPQUAL     1  STUDYID
#> 6306   SDTMIG     3.4    Relationship SUPPQUAL     2  RDOMAIN
#> 6307   SDTMIG     3.4    Relationship SUPPQUAL     3  USUBJID
#> 6308   SDTMIG     3.4    Relationship SUPPQUAL     4    IDVAR
#> 6309   SDTMIG     3.4    Relationship SUPPQUAL     5 IDVARVAL
#> 6310   SDTMIG     3.4    Relationship SUPPQUAL     6     QNAM
#> 6311   SDTMIG     3.4    Relationship SUPPQUAL     7   QLABEL
#> 6312   SDTMIG     3.4    Relationship SUPPQUAL     8     QVAL
#> 6313   SDTMIG     3.4    Relationship SUPPQUAL     9    QORIG
#> 6314   SDTMIG     3.4    Relationship SUPPQUAL    10    QEVAL
#>                                         label type               role core
#> 4398                         Study Identifier Char         Identifier  Req
#> 4399                      Domain Abbreviation Char         Identifier  Req
#> 4400                Unique Subject Identifier Char         Identifier  Req
#> 4401                          Sequence Number  Num         Identifier  Req
#> 4402                                 Group ID Char         Identifier Perm
#> 4403               Sponsor-Defined Identifier Char         Identifier Perm
#> 4404                                  Link ID Char         Identifier Perm
#> 4405                            Link Group ID Char         Identifier Perm
#> 4406                      Reported Agent Name Char              Topic  Req
#> 4407                   Modified Reported Name Char  Synonym Qualifier Perm
#> 4408                  Standardized Agent Name Char  Synonym Qualifier Perm
#> 4409                       Category for Agent Char Grouping Qualifier Perm
#> 4410                    Subcategory for Agent Char Grouping Qualifier Perm
#> 4411                         AG Pre-Specified Char Variable Qualifier Perm
#> 4412                            AG Occurrence Char   Record Qualifier Perm
#> 4413                        Completion Status Char   Record Qualifier Perm
#> 4414     Reason Procedure Agent Not Collected Char   Record Qualifier Perm
#> 4415                              Agent Class Char Variable Qualifier Perm
#> 4416                         Agent Class Code Char Variable Qualifier Perm
#> 4417                  Dose per Administration  Num   Record Qualifier Perm
#> 4418                         Dose Description Char   Record Qualifier Perm
#> 4419                               Dose Units Char Variable Qualifier Perm
#> 4420                                Dose Form Char Variable Qualifier Perm
#> 4421            Dosing Frequency per Interval Char   Record Qualifier Perm
#> 4422                  Route of Administration Char Variable Qualifier Perm
#> 4423                             Visit Number  Num             Timing  Exp
#> 4424                               Visit Name Char             Timing Perm
#> 4425               Planned Study Day of Visit  Num             Timing Perm
#> 4426      Planned Order of Element within Arm  Num             Timing Perm
#> 4427                                    Epoch Char             Timing Perm
#> 4428                 Start Date/Time of Agent Char             Timing Perm
#> 4429                   End Date/Time of Agent Char             Timing Perm
#> 4430              Study Day of Start of Agent  Num             Timing Perm
#> 4431                Study Day of End of Agent  Num             Timing Perm
#> 4432                        Duration of Agent Char             Timing Perm
#> 4433       Start Relative to Reference Period Char             Timing Perm
#> 4434         End Relative to Reference Period Char             Timing Perm
#> 4435   Start Relative to Reference Time Point Char             Timing Perm
#> 4436               Start Reference Time Point Char             Timing Perm
#> 4437     End Relative to Reference Time Point Char             Timing Perm
#> 4438                 End Reference Time Point Char             Timing Perm
#> 4439                         Study Identifier Char         Identifier  Req
#> 4440                      Domain Abbreviation Char         Identifier  Req
#> 4441                Unique Subject Identifier Char         Identifier  Req
#> 4442                          Sequence Number  Num         Identifier  Req
#> 4443                                 Group ID Char         Identifier Perm
#> 4444               Sponsor-Defined Identifier Char         Identifier Perm
#> 4445   Reported Name of Drug, Med, or Therapy Char              Topic  Req
#> 4446                   Modified Reported Name Char  Synonym Qualifier Perm
#> 4447             Standardized Medication Name Char  Synonym Qualifier Perm
#> 4448                  Category for Medication Char Grouping Qualifier Perm
#> 4449               Subcategory for Medication Char Grouping Qualifier Perm
#> 4450                         CM Pre-specified Char Variable Qualifier Perm
#> 4451                            CM Occurrence Char   Record Qualifier Perm
#> 4452                        Completion Status Char   Record Qualifier Perm
#> 4453          Reason Medication Not Collected Char   Record Qualifier Perm
#> 4454                               Indication Char   Record Qualifier Perm
#> 4455                         Medication Class Char Variable Qualifier Perm
#> 4456                    Medication Class Code Char Variable Qualifier Perm
#> 4457                  Dose per Administration  Num   Record Qualifier Perm
#> 4458                         Dose Description Char   Record Qualifier Perm
#> 4459                               Dose Units Char Variable Qualifier Perm
#> 4460                                Dose Form Char Variable Qualifier Perm
#> 4461            Dosing Frequency per Interval Char   Record Qualifier Perm
#> 4462                         Total Daily Dose  Num   Record Qualifier Perm
#> 4463                    Intended Dose Regimen Char   Record Qualifier Perm
#> 4464                  Route of Administration Char Variable Qualifier Perm
#> 4465               Reason for Dose Adjustment Char   Record Qualifier Perm
#> 4466 Reason the Intervention Was Discontinued Char   Record Qualifier Perm
#> 4467      Planned Order of Element within Arm  Num             Timing Perm
#> 4468                                    Epoch Char             Timing Perm
#> 4469            Start Date/Time of Medication Char             Timing Perm
#> 4470              End Date/Time of Medication Char             Timing Perm
#> 4471         Study Day of Start of Medication  Num             Timing Perm
#> 4472           Study Day of End of Medication  Num             Timing Perm
#> 4473                                 Duration Char             Timing Perm
#> 4474       Start Relative to Reference Period Char             Timing Perm
#> 4475         End Relative to Reference Period Char             Timing Perm
#> 4476   Start Relative to Reference Time Point Char             Timing Perm
#> 4477               Start Reference Time Point Char             Timing Perm
#> 4478     End Relative to Reference Time Point Char             Timing Perm
#> 4479                 End Reference Time Point Char             Timing Perm
#> 4480                         Study Identifier Char         Identifier  Req
#> 4481                      Domain Abbreviation Char         Identifier  Req
#> 4482                Unique Subject Identifier Char         Identifier  Req
#> 4483                          Sequence Number  Num         Identifier  Req
#> 4484                                 Group ID Char         Identifier Perm
#> 4485                             Reference ID Char         Identifier Perm
#> 4486               Sponsor-Defined Identifier Char         Identifier Perm
#> 4487                                  Link ID Char         Identifier Perm
#> 4488                            Link Group ID Char         Identifier Perm
#> 4489                        Name of Treatment Char              Topic  Req
#> 4490                                     Mood Char   Record Qualifier Perm
#> 4491                    Category of Treatment Char Grouping Qualifier Perm
#> 4492                 Subcategory of Treatment Char Grouping Qualifier Perm
#> 4493                            Pre-Specified Char Variable Qualifier Perm
#> 4494                               Occurrence Char   Record Qualifier Perm
#> 4495                   Reason for Occur Value Char   Record Qualifier Perm
#> 4496                                     Dose  Num   Record Qualifier  Exp
#> 4497                         Dose Description Char   Record Qualifier Perm
#> 4498                               Dose Units Char Variable Qualifier  Exp
#> 4499                                Dose Form Char Variable Qualifier  Exp
#> 4500            Dosing Frequency per Interval Char   Record Qualifier Perm
#> 4501                         Total Daily Dose  Num   Record Qualifier Perm
#> 4502                    Intended Dose Regimen Char   Record Qualifier Perm
#> 4503                  Route of Administration Char Variable Qualifier Perm
#> 4504                               Lot Number Char   Record Qualifier Perm
#> 4505          Location of Dose Administration Char   Record Qualifier Perm
#> 4506                               Laterality Char Variable Qualifier Perm
#> 4507                           Directionality Char Variable Qualifier Perm
#> 4508                      Portion or Totality Char Variable Qualifier Perm
#> 4509                           Fasting Status Char   Record Qualifier Perm
#> 4510                  Pharmaceutical Strength  Num   Record Qualifier Perm
#> 4511            Pharmaceutical Strength Units Char Variable Qualifier Perm
#> 4512               Reason for Dose Adjustment Char   Record Qualifier Perm
#> 4513      Planned Order of Element within Arm  Num             Timing Perm
#> 4514                                    Epoch Char             Timing Perm
#> 4515             Start Date/Time of Treatment Char             Timing  Exp
#> 4516               End Date/Time of Treatment Char             Timing  Exp
#> 4517          Study Day of Start of Treatment  Num             Timing Perm
#> 4518            Study Day of End of Treatment  Num             Timing Perm
#> 4519                    Duration of Treatment Char             Timing Perm
#> 4520                  Planned Time Point Name Char             Timing Perm
#> 4521                Planned Time Point Number  Num             Timing Perm
#> 4522 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 4523                     Time Point Reference Char             Timing Perm
#> 4524        Date/Time of Reference Time Point Char             Timing Perm
#> 4525                         Study Identifier Char         Identifier  Req
#> 4526                      Domain Abbreviation Char         Identifier  Req
#> 4527                Unique Subject Identifier Char         Identifier  Req
#> 4528                          Sequence Number  Num         Identifier  Req
#> 4529                                 Group ID Char         Identifier Perm
#> 4530                             Reference ID Char         Identifier Perm
#> 4531               Sponsor-Defined Identifier Char         Identifier Perm
#> 4532                                  Link ID Char         Identifier Perm
#> 4533                            Link Group ID Char         Identifier Perm
#> 4534                        Name of Treatment Char              Topic  Req
#> 4535                    Category of Treatment Char Grouping Qualifier Perm
#> 4536                 Subcategory of Treatment Char Grouping Qualifier Perm
#> 4537                                     Dose  Num   Record Qualifier  Exp
#> 4538                         Dose Description Char   Record Qualifier Perm
#> 4539                               Dose Units Char Variable Qualifier  Exp
#> 4540                                Dose Form Char Variable Qualifier  Exp
#> 4541            Dosing Frequency per Interval Char   Record Qualifier Perm
#> 4542                    Intended Dose Regimen Char   Record Qualifier Perm
#> 4543                  Route of Administration Char Variable Qualifier Perm
#> 4544                               Lot Number Char   Record Qualifier Perm
#> 4545          Location of Dose Administration Char   Record Qualifier Perm
#> 4546                               Laterality Char Variable Qualifier Perm
#> 4547                           Directionality Char Variable Qualifier Perm
#> 4548                           Fasting Status Char   Record Qualifier Perm
#> 4549               Reason for Dose Adjustment Char   Record Qualifier Perm
#> 4550      Planned Order of Element within Arm  Num             Timing Perm
#> 4551                                    Epoch Char             Timing Perm
#> 4552             Start Date/Time of Treatment Char             Timing  Exp
#> 4553               End Date/Time of Treatment Char             Timing  Exp
#> 4554          Study Day of Start of Treatment  Num             Timing Perm
#> 4555            Study Day of End of Treatment  Num             Timing Perm
#> 4556                    Duration of Treatment Char             Timing Perm
#> 4557                  Planned Time Point Name Char             Timing Perm
#> 4558                Planned Time Point Number  Num             Timing Perm
#> 4559 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 4560                     Time Point Reference Char             Timing Perm
#> 4561        Date/Time of Reference Time Point Char             Timing Perm
#> 4562                         Study Identifier Char         Identifier  Req
#> 4563                      Domain Abbreviation Char         Identifier  Req
#> 4564                Unique Subject Identifier Char         Identifier  Req
#> 4565                          Sequence Number  Num         Identifier  Req
#> 4566                                 Group ID Char         Identifier Perm
#> 4567               Sponsor-Defined Identifier Char         Identifier Perm
#> 4568                             Name of Meal Char              Topic  Req
#> 4569                        Category for Meal Char Grouping Qualifier Perm
#> 4570                     Subcategory for Meal Char Grouping Qualifier Perm
#> 4571                         ML Pre-specified Char Variable Qualifier Perm
#> 4572                            ML Occurrence Char   Record Qualifier Perm
#> 4573                        Completion Status Char   Record Qualifier Perm
#> 4574                Reason Meal Not Collected Char   Record Qualifier Perm
#> 4575                                     Dose  Num   Record Qualifier Perm
#> 4576                         Dose Description Char   Record Qualifier Perm
#> 4577                               Dose Units Char Variable Qualifier Perm
#> 4578                                Dose Form Char Variable Qualifier Perm
#> 4579                             Visit Number  Num             Timing Perm
#> 4580                               Visit Name Char             Timing Perm
#> 4581               Planned Study Day of Visit  Num             Timing Perm
#> 4582      Planned Order of Element within Arm  Num             Timing Perm
#> 4583                                    Epoch Char             Timing Perm
#> 4584                  Date/Time of Collection Char             Timing Perm
#> 4585                  Start Date/Time of Meal Char             Timing Perm
#> 4586                    End Date/Time of Meal Char             Timing Perm
#> 4587       Study Day of Visit/Collection/Exam  Num             Timing Perm
#> 4588               Study Day of Start of Meal  Num             Timing Perm
#> 4589                 Study Day of End of Meal  Num             Timing Perm
#> 4590                         Duration of Meal Char             Timing Perm
#> 4591                  Planned Time Point Name Char             Timing Perm
#> 4592                Planned Time Point Number  Num             Timing Perm
#> 4593 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 4594                     Time Point Reference Char             Timing Perm
#> 4595        Date/Time of Reference Time Point Char             Timing Perm
#> 4596          Disease Milestone Instance Name Char             Timing Perm
#> 4597  Temporal Relation to Milestone Instance Char             Timing Perm
#> 4598     Disease Milestone Instance Date/Time Char             Timing Perm
#> 4599                         Study Identifier Char         Identifier  Req
#> 4600                      Domain Abbreviation Char         Identifier  Req
#> 4601                Unique Subject Identifier Char         Identifier  Req
#> 4602                          Sequence Number  Num         Identifier  Req
#> 4603                                 Group ID Char         Identifier Perm
#> 4604               Sponsor-Defined Identifier Char         Identifier Perm
#> 4605                                  Link ID Char         Identifier Perm
#> 4606                            Link Group ID Char         Identifier Perm
#> 4607               Reported Name of Procedure Char              Topic  Req
#> 4608              Standardized Procedure Name Char  Synonym Qualifier Perm
#> 4609                                 Category Char Grouping Qualifier Perm
#> 4610                              Subcategory Char Grouping Qualifier Perm
#> 4611                            Pre-specified Char Variable Qualifier Perm
#> 4612                               Occurrence Char   Record Qualifier Perm
#> 4613                               Indication Char   Record Qualifier Perm
#> 4614                                     Dose  Num   Record Qualifier Perm
#> 4615                         Dose Description Char   Record Qualifier Perm
#> 4616                               Dose Units Char Variable Qualifier Perm
#> 4617                                Dose Form Char Variable Qualifier Perm
#> 4618            Dosing Frequency per Interval Char   Record Qualifier Perm
#> 4619                    Intended Dose Regimen Char   Record Qualifier Perm
#> 4620                  Route of Administration Char Variable Qualifier Perm
#> 4621                    Location of Procedure Char   Record Qualifier Perm
#> 4622                               Laterality Char Variable Qualifier Perm
#> 4623                           Directionality Char Variable Qualifier Perm
#> 4624                      Portion or Totality Char Variable Qualifier Perm
#> 4625                             Visit Number  Num             Timing Perm
#> 4626                               Visit Name Char             Timing Perm
#> 4627               Planned Study Day of Visit  Num             Timing Perm
#> 4628      Planned Order of Element within Arm  Num             Timing Perm
#> 4629                                    Epoch Char             Timing Perm
#> 4630             Start Date/Time of Procedure Char             Timing  Exp
#> 4631               End Date/Time of Procedure Char             Timing Perm
#> 4632          Study Day of Start of Procedure  Num             Timing Perm
#> 4633            Study Day of End of Procedure  Num             Timing Perm
#> 4634                    Duration of Procedure Char             Timing Perm
#> 4635                  Planned Time Point Name Char             Timing Perm
#> 4636                Planned Time Point Number  Num             Timing Perm
#> 4637 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 4638                     Time Point Reference Char             Timing Perm
#> 4639        Date/Time of Reference Time Point Char             Timing Perm
#> 4640   Start Relative to Reference Time Point Char             Timing Perm
#> 4641               Start Reference Time Point Char             Timing Perm
#> 4642     End Relative to Reference Time Point Char             Timing Perm
#> 4643                 End Reference Time Point Char             Timing Perm
#> 4644                         Study Identifier Char         Identifier  Req
#> 4645                      Domain Abbreviation Char         Identifier  Req
#> 4646                Unique Subject Identifier Char         Identifier  Req
#> 4647                          Sequence Number  Num         Identifier  Req
#> 4648                                 Group ID Char         Identifier Perm
#> 4649               Sponsor-Defined Identifier Char         Identifier Perm
#> 4650               Reported Name of Substance Char              Topic  Req
#> 4651                  Modified Substance Name Char  Synonym Qualifier Perm
#> 4652              Standardized Substance Name Char  Synonym Qualifier Perm
#> 4653               Category for Substance Use Char Grouping Qualifier Perm
#> 4654            Subcategory for Substance Use Char Grouping Qualifier Perm
#> 4655                         SU Pre-Specified Char Variable Qualifier Perm
#> 4656                            SU Occurrence Char   Record Qualifier Perm
#> 4657                        Completion Status Char   Record Qualifier Perm
#> 4658       Reason Substance Use Not Collected Char   Record Qualifier Perm
#> 4659                      Substance Use Class Char Variable Qualifier Perm
#> 4660                 Substance Use Class Code Char Variable Qualifier Perm
#> 4661                Substance Use Consumption  Num   Record Qualifier Perm
#> 4662           Substance Use Consumption Text Char   Record Qualifier Perm
#> 4663                        Consumption Units Char Variable Qualifier Perm
#> 4664                                Dose Form Char Variable Qualifier Perm
#> 4665               Use Frequency Per Interval Char Variable Qualifier Perm
#> 4666                  Total Daily Consumption  Num   Record Qualifier Perm
#> 4667                  Route of Administration Char Variable Qualifier Perm
#> 4668      Planned Order of Element within Arm  Num             Timing Perm
#> 4669                                    Epoch Char             Timing Perm
#> 4670         Start Date/Time of Substance Use Char             Timing Perm
#> 4671           End Date/Time of Substance Use Char             Timing Perm
#> 4672      Study Day of Start of Substance Use  Num             Timing Perm
#> 4673        Study Day of End of Substance Use  Num             Timing Perm
#> 4674                Duration of Substance Use Char             Timing Perm
#> 4675       Start Relative to Reference Period Char             Timing Perm
#> 4676         End Relative to Reference Period Char             Timing Perm
#> 4677   Start Relative to Reference Time Point Char             Timing Perm
#> 4678               Start Reference Time Point Char             Timing Perm
#> 4679     End Relative to Reference Time Point Char             Timing Perm
#> 4680                 End Reference Time Point Char             Timing Perm
#> 4681                         Study Identifier Char         Identifier  Req
#> 4682                      Domain Abbreviation Char         Identifier  Req
#> 4683                Unique Subject Identifier Char         Identifier  Req
#> 4684                Sponsor Device Identifier Char         Identifier Perm
#> 4685                          Sequence Number  Num         Identifier  Req
#> 4686                                 Group ID Char         Identifier Perm
#> 4687                             Reference ID Char         Identifier Perm
#> 4688               Sponsor-Defined Identifier Char         Identifier Perm
#> 4689      Reported Term for the Adverse Event Char              Topic  Req
#> 4690                   Modified Reported Term Char  Synonym Qualifier Perm
#> 4691                        Lowest Level Term Char Variable Qualifier  Exp
#> 4692                   Lowest Level Term Code  Num Variable Qualifier  Exp
#> 4693                  Dictionary-Derived Term Char  Synonym Qualifier  Req
#> 4694                      Preferred Term Code  Num Variable Qualifier  Exp
#> 4695                          High Level Term Char Variable Qualifier  Exp
#> 4696                     High Level Term Code  Num Variable Qualifier  Exp
#> 4697                    High Level Group Term Char Variable Qualifier  Exp
#> 4698               High Level Group Term Code  Num Variable Qualifier  Exp
#> 4699               Category for Adverse Event Char Grouping Qualifier Perm
#> 4700            Subcategory for Adverse Event Char Grouping Qualifier Perm
#> 4701              Pre-Specified Adverse Event Char Variable Qualifier Perm
#> 4702               Body System or Organ Class Char   Record Qualifier  Exp
#> 4703          Body System or Organ Class Code  Num Variable Qualifier  Exp
#> 4704               Primary System Organ Class Char Variable Qualifier  Exp
#> 4705          Primary System Organ Class Code  Num Variable Qualifier  Exp
#> 4706                        Location of Event Char   Record Qualifier Perm
#> 4707                       Severity/Intensity Char   Record Qualifier Perm
#> 4708                            Serious Event Char   Record Qualifier  Exp
#> 4709        Action Taken with Study Treatment Char   Record Qualifier  Exp
#> 4710                       Other Action Taken Char   Record Qualifier Perm
#> 4711                 Action Taken with Device Char   Record Qualifier Perm
#> 4712                                Causality Char   Record Qualifier  Exp
#> 4713          Relationship of Event to Device Char   Record Qualifier Perm
#> 4714      Relationship to Non-Study Treatment Char   Record Qualifier Perm
#> 4715                 Pattern of Adverse Event Char   Record Qualifier Perm
#> 4716                 Outcome of Adverse Event Char   Record Qualifier Perm
#> 4717                          Involves Cancer Char   Record Qualifier Perm
#> 4718       Congenital Anomaly or Birth Defect Char   Record Qualifier Perm
#> 4719  Persist or Signif Disability/Incapacity Char   Record Qualifier Perm
#> 4720                         Results in Death Char   Record Qualifier Perm
#> 4721     Requires or Prolongs Hospitalization Char   Record Qualifier Perm
#> 4722                      Is Life Threatening Char   Record Qualifier Perm
#> 4723                   Occurred with Overdose Char   Record Qualifier Perm
#> 4724  Other Medically Important Serious Event Char   Record Qualifier Perm
#> 4725 Needs Intervention to Prevent Impairment Char   Record Qualifier Perm
#> 4726      Unanticipated Adverse Device Effect Char   Record Qualifier Perm
#> 4727  Rel of AE to Non-Dev-Rel Study Activity Char   Record Qualifier Perm
#> 4728    Rel of AE to Device-Related Procedure Char   Record Qualifier Perm
#> 4729   Concomitant or Additional Trtmnt Given Char   Record Qualifier Perm
#> 4730                  Standard Toxicity Grade Char   Record Qualifier Perm
#> 4731      Planned Order of Element within Arm  Num             Timing Perm
#> 4732                                    Epoch Char             Timing Perm
#> 4733         Start Date/Time of Adverse Event Char             Timing  Exp
#> 4734           End Date/Time of Adverse Event Char             Timing  Exp
#> 4735      Study Day of Start of Adverse Event  Num             Timing Perm
#> 4736        Study Day of End of Adverse Event  Num             Timing Perm
#> 4737                Duration of Adverse Event Char             Timing Perm
#> 4738         End Relative to Reference Period Char             Timing Perm
#> 4739     End Relative to Reference Time Point Char             Timing Perm
#> 4740                 End Reference Time Point Char             Timing Perm
#> 4741                         Study Identifier Char         Identifier  Req
#> 4742                      Domain Abbreviation Char         Identifier  Req
#> 4743                Unique Subject Identifier Char         Identifier  Req
#> 4744                Sponsor Device Identifier Char         Identifier Perm
#> 4745                          Sequence Number  Num         Identifier  Req
#> 4746                                 Group ID Char         Identifier Perm
#> 4747                             Reference ID Char         Identifier  Exp
#> 4748               Sponsor-Defined Identifier Char         Identifier Perm
#> 4749  Reported Term for the Biospecimen Event Char              Topic  Req
#> 4750                   Modified Reported Term Char  Synonym Qualifier Perm
#> 4751                  Dictionary-Derived Term Char  Synonym Qualifier Perm
#> 4752           Category for Biospecimen Event Char Grouping Qualifier Perm
#> 4753        Subcategory for Biospecimen Event Char Grouping Qualifier Perm
#> 4754             Anatomical Location of Event Char   Record Qualifier Perm
#> 4755                        Accountable Party Char   Record Qualifier Perm
#> 4756      Identification of Accountable Party Char   Record Qualifier Perm
#> 4757                             Visit Number  Num             Timing  Exp
#> 4758                               Visit Name Char             Timing Perm
#> 4759               Planned Study Day of Visit  Num             Timing Perm
#> 4760         Date/Time of Specimen Collection Char             Timing  Exp
#> 4761     Start Date/Time of Biospecimen Event Char             Timing  Exp
#> 4762       End Date/Time of Biospecimen Event Char             Timing  Exp
#> 4763  Study Day of Start of Biospecimen Event  Num             Timing Perm
#> 4764    Study Day of End of Biospecimen Event  Num             Timing Perm
#> 4765            Duration of Biospecimen Event Char             Timing Perm
#> 4766                         Study Identifier Char         Identifier  Req
#> 4767                      Domain Abbreviation Char         Identifier  Req
#> 4768                Unique Subject Identifier Char         Identifier  Req
#> 4769                          Sequence Number  Num         Identifier  Req
#> 4770                                 Group ID Char         Identifier Perm
#> 4771                             Reference ID Char         Identifier Perm
#> 4772               Sponsor-Defined Identifier Char         Identifier Perm
#> 4773     Reported Term for the Clinical Event Char              Topic  Req
#> 4774                  Dictionary-Derived Term Char  Synonym Qualifier Perm
#> 4775          Category for the Clinical Event Char Grouping Qualifier Perm
#> 4776       Subcategory for the Clinical Event Char Grouping Qualifier Perm
#> 4777             Clinical Event Pre-specified Char Variable Qualifier Perm
#> 4778                Clinical Event Occurrence Char   Record Qualifier Perm
#> 4779                        Completion Status Char   Record Qualifier Perm
#> 4780      Reason Clinical Event Not Collected Char   Record Qualifier Perm
#> 4781               Body System or Organ Class Char   Record Qualifier Perm
#> 4782                       Severity/Intensity Char   Record Qualifier Perm
#> 4783                  Standard Toxicity Grade Char   Record Qualifier Perm
#> 4784      Planned Order of Element within Arm  Num             Timing Perm
#> 4785                                    Epoch Char             Timing Perm
#> 4786            Date/Time of Event Collection Char             Timing Perm
#> 4787        Start Date/Time of Clinical Event Char             Timing Perm
#> 4788          End Date/Time of Clinical Event Char             Timing Perm
#> 4789            Study Day of Event Collection  Num             Timing Perm
#> 4790              Study Day of Start of Event  Num             Timing Perm
#> 4791                Study Day of End of Event  Num             Timing Perm
#> 4792       Start Relative to Reference Period Char             Timing Perm
#> 4793         End Relative to Reference Period Char             Timing Perm
#> 4794   Start Relative to Reference Time Point Char             Timing Perm
#> 4795               Start Reference Time Point Char             Timing Perm
#> 4796     End Relative to Reference Time Point Char             Timing Perm
#> 4797                 End Reference Time Point Char             Timing Perm
#> 4798                         Study Identifier Char         Identifier  Req
#> 4799                      Domain Abbreviation Char         Identifier  Req
#> 4800                Unique Subject Identifier Char         Identifier  Req
#> 4801                          Sequence Number  Num         Identifier  Req
#> 4802                                 Group ID Char         Identifier Perm
#> 4803                             Reference ID Char         Identifier Perm
#> 4804               Sponsor-Defined Identifier Char         Identifier Perm
#> 4805  Reported Term for the Disposition Event Char              Topic  Req
#> 4806            Standardized Disposition Term Char  Synonym Qualifier  Req
#> 4807           Category for Disposition Event Char Grouping Qualifier  Exp
#> 4808        Subcategory for Disposition Event Char Grouping Qualifier Perm
#> 4809                                    Epoch Char             Timing Perm
#> 4810                  Date/Time of Collection Char             Timing Perm
#> 4811     Start Date/Time of Disposition Event Char             Timing  Exp
#> 4812                  Study Day of Collection  Num             Timing Perm
#> 4813  Study Day of Start of Disposition Event  Num             Timing  Exp
#> 4814                         Study Identifier Char         Identifier  Req
#> 4815                      Domain Abbreviation Char         Identifier  Req
#> 4816                Unique Subject Identifier Char         Identifier  Req
#> 4817                          Sequence Number  Num         Identifier  Req
#> 4818                             Reference ID Char         Identifier Perm
#> 4819               Sponsor-Defined Identifier Char         Identifier Perm
#> 4820                  Protocol Deviation Term Char              Topic  Req
#> 4821            Protocol Deviation Coded Term Char  Synonym Qualifier Perm
#> 4822          Category for Protocol Deviation Char Grouping Qualifier Perm
#> 4823       Subcategory for Protocol Deviation Char Grouping Qualifier Perm
#> 4824      Planned Order of Element within Arm  Num             Timing Perm
#> 4825                                    Epoch Char             Timing Perm
#> 4826             Start Date/Time of Deviation Char             Timing Perm
#> 4827               End Date/Time of Deviation Char             Timing Perm
#> 4828    Study Day of Start of Deviation Event  Num             Timing Perm
#> 4829      Study Day of End of Deviation Event  Num             Timing Perm
#> 4830                         Study Identifier Char         Identifier  Req
#> 4831                      Domain Abbreviation Char         Identifier  Req
#> 4832                Unique Subject Identifier Char         Identifier  Req
#> 4833                          Sequence Number  Num         Identifier  Req
#> 4834                                 Group ID Char         Identifier Perm
#> 4835                             Reference ID Char         Identifier Perm
#> 4836               Sponsor-Defined Identifier Char         Identifier Perm
#> 4837                Healthcare Encounter Term Char              Topic  Req
#> 4838                  Dictionary-Derived Term Char  Synonym Qualifier Perm
#> 4839        Category for Healthcare Encounter Char Grouping Qualifier Perm
#> 4840     Subcategory for Healthcare Encounter Char Grouping Qualifier Perm
#> 4841       Pre-Specified Healthcare Encounter Char Variable Qualifier Perm
#> 4842          Healthcare Encounter Occurrence Char   Record Qualifier Perm
#> 4843                        Completion Status Char   Record Qualifier Perm
#> 4844     Reason Healthcare Encounter Not Done Char   Record Qualifier Perm
#> 4845      Planned Order of Element within Arm  Num             Timing Perm
#> 4846                                    Epoch Char             Timing Perm
#> 4847            Date/Time of Event Collection Char             Timing Perm
#> 4848  Start Date/Time of Healthcare Encounter Char             Timing  Exp
#> 4849    End Date/Time of Healthcare Encounter Char             Timing Perm
#> 4850            Study Day of Event Collection  Num             Timing Perm
#> 4851          Study Day of Start of Encounter  Num             Timing Perm
#> 4852 Study Day of End of Healthcare Encounter  Num             Timing Perm
#> 4853         Duration of Healthcare Encounter Char             Timing Perm
#> 4854   Start Relative to Reference Time Point Char             Timing Perm
#> 4855               Start Reference Time Point Char             Timing Perm
#> 4856     End Relative to Reference Time Point Char             Timing Perm
#> 4857                 End Reference Time Point Char             Timing Perm
#> 4858                         Study Identifier Char         Identifier  Req
#> 4859                      Domain Abbreviation Char         Identifier  Req
#> 4860                Unique Subject Identifier Char         Identifier  Req
#> 4861                          Sequence Number  Num         Identifier  Req
#> 4862                                 Group ID Char         Identifier Perm
#> 4863                             Reference ID Char         Identifier Perm
#> 4864               Sponsor-Defined Identifier Char         Identifier Perm
#> 4865    Reported Term for the Medical History Char              Topic  Req
#> 4866                   Modified Reported Term Char  Synonym Qualifier Perm
#> 4867                  Dictionary-Derived Term Char  Synonym Qualifier Perm
#> 4868          Medical History Event Date Type Char Variable Qualifier Perm
#> 4869             Category for Medical History Char Grouping Qualifier Perm
#> 4870          Subcategory for Medical History Char Grouping Qualifier Perm
#> 4871      Medical History Event Pre-Specified Char Variable Qualifier Perm
#> 4872               Medical History Occurrence Char   Record Qualifier Perm
#> 4873                        Completion Status Char   Record Qualifier Perm
#> 4874     Reason Medical History Not Collected Char   Record Qualifier Perm
#> 4875               Body System or Organ Class Char   Record Qualifier Perm
#> 4876      Planned Order of Element within Arm  Num             Timing Perm
#> 4877                                    Epoch Char             Timing Perm
#> 4878          Date/Time of History Collection Char             Timing Perm
#> 4879 Start Date/Time of Medical History Event Char             Timing Perm
#> 4880   End Date/Time of Medical History Event Char             Timing Perm
#> 4881          Study Day of History Collection  Num             Timing Perm
#> 4882         End Relative to Reference Period Char             Timing Perm
#> 4883     End Relative to Reference Time Point Char             Timing Perm
#> 4884                 End Reference Time Point Char             Timing Perm
#> 4885                         Study Identifier Char         Identifier  Req
#> 4886                      Domain Abbreviation Char         Identifier  Req
#> 4887                Unique Subject Identifier Char         Identifier  Req
#> 4888                Sponsor Device Identifier Char         Identifier Perm
#> 4889                          Sequence Number  Num         Identifier  Req
#> 4890                                 Group ID Char         Identifier Perm
#> 4891                             Reference ID Char         Identifier  Exp
#> 4892               Sponsor-Defined Identifier Char         Identifier Perm
#> 4893              Biospecimen Test Short Name Char              Topic  Req
#> 4894                    Biospecimen Test Name Char  Synonym Qualifier  Req
#> 4895            Category for Biospecimen Test Char Grouping Qualifier  Exp
#> 4896         Subcategory for Biospecimen Test Char Grouping Qualifier Perm
#> 4897      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 4898                           Original Units Char Variable Qualifier  Exp
#> 4899   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 4900 Numeric Result/Finding in Standard Units  Num   Result Qualifier  Exp
#> 4901                           Standard Units Char Variable Qualifier  Exp
#> 4902                        Completion Status Char   Record Qualifier Perm
#> 4903                     Reason Test Not Done Char   Record Qualifier Perm
#> 4904                              Vendor Name Char   Record Qualifier Perm
#> 4905                            Specimen Type Char   Record Qualifier Perm
#> 4906            Anatomical Region of Specimen Char Variable Qualifier Perm
#> 4907                       Specimen Condition Char   Record Qualifier Perm
#> 4908            Method of Test or Examination Char   Record Qualifier Perm
#> 4909                            Baseline Flag Char   Record Qualifier Perm
#> 4910                             Visit Number  Num             Timing  Exp
#> 4911                               Visit Name Char             Timing Perm
#> 4912               Planned Study Day of Visit  Num             Timing Perm
#> 4913         Date/Time of Specimen Collection Char             Timing  Exp
#> 4914         Study Day of Specimen Collection  Num             Timing Perm
#> 4915                  Planned Time Point Name Char             Timing Perm
#> 4916                Planned Time Point Number  Num             Timing Perm
#> 4917 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 4918                     Time Point Reference Char             Timing Perm
#> 4919        Date/Time of Reference Time Point Char             Timing Perm
#> 4920                         Study Identifier Char         Identifier  Req
#> 4921                      Domain Abbreviation Char         Identifier  Req
#> 4922                Unique Subject Identifier Char         Identifier  Req
#> 4923                          Sequence Number  Num         Identifier  Req
#> 4924                                 Group ID Char         Identifier Perm
#> 4925                             Reference ID Char         Identifier Perm
#> 4926               Sponsor-Defined Identifier Char         Identifier Perm
#> 4927                                  Link ID Char         Identifier Perm
#> 4928                            Link Group ID Char         Identifier Perm
#> 4929           Test or Examination Short Name Char              Topic  Req
#> 4930 Name of Measurement, Test or Examination Char  Synonym Qualifier  Req
#> 4931                 Sublineage Marker String Char Variable Qualifier Perm
#> 4932                               Cell State Char Variable Qualifier Perm
#> 4933                 Cell State Marker String Char Variable Qualifier Perm
#> 4934                           Test Condition Char Variable Qualifier Perm
#> 4935                     Test Condition Agent Char   Record Qualifier Perm
#> 4936                            Binding Agent Char   Record Qualifier Perm
#> 4937                Antibody Clone Identifier Char   Record Qualifier Perm
#> 4938                            Marker String Char   Record Qualifier  Exp
#> 4939                                     Gate Char   Record Qualifier Perm
#> 4940                          Gate Definition Char   Record Qualifier Perm
#> 4941                 Sponsor Test Description Char   Record Qualifier Perm
#> 4942                                 Category Char Grouping Qualifier Perm
#> 4943                              Subcategory Char Grouping Qualifier Perm
#> 4944                               Test Panel Char Grouping Qualifier Perm
#> 4945      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 4946                           Original Units Char Variable Qualifier Perm
#> 4947                             Result Scale Char   Record Qualifier Perm
#> 4948                              Result Type Char   Record Qualifier Perm
#> 4949            Collected Summary Result Type Char   Record Qualifier Perm
#> 4950 Reference Range Lower Limit in Orig Unit Char Variable Qualifier Perm
#> 4951 Reference Range Upper Limit in Orig Unit Char Variable Qualifier Perm
#> 4952     Result or Finding in Standard Format Char   Result Qualifier  Exp
#> 4953 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 4954                           Standard Units Char Variable Qualifier Perm
#> 4955    Reference Range Lower Limit-Std Units  Num Variable Qualifier Perm
#> 4956    Reference Range Upper Limit-Std Units  Num Variable Qualifier Perm
#> 4957                Reference Range Indicator Char Variable Qualifier Perm
#> 4958                        Completion Status Char   Record Qualifier Perm
#> 4959                          Reason Not Done Char   Record Qualifier Perm
#> 4960                              Vendor Name Char   Record Qualifier Perm
#> 4961                               LOINC Code Char  Synonym Qualifier Perm
#> 4962                            Specimen Type Char   Record Qualifier Perm
#> 4963                       Specimen Condition Char   Record Qualifier Perm
#> 4964            Method of Test or Examination Char   Record Qualifier Perm
#> 4965                          Analysis Method Char   Record Qualifier Perm
#> 4966    Last Observation Before Exposure Flag Char   Record Qualifier Perm
#> 4967                            Baseline Flag Char   Record Qualifier Perm
#> 4968                             Derived Flag Char   Record Qualifier Perm
#> 4969        Clinically Significant, Collected Char   Record Qualifier Perm
#> 4970                             Visit Number  Num             Timing Perm
#> 4971                               Visit Name Char             Timing Perm
#> 4972               Planned Study Day of Visit  Num             Timing Perm
#> 4973      Planned Order of Element within Arm  Num             Timing Perm
#> 4974                                    Epoch Char             Timing Perm
#> 4975                  Date/Time of Collection Char             Timing  Exp
#> 4976       Study Day of Visit/Collection/Exam  Num             Timing Perm
#> 4977                  Planned Time Point Name Char             Timing Perm
#> 4978                Planned Time Point Number  Num             Timing Perm
#> 4979 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 4980                     Time Point Reference Char             Timing Perm
#> 4981        Date/Time of Reference Time Point Char             Timing Perm
#> 4982                         Study Identifier Char         Identifier  Req
#> 4983                      Domain Abbreviation Char         Identifier  Req
#> 4984                Unique Subject Identifier Char         Identifier  Req
#> 4985                          Sequence Number  Num         Identifier  Req
#> 4986                                 Group ID Char         Identifier Perm
#> 4987                             Reference ID Char         Identifier Perm
#> 4988               Sponsor-Defined Identifier Char         Identifier Perm
#> 4989                                  Link ID Char         Identifier Perm
#> 4990                               Link Group Char         Identifier Perm
#> 4991        Short Name of Cardiovascular Test Char              Topic  Req
#> 4992              Name of Cardiovascular Test Char  Synonym Qualifier  Req
#> 4993         Category for Cardiovascular Test Char Grouping Qualifier Perm
#> 4994      Subcategory for Cardiovascular Test Char Grouping Qualifier Perm
#> 4995   Position of Subject During Observation Char   Record Qualifier Perm
#> 4996      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 4997                           Original Units Char Variable Qualifier Perm
#> 4998   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 4999 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 5000                           Standard Units Char Variable Qualifier Perm
#> 5001                        Completion Status Char   Record Qualifier Perm
#> 5002                          Reason Not Done Char   Record Qualifier Perm
#> 5003        Location Used for the Measurement Char   Record Qualifier Perm
#> 5004                               Laterality Char Variable Qualifier Perm
#> 5005                           Directionality Char Variable Qualifier Perm
#> 5006            Method of Test or Examination Char   Record Qualifier Perm
#> 5007    Last Observation Before Exposure Flag Char   Record Qualifier  Exp
#> 5008                            Baseline Flag Char   Record Qualifier Perm
#> 5009                             Derived Flag Char   Record Qualifier Perm
#> 5010                                Evaluator Char   Record Qualifier Perm
#> 5011                     Evaluator Identifier Char Variable Qualifier Perm
#> 5012                             Visit Number  Num             Timing  Exp
#> 5013                               Visit Name Char             Timing Perm
#> 5014               Planned Study Day of Visit  Num             Timing Perm
#> 5015      Planned Order of Element within Arm  Num             Timing Perm
#> 5016                                    Epoch Char             Timing Perm
#> 5017                        Date/Time of Test Char             Timing  Exp
#> 5018       Study Day of Visit/Collection/Exam  Num             Timing Perm
#> 5019                  Planned Time Point Name Char             Timing Perm
#> 5020                Planned Time Point Number  Num             Timing Perm
#> 5021 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5022                     Time Point Reference Char             Timing Perm
#> 5023        Date/Time of Reference Time Point Char             Timing Perm
#> 5024                         Study Identifier Char         Identifier  Req
#> 5025                      Domain Abbreviation Char         Identifier  Req
#> 5026                Unique Subject Identifier Char         Identifier  Req
#> 5027                          Sequence Number  Num         Identifier  Req
#> 5028                                 Group ID Char         Identifier Perm
#> 5029                             Reference ID Char         Identifier Perm
#> 5030               Sponsor-Defined Identifier Char         Identifier Perm
#> 5031                                  Link ID Char         Identifier Perm
#> 5032                            Link Group ID Char         Identifier Perm
#> 5033  Short Name of Accountability Assessment Char              Topic  Req
#> 5034        Name of Accountability Assessment Char  Synonym Qualifier  Req
#> 5035                                 Category Char Grouping Qualifier Perm
#> 5036                              Subcategory Char Grouping Qualifier Perm
#> 5037      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5038                           Original Units Char Variable Qualifier Perm
#> 5039     Result or Finding in Standard Format Char   Result Qualifier  Exp
#> 5040 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 5041                           Standard Units Char Variable Qualifier Perm
#> 5042                        Completion Status Char   Record Qualifier Perm
#> 5043                          Reason Not Done Char   Record Qualifier Perm
#> 5044                             Visit Number  Num             Timing  Exp
#> 5045                               Visit Name Char             Timing Perm
#> 5046               Planned Study Day of Visit  Num             Timing Perm
#> 5047      Planned Order of Element within Arm  Num             Timing Perm
#> 5048                                    Epoch Char             Timing Perm
#> 5049                  Date/Time of Collection Char             Timing  Exp
#> 5050       Study Day of Visit/Collection/Exam  Num             Timing Perm
#> 5051                         Study Identifier Char         Identifier  Req
#> 5052                      Domain Abbreviation Char         Identifier  Req
#> 5053                Unique Subject Identifier Char         Identifier  Req
#> 5054                          Sequence Number  Num         Identifier  Req
#> 5055       Death Detail Assessment Short Name Char              Topic  Req
#> 5056             Death Detail Assessment Name Char  Synonym Qualifier  Req
#> 5057           Result or Finding as Collected Char   Result Qualifier  Exp
#> 5058   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5059                          Result Category Char Variable Qualifier Perm
#> 5060                                Evaluator Char   Record Qualifier Perm
#> 5061                  Date/Time of Collection Char             Timing  Exp
#> 5062                  Study Day of Collection  Num             Timing Perm
#> 5063                         Study Identifier Char         Identifier  Req
#> 5064                      Domain Abbreviation Char         Identifier  Req
#> 5065                Unique Subject Identifier Char         Identifier  Req
#> 5066                Sponsor Device Identifier Char         Identifier Perm
#> 5067                          Sequence Number  Num         Identifier  Req
#> 5068                                 Group ID Char         Identifier Perm
#> 5069                         ECG Reference ID Char         Identifier Perm
#> 5070               Sponsor-Defined Identifier Char         Identifier Perm
#> 5071                          ECG Beat Number  Num         Identifier Perm
#> 5072       ECG Test or Examination Short Name Char              Topic  Req
#> 5073             ECG Test or Examination Name Char  Synonym Qualifier  Req
#> 5074                         Category for ECG Char Grouping Qualifier Perm
#> 5075                      Subcategory for ECG Char Grouping Qualifier Perm
#> 5076                  ECG Position of Subject Char   Record Qualifier Perm
#> 5077      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5078                           Original Units Char Variable Qualifier Perm
#> 5079   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5080 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 5081                           Standard Units Char Variable Qualifier Perm
#> 5082                        Completion Status Char   Record Qualifier Perm
#> 5083                      Reason ECG Not Done Char   Record Qualifier Perm
#> 5084                   ECG External File Path Char   Record Qualifier Perm
#> 5085                              Vendor Name Char   Record Qualifier Perm
#> 5086            Method of Test or Examination Char   Record Qualifier Perm
#> 5087       Lead Location Used for Measurement Char   Record Qualifier Perm
#> 5088    Last Observation Before Exposure Flag Char   Record Qualifier  Exp
#> 5089                            Baseline Flag Char   Record Qualifier Perm
#> 5090                             Derived Flag Char   Record Qualifier Perm
#> 5091                                Evaluator Char   Record Qualifier Perm
#> 5092                     Evaluator Identifier Char Variable Qualifier Perm
#> 5093        Clinically Significant, Collected Char   Record Qualifier Perm
#> 5094                        Repetition Number  Num   Record Qualifier Perm
#> 5095                             Visit Number  Num             Timing  Exp
#> 5096                               Visit Name Char             Timing Perm
#> 5097               Planned Study Day of Visit  Num             Timing Perm
#> 5098      Planned Order of Element within Arm  Num             Timing Perm
#> 5099                                    Epoch Char             Timing Perm
#> 5100                         Date/Time of ECG Char             Timing  Exp
#> 5101                         Study Day of ECG  Num             Timing Perm
#> 5102                  Planned Time Point Name Char             Timing Perm
#> 5103                Planned Time Point Number  Num             Timing Perm
#> 5104 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5105                     Time Point Reference Char             Timing Perm
#> 5106        Date/Time of Reference Time Point Char             Timing Perm
#> 5107                         Study Identifier Char         Identifier  Req
#> 5108                      Domain Abbreviation Char         Identifier  Req
#> 5109                Unique Subject Identifier Char         Identifier  Req
#> 5110                          Sequence Number  Num         Identifier  Req
#> 5111                                 Group ID Char         Identifier Perm
#> 5112                             Reference ID Char         Identifier Perm
#> 5113               Sponsor-Defined Identifier Char         Identifier Perm
#> 5114                       Short Name of Test Char              Topic  Req
#> 5115                             Name of Test Char  Synonym Qualifier  Req
#> 5116                                 Category Char Grouping Qualifier  Req
#> 5117                              Subcategory Char Grouping Qualifier Perm
#> 5118   Position of Subject During Observation Char   Record Qualifier Perm
#> 5119      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5120                           Original Units Char Variable Qualifier Perm
#> 5121     Result or Finding in Standard Format Char   Result Qualifier  Exp
#> 5122 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 5123                           Standard Units Char Variable Qualifier Perm
#> 5124                        Completion Status Char   Record Qualifier Perm
#> 5125                          Reason Not Done Char   Record Qualifier Perm
#> 5126                       External File Path Char   Record Qualifier Perm
#> 5127                              Vendor Name Char   Record Qualifier Perm
#> 5128            Method of Test or Examination Char   Record Qualifier Perm
#> 5129    Last Observation Before Exposure Flag Char   Record Qualifier  Exp
#> 5130                            Baseline Flag Char   Record Qualifier Perm
#> 5131                             Derived Flag Char   Record Qualifier Perm
#> 5132                        Repetition Number  Num   Record Qualifier Perm
#> 5133                             Visit Number  Num             Timing  Exp
#> 5134                               Visit Name Char             Timing Perm
#> 5135               Planned Study Day of Visit  Num             Timing Perm
#> 5136      Planned Order of Element within Arm  Num             Timing Perm
#> 5137                                    Epoch Char             Timing Perm
#> 5138                        Date/Time of Test Char             Timing  Exp
#> 5139                        Study Day of Test  Num             Timing Perm
#> 5140                  Planned Time Point Name Char             Timing Perm
#> 5141                Planned Time Point Number  Num             Timing Perm
#> 5142 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5143                     Time Point Reference Char             Timing Perm
#> 5144        Date/Time of Reference Time Point Char             Timing Perm
#> 5145                         Study Identifier Char         Identifier  Req
#> 5146                      Domain Abbreviation Char         Identifier  Req
#> 5147                Unique Subject Identifier Char         Identifier  Req
#> 5148                Sponsor Device Identifier Char         Identifier Perm
#> 5149             Non-Host Organism Identifier Char         Identifier Perm
#> 5150                          Sequence Number  Num         Identifier  Req
#> 5151                                 Group ID Char         Identifier Perm
#> 5152                             Reference ID Char         Identifier  Exp
#> 5153               Sponsor-Defined Identifier Char         Identifier Perm
#> 5154                                  Link ID Char         Identifier Perm
#> 5155                            Link Group ID Char         Identifier Perm
#> 5156        Short Name of Genomic Measurement Char              Topic  Req
#> 5157              Name of Genomic Measurement Char  Synonym Qualifier  Req
#> 5158 Measurement, Test, or Examination Detail Char Variable Qualifier Perm
#> 5159             Category for Genomic Finding Char Grouping Qualifier Perm
#> 5160          Subcategory for Genomic Finding Char Grouping Qualifier Perm
#> 5161      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5162                           Original Units Char Variable Qualifier Perm
#> 5163       Reference Result in Original Units Char Variable Qualifier Perm
#> 5164     Result or Finding in Standard Format Char   Result Qualifier  Exp
#> 5165 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 5166                           Standard Units Char Variable Qualifier Perm
#> 5167      Reference Result in Standard Format Char Variable Qualifier Perm
#> 5168    Numeric Reference Result in Std Units  Num Variable Qualifier Perm
#> 5169                          Result Category Char Variable Qualifier Perm
#> 5170                           Inheritability Char Variable Qualifier Perm
#> 5171                         Genome Reference Char Variable Qualifier Perm
#> 5172                    Chromosome Identifier Char Variable Qualifier Perm
#> 5173                           Genomic Symbol Char Variable Qualifier Perm
#> 5174                      Genomic Symbol Type Char Variable Qualifier Perm
#> 5175                         Genetic Location Char Variable Qualifier Perm
#> 5176                       Genetic Sub-Region Char Variable Qualifier Perm
#> 5177                  Sequence Identifier \\n Char Variable Qualifier Perm
#> 5178             Published Variant Identifier Char Variable Qualifier Perm
#> 5179                          Copy Identifier Char Variable Qualifier Perm
#> 5180                        Completion Status Char   Record Qualifier Perm
#> 5181                     Reason Test Not Done Char   Record Qualifier Perm
#> 5182                       External File Path Char   Record Qualifier Perm
#> 5183                   Laboratory/Vendor Name Char   Record Qualifier Perm
#> 5184                   Specimen Material Type Char   Record Qualifier Perm
#> 5185            Method of Test or Examination Char   Record Qualifier  Exp
#> 5186                                   Run ID Char   Record Qualifier Perm
#> 5187                          Analysis Method Char   Record Qualifier Perm
#> 5188                            Baseline Flag Char   Record Qualifier Perm
#> 5189                             Derived Flag Char   Record Qualifier Perm
#> 5190              Lower Limit of Quantitation  Num Variable Qualifier Perm
#> 5191                        Repetition Number  Num   Record Qualifier Perm
#> 5192                             Visit Number  Num             Timing  Exp
#> 5193                               Visit Name Char             Timing Perm
#> 5194               Planned Study Day of Visit  Num             Timing Perm
#> 5195         Date/Time of Specimen Collection Char             Timing  Exp
#> 5196         Study Day of Specimen Collection  Num             Timing Perm
#> 5197                  Planned Time Point Name Char             Timing Perm
#> 5198                Planned Time Point Number  Num             Timing Perm
#> 5199 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5200                     Time Point Reference Char             Timing Perm
#> 5201        Date/Time of Reference Time Point Char             Timing Perm
#> 5202                         Study Identifier Char         Identifier  Req
#> 5203                      Domain Abbreviation Char         Identifier  Req
#> 5204                Unique Subject Identifier Char         Identifier  Req
#> 5205                          Sequence Number  Num         Identifier  Req
#> 5206               Sponsor-Defined Identifier Char         Identifier Perm
#> 5207 Inclusion/Exclusion Criterion Short Name Char              Topic  Req
#> 5208            Inclusion/Exclusion Criterion Char  Synonym Qualifier  Req
#> 5209             Inclusion/Exclusion Category Char Grouping Qualifier  Req
#> 5210          Inclusion/Exclusion Subcategory Char Grouping Qualifier Perm
#> 5211            I/E Criterion Original Result Char   Result Qualifier  Req
#> 5212       I/E Criterion Result in Std Format Char   Result Qualifier  Req
#> 5213                             Visit Number  Num             Timing Perm
#> 5214                               Visit Name Char             Timing Perm
#> 5215               Planned Study Day of Visit  Num             Timing Perm
#> 5216      Planned Order of Element within Arm  Num             Timing Perm
#> 5217                                    Epoch Char             Timing Perm
#> 5218                  Date/Time of Collection Char             Timing Perm
#> 5219                  Study Day of Collection  Num             Timing Perm
#> 5220                         Study Identifier Char         Identifier  Req
#> 5221                      Domain Abbreviation Char         Identifier  Req
#> 5222                Unique Subject Identifier Char         Identifier  Req
#> 5223                     Non-host Organism ID Char         Identifier Perm
#> 5224                          Sequence Number  Num         Identifier  Req
#> 5225                                 Group ID Char         Identifier Perm
#> 5226                             Reference ID Char         Identifier Perm
#> 5227               Sponsor-Defined Identifier Char         Identifier Perm
#> 5228      Immunogenicity Test/Exam Short Name Char              Topic  Req
#> 5229  Immunogenicity Test or Examination Name Char  Synonym Qualifier  Req
#> 5230                           Test Condition Char Variable Qualifier Perm
#> 5231                     Test Condition Agent Char   Record Qualifier Perm
#> 5232                            Binding Agent Char Variable Qualifier Perm
#> 5233               Test Operational Objective Char Variable Qualifier Perm
#> 5234               Molecule Secreted by Cells Char Variable Qualifier Perm
#> 5235                              Test Detail Char Variable Qualifier Perm
#> 5236         Category for Immunogenicity Test Char Grouping Qualifier Perm
#> 5237      Subcategory for Immunogenicity Test Char Grouping Qualifier Perm
#> 5238    Results or Findings in Original Units Char   Result Qualifier  Exp
#> 5239                           Original Units Char Variable Qualifier  Exp
#> 5240 Reference Range Lower Limit in Orig Unit Char Variable Qualifier  Exp
#> 5241 Reference Range Upper Limit in Orig Unit Char Variable Qualifier  Exp
#> 5242   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5243   Numeric Results/Findings in Std. Units  Num   Result Qualifier  Exp
#> 5244                           Standard Units Char Variable Qualifier  Exp
#> 5245    Reference Range Lower Limit-Std Units  Num Variable Qualifier  Exp
#> 5246    Reference Range Upper Limit-Std Units  Num Variable Qualifier  Exp
#> 5247  Reference Range for Char Rslt-Std Units Char Variable Qualifier Perm
#> 5248                Reference Range Indicator Char Variable Qualifier  Exp
#> 5249                        Completion Status Char   Record Qualifier Perm
#> 5250                          Reason Not Done Char   Record Qualifier Perm
#> 5251                              Vendor Name Char   Record Qualifier Perm
#> 5252                            Specimen Type Char   Record Qualifier Perm
#> 5253                       Specimen Condition Char   Record Qualifier Perm
#> 5254          Specimen Usability for the Test Char   Record Qualifier Perm
#> 5255            Method of Test or Examination Char   Record Qualifier Perm
#> 5256    Last Observation Before Exposure Flag Char   Record Qualifier Perm
#> 5257                            Baseline Flag Char   Record Qualifier Perm
#> 5258                             Derived Flag Char   Record Qualifier Perm
#> 5259              Lower Limit of Quantitation  Num Variable Qualifier  Exp
#> 5260                             Visit Number  Num             Timing  Exp
#> 5261                               Visit Name Char             Timing Perm
#> 5262               Planned Study Day of Visit  Num             Timing Perm
#> 5263      Planned Order of Element within Arm  Num             Timing Perm
#> 5264                                    Epoch Char             Timing Perm
#> 5265                  Date/Time of Collection Char             Timing  Exp
#> 5266     End Date/Time of Specimen Collection Char             Timing Perm
#> 5267       Study Day of Visit/Collection/Exam  Num             Timing Perm
#> 5268  Study Day of End of Specimen Collection  Num             Timing Perm
#> 5269                  Planned Time Point Name Char             Timing Perm
#> 5270                Planned Time Point Number  Num             Timing Perm
#> 5271 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5272                     Time Point Reference Char             Timing Perm
#> 5273        Date/Time of Reference Time Point Char             Timing Perm
#> 5274                         Study Identifier Char         Identifier  Req
#> 5275                      Domain Abbreviation Char         Identifier  Req
#> 5276                Unique Subject Identifier Char         Identifier  Req
#> 5277                          Sequence Number  Num         Identifier  Req
#> 5278                                 Group ID Char         Identifier Perm
#> 5279                              Specimen ID Char         Identifier Perm
#> 5280               Sponsor-Defined Identifier Char         Identifier Perm
#> 5281       Lab Test or Examination Short Name Char              Topic  Req
#> 5282             Lab Test or Examination Name Char  Synonym Qualifier  Req
#> 5283                           Test Condition Char Variable Qualifier Perm
#> 5284                            Binding Agent Char Variable Qualifier Perm
#> 5285               Test Operational Objective Char Variable Qualifier Perm
#> 5286                    Category for Lab Test Char Grouping Qualifier  Exp
#> 5287                 Subcategory for Lab Test Char Grouping Qualifier Perm
#> 5288      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5289                           Original Units Char Variable Qualifier  Exp
#> 5290                             Result Scale Char   Record Qualifier Perm
#> 5291                              Result Type Char   Record Qualifier Perm
#> 5292            Collected Summary Result Type Char   Record Qualifier Perm
#> 5293 Reference Range Lower Limit in Orig Unit Char Variable Qualifier  Exp
#> 5294 Reference Range Upper Limit in Orig Unit Char Variable Qualifier  Exp
#> 5295                 Lower Limit of Detection Char Variable Qualifier Perm
#> 5296   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5297 Numeric Result/Finding in Standard Units  Num   Result Qualifier  Exp
#> 5298                           Standard Units Char Variable Qualifier  Exp
#> 5299    Reference Range Lower Limit-Std Units  Num Variable Qualifier  Exp
#> 5300    Reference Range Upper Limit-Std Units  Num Variable Qualifier  Exp
#> 5301  Reference Range for Char Rslt-Std Units Char Variable Qualifier Perm
#> 5302                Reference Range Indicator Char Variable Qualifier  Exp
#> 5303                        Completion Status Char   Record Qualifier Perm
#> 5304                     Reason Test Not Done Char   Record Qualifier Perm
#> 5305                              Vendor Name Char   Record Qualifier Perm
#> 5306                               LOINC Code Char  Synonym Qualifier Perm
#> 5307                            Specimen Type Char   Record Qualifier Perm
#> 5308                       Specimen Condition Char   Record Qualifier Perm
#> 5309          Specimen Usability for the Test Char   Record Qualifier Perm
#> 5310            Method of Test or Examination Char   Record Qualifier Perm
#> 5311                          Analysis Method Char   Record Qualifier Perm
#> 5312                  Test Method Sensitivity Char   Record Qualifier Perm
#> 5313    Last Observation Before Exposure Flag Char   Record Qualifier  Exp
#> 5314                            Baseline Flag Char   Record Qualifier Perm
#> 5315                           Fasting Status Char   Record Qualifier Perm
#> 5316                             Derived Flag Char   Record Qualifier Perm
#> 5317                                 Toxicity Char Variable Qualifier Perm
#> 5318                  Standard Toxicity Grade Char   Record Qualifier Perm
#> 5319        Clinically Significant, Collected Char   Record Qualifier Perm
#> 5320                             Visit Number  Num             Timing  Exp
#> 5321                               Visit Name Char             Timing Perm
#> 5322               Planned Study Day of Visit  Num             Timing Perm
#> 5323      Planned Order of Element within Arm  Num             Timing Perm
#> 5324                                    Epoch Char             Timing Perm
#> 5325         Date/Time of Specimen Collection Char             Timing  Exp
#> 5326     End Date/Time of Specimen Collection Char             Timing Perm
#> 5327         Study Day of Specimen Collection  Num             Timing Perm
#> 5328          Study Day of End of Observation  Num             Timing Perm
#> 5329                  Planned Time Point Name Char             Timing Perm
#> 5330                Planned Time Point Number  Num             Timing Perm
#> 5331 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5332                     Time Point Reference Char             Timing Perm
#> 5333        Date/Time of Reference Time Point Char             Timing Perm
#> 5334                       Point in Time Flag Char             Timing Perm
#> 5335                         Planned Duration Char             Timing Perm
#> 5336                         Study Identifier Char         Identifier  Req
#> 5337                      Domain Abbreviation Char         Identifier  Req
#> 5338                Unique Subject Identifier Char         Identifier  Req
#> 5339         Focus of Study-Specific Interest Char         Identifier Perm
#> 5340                          Sequence Number  Num         Identifier  Req
#> 5341                                 Group ID Char         Identifier Perm
#> 5342                             Reference ID Char         Identifier Perm
#> 5343               Sponsor-Defined Identifier Char         Identifier Perm
#> 5344                                  Link ID Char         Identifier Perm
#> 5345                            Link Group ID Char         Identifier Perm
#> 5346  Microbiology Test or Finding Short Name Char              Topic  Req
#> 5347        Microbiology Test or Finding Name Char  Synonym Qualifier  Req
#> 5348  Measurement, Test or Examination Detail Char Variable Qualifier Perm
#> 5349                                 Category Char Grouping Qualifier Perm
#> 5350                              Subcategory Char Grouping Qualifier Perm
#> 5351      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5352                           Original Units Char Variable Qualifier Perm
#> 5353     Result or Finding in Standard Format Char   Result Qualifier  Exp
#> 5354 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 5355                           Standard Units Char Variable Qualifier Perm
#> 5356                          Result Category Char Variable Qualifier Perm
#> 5357                        Completion Status Char   Record Qualifier Perm
#> 5358                          Reason Not Done Char   Record Qualifier Perm
#> 5359                   Laboratory/Vendor Name Char   Record Qualifier Perm
#> 5360                               LOINC Code Char  Synonym Qualifier Perm
#> 5361                   Specimen Material Type Char   Record Qualifier Perm
#> 5362                       Specimen Condition Char   Record Qualifier Perm
#> 5363             Specimen Collection Location Char   Record Qualifier Perm
#> 5364                               Laterality Char Variable Qualifier Perm
#> 5365                           Directionality Char Variable Qualifier Perm
#> 5366            Method of Test or Examination Char   Record Qualifier  Exp
#> 5367    Last Observation Before Exposure Flag Char   Record Qualifier Perm
#> 5368                            Baseline Flag Char   Record Qualifier Perm
#> 5369                           Fasting Status Char   Record Qualifier Perm
#> 5370                             Derived Flag Char   Record Qualifier Perm
#> 5371                             Visit Number  Num             Timing  Exp
#> 5372                               Visit Name Char             Timing Perm
#> 5373               Planned Study Day of Visit  Num             Timing Perm
#> 5374      Planned Order of Element within Arm  Num             Timing Perm
#> 5375                                    Epoch Char             Timing Perm
#> 5376                  Date/Time of Collection Char             Timing  Exp
#> 5377       Study Day of Visit/Collection/Exam  Num             Timing Perm
#> 5378                  Planned Time Point Name Char             Timing Perm
#> 5379                Planned Time Point Number  Num             Timing Perm
#> 5380 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5381                     Time Point Reference Char             Timing Perm
#> 5382        Date/Time of Reference Time Point Char             Timing Perm
#> 5383                         Study Identifier Char         Identifier  Req
#> 5384                      Domain Abbreviation Char         Identifier  Req
#> 5385                Unique Subject Identifier Char         Identifier  Req
#> 5386                          Sequence Number  Num         Identifier  Req
#> 5387                                 Group ID Char         Identifier Perm
#> 5388                             Reference ID Char         Identifier Perm
#> 5389               Sponsor-Defined Identifier Char         Identifier Perm
#> 5390       Microscopic Examination Short Name Char              Topic  Req
#> 5391             Microscopic Examination Name Char  Synonym Qualifier  Req
#> 5392           Microscopic Examination Detail Char   Record Qualifier Perm
#> 5393         Category for Microscopic Finding Char Grouping Qualifier Perm
#> 5394      Subcategory for Microscopic Finding Char Grouping Qualifier Perm
#> 5395      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5396                           Original Units Char Variable Qualifier Perm
#> 5397   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5398 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 5399                           Standard Units Char Variable Qualifier Perm
#> 5400                          Result Category Char Variable Qualifier Perm
#> 5401                        Completion Status Char   Record Qualifier Perm
#> 5402                          Reason Not Done Char   Record Qualifier Perm
#> 5403                   Laboratory/Vendor Name Char   Record Qualifier Perm
#> 5404                   Specimen Material Type Char   Record Qualifier  Req
#> 5405                       Specimen Condition Char   Record Qualifier  Exp
#> 5406             Specimen Collection Location Char   Record Qualifier Perm
#> 5407       Specimen Laterality within Subject Char Variable Qualifier Perm
#> 5408   Specimen Directionality within Subject Char Variable Qualifier Perm
#> 5409            Method of Test or Examination Char   Record Qualifier Perm
#> 5410    Last Observation Before Exposure Flag Char   Record Qualifier  Exp
#> 5411                            Baseline Flag Char   Record Qualifier Perm
#> 5412                                Evaluator Char   Record Qualifier Perm
#> 5413                             Visit Number  Num             Timing  Exp
#> 5414                               Visit Name Char             Timing Perm
#> 5415               Planned Study Day of Visit  Num             Timing Perm
#> 5416      Planned Order of Element within Arm  Num             Timing Perm
#> 5417                                    Epoch Char             Timing Perm
#> 5418         Date/Time of Specimen Collection Char             Timing  Exp
#> 5419         Study Day of Specimen Collection  Num             Timing Perm
#> 5420                         Study Identifier Char         Identifier  Req
#> 5421                      Domain Abbreviation Char         Identifier  Req
#> 5422                Unique Subject Identifier Char         Identifier  Req
#> 5423                          Sequence Number  Num         Identifier  Req
#> 5424                                 Group ID Char         Identifier Perm
#> 5425                             Reference ID Char         Identifier Perm
#> 5426               Sponsor-Defined Identifier Char         Identifier Perm
#> 5427                                  Link ID Char         Identifier Perm
#> 5428                            Link Group ID Char         Identifier Perm
#> 5429       Short Name of Musculoskeletal Test Char              Topic  Req
#> 5430             Name of Musculoskeletal Test Char  Synonym Qualifier  Req
#> 5431        Category for Musculoskeletal Test Char Grouping Qualifier Perm
#> 5432     Subcategory for Musculoskeletal Test Char Grouping Qualifier Perm
#> 5433                      Position of Subject Char   Record Qualifier Perm
#> 5434      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5435                           Original Units Char Variable Qualifier Perm
#> 5436   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5437 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 5438                           Standard Units Char Variable Qualifier Perm
#> 5439                        Completion Status Char   Record Qualifier Perm
#> 5440                          Reason Not Done Char   Record Qualifier Perm
#> 5441        Location Used for the Measurement Char   Record Qualifier  Exp
#> 5442                               Laterality Char Variable Qualifier Perm
#> 5443                           Directionality Char Variable Qualifier Perm
#> 5444            Method of Test or Examination Char   Record Qualifier Perm
#> 5445    Last Observation Before Exposure Flag Char   Record Qualifier  Exp
#> 5446                            Baseline Flag Char   Record Qualifier Perm
#> 5447                             Derived Flag Char   Record Qualifier Perm
#> 5448                                Evaluator Char   Record Qualifier Perm
#> 5449                     Evaluator Identifier Char Variable Qualifier Perm
#> 5450                             Visit Number  Num             Timing  Exp
#> 5451                               Visit Name Char             Timing Perm
#> 5452               Planned Study Day of Visit  Num             Timing Perm
#> 5453      Planned Order of Element within Arm  Num             Timing Perm
#> 5454                                    Epoch Char             Timing Perm
#> 5455                  Date/Time of Collection Char             Timing  Exp
#> 5456       Study Day of Visit/Collection/Exam  Num             Timing Perm
#> 5457                  Planned Time Point Name Char             Timing Perm
#> 5458                Planned Time Point Number  Num             Timing Perm
#> 5459 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5460                     Time Point Reference Char             Timing Perm
#> 5461        Date/Time of Reference Time Point Char             Timing Perm
#> 5462                         Study Identifier Char         Identifier  Req
#> 5463                      Domain Abbreviation Char         Identifier  Req
#> 5464                Unique Subject Identifier Char         Identifier  Req
#> 5465                     Non-host Organism ID Char         Identifier Perm
#> 5466                          Sequence Number  Num         Identifier  Req
#> 5467                                 Group ID Char         Identifier Perm
#> 5468                             Reference ID Char         Identifier Perm
#> 5469               Sponsor-Defined Identifier Char         Identifier Perm
#> 5470                                  Link ID Char         Identifier Perm
#> 5471                 Short Name of Assessment Char              Topic  Req
#> 5472                       Name of Assessment Char  Synonym Qualifier  Req
#> 5473                               Agent Name Char Variable Qualifier  Exp
#> 5474                      Agent Concentration  Num Variable Qualifier Perm
#> 5475                Agent Concentration Units Char Variable Qualifier Perm
#> 5476  Measurement, Test or Examination Detail Char Variable Qualifier Perm
#> 5477                                 Category Char Grouping Qualifier Perm
#> 5478                              Subcategory Char Grouping Qualifier Perm
#> 5479      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5480                           Original Units Char Variable Qualifier Perm
#> 5481     Result or Finding in Standard Format Char   Result Qualifier  Exp
#> 5482 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 5483                           Standard Units Char Variable Qualifier Perm
#> 5484         Normal/Reference Range Indicator Char Variable Qualifier Perm
#> 5485                          Result Category Char Variable Qualifier Perm
#> 5486                        Completion Status Char   Record Qualifier Perm
#> 5487                          Reason Not Done Char   Record Qualifier Perm
#> 5488                       External File Path Char   Record Qualifier Perm
#> 5489                   Laboratory/Vendor Name Char   Record Qualifier Perm
#> 5490                               LOINC Code Char  Synonym Qualifier Perm
#> 5491                   Specimen Material Type Char   Record Qualifier Perm
#> 5492                       Specimen Condition Char   Record Qualifier Perm
#> 5493        Location Used for the Measurement Char   Record Qualifier Perm
#> 5494                               Laterality Char Variable Qualifier Perm
#> 5495                           Directionality Char Variable Qualifier Perm
#> 5496            Method of Test or Examination Char   Record Qualifier Perm
#> 5497                          Analysis Method Char   Record Qualifier Perm
#> 5498    Last Observation Before Exposure Flag Char   Record Qualifier Perm
#> 5499                            Baseline Flag Char   Record Qualifier Perm
#> 5500                           Fasting Status Char   Record Qualifier Perm
#> 5501                             Derived Flag Char   Record Qualifier Perm
#> 5502                                Evaluator Char   Record Qualifier Perm
#> 5503                     Evaluator Identifier Char Variable Qualifier Perm
#> 5504                     Accepted Record Flag Char   Record Qualifier Perm
#> 5505              Lower Limit of Quantitation  Num Variable Qualifier Perm
#> 5506              Upper Limit of Quantitation  Num Variable Qualifier Perm
#> 5507                        Repetition Number  Num   Record Qualifier Perm
#> 5508                             Visit Number  Num             Timing  Exp
#> 5509                               Visit Name Char             Timing Perm
#> 5510               Planned Study Day of Visit  Num             Timing Perm
#> 5511      Planned Order of Element within Arm  Num             Timing Perm
#> 5512                                    Epoch Char             Timing Perm
#> 5513                  Date/Time of Collection Char             Timing Perm
#> 5514       Study Day of Visit/Collection/Exam  Num             Timing Perm
#> 5515                                 Duration Char             Timing Perm
#> 5516                  Planned Time Point Name Char             Timing Perm
#> 5517                Planned Time Point Number  Num             Timing Perm
#> 5518 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5519                     Time Point Reference Char             Timing Perm
#> 5520        Date/Time of Reference Time Point Char             Timing Perm
#> 5521                      Evaluation Interval Char             Timing Perm
#> 5522                 Evaluation Interval Text Char             Timing Perm
#> 5523                         Study Identifier Char         Identifier  Req
#> 5524                      Domain Abbreviation Char         Identifier  Req
#> 5525                Unique Subject Identifier Char         Identifier  Req
#> 5526         Focus of Study-Specific Interest Char         Identifier Perm
#> 5527                          Sequence Number  Num         Identifier  Req
#> 5528                                 Group ID Char         Identifier Perm
#> 5529                             Reference ID Char         Identifier Perm
#> 5530               Sponsor-Defined Identifier Char         Identifier Perm
#> 5531                                  Link ID Char         Identifier Perm
#> 5532                               Link Group Char         Identifier Perm
#> 5533        Short Name of Nervous System Test Char              Topic  Req
#> 5534              Name of Nervous System Test Char  Synonym Qualifier  Req
#> 5535         Category for Nervous System Test Char Grouping Qualifier Perm
#> 5536      Subcategory for Nervous System Test Char Grouping Qualifier Perm
#> 5537      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5538                           Original Units Char Variable Qualifier Perm
#> 5539   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5540 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 5541                           Standard Units Char Variable Qualifier Perm
#> 5542                        Completion Status Char   Record Qualifier Perm
#> 5543                          Reason Not Done Char   Record Qualifier Perm
#> 5544        Location Used for the Measurement Char   Record Qualifier Perm
#> 5545                               Laterality Char Variable Qualifier Perm
#> 5546                           Directionality Char Variable Qualifier Perm
#> 5547            Method of Test or Examination Char   Record Qualifier Perm
#> 5548    Last Observation Before Exposure Flag Char   Record Qualifier Perm
#> 5549                            Baseline Flag Char   Record Qualifier Perm
#> 5550                             Derived Flag Char   Record Qualifier Perm
#> 5551                                Evaluator Char   Record Qualifier Perm
#> 5552                     Evaluator Identifier Char Variable Qualifier Perm
#> 5553                             Visit Number  Num             Timing  Exp
#> 5554                               Visit Name Char             Timing Perm
#> 5555               Planned Study Day of Visit  Num             Timing Perm
#> 5556      Planned Order of Element within Arm  Num             Timing Perm
#> 5557                                    Epoch Char             Timing Perm
#> 5558                  Date/Time of Collection Char             Timing  Exp
#> 5559       Study Day of Visit/Collection/Exam  Num             Timing Perm
#> 5560                  Planned Time Point Name Char             Timing Perm
#> 5561                Planned Time Point Number  Num             Timing Perm
#> 5562 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5563                     Time Point Reference Char             Timing Perm
#> 5564        Date/Time of Reference Time Point Char             Timing Perm
#> 5565                         Study Identifier Char         Identifier  Req
#> 5566                      Domain Abbreviation Char         Identifier  Req
#> 5567                Unique Subject Identifier Char         Identifier  Req
#> 5568         Focus of Study-Specific Interest Char         Identifier Perm
#> 5569                          Sequence Number  Num         Identifier  Req
#> 5570                                 Group ID Char         Identifier Perm
#> 5571                                  Link ID Char         Identifier Perm
#> 5572                               Link Group Char         Identifier Perm
#> 5573    Short Name of Ophthalmic Test or Exam Char              Topic  Req
#> 5574          Name of Ophthalmic Test or Exam Char  Synonym Qualifier  Req
#> 5575           Ophthalmic Test or Exam Detail Char Variable Qualifier Perm
#> 5576     Category for Ophthalmic Test or Exam Char Grouping Qualifier Perm
#> 5577  Subcategory for Ophthalmic Test or Exam Char Grouping Qualifier Perm
#> 5578      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5579                           Original Units Char Variable Qualifier  Exp
#> 5580  Normal Range Lower Limit-Original Units Char Variable Qualifier Perm
#> 5581  Normal Range Upper Limit-Original Units Char Variable Qualifier Perm
#> 5582   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5583 Numeric Result/Finding in Standard Units  Num   Result Qualifier  Exp
#> 5584                           Standard Units Char Variable Qualifier  Exp
#> 5585  Normal Range Lower Limit-Standard Units  Num Variable Qualifier Perm
#> 5586  Normal Range Upper Limit-Standard Units  Num Variable Qualifier Perm
#> 5587       Normal Range for Character Results Char Variable Qualifier Perm
#> 5588         Normal/Reference Range Indicator Char Variable Qualifier Perm
#> 5589                          Result Category Char Variable Qualifier Perm
#> 5590                        Completion Status Char   Record Qualifier Perm
#> 5591                          Reason Not Done Char   Record Qualifier Perm
#> 5592                       External File Path Char   Record Qualifier Perm
#> 5593        Location Used for the Measurement Char   Record Qualifier  Exp
#> 5594                               Laterality Char Variable Qualifier  Exp
#> 5595                           Directionality Char Variable Qualifier Perm
#> 5596                      Portion or Totality Char Variable Qualifier Perm
#> 5597            Method of Test or Examination Char   Record Qualifier  Exp
#> 5598    Last Observation Before Exposure Flag Char   Record Qualifier  Exp
#> 5599                            Baseline Flag Char   Record Qualifier Perm
#> 5600                             Derived Flag Char   Record Qualifier Perm
#> 5601                                Evaluator Char   Record Qualifier Perm
#> 5602                     Evaluator Identifier Char Variable Qualifier Perm
#> 5603                     Accepted Record Flag Char   Record Qualifier Perm
#> 5604                        Repetition Number  Num   Record Qualifier Perm
#> 5605                             Visit Number  Num             Timing  Exp
#> 5606                               Visit Name Char             Timing Perm
#> 5607               Planned Study Day of Visit  Num             Timing Perm
#> 5608      Planned Order of Element within Arm  Num             Timing Perm
#> 5609                                    Epoch Char             Timing Perm
#> 5610                  Date/Time of Collection Char             Timing  Exp
#> 5611       Study Day of Visit/Collection/Exam  Num             Timing  Exp
#> 5612                  Planned Time Point Name Char             Timing Perm
#> 5613                Planned Time Point Number  Num             Timing Perm
#> 5614 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5615                     Time Point Reference Char             Timing Perm
#> 5616        Date/Time of Reference Time Point Char             Timing Perm
#> 5617                         Study Identifier Char         Identifier  Req
#> 5618                      Domain Abbreviation Char         Identifier  Req
#> 5619                Unique Subject Identifier Char         Identifier  Req
#> 5620                          Sequence Number  Num         Identifier  Req
#> 5621                                 Group ID Char         Identifier Perm
#> 5622                             Reference ID Char         Identifier Perm
#> 5623               Sponsor-Defined Identifier Char         Identifier Perm
#> 5624          Pharmacokinetic Test Short Name Char              Topic  Req
#> 5625                Pharmacokinetic Test Name Char  Synonym Qualifier  Req
#> 5626                            Test Category Char Grouping Qualifier Perm
#> 5627                         Test Subcategory Char Grouping Qualifier Perm
#> 5628      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5629                           Original Units Char Variable Qualifier  Exp
#> 5630   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5631 Numeric Result/Finding in Standard Units  Num   Result Qualifier  Exp
#> 5632                           Standard Units Char Variable Qualifier  Exp
#> 5633                        Completion Status Char   Record Qualifier Perm
#> 5634                     Reason Test Not Done Char   Record Qualifier Perm
#> 5635                              Vendor Name Char   Record Qualifier  Exp
#> 5636                   Specimen Material Type Char   Record Qualifier  Exp
#> 5637                       Specimen Condition Char   Record Qualifier Perm
#> 5638            Method of Test or Examination Char   Record Qualifier Perm
#> 5639                           Fasting Status Char   Record Qualifier Perm
#> 5640                             Derived Flag Char   Record Qualifier Perm
#> 5641              Lower Limit of Quantitation  Num Variable Qualifier  Exp
#> 5642              Upper Limit of Quantitation  Num Variable Qualifier Perm
#> 5643                             Visit Number  Num             Timing  Exp
#> 5644                               Visit Name Char             Timing Perm
#> 5645               Planned Study Day of Visit  Num             Timing Perm
#> 5646      Planned Order of Element within Arm  Num             Timing Perm
#> 5647                                    Epoch Char             Timing Perm
#> 5648         Date/Time of Specimen Collection Char             Timing  Exp
#> 5649     End Date/Time of Specimen Collection Char             Timing Perm
#> 5650  Actual Study Day of Specimen Collection  Num             Timing Perm
#> 5651          Study Day of End of Observation  Num             Timing Perm
#> 5652                  Planned Time Point Name Char             Timing Perm
#> 5653                Planned Time Point Number  Num             Timing Perm
#> 5654 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5655                     Time Point Reference Char             Timing Perm
#> 5656             Date/Time of Reference Point Char             Timing Perm
#> 5657                      Evaluation Interval Char             Timing Perm
#> 5658                         Study Identifier Char         Identifier  Req
#> 5659                      Domain Abbreviation Char         Identifier  Req
#> 5660                Unique Subject Identifier Char         Identifier  Req
#> 5661                          Sequence Number  Num         Identifier  Req
#> 5662                                 Group ID Char         Identifier Perm
#> 5663               Sponsor-Defined Identifier Char         Identifier Perm
#> 5664          Body System Examined Short Name Char              Topic  Req
#> 5665                     Body System Examined Char  Synonym Qualifier  Req
#> 5666                   Modified Reported Term Char  Synonym Qualifier Perm
#> 5667                 Category for Examination Char Grouping Qualifier Perm
#> 5668              Subcategory for Examination Char Grouping Qualifier Perm
#> 5669               Body System or Organ Class Char   Record Qualifier Perm
#> 5670             Verbatim Examination Finding Char   Result Qualifier  Exp
#> 5671                           Original Units Char Variable Qualifier Perm
#> 5672   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5673                        Completion Status Char   Record Qualifier Perm
#> 5674                      Reason Not Examined Char   Record Qualifier Perm
#> 5675        Location of Physical Exam Finding Char   Record Qualifier Perm
#> 5676                               Laterality Char Variable Qualifier Perm
#> 5677            Method of Test or Examination Char   Record Qualifier Perm
#> 5678    Last Observation Before Exposure Flag Char   Record Qualifier Perm
#> 5679                            Baseline Flag Char   Record Qualifier Perm
#> 5680                                Evaluator Char   Record Qualifier Perm
#> 5681                             Visit Number  Num             Timing  Exp
#> 5682                               Visit Name Char             Timing Perm
#> 5683               Planned Study Day of Visit  Num             Timing Perm
#> 5684      Planned Order of Element within Arm  Num             Timing Perm
#> 5685                                    Epoch Char             Timing Perm
#> 5686                 Date/Time of Examination Char             Timing  Exp
#> 5687                 Study Day of Examination  Num             Timing Perm
#> 5688                         Study Identifier Char         Identifier  Req
#> 5689                      Domain Abbreviation Char         Identifier  Req
#> 5690                Unique Subject Identifier Char         Identifier  Req
#> 5691                          Sequence Number  Num         Identifier  Req
#> 5692                                 Group ID Char         Identifier Perm
#> 5693                     Parameter Short Name Char              Topic  Req
#> 5694                           Parameter Name Char  Synonym Qualifier  Req
#> 5695                       Parameter Category Char Grouping Qualifier  Exp
#> 5696                    Parameter Subcategory Char Grouping Qualifier Perm
#> 5697      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5698                           Original Units Char Variable Qualifier  Exp
#> 5699   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5700 Numeric Result/Finding in Standard Units  Num   Result Qualifier  Exp
#> 5701                           Standard Units Char Variable Qualifier  Exp
#> 5702                        Completion Status Char   Record Qualifier Perm
#> 5703          Reason Parameter Not Calculated Char   Record Qualifier Perm
#> 5704                   Specimen Material Type Char   Record Qualifier  Exp
#> 5705                          Analysis Method Char   Record Qualifier Perm
#> 5706      Planned Order of Element within Arm  Num             Timing Perm
#> 5707                                    Epoch Char             Timing Perm
#> 5708      Date/Time of Parameter Calculations Char             Timing Perm
#> 5709      Study Day of Parameter Calculations  Num             Timing Perm
#> 5710                     Time Point Reference Char             Timing Perm
#> 5711             Date/Time of Reference Point Char             Timing  Exp
#> 5712     Planned Start of Assessment Interval Char             Timing Perm
#> 5713       Planned End of Assessment Interval Char             Timing Perm
#> 5714                         Study Identifier Char         Identifier  Req
#> 5715                      Domain Abbreviation Char         Identifier  Req
#> 5716                Unique Subject Identifier Char         Identifier  Req
#> 5717                          Sequence Number  Num         Identifier  Req
#> 5718                                 Group ID Char         Identifier Perm
#> 5719               Sponsor-Defined Identifier Char         Identifier Perm
#> 5720                      Question Short Name Char              Topic  Req
#> 5721                            Question Name Char  Synonym Qualifier  Req
#> 5722                     Category of Question Char Grouping Qualifier  Req
#> 5723                 Subcategory for Question Char Grouping Qualifier Perm
#> 5724                Finding in Original Units Char   Result Qualifier  Exp
#> 5725                           Original Units Char Variable Qualifier Perm
#> 5726   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5727        Numeric Finding in Standard Units  Num   Result Qualifier Perm
#> 5728                           Standard Units Char Variable Qualifier Perm
#> 5729                        Completion Status Char   Record Qualifier Perm
#> 5730                     Reason Not Performed Char   Record Qualifier Perm
#> 5731            Method of Test or Examination Char   Record Qualifier Perm
#> 5732    Last Observation Before Exposure Flag Char   Record Qualifier  Exp
#> 5733                            Baseline Flag Char   Record Qualifier Perm
#> 5734                             Derived Flag Char   Record Qualifier Perm
#> 5735                             Visit Number  Num             Timing  Exp
#> 5736                               Visit Name Char             Timing Perm
#> 5737               Planned Study Day of Visit  Num             Timing Perm
#> 5738      Planned Order of Element within Arm  Num             Timing Perm
#> 5739                                    Epoch Char             Timing Perm
#> 5740                     Date/Time of Finding Char             Timing  Exp
#> 5741                     Study Day of Finding  Num             Timing Perm
#> 5742                  Planned Time Point Name Char             Timing Perm
#> 5743                Planned Time Point Number  Num             Timing Perm
#> 5744 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5745                     Time Point Reference Char             Timing Perm
#> 5746        Date/Time of Reference Time Point Char             Timing Perm
#> 5747                      Evaluation Interval Char             Timing Perm
#> 5748                 Evaluation Interval Text Char             Timing Perm
#> 5749                         Study Identifier Char         Identifier  Req
#> 5750                      Domain Abbreviation Char         Identifier  Req
#> 5751                Unique Subject Identifier Char         Identifier  Req
#> 5752                Sponsor Device Identifier Char         Identifier Perm
#> 5753                          Sequence Number  Num         Identifier  Req
#> 5754                                 Group ID Char         Identifier Perm
#> 5755                             Reference ID Char         Identifier Perm
#> 5756               Sponsor-Defined Identifier Char         Identifier Perm
#> 5757                                  Link ID Char         Identifier Perm
#> 5758                               Link Group Char         Identifier Perm
#> 5759           Short Name of Respiratory Test Char              Topic  Req
#> 5760                 Name of Respiratory Test Char  Synonym Qualifier  Req
#> 5761            Category for Respiratory Test Char Grouping Qualifier Perm
#> 5762         Subcategory for Respiratory Test Char Grouping Qualifier Perm
#> 5763   Position of Subject During Observation Char   Record Qualifier Perm
#> 5764      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5765                           Original Units Char Variable Qualifier Perm
#> 5766       Reference Result in Original Units Char Variable Qualifier Perm
#> 5767   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5768 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 5769                           Standard Units Char Variable Qualifier Perm
#> 5770               Character Reference Result Char Variable Qualifier Perm
#> 5771    Numeric Reference Result in Std Units  Num Variable Qualifier Perm
#> 5772                        Completion Status Char   Record Qualifier Perm
#> 5773                          Reason Not Done Char   Record Qualifier Perm
#> 5774        Location Used for the Measurement Char   Record Qualifier Perm
#> 5775                               Laterality Char Variable Qualifier Perm
#> 5776                           Directionality Char Variable Qualifier Perm
#> 5777            Method of Test or Examination Char   Record Qualifier Perm
#> 5778    Last Observation Before Exposure Flag Char   Record Qualifier  Exp
#> 5779                            Baseline Flag Char   Record Qualifier Perm
#> 5780                             Derived Flag Char   Record Qualifier Perm
#> 5781                                Evaluator Char   Record Qualifier Perm
#> 5782                     Evaluator Identifier Char Variable Qualifier Perm
#> 5783                        Repetition Number  Num   Record Qualifier Perm
#> 5784                             Visit Number  Num             Timing  Exp
#> 5785                               Visit Name Char             Timing Perm
#> 5786               Planned Study Day of Visit  Num             Timing Perm
#> 5787      Planned Order of Element within Arm  Num             Timing Perm
#> 5788                                    Epoch Char             Timing Perm
#> 5789                  Date/Time of Collection Char             Timing  Exp
#> 5790       Study Day of Visit/Collection/Exam  Num             Timing Perm
#> 5791                  Planned Time Point Name Char             Timing Perm
#> 5792                Planned Time Point Number  Num             Timing Perm
#> 5793 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5794                     Time Point Reference Char             Timing Perm
#> 5795        Date/Time of Reference Time Point Char             Timing Perm
#> 5796                         Study Identifier Char         Identifier  Req
#> 5797                      Domain Abbreviation Char         Identifier  Req
#> 5798                Unique Subject Identifier Char         Identifier  Req
#> 5799                          Sequence Number  Num         Identifier  Req
#> 5800                                 Group ID Char         Identifier Perm
#> 5801                             Reference ID Char         Identifier Perm
#> 5802               Sponsor-Defined Identifier Char         Identifier Perm
#> 5803                                  Link ID Char         Identifier Perm
#> 5804                            Link Group ID Char         Identifier Perm
#> 5805          Short Name of Reproductive Test Char              Topic  Req
#> 5806                Name of Reproductive Test Char  Synonym Qualifier  Req
#> 5807           Category for Reproductive Test Char Grouping Qualifier Perm
#> 5808        Subcategory for Reproductive Test Char Grouping Qualifier Perm
#> 5809      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5810                           Original Units Char Variable Qualifier Perm
#> 5811   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5812 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 5813                           Standard Units Char Variable Qualifier Perm
#> 5814                        Completion Status Char   Record Qualifier Perm
#> 5815                          Reason Not Done Char   Record Qualifier Perm
#> 5816    Last Observation Before Exposure Flag Char   Record Qualifier Perm
#> 5817                            Baseline Flag Char   Record Qualifier Perm
#> 5818                             Derived Flag Char   Record Qualifier Perm
#> 5819                             Visit Number  Num             Timing  Exp
#> 5820                               Visit Name Char             Timing Perm
#> 5821               Planned Study Day of Visit  Num             Timing Perm
#> 5822      Planned Order of Element within Arm  Num             Timing Perm
#> 5823                                    Epoch Char             Timing Perm
#> 5824                  Date/Time of Collection Char             Timing  Exp
#> 5825       Study Day of Visit/Collection/Exam  Num             Timing Perm
#> 5826                                 Duration Char             Timing Perm
#> 5827                  Planned Time Point Name Char             Timing Perm
#> 5828                Planned Time Point Number  Num             Timing Perm
#> 5829 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5830                     Time Point Reference Char             Timing Perm
#> 5831        Date/Time of Reference Time Point Char             Timing Perm
#> 5832                         Study Identifier Char         Identifier  Req
#> 5833                      Domain Abbreviation Char         Identifier  Req
#> 5834                Unique Subject Identifier Char         Identifier  Req
#> 5835                          Sequence Number  Num         Identifier  Req
#> 5836                                 Group ID Char         Identifier Perm
#> 5837                             Reference ID Char         Identifier Perm
#> 5838               Sponsor-Defined Identifier Char         Identifier Perm
#> 5839                                  Link ID Char         Identifier Perm
#> 5840                            Link Group ID Char         Identifier Perm
#> 5841                    Assessment Short Name Char              Topic  Req
#> 5842                          Assessment Name Char  Synonym Qualifier  Req
#> 5843                  Category for Assessment Char Grouping Qualifier  Exp
#> 5844                              Subcategory Char Grouping Qualifier Perm
#> 5845      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5846                           Original Units Char Variable Qualifier Perm
#> 5847   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5848 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 5849                           Standard Units Char Variable Qualifier Perm
#> 5850                        Completion Status Char   Record Qualifier Perm
#> 5851                          Reason Not Done Char   Record Qualifier Perm
#> 5852                              Vendor Name Char   Record Qualifier Perm
#> 5853            Method of Test or Examination Char   Record Qualifier Perm
#> 5854    Last Observation Before Exposure Flag Char   Record Qualifier Perm
#> 5855                            Baseline Flag Char   Record Qualifier Perm
#> 5856                             Derived Flag Char   Record Qualifier Perm
#> 5857                                Evaluator Char   Record Qualifier Perm
#> 5858                     Evaluator Identifier Char Variable Qualifier Perm
#> 5859                     Accepted Record Flag Char   Record Qualifier Perm
#> 5860                             Visit Number  Num             Timing  Exp
#> 5861                               Visit Name Char             Timing Perm
#> 5862               Planned Study Day of Visit  Num             Timing Perm
#> 5863      Planned Order of Element within Arm  Num             Timing Perm
#> 5864                                    Epoch Char             Timing Perm
#> 5865                  Date/Time of Assessment Char             Timing  Exp
#> 5866                  Study Day of Assessment  Num             Timing Perm
#> 5867                  Planned Time Point Name Char             Timing Perm
#> 5868                Planned Time Point Number  Num             Timing Perm
#> 5869 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 5870                     Time Point Reference Char             Timing Perm
#> 5871        Date/Time of Reference Time Point Char             Timing Perm
#> 5872                      Evaluation Interval Char             Timing Perm
#> 5873                 Evaluation Interval Text Char             Timing Perm
#> 5874   Start Relative to Reference Time Point Char             Timing Perm
#> 5875               Start Reference Time Point Char             Timing Perm
#> 5876     End Relative to Reference Time Point Char             Timing Perm
#> 5877                 End Reference Time Point Char             Timing Perm
#> 5878                         Study Identifier Char         Identifier  Req
#> 5879                      Domain Abbreviation Char         Identifier  Req
#> 5880                Unique Subject Identifier Char         Identifier  Req
#> 5881                          Sequence Number  Num         Identifier  Req
#> 5882                                 Group ID Char         Identifier Perm
#> 5883               Sponsor-Defined Identifier Char         Identifier Perm
#> 5884        Subject Characteristic Short Name Char              Topic  Req
#> 5885                   Subject Characteristic Char  Synonym Qualifier  Req
#> 5886      Category for Subject Characteristic Char Grouping Qualifier Perm
#> 5887   Subcategory for Subject Characteristic Char Grouping Qualifier Perm
#> 5888      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5889                           Original Units Char Variable Qualifier Perm
#> 5890   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5891 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 5892                           Standard Units Char Variable Qualifier Perm
#> 5893                        Completion Status Char   Record Qualifier Perm
#> 5894                     Reason Not Performed Char   Record Qualifier Perm
#> 5895                             Visit Number  Num             Timing Perm
#> 5896                               Visit Name Char             Timing Perm
#> 5897               Planned Study Day of Visit  Num             Timing Perm
#> 5898      Planned Order of Element within Arm  Num             Timing Perm
#> 5899                                    Epoch Char             Timing Perm
#> 5900                  Date/Time of Collection Char             Timing Perm
#> 5901                 Study Day of Examination  Num             Timing Perm
#> 5902                         Study Identifier Char         Identifier  Req
#> 5903                      Domain Abbreviation Char         Identifier  Req
#> 5904                Unique Subject Identifier Char         Identifier  Req
#> 5905                          Sequence Number  Num         Identifier  Req
#> 5906                                 Group ID Char         Identifier Perm
#> 5907               Sponsor-Defined Identifier Char         Identifier Perm
#> 5908                        Status Short Name Char              Topic  Req
#> 5909                              Status Name Char  Synonym Qualifier  Req
#> 5910                  Category for Assessment Char Grouping Qualifier Perm
#> 5911               Subcategory for Assessment Char Grouping Qualifier Perm
#> 5912        Result or Finding Original Result Char   Result Qualifier  Exp
#> 5913   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5914                        Completion Status Char   Record Qualifier Perm
#> 5915          Reason Assessment Not Performed Char   Record Qualifier Perm
#> 5916                                Evaluator Char   Record Qualifier Perm
#> 5917                             Visit Number  Num             Timing  Exp
#> 5918                               Visit Name Char             Timing Perm
#> 5919               Planned Study Day of Visit  Num             Timing Perm
#> 5920      Planned Order of Element within Arm  Num             Timing Perm
#> 5921                                    Epoch Char             Timing Perm
#> 5922                  Date/Time of Assessment Char             Timing  Exp
#> 5923                  Study Day of Assessment  Num             Timing Perm
#> 5924                         Study Identifier Char         Identifier  Req
#> 5925                      Domain Abbreviation Char         Identifier  Req
#> 5926                Unique Subject Identifier Char         Identifier  Req
#> 5927                          Sequence Number  Num         Identifier  Req
#> 5928                                 Group ID Char         Identifier Perm
#> 5929                             Reference ID Char         Identifier Perm
#> 5930               Sponsor-Defined Identifier Char         Identifier Perm
#> 5931                                  Link ID Char         Identifier  Exp
#> 5932                               Link Group Char         Identifier Perm
#> 5933       Tumor/Lesion Assessment Short Name Char              Topic  Req
#> 5934        Tumor/Lesion Assessment Test Name Char  Synonym Qualifier  Req
#> 5935      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 5936                           Original Units Char Variable Qualifier  Exp
#> 5937   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 5938 Numeric Result/Finding in Standard Units  Num   Result Qualifier  Exp
#> 5939                           Standard Units Char Variable Qualifier  Exp
#> 5940                        Completion Status Char   Record Qualifier Perm
#> 5941                          Reason Not Done Char   Record Qualifier Perm
#> 5942                   Laboratory/Vendor Name Char   Record Qualifier Perm
#> 5943 Method Used to Identify the Tumor/Lesion Char   Record Qualifier  Exp
#> 5944    Last Observation Before Exposure Flag Char   Record Qualifier  Exp
#> 5945                            Baseline Flag Char   Record Qualifier Perm
#> 5946                                Evaluator Char   Record Qualifier  Exp
#> 5947                     Evaluator Identifier Char Variable Qualifier Perm
#> 5948                     Accepted Record Flag Char   Record Qualifier Perm
#> 5949                             Visit Number  Num             Timing  Exp
#> 5950                               Visit Name Char             Timing Perm
#> 5951               Planned Study Day of Visit  Num             Timing Perm
#> 5952      Planned Order of Element within Arm  Num             Timing Perm
#> 5953                                    Epoch Char             Timing Perm
#> 5954    Date/Time of Tumor/Lesion Measurement Char             Timing  Exp
#> 5955    Study Day of Tumor/Lesion Measurement  Num             Timing Perm
#> 5956                         Study Identifier Char         Identifier  Req
#> 5957                      Domain Abbreviation Char         Identifier  Req
#> 5958                Unique Subject Identifier Char         Identifier  Req
#> 5959                          Sequence Number  Num         Identifier  Req
#> 5960                                 Group ID Char         Identifier Perm
#> 5961                             Reference ID Char         Identifier Perm
#> 5962               Sponsor-Defined Identifier Char         Identifier Perm
#> 5963                                  Link ID Char         Identifier  Exp
#> 5964                            Link Group ID Char         Identifier Perm
#> 5965               Tumor/Lesion ID Short Name Char              Topic  Req
#> 5966                Tumor/Lesion ID Test Name Char  Synonym Qualifier  Req
#> 5967                   Tumor/Lesion ID Result Char   Result Qualifier  Exp
#> 5968       Tumor/Lesion ID Result Std. Format Char   Result Qualifier  Exp
#> 5969                   Laboratory/Vendor Name Char   Record Qualifier Perm
#> 5970             Location of the Tumor/Lesion Char   Record Qualifier  Exp
#> 5971                               Laterality Char Variable Qualifier Perm
#> 5972                           Directionality Char Variable Qualifier Perm
#> 5973                      Portion or Totality Char Variable Qualifier Perm
#> 5974                 Method of Identification Char   Record Qualifier  Exp
#> 5975    Last Observation Before Exposure Flag Char   Record Qualifier  Exp
#> 5976                            Baseline Flag Char   Record Qualifier Perm
#> 5977                                Evaluator Char   Record Qualifier  Exp
#> 5978                     Evaluator Identifier Char Variable Qualifier Perm
#> 5979                     Accepted Record Flag Char   Record Qualifier Perm
#> 5980                             Visit Number  Num             Timing  Exp
#> 5981                               Visit Name Char             Timing Perm
#> 5982               Planned Study Day of Visit  Num             Timing Perm
#> 5983      Planned Order of Element within Arm  Num             Timing Perm
#> 5984                                    Epoch Char             Timing Perm
#> 5985 Date/Time of Tumor/Lesion Identification Char             Timing  Exp
#> 5986 Study Day of Tumor/Lesion Identification  Num             Timing Perm
#> 5987                         Study Identifier Char         Identifier  Req
#> 5988                      Domain Abbreviation Char         Identifier  Req
#> 5989                Unique Subject Identifier Char         Identifier  Req
#> 5990                          Sequence Number  Num         Identifier  Req
#> 5991                                 Group ID Char         Identifier Perm
#> 5992                             Reference ID Char         Identifier Perm
#> 5993               Sponsor-Defined Identifier Char         Identifier Perm
#> 5994                                  Link ID Char         Identifier Perm
#> 5995                            Link Group ID Char         Identifier Perm
#> 5996               Short Name of Urinary Test Char              Topic  Req
#> 5997                     Name of Urinary Test Char  Synonym Qualifier  Req
#> 5998                      Urinary Test Detail Char Variable Qualifier Perm
#> 5999                Category for Urinary Test Char Grouping Qualifier Perm
#> 6000             Subcategory for Urinary Test Char Grouping Qualifier Perm
#> 6001      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 6002                           Original Units Char Variable Qualifier Perm
#> 6003   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 6004 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 6005                           Standard Units Char Variable Qualifier Perm
#> 6006                          Result Category Char Variable Qualifier Perm
#> 6007                        Completion Status Char   Record Qualifier Perm
#> 6008                          Reason Not Done Char   Record Qualifier Perm
#> 6009        Location Used for the Measurement Char   Record Qualifier Perm
#> 6010                               Laterality Char Variable Qualifier Perm
#> 6011                           Directionality Char Variable Qualifier Perm
#> 6012            Method of Test or Examination Char   Record Qualifier Perm
#> 6013    Last Observation Before Exposure Flag Char   Record Qualifier  Exp
#> 6014                            Baseline Flag Char   Record Qualifier Perm
#> 6015                             Derived Flag Char   Record Qualifier Perm
#> 6016                                Evaluator Char   Record Qualifier Perm
#> 6017                     Evaluator Identifier Char Variable Qualifier Perm
#> 6018                             Visit Number  Num             Timing  Exp
#> 6019                               Visit Name Char             Timing Perm
#> 6020               Planned Study Day of Visit  Num             Timing Perm
#> 6021      Planned Order of Element within Arm  Num             Timing Perm
#> 6022                                    Epoch Char             Timing Perm
#> 6023                  Date/Time of Collection Char             Timing  Exp
#> 6024       Study Day of Visit/Collection/Exam  Num             Timing Perm
#> 6025                  Planned Time Point Name Char             Timing Perm
#> 6026                Planned Time Point Number  Num             Timing Perm
#> 6027 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 6028                     Time Point Reference Char             Timing Perm
#> 6029        Date/Time of Reference Time Point Char             Timing Perm
#> 6030                         Study Identifier Char         Identifier  Req
#> 6031                      Domain Abbreviation Char         Identifier  Req
#> 6032                Unique Subject Identifier Char         Identifier  Req
#> 6033                          Sequence Number  Num         Identifier  Req
#> 6034                                 Group ID Char         Identifier Perm
#> 6035               Sponsor-Defined Identifier Char         Identifier Perm
#> 6036              Vital Signs Test Short Name Char              Topic  Req
#> 6037                    Vital Signs Test Name Char  Synonym Qualifier  Req
#> 6038                 Category for Vital Signs Char Grouping Qualifier Perm
#> 6039              Subcategory for Vital Signs Char Grouping Qualifier Perm
#> 6040          Vital Signs Position of Subject Char   Record Qualifier Perm
#> 6041      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 6042                           Original Units Char Variable Qualifier  Exp
#> 6043   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 6044 Numeric Result/Finding in Standard Units  Num   Result Qualifier  Exp
#> 6045                           Standard Units Char Variable Qualifier  Exp
#> 6046                        Completion Status Char   Record Qualifier Perm
#> 6047                     Reason Not Performed Char   Record Qualifier Perm
#> 6048      Location of Vital Signs Measurement Char   Record Qualifier Perm
#> 6049                               Laterality Char   Result Qualifier Perm
#> 6050    Last Observation Before Exposure Flag Char   Record Qualifier  Exp
#> 6051                            Baseline Flag Char   Record Qualifier Perm
#> 6052                             Derived Flag Char   Record Qualifier Perm
#> 6053                                 Toxicity Char Variable Qualifier Perm
#> 6054                  Standard Toxicity Grade Char   Record Qualifier Perm
#> 6055        Clinically Significant, Collected Char   Record Qualifier Perm
#> 6056                             Visit Number  Num             Timing  Exp
#> 6057                               Visit Name Char             Timing Perm
#> 6058               Planned Study Day of Visit  Num             Timing Perm
#> 6059      Planned Order of Element within Arm  Num             Timing Perm
#> 6060                                    Epoch Char             Timing Perm
#> 6061                Date/Time of Measurements Char             Timing  Exp
#> 6062                 Study Day of Vital Signs  Num             Timing Perm
#> 6063                  Planned Time Point Name Char             Timing Perm
#> 6064                Planned Time Point Number  Num             Timing Perm
#> 6065 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 6066                     Time Point Reference Char             Timing Perm
#> 6067        Date/Time of Reference Time Point Char             Timing Perm
#> 6068                         Study Identifier Char         Identifier  Req
#> 6069                      Domain Abbreviation Char         Identifier  Req
#> 6070                Unique Subject Identifier Char         Identifier  Req
#> 6071                          Sequence Number  Num         Identifier  Req
#> 6072                                 Group ID Char         Identifier Perm
#> 6073               Sponsor-Defined Identifier Char         Identifier Perm
#> 6074           Findings About Test Short Name Char              Topic  Req
#> 6075                 Findings About Test Name Char  Synonym Qualifier  Req
#> 6076                Object of the Observation Char   Record Qualifier  Req
#> 6077              Category for Findings About Char Grouping Qualifier Perm
#> 6078           Subcategory for Findings About Char Grouping Qualifier Perm
#> 6079      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 6080                           Original Units Char Variable Qualifier Perm
#> 6081   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 6082 Numeric Result/Finding in Standard Units  Num   Result Qualifier Perm
#> 6083                           Standard Units Char Variable Qualifier Perm
#> 6084                        Completion Status Char   Record Qualifier Perm
#> 6085                     Reason Not Performed Char   Record Qualifier Perm
#> 6086            Location of the Finding About Char   Record Qualifier Perm
#> 6087                               Laterality Char Variable Qualifier Perm
#> 6088    Last Observation Before Exposure Flag Char   Record Qualifier Perm
#> 6089                            Baseline Flag Char   Record Qualifier Perm
#> 6090                                Evaluator Char   Record Qualifier Perm
#> 6091                             Visit Number  Num             Timing  Exp
#> 6092                               Visit Name Char             Timing Perm
#> 6093               Planned Study Day of Visit  Num             Timing Perm
#> 6094      Planned Order of Element within Arm  Num             Timing Perm
#> 6095                                    Epoch Char             Timing Perm
#> 6096                  Date/Time of Collection Char             Timing  Exp
#> 6097                  Study Day of Collection  Num             Timing Perm
#> 6098                         Study Identifier Char         Identifier  Req
#> 6099                      Domain Abbreviation Char         Identifier  Req
#> 6100                Unique Subject Identifier Char         Identifier  Req
#> 6101                          Sequence Number  Num         Identifier  Req
#> 6102                                 Group ID Char         Identifier Perm
#> 6103                             Reference ID Char         Identifier Perm
#> 6104               Sponsor-Defined Identifier Char         Identifier Perm
#> 6105    Skin Response Test or Exam Short Name Char              Topic  Req
#> 6106   Skin Response Test or Examination Name Char  Synonym Qualifier  Req
#> 6107                Object of the Observation Char   Record Qualifier  Req
#> 6108                        Category for Test Char Grouping Qualifier Perm
#> 6109                     Subcategory for Test Char Grouping Qualifier Perm
#> 6110    Results or Findings in Original Units Char   Result Qualifier  Exp
#> 6111                           Original Units Char Variable Qualifier  Exp
#> 6112   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 6113   Numeric Results/Findings in Std. Units  Num   Result Qualifier  Exp
#> 6114                           Standard Units Char Variable Qualifier  Exp
#> 6115                        Completion Status Char   Record Qualifier Perm
#> 6116                          Reason Not Done Char   Record Qualifier Perm
#> 6117                              Vendor Name Char   Record Qualifier Perm
#> 6118                            Specimen Type Char   Record Qualifier Perm
#> 6119            Location Used for Measurement Char   Record Qualifier Perm
#> 6120                               Laterality Char Variable Qualifier Perm
#> 6121            Method of Test or Examination Char   Record Qualifier Perm
#> 6122    Last Observation Before Exposure Flag Char   Record Qualifier Perm
#> 6123                            Baseline Flag Char   Record Qualifier Perm
#> 6124                                Evaluator Char   Record Qualifier Perm
#> 6125                             Visit Number  Num             Timing  Exp
#> 6126                               Visit Name Char             Timing Perm
#> 6127               Planned Study Day of Visit  Num             Timing Perm
#> 6128      Planned Order of Element within Arm  Num             Timing Perm
#> 6129                                    Epoch Char             Timing Perm
#> 6130                  Date/Time of Collection Char             Timing  Exp
#> 6131       Study Day of Visit/Collection/Exam  Num             Timing Perm
#> 6132                  Planned Time Point Name Char             Timing Perm
#> 6133                Planned Time Point Number  Num             Timing Perm
#> 6134 Planned Elapsed Time from Time Point Ref Char             Timing Perm
#> 6135                     Time Point Reference Char             Timing Perm
#> 6136        Date/Time of Reference Time Point Char             Timing Perm
#> 6137                         Study Identifier Char         Identifier  Req
#> 6138                      Domain Abbreviation Char         Identifier  Req
#> 6139              Related Domain Abbreviation Char   Record Qualifier Perm
#> 6140                Unique Subject Identifier Char         Identifier  Req
#> 6141                          Sequence Number  Num         Identifier  Req
#> 6142                     Identifying Variable Char   Record Qualifier Perm
#> 6143               Identifying Variable Value Char   Record Qualifier Perm
#> 6144                        Comment Reference Char   Record Qualifier Perm
#> 6145                                  Comment Char              Topic  Req
#> 6146                                Evaluator Char   Record Qualifier Perm
#> 6147                     Evaluator Identifier Char   Record Qualifier Perm
#> 6148                     Date/Time of Comment Char             Timing Perm
#> 6149                     Study Day of Comment  Num             Timing Perm
#> 6150                         Study Identifier Char         Identifier  Req
#> 6151                      Domain Abbreviation Char         Identifier  Req
#> 6152                Unique Subject Identifier Char         Identifier  Req
#> 6153         Subject Identifier for the Study Char              Topic  Req
#> 6154        Subject Reference Start Date/Time Char   Record Qualifier  Exp
#> 6155          Subject Reference End Date/Time Char   Record Qualifier  Exp
#> 6156       Date/Time of First Study Treatment Char   Record Qualifier  Exp
#> 6157        Date/Time of Last Study Treatment Char   Record Qualifier  Exp
#> 6158 Date/Time of First Challenge Agent Admin Char   Record Qualifier Perm
#> 6159  Date/Time of Last Challenge Agent Admin Char   Record Qualifier Perm
#> 6160            Date/Time of Informed Consent Char   Record Qualifier  Exp
#> 6161        Date/Time of End of Participation Char   Record Qualifier  Exp
#> 6162                       Date/Time of Death Char   Record Qualifier  Exp
#> 6163                       Subject Death Flag Char   Record Qualifier  Exp
#> 6164                    Study Site Identifier Char   Record Qualifier  Req
#> 6165                  Investigator Identifier Char   Record Qualifier Perm
#> 6166                        Investigator Name Char  Synonym Qualifier Perm
#> 6167                       Date/Time of Birth Char   Record Qualifier Perm
#> 6168                                      Age  Num   Record Qualifier  Exp
#> 6169                                Age Units Char Variable Qualifier  Exp
#> 6170                                      Sex Char   Record Qualifier  Req
#> 6171                                     Race Char   Record Qualifier  Exp
#> 6172                                Ethnicity Char   Record Qualifier Perm
#> 6173                         Planned Arm Code Char   Record Qualifier  Exp
#> 6174               Description of Planned Arm Char  Synonym Qualifier  Exp
#> 6175                          Actual Arm Code Char   Record Qualifier  Exp
#> 6176                Description of Actual Arm Char  Synonym Qualifier  Exp
#> 6177     Reason Arm and/or Actual Arm is Null Char   Record Qualifier  Exp
#> 6178      Description of Unplanned Actual Arm Char   Record Qualifier  Exp
#> 6179                                  Country Char   Record Qualifier  Req
#> 6180                  Date/Time of Collection Char             Timing Perm
#> 6181                  Study Day of Collection  Num             Timing Perm
#> 6182                         Study Identifier Char         Identifier  Req
#> 6183                      Domain Abbreviation Char         Identifier  Req
#> 6184                Unique Subject Identifier Char         Identifier  Req
#> 6185                          Sequence Number  Num         Identifier  Req
#> 6186                             Element Code Char              Topic  Req
#> 6187                   Description of Element Char  Synonym Qualifier Perm
#> 6188      Planned Order of Element within Arm  Num             Timing Perm
#> 6189                                    Epoch Char             Timing Perm
#> 6190               Start Date/Time of Element Char             Timing  Req
#> 6191                 End Date/Time of Element Char             Timing  Exp
#> 6192            Study Day of Start of Element  Num             Timing Perm
#> 6193              Study Day of End of Element  Num             Timing Perm
#> 6194         Description of Unplanned Element Char  Synonym Qualifier Perm
#> 6195                         Study Identifier Char         Identifier  Req
#> 6196                      Domain Abbreviation Char         Identifier  Req
#> 6197                Unique Subject Identifier Char         Identifier  Req
#> 6198                          Sequence Number  Num         Identifier  Req
#> 6199          Disease Milestone Instance Name Char              Topic  Req
#> 6200                   Disease Milestone Type Char   Record Qualifier  Req
#> 6201             Start Date/Time of Milestone Char             Timing  Exp
#> 6202               End Date/Time of Milestone Char             Timing  Exp
#> 6203          Study Day of Start of Milestone  Num             Timing  Exp
#> 6204            Study Day of End of Milestone  Num             Timing  Exp
#> 6205                         Study Identifier Char         Identifier  Req
#> 6206                      Domain Abbreviation Char         Identifier  Req
#> 6207                Unique Subject Identifier Char         Identifier  Req
#> 6208                             Visit Number  Num              Topic  Req
#> 6209                               Visit Name Char  Synonym Qualifier Perm
#> 6210                            Pre-specified Char Variable Qualifier  Exp
#> 6211                               Occurrence Char   Record Qualifier  Exp
#> 6212                   Reason for Occur Value Char   Record Qualifier Perm
#> 6213                             Contact Mode Char   Record Qualifier Perm
#> 6214    Epi/Pandemic Related Change Indicator Char   Record Qualifier Perm
#> 6215               Planned Study Day of Visit  Num             Timing Perm
#> 6216           Start Date/Time of Observation Char             Timing  Exp
#> 6217             End Date/Time of Observation Char             Timing  Exp
#> 6218        Study Day of Start of Observation  Num             Timing Perm
#> 6219          Study Day of End of Observation  Num             Timing Perm
#> 6220           Description of Unplanned Visit Char   Record Qualifier Perm
#> 6221                         Study Identifier Char         Identifier  Req
#> 6222                      Domain Abbreviation Char         Identifier  Req
#> 6223                         Planned Arm Code Char              Topic  Req
#> 6224               Description of Planned Arm Char  Synonym Qualifier  Req
#> 6225      Planned Order of Element within Arm  Num             Timing  Req
#> 6226                             Element Code Char   Record Qualifier  Req
#> 6227                   Description of Element Char  Synonym Qualifier Perm
#> 6228                                   Branch Char               Rule  Exp
#> 6229                          Transition Rule Char               Rule  Exp
#> 6230                                    Epoch Char             Timing  Req
#> 6231                         Study Identifier Char         Identifier  Req
#> 6232                      Domain Abbreviation Char         Identifier  Req
#> 6233  Sequence of Planned Assessment Schedule  Num             Timing  Req
#> 6234                     Anchor Variable Name Char             Timing  Req
#> 6235                   Offset from the Anchor Char             Timing  Req
#> 6236              Planned Assessment Interval Char             Timing  Req
#> 6237      Planned Assessment Interval Minimum Char             Timing  Req
#> 6238      Planned Assessment Interval Maximum Char             Timing  Req
#> 6239     Maximum Number of Actual Assessments  Num   Record Qualifier  Req
#> 6240                         Study Identifier Char         Identifier  Req
#> 6241                      Domain Abbreviation Char         Identifier  Req
#> 6242                             Element Code Char              Topic  Req
#> 6243                   Description of Element Char  Synonym Qualifier  Req
#> 6244                Rule for Start of Element Char               Rule  Req
#> 6245                  Rule for End of Element Char               Rule Perm
#> 6246              Planned Duration of Element Char             Timing Perm
#> 6247                         Study Identifier Char         Identifier  Req
#> 6248                      Domain Abbreviation Char         Identifier  Req
#> 6249           Incl/Excl Criterion Short Name Char              Topic  Req
#> 6250            Inclusion/Exclusion Criterion Char  Synonym Qualifier  Req
#> 6251             Inclusion/Exclusion Category Char Grouping Qualifier  Req
#> 6252          Inclusion/Exclusion Subcategory Char Grouping Qualifier Perm
#> 6253       Inclusion/Exclusion Criterion Rule Char               Rule Perm
#> 6254               Protocol Criteria Versions Char   Record Qualifier Perm
#> 6255                         Study Identifier Char         Identifier  Req
#> 6256                      Domain Abbreviation Char         Identifier  Req
#> 6257                   Disease Milestone Type Char              Topic  Req
#> 6258             Disease Milestone Definition Char Variable Qualifier  Req
#> 6259   Disease Milestone Repetition Indicator Char   Record Qualifier  Req
#> 6260                         Study Identifier Char         Identifier  Req
#> 6261                      Domain Abbreviation Char         Identifier  Req
#> 6262                          Sequence Number  Num         Identifier  Req
#> 6263                                 Group ID Char         Identifier Perm
#> 6264       Trial Summary Parameter Short Name Char              Topic  Req
#> 6265                  Trial Summary Parameter Char  Synonym Qualifier  Req
#> 6266                          Parameter Value Char   Result Qualifier  Exp
#> 6267              Parameter Value Null Flavor Char   Result Qualifier Perm
#> 6268                     Parameter Value Code Char   Result Qualifier  Exp
#> 6269        Name of the Reference Terminology Char   Result Qualifier  Exp
#> 6270     Version of the Reference Terminology Char   Result Qualifier  Exp
#> 6271                         Study Identifier Char         Identifier  Req
#> 6272                      Domain Abbreviation Char         Identifier  Req
#> 6273                             Visit Number  Num              Topic  Req
#> 6274                               Visit Name Char  Synonym Qualifier  Req
#> 6275               Planned Study Day of Visit  Num             Timing Perm
#> 6276                         Planned Arm Code Char   Record Qualifier  Exp
#> 6277               Description of Planned Arm Char  Synonym Qualifier Perm
#> 6278                         Visit Start Rule Char               Rule  Req
#> 6279                           Visit End Rule Char               Rule Perm
#> 6280                         Study Identifier Char         Identifier  Req
#> 6281                      Domain Abbreviation Char         Identifier  Req
#> 6282             Non-host Organism Identifier Char         Identifier  Req
#> 6283                          Sequence Number  Num         Identifier  Req
#> 6284  Non-host Organism ID Element Short Name Char              Topic  Req
#> 6285        Non-host Organism ID Element Name Char  Synonym Qualifier  Req
#> 6286       Non-host Organism ID Element Value Char   Result Qualifier  Req
#> 6287                         Study Identifier Char         Identifier  Req
#> 6288              Related Domain Abbreviation Char         Identifier  Req
#> 6289                Unique Subject Identifier Char         Identifier  Exp
#> 6290                     Identifying Variable Char         Identifier  Req
#> 6291               Identifying Variable Value Char         Identifier  Exp
#> 6292                        Relationship Type Char   Record Qualifier  Exp
#> 6293                  Relationship Identifier Char   Record Qualifier  Req
#> 6294                         Study Identifier Char         Identifier  Req
#> 6295                Unique Subject Identifier Char         Identifier  Req
#> 6296                              Specimen ID Char         Identifier  Req
#> 6297                            Specimen Type Char Variable Qualifier Perm
#> 6298                          Specimen Parent Char         Identifier  Exp
#> 6299                           Specimen Level  Num Variable Qualifier  Req
#> 6300                         Study Identifier Char         Identifier  Req
#> 6301                Unique Subject Identifier Char         Identifier  Exp
#> 6302                          Pool Identifier Char         Identifier Perm
#> 6303       Related Subject or Pool Identifier Char         Identifier  Req
#> 6304                     Subject Relationship Char   Record Qualifier  Req
#> 6305                         Study Identifier Char         Identifier  Req
#> 6306              Related Domain Abbreviation Char         Identifier  Req
#> 6307                Unique Subject Identifier Char         Identifier  Req
#> 6308                     Identifying Variable Char         Identifier  Exp
#> 6309               Identifying Variable Value Char         Identifier  Exp
#> 6310                  Qualifier Variable Name Char              Topic  Req
#> 6311                 Qualifier Variable Label Char  Synonym Qualifier  Req
#> 6312                               Data Value Char   Result Qualifier  Req
#> 6313                                   Origin Char   Record Qualifier  Req
#> 6314                                Evaluator Char   Record Qualifier  Exp
#>                                   codelist_code codelist_submission_values
#> 4398                                       <NA>                       <NA>
#> 4399                                       <NA>                       <NA>
#> 4400                                       <NA>                       <NA>
#> 4401                                       <NA>                       <NA>
#> 4402                                       <NA>                       <NA>
#> 4403                                       <NA>                       <NA>
#> 4404                                       <NA>                       <NA>
#> 4405                                       <NA>                       <NA>
#> 4406                                       <NA>                       <NA>
#> 4407                                       <NA>                       <NA>
#> 4408                                       <NA>                       <NA>
#> 4409                                       <NA>                       <NA>
#> 4410                                       <NA>                       <NA>
#> 4411                                     C66742                       <NA>
#> 4412                                     C66742                       <NA>
#> 4413                                     C66789                       <NA>
#> 4414                                       <NA>                       <NA>
#> 4415                                       <NA>                       <NA>
#> 4416                                       <NA>                       <NA>
#> 4417                                       <NA>                       <NA>
#> 4418                                       <NA>                       <NA>
#> 4419                                     C71620                       <NA>
#> 4420                                     C66726                       <NA>
#> 4421                                     C71113                       <NA>
#> 4422                                     C66729                       <NA>
#> 4423                                       <NA>                       <NA>
#> 4424                                       <NA>                       <NA>
#> 4425                                       <NA>                       <NA>
#> 4426                                       <NA>                       <NA>
#> 4427                                     C99079                       <NA>
#> 4428                                       <NA>                       <NA>
#> 4429                                       <NA>                       <NA>
#> 4430                                       <NA>                       <NA>
#> 4431                                       <NA>                       <NA>
#> 4432                                       <NA>                       <NA>
#> 4433                                     C66728                       <NA>
#> 4434                                     C66728                       <NA>
#> 4435                                     C66728                       <NA>
#> 4436                                       <NA>                       <NA>
#> 4437                                     C66728                       <NA>
#> 4438                                       <NA>                       <NA>
#> 4439                                       <NA>                       <NA>
#> 4440                                       <NA>                       <NA>
#> 4441                                       <NA>                       <NA>
#> 4442                                       <NA>                       <NA>
#> 4443                                       <NA>                       <NA>
#> 4444                                       <NA>                       <NA>
#> 4445                                       <NA>                       <NA>
#> 4446                                       <NA>                       <NA>
#> 4447                                       <NA>                       <NA>
#> 4448                                       <NA>                       <NA>
#> 4449                                       <NA>                       <NA>
#> 4450                                     C66742                       <NA>
#> 4451                                     C66742                       <NA>
#> 4452                                     C66789                       <NA>
#> 4453                                       <NA>                       <NA>
#> 4454                                       <NA>                       <NA>
#> 4455                                       <NA>                       <NA>
#> 4456                                       <NA>                       <NA>
#> 4457                                       <NA>                       <NA>
#> 4458                                       <NA>                       <NA>
#> 4459                                     C71620                       <NA>
#> 4460                                     C66726                       <NA>
#> 4461                                     C71113                       <NA>
#> 4462                                       <NA>                       <NA>
#> 4463                                       <NA>                       <NA>
#> 4464                                     C66729                       <NA>
#> 4465                                       <NA>                       <NA>
#> 4466                                       <NA>                       <NA>
#> 4467                                       <NA>                       <NA>
#> 4468                                     C99079                       <NA>
#> 4469                                       <NA>                       <NA>
#> 4470                                       <NA>                       <NA>
#> 4471                                       <NA>                       <NA>
#> 4472                                       <NA>                       <NA>
#> 4473                                       <NA>                       <NA>
#> 4474                                     C66728                       <NA>
#> 4475                                     C66728                       <NA>
#> 4476                                     C66728                       <NA>
#> 4477                                       <NA>                       <NA>
#> 4478                                     C66728                       <NA>
#> 4479                                       <NA>                       <NA>
#> 4480                                       <NA>                       <NA>
#> 4481                                       <NA>                       <NA>
#> 4482                                       <NA>                       <NA>
#> 4483                                       <NA>                       <NA>
#> 4484                                       <NA>                       <NA>
#> 4485                                       <NA>                       <NA>
#> 4486                                       <NA>                       <NA>
#> 4487                                       <NA>                       <NA>
#> 4488                                       <NA>                       <NA>
#> 4489                                       <NA>                       <NA>
#> 4490                                    C125923                       <NA>
#> 4491                                       <NA>                       <NA>
#> 4492                                       <NA>                       <NA>
#> 4493                                     C66742                       <NA>
#> 4494                                     C66742                       <NA>
#> 4495                                       <NA>                       <NA>
#> 4496                                       <NA>                       <NA>
#> 4497                                       <NA>                       <NA>
#> 4498                                     C71620                       <NA>
#> 4499                                     C66726                       <NA>
#> 4500                                     C71113                       <NA>
#> 4501                                       <NA>                       <NA>
#> 4502                                       <NA>                       <NA>
#> 4503                                     C66729                       <NA>
#> 4504                                       <NA>                       <NA>
#> 4505                                     C74456                       <NA>
#> 4506                                     C99073                       <NA>
#> 4507                                     C99074                       <NA>
#> 4508                                     C99075                       <NA>
#> 4509                                     C66742                       <NA>
#> 4510                                       <NA>                       <NA>
#> 4511                                     C71620                       <NA>
#> 4512                                       <NA>                       <NA>
#> 4513                                       <NA>                       <NA>
#> 4514                                     C99079                       <NA>
#> 4515                                       <NA>                       <NA>
#> 4516                                       <NA>                       <NA>
#> 4517                                       <NA>                       <NA>
#> 4518                                       <NA>                       <NA>
#> 4519                                       <NA>                       <NA>
#> 4520                                       <NA>                       <NA>
#> 4521                                       <NA>                       <NA>
#> 4522                                       <NA>                       <NA>
#> 4523                                       <NA>                       <NA>
#> 4524                                       <NA>                       <NA>
#> 4525                                       <NA>                       <NA>
#> 4526                                       <NA>                       <NA>
#> 4527                                       <NA>                       <NA>
#> 4528                                       <NA>                       <NA>
#> 4529                                       <NA>                       <NA>
#> 4530                                       <NA>                       <NA>
#> 4531                                       <NA>                       <NA>
#> 4532                                       <NA>                       <NA>
#> 4533                                       <NA>                       <NA>
#> 4534                                       <NA>                       <NA>
#> 4535                                       <NA>                       <NA>
#> 4536                                       <NA>                       <NA>
#> 4537                                       <NA>                       <NA>
#> 4538                                       <NA>                       <NA>
#> 4539                                     C71620                       <NA>
#> 4540                                     C66726                       <NA>
#> 4541                                     C71113                       <NA>
#> 4542                                       <NA>                       <NA>
#> 4543                                     C66729                       <NA>
#> 4544                                       <NA>                       <NA>
#> 4545                                     C74456                       <NA>
#> 4546                                     C99073                       <NA>
#> 4547                                     C99074                       <NA>
#> 4548                                     C66742                       <NA>
#> 4549                                       <NA>                       <NA>
#> 4550                                       <NA>                       <NA>
#> 4551                                     C99079                       <NA>
#> 4552                                       <NA>                       <NA>
#> 4553                                       <NA>                       <NA>
#> 4554                                       <NA>                       <NA>
#> 4555                                       <NA>                       <NA>
#> 4556                                       <NA>                       <NA>
#> 4557                                       <NA>                       <NA>
#> 4558                                       <NA>                       <NA>
#> 4559                                       <NA>                       <NA>
#> 4560                                       <NA>                       <NA>
#> 4561                                       <NA>                       <NA>
#> 4562                                       <NA>                       <NA>
#> 4563                                       <NA>                       <NA>
#> 4564                                       <NA>                       <NA>
#> 4565                                       <NA>                       <NA>
#> 4566                                       <NA>                       <NA>
#> 4567                                       <NA>                       <NA>
#> 4568                                       <NA>                       <NA>
#> 4569                                       <NA>                       <NA>
#> 4570                                       <NA>                       <NA>
#> 4571                                     C66742                       <NA>
#> 4572                                     C66742                       <NA>
#> 4573                                     C66789                       <NA>
#> 4574                                       <NA>                       <NA>
#> 4575                                       <NA>                       <NA>
#> 4576                                       <NA>                       <NA>
#> 4577                                     C71620                       <NA>
#> 4578                                     C66726                       <NA>
#> 4579                                       <NA>                       <NA>
#> 4580                                       <NA>                       <NA>
#> 4581                                       <NA>                       <NA>
#> 4582                                       <NA>                       <NA>
#> 4583                                     C99079                       <NA>
#> 4584                                       <NA>                       <NA>
#> 4585                                       <NA>                       <NA>
#> 4586                                       <NA>                       <NA>
#> 4587                                       <NA>                       <NA>
#> 4588                                       <NA>                       <NA>
#> 4589                                       <NA>                       <NA>
#> 4590                                       <NA>                       <NA>
#> 4591                                       <NA>                       <NA>
#> 4592                                       <NA>                       <NA>
#> 4593                                       <NA>                       <NA>
#> 4594                                       <NA>                       <NA>
#> 4595                                       <NA>                       <NA>
#> 4596                                       <NA>                       <NA>
#> 4597                                       <NA>                       <NA>
#> 4598                                       <NA>                       <NA>
#> 4599                                       <NA>                       <NA>
#> 4600                                       <NA>                       <NA>
#> 4601                                       <NA>                       <NA>
#> 4602                                       <NA>                       <NA>
#> 4603                                       <NA>                       <NA>
#> 4604                                       <NA>                       <NA>
#> 4605                                       <NA>                       <NA>
#> 4606                                       <NA>                       <NA>
#> 4607                                       <NA>                       <NA>
#> 4608                                    C101858                       <NA>
#> 4609                                       <NA>                       <NA>
#> 4610                                       <NA>                       <NA>
#> 4611                                     C66742                       <NA>
#> 4612                                     C66742                       <NA>
#> 4613                                       <NA>                       <NA>
#> 4614                                       <NA>                       <NA>
#> 4615                                       <NA>                       <NA>
#> 4616                                     C71620                       <NA>
#> 4617                                     C66726                       <NA>
#> 4618                                     C71113                       <NA>
#> 4619                                       <NA>                       <NA>
#> 4620                                     C66729                       <NA>
#> 4621                                     C74456                       <NA>
#> 4622                                     C99073                       <NA>
#> 4623                                     C99074                       <NA>
#> 4624                                     C99075                       <NA>
#> 4625                                       <NA>                       <NA>
#> 4626                                       <NA>                       <NA>
#> 4627                                       <NA>                       <NA>
#> 4628                                       <NA>                       <NA>
#> 4629                                     C99079                       <NA>
#> 4630                                       <NA>                       <NA>
#> 4631                                       <NA>                       <NA>
#> 4632                                       <NA>                       <NA>
#> 4633                                       <NA>                       <NA>
#> 4634                                       <NA>                       <NA>
#> 4635                                       <NA>                       <NA>
#> 4636                                       <NA>                       <NA>
#> 4637                                       <NA>                       <NA>
#> 4638                                       <NA>                       <NA>
#> 4639                                       <NA>                       <NA>
#> 4640                                     C66728                       <NA>
#> 4641                                       <NA>                       <NA>
#> 4642                                     C66728                       <NA>
#> 4643                                       <NA>                       <NA>
#> 4644                                       <NA>                       <NA>
#> 4645                                       <NA>                       <NA>
#> 4646                                       <NA>                       <NA>
#> 4647                                       <NA>                       <NA>
#> 4648                                       <NA>                       <NA>
#> 4649                                       <NA>                       <NA>
#> 4650                                       <NA>                       <NA>
#> 4651                                       <NA>                       <NA>
#> 4652                                       <NA>                       <NA>
#> 4653                                       <NA>                       <NA>
#> 4654                                       <NA>                       <NA>
#> 4655                                     C66742                       <NA>
#> 4656                                     C66742                       <NA>
#> 4657                                     C66789                       <NA>
#> 4658                                       <NA>                       <NA>
#> 4659                                       <NA>                       <NA>
#> 4660                                       <NA>                       <NA>
#> 4661                                       <NA>                       <NA>
#> 4662                                       <NA>                       <NA>
#> 4663                                     C71620                       <NA>
#> 4664                                     C66726                       <NA>
#> 4665                                     C71113                       <NA>
#> 4666                                       <NA>                       <NA>
#> 4667                                     C66729                       <NA>
#> 4668                                       <NA>                       <NA>
#> 4669                                     C99079                       <NA>
#> 4670                                       <NA>                       <NA>
#> 4671                                       <NA>                       <NA>
#> 4672                                       <NA>                       <NA>
#> 4673                                       <NA>                       <NA>
#> 4674                                       <NA>                       <NA>
#> 4675                                     C66728                       <NA>
#> 4676                                     C66728                       <NA>
#> 4677                                     C66728                       <NA>
#> 4678                                       <NA>                       <NA>
#> 4679                                     C66728                       <NA>
#> 4680                                       <NA>                       <NA>
#> 4681                                       <NA>                       <NA>
#> 4682                                       <NA>                       <NA>
#> 4683                                       <NA>                       <NA>
#> 4684                                       <NA>                       <NA>
#> 4685                                       <NA>                       <NA>
#> 4686                                       <NA>                       <NA>
#> 4687                                       <NA>                       <NA>
#> 4688                                       <NA>                       <NA>
#> 4689                                       <NA>                       <NA>
#> 4690                                       <NA>                       <NA>
#> 4691                                       <NA>                       <NA>
#> 4692                                       <NA>                       <NA>
#> 4693                                       <NA>                       <NA>
#> 4694                                       <NA>                       <NA>
#> 4695                                       <NA>                       <NA>
#> 4696                                       <NA>                       <NA>
#> 4697                                       <NA>                       <NA>
#> 4698                                       <NA>                       <NA>
#> 4699                                       <NA>                       <NA>
#> 4700                                       <NA>                       <NA>
#> 4701                                     C66742                       <NA>
#> 4702                                       <NA>                       <NA>
#> 4703                                       <NA>                       <NA>
#> 4704                                       <NA>                       <NA>
#> 4705                                       <NA>                       <NA>
#> 4706                                     C74456                       <NA>
#> 4707                                     C66769                       <NA>
#> 4708                                     C66742                       <NA>
#> 4709                                     C66767                       <NA>
#> 4710                                       <NA>                       <NA>
#> 4711                                    C111110                       <NA>
#> 4712                                       <NA>                       <NA>
#> 4713                                       <NA>                       <NA>
#> 4714                                       <NA>                       <NA>
#> 4715                                       <NA>                       <NA>
#> 4716                                     C66768                       <NA>
#> 4717                                     C66742                       <NA>
#> 4718                                     C66742                       <NA>
#> 4719                                     C66742                       <NA>
#> 4720                                     C66742                       <NA>
#> 4721                                     C66742                       <NA>
#> 4722                                     C66742                       <NA>
#> 4723                                     C66742                       <NA>
#> 4724                                     C66742                       <NA>
#> 4725                                     C66742                       <NA>
#> 4726                                     C66742                       <NA>
#> 4727                                       <NA>                       <NA>
#> 4728                                       <NA>                       <NA>
#> 4729                                     C66742                       <NA>
#> 4730                                       <NA>                       <NA>
#> 4731                                       <NA>                       <NA>
#> 4732                                     C99079                       <NA>
#> 4733                                       <NA>                       <NA>
#> 4734                                       <NA>                       <NA>
#> 4735                                       <NA>                       <NA>
#> 4736                                       <NA>                       <NA>
#> 4737                                       <NA>                       <NA>
#> 4738                                     C66728                       <NA>
#> 4739                                     C66728                       <NA>
#> 4740                                       <NA>                       <NA>
#> 4741                                       <NA>                       <NA>
#> 4742                                       <NA>                       <NA>
#> 4743                                       <NA>                       <NA>
#> 4744                                       <NA>                       <NA>
#> 4745                                       <NA>                       <NA>
#> 4746                                       <NA>                       <NA>
#> 4747                                       <NA>                       <NA>
#> 4748                                       <NA>                       <NA>
#> 4749                                       <NA>                       <NA>
#> 4750                                       <NA>                       <NA>
#> 4751                                    C124297                       <NA>
#> 4752                                       <NA>                       <NA>
#> 4753                                       <NA>                       <NA>
#> 4754                                     C74456                       <NA>
#> 4755                                       <NA>                       <NA>
#> 4756                                       <NA>                       <NA>
#> 4757                                       <NA>                       <NA>
#> 4758                                       <NA>                       <NA>
#> 4759                                       <NA>                       <NA>
#> 4760                                       <NA>                       <NA>
#> 4761                                       <NA>                       <NA>
#> 4762                                       <NA>                       <NA>
#> 4763                                       <NA>                       <NA>
#> 4764                                       <NA>                       <NA>
#> 4765                                       <NA>                       <NA>
#> 4766                                       <NA>                       <NA>
#> 4767                                       <NA>                       <NA>
#> 4768                                       <NA>                       <NA>
#> 4769                                       <NA>                       <NA>
#> 4770                                       <NA>                       <NA>
#> 4771                                       <NA>                       <NA>
#> 4772                                       <NA>                       <NA>
#> 4773                                       <NA>                       <NA>
#> 4774                                       <NA>                       <NA>
#> 4775                                       <NA>                       <NA>
#> 4776                                       <NA>                       <NA>
#> 4777                                     C66742                       <NA>
#> 4778                                     C66742                       <NA>
#> 4779                                     C66789                       <NA>
#> 4780                                       <NA>                       <NA>
#> 4781                                       <NA>                       <NA>
#> 4782                                    C165643                       <NA>
#> 4783                                       <NA>                       <NA>
#> 4784                                       <NA>                       <NA>
#> 4785                                     C99079                       <NA>
#> 4786                                       <NA>                       <NA>
#> 4787                                       <NA>                       <NA>
#> 4788                                       <NA>                       <NA>
#> 4789                                       <NA>                       <NA>
#> 4790                                       <NA>                       <NA>
#> 4791                                       <NA>                       <NA>
#> 4792                                     C66728                       <NA>
#> 4793                                     C66728                       <NA>
#> 4794                                     C66728                       <NA>
#> 4795                                       <NA>                       <NA>
#> 4796                                     C66728                       <NA>
#> 4797                                       <NA>                       <NA>
#> 4798                                       <NA>                       <NA>
#> 4799                                       <NA>                       <NA>
#> 4800                                       <NA>                       <NA>
#> 4801                                       <NA>                       <NA>
#> 4802                                       <NA>                       <NA>
#> 4803                                       <NA>                       <NA>
#> 4804                                       <NA>                       <NA>
#> 4805                                       <NA>                       <NA>
#> 4806                   C66727; C114118; C150811                       <NA>
#> 4807                                     C74558                       <NA>
#> 4808                                    C170443                       <NA>
#> 4809                                     C99079                       <NA>
#> 4810                                       <NA>                       <NA>
#> 4811                                       <NA>                       <NA>
#> 4812                                       <NA>                       <NA>
#> 4813                                       <NA>                       <NA>
#> 4814                                       <NA>                       <NA>
#> 4815                                       <NA>                       <NA>
#> 4816                                       <NA>                       <NA>
#> 4817                                       <NA>                       <NA>
#> 4818                                       <NA>                       <NA>
#> 4819                                       <NA>                       <NA>
#> 4820                                       <NA>                       <NA>
#> 4821                                       <NA>                       <NA>
#> 4822                                       <NA>                       <NA>
#> 4823                                       <NA>                       <NA>
#> 4824                                       <NA>                       <NA>
#> 4825                                     C99079                       <NA>
#> 4826                                       <NA>                       <NA>
#> 4827                                       <NA>                       <NA>
#> 4828                                       <NA>                       <NA>
#> 4829                                       <NA>                       <NA>
#> 4830                                       <NA>                       <NA>
#> 4831                                       <NA>                       <NA>
#> 4832                                       <NA>                       <NA>
#> 4833                                       <NA>                       <NA>
#> 4834                                       <NA>                       <NA>
#> 4835                                       <NA>                       <NA>
#> 4836                                       <NA>                       <NA>
#> 4837                                       <NA>                       <NA>
#> 4838                                    C171444                       <NA>
#> 4839                                       <NA>                       <NA>
#> 4840                                       <NA>                       <NA>
#> 4841                                     C66742                       <NA>
#> 4842                                     C66742                       <NA>
#> 4843                                     C66789                       <NA>
#> 4844                                       <NA>                       <NA>
#> 4845                                       <NA>                       <NA>
#> 4846                                     C99079                       <NA>
#> 4847                                       <NA>                       <NA>
#> 4848                                       <NA>                       <NA>
#> 4849                                       <NA>                       <NA>
#> 4850                                       <NA>                       <NA>
#> 4851                                       <NA>                       <NA>
#> 4852                                       <NA>                       <NA>
#> 4853                                       <NA>                       <NA>
#> 4854                                     C66728                       <NA>
#> 4855                                       <NA>                       <NA>
#> 4856                                     C66728                       <NA>
#> 4857                                       <NA>                       <NA>
#> 4858                                       <NA>                       <NA>
#> 4859                                       <NA>                       <NA>
#> 4860                                       <NA>                       <NA>
#> 4861                                       <NA>                       <NA>
#> 4862                                       <NA>                       <NA>
#> 4863                                       <NA>                       <NA>
#> 4864                                       <NA>                       <NA>
#> 4865                                       <NA>                       <NA>
#> 4866                                       <NA>                       <NA>
#> 4867                                       <NA>                       <NA>
#> 4868                                    C124301                       <NA>
#> 4869                                       <NA>                       <NA>
#> 4870                                       <NA>                       <NA>
#> 4871                                     C66742                       <NA>
#> 4872                                     C66742                       <NA>
#> 4873                                     C66789                       <NA>
#> 4874                                       <NA>                       <NA>
#> 4875                                       <NA>                       <NA>
#> 4876                                       <NA>                       <NA>
#> 4877                                     C99079                       <NA>
#> 4878                                       <NA>                       <NA>
#> 4879                                       <NA>                       <NA>
#> 4880                                       <NA>                       <NA>
#> 4881                                       <NA>                       <NA>
#> 4882                                     C66728                       <NA>
#> 4883                                     C66728                       <NA>
#> 4884                                       <NA>                       <NA>
#> 4885                                       <NA>                       <NA>
#> 4886                                       <NA>                       <NA>
#> 4887                                       <NA>                       <NA>
#> 4888                                       <NA>                       <NA>
#> 4889                                       <NA>                       <NA>
#> 4890                                       <NA>                       <NA>
#> 4891                                       <NA>                       <NA>
#> 4892                                       <NA>                       <NA>
#> 4893                                    C124300                       <NA>
#> 4894                                    C124299                       <NA>
#> 4895                                       <NA>                       <NA>
#> 4896                                       <NA>                       <NA>
#> 4897                                       <NA>                       <NA>
#> 4898                                     C71620                       <NA>
#> 4899                                       <NA>                       <NA>
#> 4900                                       <NA>                       <NA>
#> 4901                                     C71620                       <NA>
#> 4902                                     C66789                       <NA>
#> 4903                                       <NA>                       <NA>
#> 4904                                       <NA>                       <NA>
#> 4905                            C78734; C111114                       <NA>
#> 4906                                       <NA>                       <NA>
#> 4907                                     C78733                       <NA>
#> 4908                                     C85492                       <NA>
#> 4909                                     C66742                       <NA>
#> 4910                                       <NA>                       <NA>
#> 4911                                       <NA>                       <NA>
#> 4912                                       <NA>                       <NA>
#> 4913                                       <NA>                       <NA>
#> 4914                                       <NA>                       <NA>
#> 4915                                       <NA>                       <NA>
#> 4916                                       <NA>                       <NA>
#> 4917                                       <NA>                       <NA>
#> 4918                                       <NA>                       <NA>
#> 4919                                       <NA>                       <NA>
#> 4920                                       <NA>                       <NA>
#> 4921                                       <NA>                       <NA>
#> 4922                                       <NA>                       <NA>
#> 4923                                       <NA>                       <NA>
#> 4924                                       <NA>                       <NA>
#> 4925                                       <NA>                       <NA>
#> 4926                                       <NA>                       <NA>
#> 4927                                       <NA>                       <NA>
#> 4928                                       <NA>                       <NA>
#> 4929                                    C181173                       <NA>
#> 4930                                    C181174                       <NA>
#> 4931                                       <NA>                       <NA>
#> 4932                                    C181172                       <NA>
#> 4933                                       <NA>                       <NA>
#> 4934                                    C181175                       <NA>
#> 4935                                       <NA>                       <NA>
#> 4936                                       <NA>                       <NA>
#> 4937                                       <NA>                       <NA>
#> 4938                                       <NA>                       <NA>
#> 4939                                       <NA>                       <NA>
#> 4940                                       <NA>                       <NA>
#> 4941                                       <NA>                       <NA>
#> 4942                                    C181171                       <NA>
#> 4943                                       <NA>                       <NA>
#> 4944                                       <NA>                       <NA>
#> 4945                                       <NA>                       <NA>
#> 4946                                     C71620                       <NA>
#> 4947                                    C177910                       <NA>
#> 4948                                    C179588                       <NA>
#> 4949                                    C177908                       <NA>
#> 4950                                       <NA>                       <NA>
#> 4951                                       <NA>                       <NA>
#> 4952                                       <NA>                       <NA>
#> 4953                                       <NA>                       <NA>
#> 4954                                     C71620                       <NA>
#> 4955                                       <NA>                       <NA>
#> 4956                                       <NA>                       <NA>
#> 4957                                     C78736                       <NA>
#> 4958                                     C66789                       <NA>
#> 4959                                       <NA>                       <NA>
#> 4960                                       <NA>                       <NA>
#> 4961                                       <NA>                       <NA>
#> 4962                                     C78734                       <NA>
#> 4963                                     C78733                       <NA>
#> 4964                                     C85492                       <NA>
#> 4965                                       <NA>                       <NA>
#> 4966                                     C66742                       <NA>
#> 4967                                     C66742                       <NA>
#> 4968                                     C66742                       <NA>
#> 4969                                     C66742                       <NA>
#> 4970                                       <NA>                       <NA>
#> 4971                                       <NA>                       <NA>
#> 4972                                       <NA>                       <NA>
#> 4973                                       <NA>                       <NA>
#> 4974                                     C99079                       <NA>
#> 4975                                       <NA>                       <NA>
#> 4976                                       <NA>                       <NA>
#> 4977                                       <NA>                       <NA>
#> 4978                                       <NA>                       <NA>
#> 4979                                       <NA>                       <NA>
#> 4980                                       <NA>                       <NA>
#> 4981                                       <NA>                       <NA>
#> 4982                                       <NA>                       <NA>
#> 4983                                       <NA>                       <NA>
#> 4984                                       <NA>                       <NA>
#> 4985                                       <NA>                       <NA>
#> 4986                                       <NA>                       <NA>
#> 4987                                       <NA>                       <NA>
#> 4988                                       <NA>                       <NA>
#> 4989                                       <NA>                       <NA>
#> 4990                                       <NA>                       <NA>
#> 4991                                    C101847                       <NA>
#> 4992                                    C101846                       <NA>
#> 4993                                       <NA>                       <NA>
#> 4994                                       <NA>                       <NA>
#> 4995                                     C71148                       <NA>
#> 4996                                       <NA>                       <NA>
#> 4997                                     C71620                       <NA>
#> 4998                                       <NA>                       <NA>
#> 4999                                       <NA>                       <NA>
#> 5000                                     C71620                       <NA>
#> 5001                                     C66789                       <NA>
#> 5002                                       <NA>                       <NA>
#> 5003                                     C74456                       <NA>
#> 5004                                     C99073                       <NA>
#> 5005                                     C99074                       <NA>
#> 5006                                     C85492                       <NA>
#> 5007                                     C66742                       <NA>
#> 5008                                     C66742                       <NA>
#> 5009                                     C66742                       <NA>
#> 5010                                     C78735                       <NA>
#> 5011                                     C96777                       <NA>
#> 5012                                       <NA>                       <NA>
#> 5013                                       <NA>                       <NA>
#> 5014                                       <NA>                       <NA>
#> 5015                                       <NA>                       <NA>
#> 5016                                     C99079                       <NA>
#> 5017                                       <NA>                       <NA>
#> 5018                                       <NA>                       <NA>
#> 5019                                       <NA>                       <NA>
#> 5020                                       <NA>                       <NA>
#> 5021                                       <NA>                       <NA>
#> 5022                                       <NA>                       <NA>
#> 5023                                       <NA>                       <NA>
#> 5024                                       <NA>                       <NA>
#> 5025                                       <NA>                       <NA>
#> 5026                                       <NA>                       <NA>
#> 5027                                       <NA>                       <NA>
#> 5028                                       <NA>                       <NA>
#> 5029                                       <NA>                       <NA>
#> 5030                                       <NA>                       <NA>
#> 5031                                       <NA>                       <NA>
#> 5032                                       <NA>                       <NA>
#> 5033                                     C78732                       <NA>
#> 5034                                     C78731                       <NA>
#> 5035                                       <NA>                       <NA>
#> 5036                                       <NA>                       <NA>
#> 5037                                       <NA>                       <NA>
#> 5038                                     C71620                       <NA>
#> 5039                                       <NA>                       <NA>
#> 5040                                       <NA>                       <NA>
#> 5041                                     C71620                       <NA>
#> 5042                                     C66789                       <NA>
#> 5043                                       <NA>                       <NA>
#> 5044                                       <NA>                       <NA>
#> 5045                                       <NA>                       <NA>
#> 5046                                       <NA>                       <NA>
#> 5047                                       <NA>                       <NA>
#> 5048                                     C99079                       <NA>
#> 5049                                       <NA>                       <NA>
#> 5050                                       <NA>                       <NA>
#> 5051                                       <NA>                       <NA>
#> 5052                                       <NA>                       <NA>
#> 5053                                       <NA>                       <NA>
#> 5054                                       <NA>                       <NA>
#> 5055                                    C116108                       <NA>
#> 5056                                    C116107                       <NA>
#> 5057                                       <NA>                       <NA>
#> 5058                                       <NA>                       <NA>
#> 5059                                       <NA>                       <NA>
#> 5060                                     C78735                       <NA>
#> 5061                                       <NA>                       <NA>
#> 5062                                       <NA>                       <NA>
#> 5063                                       <NA>                       <NA>
#> 5064                                       <NA>                       <NA>
#> 5065                                       <NA>                       <NA>
#> 5066                                       <NA>                       <NA>
#> 5067                                       <NA>                       <NA>
#> 5068                                       <NA>                       <NA>
#> 5069                                       <NA>                       <NA>
#> 5070                                       <NA>                       <NA>
#> 5071                                       <NA>                       <NA>
#> 5072                            C71153; C120523                       <NA>
#> 5073                            C71152; C120524                       <NA>
#> 5074                                       <NA>                       <NA>
#> 5075                                       <NA>                       <NA>
#> 5076                                     C71148                       <NA>
#> 5077                                       <NA>                       <NA>
#> 5078                                     C71620                       <NA>
#> 5079                   C71150; C120522; C101834                       <NA>
#> 5080                                       <NA>                       <NA>
#> 5081                                     C71620                       <NA>
#> 5082                                     C66789                       <NA>
#> 5083                                       <NA>                       <NA>
#> 5084                                       <NA>                       <NA>
#> 5085                                       <NA>                       <NA>
#> 5086                                     C71151                       <NA>
#> 5087                                     C90013                       <NA>
#> 5088                                     C66742                       <NA>
#> 5089                                     C66742                       <NA>
#> 5090                                     C66742                       <NA>
#> 5091                                     C78735                       <NA>
#> 5092                                     C96777                       <NA>
#> 5093                                     C66742                       <NA>
#> 5094                                       <NA>                       <NA>
#> 5095                                       <NA>                       <NA>
#> 5096                                       <NA>                       <NA>
#> 5097                                       <NA>                       <NA>
#> 5098                                       <NA>                       <NA>
#> 5099                                     C99079                       <NA>
#> 5100                                       <NA>                       <NA>
#> 5101                                       <NA>                       <NA>
#> 5102                                       <NA>                       <NA>
#> 5103                                       <NA>                       <NA>
#> 5104                                       <NA>                       <NA>
#> 5105                                       <NA>                       <NA>
#> 5106                                       <NA>                       <NA>
#> 5107                                       <NA>                       <NA>
#> 5108                                       <NA>                       <NA>
#> 5109                                       <NA>                       <NA>
#> 5110                                       <NA>                       <NA>
#> 5111                                       <NA>                       <NA>
#> 5112                                       <NA>                       <NA>
#> 5113                                       <NA>                       <NA>
#> 5114                                       <NA>                       <NA>
#> 5115                                       <NA>                       <NA>
#> 5116                                    C115304                       <NA>
#> 5117                                       <NA>                       <NA>
#> 5118                                     C71148                       <NA>
#> 5119                                       <NA>                       <NA>
#> 5120                                     C71620                       <NA>
#> 5121                                       <NA>                       <NA>
#> 5122                                       <NA>                       <NA>
#> 5123                                     C71620                       <NA>
#> 5124                                     C66789                       <NA>
#> 5125                                       <NA>                       <NA>
#> 5126                                       <NA>                       <NA>
#> 5127                                       <NA>                       <NA>
#> 5128                                    C158113                       <NA>
#> 5129                                     C66742                       <NA>
#> 5130                                     C66742                       <NA>
#> 5131                                     C66742                       <NA>
#> 5132                                       <NA>                       <NA>
#> 5133                                       <NA>                       <NA>
#> 5134                                       <NA>                       <NA>
#> 5135                                       <NA>                       <NA>
#> 5136                                       <NA>                       <NA>
#> 5137                                     C99079                       <NA>
#> 5138                                       <NA>                       <NA>
#> 5139                                       <NA>                       <NA>
#> 5140                                       <NA>                       <NA>
#> 5141                                       <NA>                       <NA>
#> 5142                                       <NA>                       <NA>
#> 5143                                       <NA>                       <NA>
#> 5144                                       <NA>                       <NA>
#> 5145                                       <NA>                       <NA>
#> 5146                                       <NA>                       <NA>
#> 5147                                       <NA>                       <NA>
#> 5148                                       <NA>                       <NA>
#> 5149                                       <NA>                       <NA>
#> 5150                                       <NA>                       <NA>
#> 5151                                       <NA>                       <NA>
#> 5152                                       <NA>                       <NA>
#> 5153                                       <NA>                       <NA>
#> 5154                                       <NA>                       <NA>
#> 5155                                       <NA>                       <NA>
#> 5156                                    C181178                       <NA>
#> 5157                                    C181179                       <NA>
#> 5158                                    C181180                       <NA>
#> 5159                                       <NA>                       <NA>
#> 5160                                       <NA>                       <NA>
#> 5161                                       <NA>                       <NA>
#> 5162                                     C71620                       <NA>
#> 5163                                       <NA>                       <NA>
#> 5164                                       <NA>                       <NA>
#> 5165                                       <NA>                       <NA>
#> 5166                                     C71620                       <NA>
#> 5167                                       <NA>                       <NA>
#> 5168                                       <NA>                       <NA>
#> 5169                                       <NA>                       <NA>
#> 5170                                    C181177                       <NA>
#> 5171                                       <NA>                       <NA>
#> 5172                                       <NA>                       <NA>
#> 5173                                       <NA>                       <NA>
#> 5174                                    C181176                       <NA>
#> 5175                                       <NA>                       <NA>
#> 5176                                       <NA>                       <NA>
#> 5177                                       <NA>                       <NA>
#> 5178                                       <NA>                       <NA>
#> 5179                                       <NA>                       <NA>
#> 5180                                     C66789                       <NA>
#> 5181                                       <NA>                       <NA>
#> 5182                                       <NA>                       <NA>
#> 5183                                       <NA>                       <NA>
#> 5184                                    C111114                       <NA>
#> 5185                                     C85492                       <NA>
#> 5186                                       <NA>                       <NA>
#> 5187                                    C181181                       <NA>
#> 5188                                     C66742                       <NA>
#> 5189                                     C66742                       <NA>
#> 5190                                       <NA>                       <NA>
#> 5191                                       <NA>                       <NA>
#> 5192                                       <NA>                       <NA>
#> 5193                                       <NA>                       <NA>
#> 5194                                       <NA>                       <NA>
#> 5195                                       <NA>                       <NA>
#> 5196                                       <NA>                       <NA>
#> 5197                                       <NA>                       <NA>
#> 5198                                       <NA>                       <NA>
#> 5199                                       <NA>                       <NA>
#> 5200                                       <NA>                       <NA>
#> 5201                                       <NA>                       <NA>
#> 5202                                       <NA>                       <NA>
#> 5203                                       <NA>                       <NA>
#> 5204                                       <NA>                       <NA>
#> 5205                                       <NA>                       <NA>
#> 5206                                       <NA>                       <NA>
#> 5207                                       <NA>                       <NA>
#> 5208                                       <NA>                       <NA>
#> 5209                                     C66797                       <NA>
#> 5210                                       <NA>                       <NA>
#> 5211                                     C66742                       <NA>
#> 5212                                     C66742                       <NA>
#> 5213                                       <NA>                       <NA>
#> 5214                                       <NA>                       <NA>
#> 5215                                       <NA>                       <NA>
#> 5216                                       <NA>                       <NA>
#> 5217                                     C99079                       <NA>
#> 5218                                       <NA>                       <NA>
#> 5219                                       <NA>                       <NA>
#> 5220                                       <NA>                       <NA>
#> 5221                                       <NA>                       <NA>
#> 5222                                       <NA>                       <NA>
#> 5223                                       <NA>                       <NA>
#> 5224                                       <NA>                       <NA>
#> 5225                                       <NA>                       <NA>
#> 5226                                       <NA>                       <NA>
#> 5227                                       <NA>                       <NA>
#> 5228                                    C120525                       <NA>
#> 5229                                    C120526                       <NA>
#> 5230                                    C181175                       <NA>
#> 5231                                       <NA>                       <NA>
#> 5232                            C85491; C181169                       <NA>
#> 5233                                    C181170                       <NA>
#> 5234                                       <NA>                       <NA>
#> 5235                                       <NA>                       <NA>
#> 5236                                       <NA>                       <NA>
#> 5237                                       <NA>                       <NA>
#> 5238                                       <NA>                       <NA>
#> 5239                                     C71620                       <NA>
#> 5240                                       <NA>                       <NA>
#> 5241                                       <NA>                       <NA>
#> 5242                                       <NA>                       <NA>
#> 5243                                       <NA>                       <NA>
#> 5244                                     C71620                       <NA>
#> 5245                                       <NA>                       <NA>
#> 5246                                       <NA>                       <NA>
#> 5247                                       <NA>                       <NA>
#> 5248                                     C78736                       <NA>
#> 5249                                     C66789                       <NA>
#> 5250                                       <NA>                       <NA>
#> 5251                                       <NA>                       <NA>
#> 5252                                     C78734                       <NA>
#> 5253                                     C78733                       <NA>
#> 5254                                     C66742                       <NA>
#> 5255                                     C85492                       <NA>
#> 5256                                     C66742                       <NA>
#> 5257                                     C66742                       <NA>
#> 5258                                     C66742                       <NA>
#> 5259                                       <NA>                       <NA>
#> 5260                                       <NA>                       <NA>
#> 5261                                       <NA>                       <NA>
#> 5262                                       <NA>                       <NA>
#> 5263                                       <NA>                       <NA>
#> 5264                                     C99079                       <NA>
#> 5265                                       <NA>                       <NA>
#> 5266                                       <NA>                       <NA>
#> 5267                                       <NA>                       <NA>
#> 5268                                       <NA>                       <NA>
#> 5269                                       <NA>                       <NA>
#> 5270                                       <NA>                       <NA>
#> 5271                                       <NA>                       <NA>
#> 5272                                       <NA>                       <NA>
#> 5273                                       <NA>                       <NA>
#> 5274                                       <NA>                       <NA>
#> 5275                                       <NA>                       <NA>
#> 5276                                       <NA>                       <NA>
#> 5277                                       <NA>                       <NA>
#> 5278                                       <NA>                       <NA>
#> 5279                                       <NA>                       <NA>
#> 5280                                       <NA>                       <NA>
#> 5281                                     C65047                       <NA>
#> 5282                                     C67154                       <NA>
#> 5283                                    C181175                       <NA>
#> 5284                                       <NA>                       <NA>
#> 5285                                    C181170                       <NA>
#> 5286                                       <NA>                       <NA>
#> 5287                                       <NA>                       <NA>
#> 5288                                       <NA>                       <NA>
#> 5289                                     C71620                       <NA>
#> 5290                                    C177910                       <NA>
#> 5291                                    C179588                       <NA>
#> 5292                                    C177908                       <NA>
#> 5293                                       <NA>                       <NA>
#> 5294                                       <NA>                       <NA>
#> 5295                                       <NA>                       <NA>
#> 5296                                    C102580                       <NA>
#> 5297                                       <NA>                       <NA>
#> 5298                                     C71620                       <NA>
#> 5299                                       <NA>                       <NA>
#> 5300                                       <NA>                       <NA>
#> 5301                                       <NA>                       <NA>
#> 5302                                     C78736                       <NA>
#> 5303                                     C66789                       <NA>
#> 5304                                       <NA>                       <NA>
#> 5305                                       <NA>                       <NA>
#> 5306                                       <NA>                       <NA>
#> 5307                                     C78734                       <NA>
#> 5308                                     C78733                       <NA>
#> 5309                                     C66742                       <NA>
#> 5310                                     C85492                       <NA>
#> 5311                                    C160922                       <NA>
#> 5312                                    C179589                       <NA>
#> 5313                                     C66742                       <NA>
#> 5314                                     C66742                       <NA>
#> 5315                                     C66742                       <NA>
#> 5316                                     C66742                       <NA>
#> 5317                                       <NA>                       <NA>
#> 5318                                       <NA>                       <NA>
#> 5319                                     C66742                       <NA>
#> 5320                                       <NA>                       <NA>
#> 5321                                       <NA>                       <NA>
#> 5322                                       <NA>                       <NA>
#> 5323                                       <NA>                       <NA>
#> 5324                                     C99079                       <NA>
#> 5325                                       <NA>                       <NA>
#> 5326                                       <NA>                       <NA>
#> 5327                                       <NA>                       <NA>
#> 5328                                       <NA>                       <NA>
#> 5329                                       <NA>                       <NA>
#> 5330                                       <NA>                       <NA>
#> 5331                                       <NA>                       <NA>
#> 5332                                       <NA>                       <NA>
#> 5333                                       <NA>                       <NA>
#> 5334                                     C66742                       <NA>
#> 5335                                       <NA>                       <NA>
#> 5336                                       <NA>                       <NA>
#> 5337                                       <NA>                       <NA>
#> 5338                                       <NA>                       <NA>
#> 5339                                       <NA>                       <NA>
#> 5340                                       <NA>                       <NA>
#> 5341                                       <NA>                       <NA>
#> 5342                                       <NA>                       <NA>
#> 5343                                       <NA>                       <NA>
#> 5344                                       <NA>                       <NA>
#> 5345                                       <NA>                       <NA>
#> 5346                                    C120527                       <NA>
#> 5347                                    C120528                       <NA>
#> 5348                                    C174225                       <NA>
#> 5349                                       <NA>                       <NA>
#> 5350                                       <NA>                       <NA>
#> 5351                                       <NA>                       <NA>
#> 5352                                     C71620                       <NA>
#> 5353                                       <NA>                       <NA>
#> 5354                                       <NA>                       <NA>
#> 5355                                     C71620                       <NA>
#> 5356                                       <NA>                       <NA>
#> 5357                                     C66789                       <NA>
#> 5358                                       <NA>                       <NA>
#> 5359                                       <NA>                       <NA>
#> 5360                                       <NA>                       <NA>
#> 5361                                     C78734                       <NA>
#> 5362                                     C78733                       <NA>
#> 5363                                     C74456                       <NA>
#> 5364                                     C99073                       <NA>
#> 5365                                     C99074                       <NA>
#> 5366                                     C85492                       <NA>
#> 5367                                     C66742                       <NA>
#> 5368                                     C66742                       <NA>
#> 5369                                     C66742                       <NA>
#> 5370                                     C66742                       <NA>
#> 5371                                       <NA>                       <NA>
#> 5372                                       <NA>                       <NA>
#> 5373                                       <NA>                       <NA>
#> 5374                                       <NA>                       <NA>
#> 5375                                     C99079                       <NA>
#> 5376                                       <NA>                       <NA>
#> 5377                                       <NA>                       <NA>
#> 5378                                       <NA>                       <NA>
#> 5379                                       <NA>                       <NA>
#> 5380                                       <NA>                       <NA>
#> 5381                                       <NA>                       <NA>
#> 5382                                       <NA>                       <NA>
#> 5383                                       <NA>                       <NA>
#> 5384                                       <NA>                       <NA>
#> 5385                                       <NA>                       <NA>
#> 5386                                       <NA>                       <NA>
#> 5387                                       <NA>                       <NA>
#> 5388                                       <NA>                       <NA>
#> 5389                                       <NA>                       <NA>
#> 5390                                    C132263                       <NA>
#> 5391                                    C132262                       <NA>
#> 5392                                    C125922                       <NA>
#> 5393                                       <NA>                       <NA>
#> 5394                                       <NA>                       <NA>
#> 5395                                       <NA>                       <NA>
#> 5396                                     C71620                       <NA>
#> 5397                                       <NA>                       <NA>
#> 5398                                       <NA>                       <NA>
#> 5399                                     C71620                       <NA>
#> 5400                                       <NA>                       <NA>
#> 5401                                     C66789                       <NA>
#> 5402                                       <NA>                       <NA>
#> 5403                                       <NA>                       <NA>
#> 5404                                     C78734                       <NA>
#> 5405                                     C78733                       <NA>
#> 5406                                     C74456                       <NA>
#> 5407                                     C99073                       <NA>
#> 5408                                     C99074                       <NA>
#> 5409                                     C85492                       <NA>
#> 5410                                     C66742                       <NA>
#> 5411                                     C66742                       <NA>
#> 5412                                     C78735                       <NA>
#> 5413                                       <NA>                       <NA>
#> 5414                                       <NA>                       <NA>
#> 5415                                       <NA>                       <NA>
#> 5416                                       <NA>                       <NA>
#> 5417                                     C99079                       <NA>
#> 5418                                       <NA>                       <NA>
#> 5419                                       <NA>                       <NA>
#> 5420                                       <NA>                       <NA>
#> 5421                                       <NA>                       <NA>
#> 5422                                       <NA>                       <NA>
#> 5423                                       <NA>                       <NA>
#> 5424                                       <NA>                       <NA>
#> 5425                                       <NA>                       <NA>
#> 5426                                       <NA>                       <NA>
#> 5427                                       <NA>                       <NA>
#> 5428                                       <NA>                       <NA>
#> 5429                                    C127269                       <NA>
#> 5430                                    C127270                       <NA>
#> 5431                                       <NA>                       <NA>
#> 5432                                       <NA>                       <NA>
#> 5433                                     C71148                       <NA>
#> 5434                                       <NA>                       <NA>
#> 5435                                     C71620                       <NA>
#> 5436                                       <NA>                       <NA>
#> 5437                                       <NA>                       <NA>
#> 5438                                     C71620                       <NA>
#> 5439                                     C66789                       <NA>
#> 5440                                       <NA>                       <NA>
#> 5441                                     C74456                       <NA>
#> 5442                                     C99073                       <NA>
#> 5443                                     C99074                       <NA>
#> 5444                                     C85492                       <NA>
#> 5445                                     C66742                       <NA>
#> 5446                                     C66742                       <NA>
#> 5447                                     C66742                       <NA>
#> 5448                                     C78735                       <NA>
#> 5449                                     C96777                       <NA>
#> 5450                                       <NA>                       <NA>
#> 5451                                       <NA>                       <NA>
#> 5452                                       <NA>                       <NA>
#> 5453                                       <NA>                       <NA>
#> 5454                                     C99079                       <NA>
#> 5455                                       <NA>                       <NA>
#> 5456                                       <NA>                       <NA>
#> 5457                                       <NA>                       <NA>
#> 5458                                       <NA>                       <NA>
#> 5459                                       <NA>                       <NA>
#> 5460                                       <NA>                       <NA>
#> 5461                                       <NA>                       <NA>
#> 5462                                       <NA>                       <NA>
#> 5463                                       <NA>                       <NA>
#> 5464                                       <NA>                       <NA>
#> 5465                                       <NA>                       <NA>
#> 5466                                       <NA>                       <NA>
#> 5467                                       <NA>                       <NA>
#> 5468                                       <NA>                       <NA>
#> 5469                                       <NA>                       <NA>
#> 5470                                       <NA>                       <NA>
#> 5471                                    C128688                       <NA>
#> 5472                                    C128687                       <NA>
#> 5473                                       <NA>                       <NA>
#> 5474                                       <NA>                       <NA>
#> 5475                                     C71620                       <NA>
#> 5476                                       <NA>                       <NA>
#> 5477                                       <NA>                       <NA>
#> 5478                                       <NA>                       <NA>
#> 5479                                       <NA>                       <NA>
#> 5480                                     C71620                       <NA>
#> 5481                                       <NA>                       <NA>
#> 5482                                       <NA>                       <NA>
#> 5483                                     C71620                       <NA>
#> 5484                                     C78736                       <NA>
#> 5485                                     C85495                       <NA>
#> 5486                                     C66789                       <NA>
#> 5487                                       <NA>                       <NA>
#> 5488                                       <NA>                       <NA>
#> 5489                                       <NA>                       <NA>
#> 5490                                       <NA>                       <NA>
#> 5491                                     C78734                       <NA>
#> 5492                                     C78733                       <NA>
#> 5493                                     C74456                       <NA>
#> 5494                                     C99073                       <NA>
#> 5495                                     C99074                       <NA>
#> 5496                                     C85492                       <NA>
#> 5497                                       <NA>                       <NA>
#> 5498                                     C66742                       <NA>
#> 5499                                     C66742                       <NA>
#> 5500                                     C66742                       <NA>
#> 5501                                     C66742                       <NA>
#> 5502                                     C78735                       <NA>
#> 5503                                     C96777                       <NA>
#> 5504                                     C66742                       <NA>
#> 5505                                       <NA>                       <NA>
#> 5506                                       <NA>                       <NA>
#> 5507                                       <NA>                       <NA>
#> 5508                                       <NA>                       <NA>
#> 5509                                       <NA>                       <NA>
#> 5510                                       <NA>                       <NA>
#> 5511                                       <NA>                       <NA>
#> 5512                                     C99079                       <NA>
#> 5513                                       <NA>                       <NA>
#> 5514                                       <NA>                       <NA>
#> 5515                                       <NA>                       <NA>
#> 5516                                       <NA>                       <NA>
#> 5517                                       <NA>                       <NA>
#> 5518                                       <NA>                       <NA>
#> 5519                                       <NA>                       <NA>
#> 5520                                       <NA>                       <NA>
#> 5521                                       <NA>                       <NA>
#> 5522                                       <NA>                       <NA>
#> 5523                                       <NA>                       <NA>
#> 5524                                       <NA>                       <NA>
#> 5525                                       <NA>                       <NA>
#> 5526                                       <NA>                       <NA>
#> 5527                                       <NA>                       <NA>
#> 5528                                       <NA>                       <NA>
#> 5529                                       <NA>                       <NA>
#> 5530                                       <NA>                       <NA>
#> 5531                                       <NA>                       <NA>
#> 5532                                       <NA>                       <NA>
#> 5533                                    C116104                       <NA>
#> 5534                                    C116103                       <NA>
#> 5535                                       <NA>                       <NA>
#> 5536                                       <NA>                       <NA>
#> 5537                                       <NA>                       <NA>
#> 5538                                     C71620                       <NA>
#> 5539                                       <NA>                       <NA>
#> 5540                                       <NA>                       <NA>
#> 5541                                     C71620                       <NA>
#> 5542                                     C66789                       <NA>
#> 5543                                       <NA>                       <NA>
#> 5544                                     C74456                       <NA>
#> 5545                                     C99073                       <NA>
#> 5546                                     C99074                       <NA>
#> 5547                                     C85492                       <NA>
#> 5548                                     C66742                       <NA>
#> 5549                                     C66742                       <NA>
#> 5550                                     C66742                       <NA>
#> 5551                                     C78735                       <NA>
#> 5552                                     C96777                       <NA>
#> 5553                                       <NA>                       <NA>
#> 5554                                       <NA>                       <NA>
#> 5555                                       <NA>                       <NA>
#> 5556                                       <NA>                       <NA>
#> 5557                                     C99079                       <NA>
#> 5558                                       <NA>                       <NA>
#> 5559                                       <NA>                       <NA>
#> 5560                                       <NA>                       <NA>
#> 5561                                       <NA>                       <NA>
#> 5562                                       <NA>                       <NA>
#> 5563                                       <NA>                       <NA>
#> 5564                                       <NA>                       <NA>
#> 5565                                       <NA>                       <NA>
#> 5566                                       <NA>                       <NA>
#> 5567                                       <NA>                       <NA>
#> 5568                                    C119013                       <NA>
#> 5569                                       <NA>                       <NA>
#> 5570                                       <NA>                       <NA>
#> 5571                                       <NA>                       <NA>
#> 5572                                       <NA>                       <NA>
#> 5573                                    C117743                       <NA>
#> 5574                                    C117742                       <NA>
#> 5575                                       <NA>                       <NA>
#> 5576                                       <NA>                       <NA>
#> 5577                                       <NA>                       <NA>
#> 5578                                       <NA>                       <NA>
#> 5579                                     C71620                       <NA>
#> 5580                                       <NA>                       <NA>
#> 5581                                       <NA>                       <NA>
#> 5582                                       <NA>                       <NA>
#> 5583                                       <NA>                       <NA>
#> 5584                                     C71620                       <NA>
#> 5585                                       <NA>                       <NA>
#> 5586                                       <NA>                       <NA>
#> 5587                                       <NA>                       <NA>
#> 5588                                     C78736                       <NA>
#> 5589                                       <NA>                       <NA>
#> 5590                                     C66789                       <NA>
#> 5591                                       <NA>                       <NA>
#> 5592                                       <NA>                       <NA>
#> 5593                                     C74456                       <NA>
#> 5594                                     C99073                       <NA>
#> 5595                                     C99074                       <NA>
#> 5596                                     C99075                       <NA>
#> 5597                                     C85492                       <NA>
#> 5598                                     C66742                       <NA>
#> 5599                                     C66742                       <NA>
#> 5600                                     C66742                       <NA>
#> 5601                                     C78735                       <NA>
#> 5602                                     C96777                       <NA>
#> 5603                                     C66742                       <NA>
#> 5604                                       <NA>                       <NA>
#> 5605                                       <NA>                       <NA>
#> 5606                                       <NA>                       <NA>
#> 5607                                       <NA>                       <NA>
#> 5608                                       <NA>                       <NA>
#> 5609                                     C99079                       <NA>
#> 5610                                       <NA>                       <NA>
#> 5611                                       <NA>                       <NA>
#> 5612                                       <NA>                       <NA>
#> 5613                                       <NA>                       <NA>
#> 5614                                       <NA>                       <NA>
#> 5615                                       <NA>                       <NA>
#> 5616                                       <NA>                       <NA>
#> 5617                                       <NA>                       <NA>
#> 5618                                       <NA>                       <NA>
#> 5619                                       <NA>                       <NA>
#> 5620                                       <NA>                       <NA>
#> 5621                                       <NA>                       <NA>
#> 5622                                       <NA>                       <NA>
#> 5623                                       <NA>                       <NA>
#> 5624                                       <NA>                       <NA>
#> 5625                                       <NA>                       <NA>
#> 5626                                       <NA>                       <NA>
#> 5627                                       <NA>                       <NA>
#> 5628                                       <NA>                       <NA>
#> 5629                                     C85494                       <NA>
#> 5630                                       <NA>                       <NA>
#> 5631                                       <NA>                       <NA>
#> 5632                                     C85494                       <NA>
#> 5633                                     C66789                       <NA>
#> 5634                                       <NA>                       <NA>
#> 5635                                       <NA>                       <NA>
#> 5636                                     C78734                       <NA>
#> 5637                                     C78733                       <NA>
#> 5638                                     C85492                       <NA>
#> 5639                                     C66742                       <NA>
#> 5640                                     C66742                       <NA>
#> 5641                                       <NA>                       <NA>
#> 5642                                       <NA>                       <NA>
#> 5643                                       <NA>                       <NA>
#> 5644                                       <NA>                       <NA>
#> 5645                                       <NA>                       <NA>
#> 5646                                       <NA>                       <NA>
#> 5647                                     C99079                       <NA>
#> 5648                                       <NA>                       <NA>
#> 5649                                       <NA>                       <NA>
#> 5650                                       <NA>                       <NA>
#> 5651                                       <NA>                       <NA>
#> 5652                                       <NA>                       <NA>
#> 5653                                       <NA>                       <NA>
#> 5654                                       <NA>                       <NA>
#> 5655                                       <NA>                       <NA>
#> 5656                                       <NA>                       <NA>
#> 5657                                       <NA>                       <NA>
#> 5658                                       <NA>                       <NA>
#> 5659                                       <NA>                       <NA>
#> 5660                                       <NA>                       <NA>
#> 5661                                       <NA>                       <NA>
#> 5662                                       <NA>                       <NA>
#> 5663                                       <NA>                       <NA>
#> 5664                                       <NA>                       <NA>
#> 5665                                       <NA>                       <NA>
#> 5666                                       <NA>                       <NA>
#> 5667                                       <NA>                       <NA>
#> 5668                                       <NA>                       <NA>
#> 5669                                       <NA>                       <NA>
#> 5670                                       <NA>                       <NA>
#> 5671                                     C71620                       <NA>
#> 5672                                       <NA>                       <NA>
#> 5673                                     C66789                       <NA>
#> 5674                                       <NA>                       <NA>
#> 5675                                     C74456                       <NA>
#> 5676                                     C99073                       <NA>
#> 5677                                     C85492                       <NA>
#> 5678                                     C66742                       <NA>
#> 5679                                     C66742                       <NA>
#> 5680                                     C78735                       <NA>
#> 5681                                       <NA>                       <NA>
#> 5682                                       <NA>                       <NA>
#> 5683                                       <NA>                       <NA>
#> 5684                                       <NA>                       <NA>
#> 5685                                     C99079                       <NA>
#> 5686                                       <NA>                       <NA>
#> 5687                                       <NA>                       <NA>
#> 5688                                       <NA>                       <NA>
#> 5689                                       <NA>                       <NA>
#> 5690                                       <NA>                       <NA>
#> 5691                                       <NA>                       <NA>
#> 5692                                       <NA>                       <NA>
#> 5693                                     C85839                       <NA>
#> 5694                                     C85493                       <NA>
#> 5695                                       <NA>                       <NA>
#> 5696                                       <NA>                       <NA>
#> 5697                                       <NA>                       <NA>
#> 5698 C85494; C128684; C128683; C128685; C128686                       <NA>
#> 5699                                       <NA>                       <NA>
#> 5700                                       <NA>                       <NA>
#> 5701 C85494; C128684; C128683; C128685; C128686                       <NA>
#> 5702                                     C66789                       <NA>
#> 5703                                       <NA>                       <NA>
#> 5704                                     C78734                       <NA>
#> 5705                                    C172330                       <NA>
#> 5706                                       <NA>                       <NA>
#> 5707                                     C99079                       <NA>
#> 5708                                       <NA>                       <NA>
#> 5709                                       <NA>                       <NA>
#> 5710                                       <NA>                       <NA>
#> 5711                                       <NA>                       <NA>
#> 5712                                       <NA>                       <NA>
#> 5713                                       <NA>                       <NA>
#> 5714                                       <NA>                       <NA>
#> 5715                                       <NA>                       <NA>
#> 5716                                       <NA>                       <NA>
#> 5717                                       <NA>                       <NA>
#> 5718                                       <NA>                       <NA>
#> 5719                                       <NA>                       <NA>
#> 5720                                       <NA>                       <NA>
#> 5721                                       <NA>                       <NA>
#> 5722                                    C100129                       <NA>
#> 5723                                       <NA>                       <NA>
#> 5724                                       <NA>                       <NA>
#> 5725                                     C71620                       <NA>
#> 5726                                       <NA>                       <NA>
#> 5727                                       <NA>                       <NA>
#> 5728                                     C71620                       <NA>
#> 5729                                     C66789                       <NA>
#> 5730                                       <NA>                       <NA>
#> 5731                                    C158113                       <NA>
#> 5732                                     C66742                       <NA>
#> 5733                                     C66742                       <NA>
#> 5734                                     C66742                       <NA>
#> 5735                                       <NA>                       <NA>
#> 5736                                       <NA>                       <NA>
#> 5737                                       <NA>                       <NA>
#> 5738                                       <NA>                       <NA>
#> 5739                                     C99079                       <NA>
#> 5740                                       <NA>                       <NA>
#> 5741                                       <NA>                       <NA>
#> 5742                                       <NA>                       <NA>
#> 5743                                       <NA>                       <NA>
#> 5744                                       <NA>                       <NA>
#> 5745                                       <NA>                       <NA>
#> 5746                                       <NA>                       <NA>
#> 5747                                       <NA>                       <NA>
#> 5748                                       <NA>                       <NA>
#> 5749                                       <NA>                       <NA>
#> 5750                                       <NA>                       <NA>
#> 5751                                       <NA>                       <NA>
#> 5752                                       <NA>                       <NA>
#> 5753                                       <NA>                       <NA>
#> 5754                                       <NA>                       <NA>
#> 5755                                       <NA>                       <NA>
#> 5756                                       <NA>                       <NA>
#> 5757                                       <NA>                       <NA>
#> 5758                                       <NA>                       <NA>
#> 5759                                    C111106                       <NA>
#> 5760                                    C111107                       <NA>
#> 5761                                       <NA>                       <NA>
#> 5762                                       <NA>                       <NA>
#> 5763                                     C71148                       <NA>
#> 5764                                       <NA>                       <NA>
#> 5765                                     C71620                       <NA>
#> 5766                                       <NA>                       <NA>
#> 5767                                       <NA>                       <NA>
#> 5768                                       <NA>                       <NA>
#> 5769                                     C71620                       <NA>
#> 5770                                       <NA>                       <NA>
#> 5771                                       <NA>                       <NA>
#> 5772                                     C66789                       <NA>
#> 5773                                       <NA>                       <NA>
#> 5774                                     C74456                       <NA>
#> 5775                                     C99073                       <NA>
#> 5776                                     C99074                       <NA>
#> 5777                                     C85492                       <NA>
#> 5778                                     C66742                       <NA>
#> 5779                                     C66742                       <NA>
#> 5780                                     C66742                       <NA>
#> 5781                                     C78735                       <NA>
#> 5782                                     C96777                       <NA>
#> 5783                                       <NA>                       <NA>
#> 5784                                       <NA>                       <NA>
#> 5785                                       <NA>                       <NA>
#> 5786                                       <NA>                       <NA>
#> 5787                                       <NA>                       <NA>
#> 5788                                     C99079                       <NA>
#> 5789                                       <NA>                       <NA>
#> 5790                                       <NA>                       <NA>
#> 5791                                       <NA>                       <NA>
#> 5792                                       <NA>                       <NA>
#> 5793                                       <NA>                       <NA>
#> 5794                                       <NA>                       <NA>
#> 5795                                       <NA>                       <NA>
#> 5796                                       <NA>                       <NA>
#> 5797                                       <NA>                       <NA>
#> 5798                                       <NA>                       <NA>
#> 5799                                       <NA>                       <NA>
#> 5800                                       <NA>                       <NA>
#> 5801                                       <NA>                       <NA>
#> 5802                                       <NA>                       <NA>
#> 5803                                       <NA>                       <NA>
#> 5804                                       <NA>                       <NA>
#> 5805                                    C106479                       <NA>
#> 5806                                    C106478                       <NA>
#> 5807                                       <NA>                       <NA>
#> 5808                                       <NA>                       <NA>
#> 5809                                       <NA>                       <NA>
#> 5810                                     C71620                       <NA>
#> 5811                                       <NA>                       <NA>
#> 5812                                       <NA>                       <NA>
#> 5813                                     C71620                       <NA>
#> 5814                                     C66789                       <NA>
#> 5815                                       <NA>                       <NA>
#> 5816                                     C66742                       <NA>
#> 5817                                     C66742                       <NA>
#> 5818                                     C66742                       <NA>
#> 5819                                       <NA>                       <NA>
#> 5820                                       <NA>                       <NA>
#> 5821                                       <NA>                       <NA>
#> 5822                                       <NA>                       <NA>
#> 5823                                     C99079                       <NA>
#> 5824                                       <NA>                       <NA>
#> 5825                                       <NA>                       <NA>
#> 5826                                       <NA>                       <NA>
#> 5827                                       <NA>                       <NA>
#> 5828                                       <NA>                       <NA>
#> 5829                                       <NA>                       <NA>
#> 5830                                       <NA>                       <NA>
#> 5831                                       <NA>                       <NA>
#> 5832                                       <NA>                       <NA>
#> 5833                                       <NA>                       <NA>
#> 5834                                       <NA>                       <NA>
#> 5835                                       <NA>                       <NA>
#> 5836                                       <NA>                       <NA>
#> 5837                                       <NA>                       <NA>
#> 5838                                       <NA>                       <NA>
#> 5839                                       <NA>                       <NA>
#> 5840                                       <NA>                       <NA>
#> 5841                                     C96782                       <NA>
#> 5842                                     C96781                       <NA>
#> 5843                           C124298; C118971                       <NA>
#> 5844                                       <NA>                       <NA>
#> 5845                                       <NA>                       <NA>
#> 5846                                     C71620                       <NA>
#> 5847                                     C96785                       <NA>
#> 5848                                       <NA>                       <NA>
#> 5849                                     C71620                       <NA>
#> 5850                                     C66789                       <NA>
#> 5851                                       <NA>                       <NA>
#> 5852                                       <NA>                       <NA>
#> 5853                                    C158113                       <NA>
#> 5854                                     C66742                       <NA>
#> 5855                                     C66742                       <NA>
#> 5856                                     C66742                       <NA>
#> 5857                                     C78735                       <NA>
#> 5858                                     C96777                       <NA>
#> 5859                                     C66742                       <NA>
#> 5860                                       <NA>                       <NA>
#> 5861                                       <NA>                       <NA>
#> 5862                                       <NA>                       <NA>
#> 5863                                       <NA>                       <NA>
#> 5864                                     C99079                       <NA>
#> 5865                                       <NA>                       <NA>
#> 5866                                       <NA>                       <NA>
#> 5867                                       <NA>                       <NA>
#> 5868                                       <NA>                       <NA>
#> 5869                                       <NA>                       <NA>
#> 5870                                       <NA>                       <NA>
#> 5871                                       <NA>                       <NA>
#> 5872                                       <NA>                       <NA>
#> 5873                                       <NA>                       <NA>
#> 5874                                     C66728                       <NA>
#> 5875                                       <NA>                       <NA>
#> 5876                                     C66728                       <NA>
#> 5877                                       <NA>                       <NA>
#> 5878                                       <NA>                       <NA>
#> 5879                                       <NA>                       <NA>
#> 5880                                       <NA>                       <NA>
#> 5881                                       <NA>                       <NA>
#> 5882                                       <NA>                       <NA>
#> 5883                                       <NA>                       <NA>
#> 5884                                     C74559                       <NA>
#> 5885                                    C103330                       <NA>
#> 5886                                       <NA>                       <NA>
#> 5887                                       <NA>                       <NA>
#> 5888                                       <NA>                       <NA>
#> 5889                                     C71620                       <NA>
#> 5890                                       <NA>                       <NA>
#> 5891                                       <NA>                       <NA>
#> 5892                                     C71620                       <NA>
#> 5893                                     C66789                       <NA>
#> 5894                                       <NA>                       <NA>
#> 5895                                       <NA>                       <NA>
#> 5896                                       <NA>                       <NA>
#> 5897                                       <NA>                       <NA>
#> 5898                                       <NA>                       <NA>
#> 5899                                     C99079                       <NA>
#> 5900                                       <NA>                       <NA>
#> 5901                                       <NA>                       <NA>
#> 5902                                       <NA>                       <NA>
#> 5903                                       <NA>                       <NA>
#> 5904                                       <NA>                       <NA>
#> 5905                                       <NA>                       <NA>
#> 5906                                       <NA>                       <NA>
#> 5907                                       <NA>                       <NA>
#> 5908                                    C124305                       <NA>
#> 5909                                    C124306                       <NA>
#> 5910                                       <NA>                       <NA>
#> 5911                                       <NA>                       <NA>
#> 5912                                       <NA>                       <NA>
#> 5913                                    C124304                       <NA>
#> 5914                                     C66789                       <NA>
#> 5915                                       <NA>                       <NA>
#> 5916                                     C78735                       <NA>
#> 5917                                       <NA>                       <NA>
#> 5918                                       <NA>                       <NA>
#> 5919                                       <NA>                       <NA>
#> 5920                                       <NA>                       <NA>
#> 5921                                     C99079                       <NA>
#> 5922                                       <NA>                       <NA>
#> 5923                                       <NA>                       <NA>
#> 5924                                       <NA>                       <NA>
#> 5925                                       <NA>                       <NA>
#> 5926                                       <NA>                       <NA>
#> 5927                                       <NA>                       <NA>
#> 5928                                       <NA>                       <NA>
#> 5929                                       <NA>                       <NA>
#> 5930                                       <NA>                       <NA>
#> 5931                                       <NA>                       <NA>
#> 5932                                       <NA>                       <NA>
#> 5933                                     C96779                       <NA>
#> 5934                                     C96778                       <NA>
#> 5935                                       <NA>                       <NA>
#> 5936                                     C71620                       <NA>
#> 5937                                    C124309                       <NA>
#> 5938                                       <NA>                       <NA>
#> 5939                                     C71620                       <NA>
#> 5940                                     C66789                       <NA>
#> 5941                                       <NA>                       <NA>
#> 5942                                       <NA>                       <NA>
#> 5943                                     C85492                       <NA>
#> 5944                                     C66742                       <NA>
#> 5945                                     C66742                       <NA>
#> 5946                                     C78735                       <NA>
#> 5947                                     C96777                       <NA>
#> 5948                                     C66742                       <NA>
#> 5949                                       <NA>                       <NA>
#> 5950                                       <NA>                       <NA>
#> 5951                                       <NA>                       <NA>
#> 5952                                       <NA>                       <NA>
#> 5953                                     C99079                       <NA>
#> 5954                                       <NA>                       <NA>
#> 5955                                       <NA>                       <NA>
#> 5956                                       <NA>                       <NA>
#> 5957                                       <NA>                       <NA>
#> 5958                                       <NA>                       <NA>
#> 5959                                       <NA>                       <NA>
#> 5960                                       <NA>                       <NA>
#> 5961                                       <NA>                       <NA>
#> 5962                                       <NA>                       <NA>
#> 5963                                       <NA>                       <NA>
#> 5964                                       <NA>                       <NA>
#> 5965                                     C96784                       <NA>
#> 5966                                     C96783                       <NA>
#> 5967                                       <NA>                       <NA>
#> 5968                                    C123650                       <NA>
#> 5969                                       <NA>                       <NA>
#> 5970                                     C74456                       <NA>
#> 5971                                     C99073                       <NA>
#> 5972                                     C99074                       <NA>
#> 5973                                     C99075                       <NA>
#> 5974                                     C85492                       <NA>
#> 5975                                     C66742                       <NA>
#> 5976                                     C66742                       <NA>
#> 5977                                     C78735                       <NA>
#> 5978                                     C96777                       <NA>
#> 5979                                     C66742                       <NA>
#> 5980                                       <NA>                       <NA>
#> 5981                                       <NA>                       <NA>
#> 5982                                       <NA>                       <NA>
#> 5983                                       <NA>                       <NA>
#> 5984                                     C99079                       <NA>
#> 5985                                       <NA>                       <NA>
#> 5986                                       <NA>                       <NA>
#> 5987                                       <NA>                       <NA>
#> 5988                                       <NA>                       <NA>
#> 5989                                       <NA>                       <NA>
#> 5990                                       <NA>                       <NA>
#> 5991                                       <NA>                       <NA>
#> 5992                                       <NA>                       <NA>
#> 5993                                       <NA>                       <NA>
#> 5994                                       <NA>                       <NA>
#> 5995                                       <NA>                       <NA>
#> 5996                                    C129942                       <NA>
#> 5997                                    C129941                       <NA>
#> 5998                                       <NA>                       <NA>
#> 5999                                       <NA>                       <NA>
#> 6000                                       <NA>                       <NA>
#> 6001                                       <NA>                       <NA>
#> 6002                                     C71620                       <NA>
#> 6003                                       <NA>                       <NA>
#> 6004                                       <NA>                       <NA>
#> 6005                                     C71620                       <NA>
#> 6006                                       <NA>                       <NA>
#> 6007                                     C66789                       <NA>
#> 6008                                       <NA>                       <NA>
#> 6009                                     C74456                       <NA>
#> 6010                                     C99073                       <NA>
#> 6011                                     C99074                       <NA>
#> 6012                                     C85492                       <NA>
#> 6013                                     C66742                       <NA>
#> 6014                                     C66742                       <NA>
#> 6015                                     C66742                       <NA>
#> 6016                                     C78735                       <NA>
#> 6017                                     C96777                       <NA>
#> 6018                                       <NA>                       <NA>
#> 6019                                       <NA>                       <NA>
#> 6020                                       <NA>                       <NA>
#> 6021                                       <NA>                       <NA>
#> 6022                                     C99079                       <NA>
#> 6023                                       <NA>                       <NA>
#> 6024                                       <NA>                       <NA>
#> 6025                                       <NA>                       <NA>
#> 6026                                       <NA>                       <NA>
#> 6027                                       <NA>                       <NA>
#> 6028                                       <NA>                       <NA>
#> 6029                                       <NA>                       <NA>
#> 6030                                       <NA>                       <NA>
#> 6031                                       <NA>                       <NA>
#> 6032                                       <NA>                       <NA>
#> 6033                                       <NA>                       <NA>
#> 6034                                       <NA>                       <NA>
#> 6035                                       <NA>                       <NA>
#> 6036                                     C66741                       <NA>
#> 6037                                     C67153                       <NA>
#> 6038                                       <NA>                       <NA>
#> 6039                                       <NA>                       <NA>
#> 6040                                     C71148                       <NA>
#> 6041                                       <NA>                       <NA>
#> 6042                                     C66770                       <NA>
#> 6043                                       <NA>                       <NA>
#> 6044                                       <NA>                       <NA>
#> 6045                                     C66770                       <NA>
#> 6046                                     C66789                       <NA>
#> 6047                                       <NA>                       <NA>
#> 6048                                     C74456                       <NA>
#> 6049                                     C99073                       <NA>
#> 6050                                     C66742                       <NA>
#> 6051                                     C66742                       <NA>
#> 6052                                     C66742                       <NA>
#> 6053                                       <NA>                       <NA>
#> 6054                                       <NA>                       <NA>
#> 6055                                     C66742                       <NA>
#> 6056                                       <NA>                       <NA>
#> 6057                                       <NA>                       <NA>
#> 6058                                       <NA>                       <NA>
#> 6059                                       <NA>                       <NA>
#> 6060                                     C99079                       <NA>
#> 6061                                       <NA>                       <NA>
#> 6062                                       <NA>                       <NA>
#> 6063                                       <NA>                       <NA>
#> 6064                                       <NA>                       <NA>
#> 6065                                       <NA>                       <NA>
#> 6066                                       <NA>                       <NA>
#> 6067                                       <NA>                       <NA>
#> 6068                                       <NA>                       <NA>
#> 6069                                       <NA>                       <NA>
#> 6070                                       <NA>                       <NA>
#> 6071                                       <NA>                       <NA>
#> 6072                                       <NA>                       <NA>
#> 6073                                       <NA>                       <NA>
#> 6074                                    C101832                       <NA>
#> 6075                                    C101833                       <NA>
#> 6076                                       <NA>                       <NA>
#> 6077                                       <NA>                       <NA>
#> 6078                                       <NA>                       <NA>
#> 6079                                       <NA>                       <NA>
#> 6080                                     C71620                       <NA>
#> 6081                                       <NA>                       <NA>
#> 6082                                       <NA>                       <NA>
#> 6083                                     C71620                       <NA>
#> 6084                                     C66789                       <NA>
#> 6085                                       <NA>                       <NA>
#> 6086                                     C74456                       <NA>
#> 6087                                     C99073                       <NA>
#> 6088                                     C66742                       <NA>
#> 6089                                     C66742                       <NA>
#> 6090                                     C78735                       <NA>
#> 6091                                       <NA>                       <NA>
#> 6092                                       <NA>                       <NA>
#> 6093                                       <NA>                       <NA>
#> 6094                                       <NA>                       <NA>
#> 6095                                     C99079                       <NA>
#> 6096                                       <NA>                       <NA>
#> 6097                                       <NA>                       <NA>
#> 6098                                       <NA>                       <NA>
#> 6099                                       <NA>                       <NA>
#> 6100                                       <NA>                       <NA>
#> 6101                                       <NA>                       <NA>
#> 6102                                       <NA>                       <NA>
#> 6103                                       <NA>                       <NA>
#> 6104                                       <NA>                       <NA>
#> 6105                                    C112024                       <NA>
#> 6106                                    C112023                       <NA>
#> 6107                                       <NA>                       <NA>
#> 6108                                       <NA>                       <NA>
#> 6109                                       <NA>                       <NA>
#> 6110                                       <NA>                       <NA>
#> 6111                                     C71620                       <NA>
#> 6112                                       <NA>                       <NA>
#> 6113                                       <NA>                       <NA>
#> 6114                                     C71620                       <NA>
#> 6115                                     C66789                       <NA>
#> 6116                                       <NA>                       <NA>
#> 6117                                       <NA>                       <NA>
#> 6118                                     C78734                       <NA>
#> 6119                                     C74456                       <NA>
#> 6120                                     C99073                       <NA>
#> 6121                                     C85492                       <NA>
#> 6122                                     C66742                       <NA>
#> 6123                                     C66742                       <NA>
#> 6124                                     C78735                       <NA>
#> 6125                                       <NA>                       <NA>
#> 6126                                       <NA>                       <NA>
#> 6127                                       <NA>                       <NA>
#> 6128                                       <NA>                       <NA>
#> 6129                                     C99079                       <NA>
#> 6130                                       <NA>                       <NA>
#> 6131                                       <NA>                       <NA>
#> 6132                                       <NA>                       <NA>
#> 6133                                       <NA>                       <NA>
#> 6134                                       <NA>                       <NA>
#> 6135                                       <NA>                       <NA>
#> 6136                                       <NA>                       <NA>
#> 6137                                       <NA>                       <NA>
#> 6138                                       <NA>                       <NA>
#> 6139                                     C66734                       <NA>
#> 6140                                       <NA>                       <NA>
#> 6141                                       <NA>                       <NA>
#> 6142                                       <NA>                       <NA>
#> 6143                                       <NA>                       <NA>
#> 6144                                       <NA>                       <NA>
#> 6145                                       <NA>                       <NA>
#> 6146                                     C78735                       <NA>
#> 6147                                     C96777                       <NA>
#> 6148                                       <NA>                       <NA>
#> 6149                                       <NA>                       <NA>
#> 6150                                       <NA>                       <NA>
#> 6151                                       <NA>                       <NA>
#> 6152                                       <NA>                       <NA>
#> 6153                                       <NA>                       <NA>
#> 6154                                       <NA>                       <NA>
#> 6155                                       <NA>                       <NA>
#> 6156                                       <NA>                       <NA>
#> 6157                                       <NA>                       <NA>
#> 6158                                       <NA>                       <NA>
#> 6159                                       <NA>                       <NA>
#> 6160                                       <NA>                       <NA>
#> 6161                                       <NA>                       <NA>
#> 6162                                       <NA>                       <NA>
#> 6163                                     C66742                       <NA>
#> 6164                                       <NA>                       <NA>
#> 6165                                       <NA>                       <NA>
#> 6166                                       <NA>                       <NA>
#> 6167                                       <NA>                       <NA>
#> 6168                                       <NA>                       <NA>
#> 6169                                     C66781                       <NA>
#> 6170                                     C66731                       <NA>
#> 6171                                     C74457                       <NA>
#> 6172                                     C66790                       <NA>
#> 6173                                       <NA>                       <NA>
#> 6174                                       <NA>                       <NA>
#> 6175                                       <NA>                       <NA>
#> 6176                                       <NA>                       <NA>
#> 6177                                    C142179                       <NA>
#> 6178                                       <NA>                       <NA>
#> 6179                                       <NA>                       <NA>
#> 6180                                       <NA>                       <NA>
#> 6181                                       <NA>                       <NA>
#> 6182                                       <NA>                       <NA>
#> 6183                                       <NA>                       <NA>
#> 6184                                       <NA>                       <NA>
#> 6185                                       <NA>                       <NA>
#> 6186                                       <NA>                       <NA>
#> 6187                                       <NA>                       <NA>
#> 6188                                       <NA>                       <NA>
#> 6189                                     C99079                       <NA>
#> 6190                                       <NA>                       <NA>
#> 6191                                       <NA>                       <NA>
#> 6192                                       <NA>                       <NA>
#> 6193                                       <NA>                       <NA>
#> 6194                                       <NA>                       <NA>
#> 6195                                       <NA>                       <NA>
#> 6196                                       <NA>                       <NA>
#> 6197                                       <NA>                       <NA>
#> 6198                                       <NA>                       <NA>
#> 6199                                       <NA>                       <NA>
#> 6200                                       <NA>                       <NA>
#> 6201                                       <NA>                       <NA>
#> 6202                                       <NA>                       <NA>
#> 6203                                       <NA>                       <NA>
#> 6204                                       <NA>                       <NA>
#> 6205                                       <NA>                       <NA>
#> 6206                                       <NA>                       <NA>
#> 6207                                       <NA>                       <NA>
#> 6208                                       <NA>                       <NA>
#> 6209                                       <NA>                       <NA>
#> 6210                                     C66742                       <NA>
#> 6211                                     C66742                       <NA>
#> 6212                                       <NA>                       <NA>
#> 6213                                    C171445                       <NA>
#> 6214                                     C66742                       <NA>
#> 6215                                       <NA>                       <NA>
#> 6216                                       <NA>                       <NA>
#> 6217                                       <NA>                       <NA>
#> 6218                                       <NA>                       <NA>
#> 6219                                       <NA>                       <NA>
#> 6220                                       <NA>                       <NA>
#> 6221                                       <NA>                       <NA>
#> 6222                                       <NA>                       <NA>
#> 6223                                       <NA>                       <NA>
#> 6224                                       <NA>                       <NA>
#> 6225                                       <NA>                       <NA>
#> 6226                                       <NA>                       <NA>
#> 6227                                       <NA>                       <NA>
#> 6228                                       <NA>                       <NA>
#> 6229                                       <NA>                       <NA>
#> 6230                                     C99079                       <NA>
#> 6231                                       <NA>                       <NA>
#> 6232                                       <NA>                       <NA>
#> 6233                                       <NA>                       <NA>
#> 6234                                       <NA>                       <NA>
#> 6235                                       <NA>                       <NA>
#> 6236                                       <NA>                       <NA>
#> 6237                                       <NA>                       <NA>
#> 6238                                       <NA>                       <NA>
#> 6239                                       <NA>                       <NA>
#> 6240                                       <NA>                       <NA>
#> 6241                                       <NA>                       <NA>
#> 6242                                       <NA>                       <NA>
#> 6243                                       <NA>                       <NA>
#> 6244                                       <NA>                       <NA>
#> 6245                                       <NA>                       <NA>
#> 6246                                       <NA>                       <NA>
#> 6247                                       <NA>                       <NA>
#> 6248                                       <NA>                       <NA>
#> 6249                                       <NA>                       <NA>
#> 6250                                       <NA>                       <NA>
#> 6251                                     C66797                       <NA>
#> 6252                                       <NA>                       <NA>
#> 6253                                       <NA>                       <NA>
#> 6254                                       <NA>                       <NA>
#> 6255                                       <NA>                       <NA>
#> 6256                                       <NA>                       <NA>
#> 6257                                       <NA>                       <NA>
#> 6258                                       <NA>                       <NA>
#> 6259                                     C66742                       <NA>
#> 6260                                       <NA>                       <NA>
#> 6261                                       <NA>                       <NA>
#> 6262                                       <NA>                       <NA>
#> 6263                                       <NA>                       <NA>
#> 6264                                     C66738                       <NA>
#> 6265                                     C67152                       <NA>
#> 6266                                       <NA>                       <NA>
#> 6267                                       <NA>                       <NA>
#> 6268                                       <NA>                       <NA>
#> 6269                                     C66788                       <NA>
#> 6270                                       <NA>                       <NA>
#> 6271                                       <NA>                       <NA>
#> 6272                                       <NA>                       <NA>
#> 6273                                       <NA>                       <NA>
#> 6274                                       <NA>                       <NA>
#> 6275                                       <NA>                       <NA>
#> 6276                                       <NA>                       <NA>
#> 6277                                       <NA>                       <NA>
#> 6278                                       <NA>                       <NA>
#> 6279                                       <NA>                       <NA>
#> 6280                                       <NA>                       <NA>
#> 6281                                       <NA>                       <NA>
#> 6282                                       <NA>                       <NA>
#> 6283                                       <NA>                       <NA>
#> 6284                                    C179591                       <NA>
#> 6285                                    C179590                       <NA>
#> 6286                                       <NA>                       <NA>
#> 6287                                       <NA>                       <NA>
#> 6288                                     C66734                       <NA>
#> 6289                                       <NA>                       <NA>
#> 6290                                       <NA>                       <NA>
#> 6291                                       <NA>                       <NA>
#> 6292                                     C78737                       <NA>
#> 6293                                       <NA>                       <NA>
#> 6294                                       <NA>                       <NA>
#> 6295                                       <NA>                       <NA>
#> 6296                                       <NA>                       <NA>
#> 6297                            C78734; C111114                       <NA>
#> 6298                                       <NA>                       <NA>
#> 6299                                       <NA>                       <NA>
#> 6300                                       <NA>                       <NA>
#> 6301                                       <NA>                       <NA>
#> 6302                                       <NA>                       <NA>
#> 6303                                       <NA>                       <NA>
#> 6304                                    C100130                       <NA>
#> 6305                                       <NA>                       <NA>
#> 6306                                     C66734                       <NA>
#> 6307                                       <NA>                       <NA>
#> 6308                                       <NA>                       <NA>
#> 6309                                       <NA>                       <NA>
#> 6310                                       <NA>                       <NA>
#> 6311                                       <NA>                       <NA>
#> 6312                                       <NA>                       <NA>
#> 6313                                       <NA>                       <NA>
#> 6314                                     C78735                       <NA>
#>             described_value_domain value_list
#> 4398                          <NA>       <NA>
#> 4399                          <NA>         AG
#> 4400                          <NA>       <NA>
#> 4401                          <NA>       <NA>
#> 4402                          <NA>       <NA>
#> 4403                          <NA>       <NA>
#> 4404                          <NA>       <NA>
#> 4405                          <NA>       <NA>
#> 4406                          <NA>       <NA>
#> 4407                          <NA>       <NA>
#> 4408                          <NA>       <NA>
#> 4409                          <NA>       <NA>
#> 4410                          <NA>       <NA>
#> 4411                          <NA>       <NA>
#> 4412                          <NA>       <NA>
#> 4413                          <NA>       <NA>
#> 4414                          <NA>       <NA>
#> 4415                          <NA>       <NA>
#> 4416                          <NA>       <NA>
#> 4417                          <NA>       <NA>
#> 4418                          <NA>       <NA>
#> 4419                          <NA>       <NA>
#> 4420                          <NA>       <NA>
#> 4421                          <NA>       <NA>
#> 4422                          <NA>       <NA>
#> 4423                          <NA>       <NA>
#> 4424                          <NA>       <NA>
#> 4425                          <NA>       <NA>
#> 4426                          <NA>       <NA>
#> 4427                          <NA>       <NA>
#> 4428 ISO 8601 datetime or interval       <NA>
#> 4429 ISO 8601 datetime or interval       <NA>
#> 4430                          <NA>       <NA>
#> 4431                          <NA>       <NA>
#> 4432             ISO 8601 duration       <NA>
#> 4433                          <NA>       <NA>
#> 4434                          <NA>       <NA>
#> 4435                          <NA>       <NA>
#> 4436                          <NA>       <NA>
#> 4437                          <NA>       <NA>
#> 4438                          <NA>       <NA>
#> 4439                          <NA>       <NA>
#> 4440                          <NA>         CM
#> 4441                          <NA>       <NA>
#> 4442                          <NA>       <NA>
#> 4443                          <NA>       <NA>
#> 4444                          <NA>       <NA>
#> 4445                          <NA>       <NA>
#> 4446                          <NA>       <NA>
#> 4447                          <NA>       <NA>
#> 4448                          <NA>       <NA>
#> 4449                          <NA>       <NA>
#> 4450                          <NA>       <NA>
#> 4451                          <NA>       <NA>
#> 4452                          <NA>       <NA>
#> 4453                          <NA>       <NA>
#> 4454                          <NA>       <NA>
#> 4455                          <NA>       <NA>
#> 4456                          <NA>       <NA>
#> 4457                          <NA>       <NA>
#> 4458                          <NA>       <NA>
#> 4459                          <NA>       <NA>
#> 4460                          <NA>       <NA>
#> 4461                          <NA>       <NA>
#> 4462                          <NA>       <NA>
#> 4463                          <NA>       <NA>
#> 4464                          <NA>       <NA>
#> 4465                          <NA>       <NA>
#> 4466                          <NA>       <NA>
#> 4467                          <NA>       <NA>
#> 4468                          <NA>       <NA>
#> 4469 ISO 8601 datetime or interval       <NA>
#> 4470 ISO 8601 datetime or interval       <NA>
#> 4471                          <NA>       <NA>
#> 4472                          <NA>       <NA>
#> 4473             ISO 8601 duration       <NA>
#> 4474                          <NA>       <NA>
#> 4475                          <NA>       <NA>
#> 4476                          <NA>       <NA>
#> 4477                          <NA>       <NA>
#> 4478                          <NA>       <NA>
#> 4479                          <NA>       <NA>
#> 4480                          <NA>       <NA>
#> 4481                          <NA>         EC
#> 4482                          <NA>       <NA>
#> 4483                          <NA>       <NA>
#> 4484                          <NA>       <NA>
#> 4485                          <NA>       <NA>
#> 4486                          <NA>       <NA>
#> 4487                          <NA>       <NA>
#> 4488                          <NA>       <NA>
#> 4489                          <NA>       <NA>
#> 4490                          <NA>       <NA>
#> 4491                          <NA>       <NA>
#> 4492                          <NA>       <NA>
#> 4493                          <NA>       <NA>
#> 4494                          <NA>       <NA>
#> 4495                          <NA>       <NA>
#> 4496                          <NA>       <NA>
#> 4497                          <NA>       <NA>
#> 4498                          <NA>       <NA>
#> 4499                          <NA>       <NA>
#> 4500                          <NA>       <NA>
#> 4501                          <NA>       <NA>
#> 4502                          <NA>       <NA>
#> 4503                          <NA>       <NA>
#> 4504                          <NA>       <NA>
#> 4505                          <NA>       <NA>
#> 4506                          <NA>       <NA>
#> 4507                          <NA>       <NA>
#> 4508                          <NA>       <NA>
#> 4509                          <NA>       <NA>
#> 4510                          <NA>       <NA>
#> 4511                          <NA>       <NA>
#> 4512                          <NA>       <NA>
#> 4513                          <NA>       <NA>
#> 4514                          <NA>       <NA>
#> 4515 ISO 8601 datetime or interval       <NA>
#> 4516 ISO 8601 datetime or interval       <NA>
#> 4517                          <NA>       <NA>
#> 4518                          <NA>       <NA>
#> 4519             ISO 8601 duration       <NA>
#> 4520                          <NA>       <NA>
#> 4521                          <NA>       <NA>
#> 4522             ISO 8601 duration       <NA>
#> 4523                          <NA>       <NA>
#> 4524 ISO 8601 datetime or interval       <NA>
#> 4525                          <NA>       <NA>
#> 4526                          <NA>         EX
#> 4527                          <NA>       <NA>
#> 4528                          <NA>       <NA>
#> 4529                          <NA>       <NA>
#> 4530                          <NA>       <NA>
#> 4531                          <NA>       <NA>
#> 4532                          <NA>       <NA>
#> 4533                          <NA>       <NA>
#> 4534                          <NA>       <NA>
#> 4535                          <NA>       <NA>
#> 4536                          <NA>       <NA>
#> 4537                          <NA>       <NA>
#> 4538                          <NA>       <NA>
#> 4539                          <NA>       <NA>
#> 4540                          <NA>       <NA>
#> 4541                          <NA>       <NA>
#> 4542                          <NA>       <NA>
#> 4543                          <NA>       <NA>
#> 4544                          <NA>       <NA>
#> 4545                          <NA>       <NA>
#> 4546                          <NA>       <NA>
#> 4547                          <NA>       <NA>
#> 4548                          <NA>       <NA>
#> 4549                          <NA>       <NA>
#> 4550                          <NA>       <NA>
#> 4551                          <NA>       <NA>
#> 4552 ISO 8601 datetime or interval       <NA>
#> 4553 ISO 8601 datetime or interval       <NA>
#> 4554                          <NA>       <NA>
#> 4555                          <NA>       <NA>
#> 4556             ISO 8601 duration       <NA>
#> 4557                          <NA>       <NA>
#> 4558                          <NA>       <NA>
#> 4559             ISO 8601 duration       <NA>
#> 4560                          <NA>       <NA>
#> 4561 ISO 8601 datetime or interval       <NA>
#> 4562                          <NA>       <NA>
#> 4563                          <NA>         ML
#> 4564                          <NA>       <NA>
#> 4565                          <NA>       <NA>
#> 4566                          <NA>       <NA>
#> 4567                          <NA>       <NA>
#> 4568                          <NA>       <NA>
#> 4569                          <NA>       <NA>
#> 4570                          <NA>       <NA>
#> 4571                          <NA>       <NA>
#> 4572                          <NA>       <NA>
#> 4573                          <NA>       <NA>
#> 4574                          <NA>       <NA>
#> 4575                          <NA>       <NA>
#> 4576                          <NA>       <NA>
#> 4577                          <NA>       <NA>
#> 4578                          <NA>       <NA>
#> 4579                          <NA>       <NA>
#> 4580                          <NA>       <NA>
#> 4581                          <NA>       <NA>
#> 4582                          <NA>       <NA>
#> 4583                          <NA>       <NA>
#> 4584 ISO 8601 datetime or interval       <NA>
#> 4585 ISO 8601 datetime or interval       <NA>
#> 4586 ISO 8601 datetime or interval       <NA>
#> 4587                          <NA>       <NA>
#> 4588                          <NA>       <NA>
#> 4589                          <NA>       <NA>
#> 4590             ISO 8601 duration       <NA>
#> 4591                          <NA>       <NA>
#> 4592                          <NA>       <NA>
#> 4593             ISO 8601 duration       <NA>
#> 4594                          <NA>       <NA>
#> 4595 ISO 8601 datetime or interval       <NA>
#> 4596                          <NA>       <NA>
#> 4597                          <NA>       <NA>
#> 4598 ISO 8601 datetime or interval       <NA>
#> 4599                          <NA>       <NA>
#> 4600                          <NA>         PR
#> 4601                          <NA>       <NA>
#> 4602                          <NA>       <NA>
#> 4603                          <NA>       <NA>
#> 4604                          <NA>       <NA>
#> 4605                          <NA>       <NA>
#> 4606                          <NA>       <NA>
#> 4607                          <NA>       <NA>
#> 4608                          <NA>       <NA>
#> 4609                          <NA>       <NA>
#> 4610                          <NA>       <NA>
#> 4611                          <NA>       <NA>
#> 4612                          <NA>       <NA>
#> 4613                          <NA>       <NA>
#> 4614                          <NA>       <NA>
#> 4615                          <NA>       <NA>
#> 4616                          <NA>       <NA>
#> 4617                          <NA>       <NA>
#> 4618                          <NA>       <NA>
#> 4619                          <NA>       <NA>
#> 4620                          <NA>       <NA>
#> 4621                          <NA>       <NA>
#> 4622                          <NA>       <NA>
#> 4623                          <NA>       <NA>
#> 4624                          <NA>       <NA>
#> 4625                          <NA>       <NA>
#> 4626                          <NA>       <NA>
#> 4627                          <NA>       <NA>
#> 4628                          <NA>       <NA>
#> 4629                          <NA>       <NA>
#> 4630 ISO 8601 datetime or interval       <NA>
#> 4631 ISO 8601 datetime or interval       <NA>
#> 4632                          <NA>       <NA>
#> 4633                          <NA>       <NA>
#> 4634             ISO 8601 duration       <NA>
#> 4635                          <NA>       <NA>
#> 4636                          <NA>       <NA>
#> 4637             ISO 8601 duration       <NA>
#> 4638                          <NA>       <NA>
#> 4639 ISO 8601 datetime or interval       <NA>
#> 4640                          <NA>       <NA>
#> 4641                          <NA>       <NA>
#> 4642                          <NA>       <NA>
#> 4643                          <NA>       <NA>
#> 4644                          <NA>       <NA>
#> 4645                          <NA>         SU
#> 4646                          <NA>       <NA>
#> 4647                          <NA>       <NA>
#> 4648                          <NA>       <NA>
#> 4649                          <NA>       <NA>
#> 4650                          <NA>       <NA>
#> 4651                          <NA>       <NA>
#> 4652                          <NA>       <NA>
#> 4653                          <NA>       <NA>
#> 4654                          <NA>       <NA>
#> 4655                          <NA>       <NA>
#> 4656                          <NA>       <NA>
#> 4657                          <NA>       <NA>
#> 4658                          <NA>       <NA>
#> 4659                          <NA>       <NA>
#> 4660                          <NA>       <NA>
#> 4661                          <NA>       <NA>
#> 4662                          <NA>       <NA>
#> 4663                          <NA>       <NA>
#> 4664                          <NA>       <NA>
#> 4665                          <NA>       <NA>
#> 4666                          <NA>       <NA>
#> 4667                          <NA>       <NA>
#> 4668                          <NA>       <NA>
#> 4669                          <NA>       <NA>
#> 4670 ISO 8601 datetime or interval       <NA>
#> 4671 ISO 8601 datetime or interval       <NA>
#> 4672                          <NA>       <NA>
#> 4673                          <NA>       <NA>
#> 4674             ISO 8601 duration       <NA>
#> 4675                          <NA>       <NA>
#> 4676                          <NA>       <NA>
#> 4677                          <NA>       <NA>
#> 4678                          <NA>       <NA>
#> 4679                          <NA>       <NA>
#> 4680                          <NA>       <NA>
#> 4681                          <NA>       <NA>
#> 4682                          <NA>         AE
#> 4683                          <NA>       <NA>
#> 4684                          <NA>       <NA>
#> 4685                          <NA>       <NA>
#> 4686                          <NA>       <NA>
#> 4687                          <NA>       <NA>
#> 4688                          <NA>       <NA>
#> 4689                          <NA>       <NA>
#> 4690                          <NA>       <NA>
#> 4691                        MedDRA       <NA>
#> 4692                        MedDRA       <NA>
#> 4693                        MedDRA       <NA>
#> 4694                        MedDRA       <NA>
#> 4695                        MedDRA       <NA>
#> 4696                        MedDRA       <NA>
#> 4697                        MedDRA       <NA>
#> 4698                        MedDRA       <NA>
#> 4699                          <NA>       <NA>
#> 4700                          <NA>       <NA>
#> 4701                          <NA>       <NA>
#> 4702                          <NA>       <NA>
#> 4703                        MedDRA       <NA>
#> 4704                        MedDRA       <NA>
#> 4705                        MedDRA       <NA>
#> 4706                          <NA>       <NA>
#> 4707                          <NA>       <NA>
#> 4708                          <NA>       <NA>
#> 4709                          <NA>       <NA>
#> 4710                          <NA>       <NA>
#> 4711                          <NA>       <NA>
#> 4712                          <NA>       <NA>
#> 4713                          <NA>       <NA>
#> 4714                          <NA>       <NA>
#> 4715                          <NA>       <NA>
#> 4716                          <NA>       <NA>
#> 4717                          <NA>       <NA>
#> 4718                          <NA>       <NA>
#> 4719                          <NA>       <NA>
#> 4720                          <NA>       <NA>
#> 4721                          <NA>       <NA>
#> 4722                          <NA>       <NA>
#> 4723                          <NA>       <NA>
#> 4724                          <NA>       <NA>
#> 4725                          <NA>       <NA>
#> 4726                          <NA>       <NA>
#> 4727                          <NA>       <NA>
#> 4728                          <NA>       <NA>
#> 4729                          <NA>       <NA>
#> 4730                          <NA>       <NA>
#> 4731                          <NA>       <NA>
#> 4732                          <NA>       <NA>
#> 4733 ISO 8601 datetime or interval       <NA>
#> 4734 ISO 8601 datetime or interval       <NA>
#> 4735                          <NA>       <NA>
#> 4736                          <NA>       <NA>
#> 4737             ISO 8601 duration       <NA>
#> 4738                          <NA>       <NA>
#> 4739                          <NA>       <NA>
#> 4740                          <NA>       <NA>
#> 4741                          <NA>       <NA>
#> 4742                          <NA>         BE
#> 4743                          <NA>       <NA>
#> 4744                          <NA>       <NA>
#> 4745                          <NA>       <NA>
#> 4746                          <NA>       <NA>
#> 4747                          <NA>       <NA>
#> 4748                          <NA>       <NA>
#> 4749                          <NA>       <NA>
#> 4750                          <NA>       <NA>
#> 4751                          <NA>       <NA>
#> 4752                          <NA>       <NA>
#> 4753                          <NA>       <NA>
#> 4754                          <NA>       <NA>
#> 4755                          <NA>       <NA>
#> 4756                          <NA>       <NA>
#> 4757                          <NA>       <NA>
#> 4758                          <NA>       <NA>
#> 4759                          <NA>       <NA>
#> 4760 ISO 8601 datetime or interval       <NA>
#> 4761 ISO 8601 datetime or interval       <NA>
#> 4762 ISO 8601 datetime or interval       <NA>
#> 4763                          <NA>       <NA>
#> 4764                          <NA>       <NA>
#> 4765             ISO 8601 duration       <NA>
#> 4766                          <NA>       <NA>
#> 4767                          <NA>         CE
#> 4768                          <NA>       <NA>
#> 4769                          <NA>       <NA>
#> 4770                          <NA>       <NA>
#> 4771                          <NA>       <NA>
#> 4772                          <NA>       <NA>
#> 4773                          <NA>       <NA>
#> 4774                          <NA>       <NA>
#> 4775                          <NA>       <NA>
#> 4776                          <NA>       <NA>
#> 4777                          <NA>       <NA>
#> 4778                          <NA>       <NA>
#> 4779                          <NA>       <NA>
#> 4780                          <NA>       <NA>
#> 4781                          <NA>       <NA>
#> 4782                          <NA>       <NA>
#> 4783                          <NA>       <NA>
#> 4784                          <NA>       <NA>
#> 4785                          <NA>       <NA>
#> 4786 ISO 8601 datetime or interval       <NA>
#> 4787 ISO 8601 datetime or interval       <NA>
#> 4788 ISO 8601 datetime or interval       <NA>
#> 4789                          <NA>       <NA>
#> 4790                          <NA>       <NA>
#> 4791                          <NA>       <NA>
#> 4792                          <NA>       <NA>
#> 4793                          <NA>       <NA>
#> 4794                          <NA>       <NA>
#> 4795                          <NA>       <NA>
#> 4796                          <NA>       <NA>
#> 4797                          <NA>       <NA>
#> 4798                          <NA>       <NA>
#> 4799                          <NA>         DS
#> 4800                          <NA>       <NA>
#> 4801                          <NA>       <NA>
#> 4802                          <NA>       <NA>
#> 4803                          <NA>       <NA>
#> 4804                          <NA>       <NA>
#> 4805                          <NA>       <NA>
#> 4806                          <NA>       <NA>
#> 4807                          <NA>       <NA>
#> 4808                          <NA>       <NA>
#> 4809                          <NA>       <NA>
#> 4810 ISO 8601 datetime or interval       <NA>
#> 4811 ISO 8601 datetime or interval       <NA>
#> 4812                          <NA>       <NA>
#> 4813                          <NA>       <NA>
#> 4814                          <NA>       <NA>
#> 4815                          <NA>         DV
#> 4816                          <NA>       <NA>
#> 4817                          <NA>       <NA>
#> 4818                          <NA>       <NA>
#> 4819                          <NA>       <NA>
#> 4820                          <NA>       <NA>
#> 4821                          <NA>       <NA>
#> 4822                          <NA>       <NA>
#> 4823                          <NA>       <NA>
#> 4824                          <NA>       <NA>
#> 4825                          <NA>       <NA>
#> 4826 ISO 8601 datetime or interval       <NA>
#> 4827 ISO 8601 datetime or interval       <NA>
#> 4828                          <NA>       <NA>
#> 4829                          <NA>       <NA>
#> 4830                          <NA>       <NA>
#> 4831                          <NA>         HO
#> 4832                          <NA>       <NA>
#> 4833                          <NA>       <NA>
#> 4834                          <NA>       <NA>
#> 4835                          <NA>       <NA>
#> 4836                          <NA>       <NA>
#> 4837                          <NA>       <NA>
#> 4838                          <NA>       <NA>
#> 4839                          <NA>       <NA>
#> 4840                          <NA>       <NA>
#> 4841                          <NA>       <NA>
#> 4842                          <NA>       <NA>
#> 4843                          <NA>       <NA>
#> 4844                          <NA>       <NA>
#> 4845                          <NA>       <NA>
#> 4846                          <NA>       <NA>
#> 4847 ISO 8601 datetime or interval       <NA>
#> 4848 ISO 8601 datetime or interval       <NA>
#> 4849 ISO 8601 datetime or interval       <NA>
#> 4850                          <NA>       <NA>
#> 4851                          <NA>       <NA>
#> 4852                          <NA>       <NA>
#> 4853             ISO 8601 duration       <NA>
#> 4854                          <NA>       <NA>
#> 4855                          <NA>       <NA>
#> 4856                          <NA>       <NA>
#> 4857                          <NA>       <NA>
#> 4858                          <NA>       <NA>
#> 4859                          <NA>         MH
#> 4860                          <NA>       <NA>
#> 4861                          <NA>       <NA>
#> 4862                          <NA>       <NA>
#> 4863                          <NA>       <NA>
#> 4864                          <NA>       <NA>
#> 4865                          <NA>       <NA>
#> 4866                          <NA>       <NA>
#> 4867                          <NA>       <NA>
#> 4868                          <NA>       <NA>
#> 4869                          <NA>       <NA>
#> 4870                          <NA>       <NA>
#> 4871                          <NA>       <NA>
#> 4872                          <NA>       <NA>
#> 4873                          <NA>       <NA>
#> 4874                          <NA>       <NA>
#> 4875                          <NA>       <NA>
#> 4876                          <NA>       <NA>
#> 4877                          <NA>       <NA>
#> 4878 ISO 8601 datetime or interval       <NA>
#> 4879 ISO 8601 datetime or interval       <NA>
#> 4880 ISO 8601 datetime or interval       <NA>
#> 4881                          <NA>       <NA>
#> 4882                          <NA>       <NA>
#> 4883                          <NA>       <NA>
#> 4884                          <NA>       <NA>
#> 4885                          <NA>       <NA>
#> 4886                          <NA>         BS
#> 4887                          <NA>       <NA>
#> 4888                          <NA>       <NA>
#> 4889                          <NA>       <NA>
#> 4890                          <NA>       <NA>
#> 4891                          <NA>       <NA>
#> 4892                          <NA>       <NA>
#> 4893                          <NA>       <NA>
#> 4894                          <NA>       <NA>
#> 4895                          <NA>       <NA>
#> 4896                          <NA>       <NA>
#> 4897                          <NA>       <NA>
#> 4898                          <NA>       <NA>
#> 4899                          <NA>       <NA>
#> 4900                          <NA>       <NA>
#> 4901                          <NA>       <NA>
#> 4902                          <NA>       <NA>
#> 4903                          <NA>       <NA>
#> 4904                          <NA>       <NA>
#> 4905                          <NA>       <NA>
#> 4906                          <NA>       <NA>
#> 4907                          <NA>       <NA>
#> 4908                          <NA>       <NA>
#> 4909                          <NA>       <NA>
#> 4910                          <NA>       <NA>
#> 4911                          <NA>       <NA>
#> 4912                          <NA>       <NA>
#> 4913 ISO 8601 datetime or interval       <NA>
#> 4914                          <NA>       <NA>
#> 4915                          <NA>       <NA>
#> 4916                          <NA>       <NA>
#> 4917             ISO 8601 duration       <NA>
#> 4918                          <NA>       <NA>
#> 4919 ISO 8601 datetime or interval       <NA>
#> 4920                          <NA>       <NA>
#> 4921                          <NA>         CP
#> 4922                          <NA>       <NA>
#> 4923                          <NA>       <NA>
#> 4924                          <NA>       <NA>
#> 4925                          <NA>       <NA>
#> 4926                          <NA>       <NA>
#> 4927                          <NA>       <NA>
#> 4928                          <NA>       <NA>
#> 4929                          <NA>       <NA>
#> 4930                          <NA>       <NA>
#> 4931                          <NA>       <NA>
#> 4932                          <NA>       <NA>
#> 4933                          <NA>       <NA>
#> 4934                          <NA>       <NA>
#> 4935                          <NA>       <NA>
#> 4936                          <NA>       <NA>
#> 4937                          <NA>       <NA>
#> 4938                          <NA>       <NA>
#> 4939                          <NA>       <NA>
#> 4940                          <NA>       <NA>
#> 4941                          <NA>       <NA>
#> 4942                          <NA>       <NA>
#> 4943                          <NA>       <NA>
#> 4944                          <NA>       <NA>
#> 4945                          <NA>       <NA>
#> 4946                          <NA>       <NA>
#> 4947                          <NA>       <NA>
#> 4948                          <NA>       <NA>
#> 4949                          <NA>       <NA>
#> 4950                          <NA>       <NA>
#> 4951                          <NA>       <NA>
#> 4952                          <NA>       <NA>
#> 4953                          <NA>       <NA>
#> 4954                          <NA>       <NA>
#> 4955                          <NA>       <NA>
#> 4956                          <NA>       <NA>
#> 4957                          <NA>       <NA>
#> 4958                          <NA>       <NA>
#> 4959                          <NA>       <NA>
#> 4960                          <NA>       <NA>
#> 4961                         LOINC       <NA>
#> 4962                          <NA>       <NA>
#> 4963                          <NA>       <NA>
#> 4964                          <NA>       <NA>
#> 4965                          <NA>       <NA>
#> 4966                          <NA>       <NA>
#> 4967                          <NA>       <NA>
#> 4968                          <NA>       <NA>
#> 4969                          <NA>       <NA>
#> 4970                          <NA>       <NA>
#> 4971                          <NA>       <NA>
#> 4972                          <NA>       <NA>
#> 4973                          <NA>       <NA>
#> 4974                          <NA>       <NA>
#> 4975 ISO 8601 datetime or interval       <NA>
#> 4976                          <NA>       <NA>
#> 4977                          <NA>       <NA>
#> 4978                          <NA>       <NA>
#> 4979             ISO 8601 duration       <NA>
#> 4980                          <NA>       <NA>
#> 4981 ISO 8601 datetime or interval       <NA>
#> 4982                          <NA>       <NA>
#> 4983                          <NA>         CV
#> 4984                          <NA>       <NA>
#> 4985                          <NA>       <NA>
#> 4986                          <NA>       <NA>
#> 4987                          <NA>       <NA>
#> 4988                          <NA>       <NA>
#> 4989                          <NA>       <NA>
#> 4990                          <NA>       <NA>
#> 4991                          <NA>       <NA>
#> 4992                          <NA>       <NA>
#> 4993                          <NA>       <NA>
#> 4994                          <NA>       <NA>
#> 4995                          <NA>       <NA>
#> 4996                          <NA>       <NA>
#> 4997                          <NA>       <NA>
#> 4998                          <NA>       <NA>
#> 4999                          <NA>       <NA>
#> 5000                          <NA>       <NA>
#> 5001                          <NA>       <NA>
#> 5002                          <NA>       <NA>
#> 5003                          <NA>       <NA>
#> 5004                          <NA>       <NA>
#> 5005                          <NA>       <NA>
#> 5006                          <NA>       <NA>
#> 5007                          <NA>       <NA>
#> 5008                          <NA>       <NA>
#> 5009                          <NA>       <NA>
#> 5010                          <NA>       <NA>
#> 5011                          <NA>       <NA>
#> 5012                          <NA>       <NA>
#> 5013                          <NA>       <NA>
#> 5014                          <NA>       <NA>
#> 5015                          <NA>       <NA>
#> 5016                          <NA>       <NA>
#> 5017 ISO 8601 datetime or interval       <NA>
#> 5018                          <NA>       <NA>
#> 5019                          <NA>       <NA>
#> 5020                          <NA>       <NA>
#> 5021             ISO 8601 duration       <NA>
#> 5022                          <NA>       <NA>
#> 5023 ISO 8601 datetime or interval       <NA>
#> 5024                          <NA>       <NA>
#> 5025                          <NA>         DA
#> 5026                          <NA>       <NA>
#> 5027                          <NA>       <NA>
#> 5028                          <NA>       <NA>
#> 5029                          <NA>       <NA>
#> 5030                          <NA>       <NA>
#> 5031                          <NA>       <NA>
#> 5032                          <NA>       <NA>
#> 5033                          <NA>       <NA>
#> 5034                          <NA>       <NA>
#> 5035                          <NA>       <NA>
#> 5036                          <NA>       <NA>
#> 5037                          <NA>       <NA>
#> 5038                          <NA>       <NA>
#> 5039                          <NA>       <NA>
#> 5040                          <NA>       <NA>
#> 5041                          <NA>       <NA>
#> 5042                          <NA>       <NA>
#> 5043                          <NA>       <NA>
#> 5044                          <NA>       <NA>
#> 5045                          <NA>       <NA>
#> 5046                          <NA>       <NA>
#> 5047                          <NA>       <NA>
#> 5048                          <NA>       <NA>
#> 5049 ISO 8601 datetime or interval       <NA>
#> 5050                          <NA>       <NA>
#> 5051                          <NA>       <NA>
#> 5052                          <NA>         DD
#> 5053                          <NA>       <NA>
#> 5054                          <NA>       <NA>
#> 5055                          <NA>       <NA>
#> 5056                          <NA>       <NA>
#> 5057                          <NA>       <NA>
#> 5058                          <NA>       <NA>
#> 5059                          <NA>       <NA>
#> 5060                          <NA>       <NA>
#> 5061 ISO 8601 datetime or interval       <NA>
#> 5062                          <NA>       <NA>
#> 5063                          <NA>       <NA>
#> 5064                          <NA>         EG
#> 5065                          <NA>       <NA>
#> 5066                          <NA>       <NA>
#> 5067                          <NA>       <NA>
#> 5068                          <NA>       <NA>
#> 5069                          <NA>       <NA>
#> 5070                          <NA>       <NA>
#> 5071                          <NA>       <NA>
#> 5072                          <NA>       <NA>
#> 5073                          <NA>       <NA>
#> 5074                          <NA>       <NA>
#> 5075                          <NA>       <NA>
#> 5076                          <NA>       <NA>
#> 5077                          <NA>       <NA>
#> 5078                          <NA>       <NA>
#> 5079                          <NA>       <NA>
#> 5080                          <NA>       <NA>
#> 5081                          <NA>       <NA>
#> 5082                          <NA>       <NA>
#> 5083                          <NA>       <NA>
#> 5084                          <NA>       <NA>
#> 5085                          <NA>       <NA>
#> 5086                          <NA>       <NA>
#> 5087                          <NA>       <NA>
#> 5088                          <NA>       <NA>
#> 5089                          <NA>       <NA>
#> 5090                          <NA>       <NA>
#> 5091                          <NA>       <NA>
#> 5092                          <NA>       <NA>
#> 5093                          <NA>       <NA>
#> 5094                          <NA>       <NA>
#> 5095                          <NA>       <NA>
#> 5096                          <NA>       <NA>
#> 5097                          <NA>       <NA>
#> 5098                          <NA>       <NA>
#> 5099                          <NA>       <NA>
#> 5100 ISO 8601 datetime or interval       <NA>
#> 5101                          <NA>       <NA>
#> 5102                          <NA>       <NA>
#> 5103                          <NA>       <NA>
#> 5104             ISO 8601 duration       <NA>
#> 5105                          <NA>       <NA>
#> 5106 ISO 8601 datetime or interval       <NA>
#> 5107                          <NA>       <NA>
#> 5108                          <NA>         FT
#> 5109                          <NA>       <NA>
#> 5110                          <NA>       <NA>
#> 5111                          <NA>       <NA>
#> 5112                          <NA>       <NA>
#> 5113                          <NA>       <NA>
#> 5114                          <NA>       <NA>
#> 5115                          <NA>       <NA>
#> 5116                          <NA>       <NA>
#> 5117                          <NA>       <NA>
#> 5118                          <NA>       <NA>
#> 5119                          <NA>       <NA>
#> 5120                          <NA>       <NA>
#> 5121                          <NA>       <NA>
#> 5122                          <NA>       <NA>
#> 5123                          <NA>       <NA>
#> 5124                          <NA>       <NA>
#> 5125                          <NA>       <NA>
#> 5126                          <NA>       <NA>
#> 5127                          <NA>       <NA>
#> 5128                          <NA>       <NA>
#> 5129                          <NA>       <NA>
#> 5130                          <NA>       <NA>
#> 5131                          <NA>       <NA>
#> 5132                          <NA>       <NA>
#> 5133                          <NA>       <NA>
#> 5134                          <NA>       <NA>
#> 5135                          <NA>       <NA>
#> 5136                          <NA>       <NA>
#> 5137                          <NA>       <NA>
#> 5138 ISO 8601 datetime or interval       <NA>
#> 5139                          <NA>       <NA>
#> 5140                          <NA>       <NA>
#> 5141                          <NA>       <NA>
#> 5142             ISO 8601 duration       <NA>
#> 5143                          <NA>       <NA>
#> 5144 ISO 8601 datetime or interval       <NA>
#> 5145                          <NA>       <NA>
#> 5146                          <NA>         GF
#> 5147                          <NA>       <NA>
#> 5148                          <NA>       <NA>
#> 5149                          <NA>       <NA>
#> 5150                          <NA>       <NA>
#> 5151                          <NA>       <NA>
#> 5152                          <NA>       <NA>
#> 5153                          <NA>       <NA>
#> 5154                          <NA>       <NA>
#> 5155                          <NA>       <NA>
#> 5156                          <NA>       <NA>
#> 5157                          <NA>       <NA>
#> 5158                          <NA>       <NA>
#> 5159                          <NA>       <NA>
#> 5160                          <NA>       <NA>
#> 5161                          <NA>       <NA>
#> 5162                          <NA>       <NA>
#> 5163                          <NA>       <NA>
#> 5164                          <NA>       <NA>
#> 5165                          <NA>       <NA>
#> 5166                          <NA>       <NA>
#> 5167                          <NA>       <NA>
#> 5168                          <NA>       <NA>
#> 5169                          <NA>       <NA>
#> 5170                          <NA>       <NA>
#> 5171                          <NA>       <NA>
#> 5172                          <NA>       <NA>
#> 5173                          <NA>       <NA>
#> 5174                          <NA>       <NA>
#> 5175                          <NA>       <NA>
#> 5176                          <NA>       <NA>
#> 5177                          <NA>       <NA>
#> 5178                          <NA>       <NA>
#> 5179                          <NA>       <NA>
#> 5180                          <NA>       <NA>
#> 5181                          <NA>       <NA>
#> 5182                          <NA>       <NA>
#> 5183                          <NA>       <NA>
#> 5184                          <NA>       <NA>
#> 5185                          <NA>       <NA>
#> 5186                          <NA>       <NA>
#> 5187                          <NA>       <NA>
#> 5188                          <NA>       <NA>
#> 5189                          <NA>       <NA>
#> 5190                          <NA>       <NA>
#> 5191                          <NA>       <NA>
#> 5192                          <NA>       <NA>
#> 5193                          <NA>       <NA>
#> 5194                          <NA>       <NA>
#> 5195 ISO 8601 datetime or interval       <NA>
#> 5196                          <NA>       <NA>
#> 5197                          <NA>       <NA>
#> 5198                          <NA>       <NA>
#> 5199             ISO 8601 duration       <NA>
#> 5200                          <NA>       <NA>
#> 5201 ISO 8601 datetime or interval       <NA>
#> 5202                          <NA>       <NA>
#> 5203                          <NA>         IE
#> 5204                          <NA>       <NA>
#> 5205                          <NA>       <NA>
#> 5206                          <NA>       <NA>
#> 5207                          <NA>       <NA>
#> 5208                          <NA>       <NA>
#> 5209                          <NA>       <NA>
#> 5210                          <NA>       <NA>
#> 5211                          <NA>       <NA>
#> 5212                          <NA>       <NA>
#> 5213                          <NA>       <NA>
#> 5214                          <NA>       <NA>
#> 5215                          <NA>       <NA>
#> 5216                          <NA>       <NA>
#> 5217                          <NA>       <NA>
#> 5218 ISO 8601 datetime or interval       <NA>
#> 5219                          <NA>       <NA>
#> 5220                          <NA>       <NA>
#> 5221                          <NA>         IS
#> 5222                          <NA>       <NA>
#> 5223                          <NA>       <NA>
#> 5224                          <NA>       <NA>
#> 5225                          <NA>       <NA>
#> 5226                          <NA>       <NA>
#> 5227                          <NA>       <NA>
#> 5228                          <NA>       <NA>
#> 5229                          <NA>       <NA>
#> 5230                          <NA>       <NA>
#> 5231                          <NA>       <NA>
#> 5232                          <NA>       <NA>
#> 5233                          <NA>       <NA>
#> 5234                          <NA>       <NA>
#> 5235                          <NA>       <NA>
#> 5236                          <NA>       <NA>
#> 5237                          <NA>       <NA>
#> 5238                          <NA>       <NA>
#> 5239                          <NA>       <NA>
#> 5240                          <NA>       <NA>
#> 5241                          <NA>       <NA>
#> 5242                          <NA>       <NA>
#> 5243                          <NA>       <NA>
#> 5244                          <NA>       <NA>
#> 5245                          <NA>       <NA>
#> 5246                          <NA>       <NA>
#> 5247                          <NA>       <NA>
#> 5248                          <NA>       <NA>
#> 5249                          <NA>       <NA>
#> 5250                          <NA>       <NA>
#> 5251                          <NA>       <NA>
#> 5252                          <NA>       <NA>
#> 5253                          <NA>       <NA>
#> 5254                          <NA>       <NA>
#> 5255                          <NA>       <NA>
#> 5256                          <NA>       <NA>
#> 5257                          <NA>       <NA>
#> 5258                          <NA>       <NA>
#> 5259                          <NA>       <NA>
#> 5260                          <NA>       <NA>
#> 5261                          <NA>       <NA>
#> 5262                          <NA>       <NA>
#> 5263                          <NA>       <NA>
#> 5264                          <NA>       <NA>
#> 5265 ISO 8601 datetime or interval       <NA>
#> 5266 ISO 8601 datetime or interval       <NA>
#> 5267                          <NA>       <NA>
#> 5268                          <NA>       <NA>
#> 5269                          <NA>       <NA>
#> 5270                          <NA>       <NA>
#> 5271             ISO 8601 duration       <NA>
#> 5272                          <NA>       <NA>
#> 5273 ISO 8601 datetime or interval       <NA>
#> 5274                          <NA>       <NA>
#> 5275                          <NA>         LB
#> 5276                          <NA>       <NA>
#> 5277                          <NA>       <NA>
#> 5278                          <NA>       <NA>
#> 5279                          <NA>       <NA>
#> 5280                          <NA>       <NA>
#> 5281                          <NA>       <NA>
#> 5282                          <NA>       <NA>
#> 5283                          <NA>       <NA>
#> 5284                          <NA>       <NA>
#> 5285                          <NA>       <NA>
#> 5286                          <NA>       <NA>
#> 5287                          <NA>       <NA>
#> 5288                          <NA>       <NA>
#> 5289                          <NA>       <NA>
#> 5290                          <NA>       <NA>
#> 5291                          <NA>       <NA>
#> 5292                          <NA>       <NA>
#> 5293                          <NA>       <NA>
#> 5294                          <NA>       <NA>
#> 5295                          <NA>       <NA>
#> 5296                          <NA>       <NA>
#> 5297                          <NA>       <NA>
#> 5298                          <NA>       <NA>
#> 5299                          <NA>       <NA>
#> 5300                          <NA>       <NA>
#> 5301                          <NA>       <NA>
#> 5302                          <NA>       <NA>
#> 5303                          <NA>       <NA>
#> 5304                          <NA>       <NA>
#> 5305                          <NA>       <NA>
#> 5306                         LOINC       <NA>
#> 5307                          <NA>       <NA>
#> 5308                          <NA>       <NA>
#> 5309                          <NA>       <NA>
#> 5310                          <NA>       <NA>
#> 5311                          <NA>       <NA>
#> 5312                          <NA>       <NA>
#> 5313                          <NA>       <NA>
#> 5314                          <NA>       <NA>
#> 5315                          <NA>       <NA>
#> 5316                          <NA>       <NA>
#> 5317                          <NA>       <NA>
#> 5318                          <NA>       <NA>
#> 5319                          <NA>       <NA>
#> 5320                          <NA>       <NA>
#> 5321                          <NA>       <NA>
#> 5322                          <NA>       <NA>
#> 5323                          <NA>       <NA>
#> 5324                          <NA>       <NA>
#> 5325 ISO 8601 datetime or interval       <NA>
#> 5326 ISO 8601 datetime or interval       <NA>
#> 5327                          <NA>       <NA>
#> 5328                          <NA>       <NA>
#> 5329                          <NA>       <NA>
#> 5330                          <NA>       <NA>
#> 5331             ISO 8601 duration       <NA>
#> 5332                          <NA>       <NA>
#> 5333 ISO 8601 datetime or interval       <NA>
#> 5334                          <NA>       <NA>
#> 5335             ISO 8601 duration       <NA>
#> 5336                          <NA>       <NA>
#> 5337                          <NA>         MB
#> 5338                          <NA>       <NA>
#> 5339                          <NA>       <NA>
#> 5340                          <NA>       <NA>
#> 5341                          <NA>       <NA>
#> 5342                          <NA>       <NA>
#> 5343                          <NA>       <NA>
#> 5344                          <NA>       <NA>
#> 5345                          <NA>       <NA>
#> 5346                          <NA>       <NA>
#> 5347                          <NA>       <NA>
#> 5348                          <NA>       <NA>
#> 5349                          <NA>       <NA>
#> 5350                          <NA>       <NA>
#> 5351                          <NA>       <NA>
#> 5352                          <NA>       <NA>
#> 5353                          <NA>       <NA>
#> 5354                          <NA>       <NA>
#> 5355                          <NA>       <NA>
#> 5356                          <NA>       <NA>
#> 5357                          <NA>       <NA>
#> 5358                          <NA>       <NA>
#> 5359                          <NA>       <NA>
#> 5360                          <NA>       <NA>
#> 5361                          <NA>       <NA>
#> 5362                          <NA>       <NA>
#> 5363                          <NA>       <NA>
#> 5364                          <NA>       <NA>
#> 5365                          <NA>       <NA>
#> 5366                          <NA>       <NA>
#> 5367                          <NA>       <NA>
#> 5368                          <NA>       <NA>
#> 5369                          <NA>       <NA>
#> 5370                          <NA>       <NA>
#> 5371                          <NA>       <NA>
#> 5372                          <NA>       <NA>
#> 5373                          <NA>       <NA>
#> 5374                          <NA>       <NA>
#> 5375                          <NA>       <NA>
#> 5376 ISO 8601 datetime or interval       <NA>
#> 5377                          <NA>       <NA>
#> 5378                          <NA>       <NA>
#> 5379                          <NA>       <NA>
#> 5380             ISO 8601 duration       <NA>
#> 5381                          <NA>       <NA>
#> 5382 ISO 8601 datetime or interval       <NA>
#> 5383                          <NA>       <NA>
#> 5384                          <NA>         MI
#> 5385                          <NA>       <NA>
#> 5386                          <NA>       <NA>
#> 5387                          <NA>       <NA>
#> 5388                          <NA>       <NA>
#> 5389                          <NA>       <NA>
#> 5390                          <NA>       <NA>
#> 5391                          <NA>       <NA>
#> 5392                          <NA>       <NA>
#> 5393                          <NA>       <NA>
#> 5394                          <NA>       <NA>
#> 5395                          <NA>       <NA>
#> 5396                          <NA>       <NA>
#> 5397                          <NA>       <NA>
#> 5398                          <NA>       <NA>
#> 5399                          <NA>       <NA>
#> 5400                          <NA>       <NA>
#> 5401                          <NA>       <NA>
#> 5402                          <NA>       <NA>
#> 5403                          <NA>       <NA>
#> 5404                          <NA>       <NA>
#> 5405                          <NA>       <NA>
#> 5406                          <NA>       <NA>
#> 5407                          <NA>       <NA>
#> 5408                          <NA>       <NA>
#> 5409                          <NA>       <NA>
#> 5410                          <NA>       <NA>
#> 5411                          <NA>       <NA>
#> 5412                          <NA>       <NA>
#> 5413                          <NA>       <NA>
#> 5414                          <NA>       <NA>
#> 5415                          <NA>       <NA>
#> 5416                          <NA>       <NA>
#> 5417                          <NA>       <NA>
#> 5418 ISO 8601 datetime or interval       <NA>
#> 5419                          <NA>       <NA>
#> 5420                          <NA>       <NA>
#> 5421                          <NA>         MK
#> 5422                          <NA>       <NA>
#> 5423                          <NA>       <NA>
#> 5424                          <NA>       <NA>
#> 5425                          <NA>       <NA>
#> 5426                          <NA>       <NA>
#> 5427                          <NA>       <NA>
#> 5428                          <NA>       <NA>
#> 5429                          <NA>       <NA>
#> 5430                          <NA>       <NA>
#> 5431                          <NA>       <NA>
#> 5432                          <NA>       <NA>
#> 5433                          <NA>       <NA>
#> 5434                          <NA>       <NA>
#> 5435                          <NA>       <NA>
#> 5436                          <NA>       <NA>
#> 5437                          <NA>       <NA>
#> 5438                          <NA>       <NA>
#> 5439                          <NA>       <NA>
#> 5440                          <NA>       <NA>
#> 5441                          <NA>       <NA>
#> 5442                          <NA>       <NA>
#> 5443                          <NA>       <NA>
#> 5444                          <NA>       <NA>
#> 5445                          <NA>       <NA>
#> 5446                          <NA>       <NA>
#> 5447                          <NA>       <NA>
#> 5448                          <NA>       <NA>
#> 5449                          <NA>       <NA>
#> 5450                          <NA>       <NA>
#> 5451                          <NA>       <NA>
#> 5452                          <NA>       <NA>
#> 5453                          <NA>       <NA>
#> 5454                          <NA>       <NA>
#> 5455 ISO 8601 datetime or interval       <NA>
#> 5456                          <NA>       <NA>
#> 5457                          <NA>       <NA>
#> 5458                          <NA>       <NA>
#> 5459             ISO 8601 duration       <NA>
#> 5460                          <NA>       <NA>
#> 5461 ISO 8601 datetime or interval       <NA>
#> 5462                          <NA>       <NA>
#> 5463                          <NA>         MS
#> 5464                          <NA>       <NA>
#> 5465                          <NA>       <NA>
#> 5466                          <NA>       <NA>
#> 5467                          <NA>       <NA>
#> 5468                          <NA>       <NA>
#> 5469                          <NA>       <NA>
#> 5470                          <NA>       <NA>
#> 5471                          <NA>       <NA>
#> 5472                          <NA>       <NA>
#> 5473                          <NA>       <NA>
#> 5474                          <NA>       <NA>
#> 5475                          <NA>       <NA>
#> 5476                          <NA>       <NA>
#> 5477                          <NA>       <NA>
#> 5478                          <NA>       <NA>
#> 5479                          <NA>       <NA>
#> 5480                          <NA>       <NA>
#> 5481                          <NA>       <NA>
#> 5482                          <NA>       <NA>
#> 5483                          <NA>       <NA>
#> 5484                          <NA>       <NA>
#> 5485                          <NA>       <NA>
#> 5486                          <NA>       <NA>
#> 5487                          <NA>       <NA>
#> 5488                          <NA>       <NA>
#> 5489                          <NA>       <NA>
#> 5490                          <NA>       <NA>
#> 5491                          <NA>       <NA>
#> 5492                          <NA>       <NA>
#> 5493                          <NA>       <NA>
#> 5494                          <NA>       <NA>
#> 5495                          <NA>       <NA>
#> 5496                          <NA>       <NA>
#> 5497                          <NA>       <NA>
#> 5498                          <NA>       <NA>
#> 5499                          <NA>       <NA>
#> 5500                          <NA>       <NA>
#> 5501                          <NA>       <NA>
#> 5502                          <NA>       <NA>
#> 5503                          <NA>       <NA>
#> 5504                          <NA>       <NA>
#> 5505                          <NA>       <NA>
#> 5506                          <NA>       <NA>
#> 5507                          <NA>       <NA>
#> 5508                          <NA>       <NA>
#> 5509                          <NA>       <NA>
#> 5510                          <NA>       <NA>
#> 5511                          <NA>       <NA>
#> 5512                          <NA>       <NA>
#> 5513 ISO 8601 datetime or interval       <NA>
#> 5514                          <NA>       <NA>
#> 5515             ISO 8601 duration       <NA>
#> 5516                          <NA>       <NA>
#> 5517                          <NA>       <NA>
#> 5518             ISO 8601 duration       <NA>
#> 5519                          <NA>       <NA>
#> 5520 ISO 8601 datetime or interval       <NA>
#> 5521 ISO 8601 duration or interval       <NA>
#> 5522                          <NA>       <NA>
#> 5523                          <NA>       <NA>
#> 5524                          <NA>         NV
#> 5525                          <NA>       <NA>
#> 5526                          <NA>       <NA>
#> 5527                          <NA>       <NA>
#> 5528                          <NA>       <NA>
#> 5529                          <NA>       <NA>
#> 5530                          <NA>       <NA>
#> 5531                          <NA>       <NA>
#> 5532                          <NA>       <NA>
#> 5533                          <NA>       <NA>
#> 5534                          <NA>       <NA>
#> 5535                          <NA>       <NA>
#> 5536                          <NA>       <NA>
#> 5537                          <NA>       <NA>
#> 5538                          <NA>       <NA>
#> 5539                          <NA>       <NA>
#> 5540                          <NA>       <NA>
#> 5541                          <NA>       <NA>
#> 5542                          <NA>       <NA>
#> 5543                          <NA>       <NA>
#> 5544                          <NA>       <NA>
#> 5545                          <NA>       <NA>
#> 5546                          <NA>       <NA>
#> 5547                          <NA>       <NA>
#> 5548                          <NA>       <NA>
#> 5549                          <NA>       <NA>
#> 5550                          <NA>       <NA>
#> 5551                          <NA>       <NA>
#> 5552                          <NA>       <NA>
#> 5553                          <NA>       <NA>
#> 5554                          <NA>       <NA>
#> 5555                          <NA>       <NA>
#> 5556                          <NA>       <NA>
#> 5557                          <NA>       <NA>
#> 5558 ISO 8601 datetime or interval       <NA>
#> 5559                          <NA>       <NA>
#> 5560                          <NA>       <NA>
#> 5561                          <NA>       <NA>
#> 5562             ISO 8601 duration       <NA>
#> 5563                          <NA>       <NA>
#> 5564 ISO 8601 datetime or interval       <NA>
#> 5565                          <NA>       <NA>
#> 5566                          <NA>         OE
#> 5567                          <NA>       <NA>
#> 5568                          <NA>       <NA>
#> 5569                          <NA>       <NA>
#> 5570                          <NA>       <NA>
#> 5571                          <NA>       <NA>
#> 5572                          <NA>       <NA>
#> 5573                          <NA>       <NA>
#> 5574                          <NA>       <NA>
#> 5575                          <NA>       <NA>
#> 5576                          <NA>       <NA>
#> 5577                          <NA>       <NA>
#> 5578                          <NA>       <NA>
#> 5579                          <NA>       <NA>
#> 5580                          <NA>       <NA>
#> 5581                          <NA>       <NA>
#> 5582                          <NA>       <NA>
#> 5583                          <NA>       <NA>
#> 5584                          <NA>       <NA>
#> 5585                          <NA>       <NA>
#> 5586                          <NA>       <NA>
#> 5587                          <NA>       <NA>
#> 5588                          <NA>       <NA>
#> 5589                          <NA>       <NA>
#> 5590                          <NA>       <NA>
#> 5591                          <NA>       <NA>
#> 5592                          <NA>       <NA>
#> 5593                          <NA>       <NA>
#> 5594                          <NA>       <NA>
#> 5595                          <NA>       <NA>
#> 5596                          <NA>       <NA>
#> 5597                          <NA>       <NA>
#> 5598                          <NA>       <NA>
#> 5599                          <NA>       <NA>
#> 5600                          <NA>       <NA>
#> 5601                          <NA>       <NA>
#> 5602                          <NA>       <NA>
#> 5603                          <NA>       <NA>
#> 5604                          <NA>       <NA>
#> 5605                          <NA>       <NA>
#> 5606                          <NA>       <NA>
#> 5607                          <NA>       <NA>
#> 5608                          <NA>       <NA>
#> 5609                          <NA>       <NA>
#> 5610 ISO 8601 datetime or interval       <NA>
#> 5611                          <NA>       <NA>
#> 5612                          <NA>       <NA>
#> 5613                          <NA>       <NA>
#> 5614             ISO 8601 duration       <NA>
#> 5615                          <NA>       <NA>
#> 5616 ISO 8601 datetime or interval       <NA>
#> 5617                          <NA>       <NA>
#> 5618                          <NA>         PC
#> 5619                          <NA>       <NA>
#> 5620                          <NA>       <NA>
#> 5621                          <NA>       <NA>
#> 5622                          <NA>       <NA>
#> 5623                          <NA>       <NA>
#> 5624                          <NA>       <NA>
#> 5625                          <NA>       <NA>
#> 5626                          <NA>       <NA>
#> 5627                          <NA>       <NA>
#> 5628                          <NA>       <NA>
#> 5629                          <NA>       <NA>
#> 5630                          <NA>       <NA>
#> 5631                          <NA>       <NA>
#> 5632                          <NA>       <NA>
#> 5633                          <NA>       <NA>
#> 5634                          <NA>       <NA>
#> 5635                          <NA>       <NA>
#> 5636                          <NA>       <NA>
#> 5637                          <NA>       <NA>
#> 5638                          <NA>       <NA>
#> 5639                          <NA>       <NA>
#> 5640                          <NA>       <NA>
#> 5641                          <NA>       <NA>
#> 5642                          <NA>       <NA>
#> 5643                          <NA>       <NA>
#> 5644                          <NA>       <NA>
#> 5645                          <NA>       <NA>
#> 5646                          <NA>       <NA>
#> 5647                          <NA>       <NA>
#> 5648 ISO 8601 datetime or interval       <NA>
#> 5649 ISO 8601 datetime or interval       <NA>
#> 5650                          <NA>       <NA>
#> 5651                          <NA>       <NA>
#> 5652                          <NA>       <NA>
#> 5653                          <NA>       <NA>
#> 5654             ISO 8601 duration       <NA>
#> 5655                          <NA>       <NA>
#> 5656 ISO 8601 datetime or interval       <NA>
#> 5657 ISO 8601 duration or interval       <NA>
#> 5658                          <NA>       <NA>
#> 5659                          <NA>         PE
#> 5660                          <NA>       <NA>
#> 5661                          <NA>       <NA>
#> 5662                          <NA>       <NA>
#> 5663                          <NA>       <NA>
#> 5664                          <NA>       <NA>
#> 5665                          <NA>       <NA>
#> 5666                          <NA>       <NA>
#> 5667                          <NA>       <NA>
#> 5668                          <NA>       <NA>
#> 5669                          <NA>       <NA>
#> 5670                          <NA>       <NA>
#> 5671                          <NA>       <NA>
#> 5672                          <NA>       <NA>
#> 5673                          <NA>       <NA>
#> 5674                          <NA>       <NA>
#> 5675                          <NA>       <NA>
#> 5676                          <NA>       <NA>
#> 5677                          <NA>       <NA>
#> 5678                          <NA>       <NA>
#> 5679                          <NA>       <NA>
#> 5680                          <NA>       <NA>
#> 5681                          <NA>       <NA>
#> 5682                          <NA>       <NA>
#> 5683                          <NA>       <NA>
#> 5684                          <NA>       <NA>
#> 5685                          <NA>       <NA>
#> 5686 ISO 8601 datetime or interval       <NA>
#> 5687                          <NA>       <NA>
#> 5688                          <NA>       <NA>
#> 5689                          <NA>         PP
#> 5690                          <NA>       <NA>
#> 5691                          <NA>       <NA>
#> 5692                          <NA>       <NA>
#> 5693                          <NA>       <NA>
#> 5694                          <NA>       <NA>
#> 5695                          <NA>       <NA>
#> 5696                          <NA>       <NA>
#> 5697                          <NA>       <NA>
#> 5698                          <NA>       <NA>
#> 5699                          <NA>       <NA>
#> 5700                          <NA>       <NA>
#> 5701                          <NA>       <NA>
#> 5702                          <NA>       <NA>
#> 5703                          <NA>       <NA>
#> 5704                          <NA>       <NA>
#> 5705                          <NA>       <NA>
#> 5706                          <NA>       <NA>
#> 5707                          <NA>       <NA>
#> 5708 ISO 8601 datetime or interval       <NA>
#> 5709                          <NA>       <NA>
#> 5710                          <NA>       <NA>
#> 5711 ISO 8601 datetime or interval       <NA>
#> 5712             ISO 8601 duration       <NA>
#> 5713             ISO 8601 duration       <NA>
#> 5714                          <NA>       <NA>
#> 5715                          <NA>         QS
#> 5716                          <NA>       <NA>
#> 5717                          <NA>       <NA>
#> 5718                          <NA>       <NA>
#> 5719                          <NA>       <NA>
#> 5720                          <NA>       <NA>
#> 5721                          <NA>       <NA>
#> 5722                          <NA>       <NA>
#> 5723                          <NA>       <NA>
#> 5724                          <NA>       <NA>
#> 5725                          <NA>       <NA>
#> 5726                          <NA>       <NA>
#> 5727                          <NA>       <NA>
#> 5728                          <NA>       <NA>
#> 5729                          <NA>       <NA>
#> 5730                          <NA>       <NA>
#> 5731                          <NA>       <NA>
#> 5732                          <NA>       <NA>
#> 5733                          <NA>       <NA>
#> 5734                          <NA>       <NA>
#> 5735                          <NA>       <NA>
#> 5736                          <NA>       <NA>
#> 5737                          <NA>       <NA>
#> 5738                          <NA>       <NA>
#> 5739                          <NA>       <NA>
#> 5740 ISO 8601 datetime or interval       <NA>
#> 5741                          <NA>       <NA>
#> 5742                          <NA>       <NA>
#> 5743                          <NA>       <NA>
#> 5744             ISO 8601 duration       <NA>
#> 5745                          <NA>       <NA>
#> 5746 ISO 8601 datetime or interval       <NA>
#> 5747 ISO 8601 duration or interval       <NA>
#> 5748                          <NA>       <NA>
#> 5749                          <NA>       <NA>
#> 5750                          <NA>         RE
#> 5751                          <NA>       <NA>
#> 5752                          <NA>       <NA>
#> 5753                          <NA>       <NA>
#> 5754                          <NA>       <NA>
#> 5755                          <NA>       <NA>
#> 5756                          <NA>       <NA>
#> 5757                          <NA>       <NA>
#> 5758                          <NA>       <NA>
#> 5759                          <NA>       <NA>
#> 5760                          <NA>       <NA>
#> 5761                          <NA>       <NA>
#> 5762                          <NA>       <NA>
#> 5763                          <NA>       <NA>
#> 5764                          <NA>       <NA>
#> 5765                          <NA>       <NA>
#> 5766                          <NA>       <NA>
#> 5767                          <NA>       <NA>
#> 5768                          <NA>       <NA>
#> 5769                          <NA>       <NA>
#> 5770                          <NA>       <NA>
#> 5771                          <NA>       <NA>
#> 5772                          <NA>       <NA>
#> 5773                          <NA>       <NA>
#> 5774                          <NA>       <NA>
#> 5775                          <NA>       <NA>
#> 5776                          <NA>       <NA>
#> 5777                          <NA>       <NA>
#> 5778                          <NA>       <NA>
#> 5779                          <NA>       <NA>
#> 5780                          <NA>       <NA>
#> 5781                          <NA>       <NA>
#> 5782                          <NA>       <NA>
#> 5783                          <NA>       <NA>
#> 5784                          <NA>       <NA>
#> 5785                          <NA>       <NA>
#> 5786                          <NA>       <NA>
#> 5787                          <NA>       <NA>
#> 5788                          <NA>       <NA>
#> 5789 ISO 8601 datetime or interval       <NA>
#> 5790                          <NA>       <NA>
#> 5791                          <NA>       <NA>
#> 5792                          <NA>       <NA>
#> 5793             ISO 8601 duration       <NA>
#> 5794                          <NA>       <NA>
#> 5795 ISO 8601 datetime or interval       <NA>
#> 5796                          <NA>       <NA>
#> 5797                          <NA>         RP
#> 5798                          <NA>       <NA>
#> 5799                          <NA>       <NA>
#> 5800                          <NA>       <NA>
#> 5801                          <NA>       <NA>
#> 5802                          <NA>       <NA>
#> 5803                          <NA>       <NA>
#> 5804                          <NA>       <NA>
#> 5805                          <NA>       <NA>
#> 5806                          <NA>       <NA>
#> 5807                          <NA>       <NA>
#> 5808                          <NA>       <NA>
#> 5809                          <NA>       <NA>
#> 5810                          <NA>       <NA>
#> 5811                          <NA>       <NA>
#> 5812                          <NA>       <NA>
#> 5813                          <NA>       <NA>
#> 5814                          <NA>       <NA>
#> 5815                          <NA>       <NA>
#> 5816                          <NA>       <NA>
#> 5817                          <NA>       <NA>
#> 5818                          <NA>       <NA>
#> 5819                          <NA>       <NA>
#> 5820                          <NA>       <NA>
#> 5821                          <NA>       <NA>
#> 5822                          <NA>       <NA>
#> 5823                          <NA>       <NA>
#> 5824 ISO 8601 datetime or interval       <NA>
#> 5825                          <NA>       <NA>
#> 5826             ISO 8601 duration       <NA>
#> 5827                          <NA>       <NA>
#> 5828                          <NA>       <NA>
#> 5829             ISO 8601 duration       <NA>
#> 5830                          <NA>       <NA>
#> 5831 ISO 8601 datetime or interval       <NA>
#> 5832                          <NA>       <NA>
#> 5833                          <NA>         RS
#> 5834                          <NA>       <NA>
#> 5835                          <NA>       <NA>
#> 5836                          <NA>       <NA>
#> 5837                          <NA>       <NA>
#> 5838                          <NA>       <NA>
#> 5839                          <NA>       <NA>
#> 5840                          <NA>       <NA>
#> 5841                          <NA>       <NA>
#> 5842                          <NA>       <NA>
#> 5843                          <NA>       <NA>
#> 5844                          <NA>       <NA>
#> 5845                          <NA>       <NA>
#> 5846                          <NA>       <NA>
#> 5847                          <NA>       <NA>
#> 5848                          <NA>       <NA>
#> 5849                          <NA>       <NA>
#> 5850                          <NA>       <NA>
#> 5851                          <NA>       <NA>
#> 5852                          <NA>       <NA>
#> 5853                          <NA>       <NA>
#> 5854                          <NA>       <NA>
#> 5855                          <NA>       <NA>
#> 5856                          <NA>       <NA>
#> 5857                          <NA>       <NA>
#> 5858                          <NA>       <NA>
#> 5859                          <NA>       <NA>
#> 5860                          <NA>       <NA>
#> 5861                          <NA>       <NA>
#> 5862                          <NA>       <NA>
#> 5863                          <NA>       <NA>
#> 5864                          <NA>       <NA>
#> 5865 ISO 8601 datetime or interval       <NA>
#> 5866                          <NA>       <NA>
#> 5867                          <NA>       <NA>
#> 5868                          <NA>       <NA>
#> 5869             ISO 8601 duration       <NA>
#> 5870                          <NA>       <NA>
#> 5871 ISO 8601 datetime or interval       <NA>
#> 5872 ISO 8601 duration or interval       <NA>
#> 5873                          <NA>       <NA>
#> 5874                          <NA>       <NA>
#> 5875                          <NA>       <NA>
#> 5876                          <NA>       <NA>
#> 5877                          <NA>       <NA>
#> 5878                          <NA>       <NA>
#> 5879                          <NA>         SC
#> 5880                          <NA>       <NA>
#> 5881                          <NA>       <NA>
#> 5882                          <NA>       <NA>
#> 5883                          <NA>       <NA>
#> 5884                          <NA>       <NA>
#> 5885                          <NA>       <NA>
#> 5886                          <NA>       <NA>
#> 5887                          <NA>       <NA>
#> 5888                          <NA>       <NA>
#> 5889                          <NA>       <NA>
#> 5890                          <NA>       <NA>
#> 5891                          <NA>       <NA>
#> 5892                          <NA>       <NA>
#> 5893                          <NA>       <NA>
#> 5894                          <NA>       <NA>
#> 5895                          <NA>       <NA>
#> 5896                          <NA>       <NA>
#> 5897                          <NA>       <NA>
#> 5898                          <NA>       <NA>
#> 5899                          <NA>       <NA>
#> 5900 ISO 8601 datetime or interval       <NA>
#> 5901                          <NA>       <NA>
#> 5902                          <NA>       <NA>
#> 5903                          <NA>         SS
#> 5904                          <NA>       <NA>
#> 5905                          <NA>       <NA>
#> 5906                          <NA>       <NA>
#> 5907                          <NA>       <NA>
#> 5908                          <NA>       <NA>
#> 5909                          <NA>       <NA>
#> 5910                          <NA>       <NA>
#> 5911                          <NA>       <NA>
#> 5912                          <NA>       <NA>
#> 5913                          <NA>       <NA>
#> 5914                          <NA>       <NA>
#> 5915                          <NA>       <NA>
#> 5916                          <NA>       <NA>
#> 5917                          <NA>       <NA>
#> 5918                          <NA>       <NA>
#> 5919                          <NA>       <NA>
#> 5920                          <NA>       <NA>
#> 5921                          <NA>       <NA>
#> 5922 ISO 8601 datetime or interval       <NA>
#> 5923                          <NA>       <NA>
#> 5924                          <NA>       <NA>
#> 5925                          <NA>         TR
#> 5926                          <NA>       <NA>
#> 5927                          <NA>       <NA>
#> 5928                          <NA>       <NA>
#> 5929                          <NA>       <NA>
#> 5930                          <NA>       <NA>
#> 5931                          <NA>       <NA>
#> 5932                          <NA>       <NA>
#> 5933                          <NA>       <NA>
#> 5934                          <NA>       <NA>
#> 5935                          <NA>       <NA>
#> 5936                          <NA>       <NA>
#> 5937                          <NA>       <NA>
#> 5938                          <NA>       <NA>
#> 5939                          <NA>       <NA>
#> 5940                          <NA>       <NA>
#> 5941                          <NA>       <NA>
#> 5942                          <NA>       <NA>
#> 5943                          <NA>       <NA>
#> 5944                          <NA>       <NA>
#> 5945                          <NA>       <NA>
#> 5946                          <NA>       <NA>
#> 5947                          <NA>       <NA>
#> 5948                          <NA>       <NA>
#> 5949                          <NA>       <NA>
#> 5950                          <NA>       <NA>
#> 5951                          <NA>       <NA>
#> 5952                          <NA>       <NA>
#> 5953                          <NA>       <NA>
#> 5954 ISO 8601 datetime or interval       <NA>
#> 5955                          <NA>       <NA>
#> 5956                          <NA>       <NA>
#> 5957                          <NA>         TU
#> 5958                          <NA>       <NA>
#> 5959                          <NA>       <NA>
#> 5960                          <NA>       <NA>
#> 5961                          <NA>       <NA>
#> 5962                          <NA>       <NA>
#> 5963                          <NA>       <NA>
#> 5964                          <NA>       <NA>
#> 5965                          <NA>       <NA>
#> 5966                          <NA>       <NA>
#> 5967                          <NA>       <NA>
#> 5968                          <NA>       <NA>
#> 5969                          <NA>       <NA>
#> 5970                          <NA>       <NA>
#> 5971                          <NA>       <NA>
#> 5972                          <NA>       <NA>
#> 5973                          <NA>       <NA>
#> 5974                          <NA>       <NA>
#> 5975                          <NA>       <NA>
#> 5976                          <NA>       <NA>
#> 5977                          <NA>       <NA>
#> 5978                          <NA>       <NA>
#> 5979                          <NA>       <NA>
#> 5980                          <NA>       <NA>
#> 5981                          <NA>       <NA>
#> 5982                          <NA>       <NA>
#> 5983                          <NA>       <NA>
#> 5984                          <NA>       <NA>
#> 5985 ISO 8601 datetime or interval       <NA>
#> 5986                          <NA>       <NA>
#> 5987                          <NA>       <NA>
#> 5988                          <NA>         UR
#> 5989                          <NA>       <NA>
#> 5990                          <NA>       <NA>
#> 5991                          <NA>       <NA>
#> 5992                          <NA>       <NA>
#> 5993                          <NA>       <NA>
#> 5994                          <NA>       <NA>
#> 5995                          <NA>       <NA>
#> 5996                          <NA>       <NA>
#> 5997                          <NA>       <NA>
#> 5998                          <NA>       <NA>
#> 5999                          <NA>       <NA>
#> 6000                          <NA>       <NA>
#> 6001                          <NA>       <NA>
#> 6002                          <NA>       <NA>
#> 6003                          <NA>       <NA>
#> 6004                          <NA>       <NA>
#> 6005                          <NA>       <NA>
#> 6006                          <NA>       <NA>
#> 6007                          <NA>       <NA>
#> 6008                          <NA>       <NA>
#> 6009                          <NA>       <NA>
#> 6010                          <NA>       <NA>
#> 6011                          <NA>       <NA>
#> 6012                          <NA>       <NA>
#> 6013                          <NA>       <NA>
#> 6014                          <NA>       <NA>
#> 6015                          <NA>       <NA>
#> 6016                          <NA>       <NA>
#> 6017                          <NA>       <NA>
#> 6018                          <NA>       <NA>
#> 6019                          <NA>       <NA>
#> 6020                          <NA>       <NA>
#> 6021                          <NA>       <NA>
#> 6022                          <NA>       <NA>
#> 6023 ISO 8601 datetime or interval       <NA>
#> 6024                          <NA>       <NA>
#> 6025                          <NA>       <NA>
#> 6026                          <NA>       <NA>
#> 6027             ISO 8601 duration       <NA>
#> 6028                          <NA>       <NA>
#> 6029 ISO 8601 datetime or interval       <NA>
#> 6030                          <NA>       <NA>
#> 6031                          <NA>         VS
#> 6032                          <NA>       <NA>
#> 6033                          <NA>       <NA>
#> 6034                          <NA>       <NA>
#> 6035                          <NA>       <NA>
#> 6036                          <NA>       <NA>
#> 6037                          <NA>       <NA>
#> 6038                          <NA>       <NA>
#> 6039                          <NA>       <NA>
#> 6040                          <NA>       <NA>
#> 6041                          <NA>       <NA>
#> 6042                          <NA>       <NA>
#> 6043                          <NA>       <NA>
#> 6044                          <NA>       <NA>
#> 6045                          <NA>       <NA>
#> 6046                          <NA>       <NA>
#> 6047                          <NA>       <NA>
#> 6048                          <NA>       <NA>
#> 6049                          <NA>       <NA>
#> 6050                          <NA>       <NA>
#> 6051                          <NA>       <NA>
#> 6052                          <NA>       <NA>
#> 6053                          <NA>       <NA>
#> 6054                          <NA>       <NA>
#> 6055                          <NA>       <NA>
#> 6056                          <NA>       <NA>
#> 6057                          <NA>       <NA>
#> 6058                          <NA>       <NA>
#> 6059                          <NA>       <NA>
#> 6060                          <NA>       <NA>
#> 6061 ISO 8601 datetime or interval       <NA>
#> 6062                          <NA>       <NA>
#> 6063                          <NA>       <NA>
#> 6064                          <NA>       <NA>
#> 6065             ISO 8601 duration       <NA>
#> 6066                          <NA>       <NA>
#> 6067 ISO 8601 datetime or interval       <NA>
#> 6068                          <NA>       <NA>
#> 6069                          <NA>         FA
#> 6070                          <NA>       <NA>
#> 6071                          <NA>       <NA>
#> 6072                          <NA>       <NA>
#> 6073                          <NA>       <NA>
#> 6074                          <NA>       <NA>
#> 6075                          <NA>       <NA>
#> 6076                          <NA>       <NA>
#> 6077                          <NA>       <NA>
#> 6078                          <NA>       <NA>
#> 6079                          <NA>       <NA>
#> 6080                          <NA>       <NA>
#> 6081                          <NA>       <NA>
#> 6082                          <NA>       <NA>
#> 6083                          <NA>       <NA>
#> 6084                          <NA>       <NA>
#> 6085                          <NA>       <NA>
#> 6086                          <NA>       <NA>
#> 6087                          <NA>       <NA>
#> 6088                          <NA>       <NA>
#> 6089                          <NA>       <NA>
#> 6090                          <NA>       <NA>
#> 6091                          <NA>       <NA>
#> 6092                          <NA>       <NA>
#> 6093                          <NA>       <NA>
#> 6094                          <NA>       <NA>
#> 6095                          <NA>       <NA>
#> 6096 ISO 8601 datetime or interval       <NA>
#> 6097                          <NA>       <NA>
#> 6098                          <NA>       <NA>
#> 6099                          <NA>         SR
#> 6100                          <NA>       <NA>
#> 6101                          <NA>       <NA>
#> 6102                          <NA>       <NA>
#> 6103                          <NA>       <NA>
#> 6104                          <NA>       <NA>
#> 6105                          <NA>       <NA>
#> 6106                          <NA>       <NA>
#> 6107                          <NA>       <NA>
#> 6108                          <NA>       <NA>
#> 6109                          <NA>       <NA>
#> 6110                          <NA>       <NA>
#> 6111                          <NA>       <NA>
#> 6112                          <NA>       <NA>
#> 6113                          <NA>       <NA>
#> 6114                          <NA>       <NA>
#> 6115                          <NA>       <NA>
#> 6116                          <NA>       <NA>
#> 6117                          <NA>       <NA>
#> 6118                          <NA>       <NA>
#> 6119                          <NA>       <NA>
#> 6120                          <NA>       <NA>
#> 6121                          <NA>       <NA>
#> 6122                          <NA>       <NA>
#> 6123                          <NA>       <NA>
#> 6124                          <NA>       <NA>
#> 6125                          <NA>       <NA>
#> 6126                          <NA>       <NA>
#> 6127                          <NA>       <NA>
#> 6128                          <NA>       <NA>
#> 6129                          <NA>       <NA>
#> 6130 ISO 8601 datetime or interval       <NA>
#> 6131                          <NA>       <NA>
#> 6132                          <NA>       <NA>
#> 6133                          <NA>       <NA>
#> 6134             ISO 8601 duration       <NA>
#> 6135                          <NA>       <NA>
#> 6136 ISO 8601 datetime or interval       <NA>
#> 6137                          <NA>       <NA>
#> 6138                          <NA>         CO
#> 6139                          <NA>       <NA>
#> 6140                          <NA>       <NA>
#> 6141                          <NA>       <NA>
#> 6142                          <NA>       <NA>
#> 6143                          <NA>       <NA>
#> 6144                          <NA>       <NA>
#> 6145                          <NA>       <NA>
#> 6146                          <NA>       <NA>
#> 6147                          <NA>       <NA>
#> 6148 ISO 8601 datetime or interval       <NA>
#> 6149                          <NA>       <NA>
#> 6150                          <NA>       <NA>
#> 6151                          <NA>         DM
#> 6152                          <NA>       <NA>
#> 6153                          <NA>       <NA>
#> 6154 ISO 8601 datetime or interval       <NA>
#> 6155 ISO 8601 datetime or interval       <NA>
#> 6156 ISO 8601 datetime or interval       <NA>
#> 6157 ISO 8601 datetime or interval       <NA>
#> 6158 ISO 8601 datetime or interval       <NA>
#> 6159 ISO 8601 datetime or interval       <NA>
#> 6160 ISO 8601 datetime or interval       <NA>
#> 6161 ISO 8601 datetime or interval       <NA>
#> 6162 ISO 8601 datetime or interval       <NA>
#> 6163                          <NA>       <NA>
#> 6164                          <NA>       <NA>
#> 6165                          <NA>       <NA>
#> 6166                          <NA>       <NA>
#> 6167 ISO 8601 datetime or interval       <NA>
#> 6168                          <NA>       <NA>
#> 6169                          <NA>       <NA>
#> 6170                          <NA>       <NA>
#> 6171                          <NA>       <NA>
#> 6172                          <NA>       <NA>
#> 6173                          <NA>       <NA>
#> 6174                          <NA>       <NA>
#> 6175                          <NA>       <NA>
#> 6176                          <NA>       <NA>
#> 6177                          <NA>       <NA>
#> 6178                          <NA>       <NA>
#> 6179                          <NA>       <NA>
#> 6180 ISO 8601 datetime or interval       <NA>
#> 6181                          <NA>       <NA>
#> 6182                          <NA>       <NA>
#> 6183                          <NA>         SE
#> 6184                          <NA>       <NA>
#> 6185                          <NA>       <NA>
#> 6186                          <NA>       <NA>
#> 6187                          <NA>       <NA>
#> 6188                          <NA>       <NA>
#> 6189                          <NA>       <NA>
#> 6190 ISO 8601 datetime or interval       <NA>
#> 6191 ISO 8601 datetime or interval       <NA>
#> 6192                          <NA>       <NA>
#> 6193                          <NA>       <NA>
#> 6194                          <NA>       <NA>
#> 6195                          <NA>       <NA>
#> 6196                          <NA>         SM
#> 6197                          <NA>       <NA>
#> 6198                          <NA>       <NA>
#> 6199                          <NA>       <NA>
#> 6200                          <NA>       <NA>
#> 6201 ISO 8601 datetime or interval       <NA>
#> 6202 ISO 8601 datetime or interval       <NA>
#> 6203                          <NA>       <NA>
#> 6204                          <NA>       <NA>
#> 6205                          <NA>       <NA>
#> 6206                          <NA>         SV
#> 6207                          <NA>       <NA>
#> 6208                          <NA>       <NA>
#> 6209                          <NA>       <NA>
#> 6210                          <NA>       <NA>
#> 6211                          <NA>       <NA>
#> 6212                          <NA>       <NA>
#> 6213                          <NA>       <NA>
#> 6214                          <NA>       <NA>
#> 6215                          <NA>       <NA>
#> 6216 ISO 8601 datetime or interval       <NA>
#> 6217 ISO 8601 datetime or interval       <NA>
#> 6218                          <NA>       <NA>
#> 6219                          <NA>       <NA>
#> 6220                          <NA>       <NA>
#> 6221                          <NA>       <NA>
#> 6222                          <NA>         TA
#> 6223                          <NA>       <NA>
#> 6224                          <NA>       <NA>
#> 6225                          <NA>       <NA>
#> 6226                          <NA>       <NA>
#> 6227                          <NA>       <NA>
#> 6228                          <NA>       <NA>
#> 6229                          <NA>       <NA>
#> 6230                          <NA>       <NA>
#> 6231                          <NA>       <NA>
#> 6232                          <NA>         TD
#> 6233                          <NA>       <NA>
#> 6234                          <NA>       <NA>
#> 6235             ISO 8601 duration       <NA>
#> 6236             ISO 8601 duration       <NA>
#> 6237             ISO 8601 duration       <NA>
#> 6238             ISO 8601 duration       <NA>
#> 6239                          <NA>       <NA>
#> 6240                          <NA>       <NA>
#> 6241                          <NA>         TE
#> 6242                          <NA>       <NA>
#> 6243                          <NA>       <NA>
#> 6244                          <NA>       <NA>
#> 6245                          <NA>       <NA>
#> 6246             ISO 8601 duration       <NA>
#> 6247                          <NA>       <NA>
#> 6248                          <NA>         TI
#> 6249                          <NA>       <NA>
#> 6250                          <NA>       <NA>
#> 6251                          <NA>       <NA>
#> 6252                          <NA>       <NA>
#> 6253                          <NA>       <NA>
#> 6254                          <NA>       <NA>
#> 6255                          <NA>       <NA>
#> 6256                          <NA>         TM
#> 6257                          <NA>       <NA>
#> 6258                          <NA>       <NA>
#> 6259                          <NA>       <NA>
#> 6260                          <NA>       <NA>
#> 6261                          <NA>         TS
#> 6262                          <NA>       <NA>
#> 6263                          <NA>       <NA>
#> 6264                          <NA>       <NA>
#> 6265                          <NA>       <NA>
#> 6266                          <NA>       <NA>
#> 6267          ISO 21090 NullFlavor       <NA>
#> 6268                          <NA>       <NA>
#> 6269                          <NA>       <NA>
#> 6270                          <NA>       <NA>
#> 6271                          <NA>       <NA>
#> 6272                          <NA>         TV
#> 6273                          <NA>       <NA>
#> 6274                          <NA>       <NA>
#> 6275                          <NA>       <NA>
#> 6276                          <NA>       <NA>
#> 6277                          <NA>       <NA>
#> 6278                          <NA>       <NA>
#> 6279                          <NA>       <NA>
#> 6280                          <NA>       <NA>
#> 6281                          <NA>         OI
#> 6282                          <NA>       <NA>
#> 6283                          <NA>       <NA>
#> 6284                          <NA>       <NA>
#> 6285                          <NA>       <NA>
#> 6286                          <NA>       <NA>
#> 6287                          <NA>       <NA>
#> 6288                          <NA>       <NA>
#> 6289                          <NA>       <NA>
#> 6290                          <NA>       <NA>
#> 6291                          <NA>       <NA>
#> 6292                          <NA>       <NA>
#> 6293                          <NA>       <NA>
#> 6294                          <NA>       <NA>
#> 6295                          <NA>       <NA>
#> 6296                          <NA>       <NA>
#> 6297                          <NA>       <NA>
#> 6298                          <NA>       <NA>
#> 6299                          <NA>       <NA>
#> 6300                          <NA>       <NA>
#> 6301                          <NA>       <NA>
#> 6302                          <NA>       <NA>
#> 6303                          <NA>       <NA>
#> 6304                          <NA>       <NA>
#> 6305                          <NA>       <NA>
#> 6306                          <NA>       <NA>
#> 6307                          <NA>       <NA>
#> 6308                          <NA>       <NA>
#> 6309                          <NA>       <NA>
#> 6310                          <NA>       <NA>
#> 6311                          <NA>       <NA>
#> 6312                          <NA>       <NA>
#> 6313                          <NA>       <NA>
#> 6314                          <NA>       <NA>
get_ig("SDTMIG", version = "3.3", domain = "PP")
#>      standard version    class domain order variable
#> 3928   SDTMIG     3.3 Findings     PP     1  STUDYID
#> 3929   SDTMIG     3.3 Findings     PP     2   DOMAIN
#> 3930   SDTMIG     3.3 Findings     PP     3  USUBJID
#> 3931   SDTMIG     3.3 Findings     PP     4    PPSEQ
#> 3932   SDTMIG     3.3 Findings     PP     5  PPGRPID
#> 3933   SDTMIG     3.3 Findings     PP     6 PPTESTCD
#> 3934   SDTMIG     3.3 Findings     PP     7   PPTEST
#> 3935   SDTMIG     3.3 Findings     PP     8    PPCAT
#> 3936   SDTMIG     3.3 Findings     PP     9   PPSCAT
#> 3937   SDTMIG     3.3 Findings     PP    10  PPORRES
#> 3938   SDTMIG     3.3 Findings     PP    11 PPORRESU
#> 3939   SDTMIG     3.3 Findings     PP    12 PPSTRESC
#> 3940   SDTMIG     3.3 Findings     PP    13 PPSTRESN
#> 3941   SDTMIG     3.3 Findings     PP    14 PPSTRESU
#> 3942   SDTMIG     3.3 Findings     PP    15   PPSTAT
#> 3943   SDTMIG     3.3 Findings     PP    16 PPREASND
#> 3944   SDTMIG     3.3 Findings     PP    17   PPSPEC
#> 3945   SDTMIG     3.3 Findings     PP    18  TAETORD
#> 3946   SDTMIG     3.3 Findings     PP    19    EPOCH
#> 3947   SDTMIG     3.3 Findings     PP    20    PPDTC
#> 3948   SDTMIG     3.3 Findings     PP    21     PPDY
#> 3949   SDTMIG     3.3 Findings     PP    22 PPRFTDTC
#> 3950   SDTMIG     3.3 Findings     PP    23  PPSTINT
#> 3951   SDTMIG     3.3 Findings     PP    24  PPENINT
#>                                         label type               role core
#> 3928                         Study Identifier Char         Identifier  Req
#> 3929                      Domain Abbreviation Char         Identifier  Req
#> 3930                Unique Subject Identifier Char         Identifier  Req
#> 3931                          Sequence Number  Num         Identifier  Req
#> 3932                                 Group ID Char         Identifier Perm
#> 3933                     Parameter Short Name Char              Topic  Req
#> 3934                           Parameter Name Char  Synonym Qualifier  Req
#> 3935                       Parameter Category Char Grouping Qualifier  Exp
#> 3936                    Parameter Subcategory Char Grouping Qualifier Perm
#> 3937      Result or Finding in Original Units Char   Result Qualifier  Exp
#> 3938                           Original Units Char Variable Qualifier  Exp
#> 3939   Character Result/Finding in Std Format Char   Result Qualifier  Exp
#> 3940 Numeric Result/Finding in Standard Units  Num   Result Qualifier  Exp
#> 3941                           Standard Units Char Variable Qualifier  Exp
#> 3942                        Completion Status Char   Record Qualifier Perm
#> 3943          Reason Parameter Not Calculated Char   Record Qualifier Perm
#> 3944                   Specimen Material Type Char   Record Qualifier  Exp
#> 3945      Planned Order of Element within Arm  Num             Timing Perm
#> 3946                                    Epoch Char             Timing Perm
#> 3947      Date/Time of Parameter Calculations Char             Timing Perm
#> 3948      Study Day of Parameter Calculations  Num             Timing Perm
#> 3949             Date/Time of Reference Point Char             Timing  Exp
#> 3950     Planned Start of Assessment Interval Char             Timing Perm
#> 3951       Planned End of Assessment Interval Char             Timing Perm
#>                                   codelist_code codelist_submission_values
#> 3928                                       <NA>                       <NA>
#> 3929                                       <NA>                       <NA>
#> 3930                                       <NA>                       <NA>
#> 3931                                       <NA>                       <NA>
#> 3932                                       <NA>                       <NA>
#> 3933                                     C85839                       <NA>
#> 3934                                     C85493                       <NA>
#> 3935                                       <NA>                       <NA>
#> 3936                                       <NA>                       <NA>
#> 3937                                       <NA>                       <NA>
#> 3938 C85494; C128686; C128683; C128685; C128684                       <NA>
#> 3939                                       <NA>                       <NA>
#> 3940                                       <NA>                       <NA>
#> 3941 C85494; C128686; C128683; C128685; C128684                       <NA>
#> 3942                                     C66789                       <NA>
#> 3943                                       <NA>                       <NA>
#> 3944                                     C78734                       <NA>
#> 3945                                       <NA>                       <NA>
#> 3946                                     C99079                       <NA>
#> 3947                                       <NA>                       <NA>
#> 3948                                       <NA>                       <NA>
#> 3949                                       <NA>                       <NA>
#> 3950                                       <NA>                       <NA>
#> 3951                                       <NA>                       <NA>
#>      described_value_domain value_list
#> 3928                   <NA>       <NA>
#> 3929                   <NA>         PP
#> 3930                   <NA>       <NA>
#> 3931                   <NA>       <NA>
#> 3932                   <NA>       <NA>
#> 3933                   <NA>       <NA>
#> 3934                   <NA>       <NA>
#> 3935                   <NA>       <NA>
#> 3936                   <NA>       <NA>
#> 3937                   <NA>       <NA>
#> 3938                   <NA>       <NA>
#> 3939                   <NA>       <NA>
#> 3940                   <NA>       <NA>
#> 3941                   <NA>       <NA>
#> 3942                   <NA>       <NA>
#> 3943                   <NA>       <NA>
#> 3944                   <NA>       <NA>
#> 3945                   <NA>       <NA>
#> 3946                   <NA>       <NA>
#> 3947               ISO 8601       <NA>
#> 3948                   <NA>       <NA>
#> 3949               ISO 8601       <NA>
#> 3950               ISO 8601       <NA>
#> 3951               ISO 8601       <NA>
get_ig("SENDIG", domain = "PP")
#>      standard version    class domain order variable
#> 8155   SENDIG   3.1.1 Findings     PP     1  STUDYID
#> 8156   SENDIG   3.1.1 Findings     PP     2   DOMAIN
#> 8157   SENDIG   3.1.1 Findings     PP     3  USUBJID
#> 8158   SENDIG   3.1.1 Findings     PP     4   POOLID
#> 8159   SENDIG   3.1.1 Findings     PP     5    PPSEQ
#> 8160   SENDIG   3.1.1 Findings     PP     6  PPGRPID
#> 8161   SENDIG   3.1.1 Findings     PP     7 PPTESTCD
#> 8162   SENDIG   3.1.1 Findings     PP     8   PPTEST
#> 8163   SENDIG   3.1.1 Findings     PP     9    PPCAT
#> 8164   SENDIG   3.1.1 Findings     PP    10   PPSCAT
#> 8165   SENDIG   3.1.1 Findings     PP    11  PPORRES
#> 8166   SENDIG   3.1.1 Findings     PP    12 PPORRESU
#> 8167   SENDIG   3.1.1 Findings     PP    13 PPSTRESC
#> 8168   SENDIG   3.1.1 Findings     PP    14 PPSTRESN
#> 8169   SENDIG   3.1.1 Findings     PP    15 PPSTRESU
#> 8170   SENDIG   3.1.1 Findings     PP    16   PPSTAT
#> 8171   SENDIG   3.1.1 Findings     PP    17 PPREASND
#> 8172   SENDIG   3.1.1 Findings     PP    18   PPSPEC
#> 8173   SENDIG   3.1.1 Findings     PP    19  VISITDY
#> 8174   SENDIG   3.1.1 Findings     PP    20  PPNOMDY
#> 8175   SENDIG   3.1.1 Findings     PP    21 PPNOMLBL
#> 8176   SENDIG   3.1.1 Findings     PP    22 PPTPTREF
#> 8177   SENDIG   3.1.1 Findings     PP    23 PPRFTDTC
#> 8178   SENDIG   3.1.1 Findings     PP    24  PPSTINT
#> 8179   SENDIG   3.1.1 Findings     PP    25  PPENINT
#>                                        label type               role core
#> 8155                        Study Identifier Char         Identifier  Req
#> 8156                     Domain Abbreviation Char         Identifier  Req
#> 8157               Unique Subject Identifier Char         Identifier  Exp
#> 8158                         Pool Identifier Char         Identifier Perm
#> 8159                         Sequence Number  Num         Identifier  Req
#> 8160                        Group Identifier Char         Identifier Perm
#> 8161                    Parameter Short Name Char              Topic  Req
#> 8162                          Parameter Name Char  Synonym Qualifier  Req
#> 8163                      Parameter Category Char Grouping Qualifier  Exp
#> 8164                   Parameter Subcategory Char Grouping Qualifier Perm
#> 8165         Result or Findings as Collected Char   Result Qualifier  Exp
#> 8166             Unit of the Original Result Char Variable Qualifier  Exp
#> 8167 Standardized Result in Character Format Char   Result Qualifier  Exp
#> 8168   Standardized Result in Numeric Format  Num   Result Qualifier  Exp
#> 8169         Unit of the Standardized Result Char Variable Qualifier  Exp
#> 8170                       Completion Status Char   Record Qualifier Perm
#> 8171                         Reason Not Done Char   Record Qualifier Perm
#> 8172                  Specimen Material Type Char   Record Qualifier  Exp
#> 8173         Planned Study Day of Collection  Num             Timing Perm
#> 8174       Nominal Study Day for Tabulations  Num             Timing  Exp
#> 8175             Label for Nominal Study Day Char             Timing Perm
#> 8176                    Time Point Reference Char             Timing  Exp
#> 8177            Date/Time of Reference Point Char             Timing  Exp
#> 8178            Start of Assessment Interval Char             Timing Perm
#> 8179              End of Assessment Interval Char             Timing Perm
#>      codelist_code codelist_submission_values described_value_domain value_list
#> 8155          <NA>                       <NA>                   <NA>       <NA>
#> 8156          <NA>                       <NA>                   <NA>         PP
#> 8157          <NA>                       <NA>                   <NA>       <NA>
#> 8158          <NA>                       <NA>                   <NA>       <NA>
#> 8159          <NA>                       <NA>                   <NA>       <NA>
#> 8160          <NA>                       <NA>                   <NA>       <NA>
#> 8161        C85839                   PKPARMCD                   <NA>       <NA>
#> 8162        C85493                     PKPARM                   <NA>       <NA>
#> 8163          <NA>                       <NA>                   <NA>       <NA>
#> 8164          <NA>                       <NA>                   <NA>       <NA>
#> 8165          <NA>                       <NA>                   <NA>       <NA>
#> 8166        C85494                     PKUNIT                   <NA>       <NA>
#> 8167          <NA>                       <NA>                   <NA>       <NA>
#> 8168          <NA>                       <NA>                   <NA>       <NA>
#> 8169        C85494                     PKUNIT                   <NA>       <NA>
#> 8170        C66789                         ND                   <NA>       <NA>
#> 8171          <NA>                       <NA>                   <NA>       <NA>
#> 8172        C77529                       SPEC                   <NA>       <NA>
#> 8173          <NA>                       <NA>                   <NA>       <NA>
#> 8174          <NA>                       <NA>                   <NA>       <NA>
#> 8175          <NA>                       <NA>                   <NA>       <NA>
#> 8176          <NA>                       <NA>                   <NA>       <NA>
#> 8177          <NA>                       <NA>               ISO 8601       <NA>
#> 8178          <NA>                       <NA>               ISO 8601       <NA>
#> 8179          <NA>                       <NA>               ISO 8601       <NA>
get_ig("ADaMIG", domain = "BDS")
#>      standard version            structure
#> 993    ADaMIG     1.3 Basic Data Structure
#> 994    ADaMIG     1.3 Basic Data Structure
#> 995    ADaMIG     1.3 Basic Data Structure
#> 996    ADaMIG     1.3 Basic Data Structure
#> 997    ADaMIG     1.3 Basic Data Structure
#> 998    ADaMIG     1.3 Basic Data Structure
#> 999    ADaMIG     1.3 Basic Data Structure
#> 1000   ADaMIG     1.3 Basic Data Structure
#> 1001   ADaMIG     1.3 Basic Data Structure
#> 1002   ADaMIG     1.3 Basic Data Structure
#> 1003   ADaMIG     1.3 Basic Data Structure
#> 1004   ADaMIG     1.3 Basic Data Structure
#> 1005   ADaMIG     1.3 Basic Data Structure
#> 1006   ADaMIG     1.3 Basic Data Structure
#> 1007   ADaMIG     1.3 Basic Data Structure
#> 1008   ADaMIG     1.3 Basic Data Structure
#> 1009   ADaMIG     1.3 Basic Data Structure
#> 1010   ADaMIG     1.3 Basic Data Structure
#> 1011   ADaMIG     1.3 Basic Data Structure
#> 1012   ADaMIG     1.3 Basic Data Structure
#> 1013   ADaMIG     1.3 Basic Data Structure
#> 1014   ADaMIG     1.3 Basic Data Structure
#> 1015   ADaMIG     1.3 Basic Data Structure
#> 1016   ADaMIG     1.3 Basic Data Structure
#> 1017   ADaMIG     1.3 Basic Data Structure
#> 1018   ADaMIG     1.3 Basic Data Structure
#> 1019   ADaMIG     1.3 Basic Data Structure
#> 1020   ADaMIG     1.3 Basic Data Structure
#> 1021   ADaMIG     1.3 Basic Data Structure
#> 1022   ADaMIG     1.3 Basic Data Structure
#> 1023   ADaMIG     1.3 Basic Data Structure
#> 1024   ADaMIG     1.3 Basic Data Structure
#> 1025   ADaMIG     1.3 Basic Data Structure
#> 1026   ADaMIG     1.3 Basic Data Structure
#> 1027   ADaMIG     1.3 Basic Data Structure
#> 1028   ADaMIG     1.3 Basic Data Structure
#> 1029   ADaMIG     1.3 Basic Data Structure
#> 1030   ADaMIG     1.3 Basic Data Structure
#> 1031   ADaMIG     1.3 Basic Data Structure
#> 1032   ADaMIG     1.3 Basic Data Structure
#> 1033   ADaMIG     1.3 Basic Data Structure
#> 1034   ADaMIG     1.3 Basic Data Structure
#> 1035   ADaMIG     1.3 Basic Data Structure
#> 1036   ADaMIG     1.3 Basic Data Structure
#> 1037   ADaMIG     1.3 Basic Data Structure
#> 1038   ADaMIG     1.3 Basic Data Structure
#> 1039   ADaMIG     1.3 Basic Data Structure
#> 1040   ADaMIG     1.3 Basic Data Structure
#> 1041   ADaMIG     1.3 Basic Data Structure
#> 1042   ADaMIG     1.3 Basic Data Structure
#> 1043   ADaMIG     1.3 Basic Data Structure
#> 1044   ADaMIG     1.3 Basic Data Structure
#> 1045   ADaMIG     1.3 Basic Data Structure
#> 1046   ADaMIG     1.3 Basic Data Structure
#> 1047   ADaMIG     1.3 Basic Data Structure
#> 1048   ADaMIG     1.3 Basic Data Structure
#> 1049   ADaMIG     1.3 Basic Data Structure
#> 1050   ADaMIG     1.3 Basic Data Structure
#> 1051   ADaMIG     1.3 Basic Data Structure
#> 1052   ADaMIG     1.3 Basic Data Structure
#> 1053   ADaMIG     1.3 Basic Data Structure
#> 1054   ADaMIG     1.3 Basic Data Structure
#> 1055   ADaMIG     1.3 Basic Data Structure
#> 1056   ADaMIG     1.3 Basic Data Structure
#> 1057   ADaMIG     1.3 Basic Data Structure
#> 1058   ADaMIG     1.3 Basic Data Structure
#> 1059   ADaMIG     1.3 Basic Data Structure
#> 1060   ADaMIG     1.3 Basic Data Structure
#> 1061   ADaMIG     1.3 Basic Data Structure
#> 1062   ADaMIG     1.3 Basic Data Structure
#> 1063   ADaMIG     1.3 Basic Data Structure
#> 1064   ADaMIG     1.3 Basic Data Structure
#> 1065   ADaMIG     1.3 Basic Data Structure
#> 1066   ADaMIG     1.3 Basic Data Structure
#> 1067   ADaMIG     1.3 Basic Data Structure
#> 1068   ADaMIG     1.3 Basic Data Structure
#> 1069   ADaMIG     1.3 Basic Data Structure
#> 1070   ADaMIG     1.3 Basic Data Structure
#> 1071   ADaMIG     1.3 Basic Data Structure
#> 1072   ADaMIG     1.3 Basic Data Structure
#> 1073   ADaMIG     1.3 Basic Data Structure
#> 1074   ADaMIG     1.3 Basic Data Structure
#> 1075   ADaMIG     1.3 Basic Data Structure
#> 1076   ADaMIG     1.3 Basic Data Structure
#> 1077   ADaMIG     1.3 Basic Data Structure
#> 1078   ADaMIG     1.3 Basic Data Structure
#> 1079   ADaMIG     1.3 Basic Data Structure
#> 1080   ADaMIG     1.3 Basic Data Structure
#> 1081   ADaMIG     1.3 Basic Data Structure
#> 1082   ADaMIG     1.3 Basic Data Structure
#> 1083   ADaMIG     1.3 Basic Data Structure
#> 1084   ADaMIG     1.3 Basic Data Structure
#> 1085   ADaMIG     1.3 Basic Data Structure
#> 1086   ADaMIG     1.3 Basic Data Structure
#> 1087   ADaMIG     1.3 Basic Data Structure
#> 1088   ADaMIG     1.3 Basic Data Structure
#> 1089   ADaMIG     1.3 Basic Data Structure
#> 1090   ADaMIG     1.3 Basic Data Structure
#> 1091   ADaMIG     1.3 Basic Data Structure
#> 1092   ADaMIG     1.3 Basic Data Structure
#> 1093   ADaMIG     1.3 Basic Data Structure
#> 1094   ADaMIG     1.3 Basic Data Structure
#> 1095   ADaMIG     1.3 Basic Data Structure
#> 1096   ADaMIG     1.3 Basic Data Structure
#> 1097   ADaMIG     1.3 Basic Data Structure
#> 1098   ADaMIG     1.3 Basic Data Structure
#> 1099   ADaMIG     1.3 Basic Data Structure
#> 1100   ADaMIG     1.3 Basic Data Structure
#> 1101   ADaMIG     1.3 Basic Data Structure
#> 1102   ADaMIG     1.3 Basic Data Structure
#> 1103   ADaMIG     1.3 Basic Data Structure
#> 1104   ADaMIG     1.3 Basic Data Structure
#> 1105   ADaMIG     1.3 Basic Data Structure
#> 1106   ADaMIG     1.3 Basic Data Structure
#> 1107   ADaMIG     1.3 Basic Data Structure
#> 1108   ADaMIG     1.3 Basic Data Structure
#> 1109   ADaMIG     1.3 Basic Data Structure
#> 1110   ADaMIG     1.3 Basic Data Structure
#> 1111   ADaMIG     1.3 Basic Data Structure
#> 1112   ADaMIG     1.3 Basic Data Structure
#> 1113   ADaMIG     1.3 Basic Data Structure
#> 1114   ADaMIG     1.3 Basic Data Structure
#> 1115   ADaMIG     1.3 Basic Data Structure
#> 1116   ADaMIG     1.3 Basic Data Structure
#> 1117   ADaMIG     1.3 Basic Data Structure
#> 1118   ADaMIG     1.3 Basic Data Structure
#> 1119   ADaMIG     1.3 Basic Data Structure
#> 1120   ADaMIG     1.3 Basic Data Structure
#> 1121   ADaMIG     1.3 Basic Data Structure
#> 1122   ADaMIG     1.3 Basic Data Structure
#> 1123   ADaMIG     1.3 Basic Data Structure
#> 1124   ADaMIG     1.3 Basic Data Structure
#> 1125   ADaMIG     1.3 Basic Data Structure
#> 1126   ADaMIG     1.3 Basic Data Structure
#> 1127   ADaMIG     1.3 Basic Data Structure
#> 1128   ADaMIG     1.3 Basic Data Structure
#> 1129   ADaMIG     1.3 Basic Data Structure
#> 1130   ADaMIG     1.3 Basic Data Structure
#> 1131   ADaMIG     1.3 Basic Data Structure
#> 1132   ADaMIG     1.3 Basic Data Structure
#> 1133   ADaMIG     1.3 Basic Data Structure
#> 1134   ADaMIG     1.3 Basic Data Structure
#> 1135   ADaMIG     1.3 Basic Data Structure
#> 1136   ADaMIG     1.3 Basic Data Structure
#> 1137   ADaMIG     1.3 Basic Data Structure
#> 1138   ADaMIG     1.3 Basic Data Structure
#> 1139   ADaMIG     1.3 Basic Data Structure
#> 1140   ADaMIG     1.3 Basic Data Structure
#> 1141   ADaMIG     1.3 Basic Data Structure
#> 1142   ADaMIG     1.3 Basic Data Structure
#> 1143   ADaMIG     1.3 Basic Data Structure
#> 1144   ADaMIG     1.3 Basic Data Structure
#> 1145   ADaMIG     1.3 Basic Data Structure
#> 1146   ADaMIG     1.3 Basic Data Structure
#> 1147   ADaMIG     1.3 Basic Data Structure
#> 1148   ADaMIG     1.3 Basic Data Structure
#> 1149   ADaMIG     1.3 Basic Data Structure
#> 1150   ADaMIG     1.3 Basic Data Structure
#> 1151   ADaMIG     1.3 Basic Data Structure
#> 1152   ADaMIG     1.3 Basic Data Structure
#> 1153   ADaMIG     1.3 Basic Data Structure
#> 1154   ADaMIG     1.3 Basic Data Structure
#> 1155   ADaMIG     1.3 Basic Data Structure
#> 1156   ADaMIG     1.3 Basic Data Structure
#> 1157   ADaMIG     1.3 Basic Data Structure
#> 1158   ADaMIG     1.3 Basic Data Structure
#> 1159   ADaMIG     1.3 Basic Data Structure
#> 1160   ADaMIG     1.3 Basic Data Structure
#> 1161   ADaMIG     1.3 Basic Data Structure
#> 1162   ADaMIG     1.3 Basic Data Structure
#> 1163   ADaMIG     1.3 Basic Data Structure
#> 1164   ADaMIG     1.3 Basic Data Structure
#> 1165   ADaMIG     1.3 Basic Data Structure
#> 1166   ADaMIG     1.3 Basic Data Structure
#> 1167   ADaMIG     1.3 Basic Data Structure
#> 1168   ADaMIG     1.3 Basic Data Structure
#> 1169   ADaMIG     1.3 Basic Data Structure
#> 1170   ADaMIG     1.3 Basic Data Structure
#> 1171   ADaMIG     1.3 Basic Data Structure
#> 1172   ADaMIG     1.3 Basic Data Structure
#> 1173   ADaMIG     1.3 Basic Data Structure
#> 1174   ADaMIG     1.3 Basic Data Structure
#> 1175   ADaMIG     1.3 Basic Data Structure
#> 1176   ADaMIG     1.3 Basic Data Structure
#> 1177   ADaMIG     1.3 Basic Data Structure
#> 1178   ADaMIG     1.3 Basic Data Structure
#> 1179   ADaMIG     1.3 Basic Data Structure
#> 1180   ADaMIG     1.3 Basic Data Structure
#> 1181   ADaMIG     1.3 Basic Data Structure
#> 1182   ADaMIG     1.3 Basic Data Structure
#> 1183   ADaMIG     1.3 Basic Data Structure
#> 1184   ADaMIG     1.3 Basic Data Structure
#> 1185   ADaMIG     1.3 Basic Data Structure
#> 1186   ADaMIG     1.3 Basic Data Structure
#> 1187   ADaMIG     1.3 Basic Data Structure
#>                                           variable_set order variable
#> 993                             Record-Level Treatment   142     TRTP
#> 994                             Record-Level Treatment   143    TRTPN
#> 995                             Record-Level Treatment   144     TRTA
#> 996                             Record-Level Treatment   145    TRTAN
#> 997                             Record-Level Treatment   146   TRTPGy
#> 998                             Record-Level Treatment   147  TRTPGyN
#> 999                             Record-Level Treatment   148   TRTAGy
#> 1000                            Record-Level Treatment   149  TRTAGyN
#> 1001                                 Record-Level Dose   150    DOSEP
#> 1002                                 Record-Level Dose   151  DOSCUMP
#> 1003                                 Record-Level Dose   152    DOSEA
#> 1004                                 Record-Level Dose   153  DOSCUMA
#> 1005                                 Record-Level Dose   154    DOSEU
#> 1006                                            Timing   155      ADT
#> 1007                                            Timing   156      ATM
#> 1008                                            Timing   157     ADTM
#> 1009                                            Timing   158      ADY
#> 1010                                            Timing   159     ADTF
#> 1011                                            Timing   160     ATMF
#> 1012                                            Timing   161    ASTDT
#> 1013                                            Timing   162    ASTTM
#> 1014                                            Timing   163   ASTDTM
#> 1015                                            Timing   164    ASTDY
#> 1016                                            Timing   165   ASTDTF
#> 1017                                            Timing   166   ASTTMF
#> 1018                                            Timing   167    AENDT
#> 1019                                            Timing   168    AENTM
#> 1020                                            Timing   169   AENDTM
#> 1021                                            Timing   170    AENDY
#> 1022                                            Timing   171   AENDTF
#> 1023                                            Timing   172   AENTMF
#> 1024                                            Timing   173   AVISIT
#> 1025                                            Timing   174  AVISITN
#> 1026                                            Timing   175     ATPT
#> 1027                                            Timing   176    ATPTN
#> 1028                                            Timing   177  ATPTREF
#> 1029                                            Timing   178   APHASE
#> 1030                                            Timing   179  APHASEN
#> 1031                                            Timing   180  APERIOD
#> 1032                                            Timing   181 APERIODC
#> 1033                                            Timing   182    ASPER
#> 1034                                            Timing   183   ASPERC
#> 1035                                            Timing   184   ARELTM
#> 1036                                            Timing   185  ARELTMU
#> 1037 Period, Subperiod, and Phase Start and End Timing   186  APERSDT
#> 1038 Period, Subperiod, and Phase Start and End Timing   187  APERSTM
#> 1039 Period, Subperiod, and Phase Start and End Timing   188 APERSDTM
#> 1040 Period, Subperiod, and Phase Start and End Timing   189 APERSDTF
#> 1041 Period, Subperiod, and Phase Start and End Timing   190 APERSTMF
#> 1042 Period, Subperiod, and Phase Start and End Timing   191  APEREDT
#> 1043 Period, Subperiod, and Phase Start and End Timing   192  APERETM
#> 1044 Period, Subperiod, and Phase Start and End Timing   193 APEREDTM
#> 1045 Period, Subperiod, and Phase Start and End Timing   194 APEREDTF
#> 1046 Period, Subperiod, and Phase Start and End Timing   195 APERETMF
#> 1047 Period, Subperiod, and Phase Start and End Timing   196  ASPRSDT
#> 1048 Period, Subperiod, and Phase Start and End Timing   197  ASPRSTM
#> 1049 Period, Subperiod, and Phase Start and End Timing   198 ASPRSDTM
#> 1050 Period, Subperiod, and Phase Start and End Timing   199 ASPRSDTF
#> 1051 Period, Subperiod, and Phase Start and End Timing   200 ASPRSTMF
#> 1052 Period, Subperiod, and Phase Start and End Timing   201  ASPREDT
#> 1053 Period, Subperiod, and Phase Start and End Timing   202  ASPRETM
#> 1054 Period, Subperiod, and Phase Start and End Timing   203 ASPREDTM
#> 1055 Period, Subperiod, and Phase Start and End Timing   204 ASPREDTF
#> 1056 Period, Subperiod, and Phase Start and End Timing   205 ASPRETMF
#> 1057 Period, Subperiod, and Phase Start and End Timing   206    PHSDT
#> 1058 Period, Subperiod, and Phase Start and End Timing   207    PHSTM
#> 1059 Period, Subperiod, and Phase Start and End Timing   208   PHSDTM
#> 1060 Period, Subperiod, and Phase Start and End Timing   209   PHSDTF
#> 1061 Period, Subperiod, and Phase Start and End Timing   210   PHSTMF
#> 1062 Period, Subperiod, and Phase Start and End Timing   211    PHEDT
#> 1063 Period, Subperiod, and Phase Start and End Timing   212    PHETM
#> 1064 Period, Subperiod, and Phase Start and End Timing   213   PHEDTM
#> 1065 Period, Subperiod, and Phase Start and End Timing   214   PHEDTF
#> 1066 Period, Subperiod, and Phase Start and End Timing   215   PHETMF
#> 1067                  Suffixes for User-Defined Timing   216      *DT
#> 1068                  Suffixes for User-Defined Timing   217      *TM
#> 1069                  Suffixes for User-Defined Timing   218     *DTM
#> 1070                  Suffixes for User-Defined Timing   219     *ADY
#> 1071                  Suffixes for User-Defined Timing   220     *DTF
#> 1072                  Suffixes for User-Defined Timing   221     *TMF
#> 1073                  Suffixes for User-Defined Timing   222     *SDT
#> 1074                  Suffixes for User-Defined Timing   223     *STM
#> 1075                  Suffixes for User-Defined Timing   224    *SDTM
#> 1076                  Suffixes for User-Defined Timing   225     *SDY
#> 1077                  Suffixes for User-Defined Timing   226    *SDTF
#> 1078                  Suffixes for User-Defined Timing   227    *STMF
#> 1079                  Suffixes for User-Defined Timing   228     *EDT
#> 1080                  Suffixes for User-Defined Timing   229     *ETM
#> 1081                  Suffixes for User-Defined Timing   230    *EDTM
#> 1082                  Suffixes for User-Defined Timing   231     *EDY
#> 1083                  Suffixes for User-Defined Timing   232    *EDTF
#> 1084                  Suffixes for User-Defined Timing   233    *ETMF
#> 1085                                Analysis Parameter   234    PARAM
#> 1086                                Analysis Parameter   235  PARAMCD
#> 1087                                Analysis Parameter   236   PARAMN
#> 1088                                Analysis Parameter   237  PARCATy
#> 1089                                Analysis Parameter   238 PARCATyN
#> 1090                                Analysis Parameter   239     AVAL
#> 1091                                Analysis Parameter   240    AVALC
#> 1092                                Analysis Parameter   241 AVALCATy
#> 1093                                Analysis Parameter   242 AVALCAyN
#> 1094                                Analysis Parameter   243     BASE
#> 1095                                Analysis Parameter   244    BASEC
#> 1096                                Analysis Parameter   245 BASECATy
#> 1097                                Analysis Parameter   246 BASECAyN
#> 1098                                Analysis Parameter   247 BASETYPE
#> 1099                                Analysis Parameter   248      CHG
#> 1100                                Analysis Parameter   249  CHGCATy
#> 1101                                Analysis Parameter   250 CHGCATyN
#> 1102                                Analysis Parameter   251     PCHG
#> 1103                                Analysis Parameter   252 PCHGCATy
#> 1104                                Analysis Parameter   253 PCHGCAyN
#> 1105                                Analysis Parameter   254   R2BASE
#> 1106                                Analysis Parameter   255   R2AyLO
#> 1107                                Analysis Parameter   256   R2AyHI
#> 1108                                Analysis Parameter   257   SHIFTy
#> 1109                                Analysis Parameter   258  SHIFTyN
#> 1110                                Analysis Parameter   259     BCHG
#> 1111                                Analysis Parameter   260 BCHGCATy
#> 1112                                Analysis Parameter   261 BCHGCAyN
#> 1113                                Analysis Parameter   262    PBCHG
#> 1114                                Analysis Parameter   263 PBCHGCAy
#> 1115                                Analysis Parameter   264 PBCHGCyN
#> 1116                       Analysis Parameter Criteria   265    CRITy
#> 1117                       Analysis Parameter Criteria   266  CRITyFL
#> 1118                       Analysis Parameter Criteria   267  CRITyFN
#> 1119                       Analysis Parameter Criteria   268   MCRITy
#> 1120                       Analysis Parameter Criteria   269 MCRITyML
#> 1121                       Analysis Parameter Criteria   270 MCRITyMN
#> 1122                               Analysis Descriptor   271    DTYPE
#> 1123                          Analysis Visit Windowing   272  AWRANGE
#> 1124                          Analysis Visit Windowing   273 AWTARGET
#> 1125                          Analysis Visit Windowing   274  AWTDIFF
#> 1126                          Analysis Visit Windowing   275     AWLO
#> 1127                          Analysis Visit Windowing   276     AWHI
#> 1128                          Analysis Visit Windowing   277      AWU
#> 1129                                     Time-to-Event   278  STARTDT
#> 1130                                     Time-to-Event   279 STARTDTM
#> 1131                                     Time-to-Event   280 STARTDTF
#> 1132                                     Time-to-Event   281 STARTTMF
#> 1133                                     Time-to-Event   282     CNSR
#> 1134                                     Time-to-Event   283 EVNTDESC
#> 1135                                     Time-to-Event   284 CNSDTDSC
#> 1136                                Toxicity and Range   285   ATOXGR
#> 1137                                Toxicity and Range   286  ATOXGRN
#> 1138                                Toxicity and Range   287   BTOXGR
#> 1139                                Toxicity and Range   288  BTOXGRN
#> 1140                                Toxicity and Range   289   ANRIND
#> 1141                                Toxicity and Range   290   BNRIND
#> 1142                                Toxicity and Range   291    ANRLO
#> 1143                                Toxicity and Range   292   ANRLOC
#> 1144                                Toxicity and Range   293    ANRHI
#> 1145                                Toxicity and Range   294   ANRHIC
#> 1146                                Toxicity and Range   295     AyLO
#> 1147                                Toxicity and Range   296    AyLOC
#> 1148                                Toxicity and Range   297     AyHI
#> 1149                                Toxicity and Range   298    AyHIC
#> 1150                                Toxicity and Range   299    AyIND
#> 1151                                Toxicity and Range   300    ByIND
#> 1152                                Toxicity and Range   301  ATOXGRL
#> 1153                                Toxicity and Range   302 ATOXGRLN
#> 1154                                Toxicity and Range   303  ATOXGRH
#> 1155                                Toxicity and Range   304 ATOXGRHN
#> 1156                                Toxicity and Range   305  BTOXGRL
#> 1157                                Toxicity and Range   306 BTOXGRLN
#> 1158                                Toxicity and Range   307  BTOXGRH
#> 1159                                Toxicity and Range   308 BTOXGRHN
#> 1160                                Toxicity and Range   309 ATOXDSCL
#> 1161                                Toxicity and Range   310 ATOXDSCH
#> 1162                                              Flag   311    ABLFL
#> 1163                                              Flag   312    ABLFN
#> 1164                                              Flag   313  ANLzzFL
#> 1165                                              Flag   314  ANLzzFN
#> 1166                                              Flag   315  ONTRTFL
#> 1167                                              Flag   316  ONTRTFN
#> 1168                                              Flag   317   LVOTFL
#> 1169                                              Flag   318   LVOTFN
#> 1170                             Population Indicators   319   ITTRFL
#> 1171                             Population Indicators   320   SAFRFL
#> 1172                             Population Indicators   321   FASRFL
#> 1173                             Population Indicators   322 PPROTRFL
#> 1174                             Population Indicators   323 COMPLRFL
#> 1175                             Population Indicators   324   ITTPFL
#> 1176                             Population Indicators   325   SAFPFL
#> 1177                             Population Indicators   326   FASPFL
#> 1178                             Population Indicators   327 PPROTPFL
#> 1179                             Population Indicators   328 COMPLPFL
#> 1180                            Datapoint Traceability   329   SRCDOM
#> 1181                            Datapoint Traceability   330   SRCVAR
#> 1182                            Datapoint Traceability   331   SRCSEQ
#> 1183                                        Identifier   332  STUDYID
#> 1184                                        Identifier   333  USUBJID
#> 1185                                        Identifier   334   SUBJID
#> 1186                                        Identifier   335   SITEID
#> 1187                                        Identifier   336     ASEQ
#>                                          label type core codelist_code
#> 993                          Planned Treatment Char Cond          <NA>
#> 994                      Planned Treatment (N)  Num Perm          <NA>
#> 995                           Actual Treatment Char Cond          <NA>
#> 996                       Actual Treatment (N)  Num Perm          <NA>
#> 997                 Planned Pooled Treatment y Char Perm          <NA>
#> 998             Planned Pooled Treatment y (N)  Num Perm          <NA>
#> 999                  Actual Pooled Treatment y Char Cond          <NA>
#> 1000             Actual Pooled Treatment y (N)  Num Perm          <NA>
#> 1001                    Planned Treatment Dose  Num Perm          <NA>
#> 1002         Cumulative Planned Treatment Dose  Num Perm          <NA>
#> 1003                     Actual Treatment Dose  Num Perm          <NA>
#> 1004          Cumulative Actual Treatment Dose  Num Perm          <NA>
#> 1005                      Treatment Dose Units Char Perm          <NA>
#> 1006                             Analysis Date  Num Cond          <NA>
#> 1007                             Analysis Time  Num Cond          <NA>
#> 1008                         Analysis Datetime  Num Cond          <NA>
#> 1009                     Analysis Relative Day  Num Cond          <NA>
#> 1010             Analysis Date Imputation Flag Char Cond        C81223
#> 1011             Analysis Time Imputation Flag Char Cond        C81226
#> 1012                       Analysis Start Date  Num Cond          <NA>
#> 1013                       Analysis Start Time  Num Cond          <NA>
#> 1014                   Analysis Start Datetime  Num Cond          <NA>
#> 1015               Analysis Start Relative Day  Num Cond          <NA>
#> 1016       Analysis Start Date Imputation Flag Char Cond        C81223
#> 1017       Analysis Start Time Imputation Flag Char Cond        C81226
#> 1018                         Analysis End Date  Num Cond          <NA>
#> 1019                         Analysis End Time  Num Cond          <NA>
#> 1020                     Analysis End Datetime  Num Cond          <NA>
#> 1021                 Analysis End Relative Day  Num Cond          <NA>
#> 1022         Analysis End Date Imputation Flag Char Cond        C81223
#> 1023         Analysis End Time Imputation Flag Char Cond        C81226
#> 1024                            Analysis Visit Char Cond          <NA>
#> 1025                        Analysis Visit (N)  Num Perm          <NA>
#> 1026                        Analysis Timepoint Char Cond          <NA>
#> 1027                    Analysis Timepoint (N)  Num Perm          <NA>
#> 1028              Analysis Timepoint Reference Char Perm          <NA>
#> 1029                                     Phase Char Perm          <NA>
#> 1030                                 Phase (N)  Num Perm          <NA>
#> 1031                                    Period  Num Cond          <NA>
#> 1032                                Period (C) Char Perm          <NA>
#> 1033                   Subperiod within Period  Num Perm          <NA>
#> 1034               Subperiod within Period (C) Char Perm          <NA>
#> 1035                    Analysis Relative Time  Num Perm          <NA>
#> 1036               Analysis Relative Time Unit Char Perm          <NA>
#> 1037                         Period Start Date  Num Perm          <NA>
#> 1038                         Period Start Time  Num Perm          <NA>
#> 1039                     Period Start Datetime  Num Perm          <NA>
#> 1040             Period Start Date Imput. Flag Char Cond        C81223
#> 1041             Period Start Time Imput. Flag Char Cond        C81226
#> 1042                           Period End Date  Num Perm          <NA>
#> 1043                           Period End Time  Num Perm          <NA>
#> 1044                       Period End Datetime  Num Perm          <NA>
#> 1045               Period End Date Imput. Flag Char Cond        C81223
#> 1046               Period End Time Imput. Flag Char Cond        C81226
#> 1047                      Subperiod Start Date  Num Perm          <NA>
#> 1048                      Subperiod Start Time  Num Perm          <NA>
#> 1049                  Subperiod Start Datetime  Num Perm          <NA>
#> 1050          Subperiod Start Date Imput. Flag Char Cond        C81223
#> 1051          Subperiod Start Time Imput. Flag Char Cond        C81226
#> 1052                        Subperiod End Date  Num Perm          <NA>
#> 1053                        Subperiod End Time  Num Perm          <NA>
#> 1054                    Subperiod End Datetime  Num Perm          <NA>
#> 1055            Subperiod End Date Imput. Flag Char Cond        C81223
#> 1056            Subperiod End Time Imput. Flag Char Cond        C81226
#> 1057                          Phase Start Date  Num Perm          <NA>
#> 1058                          Phase Start Time  Num Perm          <NA>
#> 1059                      Phase Start Datetime  Num Perm          <NA>
#> 1060              Phase Start Date Imput. Flag Char Cond        C81223
#> 1061              Phase Start Time Imput. Flag Char Cond        C81226
#> 1062                            Phase End Date  Num Perm          <NA>
#> 1063                            Phase End Time  Num Perm          <NA>
#> 1064                        Phase End Datetime  Num Perm          <NA>
#> 1065                Phase End Date Imput. Flag Char Cond        C81223
#> 1066                Phase End Time Imput. Flag Char Cond        C81226
#> 1067                                    {Date}  Num Perm          <NA>
#> 1068                                    {Time}  Num Perm          <NA>
#> 1069                                {Datetime}  Num Perm          <NA>
#> 1070                            {Relative Day}  Num Perm          <NA>
#> 1071                    {Date Imputation Flag} Char Cond        C81223
#> 1072                    {Time Imputation Flag} Char Cond        C81226
#> 1073                              {Start Date}  Num Perm          <NA>
#> 1074                              {Start Time}  Num Perm          <NA>
#> 1075                          {Start Datetime}  Num Perm          <NA>
#> 1076                      {Relative Start Day}  Num Perm          <NA>
#> 1077              {Start Date Imputation Flag} Char Cond        C81223
#> 1078              {Start Time Imputation Flag} Char Cond        C81226
#> 1079                                {End Date}  Num Perm          <NA>
#> 1080                                {End Time}  Num Perm          <NA>
#> 1081                            {End Datetime}  Num Perm          <NA>
#> 1082                        {Relative End Day}  Num Perm          <NA>
#> 1083                {End Date Imputation Flag} Char Cond        C81223
#> 1084                {End Time Imputation Flag} Char Cond        C81226
#> 1085                                 Parameter Char  Req          <NA>
#> 1086                            Parameter Code Char  Req          <NA>
#> 1087                             Parameter (N)  Num Perm          <NA>
#> 1088                      Parameter Category y Char Perm          <NA>
#> 1089                  Parameter Category y (N)  Num Perm          <NA>
#> 1090                            Analysis Value  Num Cond          <NA>
#> 1091                        Analysis Value (C) Char Cond          <NA>
#> 1092                 Analysis Value Category y Char Perm          <NA>
#> 1093             Analysis Value Category y (N)  Num Perm          <NA>
#> 1094                            Baseline Value  Num Cond          <NA>
#> 1095                        Baseline Value (C) Char Perm          <NA>
#> 1096                       Baseline Category y Char Perm          <NA>
#> 1097                   Baseline Category y (N)  Num Perm          <NA>
#> 1098                             Baseline Type Char Cond          <NA>
#> 1099                      Change from Baseline  Num Perm          <NA>
#> 1100           Change from Baseline Category y Char Perm          <NA>
#> 1101       Change from Baseline Category y (N)  Num Perm          <NA>
#> 1102              Percent Change from Baseline  Num Perm          <NA>
#> 1103      Percent Chg from Baseline Category y Char Perm          <NA>
#> 1104  Percent Chg from Baseline Category y (N)  Num Perm          <NA>
#> 1105                         Ratio to Baseline  Num Perm          <NA>
#> 1106     Ratio to Analysis Range y Lower Limit  Num Perm          <NA>
#> 1107     Ratio to Analysis Range y Upper Limit  Num Perm          <NA>
#> 1108                                   Shift y Char Perm          <NA>
#> 1109                               Shift y (N)  Num Perm          <NA>
#> 1110                        Change to Baseline  Num Perm          <NA>
#> 1111             Change to Baseline Category y Char Perm          <NA>
#> 1112         Change to Baseline Category y (N)  Num Perm          <NA>
#> 1113                Percent Change to Baseline  Num Perm          <NA>
#> 1114     Percent Change to Baseline Category y Char Perm          <NA>
#> 1115 Percent Change to Baseline Category y (N)  Num Perm          <NA>
#> 1116                      Analysis Criterion y Char Perm          <NA>
#> 1117        Criterion y Evaluation Result Flag Char Cond          <NA>
#> 1118    Criterion y Evaluation Result Flag (N)  Num Perm          <NA>
#> 1119       Analysis Multi-Response Criterion y Char Perm          <NA>
#> 1120     Multi-Response Criterion y Evaluation Char Cond          <NA>
#> 1121       Multi-Response Criterion y Eval (N)  Num Perm          <NA>
#> 1122                           Derivation Type Char Cond        C81224
#> 1123      Analysis Window Valid Relative Range Char Perm          <NA>
#> 1124                    Analysis Window Target  Num Perm          <NA>
#> 1125          Analysis Window Diff from Target  Num Perm          <NA>
#> 1126       Analysis Window Beginning Timepoint  Num Perm          <NA>
#> 1127          Analysis Window Ending Timepoint  Num Perm          <NA>
#> 1128                      Analysis Window Unit Char Perm          <NA>
#> 1129     Time-to-Event Origin Date for Subject  Num Perm          <NA>
#> 1130             Time-to-Event Origin Datetime  Num Perm          <NA>
#> 1131               Origin Date Imputation Flag Char Cond        C81223
#> 1132               Origin Time Imputation Flag Char Cond        C81226
#> 1133                                    Censor  Num Cond          <NA>
#> 1134            Event or Censoring Description Char Perm          <NA>
#> 1135                   Censor Date Description Char Perm          <NA>
#> 1136                   Analysis Toxicity Grade Char Perm          <NA>
#> 1137               Analysis Toxicity Grade (N)  Num Perm          <NA>
#> 1138                   Baseline Toxicity Grade Char Perm          <NA>
#> 1139               Baseline Toxicity Grade (N)  Num Perm          <NA>
#> 1140        Analysis Reference Range Indicator Char Perm          <NA>
#> 1141        Baseline Reference Range Indicator Char Perm          <NA>
#> 1142         Analysis Normal Range Lower Limit  Num Perm          <NA>
#> 1143     Analysis Normal Range Lower Limit (C) Char Perm          <NA>
#> 1144         Analysis Normal Range Upper Limit  Num Perm          <NA>
#> 1145     Analysis Normal Range Upper Limit (C) Char Perm          <NA>
#> 1146              Analysis Range y Lower Limit  Num Cond          <NA>
#> 1147          Analysis Range y Lower Limit (C) Char Perm          <NA>
#> 1148              Analysis Range y Upper Limit  Num Cond          <NA>
#> 1149          Analysis Range y Upper Limit (C) Char Perm          <NA>
#> 1150                Analysis Range y Indicator Char Perm          <NA>
#> 1151       Baseline Analysis Range y Indicator Char Perm          <NA>
#> 1152               Analysis Toxicity Grade Low Char Perm          <NA>
#> 1153           Analysis Toxicity Grade Low (N)  Num Perm          <NA>
#> 1154              Analysis Toxicity Grade High Char Perm          <NA>
#> 1155          Analysis Toxicity Grade High (N)  Num Perm          <NA>
#> 1156               Baseline Toxicity Grade Low Char Perm          <NA>
#> 1157           Baseline Toxicity Grade Low (N)  Num Perm          <NA>
#> 1158              Baseline Toxicity Grade High Char Perm          <NA>
#> 1159          Baseline Toxicity Grade High (N)  Num Perm          <NA>
#> 1160         Analysis Toxicity Description Low Char Perm          <NA>
#> 1161        Analysis Toxicity Description High Char Perm          <NA>
#> 1162                      Baseline Record Flag Char Cond          <NA>
#> 1163                  Baseline Record Flag (N)  Num Perm          <NA>
#> 1164                          Analysis Flag zz Char Cond          <NA>
#> 1165                      Analysis Flag zz (N)  Num Perm          <NA>
#> 1166                  On Treatment Record Flag Char Perm          <NA>
#> 1167              On Treatment Record Flag (N)  Num Perm          <NA>
#> 1168       Last Value On Treatment Record Flag Char Perm          <NA>
#> 1169   Last Value On Treatment Record Flag (N)  Num Perm          <NA>
#> 1170         Intent-To-Treat Record-Level Flag Char Perm          <NA>
#> 1171         Safety Analysis Record-Level Flag Char Perm          <NA>
#> 1172       Full Analysis Set Record-Level Flag Char Perm          <NA>
#> 1173            Per-Protocol Record-Level Flag Char Perm          <NA>
#> 1174              Completers Record-Level Flag Char Perm          <NA>
#> 1175      Intent-To-Treat Parameter-Level Flag Char Perm          <NA>
#> 1176      Safety Analysis Parameter-Level Flag Char Perm          <NA>
#> 1177    Full Analysis Set Parameter-Level Flag Char Perm          <NA>
#> 1178         Per-Protocol Parameter-Level Flag Char Perm          <NA>
#> 1179           Completers Parameter-Level Flag Char Perm          <NA>
#> 1180                               Source Data Char Perm          <NA>
#> 1181                           Source Variable Char Perm          <NA>
#> 1182                    Source Sequence Number  Num Perm          <NA>
#> 1183                          Study Identifier Char  Req          <NA>
#> 1184                 Unique Subject Identifier Char  Req          <NA>
#> 1185          Subject Identifier for the Study Char Perm          <NA>
#> 1186                     Study Site Identifier Char Perm          <NA>
#> 1187                  Analysis Sequence Number  Num Perm          <NA>
#>      codelist_submission_values described_value_domain value_list
#> 993                        <NA>                   <NA>       <NA>
#> 994                        <NA>                   <NA>       <NA>
#> 995                        <NA>                   <NA>       <NA>
#> 996                        <NA>                   <NA>       <NA>
#> 997                        <NA>                   <NA>       <NA>
#> 998                        <NA>                   <NA>       <NA>
#> 999                        <NA>                   <NA>       <NA>
#> 1000                       <NA>                   <NA>       <NA>
#> 1001                       <NA>                   <NA>       <NA>
#> 1002                       <NA>                   <NA>       <NA>
#> 1003                       <NA>                   <NA>       <NA>
#> 1004                       <NA>                   <NA>       <NA>
#> 1005                       <NA>                   <NA>       <NA>
#> 1006                       <NA>                   <NA>       <NA>
#> 1007                       <NA>                   <NA>       <NA>
#> 1008                       <NA>                   <NA>       <NA>
#> 1009                       <NA>                   <NA>       <NA>
#> 1010                     DATEFL                   <NA>       <NA>
#> 1011                     TIMEFL                   <NA>       <NA>
#> 1012                       <NA>                   <NA>       <NA>
#> 1013                       <NA>                   <NA>       <NA>
#> 1014                       <NA>                   <NA>       <NA>
#> 1015                       <NA>                   <NA>       <NA>
#> 1016                     DATEFL                   <NA>       <NA>
#> 1017                     TIMEFL                   <NA>       <NA>
#> 1018                       <NA>                   <NA>       <NA>
#> 1019                       <NA>                   <NA>       <NA>
#> 1020                       <NA>                   <NA>       <NA>
#> 1021                       <NA>                   <NA>       <NA>
#> 1022                     DATEFL                   <NA>       <NA>
#> 1023                     TIMEFL                   <NA>       <NA>
#> 1024                       <NA>                   <NA>       <NA>
#> 1025                       <NA>                   <NA>       <NA>
#> 1026                       <NA>                   <NA>       <NA>
#> 1027                       <NA>                   <NA>       <NA>
#> 1028                       <NA>                   <NA>       <NA>
#> 1029                       <NA>                   <NA>       <NA>
#> 1030                       <NA>                   <NA>       <NA>
#> 1031                       <NA>                   <NA>       <NA>
#> 1032                       <NA>                   <NA>       <NA>
#> 1033                       <NA>                   <NA>       <NA>
#> 1034                       <NA>                   <NA>       <NA>
#> 1035                       <NA>                   <NA>       <NA>
#> 1036                       <NA>                   <NA>       <NA>
#> 1037                       <NA>                   <NA>       <NA>
#> 1038                       <NA>                   <NA>       <NA>
#> 1039                       <NA>                   <NA>       <NA>
#> 1040                     DATEFL                   <NA>       <NA>
#> 1041                     TIMEFL                   <NA>       <NA>
#> 1042                       <NA>                   <NA>       <NA>
#> 1043                       <NA>                   <NA>       <NA>
#> 1044                       <NA>                   <NA>       <NA>
#> 1045                     DATEFL                   <NA>       <NA>
#> 1046                     TIMEFL                   <NA>       <NA>
#> 1047                       <NA>                   <NA>       <NA>
#> 1048                       <NA>                   <NA>       <NA>
#> 1049                       <NA>                   <NA>       <NA>
#> 1050                     DATEFL                   <NA>       <NA>
#> 1051                     TIMEFL                   <NA>       <NA>
#> 1052                       <NA>                   <NA>       <NA>
#> 1053                       <NA>                   <NA>       <NA>
#> 1054                       <NA>                   <NA>       <NA>
#> 1055                     DATEFL                   <NA>       <NA>
#> 1056                     TIMEFL                   <NA>       <NA>
#> 1057                       <NA>                   <NA>       <NA>
#> 1058                       <NA>                   <NA>       <NA>
#> 1059                       <NA>                   <NA>       <NA>
#> 1060                     DATEFL                   <NA>       <NA>
#> 1061                     TIMEFL                   <NA>       <NA>
#> 1062                       <NA>                   <NA>       <NA>
#> 1063                       <NA>                   <NA>       <NA>
#> 1064                       <NA>                   <NA>       <NA>
#> 1065                     DATEFL                   <NA>       <NA>
#> 1066                     TIMEFL                   <NA>       <NA>
#> 1067                       <NA>                   <NA>       <NA>
#> 1068                       <NA>                   <NA>       <NA>
#> 1069                       <NA>                   <NA>       <NA>
#> 1070                       <NA>                   <NA>       <NA>
#> 1071                     DATEFL                   <NA>       <NA>
#> 1072                     TIMEFL                   <NA>       <NA>
#> 1073                       <NA>                   <NA>       <NA>
#> 1074                       <NA>                   <NA>       <NA>
#> 1075                       <NA>                   <NA>       <NA>
#> 1076                       <NA>                   <NA>       <NA>
#> 1077                     DATEFL                   <NA>       <NA>
#> 1078                     TIMEFL                   <NA>       <NA>
#> 1079                       <NA>                   <NA>       <NA>
#> 1080                       <NA>                   <NA>       <NA>
#> 1081                       <NA>                   <NA>       <NA>
#> 1082                       <NA>                   <NA>       <NA>
#> 1083                     DATEFL                   <NA>       <NA>
#> 1084                     TIMEFL                   <NA>       <NA>
#> 1085                       <NA>                   <NA>       <NA>
#> 1086                       <NA>                   <NA>       <NA>
#> 1087                       <NA>                   <NA>       <NA>
#> 1088                       <NA>                   <NA>       <NA>
#> 1089                       <NA>                   <NA>       <NA>
#> 1090                       <NA>                   <NA>       <NA>
#> 1091                       <NA>                   <NA>       <NA>
#> 1092                       <NA>                   <NA>       <NA>
#> 1093                       <NA>                   <NA>       <NA>
#> 1094                       <NA>                   <NA>       <NA>
#> 1095                       <NA>                   <NA>       <NA>
#> 1096                       <NA>                   <NA>       <NA>
#> 1097                       <NA>                   <NA>       <NA>
#> 1098                       <NA>                   <NA>       <NA>
#> 1099                       <NA>                   <NA>       <NA>
#> 1100                       <NA>                   <NA>       <NA>
#> 1101                       <NA>                   <NA>       <NA>
#> 1102                       <NA>                   <NA>       <NA>
#> 1103                       <NA>                   <NA>       <NA>
#> 1104                       <NA>                   <NA>       <NA>
#> 1105                       <NA>                   <NA>       <NA>
#> 1106                       <NA>                   <NA>       <NA>
#> 1107                       <NA>                   <NA>       <NA>
#> 1108                       <NA>                   <NA>       <NA>
#> 1109                       <NA>                   <NA>       <NA>
#> 1110                       <NA>                   <NA>       <NA>
#> 1111                       <NA>                   <NA>       <NA>
#> 1112                       <NA>                   <NA>       <NA>
#> 1113                       <NA>                   <NA>       <NA>
#> 1114                       <NA>                   <NA>       <NA>
#> 1115                       <NA>                   <NA>       <NA>
#> 1116                       <NA>                   <NA>       <NA>
#> 1117                       <NA>                   <NA>       Y; N
#> 1118                       <NA>                   <NA>       1; 0
#> 1119                       <NA>                   <NA>       <NA>
#> 1120                       <NA>                   <NA>       <NA>
#> 1121                       <NA>                   <NA>       <NA>
#> 1122                      DTYPE                   <NA>       <NA>
#> 1123                       <NA>                   <NA>       <NA>
#> 1124                       <NA>                   <NA>       <NA>
#> 1125                       <NA>                   <NA>       <NA>
#> 1126                       <NA>                   <NA>       <NA>
#> 1127                       <NA>                   <NA>       <NA>
#> 1128                       <NA>                   <NA>       <NA>
#> 1129                       <NA>                   <NA>       <NA>
#> 1130                       <NA>                   <NA>       <NA>
#> 1131                     DATEFL                   <NA>       <NA>
#> 1132                     TIMEFL                   <NA>       <NA>
#> 1133                       <NA>                   <NA>       <NA>
#> 1134                       <NA>                   <NA>       <NA>
#> 1135                       <NA>                   <NA>       <NA>
#> 1136                       <NA>                   <NA>       <NA>
#> 1137                       <NA>                   <NA>       <NA>
#> 1138                       <NA>                   <NA>       <NA>
#> 1139                       <NA>                   <NA>       <NA>
#> 1140                       <NA>                   <NA>       <NA>
#> 1141                       <NA>                   <NA>       <NA>
#> 1142                       <NA>                   <NA>       <NA>
#> 1143                       <NA>                   <NA>       <NA>
#> 1144                       <NA>                   <NA>       <NA>
#> 1145                       <NA>                   <NA>       <NA>
#> 1146                       <NA>                   <NA>       <NA>
#> 1147                       <NA>                   <NA>       <NA>
#> 1148                       <NA>                   <NA>       <NA>
#> 1149                       <NA>                   <NA>       <NA>
#> 1150                       <NA>                   <NA>       <NA>
#> 1151                       <NA>                   <NA>       <NA>
#> 1152                       <NA>                   <NA>       <NA>
#> 1153                       <NA>                   <NA>       <NA>
#> 1154                       <NA>                   <NA>       <NA>
#> 1155                       <NA>                   <NA>       <NA>
#> 1156                       <NA>                   <NA>       <NA>
#> 1157                       <NA>                   <NA>       <NA>
#> 1158                       <NA>                   <NA>       <NA>
#> 1159                       <NA>                   <NA>       <NA>
#> 1160                       <NA>                   <NA>       <NA>
#> 1161                       <NA>                   <NA>       <NA>
#> 1162                       <NA>                   <NA>          Y
#> 1163                       <NA>                   <NA>          1
#> 1164                       <NA>                   <NA>          Y
#> 1165                       <NA>                   <NA>          1
#> 1166                       <NA>                   <NA>          Y
#> 1167                       <NA>                   <NA>          1
#> 1168                       <NA>                   <NA>          Y
#> 1169                       <NA>                   <NA>          1
#> 1170                       <NA>                   <NA>          Y
#> 1171                       <NA>                   <NA>          Y
#> 1172                       <NA>                   <NA>          Y
#> 1173                       <NA>                   <NA>          Y
#> 1174                       <NA>                   <NA>          Y
#> 1175                       <NA>                   <NA>          Y
#> 1176                       <NA>                   <NA>          Y
#> 1177                       <NA>                   <NA>          Y
#> 1178                       <NA>                   <NA>          Y
#> 1179                       <NA>                   <NA>          Y
#> 1180                       <NA>                   <NA>       <NA>
#> 1181                       <NA>                   <NA>       <NA>
#> 1182                       <NA>                   <NA>       <NA>
#> 1183                       <NA>                   <NA>       <NA>
#> 1184                       <NA>                   <NA>       <NA>
#> 1185                       <NA>                   <NA>       <NA>
#> 1186                       <NA>                   <NA>       <NA>
#> 1187                       <NA>                   <NA>       <NA>
get_ig("ADaMIG-NCA")
#>        standard version                                       structure
#> 1213 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1214 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1215 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1216 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1217 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1218 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1219 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1220 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1221 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1222 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1223 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1224 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1225 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1226 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1227 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1228 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1229 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1230 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1231 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1232 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1233 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1234 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1235 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1236 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1237 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1238 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1239 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1240 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1241 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1242 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1243 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1244 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1245 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1246 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1247 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1248 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1249 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1250 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1251 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1252 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1253 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1254 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1255 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1256 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1257 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1258 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1259 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1260 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1261 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1262 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1263 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1264 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1265 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1266 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1267 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1268 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1269 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1270 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#> 1271 ADaMIG-NCA     1.0 Basic Data Structure Non-Compartmental Analysis
#>                                                    variable_set order variable
#> 1213                    New Standard Non-Compartmental Analysis     1   NCAXFL
#> 1214                    New Standard Non-Compartmental Analysis     2   NCAXFN
#> 1215                    New Standard Non-Compartmental Analysis     3  NCAwXRS
#> 1216                    New Standard Non-Compartmental Analysis     4 NCAwXRSN
#> 1217                    New Standard Non-Compartmental Analysis     5  PKSUMXF
#> 1218                    New Standard Non-Compartmental Analysis     6 PKSUMXFN
#> 1219                    New Standard Non-Compartmental Analysis     7  METABFL
#> 1220                    New Standard Non-Compartmental Analysis     8   COHORT
#> 1221                    New Standard Non-Compartmental Analysis     9  COHORTN
#> 1222                    New Standard Non-Compartmental Analysis    10    ROUTE
#> 1223                    New Standard Non-Compartmental Analysis    11  TRTRINT
#> 1224                    New Standard Non-Compartmental Analysis    12 TRTRINTU
#> 1225                    New Standard Non-Compartmental Analysis    13 DOSPCTDF
#> 1226                    New Standard Non-Compartmental Analysis    14  DOSEFRQ
#> 1227                    New Standard Non-Compartmental Analysis    15   ACYCLE
#> 1228                    New Standard Non-Compartmental Analysis    16  ACYCLEC
#> 1229                    New Standard Non-Compartmental Analysis    17   FANLDT
#> 1230                    New Standard Non-Compartmental Analysis    18   FANLTM
#> 1231                    New Standard Non-Compartmental Analysis    19  FANLDTM
#> 1232                    New Standard Non-Compartmental Analysis    20  FANLEDT
#> 1233                    New Standard Non-Compartmental Analysis    21  FANLETM
#> 1234                    New Standard Non-Compartmental Analysis    22 FANLEDTM
#> 1235                    New Standard Non-Compartmental Analysis    23  PCRFTDT
#> 1236                    New Standard Non-Compartmental Analysis    24  PCRFTTM
#> 1237                    New Standard Non-Compartmental Analysis    25 PCRFTDTM
#> 1238                    New Standard Non-Compartmental Analysis    26  PCRFEDT
#> 1239                    New Standard Non-Compartmental Analysis    27  PCRFETM
#> 1240                    New Standard Non-Compartmental Analysis    28 PCRFEDTM
#> 1241                    New Standard Non-Compartmental Analysis    29    NFRLT
#> 1242                    New Standard Non-Compartmental Analysis    30    AFRLT
#> 1243                    New Standard Non-Compartmental Analysis    31   NEFRLT
#> 1244                    New Standard Non-Compartmental Analysis    32   AEFRLT
#> 1245                    New Standard Non-Compartmental Analysis    33    FRLTU
#> 1246                    New Standard Non-Compartmental Analysis    34    NRRLT
#> 1247                    New Standard Non-Compartmental Analysis    35    ARRLT
#> 1248                    New Standard Non-Compartmental Analysis    36    MRRLT
#> 1249                    New Standard Non-Compartmental Analysis    37   NERRLT
#> 1250                    New Standard Non-Compartmental Analysis    38   AERRLT
#> 1251                    New Standard Non-Compartmental Analysis    39   MERRLT
#> 1252                    New Standard Non-Compartmental Analysis    40    RRLTU
#> 1253                    New Standard Non-Compartmental Analysis    41  TMPCTDF
#> 1254                    New Standard Non-Compartmental Analysis    42 ADOSEDUR
#> 1255                    New Standard Non-Compartmental Analysis    43 NDOSEDUR
#> 1256                    New Standard Non-Compartmental Analysis    44 DOSEDURU
#> 1257                    New Standard Non-Compartmental Analysis    45    AVALU
#> 1258                    New Standard Non-Compartmental Analysis    46   PCSPEC
#> 1259                    New Standard Non-Compartmental Analysis    47 PCSTRESC
#> 1260                    New Standard Non-Compartmental Analysis    48 PCSTRESU
#> 1261                    New Standard Non-Compartmental Analysis    49    ALLOQ
#> 1262                    New Standard Non-Compartmental Analysis    50   PCLLOQ
#> 1263                    New Standard Non-Compartmental Analysis    51   VOLUME
#> 1264                    New Standard Non-Compartmental Analysis    52  VOLUMEU
#> 1265                    New Standard Non-Compartmental Analysis    53 SPWEIGHT
#> 1266                    New Standard Non-Compartmental Analysis    54 SPWEIGHU
#> 1267                    New Standard Non-Compartmental Analysis    55  PCGRPID
#> 1268                    New Standard Non-Compartmental Analysis    56    PCSEQ
#> 1269 Standard with Stronger Core for Non-Compartmental Analysis    57    DOSEA
#> 1270 Standard with Stronger Core for Non-Compartmental Analysis    58    DOSEU
#> 1271 Standard with Stronger Core for Non-Compartmental Analysis    59   AVISIT
#>                                       label type core codelist_code
#> 1213                  PK NCA Exclusion Flag Char Perm          <NA>
#> 1214              PK NCA Exclusion Flag (N)  Num Perm          <NA>
#> 1215          Reason w for PK NCA Exclusion Char Perm          <NA>
#> 1216   Reason for PK NCA Exclusion of w (N)  Num Perm          <NA>
#> 1217              PK Summary Exclusion Flag Char Perm          <NA>
#> 1218          PK Summary Exclusion Flag (N)  Num Perm          <NA>
#> 1219                        Metabolite Flag Char Cond          <NA>
#> 1220                         Subject Cohort Char Perm          <NA>
#> 1221                     Subject Cohort (N)  Num Perm          <NA>
#> 1222                                  Route Char Perm        C66729
#> 1223             Planned Treatment Interval  Num Perm          <NA>
#> 1224       Planned Treatment Interval Units Char Perm        C71620
#> 1225  Percent Diff. Nominal vs. Actual Dose  Num Cond          <NA>
#> 1226                         Dose Frequency Char Cond        C71113
#> 1227                         Analysis Cycle  Num Perm          <NA>
#> 1228                     Analysis Cycle (C) Char Perm          <NA>
#> 1229         First Date of Dose for Analyte  Num Perm          <NA>
#> 1230         First Time of Dose for Analyte  Num Perm          <NA>
#> 1231     First Datetime of Dose for Analyte  Num Perm          <NA>
#> 1232     First End Date of Dose for Analyte  Num Perm          <NA>
#> 1233     First End Time of Dose for Analyte  Num Perm          <NA>
#> 1234 First End Datetime of Dose for Analyte  Num Perm          <NA>
#> 1235     Reference Date of Dose for Analyte  Num  Req          <NA>
#> 1236     Reference Time of Dose for Analyte  Num  Req          <NA>
#> 1237 Reference Datetime of Dose for Analyte  Num  Req          <NA>
#> 1238 Reference End Date of Dose for Analyte  Num Cond          <NA>
#> 1239 Reference End Time of Dose for Analyte  Num Cond          <NA>
#> 1240  Ref. End Datetime of Dose for Analyte  Num Cond          <NA>
#> 1241 Nom. Rel. Time from Analyte First Dose  Num Perm          <NA>
#> 1242 Act. Rel. Time from Analyte First Dose  Num Perm          <NA>
#> 1243     Nom. Rel. End Time from First Dose  Num Perm          <NA>
#> 1244     Act. Rel. End Time from First Dose  Num Perm          <NA>
#> 1245         Rel. Time from First Dose Unit Char Perm        C85494
#> 1246       Nominal Rel. Time from Ref. Dose  Num  Req          <NA>
#> 1247        Actual Rel. Time from Ref. Dose  Num  Req          <NA>
#> 1248      Modified Rel. Time from Ref. Dose  Num Perm          <NA>
#> 1249   Nominal Rel. End Time from Ref. Dose  Num Perm          <NA>
#> 1250    Actual Rel. End Time from Ref. Dose  Num Perm          <NA>
#> 1251  Modified Rel. End Time from Ref. Dose  Num Perm          <NA>
#> 1252          Rel. Time from Ref. Dose Unit Char  Req        C85494
#> 1253  Percent Diff. Nominal vs. Actual Time  Num Perm          <NA>
#> 1254      Actual Duration of Treatment Dose  Num Cond          <NA>
#> 1255     Nominal duration of Treatment Dose  Num Cond          <NA>
#> 1256       Duration of Treatment Dose Units Char Perm        C85494
#> 1257                    Analysis Value Unit Char  Req          <NA>
#> 1258                 Specimen Material Type Char Perm        C78734
#> 1259 Character Result/Finding in Std Format Char Cond          <NA>
#> 1260                         Standard Units Char Cond        C71620
#> 1261   Analysis Lower Limit of Quantitation  Num Cond          <NA>
#> 1262            Lower Limit of Quantitation  Num Cond          <NA>
#> 1263                           Volume Value  Num Cond          <NA>
#> 1264                      Volume Value Unit Char Cond        C71620
#> 1265                  Specimen Weight Value  Num Cond          <NA>
#> 1266             Specimen Weight Value Unit Char Cond        C71620
#> 1267                               Group ID Char Perm          <NA>
#> 1268                        Sequence Number  Num Cond          <NA>
#> 1269                  Actual Treatment Dose  Num  Req          <NA>
#> 1270                   Treatment Dose Units Char  Req        C71620
#> 1271                         Analysis Visit Char  Req          <NA>
#>      codelist_submission_values described_value_domain value_list
#> 1213                       <NA>                   <NA>          Y
#> 1214                       <NA>                   <NA>          1
#> 1215                       <NA>                   <NA>       <NA>
#> 1216                       <NA>                   <NA>       <NA>
#> 1217                       <NA>                   <NA>          Y
#> 1218                       <NA>                   <NA>          1
#> 1219                       <NA>                   <NA>          Y
#> 1220                       <NA>                   <NA>       <NA>
#> 1221                       <NA>                   <NA>       <NA>
#> 1222                      ROUTE                   <NA>       <NA>
#> 1223                       <NA>                   <NA>       <NA>
#> 1224                       UNIT                   <NA>       <NA>
#> 1225                       <NA>                   <NA>       <NA>
#> 1226                       FREQ                   <NA>       <NA>
#> 1227                       <NA>                   <NA>       <NA>
#> 1228                       <NA>                   <NA>       <NA>
#> 1229                       <NA>                   <NA>       <NA>
#> 1230                       <NA>                   <NA>       <NA>
#> 1231                       <NA>                   <NA>       <NA>
#> 1232                       <NA>                   <NA>       <NA>
#> 1233                       <NA>                   <NA>       <NA>
#> 1234                       <NA>                   <NA>       <NA>
#> 1235                       <NA>                   <NA>       <NA>
#> 1236                       <NA>                   <NA>       <NA>
#> 1237                       <NA>                   <NA>       <NA>
#> 1238                       <NA>                   <NA>       <NA>
#> 1239                       <NA>                   <NA>       <NA>
#> 1240                       <NA>                   <NA>       <NA>
#> 1241                       <NA>                   <NA>       <NA>
#> 1242                       <NA>                   <NA>       <NA>
#> 1243                       <NA>                   <NA>       <NA>
#> 1244                       <NA>                   <NA>       <NA>
#> 1245                     PKUNIT                   <NA>       <NA>
#> 1246                       <NA>                   <NA>       <NA>
#> 1247                       <NA>                   <NA>       <NA>
#> 1248                       <NA>                   <NA>       <NA>
#> 1249                       <NA>                   <NA>       <NA>
#> 1250                       <NA>                   <NA>       <NA>
#> 1251                       <NA>                   <NA>       <NA>
#> 1252                     PKUNIT                   <NA>       <NA>
#> 1253                       <NA>                   <NA>       <NA>
#> 1254                       <NA>                   <NA>       <NA>
#> 1255                       <NA>                   <NA>       <NA>
#> 1256                     PKUNIT                   <NA>       <NA>
#> 1257                       <NA>                   <NA>       <NA>
#> 1258                   SPECTYPE                   <NA>       <NA>
#> 1259                       <NA>                   <NA>       <NA>
#> 1260                       UNIT                   <NA>       <NA>
#> 1261                       <NA>                   <NA>       <NA>
#> 1262                       <NA>                   <NA>       <NA>
#> 1263                       <NA>                   <NA>       <NA>
#> 1264                       UNIT                   <NA>       <NA>
#> 1265                       <NA>                   <NA>       <NA>
#> 1266                       UNIT                   <NA>       <NA>
#> 1267                       <NA>                   <NA>       <NA>
#> 1268                       <NA>                   <NA>       <NA>
#> 1269                       <NA>                   <NA>       <NA>
#> 1270                       UNIT                   <NA>       <NA>
#> 1271                       <NA>                   <NA>       <NA>
get_ig("SDTM", version = "2.1", domain = "Findings")
#>      standard version    class dataset order variable
#> 3234     SDTM     2.1 Findings    <NA>     1 --TESTCD
#> 3235     SDTM     2.1 Findings    <NA>     2   --TEST
#> 3236     SDTM     2.1 Findings    <NA>     3 --SBMRKS
#> 3237     SDTM     2.1 Findings    <NA>     4 --CELSTA
#> 3238     SDTM     2.1 Findings    <NA>     5 --CSMRKS
#> 3239     SDTM     2.1 Findings    <NA>     6 --CNTMOD
#> 3240     SDTM     2.1 Findings    <NA>     7 --EPCHGI
#> 3241     SDTM     2.1 Findings    <NA>     8 --TSTCND
#> 3242     SDTM     2.1 Findings    <NA>     9 --CNDAGT
#> 3243     SDTM     2.1 Findings    <NA>    10 --BDAGNT
#> 3244     SDTM     2.1 Findings    <NA>    11 --ABCLID
#> 3245     SDTM     2.1 Findings    <NA>    12 --MRKSTR
#> 3246     SDTM     2.1 Findings    <NA>    13   --GATE
#> 3247     SDTM     2.1 Findings    <NA>    14 --GATDEF
#> 3248     SDTM     2.1 Findings    <NA>    15 --TSTOPO
#> 3249     SDTM     2.1 Findings    <NA>    16 --MSCBCE
#> 3250     SDTM     2.1 Findings    <NA>    17  --AGENT
#> 3251     SDTM     2.1 Findings    <NA>    18   --CONC
#> 3252     SDTM     2.1 Findings    <NA>    19  --CONCU
#> 3253     SDTM     2.1 Findings    <NA>    20 --MODIFY
#> 3254     SDTM     2.1 Findings    <NA>    21 --TSTDTL
#> 3255     SDTM     2.1 Findings    <NA>    22 --SPTSTD
#> 3256     SDTM     2.1 Findings    <NA>    23    --CAT
#> 3257     SDTM     2.1 Findings    <NA>    24   --SCAT
#> 3258     SDTM     2.1 Findings    <NA>    25 --TSTPNL
#> 3259     SDTM     2.1 Findings    <NA>    26    --POS
#> 3260     SDTM     2.1 Findings    <NA>    27 --BODSYS
#> 3261     SDTM     2.1 Findings    <NA>    28  --ORRES
#> 3262     SDTM     2.1 Findings    <NA>    29 --ORRESU
#> 3263     SDTM     2.1 Findings    <NA>    30 --CELLEV
#> 3264     SDTM     2.1 Findings    <NA>    31 --RESSCL
#> 3265     SDTM     2.1 Findings    <NA>    32 --RESTYP
#> 3266     SDTM     2.1 Findings    <NA>    33 --COLSRT
#> 3267     SDTM     2.1 Findings    <NA>    34 --ORNRLO
#> 3268     SDTM     2.1 Findings    <NA>    35 --ORNRHI
#> 3269     SDTM     2.1 Findings    <NA>    36  --ORREF
#> 3270     SDTM     2.1 Findings    <NA>    37   --LLOD
#> 3271     SDTM     2.1 Findings    <NA>    38 --STRESC
#> 3272     SDTM     2.1 Findings    <NA>    39 --IMPLBL
#> 3273     SDTM     2.1 Findings    <NA>    40 --STRESN
#> 3274     SDTM     2.1 Findings    <NA>    41 --STRESU
#> 3275     SDTM     2.1 Findings    <NA>    42 --STNRLO
#> 3276     SDTM     2.1 Findings    <NA>    43 --STNRHI
#> 3277     SDTM     2.1 Findings    <NA>    44  --STNRC
#> 3278     SDTM     2.1 Findings    <NA>    45 --STREFC
#> 3279     SDTM     2.1 Findings    <NA>    46 --STREFN
#> 3280     SDTM     2.1 Findings    <NA>    47  --NRIND
#> 3281     SDTM     2.1 Findings    <NA>    48 --RESCAT
#> 3282     SDTM     2.1 Findings    <NA>    49 --INHERT
#> 3283     SDTM     2.1 Findings    <NA>    50 --GENREF
#> 3284     SDTM     2.1 Findings    <NA>    51  --CHROM
#> 3285     SDTM     2.1 Findings    <NA>    52    --SYM
#> 3286     SDTM     2.1 Findings    <NA>    53 --SYMTYP
#> 3287     SDTM     2.1 Findings    <NA>    54 --GENLOC
#> 3288     SDTM     2.1 Findings    <NA>    55  --GENSR
#> 3289     SDTM     2.1 Findings    <NA>    56  --SEQID
#> 3290     SDTM     2.1 Findings    <NA>    57  --PVRID
#> 3291     SDTM     2.1 Findings    <NA>    58 --COPYID
#> 3292     SDTM     2.1 Findings    <NA>    59  --CHRON
#> 3293     SDTM     2.1 Findings    <NA>    60  --DISTR
#> 3294     SDTM     2.1 Findings    <NA>    61 --RESLOC
#> 3295     SDTM     2.1 Findings    <NA>    62   --STAT
#> 3296     SDTM     2.1 Findings    <NA>    63 --REASND
#> 3297     SDTM     2.1 Findings    <NA>    64    --XFN
#> 3298     SDTM     2.1 Findings    <NA>    65    --NAM
#> 3299     SDTM     2.1 Findings    <NA>    66  --LOINC
#> 3300     SDTM     2.1 Findings    <NA>    67   --SPEC
#> 3301     SDTM     2.1 Findings    <NA>    68 --ANTREG
#> 3302     SDTM     2.1 Findings    <NA>    69 --SPCCND
#> 3303     SDTM     2.1 Findings    <NA>    70 --SPCUFL
#> 3304     SDTM     2.1 Findings    <NA>    71    --LOC
#> 3305     SDTM     2.1 Findings    <NA>    72    --LAT
#> 3306     SDTM     2.1 Findings    <NA>    73    --DIR
#> 3307     SDTM     2.1 Findings    <NA>    74 --PORTOT
#> 3308     SDTM     2.1 Findings    <NA>    75 --METHOD
#> 3309     SDTM     2.1 Findings    <NA>    76  --RUNID
#> 3310     SDTM     2.1 Findings    <NA>    77 --ANMETH
#> 3311     SDTM     2.1 Findings    <NA>    78 --TMTHSN
#> 3312     SDTM     2.1 Findings    <NA>    79   --LEAD
#> 3313     SDTM     2.1 Findings    <NA>    80 --CSTATE
#> 3314     SDTM     2.1 Findings    <NA>    81 --LOBXFL
#> 3315     SDTM     2.1 Findings    <NA>    82   --BLFL
#> 3316     SDTM     2.1 Findings    <NA>    83   --FAST
#> 3317     SDTM     2.1 Findings    <NA>    84  --DRVFL
#> 3318     SDTM     2.1 Findings    <NA>    85   --EVAL
#> 3319     SDTM     2.1 Findings    <NA>    86 --EVALID
#> 3320     SDTM     2.1 Findings    <NA>    87 --ACPTFL
#> 3321     SDTM     2.1 Findings    <NA>    88    --TOX
#> 3322     SDTM     2.1 Findings    <NA>    89  --TOXGR
#> 3323     SDTM     2.1 Findings    <NA>    90    --SEV
#> 3324     SDTM     2.1 Findings    <NA>    91  --CLSIG
#> 3325     SDTM     2.1 Findings    <NA>    92 --DTHREL
#> 3326     SDTM     2.1 Findings    <NA>    93   --LLOQ
#> 3327     SDTM     2.1 Findings    <NA>    94   --ULOQ
#> 3328     SDTM     2.1 Findings    <NA>    95 --REASPF
#> 3329     SDTM     2.1 Findings    <NA>    96 --EXCLFL
#> 3330     SDTM     2.1 Findings    <NA>    97 --REASEX
#> 3331     SDTM     2.1 Findings    <NA>    98 --USCHFL
#> 3332     SDTM     2.1 Findings    <NA>    99 --REPNUM
#> 3333     SDTM     2.1 Findings    <NA>   100 --RSTIND
#> 3334     SDTM     2.1 Findings    <NA>   101 --RSTMOD
#>                                         label type               role
#> 3234 Short Name of Measurement, Test, or Exam Char              Topic
#> 3235       Name of Measurement, Test, or Exam Char  Synonym Qualifier
#> 3236                 Sublineage Marker String Char Variable Qualifier
#> 3237                               Cell State Char Variable Qualifier
#> 3238                 Cell State Marker String Char Variable Qualifier
#> 3239                             Contact Mode Char   Record Qualifier
#> 3240    Epi/Pandemic Related Change Indicator Char   Record Qualifier
#> 3241                           Test Condition Char Variable Qualifier
#> 3242                     Test Condition Agent Char   Record Qualifier
#> 3243                            Binding Agent Char Variable Qualifier
#> 3244                Antibody Clone Identifier Char   Record Qualifier
#> 3245                            Marker String Char   Record Qualifier
#> 3246                                     Gate Char   Record Qualifier
#> 3247                          Gate Definition Char   Record Qualifier
#> 3248               Test Operational Objective Char Variable Qualifier
#> 3249               Molecule Secreted by Cells Char Variable Qualifier
#> 3250                               Agent Name Char   Record Qualifier
#> 3251                      Agent Concentration  Num Variable Qualifier
#> 3252                Agent Concentration Units Char Variable Qualifier
#> 3253                     Modified Result Term Char  Synonym Qualifier
#> 3254 Measurement, Test, or Examination Detail Char Variable Qualifier
#> 3255                 Sponsor Test Description Char   Record Qualifier
#> 3256                                 Category Char Grouping Qualifier
#> 3257                              Subcategory Char Grouping Qualifier
#> 3258                               Test Panel Char Grouping Qualifier
#> 3259   Position of Subject During Observation Char   Record Qualifier
#> 3260               Body System or Organ Class Char   Record Qualifier
#> 3261      Result or Finding in Original Units Char   Result Qualifier
#> 3262                           Original Units Char Variable Qualifier
#> 3263                Number of Cells Evaluated  Num   Result Qualifier
#> 3264                             Result Scale Char   Record Qualifier
#> 3265                              Result Type Char   Record Qualifier
#> 3266            Collected Summary Result Type Char Variable Qualifier
#> 3267  Normal Range Lower Limit-Original Units Char Variable Qualifier
#> 3268  Normal Range Upper Limit-Original Units Char Variable Qualifier
#> 3269       Reference Result in Original Units Char Variable Qualifier
#> 3270                 Lower Limit of Detection Char Variable Qualifier
#> 3271     Result or Finding in Standard Format Char   Result Qualifier
#> 3272                  Implantation Site Label Char   Record Qualifier
#> 3273 Numeric Result/Finding in Standard Units  Num   Result Qualifier
#> 3274                           Standard Units Char Variable Qualifier
#> 3275  Normal Range Lower Limit-Standard Units  Num Variable Qualifier
#> 3276  Normal Range Upper Limit-Standard Units  Num Variable Qualifier
#> 3277       Normal Range for Character Results Char Variable Qualifier
#> 3278      Reference Result in Standard Format Char Variable Qualifier
#> 3279    Numeric Reference Result in Std Units  Num Variable Qualifier
#> 3280         Normal/Reference Range Indicator Char Variable Qualifier
#> 3281                          Result Category Char Variable Qualifier
#> 3282                           Inheritability Char Variable Qualifier
#> 3283                         Genome Reference Char Variable Qualifier
#> 3284                    Chromosome Identifier Char Variable Qualifier
#> 3285                           Genomic Symbol Char Variable Qualifier
#> 3286                      Genomic Symbol Type Char Variable Qualifier
#> 3287                         Genetic Location Char Variable Qualifier
#> 3288                       Genetic Sub-Region Char Variable Qualifier
#> 3289                      Sequence Identifier Char Variable Qualifier
#> 3290             Published Variant Identifier Char Variable Qualifier
#> 3291                          Copy Identifier Char Variable Qualifier
#> 3292                    Chronicity of Finding Char Variable Qualifier
#> 3293          Distribution Pattern of Finding Char Variable Qualifier
#> 3294               Result Location of Finding Char   Record Qualifier
#> 3295                        Completion Status Char   Record Qualifier
#> 3296                          Reason Not Done Char   Record Qualifier
#> 3297                       External File Path Char   Record Qualifier
#> 3298                   Laboratory/Vendor Name Char   Record Qualifier
#> 3299                               LOINC Code Char   Record Qualifier
#> 3300                   Specimen Material Type Char   Record Qualifier
#> 3301                        Anatomical Region Char Variable Qualifier
#> 3302                       Specimen Condition Char   Record Qualifier
#> 3303          Specimen Usability for the Test Char   Record Qualifier
#> 3304        Location Used for the Measurement Char   Record Qualifier
#> 3305                               Laterality Char Variable Qualifier
#> 3306                           Directionality Char Variable Qualifier
#> 3307                      Portion or Totality Char Variable Qualifier
#> 3308            Method of Test or Examination Char   Record Qualifier
#> 3309                                   Run ID Char   Record Qualifier
#> 3310                          Analysis Method Char   Record Qualifier
#> 3311                  Test Method Sensitivity Char   Record Qualifier
#> 3312  Lead Identified to Collect Measurements Char   Record Qualifier
#> 3313                      Consciousness State Char   Record Qualifier
#> 3314    Last Observation Before Exposure Flag Char   Record Qualifier
#> 3315                            Baseline Flag Char   Record Qualifier
#> 3316                           Fasting Status Char   Record Qualifier
#> 3317                             Derived Flag Char   Record Qualifier
#> 3318                                Evaluator Char   Record Qualifier
#> 3319                     Evaluator Identifier Char Variable Qualifier
#> 3320                     Accepted Record Flag Char   Record Qualifier
#> 3321                                 Toxicity Char Variable Qualifier
#> 3322                           Toxicity Grade Char   Record Qualifier
#> 3323                       Severity/Intensity Char   Record Qualifier
#> 3324        Clinically Significant, Collected Char   Record Qualifier
#> 3325                    Relationship to Death Char   Record Qualifier
#> 3326              Lower Limit of Quantitation  Num Variable Qualifier
#> 3327              Upper Limit of Quantitation  Num Variable Qualifier
#> 3328                    Reason Test Performed Char   Record Qualifier
#> 3329                  Exclude from Statistics Char   Record Qualifier
#> 3330     Reason for Exclusion from Statistics Char   Record Qualifier
#> 3331                         Unscheduled Flag Char   Record Qualifier
#> 3332                        Repetition Number  Num   Record Qualifier
#> 3333                      Restraint Indicator Char   Record Qualifier
#> 3334                           Restraint Mode Char   Record Qualifier
#>      described_value_domain
#> 3234                   <NA>
#> 3235                   <NA>
#> 3236                   <NA>
#> 3237                   <NA>
#> 3238                   <NA>
#> 3239                   <NA>
#> 3240                   <NA>
#> 3241                   <NA>
#> 3242                   <NA>
#> 3243                   <NA>
#> 3244                   <NA>
#> 3245                   <NA>
#> 3246                   <NA>
#> 3247                   <NA>
#> 3248                   <NA>
#> 3249                   <NA>
#> 3250                   <NA>
#> 3251                   <NA>
#> 3252                   <NA>
#> 3253                   <NA>
#> 3254                   <NA>
#> 3255                   <NA>
#> 3256                   <NA>
#> 3257                   <NA>
#> 3258                   <NA>
#> 3259                   <NA>
#> 3260                   <NA>
#> 3261                   <NA>
#> 3262                   <NA>
#> 3263                   <NA>
#> 3264                   <NA>
#> 3265                   <NA>
#> 3266                   <NA>
#> 3267                   <NA>
#> 3268                   <NA>
#> 3269                   <NA>
#> 3270                   <NA>
#> 3271                   <NA>
#> 3272                   <NA>
#> 3273                   <NA>
#> 3274                   <NA>
#> 3275                   <NA>
#> 3276                   <NA>
#> 3277                   <NA>
#> 3278                   <NA>
#> 3279                   <NA>
#> 3280                   <NA>
#> 3281                   <NA>
#> 3282                   <NA>
#> 3283                   <NA>
#> 3284                   <NA>
#> 3285                   <NA>
#> 3286                   <NA>
#> 3287                   <NA>
#> 3288                   <NA>
#> 3289                   <NA>
#> 3290                   <NA>
#> 3291                   <NA>
#> 3292                   <NA>
#> 3293                   <NA>
#> 3294                   <NA>
#> 3295                   <NA>
#> 3296                   <NA>
#> 3297                   <NA>
#> 3298                   <NA>
#> 3299                   <NA>
#> 3300                   <NA>
#> 3301                   <NA>
#> 3302                   <NA>
#> 3303                   <NA>
#> 3304                   <NA>
#> 3305                   <NA>
#> 3306                   <NA>
#> 3307                   <NA>
#> 3308                   <NA>
#> 3309                   <NA>
#> 3310                   <NA>
#> 3311                   <NA>
#> 3312                   <NA>
#> 3313                   <NA>
#> 3314                   <NA>
#> 3315                   <NA>
#> 3316                   <NA>
#> 3317                   <NA>
#> 3318                   <NA>
#> 3319                   <NA>
#> 3320                   <NA>
#> 3321                   <NA>
#> 3322                   <NA>
#> 3323                   <NA>
#> 3324                   <NA>
#> 3325                   <NA>
#> 3326                   <NA>
#> 3327                   <NA>
#> 3328                   <NA>
#> 3329                   <NA>
#> 3330                   <NA>
#> 3331                   <NA>
#> 3332                   <NA>
#> 3333                   <NA>
#> 3334                   <NA>
#>                                                             variables_qualified
#> 3234                                                                       <NA>
#> 3235                                                                   --TESTCD
#> 3236                                                                   --TESTCD
#> 3237                                                                   --TESTCD
#> 3238                                                                   --TESTCD
#> 3239                                                                       <NA>
#> 3240                                                                       <NA>
#> 3241                                                                   --TESTCD
#> 3242                                                                       <NA>
#> 3243                                                                   --TESTCD
#> 3244                                                                       <NA>
#> 3245                                                                       <NA>
#> 3246                                                                       <NA>
#> 3247                                                                       <NA>
#> 3248                                                                   --TESTCD
#> 3249                                                                   --TESTCD
#> 3250                                                                       <NA>
#> 3251                                                                    --AGENT
#> 3252                                                                     --CONC
#> 3253                                                                    --ORRES
#> 3254                                                                   --TESTCD
#> 3255                                                                       <NA>
#> 3256                                                                       <NA>
#> 3257                                                                       <NA>
#> 3258                                                                       <NA>
#> 3259                                                                       <NA>
#> 3260                                                                       <NA>
#> 3261                                                                       <NA>
#> 3262                                       --ORRES; --ORNRLO; --ORNRHI; --ORREF
#> 3263                                                                       <NA>
#> 3264                                                                       <NA>
#> 3265                                                                       <NA>
#> 3266                                                                   --TESTCD
#> 3267                                                                    --ORRES
#> 3268                                                                    --ORRES
#> 3269                                                                    --ORRES
#> 3270                                                                   --TESTCD
#> 3271                                                                       <NA>
#> 3272                                                                       <NA>
#> 3273                                                                       <NA>
#> 3274 --STRESC; --STRESN; --STNRLO; --STNRHI; --STREFC; --STREFN; --LLOQ; --ULOQ
#> 3275                                                         --STRESC; --STRESN
#> 3276                                                         --STRESC; --STRESN
#> 3277                                                                   --STRESC
#> 3278                                                                   --STRESC
#> 3279                                                                   --STRESN
#> 3280                                                --ORRES; --STRESC; --STRESN
#> 3281                                                --ORRES; --STRESC; --STRESN
#> 3282                                                --ORRES; --STRESC; --STRESN
#> 3283                                                                   --METHOD
#> 3284                                                --ORRES; --STRESC; --STRESN
#> 3285                                                --ORRES; --STRESC; --STRESN
#> 3286                                                                      --SYM
#> 3287                                                --ORRES; --STRESC; --STRESN
#> 3288                                                --ORRES; --STRESC; --STRESN
#> 3289                                                --ORRES; --STRESC; --STRESN
#> 3290                                                --ORRES; --STRESC; --STRESN
#> 3291                                                --ORRES; --STRESC; --STRESN
#> 3292                                                                   --STRESC
#> 3293                                                                   --STRESC
#> 3294                                                                       <NA>
#> 3295                                                                       <NA>
#> 3296                                                                       <NA>
#> 3297                                                                       <NA>
#> 3298                                                                       <NA>
#> 3299                                                                       <NA>
#> 3300                                                                       <NA>
#> 3301                                                                     --SPEC
#> 3302                                                                       <NA>
#> 3303                                                                       <NA>
#> 3304                                                                       <NA>
#> 3305                                                              --SPEC; --LOC
#> 3306                                                              --SPEC; --LOC
#> 3307                                                              --SPEC; --LOC
#> 3308                                                                       <NA>
#> 3309                                                                       <NA>
#> 3310                                                                       <NA>
#> 3311                                                                       <NA>
#> 3312                                                                       <NA>
#> 3313                                                                       <NA>
#> 3314                                                                       <NA>
#> 3315                                                                       <NA>
#> 3316                                                                       <NA>
#> 3317                                                                       <NA>
#> 3318                                                                       <NA>
#> 3319                                                                     --EVAL
#> 3320                                                                       <NA>
#> 3321                                                                    --TOXGR
#> 3322                                                                       <NA>
#> 3323                                                                       <NA>
#> 3324                                                                       <NA>
#> 3325                                                                       <NA>
#> 3326                                                         --STRESC; --STRESN
#> 3327                                                         --STRESC; --STRESN
#> 3328                                                                       <NA>
#> 3329                                                                       <NA>
#> 3330                                                                       <NA>
#> 3331                                                                       <NA>
#> 3332                                                                       <NA>
#> 3333                                                                       <NA>
#> 3334                                                                       <NA>
#>                                              usage_restrictions variable_code
#> 3234                                                       <NA>        C82503
#> 3235                                                       <NA>        C82541
#> 3236                                             CP domain only          <NA>
#> 3237                                             CP domain only          <NA>
#> 3238                                             CP domain only          <NA>
#> 3239                                                       <NA>          <NA>
#> 3240                                                       <NA>          <NA>
#> 3241                                CP, IS, and LB domains only          <NA>
#> 3242                                CP, IS, and LB domains only          <NA>
#> 3243                                CP, IS, and LB domains only          <NA>
#> 3244                                             CP domain only          <NA>
#> 3245                                             CP domain only          <NA>
#> 3246                                             CP domain only          <NA>
#> 3247                                             CP domain only          <NA>
#> 3248                                                       <NA>          <NA>
#> 3249                                             IS domain only          <NA>
#> 3250                                             MS Domain only          <NA>
#> 3251                                             MS Domain only          <NA>
#> 3252                                             MS Domain only          <NA>
#> 3253                                                       <NA>       C170998
#> 3254                                                       <NA>          <NA>
#> 3255                                             CP domain only          <NA>
#> 3256                                                       <NA>        C25372
#> 3257                                                       <NA>        C25692
#> 3258                                             CP domain only          <NA>
#> 3259                                                       <NA>       C171002
#> 3260                                                       <NA>       C170986
#> 3261                                                       <NA>       C117221
#> 3262                                                       <NA>        C82586
#> 3263                                                       <NA>          <NA>
#> 3264                                                       <NA>          <NA>
#> 3265                                                       <NA>          <NA>
#> 3266                                                       <NA>          <NA>
#> 3267                                                       <NA>        C82580
#> 3268                                                       <NA>        C70933
#> 3269                                                       <NA>          <NA>
#> 3270                                                       <NA>          <NA>
#> 3271                                                       <NA>       C117222
#> 3272               Not in human clinical trials; IC Domain only          <NA>
#> 3273                                                       <NA>       C171009
#> 3274                                                       <NA>        C82587
#> 3275                                                       <NA>       C171008
#> 3276                                                       <NA>       C171007
#> 3277                                                       <NA>       C171006
#> 3278                                                       <NA>          <NA>
#> 3279                                                       <NA>          <NA>
#> 3280                                                       <NA>       C170999
#> 3281                                                       <NA>        C82498
#> 3282                                             GF domain only          <NA>
#> 3283                                             GF domain only          <NA>
#> 3284                                             GF domain only          <NA>
#> 3285                                             GF domain only          <NA>
#> 3286                                             GF domain only          <NA>
#> 3287                                             GF domain only          <NA>
#> 3288                                             GF domain only          <NA>
#> 3289                                             GF domain only          <NA>
#> 3290                                             GF domain only          <NA>
#> 3291                                             GF domain only          <NA>
#> 3292                                                       <NA>          <NA>
#> 3293                                                       <NA>          <NA>
#> 3294                               Not in human clinical trials       C170500
#> 3295                                                       <NA>          <NA>
#> 3296                                                       <NA>        C82556
#> 3297                                                       <NA>        C82536
#> 3298                                                       <NA>       C117200
#> 3299                                                       <NA>        C82502
#> 3300                                                       <NA>        C70713
#> 3301                                                       <NA>       C170983
#> 3302                                                       <NA>        C70714
#> 3303                                                       <NA>       C171004
#> 3304                                                       <NA>          <NA>
#> 3305                                                       <NA>          <NA>
#> 3306                                                       <NA>          <NA>
#> 3307                                                       <NA>          <NA>
#> 3308                                                       <NA>          <NA>
#> 3309                                                       <NA>       C117058
#> 3310                                                       <NA>          <NA>
#> 3311                                                       <NA>          <NA>
#> 3312                                                       <NA>       C170997
#> 3313                                                       <NA>        C88429
#> 3314                                                       <NA>          <NA>
#> 3315                                                       <NA>        C82526
#> 3316                                                       <NA>        C93566
#> 3317                                                       <NA>        C81197
#> 3318 Not in QS, FT, and clinical classifications use case of RS        C51824
#> 3319 Not in QS, FT, and clinical classifications use case of RS       C117043
#> 3320                                                       <NA>       C117038
#> 3321                                                       <NA>        C27990
#> 3322                                                       <NA>        C82528
#> 3323                                                       <NA>        C25676
#> 3324                                                       <NA>        C93532
#> 3325                               Not in human clinical trials        C82563
#> 3326                                                       <NA>        C82589
#> 3327                                                       <NA>        C85533
#> 3328                                                       <NA>       C171003
#> 3329                               Not in human clinical trials       C117045
#> 3330                               Not in human clinical trials       C117057
#> 3331                               Not in human clinical trials       C170510
#> 3332                                                       <NA>          <NA>
#> 3333                               Not in human clinical trials          <NA>
#> 3334                               Not in human clinical trials          <NA>
```
