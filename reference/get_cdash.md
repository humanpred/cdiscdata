# Retrieve CDASH model or implementation-guide variable metadata

Accessor over the two CDASH (collection-side) tables,
[`cdash_model`](https://humanpred.github.io/cdiscdata/reference/cdash_model.md)
and
[`ig_cdash`](https://humanpred.github.io/cdiscdata/reference/ig_cdash.md),
with the same conventions as
[`get_ig`](https://humanpred.github.io/cdiscdata/reference/get_ig.md):
the standard is chosen with `standard` and the version defaults to its
newest. CDASH is kept apart from
[`get_ig()`](https://humanpred.github.io/cdiscdata/reference/get_ig.md)
because its tables describe case report form collection (question text,
prompts, the SDTM variable each field maps to), not a dataset's
structure, and so have different columns.

## Usage

``` r
get_cdash(standard = "CDASHIG", version = NULL, domain = NULL)
```

## Arguments

- standard:

  `"CDASHIG"` (default) or `"CDASH"`.

- version:

  A version string of that standard (e.g. `"2.3"`). `NULL` (the default)
  uses the newest, compared numerically.

- domain:

  Restrict to one domain (e.g. `"LB"`); for `"CDASH"` a `class` (e.g.
  `"Findings"`) is accepted too. `NULL` (the default) applies no filter.

## Value

A data frame: the rows of
[`cdash_model`](https://humanpred.github.io/cdiscdata/reference/cdash_model.md)
or
[`ig_cdash`](https://humanpred.github.io/cdiscdata/reference/ig_cdash.md)
for that standard, version, and domain. An unknown standard, version, or
domain is a classed error (`cdiscdata_error_ig_standard_unavailable`,
`cdiscdata_error_ig_version_unavailable`,
`cdiscdata_error_ig_domain_unavailable`).

## Details

The standards: `"CDASH"` (the CDASH model, versions 1.0 to 1.3, in
[`cdash_model`](https://humanpred.github.io/cdiscdata/reference/cdash_model.md))
and `"CDASHIG"` (the CDASH implementation guide, 1.1 and 2.0 to 2.3, in
[`ig_cdash`](https://humanpred.github.io/cdiscdata/reference/ig_cdash.md)).

Like the other implementation-guide data these come from CDISC Library
CSV exports that are not part of this package or repository (see
[`ig_sources`](https://humanpred.github.io/cdiscdata/reference/ig_sources.md));
the guides' definitions, CRF completion instructions, mapping
instructions, and implementation notes are not carried. The collection
wording the guides publish (`question_text`, `prompt`) is.

## Examples

``` r
get_cdash()                                  # newest CDASHIG (2.3)
#>      standard version           class domain
#> 3231  CDASHIG     2.3   Interventions     AG
#> 3232  CDASHIG     2.3   Interventions     AG
#> 3233  CDASHIG     2.3   Interventions     AG
#> 3234  CDASHIG     2.3   Interventions     AG
#> 3235  CDASHIG     2.3   Interventions     AG
#> 3236  CDASHIG     2.3   Interventions     AG
#> 3237  CDASHIG     2.3   Interventions     AG
#> 3238  CDASHIG     2.3   Interventions     AG
#> 3239  CDASHIG     2.3   Interventions     AG
#> 3240  CDASHIG     2.3   Interventions     AG
#> 3241  CDASHIG     2.3   Interventions     AG
#> 3242  CDASHIG     2.3   Interventions     AG
#> 3243  CDASHIG     2.3   Interventions     AG
#> 3244  CDASHIG     2.3   Interventions     AG
#> 3245  CDASHIG     2.3   Interventions     AG
#> 3246  CDASHIG     2.3   Interventions     AG
#> 3247  CDASHIG     2.3   Interventions     AG
#> 3248  CDASHIG     2.3   Interventions     AG
#> 3249  CDASHIG     2.3   Interventions     AG
#> 3250  CDASHIG     2.3   Interventions     AG
#> 3251  CDASHIG     2.3   Interventions     AG
#> 3252  CDASHIG     2.3   Interventions     AG
#> 3253  CDASHIG     2.3   Interventions     AG
#> 3254  CDASHIG     2.3   Interventions     AG
#> 3255  CDASHIG     2.3   Interventions     AG
#> 3256  CDASHIG     2.3   Interventions     CM
#> 3257  CDASHIG     2.3   Interventions     CM
#> 3258  CDASHIG     2.3   Interventions     CM
#> 3259  CDASHIG     2.3   Interventions     CM
#> 3260  CDASHIG     2.3   Interventions     CM
#> 3261  CDASHIG     2.3   Interventions     CM
#> 3262  CDASHIG     2.3   Interventions     CM
#> 3263  CDASHIG     2.3   Interventions     CM
#> 3264  CDASHIG     2.3   Interventions     CM
#> 3265  CDASHIG     2.3   Interventions     CM
#> 3266  CDASHIG     2.3   Interventions     CM
#> 3267  CDASHIG     2.3   Interventions     CM
#> 3268  CDASHIG     2.3   Interventions     CM
#> 3269  CDASHIG     2.3   Interventions     CM
#> 3270  CDASHIG     2.3   Interventions     CM
#> 3271  CDASHIG     2.3   Interventions     CM
#> 3272  CDASHIG     2.3   Interventions     CM
#> 3273  CDASHIG     2.3   Interventions     CM
#> 3274  CDASHIG     2.3   Interventions     CM
#> 3275  CDASHIG     2.3   Interventions     CM
#> 3276  CDASHIG     2.3   Interventions     CM
#> 3277  CDASHIG     2.3   Interventions     CM
#> 3278  CDASHIG     2.3   Interventions     CM
#> 3279  CDASHIG     2.3   Interventions     CM
#> 3280  CDASHIG     2.3   Interventions     CM
#> 3281  CDASHIG     2.3   Interventions     CM
#> 3282  CDASHIG     2.3   Interventions     CM
#> 3283  CDASHIG     2.3   Interventions     CM
#> 3284  CDASHIG     2.3   Interventions     CM
#> 3285  CDASHIG     2.3   Interventions     CM
#> 3286  CDASHIG     2.3   Interventions     CM
#> 3287  CDASHIG     2.3   Interventions     CM
#> 3288  CDASHIG     2.3   Interventions     CM
#> 3289  CDASHIG     2.3   Interventions     CM
#> 3290  CDASHIG     2.3   Interventions     CM
#> 3291  CDASHIG     2.3   Interventions     CM
#> 3292  CDASHIG     2.3   Interventions     CM
#> 3293  CDASHIG     2.3   Interventions     CM
#> 3294  CDASHIG     2.3   Interventions     CM
#> 3295  CDASHIG     2.3   Interventions     CM
#> 3296  CDASHIG     2.3   Interventions     CM
#> 3297  CDASHIG     2.3   Interventions     EC
#> 3298  CDASHIG     2.3   Interventions     EC
#> 3299  CDASHIG     2.3   Interventions     EC
#> 3300  CDASHIG     2.3   Interventions     EC
#> 3301  CDASHIG     2.3   Interventions     EC
#> 3302  CDASHIG     2.3   Interventions     EC
#> 3303  CDASHIG     2.3   Interventions     EC
#> 3304  CDASHIG     2.3   Interventions     EC
#> 3305  CDASHIG     2.3   Interventions     EC
#> 3306  CDASHIG     2.3   Interventions     EC
#> 3307  CDASHIG     2.3   Interventions     EC
#> 3308  CDASHIG     2.3   Interventions     EC
#> 3309  CDASHIG     2.3   Interventions     EC
#> 3310  CDASHIG     2.3   Interventions     EC
#> 3311  CDASHIG     2.3   Interventions     EC
#> 3312  CDASHIG     2.3   Interventions     EC
#> 3313  CDASHIG     2.3   Interventions     EC
#> 3314  CDASHIG     2.3   Interventions     EC
#> 3315  CDASHIG     2.3   Interventions     EC
#> 3316  CDASHIG     2.3   Interventions     EC
#> 3317  CDASHIG     2.3   Interventions     EC
#> 3318  CDASHIG     2.3   Interventions     EC
#> 3319  CDASHIG     2.3   Interventions     EC
#> 3320  CDASHIG     2.3   Interventions     EC
#> 3321  CDASHIG     2.3   Interventions     EC
#> 3322  CDASHIG     2.3   Interventions     EC
#> 3323  CDASHIG     2.3   Interventions     EC
#> 3324  CDASHIG     2.3   Interventions     EC
#> 3325  CDASHIG     2.3   Interventions     EC
#> 3326  CDASHIG     2.3   Interventions     EC
#> 3327  CDASHIG     2.3   Interventions     EC
#> 3328  CDASHIG     2.3   Interventions     EC
#> 3329  CDASHIG     2.3   Interventions     EC
#> 3330  CDASHIG     2.3   Interventions     EC
#> 3331  CDASHIG     2.3   Interventions     EC
#> 3332  CDASHIG     2.3   Interventions     EC
#> 3333  CDASHIG     2.3   Interventions     EC
#> 3334  CDASHIG     2.3   Interventions     EC
#> 3335  CDASHIG     2.3   Interventions     EC
#> 3336  CDASHIG     2.3   Interventions     EX
#> 3337  CDASHIG     2.3   Interventions     EX
#> 3338  CDASHIG     2.3   Interventions     EX
#> 3339  CDASHIG     2.3   Interventions     EX
#> 3340  CDASHIG     2.3   Interventions     EX
#> 3341  CDASHIG     2.3   Interventions     EX
#> 3342  CDASHIG     2.3   Interventions     EX
#> 3343  CDASHIG     2.3   Interventions     EX
#> 3344  CDASHIG     2.3   Interventions     EX
#> 3345  CDASHIG     2.3   Interventions     EX
#> 3346  CDASHIG     2.3   Interventions     EX
#> 3347  CDASHIG     2.3   Interventions     EX
#> 3348  CDASHIG     2.3   Interventions     EX
#> 3349  CDASHIG     2.3   Interventions     EX
#> 3350  CDASHIG     2.3   Interventions     EX
#> 3351  CDASHIG     2.3   Interventions     EX
#> 3352  CDASHIG     2.3   Interventions     EX
#> 3353  CDASHIG     2.3   Interventions     EX
#> 3354  CDASHIG     2.3   Interventions     EX
#> 3355  CDASHIG     2.3   Interventions     EX
#> 3356  CDASHIG     2.3   Interventions     EX
#> 3357  CDASHIG     2.3   Interventions     EX
#> 3358  CDASHIG     2.3   Interventions     EX
#> 3359  CDASHIG     2.3   Interventions     EX
#> 3360  CDASHIG     2.3   Interventions     EX
#> 3361  CDASHIG     2.3   Interventions     EX
#> 3362  CDASHIG     2.3   Interventions     EX
#> 3363  CDASHIG     2.3   Interventions     EX
#> 3364  CDASHIG     2.3   Interventions     EX
#> 3365  CDASHIG     2.3   Interventions     EX
#> 3366  CDASHIG     2.3   Interventions     EX
#> 3367  CDASHIG     2.3   Interventions     EX
#> 3368  CDASHIG     2.3   Interventions     EX
#> 3369  CDASHIG     2.3   Interventions     EX
#> 3370  CDASHIG     2.3   Interventions     EX
#> 3371  CDASHIG     2.3   Interventions     ML
#> 3372  CDASHIG     2.3   Interventions     ML
#> 3373  CDASHIG     2.3   Interventions     ML
#> 3374  CDASHIG     2.3   Interventions     ML
#> 3375  CDASHIG     2.3   Interventions     ML
#> 3376  CDASHIG     2.3   Interventions     ML
#> 3377  CDASHIG     2.3   Interventions     ML
#> 3378  CDASHIG     2.3   Interventions     ML
#> 3379  CDASHIG     2.3   Interventions     ML
#> 3380  CDASHIG     2.3   Interventions     ML
#> 3381  CDASHIG     2.3   Interventions     ML
#> 3382  CDASHIG     2.3   Interventions     ML
#> 3383  CDASHIG     2.3   Interventions     ML
#> 3384  CDASHIG     2.3   Interventions     ML
#> 3385  CDASHIG     2.3   Interventions     ML
#> 3386  CDASHIG     2.3   Interventions     ML
#> 3387  CDASHIG     2.3   Interventions     ML
#> 3388  CDASHIG     2.3   Interventions     ML
#> 3389  CDASHIG     2.3   Interventions     ML
#> 3390  CDASHIG     2.3   Interventions     ML
#> 3391  CDASHIG     2.3   Interventions     ML
#> 3392  CDASHIG     2.3   Interventions     ML
#> 3393  CDASHIG     2.3   Interventions     PR
#> 3394  CDASHIG     2.3   Interventions     PR
#> 3395  CDASHIG     2.3   Interventions     PR
#> 3396  CDASHIG     2.3   Interventions     PR
#> 3397  CDASHIG     2.3   Interventions     PR
#> 3398  CDASHIG     2.3   Interventions     PR
#> 3399  CDASHIG     2.3   Interventions     PR
#> 3400  CDASHIG     2.3   Interventions     PR
#> 3401  CDASHIG     2.3   Interventions     PR
#> 3402  CDASHIG     2.3   Interventions     PR
#> 3403  CDASHIG     2.3   Interventions     PR
#> 3404  CDASHIG     2.3   Interventions     PR
#> 3405  CDASHIG     2.3   Interventions     PR
#> 3406  CDASHIG     2.3   Interventions     PR
#> 3407  CDASHIG     2.3   Interventions     PR
#> 3408  CDASHIG     2.3   Interventions     PR
#> 3409  CDASHIG     2.3   Interventions     PR
#> 3410  CDASHIG     2.3   Interventions     PR
#> 3411  CDASHIG     2.3   Interventions     PR
#> 3412  CDASHIG     2.3   Interventions     PR
#> 3413  CDASHIG     2.3   Interventions     PR
#> 3414  CDASHIG     2.3   Interventions     PR
#> 3415  CDASHIG     2.3   Interventions     PR
#> 3416  CDASHIG     2.3   Interventions     PR
#> 3417  CDASHIG     2.3   Interventions     PR
#> 3418  CDASHIG     2.3   Interventions     PR
#> 3419  CDASHIG     2.3   Interventions     PR
#> 3420  CDASHIG     2.3   Interventions     PR
#> 3421  CDASHIG     2.3   Interventions     PR
#> 3422  CDASHIG     2.3   Interventions     PR
#> 3423  CDASHIG     2.3   Interventions     PR
#> 3424  CDASHIG     2.3   Interventions     PR
#> 3425  CDASHIG     2.3   Interventions     PR
#> 3426  CDASHIG     2.3   Interventions     PR
#> 3427  CDASHIG     2.3   Interventions     PR
#> 3428  CDASHIG     2.3   Interventions     PR
#> 3429  CDASHIG     2.3   Interventions     PR
#> 3430  CDASHIG     2.3   Interventions     PR
#> 3431  CDASHIG     2.3   Interventions     PR
#> 3432  CDASHIG     2.3   Interventions     PR
#> 3433  CDASHIG     2.3   Interventions     PR
#> 3434  CDASHIG     2.3   Interventions     PR
#> 3435  CDASHIG     2.3   Interventions     PR
#> 3436  CDASHIG     2.3   Interventions     PR
#> 3437  CDASHIG     2.3   Interventions     PR
#> 3438  CDASHIG     2.3   Interventions     PR
#> 3439  CDASHIG     2.3   Interventions     PR
#> 3440  CDASHIG     2.3   Interventions     SU
#> 3441  CDASHIG     2.3   Interventions     SU
#> 3442  CDASHIG     2.3   Interventions     SU
#> 3443  CDASHIG     2.3   Interventions     SU
#> 3444  CDASHIG     2.3   Interventions     SU
#> 3445  CDASHIG     2.3   Interventions     SU
#> 3446  CDASHIG     2.3   Interventions     SU
#> 3447  CDASHIG     2.3   Interventions     SU
#> 3448  CDASHIG     2.3   Interventions     SU
#> 3449  CDASHIG     2.3   Interventions     SU
#> 3450  CDASHIG     2.3   Interventions     SU
#> 3451  CDASHIG     2.3   Interventions     SU
#> 3452  CDASHIG     2.3   Interventions     SU
#> 3453  CDASHIG     2.3   Interventions     SU
#> 3454  CDASHIG     2.3   Interventions     SU
#> 3455  CDASHIG     2.3   Interventions     SU
#> 3456  CDASHIG     2.3   Interventions     SU
#> 3457  CDASHIG     2.3   Interventions     SU
#> 3458  CDASHIG     2.3   Interventions     SU
#> 3459  CDASHIG     2.3          Events     AE
#> 3460  CDASHIG     2.3          Events     AE
#> 3461  CDASHIG     2.3          Events     AE
#> 3462  CDASHIG     2.3          Events     AE
#> 3463  CDASHIG     2.3          Events     AE
#> 3464  CDASHIG     2.3          Events     AE
#> 3465  CDASHIG     2.3          Events     AE
#> 3466  CDASHIG     2.3          Events     AE
#> 3467  CDASHIG     2.3          Events     AE
#> 3468  CDASHIG     2.3          Events     AE
#> 3469  CDASHIG     2.3          Events     AE
#> 3470  CDASHIG     2.3          Events     AE
#> 3471  CDASHIG     2.3          Events     AE
#> 3472  CDASHIG     2.3          Events     AE
#> 3473  CDASHIG     2.3          Events     AE
#> 3474  CDASHIG     2.3          Events     AE
#> 3475  CDASHIG     2.3          Events     AE
#> 3476  CDASHIG     2.3          Events     AE
#> 3477  CDASHIG     2.3          Events     AE
#> 3478  CDASHIG     2.3          Events     AE
#> 3479  CDASHIG     2.3          Events     AE
#> 3480  CDASHIG     2.3          Events     AE
#> 3481  CDASHIG     2.3          Events     AE
#> 3482  CDASHIG     2.3          Events     AE
#> 3483  CDASHIG     2.3          Events     AE
#> 3484  CDASHIG     2.3          Events     AE
#> 3485  CDASHIG     2.3          Events     AE
#> 3486  CDASHIG     2.3          Events     AE
#> 3487  CDASHIG     2.3          Events     AE
#> 3488  CDASHIG     2.3          Events     AE
#> 3489  CDASHIG     2.3          Events     AE
#> 3490  CDASHIG     2.3          Events     AE
#> 3491  CDASHIG     2.3          Events     AE
#> 3492  CDASHIG     2.3          Events     AE
#> 3493  CDASHIG     2.3          Events     AE
#> 3494  CDASHIG     2.3          Events     AE
#> 3495  CDASHIG     2.3          Events     AE
#> 3496  CDASHIG     2.3          Events     AE
#> 3497  CDASHIG     2.3          Events     AE
#> 3498  CDASHIG     2.3          Events     AE
#> 3499  CDASHIG     2.3          Events     AE
#> 3500  CDASHIG     2.3          Events     AE
#> 3501  CDASHIG     2.3          Events     AE
#> 3502  CDASHIG     2.3          Events     AE
#> 3503  CDASHIG     2.3          Events     AE
#> 3504  CDASHIG     2.3          Events     AE
#> 3505  CDASHIG     2.3          Events     AE
#> 3506  CDASHIG     2.3          Events     AE
#> 3507  CDASHIG     2.3          Events     AE
#> 3508  CDASHIG     2.3          Events     AE
#> 3509  CDASHIG     2.3          Events     AE
#> 3510  CDASHIG     2.3          Events     AE
#> 3511  CDASHIG     2.3          Events     AE
#> 3512  CDASHIG     2.3          Events     AE
#> 3513  CDASHIG     2.3          Events     AE
#> 3514  CDASHIG     2.3          Events     CE
#> 3515  CDASHIG     2.3          Events     CE
#> 3516  CDASHIG     2.3          Events     CE
#> 3517  CDASHIG     2.3          Events     CE
#> 3518  CDASHIG     2.3          Events     CE
#> 3519  CDASHIG     2.3          Events     CE
#> 3520  CDASHIG     2.3          Events     CE
#> 3521  CDASHIG     2.3          Events     CE
#> 3522  CDASHIG     2.3          Events     CE
#> 3523  CDASHIG     2.3          Events     CE
#> 3524  CDASHIG     2.3          Events     CE
#> 3525  CDASHIG     2.3          Events     CE
#> 3526  CDASHIG     2.3          Events     CE
#> 3527  CDASHIG     2.3          Events     CE
#> 3528  CDASHIG     2.3          Events     CE
#> 3529  CDASHIG     2.3          Events     CE
#> 3530  CDASHIG     2.3          Events     CE
#> 3531  CDASHIG     2.3          Events     CE
#> 3532  CDASHIG     2.3          Events     CE
#> 3533  CDASHIG     2.3          Events     CE
#> 3534  CDASHIG     2.3          Events     CE
#> 3535  CDASHIG     2.3          Events     CE
#> 3536  CDASHIG     2.3          Events     CE
#> 3537  CDASHIG     2.3          Events     CE
#> 3538  CDASHIG     2.3          Events     CE
#> 3539  CDASHIG     2.3          Events     CE
#> 3540  CDASHIG     2.3          Events     CE
#> 3541  CDASHIG     2.3          Events     CE
#> 3542  CDASHIG     2.3          Events     CE
#> 3543  CDASHIG     2.3          Events     CE
#> 3544  CDASHIG     2.3          Events     CE
#> 3545  CDASHIG     2.3          Events     CE
#> 3546  CDASHIG     2.3          Events     CE
#> 3547  CDASHIG     2.3          Events     DV
#> 3548  CDASHIG     2.3          Events     DV
#> 3549  CDASHIG     2.3          Events     DV
#> 3550  CDASHIG     2.3          Events     DV
#> 3551  CDASHIG     2.3          Events     DV
#> 3552  CDASHIG     2.3          Events     DV
#> 3553  CDASHIG     2.3          Events     DV
#> 3554  CDASHIG     2.3          Events     DV
#> 3555  CDASHIG     2.3          Events     DV
#> 3556  CDASHIG     2.3          Events     DV
#> 3557  CDASHIG     2.3          Events     DV
#> 3558  CDASHIG     2.3          Events     DV
#> 3559  CDASHIG     2.3          Events     DV
#> 3560  CDASHIG     2.3          Events     HO
#> 3561  CDASHIG     2.3          Events     HO
#> 3562  CDASHIG     2.3          Events     HO
#> 3563  CDASHIG     2.3          Events     HO
#> 3564  CDASHIG     2.3          Events     HO
#> 3565  CDASHIG     2.3          Events     HO
#> 3566  CDASHIG     2.3          Events     HO
#> 3567  CDASHIG     2.3          Events     HO
#> 3568  CDASHIG     2.3          Events     HO
#> 3569  CDASHIG     2.3          Events     HO
#> 3570  CDASHIG     2.3          Events     HO
#> 3571  CDASHIG     2.3          Events     HO
#> 3572  CDASHIG     2.3          Events     HO
#> 3573  CDASHIG     2.3          Events     HO
#> 3574  CDASHIG     2.3          Events     HO
#> 3575  CDASHIG     2.3          Events     HO
#> 3576  CDASHIG     2.3          Events     HO
#> 3577  CDASHIG     2.3          Events     HO
#> 3578  CDASHIG     2.3          Events     HO
#> 3579  CDASHIG     2.3          Events     HO
#> 3580  CDASHIG     2.3          Events     HO
#> 3581  CDASHIG     2.3          Events     MH
#> 3582  CDASHIG     2.3          Events     MH
#> 3583  CDASHIG     2.3          Events     MH
#> 3584  CDASHIG     2.3          Events     MH
#> 3585  CDASHIG     2.3          Events     MH
#> 3586  CDASHIG     2.3          Events     MH
#> 3587  CDASHIG     2.3          Events     MH
#> 3588  CDASHIG     2.3          Events     MH
#> 3589  CDASHIG     2.3          Events     MH
#> 3590  CDASHIG     2.3          Events     MH
#> 3591  CDASHIG     2.3          Events     MH
#> 3592  CDASHIG     2.3          Events     MH
#> 3593  CDASHIG     2.3          Events     MH
#> 3594  CDASHIG     2.3          Events     MH
#> 3595  CDASHIG     2.3          Events     MH
#> 3596  CDASHIG     2.3          Events     MH
#> 3597  CDASHIG     2.3          Events     MH
#> 3598  CDASHIG     2.3          Events     MH
#> 3599  CDASHIG     2.3          Events     MH
#> 3600  CDASHIG     2.3          Events     MH
#> 3601  CDASHIG     2.3          Events     MH
#> 3602  CDASHIG     2.3          Events     MH
#> 3603  CDASHIG     2.3          Events     MH
#> 3604  CDASHIG     2.3          Events     MH
#> 3605  CDASHIG     2.3          Events     MH
#> 3606  CDASHIG     2.3          Events     MH
#> 3607  CDASHIG     2.3          Events     MH
#> 3608  CDASHIG     2.3          Events     MH
#> 3609  CDASHIG     2.3          Events     MH
#> 3610  CDASHIG     2.3          Events     MH
#> 3611  CDASHIG     2.3          Events     MH
#> 3612  CDASHIG     2.3          Events     MH
#> 3613  CDASHIG     2.3        Findings     CP
#> 3614  CDASHIG     2.3        Findings     CP
#> 3615  CDASHIG     2.3        Findings     CP
#> 3616  CDASHIG     2.3        Findings     CP
#> 3617  CDASHIG     2.3        Findings     CP
#> 3618  CDASHIG     2.3        Findings     CP
#> 3619  CDASHIG     2.3        Findings     CP
#> 3620  CDASHIG     2.3        Findings     CP
#> 3621  CDASHIG     2.3        Findings     CP
#> 3622  CDASHIG     2.3        Findings     CP
#> 3623  CDASHIG     2.3        Findings     CP
#> 3624  CDASHIG     2.3        Findings     CP
#> 3625  CDASHIG     2.3        Findings     CV
#> 3626  CDASHIG     2.3        Findings     CV
#> 3627  CDASHIG     2.3        Findings     CV
#> 3628  CDASHIG     2.3        Findings     CV
#> 3629  CDASHIG     2.3        Findings     CV
#> 3630  CDASHIG     2.3        Findings     CV
#> 3631  CDASHIG     2.3        Findings     CV
#> 3632  CDASHIG     2.3        Findings     CV
#> 3633  CDASHIG     2.3        Findings     CV
#> 3634  CDASHIG     2.3        Findings     CV
#> 3635  CDASHIG     2.3        Findings     CV
#> 3636  CDASHIG     2.3        Findings     CV
#> 3637  CDASHIG     2.3        Findings     CV
#> 3638  CDASHIG     2.3        Findings     CV
#> 3639  CDASHIG     2.3        Findings     CV
#> 3640  CDASHIG     2.3        Findings     CV
#> 3641  CDASHIG     2.3        Findings     CV
#> 3642  CDASHIG     2.3        Findings     CV
#> 3643  CDASHIG     2.3        Findings     CV
#> 3644  CDASHIG     2.3        Findings     CV
#> 3645  CDASHIG     2.3        Findings     CV
#> 3646  CDASHIG     2.3        Findings     CV
#> 3647  CDASHIG     2.3        Findings     CV
#> 3648  CDASHIG     2.3        Findings     CV
#> 3649  CDASHIG     2.3        Findings     CV
#> 3650  CDASHIG     2.3        Findings     DA
#> 3651  CDASHIG     2.3        Findings     DA
#> 3652  CDASHIG     2.3        Findings     DA
#> 3653  CDASHIG     2.3        Findings     DA
#> 3654  CDASHIG     2.3        Findings     DA
#> 3655  CDASHIG     2.3        Findings     DA
#> 3656  CDASHIG     2.3        Findings     DA
#> 3657  CDASHIG     2.3        Findings     DA
#> 3658  CDASHIG     2.3        Findings     DA
#> 3659  CDASHIG     2.3        Findings     DA
#> 3660  CDASHIG     2.3        Findings     DA
#> 3661  CDASHIG     2.3        Findings     DA
#> 3662  CDASHIG     2.3        Findings     DA
#> 3663  CDASHIG     2.3        Findings     DD
#> 3664  CDASHIG     2.3        Findings     DD
#> 3665  CDASHIG     2.3        Findings     DD
#> 3666  CDASHIG     2.3        Findings     DD
#> 3667  CDASHIG     2.3        Findings     DD
#> 3668  CDASHIG     2.3        Findings     DD
#> 3669  CDASHIG     2.3        Findings     DD
#> 3670  CDASHIG     2.3        Findings     DD
#> 3671  CDASHIG     2.3        Findings     DD
#> 3672  CDASHIG     2.3        Findings     DD
#> 3673  CDASHIG     2.3        Findings     DD
#> 3674  CDASHIG     2.3        Findings     DD
#> 3675  CDASHIG     2.3        Findings     DD
#> 3676  CDASHIG     2.3        Findings     IE
#> 3677  CDASHIG     2.3        Findings     IE
#> 3678  CDASHIG     2.3        Findings     IE
#> 3679  CDASHIG     2.3        Findings     IE
#> 3680  CDASHIG     2.3        Findings     IE
#> 3681  CDASHIG     2.3        Findings     IE
#> 3682  CDASHIG     2.3        Findings     IE
#> 3683  CDASHIG     2.3        Findings     IE
#> 3684  CDASHIG     2.3        Findings     IE
#> 3685  CDASHIG     2.3        Findings     IE
#> 3686  CDASHIG     2.3        Findings     IE
#> 3687  CDASHIG     2.3        Findings     IE
#> 3688  CDASHIG     2.3        Findings     MK
#> 3689  CDASHIG     2.3        Findings     MK
#> 3690  CDASHIG     2.3        Findings     MK
#> 3691  CDASHIG     2.3        Findings     MK
#> 3692  CDASHIG     2.3        Findings     MK
#> 3693  CDASHIG     2.3        Findings     MK
#> 3694  CDASHIG     2.3        Findings     MK
#> 3695  CDASHIG     2.3        Findings     MK
#> 3696  CDASHIG     2.3        Findings     MK
#> 3697  CDASHIG     2.3        Findings     MK
#> 3698  CDASHIG     2.3        Findings     MK
#> 3699  CDASHIG     2.3        Findings     MK
#> 3700  CDASHIG     2.3        Findings     MK
#> 3701  CDASHIG     2.3        Findings     MK
#> 3702  CDASHIG     2.3        Findings     MK
#> 3703  CDASHIG     2.3        Findings     MK
#> 3704  CDASHIG     2.3        Findings     MK
#> 3705  CDASHIG     2.3        Findings     MK
#> 3706  CDASHIG     2.3        Findings     MK
#> 3707  CDASHIG     2.3        Findings     MK
#> 3708  CDASHIG     2.3        Findings     MK
#> 3709  CDASHIG     2.3        Findings     MK
#> 3710  CDASHIG     2.3        Findings     MK
#> 3711  CDASHIG     2.3        Findings     MK
#> 3712  CDASHIG     2.3        Findings     MK
#> 3713  CDASHIG     2.3        Findings     MK
#> 3714  CDASHIG     2.3        Findings     MK
#> 3715  CDASHIG     2.3        Findings     MK
#> 3716  CDASHIG     2.3        Findings     MK
#> 3717  CDASHIG     2.3        Findings     NV
#> 3718  CDASHIG     2.3        Findings     NV
#> 3719  CDASHIG     2.3        Findings     NV
#> 3720  CDASHIG     2.3        Findings     NV
#> 3721  CDASHIG     2.3        Findings     NV
#> 3722  CDASHIG     2.3        Findings     NV
#> 3723  CDASHIG     2.3        Findings     NV
#> 3724  CDASHIG     2.3        Findings     NV
#> 3725  CDASHIG     2.3        Findings     NV
#> 3726  CDASHIG     2.3        Findings     NV
#> 3727  CDASHIG     2.3        Findings     NV
#> 3728  CDASHIG     2.3        Findings     NV
#> 3729  CDASHIG     2.3        Findings     NV
#> 3730  CDASHIG     2.3        Findings     NV
#> 3731  CDASHIG     2.3        Findings     NV
#> 3732  CDASHIG     2.3        Findings     NV
#> 3733  CDASHIG     2.3        Findings     NV
#> 3734  CDASHIG     2.3        Findings     NV
#> 3735  CDASHIG     2.3        Findings     NV
#> 3736  CDASHIG     2.3        Findings     NV
#> 3737  CDASHIG     2.3        Findings     NV
#> 3738  CDASHIG     2.3        Findings     NV
#> 3739  CDASHIG     2.3        Findings     NV
#> 3740  CDASHIG     2.3        Findings     NV
#> 3741  CDASHIG     2.3        Findings     NV
#> 3742  CDASHIG     2.3        Findings     NV
#> 3743  CDASHIG     2.3        Findings     NV
#> 3744  CDASHIG     2.3        Findings     NV
#> 3745  CDASHIG     2.3        Findings     NV
#> 3746  CDASHIG     2.3        Findings     NV
#> 3747  CDASHIG     2.3        Findings     NV
#> 3748  CDASHIG     2.3        Findings     OE
#> 3749  CDASHIG     2.3        Findings     OE
#> 3750  CDASHIG     2.3        Findings     OE
#> 3751  CDASHIG     2.3        Findings     OE
#> 3752  CDASHIG     2.3        Findings     OE
#> 3753  CDASHIG     2.3        Findings     OE
#> 3754  CDASHIG     2.3        Findings     OE
#> 3755  CDASHIG     2.3        Findings     OE
#> 3756  CDASHIG     2.3        Findings     OE
#> 3757  CDASHIG     2.3        Findings     OE
#> 3758  CDASHIG     2.3        Findings     OE
#> 3759  CDASHIG     2.3        Findings     OE
#> 3760  CDASHIG     2.3        Findings     OE
#> 3761  CDASHIG     2.3        Findings     OE
#> 3762  CDASHIG     2.3        Findings     OE
#> 3763  CDASHIG     2.3        Findings     OE
#> 3764  CDASHIG     2.3        Findings     OE
#> 3765  CDASHIG     2.3        Findings     OE
#> 3766  CDASHIG     2.3        Findings     OE
#> 3767  CDASHIG     2.3        Findings     OE
#> 3768  CDASHIG     2.3        Findings     OE
#> 3769  CDASHIG     2.3        Findings     OE
#> 3770  CDASHIG     2.3        Findings     OE
#> 3771  CDASHIG     2.3        Findings     OE
#> 3772  CDASHIG     2.3        Findings     OE
#> 3773  CDASHIG     2.3        Findings     OE
#> 3774  CDASHIG     2.3        Findings     OE
#> 3775  CDASHIG     2.3        Findings     OE
#> 3776  CDASHIG     2.3        Findings     OE
#> 3777  CDASHIG     2.3        Findings     OE
#> 3778  CDASHIG     2.3        Findings     OE
#> 3779  CDASHIG     2.3        Findings     OE
#> 3780  CDASHIG     2.3        Findings     RE
#> 3781  CDASHIG     2.3        Findings     RE
#> 3782  CDASHIG     2.3        Findings     RE
#> 3783  CDASHIG     2.3        Findings     RE
#> 3784  CDASHIG     2.3        Findings     RE
#> 3785  CDASHIG     2.3        Findings     RE
#> 3786  CDASHIG     2.3        Findings     RE
#> 3787  CDASHIG     2.3        Findings     RE
#> 3788  CDASHIG     2.3        Findings     RE
#> 3789  CDASHIG     2.3        Findings     RE
#> 3790  CDASHIG     2.3        Findings     RE
#> 3791  CDASHIG     2.3        Findings     RE
#> 3792  CDASHIG     2.3        Findings     RE
#> 3793  CDASHIG     2.3        Findings     RE
#> 3794  CDASHIG     2.3        Findings     RE
#> 3795  CDASHIG     2.3        Findings     RE
#> 3796  CDASHIG     2.3        Findings     RE
#> 3797  CDASHIG     2.3        Findings     RE
#> 3798  CDASHIG     2.3        Findings     RE
#> 3799  CDASHIG     2.3        Findings     RE
#> 3800  CDASHIG     2.3        Findings     RE
#> 3801  CDASHIG     2.3        Findings     RE
#> 3802  CDASHIG     2.3        Findings     RE
#> 3803  CDASHIG     2.3        Findings     RE
#> 3804  CDASHIG     2.3        Findings     RE
#> 3805  CDASHIG     2.3        Findings     RE
#> 3806  CDASHIG     2.3        Findings     RE
#> 3807  CDASHIG     2.3        Findings     RE
#> 3808  CDASHIG     2.3        Findings     RE
#> 3809  CDASHIG     2.3        Findings     RE
#> 3810  CDASHIG     2.3        Findings     RE
#> 3811  CDASHIG     2.3        Findings     RE
#> 3812  CDASHIG     2.3        Findings     RP
#> 3813  CDASHIG     2.3        Findings     RP
#> 3814  CDASHIG     2.3        Findings     RP
#> 3815  CDASHIG     2.3        Findings     RP
#> 3816  CDASHIG     2.3        Findings     RP
#> 3817  CDASHIG     2.3        Findings     RP
#> 3818  CDASHIG     2.3        Findings     RP
#> 3819  CDASHIG     2.3        Findings     RP
#> 3820  CDASHIG     2.3        Findings     RP
#> 3821  CDASHIG     2.3        Findings     RP
#> 3822  CDASHIG     2.3        Findings     RP
#> 3823  CDASHIG     2.3        Findings     RP
#> 3824  CDASHIG     2.3        Findings     RP
#> 3825  CDASHIG     2.3        Findings     RP
#> 3826  CDASHIG     2.3        Findings     RP
#> 3827  CDASHIG     2.3        Findings     RS
#> 3828  CDASHIG     2.3        Findings     RS
#> 3829  CDASHIG     2.3        Findings     RS
#> 3830  CDASHIG     2.3        Findings     RS
#> 3831  CDASHIG     2.3        Findings     RS
#> 3832  CDASHIG     2.3        Findings     RS
#> 3833  CDASHIG     2.3        Findings     RS
#> 3834  CDASHIG     2.3        Findings     RS
#> 3835  CDASHIG     2.3        Findings     RS
#> 3836  CDASHIG     2.3        Findings     RS
#> 3837  CDASHIG     2.3        Findings     RS
#> 3838  CDASHIG     2.3        Findings     RS
#> 3839  CDASHIG     2.3        Findings     RS
#> 3840  CDASHIG     2.3        Findings     RS
#> 3841  CDASHIG     2.3        Findings     RS
#> 3842  CDASHIG     2.3        Findings     RS
#> 3843  CDASHIG     2.3        Findings     RS
#> 3844  CDASHIG     2.3        Findings     SC
#> 3845  CDASHIG     2.3        Findings     SC
#> 3846  CDASHIG     2.3        Findings     SC
#> 3847  CDASHIG     2.3        Findings     SC
#> 3848  CDASHIG     2.3        Findings     SC
#> 3849  CDASHIG     2.3        Findings     SC
#> 3850  CDASHIG     2.3        Findings     SC
#> 3851  CDASHIG     2.3        Findings     SC
#> 3852  CDASHIG     2.3        Findings     SC
#> 3853  CDASHIG     2.3        Findings     SC
#> 3854  CDASHIG     2.3        Findings     SC
#> 3855  CDASHIG     2.3        Findings     SC
#> 3856  CDASHIG     2.3        Findings     TR
#> 3857  CDASHIG     2.3        Findings     TR
#> 3858  CDASHIG     2.3        Findings     TR
#> 3859  CDASHIG     2.3        Findings     TR
#> 3860  CDASHIG     2.3        Findings     TR
#> 3861  CDASHIG     2.3        Findings     TR
#> 3862  CDASHIG     2.3        Findings     TR
#> 3863  CDASHIG     2.3        Findings     TR
#> 3864  CDASHIG     2.3        Findings     TR
#> 3865  CDASHIG     2.3        Findings     TR
#> 3866  CDASHIG     2.3        Findings     TR
#> 3867  CDASHIG     2.3        Findings     TR
#> 3868  CDASHIG     2.3        Findings     TR
#> 3869  CDASHIG     2.3        Findings     TR
#> 3870  CDASHIG     2.3        Findings     TR
#> 3871  CDASHIG     2.3        Findings     TR
#> 3872  CDASHIG     2.3        Findings     TR
#> 3873  CDASHIG     2.3        Findings     TR
#> 3874  CDASHIG     2.3        Findings     TU
#> 3875  CDASHIG     2.3        Findings     TU
#> 3876  CDASHIG     2.3        Findings     TU
#> 3877  CDASHIG     2.3        Findings     TU
#> 3878  CDASHIG     2.3        Findings     TU
#> 3879  CDASHIG     2.3        Findings     TU
#> 3880  CDASHIG     2.3        Findings     TU
#> 3881  CDASHIG     2.3        Findings     TU
#> 3882  CDASHIG     2.3        Findings     TU
#> 3883  CDASHIG     2.3        Findings     TU
#> 3884  CDASHIG     2.3        Findings     TU
#> 3885  CDASHIG     2.3        Findings     TU
#> 3886  CDASHIG     2.3        Findings     TU
#> 3887  CDASHIG     2.3        Findings     TU
#> 3888  CDASHIG     2.3        Findings     TU
#> 3889  CDASHIG     2.3        Findings     TU
#> 3890  CDASHIG     2.3        Findings     TU
#> 3891  CDASHIG     2.3        Findings     TU
#> 3892  CDASHIG     2.3        Findings     TU
#> 3893  CDASHIG     2.3        Findings     TU
#> 3894  CDASHIG     2.3        Findings     TU
#> 3895  CDASHIG     2.3        Findings     TU
#> 3896  CDASHIG     2.3        Findings     UR
#> 3897  CDASHIG     2.3        Findings     UR
#> 3898  CDASHIG     2.3        Findings     UR
#> 3899  CDASHIG     2.3        Findings     UR
#> 3900  CDASHIG     2.3        Findings     UR
#> 3901  CDASHIG     2.3        Findings     UR
#> 3902  CDASHIG     2.3        Findings     UR
#> 3903  CDASHIG     2.3        Findings     UR
#> 3904  CDASHIG     2.3        Findings     UR
#> 3905  CDASHIG     2.3        Findings     UR
#> 3906  CDASHIG     2.3        Findings     UR
#> 3907  CDASHIG     2.3        Findings     UR
#> 3908  CDASHIG     2.3        Findings     UR
#> 3909  CDASHIG     2.3        Findings     UR
#> 3910  CDASHIG     2.3        Findings     UR
#> 3911  CDASHIG     2.3        Findings     UR
#> 3912  CDASHIG     2.3        Findings     UR
#> 3913  CDASHIG     2.3        Findings     UR
#> 3914  CDASHIG     2.3        Findings     UR
#> 3915  CDASHIG     2.3        Findings     UR
#> 3916  CDASHIG     2.3        Findings     UR
#> 3917  CDASHIG     2.3        Findings     UR
#> 3918  CDASHIG     2.3        Findings     UR
#> 3919  CDASHIG     2.3        Findings     UR
#> 3920  CDASHIG     2.3        Findings     UR
#> 3921  CDASHIG     2.3        Findings     UR
#> 3922  CDASHIG     2.3        Findings     UR
#> 3923  CDASHIG     2.3        Findings     UR
#> 3924  CDASHIG     2.3        Findings     VS
#> 3925  CDASHIG     2.3        Findings     VS
#> 3926  CDASHIG     2.3        Findings     VS
#> 3927  CDASHIG     2.3        Findings     VS
#> 3928  CDASHIG     2.3        Findings     VS
#> 3929  CDASHIG     2.3        Findings     VS
#> 3930  CDASHIG     2.3        Findings     VS
#> 3931  CDASHIG     2.3        Findings     VS
#> 3932  CDASHIG     2.3        Findings     VS
#> 3933  CDASHIG     2.3        Findings     VS
#> 3934  CDASHIG     2.3        Findings     VS
#> 3935  CDASHIG     2.3        Findings     VS
#> 3936  CDASHIG     2.3        Findings     VS
#> 3937  CDASHIG     2.3        Findings     VS
#> 3938  CDASHIG     2.3        Findings     VS
#> 3939  CDASHIG     2.3        Findings     VS
#> 3940  CDASHIG     2.3        Findings     VS
#> 3941  CDASHIG     2.3        Findings     VS
#> 3942  CDASHIG     2.3        Findings     VS
#> 3943  CDASHIG     2.3        Findings     VS
#> 3944  CDASHIG     2.3        Findings     VS
#> 3945  CDASHIG     2.3        Findings     VS
#> 3946  CDASHIG     2.3  Findings About     FA
#> 3947  CDASHIG     2.3  Findings About     FA
#> 3948  CDASHIG     2.3  Findings About     FA
#> 3949  CDASHIG     2.3  Findings About     FA
#> 3950  CDASHIG     2.3  Findings About     FA
#> 3951  CDASHIG     2.3  Findings About     FA
#> 3952  CDASHIG     2.3  Findings About     FA
#> 3953  CDASHIG     2.3  Findings About     FA
#> 3954  CDASHIG     2.3  Findings About     FA
#> 3955  CDASHIG     2.3  Findings About     FA
#> 3956  CDASHIG     2.3  Findings About     FA
#> 3957  CDASHIG     2.3  Findings About     FA
#> 3958  CDASHIG     2.3  Findings About     FA
#> 3959  CDASHIG     2.3  Findings About     FA
#> 3960  CDASHIG     2.3  Findings About     FA
#> 3961  CDASHIG     2.3  Findings About     FA
#> 3962  CDASHIG     2.3  Findings About     FA
#> 3963  CDASHIG     2.3  Findings About     FA
#> 3964  CDASHIG     2.3  Findings About     FA
#> 3965  CDASHIG     2.3  Findings About     FA
#> 3966  CDASHIG     2.3  Findings About     FA
#> 3967  CDASHIG     2.3  Findings About     FA
#> 3968  CDASHIG     2.3  Findings About     FA
#> 3969  CDASHIG     2.3  Findings About     FA
#> 3970  CDASHIG     2.3  Findings About     FA
#> 3971  CDASHIG     2.3  Findings About     FA
#> 3972  CDASHIG     2.3  Findings About     FA
#> 3973  CDASHIG     2.3  Findings About     FA
#> 3974  CDASHIG     2.3  Findings About     FA
#> 3975  CDASHIG     2.3  Findings About     FA
#> 3976  CDASHIG     2.3  Findings About     FA
#> 3977  CDASHIG     2.3  Findings About     FA
#> 3978  CDASHIG     2.3  Findings About     FA
#> 3979  CDASHIG     2.3  Findings About     FA
#> 3980  CDASHIG     2.3  Findings About     SR
#> 3981  CDASHIG     2.3  Findings About     SR
#> 3982  CDASHIG     2.3  Findings About     SR
#> 3983  CDASHIG     2.3  Findings About     SR
#> 3984  CDASHIG     2.3  Findings About     SR
#> 3985  CDASHIG     2.3  Findings About     SR
#> 3986  CDASHIG     2.3  Findings About     SR
#> 3987  CDASHIG     2.3  Findings About     SR
#> 3988  CDASHIG     2.3  Findings About     SR
#> 3989  CDASHIG     2.3  Findings About     SR
#> 3990  CDASHIG     2.3  Findings About     SR
#> 3991  CDASHIG     2.3  Findings About     SR
#> 3992  CDASHIG     2.3  Findings About     SR
#> 3993  CDASHIG     2.3  Findings About     SR
#> 3994  CDASHIG     2.3  Findings About     SR
#> 3995  CDASHIG     2.3  Findings About     SR
#> 3996  CDASHIG     2.3  Findings About     SR
#> 3997  CDASHIG     2.3  Findings About     SR
#> 3998  CDASHIG     2.3  Findings About     SR
#> 3999  CDASHIG     2.3  Findings About     SR
#> 4000  CDASHIG     2.3  Findings About     SR
#> 4001  CDASHIG     2.3  Findings About     SR
#> 4002  CDASHIG     2.3  Findings About     SR
#> 4003  CDASHIG     2.3  Findings About     SR
#> 4004  CDASHIG     2.3  Findings About     SR
#> 4005  CDASHIG     2.3  Findings About     SR
#> 4006  CDASHIG     2.3 Special-Purpose     CO
#> 4007  CDASHIG     2.3 Special-Purpose     CO
#> 4008  CDASHIG     2.3 Special-Purpose     CO
#> 4009  CDASHIG     2.3 Special-Purpose     CO
#> 4010  CDASHIG     2.3          Events     DS
#> 4011  CDASHIG     2.3          Events     DS
#> 4012  CDASHIG     2.3          Events     DS
#> 4013  CDASHIG     2.3          Events     DS
#> 4014  CDASHIG     2.3          Events     DS
#> 4015  CDASHIG     2.3          Events     DS
#> 4016  CDASHIG     2.3          Events     DS
#> 4017  CDASHIG     2.3          Events     DS
#> 4018  CDASHIG     2.3          Events     DS
#> 4019  CDASHIG     2.3          Events     DS
#> 4020  CDASHIG     2.3          Events     DS
#> 4021  CDASHIG     2.3          Events     DS
#> 4022  CDASHIG     2.3          Events     DS
#> 4023  CDASHIG     2.3          Events     DS
#> 4024  CDASHIG     2.3          Events     DS
#> 4025  CDASHIG     2.3          Events     DS
#> 4026  CDASHIG     2.3          Events     DS
#> 4027  CDASHIG     2.3          Events     DS
#> 4028  CDASHIG     2.3          Events     DS
#> 4029  CDASHIG     2.3          Events     DS
#> 4030  CDASHIG     2.3          Events     DS
#> 4031  CDASHIG     2.3          Events     DS
#> 4032  CDASHIG     2.3          Events     DS
#> 4033  CDASHIG     2.3          Events     DS
#> 4034  CDASHIG     2.3          Events     SA
#> 4035  CDASHIG     2.3          Events     SA
#> 4036  CDASHIG     2.3          Events     SA
#> 4037  CDASHIG     2.3          Events     SA
#> 4038  CDASHIG     2.3          Events     SA
#> 4039  CDASHIG     2.3          Events     SA
#> 4040  CDASHIG     2.3          Events     SA
#> 4041  CDASHIG     2.3          Events     SA
#> 4042  CDASHIG     2.3          Events     SA
#> 4043  CDASHIG     2.3          Events     SA
#> 4044  CDASHIG     2.3          Events     SA
#> 4045  CDASHIG     2.3          Events     SA
#> 4046  CDASHIG     2.3          Events     SA
#> 4047  CDASHIG     2.3          Events     SA
#> 4048  CDASHIG     2.3          Events     SA
#> 4049  CDASHIG     2.3          Events     SA
#> 4050  CDASHIG     2.3          Events     SA
#> 4051  CDASHIG     2.3          Events     SA
#> 4052  CDASHIG     2.3          Events     SA
#> 4053  CDASHIG     2.3          Events     SA
#> 4054  CDASHIG     2.3          Events     SA
#> 4055  CDASHIG     2.3          Events     SA
#> 4056  CDASHIG     2.3        Findings     DA
#> 4057  CDASHIG     2.3        Findings     DA
#> 4058  CDASHIG     2.3        Findings     DA
#> 4059  CDASHIG     2.3        Findings     DA
#> 4060  CDASHIG     2.3        Findings     DA
#> 4061  CDASHIG     2.3        Findings     DA
#> 4062  CDASHIG     2.3        Findings     DA
#> 4063  CDASHIG     2.3        Findings     DA
#> 4064  CDASHIG     2.3        Findings     DA
#> 4065  CDASHIG     2.3        Findings     DA
#> 4066  CDASHIG     2.3        Findings     DA
#> 4067  CDASHIG     2.3        Findings     DA
#> 4068  CDASHIG     2.3        Findings     DA
#> 4069  CDASHIG     2.3        Findings     DD
#> 4070  CDASHIG     2.3        Findings     DD
#> 4071  CDASHIG     2.3        Findings     DD
#> 4072  CDASHIG     2.3        Findings     DD
#> 4073  CDASHIG     2.3        Findings     DD
#> 4074  CDASHIG     2.3        Findings     DD
#> 4075  CDASHIG     2.3        Findings     DD
#> 4076  CDASHIG     2.3        Findings     DD
#> 4077  CDASHIG     2.3        Findings     DD
#> 4078  CDASHIG     2.3        Findings     DD
#> 4079  CDASHIG     2.3        Findings     DD
#> 4080  CDASHIG     2.3        Findings     DD
#> 4081  CDASHIG     2.3        Findings     EG
#> 4082  CDASHIG     2.3        Findings     EG
#> 4083  CDASHIG     2.3        Findings     EG
#> 4084  CDASHIG     2.3        Findings     EG
#> 4085  CDASHIG     2.3        Findings     EG
#> 4086  CDASHIG     2.3        Findings     EG
#> 4087  CDASHIG     2.3        Findings     EG
#> 4088  CDASHIG     2.3        Findings     EG
#> 4089  CDASHIG     2.3        Findings     EG
#> 4090  CDASHIG     2.3        Findings     EG
#> 4091  CDASHIG     2.3        Findings     EG
#> 4092  CDASHIG     2.3        Findings     EG
#> 4093  CDASHIG     2.3        Findings     EG
#> 4094  CDASHIG     2.3        Findings     EG
#> 4095  CDASHIG     2.3        Findings     EG
#> 4096  CDASHIG     2.3        Findings     EG
#> 4097  CDASHIG     2.3        Findings     EG
#> 4098  CDASHIG     2.3        Findings     EG
#> 4099  CDASHIG     2.3        Findings     EG
#> 4100  CDASHIG     2.3        Findings     EG
#> 4101  CDASHIG     2.3        Findings     EG
#> 4102  CDASHIG     2.3        Findings     EG
#> 4103  CDASHIG     2.3        Findings     EG
#> 4104  CDASHIG     2.3        Findings     EG
#> 4105  CDASHIG     2.3        Findings     EG
#> 4106  CDASHIG     2.3        Findings     EG
#> 4107  CDASHIG     2.3        Findings     EG
#> 4108  CDASHIG     2.3        Findings     EG
#> 4109  CDASHIG     2.3        Findings     EG
#> 4110  CDASHIG     2.3        Findings     EG
#> 4111  CDASHIG     2.3        Findings     EG
#> 4112  CDASHIG     2.3        Findings     EG
#> 4113  CDASHIG     2.3        Findings     EG
#> 4114  CDASHIG     2.3        Findings     EG
#> 4115  CDASHIG     2.3        Findings     EG
#> 4116  CDASHIG     2.3        Findings     EG
#> 4117  CDASHIG     2.3        Findings     EG
#> 4118  CDASHIG     2.3        Findings     EG
#> 4119  CDASHIG     2.3        Findings     EG
#> 4120  CDASHIG     2.3        Findings     EG
#> 4121  CDASHIG     2.3        Findings     EG
#> 4122  CDASHIG     2.3        Findings     EG
#> 4123  CDASHIG     2.3        Findings     EG
#> 4124  CDASHIG     2.3        Findings     EG
#> 4125  CDASHIG     2.3        Findings     EG
#> 4126  CDASHIG     2.3        Findings     EG
#> 4127  CDASHIG     2.3        Findings     EG
#> 4128  CDASHIG     2.3        Findings     EG
#> 4129  CDASHIG     2.3        Findings     EG
#> 4130  CDASHIG     2.3        Findings     EG
#> 4131  CDASHIG     2.3        Findings     EG
#> 4132  CDASHIG     2.3        Findings     EG
#> 4133  CDASHIG     2.3        Findings     EG
#> 4134  CDASHIG     2.3        Findings     EG
#> 4135  CDASHIG     2.3        Findings     EG
#> 4136  CDASHIG     2.3        Findings     EG
#> 4137  CDASHIG     2.3        Findings     GF
#> 4138  CDASHIG     2.3        Findings     GF
#> 4139  CDASHIG     2.3        Findings     GF
#> 4140  CDASHIG     2.3        Findings     GF
#> 4141  CDASHIG     2.3        Findings     GF
#> 4142  CDASHIG     2.3        Findings     GF
#> 4143  CDASHIG     2.3        Findings     GF
#> 4144  CDASHIG     2.3        Findings     GF
#> 4145  CDASHIG     2.3        Findings     GF
#> 4146  CDASHIG     2.3        Findings     GF
#> 4147  CDASHIG     2.3        Findings     GF
#> 4148  CDASHIG     2.3        Findings     GF
#> 4149  CDASHIG     2.3        Findings     GF
#> 4150  CDASHIG     2.3        Findings     GF
#> 4151  CDASHIG     2.3        Findings     GF
#> 4152  CDASHIG     2.3        Findings     GF
#> 4153  CDASHIG     2.3        Findings     GF
#> 4154  CDASHIG     2.3        Findings     GF
#> 4155  CDASHIG     2.3        Findings     GF
#> 4156  CDASHIG     2.3        Findings     GF
#> 4157  CDASHIG     2.3        Findings     GF
#> 4158  CDASHIG     2.3        Findings     GF
#> 4159  CDASHIG     2.3        Findings     GF
#> 4160  CDASHIG     2.3        Findings     GF
#> 4161  CDASHIG     2.3        Findings     GF
#> 4162  CDASHIG     2.3        Findings     GF
#> 4163  CDASHIG     2.3        Findings     GF
#> 4164  CDASHIG     2.3        Findings     GF
#> 4165  CDASHIG     2.3        Findings     GF
#> 4166  CDASHIG     2.3        Findings     LB
#> 4167  CDASHIG     2.3        Findings     LB
#> 4168  CDASHIG     2.3        Findings     LB
#> 4169  CDASHIG     2.3        Findings     LB
#> 4170  CDASHIG     2.3        Findings     LB
#> 4171  CDASHIG     2.3        Findings     LB
#> 4172  CDASHIG     2.3        Findings     LB
#> 4173  CDASHIG     2.3        Findings     LB
#> 4174  CDASHIG     2.3        Findings     LB
#> 4175  CDASHIG     2.3        Findings     LB
#> 4176  CDASHIG     2.3        Findings     LB
#> 4177  CDASHIG     2.3        Findings     LB
#> 4178  CDASHIG     2.3        Findings     LB
#> 4179  CDASHIG     2.3        Findings     LB
#> 4180  CDASHIG     2.3        Findings     LB
#> 4181  CDASHIG     2.3        Findings     LB
#> 4182  CDASHIG     2.3        Findings     LB
#> 4183  CDASHIG     2.3        Findings     LB
#> 4184  CDASHIG     2.3        Findings     LB
#> 4185  CDASHIG     2.3        Findings     LB
#> 4186  CDASHIG     2.3        Findings     LB
#> 4187  CDASHIG     2.3        Findings     LB
#> 4188  CDASHIG     2.3        Findings     LB
#> 4189  CDASHIG     2.3        Findings     LB
#> 4190  CDASHIG     2.3        Findings     LB
#> 4191  CDASHIG     2.3        Findings     LB
#> 4192  CDASHIG     2.3        Findings     LB
#> 4193  CDASHIG     2.3        Findings     LB
#> 4194  CDASHIG     2.3        Findings     LB
#> 4195  CDASHIG     2.3        Findings     LB
#> 4196  CDASHIG     2.3        Findings     LB
#> 4197  CDASHIG     2.3        Findings     LB
#> 4198  CDASHIG     2.3        Findings     LB
#> 4199  CDASHIG     2.3        Findings     LB
#> 4200  CDASHIG     2.3        Findings     LB
#> 4201  CDASHIG     2.3        Findings     LB
#> 4202  CDASHIG     2.3        Findings     LB
#> 4203  CDASHIG     2.3        Findings     LB
#> 4204  CDASHIG     2.3        Findings     LB
#> 4205  CDASHIG     2.3        Findings     LB
#> 4206  CDASHIG     2.3        Findings     LB
#> 4207  CDASHIG     2.3        Findings     LB
#> 4208  CDASHIG     2.3        Findings     LB
#> 4209  CDASHIG     2.3        Findings     LB
#> 4210  CDASHIG     2.3        Findings     LB
#> 4211  CDASHIG     2.3        Findings     LB
#> 4212  CDASHIG     2.3        Findings     LB
#> 4213  CDASHIG     2.3        Findings     LB
#> 4214  CDASHIG     2.3        Findings     LB
#> 4215  CDASHIG     2.3        Findings     LB
#> 4216  CDASHIG     2.3        Findings     LB
#> 4217  CDASHIG     2.3        Findings     LB
#> 4218  CDASHIG     2.3        Findings     LB
#> 4219  CDASHIG     2.3        Findings     LB
#> 4220  CDASHIG     2.3        Findings     LB
#> 4221  CDASHIG     2.3        Findings     LB
#> 4222  CDASHIG     2.3        Findings     LB
#> 4223  CDASHIG     2.3        Findings     LB
#> 4224  CDASHIG     2.3        Findings     LB
#> 4225  CDASHIG     2.3        Findings     LB
#> 4226  CDASHIG     2.3        Findings     LB
#> 4227  CDASHIG     2.3        Findings     LB
#> 4228  CDASHIG     2.3        Findings     MB
#> 4229  CDASHIG     2.3        Findings     MB
#> 4230  CDASHIG     2.3        Findings     MB
#> 4231  CDASHIG     2.3        Findings     MB
#> 4232  CDASHIG     2.3        Findings     MB
#> 4233  CDASHIG     2.3        Findings     MB
#> 4234  CDASHIG     2.3        Findings     MB
#> 4235  CDASHIG     2.3        Findings     MB
#> 4236  CDASHIG     2.3        Findings     MB
#> 4237  CDASHIG     2.3        Findings     MB
#> 4238  CDASHIG     2.3        Findings     MB
#> 4239  CDASHIG     2.3        Findings     MB
#> 4240  CDASHIG     2.3        Findings     MB
#> 4241  CDASHIG     2.3        Findings     MB
#> 4242  CDASHIG     2.3        Findings     MB
#> 4243  CDASHIG     2.3        Findings     MB
#> 4244  CDASHIG     2.3        Findings     MB
#> 4245  CDASHIG     2.3        Findings     MB
#> 4246  CDASHIG     2.3        Findings     MB
#> 4247  CDASHIG     2.3        Findings     MB
#> 4248  CDASHIG     2.3        Findings     MB
#> 4249  CDASHIG     2.3        Findings     MB
#> 4250  CDASHIG     2.3        Findings     MB
#> 4251  CDASHIG     2.3        Findings     MB
#> 4252  CDASHIG     2.3        Findings     MB
#> 4253  CDASHIG     2.3        Findings     MB
#> 4254  CDASHIG     2.3        Findings     MB
#> 4255  CDASHIG     2.3        Findings     MB
#> 4256  CDASHIG     2.3        Findings     MB
#> 4257  CDASHIG     2.3        Findings     MB
#> 4258  CDASHIG     2.3        Findings     MB
#> 4259  CDASHIG     2.3        Findings     MB
#> 4260  CDASHIG     2.3        Findings     MB
#> 4261  CDASHIG     2.3        Findings     MB
#> 4262  CDASHIG     2.3        Findings     MB
#> 4263  CDASHIG     2.3        Findings     MB
#> 4264  CDASHIG     2.3        Findings     MB
#> 4265  CDASHIG     2.3        Findings     MB
#> 4266  CDASHIG     2.3        Findings     MB
#> 4267  CDASHIG     2.3        Findings     MB
#> 4268  CDASHIG     2.3        Findings     MB
#> 4269  CDASHIG     2.3        Findings     MB
#> 4270  CDASHIG     2.3        Findings     MB
#> 4271  CDASHIG     2.3        Findings     MB
#> 4272  CDASHIG     2.3        Findings     MB
#> 4273  CDASHIG     2.3        Findings     MI
#> 4274  CDASHIG     2.3        Findings     MI
#> 4275  CDASHIG     2.3        Findings     MI
#> 4276  CDASHIG     2.3        Findings     MI
#> 4277  CDASHIG     2.3        Findings     MI
#> 4278  CDASHIG     2.3        Findings     MI
#> 4279  CDASHIG     2.3        Findings     MI
#> 4280  CDASHIG     2.3        Findings     MI
#> 4281  CDASHIG     2.3        Findings     MI
#> 4282  CDASHIG     2.3        Findings     MI
#> 4283  CDASHIG     2.3        Findings     MI
#> 4284  CDASHIG     2.3        Findings     MI
#> 4285  CDASHIG     2.3        Findings     MI
#> 4286  CDASHIG     2.3        Findings     MI
#> 4287  CDASHIG     2.3        Findings     MI
#> 4288  CDASHIG     2.3        Findings     MI
#> 4289  CDASHIG     2.3        Findings     MI
#> 4290  CDASHIG     2.3        Findings     MI
#> 4291  CDASHIG     2.3        Findings     MI
#> 4292  CDASHIG     2.3        Findings     MI
#> 4293  CDASHIG     2.3        Findings     MI
#> 4294  CDASHIG     2.3        Findings     MI
#> 4295  CDASHIG     2.3        Findings     MI
#> 4296  CDASHIG     2.3        Findings     MI
#> 4297  CDASHIG     2.3        Findings     MI
#> 4298  CDASHIG     2.3        Findings     MI
#> 4299  CDASHIG     2.3        Findings     MI
#> 4300  CDASHIG     2.3        Findings     MI
#> 4301  CDASHIG     2.3        Findings     MI
#> 4302  CDASHIG     2.3        Findings     MI
#> 4303  CDASHIG     2.3        Findings     MI
#> 4304  CDASHIG     2.3        Findings     MI
#> 4305  CDASHIG     2.3        Findings     MI
#> 4306  CDASHIG     2.3        Findings     MI
#> 4307  CDASHIG     2.3        Findings     MI
#> 4308  CDASHIG     2.3        Findings     MI
#> 4309  CDASHIG     2.3        Findings     MI
#> 4310  CDASHIG     2.3        Findings     MI
#> 4311  CDASHIG     2.3        Findings     MI
#> 4312  CDASHIG     2.3        Findings     MI
#> 4313  CDASHIG     2.3        Findings     MI
#> 4314  CDASHIG     2.3        Findings     MI
#> 4315  CDASHIG     2.3        Findings     MS
#> 4316  CDASHIG     2.3        Findings     MS
#> 4317  CDASHIG     2.3        Findings     MS
#> 4318  CDASHIG     2.3        Findings     MS
#> 4319  CDASHIG     2.3        Findings     MS
#> 4320  CDASHIG     2.3        Findings     MS
#> 4321  CDASHIG     2.3        Findings     MS
#> 4322  CDASHIG     2.3        Findings     MS
#> 4323  CDASHIG     2.3        Findings     MS
#> 4324  CDASHIG     2.3        Findings     MS
#> 4325  CDASHIG     2.3        Findings     MS
#> 4326  CDASHIG     2.3        Findings     MS
#> 4327  CDASHIG     2.3        Findings     MS
#> 4328  CDASHIG     2.3        Findings     MS
#> 4329  CDASHIG     2.3        Findings     MS
#> 4330  CDASHIG     2.3        Findings     MS
#> 4331  CDASHIG     2.3        Findings     MS
#> 4332  CDASHIG     2.3        Findings     MS
#> 4333  CDASHIG     2.3        Findings     MS
#> 4334  CDASHIG     2.3        Findings     MS
#> 4335  CDASHIG     2.3        Findings     MS
#> 4336  CDASHIG     2.3        Findings     MS
#> 4337  CDASHIG     2.3        Findings     MS
#> 4338  CDASHIG     2.3        Findings     MS
#> 4339  CDASHIG     2.3        Findings     MS
#> 4340  CDASHIG     2.3        Findings     MS
#> 4341  CDASHIG     2.3        Findings     MS
#> 4342  CDASHIG     2.3        Findings     MS
#> 4343  CDASHIG     2.3        Findings     MS
#> 4344  CDASHIG     2.3        Findings     MS
#> 4345  CDASHIG     2.3        Findings     MS
#> 4346  CDASHIG     2.3        Findings     MS
#> 4347  CDASHIG     2.3        Findings     MS
#> 4348  CDASHIG     2.3        Findings     MS
#> 4349  CDASHIG     2.3        Findings     MS
#> 4350  CDASHIG     2.3        Findings     MS
#> 4351  CDASHIG     2.3        Findings     MS
#> 4352  CDASHIG     2.3        Findings     MS
#> 4353  CDASHIG     2.3        Findings     MS
#> 4354  CDASHIG     2.3        Findings     MS
#> 4355  CDASHIG     2.3        Findings     MS
#> 4356  CDASHIG     2.3        Findings     MS
#> 4357  CDASHIG     2.3        Findings     MS
#> 4358  CDASHIG     2.3        Findings     MS
#> 4359  CDASHIG     2.3        Findings     MS
#> 4360  CDASHIG     2.3        Findings     MS
#> 4361  CDASHIG     2.3        Findings     MS
#> 4362  CDASHIG     2.3        Findings     MS
#> 4363  CDASHIG     2.3        Findings     PC
#> 4364  CDASHIG     2.3        Findings     PC
#> 4365  CDASHIG     2.3        Findings     PC
#> 4366  CDASHIG     2.3        Findings     PC
#> 4367  CDASHIG     2.3        Findings     PC
#> 4368  CDASHIG     2.3        Findings     PC
#> 4369  CDASHIG     2.3        Findings     PC
#> 4370  CDASHIG     2.3        Findings     PC
#> 4371  CDASHIG     2.3        Findings     PC
#> 4372  CDASHIG     2.3        Findings     PC
#> 4373  CDASHIG     2.3        Findings     PC
#> 4374  CDASHIG     2.3        Findings     PC
#> 4375  CDASHIG     2.3        Findings     PC
#> 4376  CDASHIG     2.3        Findings     PC
#> 4377  CDASHIG     2.3        Findings     PC
#> 4378  CDASHIG     2.3        Findings     PC
#> 4379  CDASHIG     2.3        Findings     PC
#> 4380  CDASHIG     2.3        Findings     PC
#> 4381  CDASHIG     2.3        Findings     PC
#> 4382  CDASHIG     2.3        Findings     PC
#> 4383  CDASHIG     2.3        Findings     PC
#> 4384  CDASHIG     2.3        Findings     PC
#> 4385  CDASHIG     2.3        Findings     PC
#> 4386  CDASHIG     2.3        Findings     PC
#> 4387  CDASHIG     2.3        Findings     PC
#> 4388  CDASHIG     2.3        Findings     PC
#> 4389  CDASHIG     2.3        Findings     PC
#> 4390  CDASHIG     2.3        Findings     PC
#> 4391  CDASHIG     2.3        Findings     PC
#> 4392  CDASHIG     2.3        Findings     PC
#> 4393  CDASHIG     2.3        Findings     PC
#> 4394  CDASHIG     2.3        Findings     PC
#> 4395  CDASHIG     2.3        Findings     PC
#> 4396  CDASHIG     2.3        Findings     PC
#> 4397  CDASHIG     2.3        Findings     PC
#> 4398  CDASHIG     2.3        Findings     PC
#> 4399  CDASHIG     2.3        Findings     PC
#> 4400  CDASHIG     2.3        Findings     PC
#> 4401  CDASHIG     2.3        Findings     PE
#> 4402  CDASHIG     2.3        Findings     PE
#> 4403  CDASHIG     2.3        Findings     PE
#> 4404  CDASHIG     2.3        Findings     PE
#> 4405  CDASHIG     2.3        Findings     PE
#> 4406  CDASHIG     2.3        Findings     PE
#> 4407  CDASHIG     2.3        Findings     PE
#> 4408  CDASHIG     2.3        Findings     PE
#> 4409  CDASHIG     2.3        Findings     PE
#> 4410  CDASHIG     2.3        Findings     PE
#> 4411  CDASHIG     2.3        Findings     PE
#> 4412  CDASHIG     2.3        Findings     PE
#> 4413  CDASHIG     2.3        Findings     PE
#> 4414  CDASHIG     2.3        Findings     PE
#> 4415  CDASHIG     2.3        Findings     PE
#> 4416  CDASHIG     2.3        Findings     PE
#> 4417  CDASHIG     2.3        Findings     PE
#> 4418  CDASHIG     2.3        Findings     PE
#> 4419  CDASHIG     2.3        Findings     PE
#> 4420  CDASHIG     2.3        Findings     PE
#> 4421  CDASHIG     2.3        Findings     PE
#> 4422  CDASHIG     2.3        Findings     PE
#> 4423  CDASHIG     2.3        Findings     PE
#> 4424  CDASHIG     2.3        Findings     PE
#> 4425  CDASHIG     2.3        Findings     SC
#> 4426  CDASHIG     2.3        Findings     SC
#> 4427  CDASHIG     2.3        Findings     SC
#> 4428  CDASHIG     2.3        Findings     SC
#> 4429  CDASHIG     2.3        Findings     SC
#> 4430  CDASHIG     2.3        Findings     SC
#> 4431  CDASHIG     2.3        Findings     SC
#> 4432  CDASHIG     2.3        Findings     SC
#> 4433  CDASHIG     2.3        Findings     SC
#> 4434  CDASHIG     2.3        Findings     SC
#> 4435  CDASHIG     2.3        Findings     VS
#> 4436  CDASHIG     2.3        Findings     VS
#> 4437  CDASHIG     2.3        Findings     VS
#> 4438  CDASHIG     2.3        Findings     VS
#> 4439  CDASHIG     2.3        Findings     VS
#> 4440  CDASHIG     2.3        Findings     VS
#> 4441  CDASHIG     2.3        Findings     VS
#> 4442  CDASHIG     2.3        Findings     VS
#> 4443  CDASHIG     2.3        Findings     VS
#> 4444  CDASHIG     2.3        Findings     VS
#> 4445  CDASHIG     2.3        Findings     VS
#> 4446  CDASHIG     2.3        Findings     VS
#> 4447  CDASHIG     2.3        Findings     VS
#> 4448  CDASHIG     2.3        Findings     VS
#> 4449  CDASHIG     2.3        Findings     VS
#> 4450  CDASHIG     2.3        Findings     VS
#> 4451  CDASHIG     2.3        Findings     VS
#> 4452  CDASHIG     2.3        Findings     VS
#> 4453  CDASHIG     2.3        Findings     VS
#> 4454  CDASHIG     2.3 Special-Purpose     DM
#> 4455  CDASHIG     2.3 Special-Purpose     DM
#> 4456  CDASHIG     2.3 Special-Purpose     DM
#> 4457  CDASHIG     2.3 Special-Purpose     DM
#> 4458  CDASHIG     2.3 Special-Purpose     DM
#> 4459  CDASHIG     2.3 Special-Purpose     DM
#> 4460  CDASHIG     2.3 Special-Purpose     DM
#> 4461  CDASHIG     2.3 Special-Purpose     DM
#> 4462  CDASHIG     2.3 Special-Purpose     DM
#> 4463  CDASHIG     2.3 Special-Purpose     DM
#> 4464  CDASHIG     2.3 Special-Purpose     DM
#> 4465  CDASHIG     2.3 Special-Purpose     DM
#> 4466  CDASHIG     2.3 Special-Purpose     DM
#> 4467  CDASHIG     2.3 Special-Purpose     DM
#> 4468  CDASHIG     2.3 Special-Purpose     DM
#> 4469  CDASHIG     2.3 Special-Purpose     DM
#> 4470  CDASHIG     2.3 Special-Purpose     DM
#> 4471  CDASHIG     2.3 Special-Purpose     DM
#> 4472  CDASHIG     2.3 Special-Purpose     DM
#> 4473  CDASHIG     2.3 Special-Purpose     DM
#> 4474  CDASHIG     2.3 Special-Purpose     DM
#> 4475  CDASHIG     2.3 Special-Purpose     DM
#> 4476  CDASHIG     2.3 Special-Purpose     DM
#> 4477  CDASHIG     2.3 Special-Purpose     DM
#> 4478  CDASHIG     2.3 Special-Purpose     DM
#> 4479  CDASHIG     2.3 Special-Purpose     DM
#> 4480  CDASHIG     2.3 Special-Purpose     DM
#> 4481  CDASHIG     2.3 Special-Purpose     DM
#> 4482  CDASHIG     2.3 Special-Purpose     DM
#> 4483  CDASHIG     2.3 Special-Purpose     DM
#>                                             scenario order            variable
#> 3231                                            <NA>     1             STUDYID
#> 3232                                            <NA>     2              SITEID
#> 3233                                            <NA>     3              SUBJID
#> 3234                                            <NA>     4               AGCAT
#> 3235                                            <NA>     5              AGSCAT
#> 3236                                            <NA>     6                AGYN
#> 3237                                            <NA>     7              AGSPID
#> 3238                                            <NA>     8               AGTRT
#> 3239                                            <NA>     9             AGPRESP
#> 3240                                            <NA>    10             AGOCCUR
#> 3241                                            <NA>    11              AGDOSE
#> 3242                                            <NA>    12             AGDSTXT
#> 3243                                            <NA>    13              AGDOSU
#> 3244                                            <NA>    14            AGDOSFRM
#> 3245                                            <NA>    15            AGDOSFRQ
#> 3246                                            <NA>    16             AGROUTE
#> 3247                                            <NA>    17             AGSTDAT
#> 3248                                            <NA>    18             AGSTTIM
#> 3249                                            <NA>    19             AGPRIOR
#> 3250                                            <NA>    20              AGONGO
#> 3251                                            <NA>    21             AGENDAT
#> 3252                                            <NA>    22             AGENTIM
#> 3253                                            <NA>    23             AGDECOD
#> 3254                                            <NA>    24              AGCLAS
#> 3255                                            <NA>    25            AGCLASCD
#> 3256                                            <NA>     1             STUDYID
#> 3257                                            <NA>     2              SITEID
#> 3258                                            <NA>     3              SUBJID
#> 3259                                            <NA>     4               CMCAT
#> 3260                                            <NA>     5              CMSCAT
#> 3261                                            <NA>     6                CMYN
#> 3262                                            <NA>     7              CMSPID
#> 3263                                            <NA>     8               CMTRT
#> 3264                                            <NA>     9             CMPRESP
#> 3265                                            <NA>    10             CMOCCUR
#> 3266                                            <NA>    11             CMINGRD
#> 3267                                            <NA>    12              CMINDC
#> 3268                                            <NA>    13              CMAENO
#> 3269                                            <NA>    14              CMMHNO
#> 3270                                            <NA>    15              CMDOSE
#> 3271                                            <NA>    16             CMDSTXT
#> 3272                                            <NA>    17            CMDOSTOT
#> 3273                                            <NA>    18              CMDOSU
#> 3274                                            <NA>    19            CMDOSFRM
#> 3275                                            <NA>    20            CMDOSFRQ
#> 3276                                            <NA>    21             CMROUTE
#> 3277                                            <NA>    22             CMSTDAT
#> 3278                                            <NA>    23             CMSTTIM
#> 3279                                            <NA>    24             CMPRIOR
#> 3280                                            <NA>    25              CMONGO
#> 3281                                            <NA>    26             CMENDAT
#> 3282                                            <NA>    27             CMENTIM
#> 3283                                            <NA>    28            CMRSDISC
#> 3284                                            <NA>    29             CMDECOD
#> 3285                                            <NA>    30              CMCLAS
#> 3286                                            <NA>    31            CMCLASCD
#> 3287                                            <NA>    32              CMATC1
#> 3288                                            <NA>    33            CMATC1CD
#> 3289                                            <NA>    34              CMATC2
#> 3290                                            <NA>    35            CMATC2CD
#> 3291                                            <NA>    36              CMATC3
#> 3292                                            <NA>    37            CMATC3CD
#> 3293                                            <NA>    38              CMATC4
#> 3294                                            <NA>    39            CMATC4CD
#> 3295                                            <NA>    40              CMATC5
#> 3296                                            <NA>    41            CMATC5CD
#> 3297                                            <NA>     1             STUDYID
#> 3298                                            <NA>     2              SITEID
#> 3299                                            <NA>     3              SUBJID
#> 3300                                            <NA>     4               EPOCH
#> 3301                                            <NA>     5                ECYN
#> 3302                                            <NA>     6               ECCAT
#> 3303                                            <NA>     7              ECSCAT
#> 3304                                            <NA>     8               ECTRT
#> 3305                                            <NA>     9             ECPRESP
#> 3306                                            <NA>    10             ECOCCUR
#> 3307                                            <NA>    11            ECREASOC
#> 3308                                            <NA>    12              ECMOOD
#> 3309                                            <NA>    13             ECREFID
#> 3310                                            <NA>    14               ECLOT
#> 3311                                            <NA>    15              ECFAST
#> 3312                                            <NA>    16            ECDOSFRM
#> 3313                                            <NA>    17             ECSTDAT
#> 3314                                            <NA>    18             ECSTTIM
#> 3315                                            <NA>    19             ECENDAT
#> 3316                                            <NA>    20             ECENTIM
#> 3317                                            <NA>    21             ECDSTXT
#> 3318                                            <NA>    22              ECDOSU
#> 3319                                            <NA>    23            ECDOSFRQ
#> 3320                                            <NA>    24             ECROUTE
#> 3321                                            <NA>    25            ECDOSRGM
#> 3322                                            <NA>    26            ECDOSADJ
#> 3323                                            <NA>    27               ECADJ
#> 3324                                            <NA>    28            ECITRPYN
#> 3325                                            <NA>    29             ECCINTD
#> 3326                                            <NA>    30            ECCINTDU
#> 3327                                            <NA>    31               ECLOC
#> 3328                                            <NA>    32               ECLAT
#> 3329                                            <NA>    33               ECDIR
#> 3330                                            <NA>    34              ECVAMT
#> 3331                                            <NA>    35             ECVAMTU
#> 3332                                            <NA>    36              ECFLRT
#> 3333                                            <NA>    37             ECFLRTU
#> 3334                                            <NA>    38               ECTPT
#> 3335                                            <NA>    39            ECTRTCMP
#> 3336                                            <NA>     1             STUDYID
#> 3337                                            <NA>     2              SITEID
#> 3338                                            <NA>     3              SUBJID
#> 3339                                            <NA>     4               EPOCH
#> 3340                                            <NA>     5                EXYN
#> 3341                                            <NA>     6               EXCAT
#> 3342                                            <NA>     7              EXSCAT
#> 3343                                            <NA>     8               EXTRT
#> 3344                                            <NA>     9             EXREFID
#> 3345                                            <NA>    10               EXLOT
#> 3346                                            <NA>    11              EXFAST
#> 3347                                            <NA>    12            EXDOSFRM
#> 3348                                            <NA>    13             EXSTDAT
#> 3349                                            <NA>    14             EXSTTIM
#> 3350                                            <NA>    15             EXENDAT
#> 3351                                            <NA>    16             EXENTIM
#> 3352                                            <NA>    17             EXDSTXT
#> 3353                                            <NA>    18              EXDOSU
#> 3354                                            <NA>    19            EXDOSFRQ
#> 3355                                            <NA>    20             EXROUTE
#> 3356                                            <NA>    21            EXDOSRGM
#> 3357                                            <NA>    22            EXDOSADJ
#> 3358                                            <NA>    23               EXADJ
#> 3359                                            <NA>    24            EXITRPYN
#> 3360                                            <NA>    25             EXCINTD
#> 3361                                            <NA>    26            EXCINTDU
#> 3362                                            <NA>    27               EXLOC
#> 3363                                            <NA>    28              EXVAMT
#> 3364                                            <NA>    29             EXVAMTU
#> 3365                                            <NA>    30              EXFLRT
#> 3366                                            <NA>    31             EXFLRTU
#> 3367                                            <NA>    32               EXTPT
#> 3368                                            <NA>    33            EXTRTCMP
#> 3369                                            <NA>    34               EXLAT
#> 3370                                            <NA>    35               EXDIR
#> 3371                                            <NA>     1             STUDYID
#> 3372                                            <NA>     2              SITEID
#> 3373                                            <NA>     3              SUBJID
#> 3374                                            <NA>     4               MLCAT
#> 3375                                            <NA>     5              MLSCAT
#> 3376                                            <NA>     6                MLYN
#> 3377                                            <NA>     7              MLSPID
#> 3378                                            <NA>     8               MLTRT
#> 3379                                            <NA>     9             MLPRESP
#> 3380                                            <NA>    10             MLOCCUR
#> 3381                                            <NA>    11            MLREASOC
#> 3382                                            <NA>    12              MLREAS
#> 3383                                            <NA>    13              MLCENO
#> 3384                                            <NA>    14              MLDOSE
#> 3385                                            <NA>    15             MLDSTXT
#> 3386                                            <NA>    16              MLDOSU
#> 3387                                            <NA>    17             MLSTDAT
#> 3388                                            <NA>    18             MLSTTIM
#> 3389                                            <NA>    19             MLENDAT
#> 3390                                            <NA>    20             MLENTIM
#> 3391                                            <NA>    21             MLDECOD
#> 3392                                            <NA>    22            MLMODIFY
#> 3393                                            <NA>     1             STUDYID
#> 3394                                            <NA>     2              SITEID
#> 3395                                            <NA>     3              SUBJID
#> 3396                                            <NA>     4                PRYN
#> 3397                                            <NA>     5               PRCAT
#> 3398                                            <NA>     6              PRSCAT
#> 3399                                            <NA>     7              PRSPID
#> 3400                                            <NA>     8               PRTRT
#> 3401                                            <NA>     9             PRDECOD
#> 3402                                            <NA>    10            PRMODIFY
#> 3403                                            <NA>    11             PRPRESP
#> 3404                                            <NA>    12             PROCCUR
#> 3405                                            <NA>    13            PRREASOC
#> 3406                                            <NA>    14            PRREASND
#> 3407                                            <NA>    15             PRPRIOR
#> 3408                                            <NA>    16             PRSTDAT
#> 3409                                            <NA>    17              PRONGO
#> 3410                                            <NA>    18             PRENDAT
#> 3411                                            <NA>    19              PRINDC
#> 3412                                            <NA>    20              PRAENO
#> 3413                                            <NA>    21              PRMHNO
#> 3414                                            <NA>    22             PRDSTXT
#> 3415                                            <NA>    23              PRDOSU
#> 3416                                            <NA>    24            PRDOSFRQ
#> 3417                                            <NA>    25             PRROUTE
#> 3418                                            <NA>    26               PRLOC
#> 3419                                            <NA>    27               PRLAT
#> 3420                                            <NA>    28               PRDIR
#> 3421                                            <NA>    29            PRPORTOT
#> 3422                                            <NA>    30              PRFAST
#> 3423                                            <NA>    31            PRDOSRGM
#> 3424                                            <NA>    32            PRDOSADJ
#> 3425                                            <NA>    33               PRADJ
#> 3426                                            <NA>    34            PRTRTCMP
#> 3427                                            <NA>    35            PRITRPYN
#> 3428                                            <NA>    36            PRITRPRS
#> 3429                                            <NA>    37             PRCINTD
#> 3430                                            <NA>    38            PRCINTDU
#> 3431                                            <NA>    39               PRLLT
#> 3432                                            <NA>    40             PRLLTCD
#> 3433                                            <NA>    41              PRPTCD
#> 3434                                            <NA>    42               PRHLT
#> 3435                                            <NA>    43             PRHLTCD
#> 3436                                            <NA>    44              PRHLGT
#> 3437                                            <NA>    45            PRHLGTCD
#> 3438                                            <NA>    46               PRSOC
#> 3439                                            <NA>    47             PRSOCCD
#> 3440                                            <NA>     1             STUDYID
#> 3441                                            <NA>     2              SITEID
#> 3442                                            <NA>     3              SUBJID
#> 3443                                            <NA>     4               SUTRT
#> 3444                                            <NA>     5               SUCAT
#> 3445                                            <NA>     6              SUSCAT
#> 3446                                            <NA>     7             SUPRESP
#> 3447                                            <NA>     8                SUYN
#> 3448                                            <NA>     9               SUNCF
#> 3449                                            <NA>    10              SUSPID
#> 3450                                            <NA>    11            SUREASND
#> 3451                                            <NA>    12             SUDSTXT
#> 3452                                            <NA>    13            SUDOSFRQ
#> 3453                                            <NA>    14             SUSTDAT
#> 3454                                            <NA>    15             SUENDAT
#> 3455                                            <NA>    16              SUCDUR
#> 3456                                            <NA>    17             SUCDURU
#> 3457                                            <NA>    18            SUMODIFY
#> 3458                                            <NA>    19             SUDECOD
#> 3459                                            <NA>     1             STUDYID
#> 3460                                            <NA>     2              SITEID
#> 3461                                            <NA>     3              SUBJID
#> 3462                                            <NA>     4                AEYN
#> 3463                                            <NA>     5               AECAT
#> 3464                                            <NA>     6              AESCAT
#> 3465                                            <NA>     7              AESPID
#> 3466                                            <NA>     8              AETERM
#> 3467                                            <NA>     9             AEOCCUR
#> 3468                                            <NA>    10             AEPRESP
#> 3469                                            <NA>    11             AESTDAT
#> 3470                                            <NA>    12             AESTTIM
#> 3471                                            <NA>    13               AELOC
#> 3472                                            <NA>    14               AELAT
#> 3473                                            <NA>    15               AEDIR
#> 3474                                            <NA>    16            AEPORTOT
#> 3475                                            <NA>    17              AEONGO
#> 3476                                            <NA>    18             AEENDAT
#> 3477                                            <NA>    19             AEENTIM
#> 3478                                            <NA>    20               AESEV
#> 3479                                            <NA>    21             AETOXGR
#> 3480                                            <NA>    22               AESER
#> 3481                                            <NA>    23              AESDTH
#> 3482                                            <NA>    24              DTHDAT
#> 3483                                            <NA>    25             AESLIFE
#> 3484                                            <NA>    26             AESHOSP
#> 3485                                            <NA>    27            AESDISAB
#> 3486                                            <NA>    28             AESCONG
#> 3487                                            <NA>    29             AESINTV
#> 3488                                            <NA>    30              AESMIE
#> 3489                                            <NA>    31              AESCAN
#> 3490                                            <NA>    32               AESOD
#> 3491                                            <NA>    33               AEREL
#> 3492                                            <NA>    34               AEACN
#> 3493                                            <NA>    35            AEACNDEV
#> 3494                                            <NA>    36            AEACNOYN
#> 3495                                            <NA>    37            AEACNOTH
#> 3496                                            <NA>    38               AEOUT
#> 3497                                            <NA>    39               AEDIS
#> 3498                                            <NA>    40            AERLNSYN
#> 3499                                            <NA>    41            AERELNST
#> 3500                                            <NA>    42                AESI
#> 3501                                            <NA>    43              AEPATT
#> 3502                                            <NA>    44            AECONTRT
#> 3503                                            <NA>    45            AEMODIFY
#> 3504                                            <NA>    46             AEDECOD
#> 3505                                            <NA>    47               AELLT
#> 3506                                            <NA>    48             AELLTCD
#> 3507                                            <NA>    49              AEPTCD
#> 3508                                            <NA>    50               AEHLT
#> 3509                                            <NA>    51             AEHLTCD
#> 3510                                            <NA>    52              AEHLGT
#> 3511                                            <NA>    53            AEHLGTCD
#> 3512                                            <NA>    54               AESOC
#> 3513                                            <NA>    55             AESOCCD
#> 3514                                            <NA>     1             STUDYID
#> 3515                                            <NA>     2              SITEID
#> 3516                                            <NA>     3              SUBJID
#> 3517                                            <NA>     4               CECAT
#> 3518                                            <NA>     5              CESCAT
#> 3519                                            <NA>     6                CEYN
#> 3520                                            <NA>     7              CESPID
#> 3521                                            <NA>     8              CETERM
#> 3522                                            <NA>     9             CEOCCUR
#> 3523                                            <NA>    10             CEPRESP
#> 3524                                            <NA>    11             CESTDAT
#> 3525                                            <NA>    12             CESTTIM
#> 3526                                            <NA>    13               CELOC
#> 3527                                            <NA>    14               CELAT
#> 3528                                            <NA>    15               CEDIR
#> 3529                                            <NA>    16            CEPORTOT
#> 3530                                            <NA>    17              CEONGO
#> 3531                                            <NA>    18             CEENDAT
#> 3532                                            <NA>    19             CEENTIM
#> 3533                                            <NA>    20               CESEV
#> 3534                                            <NA>    21               CETOX
#> 3535                                            <NA>    22             CETOXGR
#> 3536                                            <NA>    23            CEMODIFY
#> 3537                                            <NA>    24             CEDECOD
#> 3538                                            <NA>    25               CELLT
#> 3539                                            <NA>    26             CELLTCD
#> 3540                                            <NA>    27              CEPTCD
#> 3541                                            <NA>    28               CEHLT
#> 3542                                            <NA>    29             CEHLTCD
#> 3543                                            <NA>    30              CEHLGT
#> 3544                                            <NA>    31            CEHLGTCD
#> 3545                                            <NA>    32               CESOC
#> 3546                                            <NA>    33             CESOCCD
#> 3547                                            <NA>     1             STUDYID
#> 3548                                            <NA>     2              SITEID
#> 3549                                            <NA>     3              SUBJID
#> 3550                                            <NA>     4               DVCAT
#> 3551                                            <NA>     5              DVSCAT
#> 3552                                            <NA>     6                DVYN
#> 3553                                            <NA>     7             DVDECOD
#> 3554                                            <NA>     8              DVTERM
#> 3555                                            <NA>     9             DVSTDAT
#> 3556                                            <NA>    10             DVSTTIM
#> 3557                                            <NA>    11             DVENDAT
#> 3558                                            <NA>    12             DVENTIM
#> 3559                                            <NA>    13              DVSPID
#> 3560                                            <NA>     1             STUDYID
#> 3561                                            <NA>     2              SITEID
#> 3562                                            <NA>     3              SUBJID
#> 3563                                            <NA>     4                HOYN
#> 3564                                            <NA>     5               HOCAT
#> 3565                                            <NA>     6              HOSCAT
#> 3566                                            <NA>     7             HOOCCUR
#> 3567                                            <NA>     8             HOPRESP
#> 3568                                            <NA>     9            HOREASND
#> 3569                                            <NA>    10              HOSPID
#> 3570                                            <NA>    11              HOTERM
#> 3571                                            <NA>    12             HODECOD
#> 3572                                            <NA>    13             HOSTDAT
#> 3573                                            <NA>    14             HOSTTIM
#> 3574                                            <NA>    15             HOENDAT
#> 3575                                            <NA>    16             HOENTIM
#> 3576                                            <NA>    17              HOCDUR
#> 3577                                            <NA>    18             HOCDURU
#> 3578                                            <NA>    19              HOONGO
#> 3579                                            <NA>    20              HOREAS
#> 3580                                            <NA>    21              HOAENO
#> 3581                                            <NA>     1             STUDYID
#> 3582                                            <NA>     2              SITEID
#> 3583                                            <NA>     3              SUBJID
#> 3584                                            <NA>     4                MHYN
#> 3585                                            <NA>     5               MHCAT
#> 3586                                            <NA>     6              MHSCAT
#> 3587                                            <NA>     7               MHDAT
#> 3588                                            <NA>     8              MHSPID
#> 3589                                            <NA>     9            MHEVDTYP
#> 3590                                            <NA>    10              MHTERM
#> 3591                                            <NA>    11             MHOCCUR
#> 3592                                            <NA>    12             MHPRESP
#> 3593                                            <NA>    13             MHPRIOR
#> 3594                                            <NA>    14              MHONGO
#> 3595                                            <NA>    15              MHCTRL
#> 3596                                            <NA>    16             MHSTDAT
#> 3597                                            <NA>    17             MHENDAT
#> 3598                                            <NA>    18               MHLOC
#> 3599                                            <NA>    19               MHLAT
#> 3600                                            <NA>    20               MHDIR
#> 3601                                            <NA>    21            MHPORTOT
#> 3602                                            <NA>    22            MHMODIFY
#> 3603                                            <NA>    23             MHDECOD
#> 3604                                            <NA>    24               MHLLT
#> 3605                                            <NA>    25             MHLLTCD
#> 3606                                            <NA>    26              MHPTCD
#> 3607                                            <NA>    27               MHHLT
#> 3608                                            <NA>    28             MHHLTCD
#> 3609                                            <NA>    29              MHHLGT
#> 3610                                            <NA>    30            MHHLGTCD
#> 3611                                            <NA>    31               MHSOC
#> 3612                                            <NA>    32             MHSOCCD
#> 3613                                            <NA>     1             STUDYID
#> 3614                                            <NA>     2              SITEID
#> 3615                                            <NA>     3              SUBJID
#> 3616                                            <NA>     4               VISIT
#> 3617                                            <NA>     5              VISDAT
#> 3618                                            <NA>     6               CPCAT
#> 3619                                            <NA>     7              CPSCAT
#> 3620                                            <NA>     8              CPPERF
#> 3621                                            <NA>     9             CPREFID
#> 3622                                            <NA>    10               CPTPT
#> 3623                                            <NA>    11               CPDAT
#> 3624                                            <NA>    12               CPTIM
#> 3625                                            <NA>     1             STUDYID
#> 3626                                            <NA>     2              SITEID
#> 3627                                            <NA>     3              SUBJID
#> 3628                                            <NA>     4               VISIT
#> 3629                                            <NA>     5              VISDAT
#> 3630                                            <NA>     6              CVPERF
#> 3631                                            <NA>     7               CVDAT
#> 3632                                            <NA>     8               CVTIM
#> 3633                                            <NA>     9               CVTPT
#> 3634                                            <NA>    10              CVTEST
#> 3635                                            <NA>    11               CVCAT
#> 3636                                            <NA>    12              CVSCAT
#> 3637                                            <NA>    13             CVORRES
#> 3638                                            <NA>    14            CVORRESU
#> 3639                                            <NA>    15               CVRES
#> 3640                                            <NA>    16              CVDESC
#> 3641                                            <NA>    21              CVSTAT
#> 3642                                            <NA>    22            CVREASND
#> 3643                                            <NA>    23               CVPOS
#> 3644                                            <NA>    24               CVLOC
#> 3645                                            <NA>    25               CVLAT
#> 3646                                            <NA>    26               CVDIR
#> 3647                                            <NA>    27            CVMETHOD
#> 3648                                            <NA>    28              CVEVAL
#> 3649                                            <NA>    29            CVEVALID
#> 3650                                            <NA>     1             STUDYID
#> 3651                                            <NA>     2              SITEID
#> 3652                                            <NA>     3              SUBJID
#> 3653                                            <NA>     4               VISIT
#> 3654                                            <NA>     5              VISDAT
#> 3655                                            <NA>     6              DAPERF
#> 3656                                            <NA>     7               DACAT
#> 3657                                            <NA>     8              DASCAT
#> 3658                                            <NA>     9               DADAT
#> 3659                                            <NA>    10             DAREFID
#> 3660                                            <NA>    11              DATEST
#> 3661                                            <NA>    12             DAORRES
#> 3662                                            <NA>    13            DAORRESU
#> 3663                                            <NA>     1             STUDYID
#> 3664                                            <NA>     2              SITEID
#> 3665                                            <NA>     3              SUBJID
#> 3666                                            <NA>     4               VISIT
#> 3667                                            <NA>     5              VISDAT
#> 3668                                            <NA>     6                DDYN
#> 3669                                            <NA>     7               DDDAT
#> 3670                                            <NA>     8              DDSPID
#> 3671                                            <NA>     9              DTHDAT
#> 3672                                            <NA>    10              DDTEST
#> 3673                                            <NA>    11             DDORRES
#> 3674                                            <NA>    12            DDRESCAT
#> 3675                                            <NA>    13              DDEVAL
#> 3676                                            <NA>     1             STUDYID
#> 3677                                            <NA>     2              SITEID
#> 3678                                            <NA>     3              SUBJID
#> 3679                                            <NA>     4               VISIT
#> 3680                                            <NA>     5              VISDAT
#> 3681                                            <NA>     6                IEYN
#> 3682                                            <NA>     7               IEDAT
#> 3683                                            <NA>     8               IECAT
#> 3684                                            <NA>     9              IESCAT
#> 3685                                            <NA>    10            IETESTCD
#> 3686                                            <NA>    11              IETEST
#> 3687                                            <NA>    12             IEORRES
#> 3688                                            <NA>     1             STUDYID
#> 3689                                            <NA>     2              SITEID
#> 3690                                            <NA>     3              SUBJID
#> 3691                                            <NA>     4               VISIT
#> 3692                                            <NA>     5              VISDAT
#> 3693                                            <NA>     6              MKPERF
#> 3694                                            <NA>     7               MKDAT
#> 3695                                            <NA>     8               MKTIM
#> 3696                                            <NA>     9               MKTPT
#> 3697                                            <NA>    10              MKTEST
#> 3698                                            <NA>    11               MKCAT
#> 3699                                            <NA>    12              MKSCAT
#> 3700                                            <NA>    13             MKORRES
#> 3701                                            <NA>    14            MKORRESU
#> 3702                                            <NA>    15               MKRES
#> 3703                                            <NA>    16              MKDESC
#> 3704                                            <NA>    17            MKRESOTH
#> 3705                                            <NA>    18             MKNRIND
#> 3706                                            <NA>    19              MKSTAT
#> 3707                                            <NA>    20            MKREASND
#> 3708                                            <NA>    21               MKPOS
#> 3709                                            <NA>    22               MKLOC
#> 3710                                            <NA>    23               MKLAT
#> 3711                                            <NA>    24               MKDIR
#> 3712                                            <NA>    25            MKMETHOD
#> 3713                                            <NA>    26              MKEVAL
#> 3714                                            <NA>    27            MKEVALID
#> 3715                                            <NA>    28            MKACPTFL
#> 3716                                            <NA>    29            MKREPNUM
#> 3717                                            <NA>     1             STUDYID
#> 3718                                            <NA>     2              SITEID
#> 3719                                            <NA>     3              SUBJID
#> 3720                                            <NA>     4               VISIT
#> 3721                                            <NA>     5              VISDAT
#> 3722                                            <NA>     6              NVPERF
#> 3723                                            <NA>     7               NVDAT
#> 3724                                            <NA>     8               NVTIM
#> 3725                                            <NA>     9               NVTPT
#> 3726                                            <NA>    10              NVTEST
#> 3727                                            <NA>    12               NVCAT
#> 3728                                            <NA>    13              NVSCAT
#> 3729                                            <NA>    14             NVORRES
#> 3730                                            <NA>    15            NVORRESU
#> 3731                                            <NA>    16               NVRES
#> 3732                                            <NA>    17              NVDESC
#> 3733                                            <NA>    18            NVRESOTH
#> 3734                                            <NA>    19            NVORNRLO
#> 3735                                            <NA>    20            NVORNRHI
#> 3736                                            <NA>    21             NVNRIND
#> 3737                                            <NA>    22              NVSTAT
#> 3738                                            <NA>    23            NVREASND
#> 3739                                            <NA>    24               NVPOS
#> 3740                                            <NA>    25               NVLOC
#> 3741                                            <NA>    26               NVLAT
#> 3742                                            <NA>    27               NVDIR
#> 3743                                            <NA>    28            NVMETHOD
#> 3744                                            <NA>    29              NVEVAL
#> 3745                                            <NA>    30            NVEVALID
#> 3746                                            <NA>    31            NVREPNUM
#> 3747                                            <NA>    32             NVCLSIG
#> 3748                                            <NA>     1             STUDYID
#> 3749                                            <NA>     2              SITEID
#> 3750                                            <NA>     3              SUBJID
#> 3751                                            <NA>     4               VISIT
#> 3752                                            <NA>     5              VISDAT
#> 3753                                            <NA>     6               FOCID
#> 3754                                            <NA>     7              OEPERF
#> 3755                                            <NA>     8               OEDAT
#> 3756                                            <NA>     9               OETIM
#> 3757                                            <NA>    10              OETEST
#> 3758                                            <NA>    11            OETSTDTL
#> 3759                                            <NA>    12               OECAT
#> 3760                                            <NA>    13              OESCAT
#> 3761                                            <NA>    14             OEORRES
#> 3762                                            <NA>    15            OEORRESU
#> 3763                                            <NA>    16               OERES
#> 3764                                            <NA>    17            OERESOTH
#> 3765                                            <NA>    18            OEORNRLO
#> 3766                                            <NA>    19            OEORNRHI
#> 3767                                            <NA>    20            OECSTNRC
#> 3768                                            <NA>    21             OENRIND
#> 3769                                            <NA>    22            OERESCAT
#> 3770                                            <NA>    23            OEREASND
#> 3771                                            <NA>    24               OELOC
#> 3772                                            <NA>    25               OELAT
#> 3773                                            <NA>    26               OEDIR
#> 3774                                            <NA>    27            OEPORTOT
#> 3775                                            <NA>    28            OEMETHOD
#> 3776                                            <NA>    29              OEEVAL
#> 3777                                            <NA>    30            OEEVALID
#> 3778                                            <NA>    31            OEACPTFL
#> 3779                                            <NA>    32            OEREPNUM
#> 3780                                            <NA>     1             STUDYID
#> 3781                                            <NA>     2              SITEID
#> 3782                                            <NA>     3              SUBJID
#> 3783                                            <NA>     4               VISIT
#> 3784                                            <NA>     5              VISDAT
#> 3785                                            <NA>     6              REPERF
#> 3786                                            <NA>     7               REDAT
#> 3787                                            <NA>     8               RETIM
#> 3788                                            <NA>     9               RETPT
#> 3789                                            <NA>    10              RETEST
#> 3790                                            <NA>    11               RECAT
#> 3791                                            <NA>    12              RESCAT
#> 3792                                            <NA>    13             REORRES
#> 3793                                            <NA>    14            REORRESU
#> 3794                                            <NA>    15               RERES
#> 3795                                            <NA>    16              REDESC
#> 3796                                            <NA>    17            RERESOTH
#> 3797                                            <NA>    18            REORNRLO
#> 3798                                            <NA>    19            REORNRHI
#> 3799                                            <NA>    20             RENRIND
#> 3800                                            <NA>    21              RESTAT
#> 3801                                            <NA>    22            REREASND
#> 3802                                            <NA>    23               REPOS
#> 3803                                            <NA>    24               RELOC
#> 3804                                            <NA>    25               RELAT
#> 3805                                            <NA>    26               REDIR
#> 3806                                            <NA>    27            REMETHOD
#> 3807                                            <NA>    28              REEVAL
#> 3808                                            <NA>    29            REEVALID
#> 3809                                            <NA>    30            REACPTFL
#> 3810                                            <NA>    31            REREPNUM
#> 3811                                            <NA>    32             RECLSIG
#> 3812                                            <NA>     1             STUDYID
#> 3813                                            <NA>     2              SITEID
#> 3814                                            <NA>     3              SUBJID
#> 3815                                            <NA>     4               VISIT
#> 3816                                            <NA>     5              VISDAT
#> 3817                                            <NA>     6               RPCAT
#> 3818                                            <NA>     7              RPSCAT
#> 3819                                            <NA>     8              RPPERF
#> 3820                                            <NA>     9            RPREASND
#> 3821                                            <NA>    10                RPYN
#> 3822                                            <NA>    11              RPSPID
#> 3823                                            <NA>    12              RPTEST
#> 3824                                            <NA>    13             RPORRES
#> 3825                                            <NA>    14            RPORRESU
#> 3826                                            <NA>    15               RPDAT
#> 3827                                            <NA>     1             STUDYID
#> 3828                                            <NA>     2              SITEID
#> 3829                                            <NA>     3              SUBJID
#> 3830                                            <NA>     4               VISIT
#> 3831                                            <NA>     5              VISDAT
#> 3832                                            <NA>     6               RSCAT
#> 3833                                            <NA>     7              RSSCAT
#> 3834                                            <NA>     8              RSPERF
#> 3835                                            <NA>     9            RSREASND
#> 3836                                            <NA>    10               RSDAT
#> 3837                                            <NA>    11              RSEVAL
#> 3838                                            <NA>    12            RSEVALID
#> 3839                                            <NA>    13             RSLNKID
#> 3840                                            <NA>    14            RSLNKGRP
#> 3841                                            <NA>    15              RSTEST
#> 3842                                            <NA>    16             RSORRES
#> 3843                                            <NA>    17            RSORRESU
#> 3844                                            <NA>     1             STUDYID
#> 3845                                            <NA>     2              SITEID
#> 3846                                            <NA>     3              SUBJID
#> 3847                                            <NA>     4               VISIT
#> 3848                                            <NA>     5              VISDAT
#> 3849                                            <NA>     6               SCCAT
#> 3850                                            <NA>     7              SCSCAT
#> 3851                                            <NA>     8              SCPERF
#> 3852                                            <NA>     9              SCSPID
#> 3853                                            <NA>    10               SCDAT
#> 3854                                            <NA>    11              SCTEST
#> 3855                                            <NA>    12             SCORRES
#> 3856                                            <NA>     1             STUDYID
#> 3857                                            <NA>     2              SITEID
#> 3858                                            <NA>     3              SUBJID
#> 3859                                            <NA>     4               VISIT
#> 3860                                            <NA>     5              VISDAT
#> 3861                                            <NA>     6            TRLNKGRP
#> 3862                                            <NA>     7               TRCAT
#> 3863                                            <NA>     8              TRSCAT
#> 3864                                            <NA>     9              TRSTAT
#> 3865                                            <NA>    10            TRREASND
#> 3866                                            <NA>    11              TREVAL
#> 3867                                            <NA>    12            TREVALID
#> 3868                                            <NA>    13               TRDAT
#> 3869                                            <NA>    14             TRLNKID
#> 3870                                            <NA>    15              TRTEST
#> 3871                                            <NA>    16             TRORRES
#> 3872                                            <NA>    17            TRORRESU
#> 3873                                            <NA>    18               TRNAM
#> 3874                                            <NA>     1             STUDYID
#> 3875                                            <NA>     2              SITEID
#> 3876                                            <NA>     3              SUBJID
#> 3877                                            <NA>     4               VISIT
#> 3878                                            <NA>     5              VISDAT
#> 3879                                            <NA>     6               TUCAT
#> 3880                                            <NA>     7              TUSCAT
#> 3881                                            <NA>     8                TUYN
#> 3882                                            <NA>     9               TUDAT
#> 3883                                            <NA>    10              TUEVAL
#> 3884                                            <NA>    11            TUEVALID
#> 3885                                            <NA>    12             TULNKID
#> 3886                                            <NA>    13              TUPRNO
#> 3887                                            <NA>    14            TUMETHOD
#> 3888                                            <NA>    15             TUREFID
#> 3889                                            <NA>    16              TUTEST
#> 3890                                            <NA>    17             TUORRES
#> 3891                                            <NA>    18               TULOC
#> 3892                                            <NA>    19               TULAT
#> 3893                                            <NA>    20               TUDIR
#> 3894                                            <NA>    21            TULOCDTL
#> 3895                                            <NA>    22               TUNAM
#> 3896                                            <NA>     1             STUDYID
#> 3897                                            <NA>     2              SITEID
#> 3898                                            <NA>     3              SUBJID
#> 3899                                            <NA>     4               VISIT
#> 3900                                            <NA>     5              VISDAT
#> 3901                                            <NA>     6              URPERF
#> 3902                                            <NA>     7               URDAT
#> 3903                                            <NA>     8               URTIM
#> 3904                                            <NA>     9               URTPT
#> 3905                                            <NA>    10              URTEST
#> 3906                                            <NA>    11               URCAT
#> 3907                                            <NA>    12              URSCAT
#> 3908                                            <NA>    13             URORRES
#> 3909                                            <NA>    14            URORRESU
#> 3910                                            <NA>    15               URRES
#> 3911                                            <NA>    16              URDESC
#> 3912                                            <NA>    17            URRESOTH
#> 3913                                            <NA>    21              URSTAT
#> 3914                                            <NA>    22            URREASND
#> 3915                                            <NA>    24               URLOC
#> 3916                                            <NA>    25               URLAT
#> 3917                                            <NA>    26               URDIR
#> 3918                                            <NA>    27            URMETHOD
#> 3919                                            <NA>    28              UREVAL
#> 3920                                            <NA>    29            UREVALID
#> 3921                                            <NA>    30            URACPTFL
#> 3922                                            <NA>    31            URREPNUM
#> 3923                                            <NA>    32             URCLSIG
#> 3924                                            <NA>     1             STUDYID
#> 3925                                            <NA>     2              SITEID
#> 3926                                            <NA>     3              SUBJID
#> 3927                                            <NA>     4               VISIT
#> 3928                                            <NA>     5              VISDAT
#> 3929                                            <NA>     6              VSPERF
#> 3930                                            <NA>     7               VSDAT
#> 3931                                            <NA>     8               VSTIM
#> 3932                                            <NA>     9              VSSPID
#> 3933                                            <NA>    10               VSTPT
#> 3934                                            <NA>    11               VSCAT
#> 3935                                            <NA>    12              VSSCAT
#> 3936                                            <NA>    13            VSREPNUM
#> 3937                                            <NA>    14              VSTEST
#> 3938                                            <NA>    15              VSSTAT
#> 3939                                            <NA>    16             VSORRES
#> 3940                                            <NA>    17            VSORRESU
#> 3941                                            <NA>    18             VSCLSIG
#> 3942                                            <NA>    19               VSLOC
#> 3943                                            <NA>    20               VSPOS
#> 3944                                            <NA>    21               VSDIR
#> 3945                                            <NA>    22               VSLAT
#> 3946                                            <NA>     1             STUDYID
#> 3947                                            <NA>     2              SITEID
#> 3948                                            <NA>     3              SUBJID
#> 3949                                            <NA>     4               VISIT
#> 3950                                            <NA>     5              VISDAT
#> 3951                                            <NA>     6               FAOBJ
#> 3952                                            <NA>     7                FAYN
#> 3953                                            <NA>     8              FAPERF
#> 3954                                            <NA>     9               FADAT
#> 3955                                            <NA>    10               FATIM
#> 3956                                            <NA>    11              FATEST
#> 3957                                            <NA>    12            FATSTDTL
#> 3958                                            <NA>    13               FACAT
#> 3959                                            <NA>    14              FASCAT
#> 3960                                            <NA>    15               FAPOS
#> 3961                                            <NA>    16             FAORRES
#> 3962                                            <NA>    17            FAORRESU
#> 3963                                            <NA>    18            FAORNRLO
#> 3964                                            <NA>    19            FAORNRHI
#> 3965                                            <NA>    20             FANRIND
#> 3966                                            <NA>    21              FASTAT
#> 3967                                            <NA>    22            FAREASND
#> 3968                                            <NA>    23              FASPEC
#> 3969                                            <NA>    24            FASPCCND
#> 3970                                            <NA>    25               FALOC
#> 3971                                            <NA>    26               FALAT
#> 3972                                            <NA>    27               FADIR
#> 3973                                            <NA>    28            FAPORTOT
#> 3974                                            <NA>    29            FAMETHOD
#> 3975                                            <NA>    30              FALEAD
#> 3976                                            <NA>    31              FAFAST
#> 3977                                            <NA>    32              FAEVAL
#> 3978                                            <NA>    33            FAEVALID
#> 3979                                            <NA>    34             FACLSIG
#> 3980                                            <NA>     1             STUDYID
#> 3981                                            <NA>     2              SITEID
#> 3982                                            <NA>     3              SUBJID
#> 3983                                            <NA>     4               VISIT
#> 3984                                            <NA>     5              VISDAT
#> 3985                                            <NA>     6              SRPERF
#> 3986                                            <NA>     7            SRREASND
#> 3987                                            <NA>     8               SRCAT
#> 3988                                            <NA>     9              SRSCAT
#> 3989                                            <NA>    10              SRSPID
#> 3990                                            <NA>    11               SROBJ
#> 3991                                            <NA>    12            SRRFTDAT
#> 3992                                            <NA>    13            SRRFTTIM
#> 3993                                            <NA>    14               SRLOC
#> 3994                                            <NA>    15               SRLAT
#> 3995                                            <NA>    16              SRTEST
#> 3996                                            <NA>    17               SRTPT
#> 3997                                            <NA>    18               SRDAT
#> 3998                                            <NA>    19               SRTIM
#> 3999                                            <NA>    20               SRDIR
#> 4000                                            <NA>    21              SREVAL
#> 4001                                            <NA>    22            SREVALID
#> 4002                                            <NA>    23             SRORRES
#> 4003                                            <NA>    24            SRORRESU
#> 4004                                            <NA>    25             SRNRIND
#> 4005                                            <NA>    26             SRCLSIG
#> 4006                                            <NA>     1             STUDYID
#> 4007                                            <NA>     2              SITEID
#> 4008                                            <NA>     3              SUBJID
#> 4009                                            <NA>     4               COVAL
#> 4010                  PROTOCOL MILESTONE/OTHER EVENT     1             STUDYID
#> 4011                  PROTOCOL MILESTONE/OTHER EVENT     2              SITEID
#> 4012                  PROTOCOL MILESTONE/OTHER EVENT     3              SUBJID
#> 4013                  PROTOCOL MILESTONE/OTHER EVENT     4               DSCAT
#> 4014                  PROTOCOL MILESTONE/OTHER EVENT     5              DSSCAT
#> 4015                  PROTOCOL MILESTONE/OTHER EVENT     6               EPOCH
#> 4016                  PROTOCOL MILESTONE/OTHER EVENT     7             DSDECOD
#> 4017                  PROTOCOL MILESTONE/OTHER EVENT     8              DSTERM
#> 4018                  PROTOCOL MILESTONE/OTHER EVENT     9             DSSTDAT
#> 4019                  PROTOCOL MILESTONE/OTHER EVENT    10             DSSTTIM
#> 4020                  PROTOCOL MILESTONE/OTHER EVENT    11            DSUNBLND
#> 4021           STUDY PARTICIPATION DISPOSITION EVENT     1             STUDYID
#> 4022           STUDY PARTICIPATION DISPOSITION EVENT     2              SITEID
#> 4023           STUDY PARTICIPATION DISPOSITION EVENT     3              SUBJID
#> 4024           STUDY PARTICIPATION DISPOSITION EVENT     4               DSCAT
#> 4025           STUDY PARTICIPATION DISPOSITION EVENT     5              DSSCAT
#> 4026           STUDY PARTICIPATION DISPOSITION EVENT     6               EPOCH
#> 4027           STUDY PARTICIPATION DISPOSITION EVENT     7             DSDECOD
#> 4028           STUDY PARTICIPATION DISPOSITION EVENT     8              DSTERM
#> 4029           STUDY PARTICIPATION DISPOSITION EVENT     9             DSSTDAT
#> 4030           STUDY PARTICIPATION DISPOSITION EVENT    10             DSSTTIM
#> 4031           STUDY PARTICIPATION DISPOSITION EVENT    11              DTHDAT
#> 4032           STUDY PARTICIPATION DISPOSITION EVENT    12              DSCONT
#> 4033           STUDY PARTICIPATION DISPOSITION EVENT    13              DSNEXT
#> 4034                                             SAE     1             SASTTIM
#> 4035                                             SAE     2             SAENTIM
#> 4036                                             SAE     3            SADCHLLT
#> 4037                                             SAE     4            SARCHLLT
#> 4038                                             SAE     5              SANARR
#> 4039                                             SAE     6            SACSLTRS
#> 4040                                             SAE     7            SACSLTAE
#> 4041                                             SAE     8            SACSTSCR
#> 4042                                             SAE     9            SACSTMTH
#> 4043                                             SAE    10             INVMNAM
#> 4044                                             SAE    11              SITEPC
#> 4045                                             SAE    12              SITEST
#> 4046                                             SAE    13               SITEC
#> 4047                                             SAE    14               SITES
#> 4048                                             SAE    15             SITETEL
#> 4049                                             SAE    16             SITEFAX
#> 4050                                             SAE    17             AWARDAT
#> 4051                                             SAE    18               INVTL
#> 4052                                             SAE    19            INVEMAIL
#> 4053                                             SAE    20             SAERCAT
#> 4054                                             SAE    21             GESTAGE
#> 4055                                             SAE    22            GESTAGEU
#> 4056  DA - Implementation Options: HorizontalGeneric     1             STUDYID
#> 4057  DA - Implementation Options: HorizontalGeneric     2              SITEID
#> 4058  DA - Implementation Options: HorizontalGeneric     3              SUBJID
#> 4059  DA - Implementation Options: HorizontalGeneric     4               VISIT
#> 4060  DA - Implementation Options: HorizontalGeneric     5              VISDAT
#> 4061  DA - Implementation Options: HorizontalGeneric     6             DAGRPID
#> 4062  DA - Implementation Options: HorizontalGeneric     7   [DATESTCD]_DAPERF
#> 4063  DA - Implementation Options: HorizontalGeneric     8    [DATESTCD]_DACAT
#> 4064  DA - Implementation Options: HorizontalGeneric     9   [DATESTCD]_DASCAT
#> 4065  DA - Implementation Options: HorizontalGeneric    10  [DATESTCD]_DAREFID
#> 4066  DA - Implementation Options: HorizontalGeneric    11    [DATESTCD]_DADAT
#> 4067  DA - Implementation Options: HorizontalGeneric    12  [DATESTCD]_DAORRES
#> 4068  DA - Implementation Options: HorizontalGeneric    13 [DATESTCD]_DAORRESU
#> 4069  DD - Implementation Options: HorizontalGeneric     1             STUDYID
#> 4070  DD - Implementation Options: HorizontalGeneric     2              SITEID
#> 4071  DD - Implementation Options: HorizontalGeneric     3              SUBJID
#> 4072  DD - Implementation Options: HorizontalGeneric     4               VISIT
#> 4073  DD - Implementation Options: HorizontalGeneric     5              VISDAT
#> 4074  DD - Implementation Options: HorizontalGeneric     6                DDYN
#> 4075  DD - Implementation Options: HorizontalGeneric     7               DDCAT
#> 4076  DD - Implementation Options: HorizontalGeneric     8              DDSCAT
#> 4077  DD - Implementation Options: HorizontalGeneric     9     [DTHDXCD]_DDDAT
#> 4078  DD - Implementation Options: HorizontalGeneric    10              DTHDAT
#> 4079  DD - Implementation Options: HorizontalGeneric    11   [DTHDXCD]_DDORRES
#> 4080  DD - Implementation Options: HorizontalGeneric    12              DDEVAL
#> 4081                                 Central Reading     1             STUDYID
#> 4082                                 Central Reading     2              SITEID
#> 4083                                 Central Reading     3              SUBJID
#> 4084                                 Central Reading     4               VISIT
#> 4085                                 Central Reading     5              VISDAT
#> 4086                                 Central Reading     6               EGCAT
#> 4087                                 Central Reading     7              EGSCAT
#> 4088                                 Central Reading     8              EGPERF
#> 4089                                 Central Reading     9            EGREPNUM
#> 4090                                 Central Reading    10             EGREFID
#> 4091                                 Central Reading    11            EGMETHOD
#> 4092                                 Central Reading    12              EGLEAD
#> 4093                                 Central Reading    13               EGPOS
#> 4094                                 Central Reading    14               EGDAT
#> 4095                                 Central Reading    15               EGTPT
#> 4096                                 Central Reading    16               EGTIM
#> 4097                                   Local Reading     1             STUDYID
#> 4098                                   Local Reading     2              SITEID
#> 4099                                   Local Reading     3              SUBJID
#> 4100                                   Local Reading     4               VISIT
#> 4101                                   Local Reading     5              VISDAT
#> 4102                                   Local Reading     6               EGCAT
#> 4103                                   Local Reading     7              EGSCAT
#> 4104                                   Local Reading     8              EGPERF
#> 4105                                   Local Reading     9            EGREPNUM
#> 4106                                   Local Reading    10            EGMETHOD
#> 4107                                   Local Reading    11              EGLEAD
#> 4108                                   Local Reading    12               EGPOS
#> 4109                                   Local Reading    13               EGDAT
#> 4110                                   Local Reading    14               EGTPT
#> 4111                                   Local Reading    15               EGTIM
#> 4112                                   Local Reading    16              EGTEST
#> 4113                                   Local Reading    17             EGORRES
#> 4114                                   Local Reading    18            EGORRESU
#> 4115                                   Local Reading    19             EGCLSIG
#> 4116    Central Reading with Investigator Assessment     1             STUDYID
#> 4117    Central Reading with Investigator Assessment     2              SITEID
#> 4118    Central Reading with Investigator Assessment     3              SUBJID
#> 4119    Central Reading with Investigator Assessment     4               VISIT
#> 4120    Central Reading with Investigator Assessment     5              VISDAT
#> 4121    Central Reading with Investigator Assessment     6               EGCAT
#> 4122    Central Reading with Investigator Assessment     7              EGSCAT
#> 4123    Central Reading with Investigator Assessment     8              EGPERF
#> 4124    Central Reading with Investigator Assessment     9            EGREPNUM
#> 4125    Central Reading with Investigator Assessment    10             EGREFID
#> 4126    Central Reading with Investigator Assessment    11            EGMETHOD
#> 4127    Central Reading with Investigator Assessment    12              EGLEAD
#> 4128    Central Reading with Investigator Assessment    13               EGPOS
#> 4129    Central Reading with Investigator Assessment    14               EGDAT
#> 4130    Central Reading with Investigator Assessment    15               EGTPT
#> 4131    Central Reading with Investigator Assessment    16               EGTIM
#> 4132    Central Reading with Investigator Assessment    17              EGEVAL
#> 4133    Central Reading with Investigator Assessment    18        INTP_EGORRES
#> 4134    Central Reading with Investigator Assessment    19             EGCLSIG
#> 4135    Central Reading with Investigator Assessment    20              EGMHNO
#> 4136    Central Reading with Investigator Assessment    21              EGAENO
#> 4137                              Central Processing     1             STUDYID
#> 4138                              Central Processing     2              SITEID
#> 4139                              Central Processing     3              SUBJID
#> 4140                              Central Processing     4               VISIT
#> 4141                              Central Processing     5              VISDAT
#> 4142                              Central Processing     6               GFCAT
#> 4143                              Central Processing     7              GFSCAT
#> 4144                              Central Processing     8              GFPERF
#> 4145                              Central Processing     9             GFREFID
#> 4146                              Central Processing    10               GFTPT
#> 4147                              Central Processing    11               GFDAT
#> 4148                              Central Processing    12               GFTIM
#> 4149                                Local Processing     1             STUDYID
#> 4150                                Local Processing     2              SITEID
#> 4151                                Local Processing     3              SUBJID
#> 4152                                Local Processing     4               VISIT
#> 4153                                Local Processing     5              VISDAT
#> 4154                                Local Processing     6               GFCAT
#> 4155                                Local Processing     7              GFSCAT
#> 4156                                Local Processing     8              GFPERF
#> 4157                                Local Processing     9               GFNAM
#> 4158                                Local Processing    10              GFTEST
#> 4159                                Local Processing    11            GFTSTDTL
#> 4160                                Local Processing    12            GFMETHOD
#> 4161                                Local Processing    13               GFTPT
#> 4162                                Local Processing    14               GFDAT
#> 4163                                Local Processing    15               GFTIM
#> 4164                                Local Processing    16             GFORRES
#> 4165                                Local Processing    17            GFORRESU
#> 4166                              Central Processing     1             STUDYID
#> 4167                              Central Processing     2              SITEID
#> 4168                              Central Processing     3              SUBJID
#> 4169                              Central Processing     4               VISIT
#> 4170                              Central Processing     5              VISDAT
#> 4171                              Central Processing     6              LBPERF
#> 4172                              Central Processing     7               LBDAT
#> 4173                              Central Processing     8               LBTIM
#> 4174                              Central Processing     9               LBCAT
#> 4175                              Central Processing    10              LBSCAT
#> 4176                              Central Processing    11              LBSPEC
#> 4177                              Central Processing    12               LBTPT
#> 4178                              Central Processing    13              LBCOND
#> 4179                              Central Processing    14              LBFAST
#> 4180                              Central Processing    15             LBREFID
#> 4181                      Central Processing with CS     1             STUDYID
#> 4182                      Central Processing with CS     2              SITEID
#> 4183                      Central Processing with CS     3              SUBJID
#> 4184                      Central Processing with CS     4               VISIT
#> 4185                      Central Processing with CS     5              VISDAT
#> 4186                      Central Processing with CS     6              LBPERF
#> 4187                      Central Processing with CS     7               LBDAT
#> 4188                      Central Processing with CS     8               LBTIM
#> 4189                      Central Processing with CS     9               LBCAT
#> 4190                      Central Processing with CS    10              LBSCAT
#> 4191                      Central Processing with CS    11              LBSPEC
#> 4192                      Central Processing with CS    12               LBTPT
#> 4193                      Central Processing with CS    13              LBCOND
#> 4194                      Central Processing with CS    14              LBFAST
#> 4195                      Central Processing with CS    15              LBTEST
#> 4196                      Central Processing with CS    16             LBORRES
#> 4197                      Central Processing with CS    17            LBORRESU
#> 4198                      Central Processing with CS    18             LBCLSIG
#> 4199                      Central Processing with CS    19             LBREFID
#> 4200                      Central Processing with CS    20            LBMETHOD
#> 4201                                Local Processing     1             STUDYID
#> 4202                                Local Processing     2              SITEID
#> 4203                                Local Processing     3              SUBJID
#> 4204                                Local Processing     4               VISIT
#> 4205                                Local Processing     5              VISDAT
#> 4206                                Local Processing     6              LBPERF
#> 4207                                Local Processing     7               LBDAT
#> 4208                                Local Processing     8               LBTIM
#> 4209                                Local Processing     9               LBCAT
#> 4210                                Local Processing    10              LBSCAT
#> 4211                                Local Processing    11              LBSPEC
#> 4212                                Local Processing    12               LBTPT
#> 4213                                Local Processing    13              LBFAST
#> 4214                                Local Processing    14              LBCOND
#> 4215                                Local Processing    15            LBSPCCND
#> 4216                                Local Processing    16              LBTEST
#> 4217                                Local Processing    17             LBORRES
#> 4218                                Local Processing    18            LBMETHOD
#> 4219                                Local Processing    19            LBORRESU
#> 4220                                Local Processing    20             LBCRESU
#> 4221                                Local Processing    21             LBTOXGR
#> 4222                                Local Processing    22               LBTOX
#> 4223                                Local Processing    23            LBORNRLO
#> 4224                                Local Processing    24            LBORNRHI
#> 4225                                Local Processing    25             LBNRIND
#> 4226                                Local Processing    26             LBCLSIG
#> 4227                                Local Processing    27               LBNAM
#> 4228                              Central Processing     1             STUDYID
#> 4229                              Central Processing     2              SITEID
#> 4230                              Central Processing     3              SUBJID
#> 4231                              Central Processing     4               VISIT
#> 4232                              Central Processing     5              VISDAT
#> 4233                              Central Processing     6              MBPERF
#> 4234                              Central Processing     7             MBREFID
#> 4235                              Central Processing     8             MBGRPID
#> 4236                              Central Processing     9               MBDAT
#> 4237                              Central Processing    10               MBTIM
#> 4238                              Central Processing    11               MBCAT
#> 4239                              Central Processing    12              MBSCAT
#> 4240                              Central Processing    13              MBSPEC
#> 4241                              Central Processing    14            MBSPCCND
#> 4242                              Central Processing    15               MBLOC
#> 4243                              Central Processing    16               MBLAT
#> 4244                              Central Processing    17               MBDIR
#> 4245                                Local Processing     1             STUDYID
#> 4246                                Local Processing     2              SITEID
#> 4247                                Local Processing     3              SUBJID
#> 4248                                Local Processing     4               VISIT
#> 4249                                Local Processing     5              VISDAT
#> 4250                                Local Processing     6              MBPERF
#> 4251                                Local Processing     7             MBREFID
#> 4252                                Local Processing     8              MBSPID
#> 4253                                Local Processing     9             MBGRPID
#> 4254                                Local Processing    10             MBLNKID
#> 4255                                Local Processing    11               MBDAT
#> 4256                                Local Processing    12               MBTIM
#> 4257                                Local Processing    13               MBCAT
#> 4258                                Local Processing    14              MBSCAT
#> 4259                                Local Processing    15              MBTEST
#> 4260                                Local Processing    16            MBTSTDTL
#> 4261                                Local Processing    17             MBORRES
#> 4262                                Local Processing    18            MBORRESU
#> 4263                                Local Processing    19             MBCLSIG
#> 4264                                Local Processing    20            MBRESCAT
#> 4265                                Local Processing    21               MBNAM
#> 4266                                Local Processing    22              MBSPEC
#> 4267                                Local Processing    23            MBSPCCND
#> 4268                                Local Processing    24               MBLOC
#> 4269                                Local Processing    25               MBLAT
#> 4270                                Local Processing    26               MBDIR
#> 4271                                Local Processing    27            MBMETHOD
#> 4272                                Local Processing    28              MBEVAL
#> 4273                              Central Processing     1             STUDYID
#> 4274                              Central Processing     2              SITEID
#> 4275                              Central Processing     3              SUBJID
#> 4276                              Central Processing     4               VISIT
#> 4277                              Central Processing     5              VISDAT
#> 4278                              Central Processing     6              MIPERF
#> 4279                              Central Processing     7             MIREFID
#> 4280                              Central Processing     8               MIDAT
#> 4281                              Central Processing     9               MITIM
#> 4282                              Central Processing    10               MICAT
#> 4283                              Central Processing    11              MISCAT
#> 4284                              Central Processing    12              MISPEC
#> 4285                              Central Processing    13            MISPCCND
#> 4286                              Central Processing    14               MILOC
#> 4287                              Central Processing    15               MILAT
#> 4288                              Central Processing    16               MIDIR
#> 4289                                Local Processing     1             STUDYID
#> 4290                                Local Processing     2              SITEID
#> 4291                                Local Processing     3              SUBJID
#> 4292                                Local Processing     4               VISIT
#> 4293                                Local Processing     5              VISDAT
#> 4294                                Local Processing     6              MIPERF
#> 4295                                Local Processing     7             MIREFID
#> 4296                                Local Processing     8              MISPID
#> 4297                                Local Processing     9               MIDAT
#> 4298                                Local Processing    10               MITIM
#> 4299                                Local Processing    11               MICAT
#> 4300                                Local Processing    12              MISCAT
#> 4301                                Local Processing    13              MITEST
#> 4302                                Local Processing    14            MITSTDTL
#> 4303                                Local Processing    15             MIORRES
#> 4304                                Local Processing    16            MIORRESU
#> 4305                                Local Processing    17             MICLSIG
#> 4306                                Local Processing    18            MIRESCAT
#> 4307                                Local Processing    19               MINAM
#> 4308                                Local Processing    20              MISPEC
#> 4309                                Local Processing    21            MISPCCND
#> 4310                                Local Processing    22               MILOC
#> 4311                                Local Processing    23               MILAT
#> 4312                                Local Processing    24               MIDIR
#> 4313                                Local Processing    25            MIMETHOD
#> 4314                                Local Processing    26              MIEVAL
#> 4315                              Central Processing     1             STUDYID
#> 4316                              Central Processing     2              SITEID
#> 4317                              Central Processing     3              SUBJID
#> 4318                              Central Processing     4               VISIT
#> 4319                              Central Processing     5              VISDAT
#> 4320                              Central Processing     6              MSPERF
#> 4321                              Central Processing     7             MSREFID
#> 4322                              Central Processing     8               MSDAT
#> 4323                              Central Processing     9               MSTIM
#> 4324                              Central Processing    10               MSCAT
#> 4325                              Central Processing    11              MSSCAT
#> 4326                              Central Processing    12              MSSPEC
#> 4327                              Central Processing    13            MSSPCCND
#> 4328                              Central Processing    14               MSLOC
#> 4329                              Central Processing    15               MSLAT
#> 4330                              Central Processing    16               MSDIR
#> 4331                                Local Processing     1             STUDYID
#> 4332                                Local Processing     2              SITEID
#> 4333                                Local Processing     3              SUBJID
#> 4334                                Local Processing     4               NHOID
#> 4335                                Local Processing     5               VISIT
#> 4336                                Local Processing     6              VISDAT
#> 4337                                Local Processing     7              MSPERF
#> 4338                                Local Processing     8             MSREFID
#> 4339                                Local Processing     9              MSSPID
#> 4340                                Local Processing    10             MSGRPID
#> 4341                                Local Processing    11             MSLNKID
#> 4342                                Local Processing    12               MSDAT
#> 4343                                Local Processing    13               MSTIM
#> 4344                                Local Processing    14               MSCAT
#> 4345                                Local Processing    15              MSSCAT
#> 4346                                Local Processing    16              MSTEST
#> 4347                                Local Processing    17            MSTSTDTL
#> 4348                                Local Processing    18             MSAGENT
#> 4349                                Local Processing    19              MSCONC
#> 4350                                Local Processing    20             MSCONCU
#> 4351                                Local Processing    21             MSORRES
#> 4352                                Local Processing    22            MSORRESU
#> 4353                                Local Processing    23             MSCLSIG
#> 4354                                Local Processing    24            MSRESCAT
#> 4355                                Local Processing    25               MSNAM
#> 4356                                Local Processing    26              MSSPEC
#> 4357                                Local Processing    27            MSSPCCND
#> 4358                                Local Processing    28               MSLOC
#> 4359                                Local Processing    29               MSLAT
#> 4360                                Local Processing    30               MSDIR
#> 4361                                Local Processing    31            MSMETHOD
#> 4362                                Local Processing    32              MSEVAL
#> 4363       PK Sample Collection at Fixed Time Points     1             STUDYID
#> 4364       PK Sample Collection at Fixed Time Points     2              SITEID
#> 4365       PK Sample Collection at Fixed Time Points     3              SUBJID
#> 4366       PK Sample Collection at Fixed Time Points     4               VISIT
#> 4367       PK Sample Collection at Fixed Time Points     5              VISDAT
#> 4368       PK Sample Collection at Fixed Time Points     6              PCPERF
#> 4369       PK Sample Collection at Fixed Time Points     7              PCSTAT
#> 4370       PK Sample Collection at Fixed Time Points     8            PCREASND
#> 4371       PK Sample Collection at Fixed Time Points     9               PCDAT
#> 4372       PK Sample Collection at Fixed Time Points    10             PCDATFL
#> 4373       PK Sample Collection at Fixed Time Points    11               PCTIM
#> 4374       PK Sample Collection at Fixed Time Points    12               PCTPT
#> 4375       PK Sample Collection at Fixed Time Points    13              PCFAST
#> 4376       PK Sample Collection at Fixed Time Points    14              PCCOND
#> 4377       PK Sample Collection at Fixed Time Points    15             PCREFID
#> 4378       PK Sample Collection at Fixed Time Points    16              PCSPEC
#> 4379       PK Sample Collection at Fixed Time Points    17              PCTEST
#> 4380       PK Sample Collection at Fixed Time Points    18             PCORRES
#> 4381       PK Sample Collection at Fixed Time Points    19            PCORRESU
#> 4382       PK Sample Collection over a Time Interval     1             STUDYID
#> 4383       PK Sample Collection over a Time Interval     2              SITEID
#> 4384       PK Sample Collection over a Time Interval     3              SUBJID
#> 4385       PK Sample Collection over a Time Interval     4               VISIT
#> 4386       PK Sample Collection over a Time Interval     5              VISDAT
#> 4387       PK Sample Collection over a Time Interval     6              PCPERF
#> 4388       PK Sample Collection over a Time Interval     7            PCREASND
#> 4389       PK Sample Collection over a Time Interval     8               PCDAT
#> 4390       PK Sample Collection over a Time Interval     9               PCTIM
#> 4391       PK Sample Collection over a Time Interval    10             PCENDAT
#> 4392       PK Sample Collection over a Time Interval    11             PCENTIM
#> 4393       PK Sample Collection over a Time Interval    12               PCTPT
#> 4394       PK Sample Collection over a Time Interval    13              PCFAST
#> 4395       PK Sample Collection over a Time Interval    14              PCCOND
#> 4396       PK Sample Collection over a Time Interval    15             PCREFID
#> 4397       PK Sample Collection over a Time Interval    16              PCSPEC
#> 4398       PK Sample Collection over a Time Interval    17              PCTEST
#> 4399       PK Sample Collection over a Time Interval    18             PCORRES
#> 4400       PK Sample Collection over a Time Interval    19            PCORRESU
#> 4401                                  PE-Traditional     1             STUDYID
#> 4402                                  PE-Traditional     2              SITEID
#> 4403                                  PE-Traditional     3              SUBJID
#> 4404                                  PE-Traditional     4               VISIT
#> 4405                                  PE-Traditional     5              VISDAT
#> 4406                                  PE-Traditional     6              PEPERF
#> 4407                                  PE-Traditional     7               PECAT
#> 4408                                  PE-Traditional     8              PESCAT
#> 4409                                  PE-Traditional     9               PEDAT
#> 4410                                  PE-Traditional    10               PETIM
#> 4411                                  PE-Traditional    11              PESPID
#> 4412                                  PE-Traditional    12              PETEST
#> 4413                                  PE-Traditional    13               PERES
#> 4414                                  PE-Traditional    14              PEDESC
#> 4415                                  PE-Traditional    15             PECLSIG
#> 4416                                  PE-Traditional    16              PEEVAL
#> 4417                                  PE-Traditional    17            PEREASND
#> 4418                                  PE-Traditional    18            PEBODSYS
#> 4419                                  PE-Traditional    19            PEMODIFY
#> 4420                                  PE-Traditional    20               PELOC
#> 4421                                  PE-Traditional    21               PELAT
#> 4422                                  PE-Traditional    22               PEDIR
#> 4423                                  PE-Traditional    23            PEPORTOT
#> 4424                                  PE-Traditional    24            PEMETHOD
#> 4425  SC - Implementation Options: HorizontalGeneric     1             STUDYID
#> 4426  SC - Implementation Options: HorizontalGeneric     2              SITEID
#> 4427  SC - Implementation Options: HorizontalGeneric     3              SUBJID
#> 4428  SC - Implementation Options: HorizontalGeneric     4               VISIT
#> 4429  SC - Implementation Options: HorizontalGeneric     5              VISDAT
#> 4430  SC - Implementation Options: HorizontalGeneric     6    [SCTESTCD]_SCCAT
#> 4431  SC - Implementation Options: HorizontalGeneric     7   [SCTESTCD]_SCSCAT
#> 4432  SC - Implementation Options: HorizontalGeneric     8   [SCTESTCD]_SCPERF
#> 4433  SC - Implementation Options: HorizontalGeneric     9             SCGRPID
#> 4434  SC - Implementation Options: HorizontalGeneric    10  [SCTESTCD]_SCORRES
#> 4435  VS - Implementation Options: HorizontalGeneric     1             STUDYID
#> 4436  VS - Implementation Options: HorizontalGeneric     2              SITEID
#> 4437  VS - Implementation Options: HorizontalGeneric     3              SUBJID
#> 4438  VS - Implementation Options: HorizontalGeneric     4               VISIT
#> 4439  VS - Implementation Options: HorizontalGeneric     5              VISDAT
#> 4440  VS - Implementation Options: HorizontalGeneric     6   [VSTESTCD]_VSPERF
#> 4441  VS - Implementation Options: HorizontalGeneric     7    [VSTESTCD]_VSDAT
#> 4442  VS - Implementation Options: HorizontalGeneric     8    [VSTESTCD]_VSTIM
#> 4443  VS - Implementation Options: HorizontalGeneric     9               VSCAT
#> 4444  VS - Implementation Options: HorizontalGeneric    10              VSSCAT
#> 4445  VS - Implementation Options: HorizontalGeneric    11             VSGRPID
#> 4446  VS - Implementation Options: HorizontalGeneric    12    [VSTESTCD]_VSTPT
#> 4447  VS - Implementation Options: HorizontalGeneric    13   [VSTESTCD]_VSSTAT
#> 4448  VS - Implementation Options: HorizontalGeneric    14  [VSTESTCD]_VSORRES
#> 4449  VS - Implementation Options: HorizontalGeneric    15 [VSTESTCD]_VSORRESU
#> 4450  VS - Implementation Options: HorizontalGeneric    16  [VSTESTCD]_VSCLSIG
#> 4451  VS - Implementation Options: HorizontalGeneric    17    [VSTESTCD]_VSPOS
#> 4452  VS - Implementation Options: HorizontalGeneric    18    [VSTESTCD]_VSLOC
#> 4453  VS - Implementation Options: HorizontalGeneric    19    [VSTESTCD]_VSLAT
#> 4454   Birth date collection using three date fields     1             STUDYID
#> 4455   Birth date collection using three date fields     2              SITEID
#> 4456   Birth date collection using three date fields     3              SUBJID
#> 4457   Birth date collection using three date fields     4              BRTHDD
#> 4458   Birth date collection using three date fields     5              BRTHMO
#> 4459   Birth date collection using three date fields     6              BRTHYY
#> 4460   Birth date collection using three date fields     7             BRTHTIM
#> 4461   Birth date collection using three date fields     8                 AGE
#> 4462   Birth date collection using three date fields     9                AGEU
#> 4463   Birth date collection using three date fields    10               DMDAT
#> 4464   Birth date collection using three date fields    11                 SEX
#> 4465   Birth date collection using three date fields    12              ETHNIC
#> 4466   Birth date collection using three date fields    13             CETHNIC
#> 4467   Birth date collection using three date fields    14                RACE
#> 4468   Birth date collection using three date fields    15               CRACE
#> 4469   Birth date collection using three date fields    16             RACEOTH
#> 4470 Birth date collection using a single date field     1             STUDYID
#> 4471 Birth date collection using a single date field     2              SITEID
#> 4472 Birth date collection using a single date field     3              SUBJID
#> 4473 Birth date collection using a single date field     4             BRTHDAT
#> 4474 Birth date collection using a single date field     5             BRTHTIM
#> 4475 Birth date collection using a single date field     6                 AGE
#> 4476 Birth date collection using a single date field     7                AGEU
#> 4477 Birth date collection using a single date field     8               DMDAT
#> 4478 Birth date collection using a single date field     9                 SEX
#> 4479 Birth date collection using a single date field    10              ETHNIC
#> 4480 Birth date collection using a single date field    11             CETHNIC
#> 4481 Birth date collection using a single date field    12                RACE
#> 4482 Birth date collection using a single date field    13               CRACE
#> 4483 Birth date collection using a single date field    14             RACEOTH
#>                                         label
#> 3231                         Study Identifier
#> 3232                    Study Site Identifier
#> 3233         Subject Identifier for the Study
#> 3234                       Category for Agent
#> 3235                    Subcategory for Agent
#> 3236                Any Procedure Agent Taken
#> 3237            AG Sponsor-Defined Identifier
#> 3238                      Reported Agent Name
#> 3239                          AG Prespecified
#> 3240                            AG Occurrence
#> 3241               AG Dose per Administration
#> 3242        Procedure Agents Dose Description
#> 3243                            AG Dose Units
#> 3244                             AG Dose Form
#> 3245         AG Dosing Frequency per Interval
#> 3246               AG Route of Administration
#> 3247               Procedure Agent Start Date
#> 3248               Procedure Agent Start Time
#> 3249                   Prior Procedure Agents
#> 3250                 Ongoing Procedure Agents
#> 3251                Procedure Agents End Date
#> 3252                Procedure Agents End Time
#> 3253                  Standardized Agent Name
#> 3254                           AG Agent Class
#> 3255                      AG Agent Class Code
#> 3256                         Study Identifier
#> 3257                    Study Site Identifier
#> 3258         Subject Identifier for the Study
#> 3259                  Category for Medication
#> 3260               Subcategory for Medication
#> 3261        Any Concomitant Medications Taken
#> 3262            CM Sponsor-Defined Identifier
#> 3263   Reported Name of Drug, Med, or Therapy
#> 3264                          CM Prespecified
#> 3265                            CM Occurrence
#> 3266      Concomitant Meds Active Ingredients
#> 3267                            CM Indication
#> 3268                 Related Adverse Event ID
#> 3269         Related Medical History Event ID
#> 3270               CM Dose per Administration
#> 3271        Concomitant Meds Dose Description
#> 3272                      CM Total Daily Dose
#> 3273                            CM Dose Units
#> 3274                             CM Dose Form
#> 3275         CM Dosing Frequency per Interval
#> 3276               CM Route of Administration
#> 3277              Concomitant Meds Start Date
#> 3278              Concomitant Meds Start Time
#> 3279                   Prior Concomitant Meds
#> 3280                 Ongoing Concomitant Meds
#> 3281                Concomitant Meds End Date
#> 3282                Concomitant Meds End Time
#> 3283     Reason for Treatment Discontinuation
#> 3284             Standardized Medication Name
#> 3285                      CM Medication Class
#> 3286                 CM Medication Class Code
#> 3287                  ATC Level 1 Description
#> 3288                         ATC Level 1 Code
#> 3289                  ATC Level 2 Description
#> 3290                         ATC Level 2 Code
#> 3291                  ATC Level 3 Description
#> 3292                         ATC Level 3 Code
#> 3293                  ATC Level 4 Description
#> 3294                         ATC Level 4 Code
#> 3295                  ATC Level 5 Description
#> 3296                         ATC Level 5 Code
#> 3297                         Study Identifier
#> 3298                    Study Site Identifier
#> 3299         Subject Identifier for the Study
#> 3300                                    Epoch
#> 3301                Any Study Treatment Taken
#> 3302                    Category of Treatment
#> 3303                 Subcategory of Treatment
#> 3304                                Treatment
#> 3305       Exposure as Collected Prespecified
#> 3306         Exposure as Collected Occurrence
#> 3307          Exposure Reason for Occur Value
#> 3308               Exposure as Collected Mood
#> 3309       Exposure as Collected Reference ID
#> 3310                               Lot Number
#> 3311     Exposure as Collected Fasting Status
#> 3312          Exposure as Collected Dose Form
#> 3313         Exposure as Collected Start Date
#> 3314         Exposure as Collected Start Time
#> 3315           Exposure as Collected End Date
#> 3316           Exposure as Collected End Time
#> 3317   Exposure as Collected Dose Description
#> 3318         Exposure as Collected Dose Units
#> 3319         EC Dosing Frequency per Interval
#> 3320               EC Route of Administration
#> 3321                    Intended Dose Regimen
#> 3322                            Dose Adjusted
#> 3323               Reason for Dose Adjustment
#> 3324                  EC Exposure Interrupted
#> 3325                 EC Interruption Duration
#> 3326           EC Interruption Duration Units
#> 3327       EC Location of Dose Administration
#> 3328         Exposure as Collected Laterality
#> 3329     Exposure as Collected Directionality
#> 3330                        EC Vehicle Amount
#> 3331                  EC Vehicle Amount Units
#> 3332      Exposure as Collected Infusion Rate
#> 3333 Exposure as Collected Infusion Rate Unit
#> 3334               EC Planned Time Point Name
#> 3335                      Completed Treatment
#> 3336                         Study Identifier
#> 3337                    Study Site Identifier
#> 3338         Subject Identifier for the Study
#> 3339                                    Epoch
#> 3340                Any Study Treatment Taken
#> 3341                    Category of Treatment
#> 3342                 Subcategory of Treatment
#> 3343                        Name of Treatment
#> 3344                    Exposure Reference ID
#> 3345                               Lot Number
#> 3346                  Exposure Fasting Status
#> 3347                       Exposure Dose Form
#> 3348                      Exposure Start Date
#> 3349                      Exposure Start Time
#> 3350                        Exposure End Date
#> 3351                        Exposure End Time
#> 3352                Exposure Dose Description
#> 3353                       Exposure Dose Unit
#> 3354   Exposure Dosing Frequency per Interval
#> 3355         Exposure Route of Administration
#> 3356                    Intended Dose Regimen
#> 3357                            Dose Adjusted
#> 3358               Reason for Dose Adjustment
#> 3359                  EX Exposure Interrupted
#> 3360           Exposure Interruption Duration
#> 3361     Exposure Interruption Duration Units
#> 3362 Exposure Location of Dose Administration
#> 3363                  Exposure Vehicle Amount
#> 3364            Exposure Vehicle Amount Units
#> 3365                   Exposure Infusion Rate
#> 3366              Exposure Infusion Rate Unit
#> 3367         Exposure Planned Time Point Name
#> 3368                      Completed Treatment
#> 3369                      Exposure Laterality
#> 3370                  Exposure Directionality
#> 3371                         Study Identifier
#> 3372                    Study Site Identifier
#> 3373         Subject Identifier for the Study
#> 3374                        Category for Meal
#> 3375                     Subcategory for Meal
#> 3376                           Any Meal Taken
#> 3377            ML Sponsor-Defined Identifier
#> 3378             Name of Meal or Food Product
#> 3379                          ML Prespecified
#> 3380                            ML Occurrence
#> 3381                   Reason for Occur Value
#> 3382                                ML Reason
#> 3383                Related Clinical Event ID
#> 3384                                     Dose
#> 3385                         Dose Description
#> 3386                               Dose Units
#> 3387                          Meal Start Date
#> 3388                          Meal Start Time
#> 3389                            Meal End Date
#> 3390                            Meal End Time
#> 3391                   Standardized Meal Name
#> 3392                   Modified Reported Term
#> 3393                         Study Identifier
#> 3394                    Study Site Identifier
#> 3395         Subject Identifier for the Study
#> 3396                 Any Procedures Performed
#> 3397                       Procedure Category
#> 3398                    Procedure Subcategory
#> 3399     Procedure Sponsor-Defined Identifier
#> 3400               Reported Name of Procedure
#> 3401              Standardized Procedure Name
#> 3402                  Modified Procedure Name
#> 3403                   Procedure Prespecified
#> 3404                     Procedure Occurrence
#> 3405         Procedure Reason for Occur Value
#> 3406                Procedure Reason Not Done
#> 3407                          Prior Procedure
#> 3408                     Procedure Start Date
#> 3409                        Ongoing Procedure
#> 3410                       Procedure End Date
#> 3411                     Procedure Indication
#> 3412                 Related Adverse Event ID
#> 3413         Related Medical History Event ID
#> 3414               Procedure Dose Description
#> 3415                      Procedure Dose Unit
#> 3416         Procedure Frequency per Interval
#> 3417        Procedure Route of Administration
#> 3418                    Location of Procedure
#> 3419                     Procedure Laterality
#> 3420                 Procedure Directionality
#> 3421            Procedure Portion or Totality
#> 3422                 Procedure Fasting Status
#> 3423          Procedure Intended Dose Regimen
#> 3424                       Procedure Adjusted
#> 3425          Reason for Procedure Adjustment
#> 3426                      Completed Procedure
#> 3427                    Procedure Interrupted
#> 3428             Reason Procedure Interrupted
#> 3429          Procedure Interruption Duration
#> 3430    Procedure Interruption Duration Units
#> 3431              Procedure Lowest Level Term
#> 3432         Procedure Lowest Level Term Code
#> 3433            Procedure Preferred Term Code
#> 3434                Procedure High Level Term
#> 3435           Procedure High Level Term Code
#> 3436          Procedure High Level Group Term
#> 3437     Procedure High Level Group Term Code
#> 3438            PR Primary System Organ Class
#> 3439       PR Primary System Organ Class Code
#> 3440                         Study Identifier
#> 3441                    Study Site Identifier
#> 3442         Subject Identifier for the Study
#> 3443               Reported Name of Substance
#> 3444               Category for Substance Use
#> 3445            Subcategory for Substance Use
#> 3446                          SU Prespecified
#> 3447                       Any Substance Used
#> 3448               Never Current Former Usage
#> 3449 Substance Use Sponsor-Defined Identifier
#> 3450       Reason Substance Use Not Collected
#> 3451               Substance Dose Description
#> 3452     Substance Use Frequency per Interval
#> 3453                 Substance Use Start Date
#> 3454                   Substance Use End Date
#> 3455         Substance Use Collected Duration
#> 3456    Substance Use Collected Duration Unit
#> 3457                  Modified Substance Name
#> 3458              Standardized Substance Name
#> 3459                         Study Identifier
#> 3460                    Study Site Identifier
#> 3461         Subject Identifier for the Study
#> 3462                        Any Adverse Event
#> 3463               Category for Adverse Event
#> 3464            Subcategory for Adverse Event
#> 3465            AE Sponsor-Defined Identifier
#> 3466      Reported Term for the Adverse Event
#> 3467                 Adverse Event Occurrence
#> 3468               prespecified Adverse Event
#> 3469                 Adverse Event Start Date
#> 3470              Start Time of Adverse Event
#> 3471                     AE Location of Event
#> 3472                 Adverse Event Laterality
#> 3473             Adverse Event Directionality
#> 3474          AE Location Portion or Totality
#> 3475                    Ongoing Adverse Event
#> 3476                   Adverse Event End Date
#> 3477                End Time of Adverse Event
#> 3478                    AE Severity/Intensity
#> 3479               AE Standard Toxicity Grade
#> 3480                         AE Serious Event
#> 3481                         Results in Death
#> 3482                               Death Date
#> 3483                      Is Life Threatening
#> 3484     Requires or Prolongs Hospitalization
#> 3485  Persist or Signif Disability/Incapacity
#> 3486       Congenital Anomaly or Birth Defect
#> 3487 Needs Intervention to Prevent Impairment
#> 3488  Other Medically Important Serious Event
#> 3489                          Involves Cancer
#> 3490                   Occurred with Overdose
#> 3491                             AE Causality
#> 3492        Action Taken with Study Treatment
#> 3493                Actions Taken with Device
#> 3494                  Any Other Actions Taken
#> 3495                       Other Action Taken
#> 3496                 Outcome of Adverse Event
#> 3497          AE Caused Study Discontinuation
#> 3498        AE Related to Non-Study Treatment
#> 3499   AE Relationship to Non-Study Treatment
#> 3500        Adverse Event of Special Interest
#> 3501                 Pattern of Adverse Event
#> 3502   Concomitant or Additional Trtmnt Given
#> 3503                AE Modified Reported Term
#> 3504               AE Dictionary-Derived Term
#> 3505                     AE Lowest Level Term
#> 3506                AE Lowest Level Term Code
#> 3507                   AE Preferred Term Code
#> 3508                       AE High Level Term
#> 3509                  AE High Level Term Code
#> 3510                 AE High Level Group Term
#> 3511            AE High Level Group Term Code
#> 3512            AE Primary System Organ Class
#> 3513       AE Primary System Organ Class Code
#> 3514                         Study Identifier
#> 3515                    Study Site Identifier
#> 3516         Subject Identifier for the Study
#> 3517              Category for Clinical Event
#> 3518           Subcategory for Clinical Event
#> 3519                       Any Clinical Event
#> 3520            CE Sponsor-Defined Identifier
#> 3521     Reported Term for the Clinical Event
#> 3522                Clinical Event Occurrence
#> 3523              Clinical Event Prespecified
#> 3524                Clinical Event Start Date
#> 3525                Clinical Event Start Time
#> 3526                  Clinical Event Location
#> 3527                Clinical Event Laterality
#> 3528            Clinical Event Directionality
#> 3529          CE Location Portion or Totality
#> 3530                   Ongoing Clinical Event
#> 3531                  Clinical Event End Date
#> 3532                  Clinical Event End Time
#> 3533                    CE Severity/Intensity
#> 3534      Clinical Event Toxicity Description
#> 3535            Clinical Event Toxicity Grade
#> 3536             Clinical Event Modified Term
#> 3537               CE Dictionary-Derived Term
#> 3538         Clinical Event Lowest Level Term
#> 3539    Clinical Event Lowest Level Term Code
#> 3540       Clinical Event Preferred Term Code
#> 3541           Clinical Event High Level Term
#> 3542      Clinical Event High Level Term Code
#> 3543     Clinical Event High Level Group Term
#> 3544            CE High Level Group Term Code
#> 3545            CE Primary System Organ Class
#> 3546       CE Primary System Organ Class Code
#> 3547                         Study Identifier
#> 3548                    Study Site Identifier
#> 3549         Subject Identifier for the Study
#> 3550          Category for Protocol Deviation
#> 3551       Subcategory for Protocol Deviation
#> 3552                   Any Protocol Deviation
#> 3553            Protocol Deviation Coded Term
#> 3554                  Protocol Deviation Term
#> 3555                     Deviation Start Date
#> 3556                     Deviation Start Time
#> 3557                       Deviation End Date
#> 3558                       Deviation End Time
#> 3559            DV Sponsor-Defined Identifier
#> 3560                         Study Identifier
#> 3561                    Study Site Identifier
#> 3562         Subject Identifier for the Study
#> 3563                Any Healthcare Encounters
#> 3564        Category for Healthcare Encounter
#> 3565     Subcategory for Healthcare Encounter
#> 3566          Healthcare Encounter Occurrence
#> 3567        prespecified Healthcare Encounter
#> 3568     Reason Healthcare Encounter Not Done
#> 3569            HO Sponsor-Defined Identifier
#> 3570   Reported Term for Healthcare Encounter
#> 3571                     HO Standardized Term
#> 3572          Healthcare Encounter Start Date
#> 3573          Healthcare Encounter Start Time
#> 3574            Healthcare Encounter End Date
#> 3575            Healthcare Encounter End Time
#> 3576  Healthcare Encounter Collected Duration
#> 3577               HO Collected Duration Unit
#> 3578             Ongoing Healthcare Encounter
#> 3579      Reason for the Healthcare Encounter
#> 3580                 Related Adverse Event ID
#> 3581                         Study Identifier
#> 3582                    Study Site Identifier
#> 3583         Subject Identifier for the Study
#> 3584                Any Medical History Event
#> 3585             Category for Medical History
#> 3586          Subcategory for Medical History
#> 3587          Medical History Collection Date
#> 3588            MH Sponsor-Defined Identifier
#> 3589          Medical History Event Date Type
#> 3590    Reported Term for the Medical History
#> 3591               Medical History Occurrence
#> 3592       Medical History Event Prespecified
#> 3593              Prior Medical History Event
#> 3594            Ongoing Medical History Event
#> 3595      MH Disease or Symptom Under Control
#> 3596         Medical History Event Start Date
#> 3597           Medical History Event End Date
#> 3598           Medical History Event Location
#> 3599         Medical History Event Laterality
#> 3600           Medical History Directionality
#> 3601    MH Event Location Portion or Totality
#> 3602                MH Modified Reported Term
#> 3603               MH Dictionary-Derived Term
#> 3604  Medical History Event Lowest Level Term
#> 3605          MH Event Lowest Level Term Code
#> 3606             MH Event Preferred Term Code
#> 3607    Medical History Event High Level Term
#> 3608            MH Event High Level Term Code
#> 3609           MH Event High Level Group Term
#> 3610      MH Event High Level Group Term Code
#> 3611      MH Event Primary System Organ Class
#> 3612 MH Event Primary System Organ Class Code
#> 3613                         Study Identifier
#> 3614                    Study Site Identifier
#> 3615         Subject Identifier for the Study
#> 3616                               Visit Name
#> 3617                               Visit Date
#> 3618              Category for Cell Phenotype
#> 3619           Subcategory for Cell Phenotype
#> 3620            Cell Phenotype Test Performed
#> 3621     Cell Phenotype Specimen Reference ID
#> 3622 Cell Phtype Test Planned Time Point Name
#> 3623  Cell Phenotype Specimen Collection Date
#> 3624  Cell Phenotype Specimen Collection Time
#> 3625                         Study Identifier
#> 3626                    Study Site Identifier
#> 3627         Subject Identifier for the Study
#> 3628                               Visit Name
#> 3629                               Visit Date
#> 3630      Cardiovascular Assessment Performed
#> 3631           Cardiovascular Assessment Date
#> 3632           Cardiovascular Assessment Time
#> 3633    CV Assessment Planned Time Point Name
#> 3634      Cardiovascular Assessment Test Name
#> 3635         Category for Cardiovascular Test
#> 3636          Subcategory Cardiovascular Test
#> 3637   CV Assessment Result in Original Units
#> 3638              CV Assessment Original Unit
#> 3639     CV Assessment Test Result or Finding
#> 3640           Description of CV Test Finding
#> 3641                     CV Completion Status
#> 3642                       CV Reason Not Done
#> 3643                   CV Position of Subject
#> 3644    Location of CV Assessment Measurement
#> 3645     Cardiovascular Assessment Laterality
#> 3646 Cardiovascular Assessment Directionality
#> 3647      Method of Cardiovascular Assessment
#> 3648      Cardiovascular Assessment Evaluator
#> 3649       CV Assessment Evaluator Identifier
#> 3650                         Study Identifier
#> 3651                    Study Site Identifier
#> 3652         Subject Identifier for the Study
#> 3653                               Visit Name
#> 3654                               Visit Date
#> 3655                 Accountability Performed
#> 3656                DA Category of Assessment
#> 3657             DA Subcategory of Assessment
#> 3658                 Drug Accountability Date
#> 3659              Accountability Reference ID
#> 3660        Name of Accountability Assessment
#> 3661   DA Assessment Result in Original Units
#> 3662                        DA Original Units
#> 3663                         Study Identifier
#> 3664                    Study Site Identifier
#> 3665         Subject Identifier for the Study
#> 3666                               Visit Name
#> 3667                               Visit Date
#> 3668                 Any Death Detail Results
#> 3669         Death Details Date of Collection
#> 3670 Death Details Sponsor-Defined Identifier
#> 3671                               Death Date
#> 3672             Death Detail Assessment Name
#> 3673          Death Details Result or Finding
#> 3674       Results Category for Death Details
#> 3675                  Death Details Evaluator
#> 3676                         Study Identifier
#> 3677                    Study Site Identifier
#> 3678         Subject Identifier for the Study
#> 3679                               Visit Name
#> 3680                               Visit Date
#> 3681          Any Incl/Excl Criteria Findings
#> 3682      Inclusion/Exclusion Collection Date
#> 3683             Inclusion/Exclusion Category
#> 3684          Inclusion/Exclusion Subcategory
#> 3685 Inclusion/Exclusion Criterion Short Name
#> 3686            Inclusion/Exclusion Criterion
#> 3687            I/E Criterion Original Result
#> 3688                         Study Identifier
#> 3689                    Study Site Identifier
#> 3690         Subject Identifier for the Study
#> 3691                               Visit Name
#> 3692                               Visit Date
#> 3693                        MK Test Performed
#> 3694                       MK Collection Date
#> 3695                       MK Collection Time
#> 3696               MK Planned Time Point Name
#> 3697             Name of Musculoskeletal Test
#> 3698        Category for Musculoskeletal Test
#> 3699     Subcategory for Musculoskeletal Test
#> 3700         MK Test Result in Original Units
#> 3701                    MK Test Original Unit
#> 3702                MK Test Result or Finding
#> 3703    Musculoskeletal Findings Descriptions
#> 3704    Musculoskeletal Findings Result Other
#> 3705    MK Findings Reference Range Indicator
#> 3706     MK System Findings Completion Status
#> 3707       MK System Findings Reason Not Done
#> 3708   MK System Findings Position of Subject
#> 3709        Musculoskeletal Findings Location
#> 3710      Musculoskeletal Findings Laterality
#> 3711  Musculoskeletal Findings Directionality
#> 3712         MK Method of Test or Examination
#> 3713           Musculoskeletal Test Evaluator
#> 3714        Musculoskeletal Test Evaluator ID
#> 3715                  MK Accepted Record Flag
#> 3716   Musculoskeletal Test Repetition Number
#> 3717                         Study Identifier
#> 3718                    Study Site Identifier
#> 3719         Subject Identifier for the Study
#> 3720                               Visit Name
#> 3721                               Visit Date
#> 3722           Neurology Assessment Performed
#> 3723                Neurology Assessment Date
#> 3724                Neurology Assessment Time
#> 3725               NV Planned Time Point Name
#> 3726                      Neurology Test Name
#> 3727              Category for Neurology Test
#> 3728           Subcategory for Neurology Test
#> 3729  Neurology Test Result in Original Units
#> 3730             Neurology Test Original Unit
#> 3731         Neurology Test Result or Finding
#> 3732    Description of Neurology Test Finding
#> 3733              Neurology Test Result Other
#> 3734  NV Ref Range Lower Limit- Original Unit
#> 3735  NV Ref Range Upper Limit- Original Unit
#> 3736             NV Reference Range Indicator
#> 3737         Neurology Test Completion Status
#> 3738           Neurology Test Reason Not Done
#> 3739   Position of Subject During Observation
#> 3740                                 Location
#> 3741                               Laterality
#> 3742                           Directionality
#> 3743                 Method of Neurology Test
#> 3744                 Neurology Test Evaluator
#> 3745      Neurology Test Evaluator Identifier
#> 3746         Neurology Test Repetition Number
#> 3747     Neurology Test Clinical Significance
#> 3748                         Study Identifier
#> 3749                    Study Site Identifier
#> 3750         Subject Identifier for the Study
#> 3751                               Visit Name
#> 3752                               Visit Date
#> 3753         Focus of Study-specific Interest
#> 3754         Ophthalmic Examination Performed
#> 3755              Ophthalmic Examination Date
#> 3756              Ophthalmic Examination Time
#> 3757 Name of Measurement, Test or Examination
#> 3758  Measurement, Test or Examination Detail
#> 3759                                 Category
#> 3760                              Subcategory
#> 3761       Result of Finding in Original Unit
#> 3762                            Original Unit
#> 3763              Collected Result or Finding
#> 3764                             Result Other
#> 3765  Normal Range Lower Limit- Original Unit
#> 3766  Normal Range Upper Limit- Original Unit
#> 3767 Collected Character/Ordinal Normal Range
#> 3768         Normal/Reference Range Indicator
#> 3769                          Result Category
#> 3770                          Reason Not Done
#> 3771                                 Location
#> 3772                               Laterality
#> 3773                           Directionality
#> 3774                      Portion or Totality
#> 3775            Method of Test or Examination
#> 3776                                Evaluator
#> 3777                     Evaluator Identifier
#> 3778                     Accepted Record Flag
#> 3779 Ophthalmic Examination Repetition Number
#> 3780                         Study Identifier
#> 3781                    Study Site Identifier
#> 3782         Subject Identifier for the Study
#> 3783                               Visit Name
#> 3784                               Visit Date
#> 3785         Respiratory Assessment Performed
#> 3786              Respiratory Assessment Date
#> 3787              Respiratory Assessment Time
#> 3788    RE Assessment Planned Time Point Name
#> 3789                    Respiratory Test Name
#> 3790            Category for Respiratory Test
#> 3791         Subcategory for Respiratory Test
#> 3792         RE Test Result in Original Units
#> 3793           Respiratory Test Original Unit
#> 3794       Respiratory Test Result or Finding
#> 3795  Description of Respiratory Test Finding
#> 3796            Respiratory Test Result Other
#> 3797  RE Ref Range Lower Limit- Original Unit
#> 3798  RE Ref Range Upper Limit- Original Unit
#> 3799             RE Reference Range Indicator
#> 3800                        Completion Status
#> 3801                          Reason Not Done
#> 3802   Position of Subject During Observation
#> 3803                                 Location
#> 3804                               Laterality
#> 3805                           Directionality
#> 3806               Method of Respiratory Test
#> 3807               Respiratory Test Evaluator
#> 3808    Respiratory Test Evaluator Identifier
#> 3809                     Accepted Record Flag
#> 3810       Respiratory Test Repetition Number
#> 3811   Respiratory Test Clinical Significance
#> 3812                         Study Identifier
#> 3813                    Study Site Identifier
#> 3814         Subject Identifier for the Study
#> 3815                               Visit Name
#> 3816                               Visit Date
#> 3817       Category for Repro System Findings
#> 3818    Subcategory for Repro System Findings
#> 3819 Reproductive System Evaluation Performed
#> 3820                  RP Reason Not Performed
#> 3821         Any Reproductive System Findings
#> 3822            RP Sponsor-Defined Identifier
#> 3823   Reproductive System Findings Test Name
#> 3824   RP Result or Finding in Original Units
#> 3825                        RP Original Units
#> 3826         Reproductive System Finding Date
#> 3827                         Study Identifier
#> 3828                    Study Site Identifier
#> 3829         Subject Identifier for the Study
#> 3830                               Visit Name
#> 3831                               Visit Date
#> 3832      Category for Response or Clin Class
#> 3833   Subcategory for Response or Clin Class
#> 3834         Response or Clin Class Performed
#> 3835   Response or Clin Class Reason Not Done
#> 3836   Response or Clin Class Assessment Date
#> 3837         Response or Clin Class Evaluator
#> 3838      Response or Clin Class Evaluator ID
#> 3839           Response or Clin Class Link ID
#> 3840        Response or Clin Class Link Group
#> 3841   Response or Clin Class Assessment Name
#> 3842   Response or Clin Class Original Result
#> 3843    Response or Clin Class Original Units
#> 3844                         Study Identifier
#> 3845                    Study Site Identifier
#> 3846         Subject Identifier for the Study
#> 3847                               Visit Name
#> 3848                               Visit Date
#> 3849      Category for Subject Characteristic
#> 3850   Subcategory for Subject Characteristic
#> 3851                  SC Assessment Performed
#> 3852            SC Sponsor-Defined Identifier
#> 3853   Subject Characteristic Collection Date
#> 3854                   Subject Characteristic
#> 3855   SC Result or Finding in Original Units
#> 3856                         Study Identifier
#> 3857                    Study Site Identifier
#> 3858         Subject Identifier for the Study
#> 3859                               Visit Name
#> 3860                               Visit Date
#> 3861           Tumor/Lesion Result Link Group
#> 3862          Category of Tumor/Lesion Result
#> 3863       Subcategory of Tumor/Lesion Result
#> 3864    Tumor/Lesion Result Completion Status
#> 3865   Reason Tumor Measurement Not Performed
#> 3866            Tumor/Lesion Result Evaluator
#> 3867 Tumor/Lesion Result Evaluator Identifier
#> 3868                 Tumor/Lesion Result Date
#> 3869              Tumor/Lesion Result Link ID
#> 3870        Tumor/Lesion Assessment Test Name
#> 3871   TR Result or Finding in Original Units
#> 3872                        TR Original Units
#> 3873          Tumor/Lesion Result Vendor Name
#> 3874                         Study Identifier
#> 3875                    Study Site Identifier
#> 3876         Subject Identifier for the Study
#> 3877                               Visit Name
#> 3878                               Visit Date
#> 3879  Category of Tumor/Lesion Identification
#> 3880  Subcategory Tumor/Lesion Identification
#> 3881       Any Tumors/ Lesions Identification
#> 3882         Tumor/Lesion Identification Date
#> 3883                   Tumor/Lesion Evaluator
#> 3884        Tumor/Lesion Evaluator Identifier
#> 3885      Tumor/Lesion Identification Link ID
#> 3886        Tumor/Lesion Related Procedure ID
#> 3887    Tumor/Lesion Method of Identification
#> 3888 Tumor/Lesion Identification Reference ID
#> 3889    Tumor/Lesion Identification Test Name
#> 3890       Tumor/Lesion Identification Result
#> 3891             Location of the Tumor/Lesion
#> 3892   Tumor/Lesion Identification Laterality
#> 3893              Tumor/Lesion Directionality
#> 3894        TU Identification Location Detail
#> 3895  Tumor/Lesion Identification Vendor Name
#> 3896                         Study Identifier
#> 3897                    Study Site Identifier
#> 3898         Subject Identifier for the Study
#> 3899                               Visit Name
#> 3900                               Visit Date
#> 3901             Urinary Assessment Performed
#> 3902                  Urinary Assessment Date
#> 3903                  Urinary Assessment Time
#> 3904    UR Assessment Planned Time Point Name
#> 3905                        Urinary Test Name
#> 3906                Category for Urinary Test
#> 3907             Subcategory for Urinary Test
#> 3908         UR Test Result in Original Units
#> 3909               Urinary Test Original Unit
#> 3910           Urinary Test Result or Finding
#> 3911      Description of Urinary Test Finding
#> 3912                Urinary Test Result Other
#> 3913                        Completion Status
#> 3914                          Reason Not Done
#> 3915                                 Location
#> 3916                               Laterality
#> 3917                           Directionality
#> 3918                   Method of Urinary Test
#> 3919                   Urinary Test Evaluator
#> 3920        Urinary Test Evaluator Identifier
#> 3921                     Accepted Record Flag
#> 3922           Urinary Test Repetition Number
#> 3923       Urinary Test Clinical Significance
#> 3924                         Study Identifier
#> 3925                    Study Site Identifier
#> 3926         Subject Identifier for the Study
#> 3927                               Visit Name
#> 3928                               Visit Date
#> 3929                    Vital Signs Performed
#> 3930                         Vital Signs Date
#> 3931                         Vital Signs Time
#> 3932   Vital Signs Sponsor-Defined Identifier
#> 3933      Vital Signs Planned Time Point Name
#> 3934                 Category for Vital Signs
#> 3935              Subcategory for Vital Signs
#> 3936            Vital Signs Repetition Number
#> 3937                    Vital Signs Test Name
#> 3938            Vital Signs Completion Status
#> 3939   VS Result or Finding in Original Units
#> 3940                        VS Original Units
#> 3941        Vital Signs Clinical Significance
#> 3942      Location of Vital Signs Measurement
#> 3943          Vital Signs Position of Subject
#> 3944               Vital Signs Directionality
#> 3945                   Vital Signs Laterality
#> 3946                         Study Identifier
#> 3947                    Study Site Identifier
#> 3948         Subject Identifier for the Study
#> 3949                               Visit Name
#> 3950                               Visit Date
#> 3951 Findings About Object of the Observation
#> 3952                 Findings About Collected
#> 3953                 Findings About Performed
#> 3954           Findings About Assessment Date
#> 3955           Findings About Assessment Time
#> 3956                 Findings About Test Name
#> 3957               Findings About Test Detail
#> 3958              Category for Findings About
#> 3959           Subcategory for Findings About
#> 3960       Findings About Position of Subject
#> 3961   FA Result or Finding in Original Units
#> 3962                        FA Original Units
#> 3963   FA Normal Range Lower Limit- Orig Unit
#> 3964   FA Normal Range Upper Limit- Orig Unit
#> 3965 Findings About Reference Range Indicator
#> 3966         Findings About Completion Status
#> 3967      Findings About Reason Not Performed
#> 3968             Findings About Specimen Type
#> 3969        Findings About Specimen Condition
#> 3970            Location of the Finding About
#> 3971  Laterality of Location of Finding About
#> 3972            Findings About Directionality
#> 3973          FA Location Portion or Totality
#> 3974                    Findings About Method
#> 3975                      Findings About Lead
#> 3976            Findings About Fasting Status
#> 3977                 Findings About Evaluator
#> 3978      Findings About Evaluator Identifier
#> 3979     Findings About Clinical Significance
#> 3980                         Study Identifier
#> 3981                    Study Site Identifier
#> 3982         Subject Identifier for the Study
#> 3983                               Visit Name
#> 3984                               Visit Date
#> 3985             Skin Response Test Performed
#> 3986            Skin Response Reason Not Done
#> 3987          Skin Response Category for Test
#> 3988       Skin Response Subcategory for Test
#> 3989 Skin Response Sponsor-Defined Identifier
#> 3990  Skin Response Object of the Observation
#> 3991          SR Date of Reference Time Point
#> 3992          SR Time of Reference Time Point
#> 3993         SR Location Used for Measurement
#> 3994                 Skin Response Laterality
#> 3995   Skin Response Test or Examination Name
#> 3996    Skin Response Planned Time Point Name
#> 3997           Skin Response Observation Date
#> 3998           Skin Response Observation Time
#> 3999             Skin Response Directionality
#> 4000                  Skin Response Evaluator
#> 4001       Skin Response Evaluator Identifier
#> 4002 SR Results or Findings in Original Units
#> 4003                        SR Original Units
#> 4004  Skin Response Reference Range Indicator
#> 4005      Skin Response Clinical Significance
#> 4006                         Study Identifier
#> 4007                    Study Site Identifier
#> 4008         Subject Identifier for the Study
#> 4009                                  Comment
#> 4010                         Study Identifier
#> 4011                    Study Site Identifier
#> 4012         Subject Identifier for the Study
#> 4013           Category for Disposition Event
#> 4014        Subcategory for Disposition Event
#> 4015                                    Epoch
#> 4016            Standardized Disposition Term
#> 4017  Reported Term for the Disposition Event
#> 4018             Disposition Event Start Date
#> 4019             Disposition Event Start Time
#> 4020                                Unblinded
#> 4021                         Study Identifier
#> 4022                    Study Site Identifier
#> 4023         Subject Identifier for the Study
#> 4024           Category for Disposition Event
#> 4025        Subcategory for Disposition Event
#> 4026                                    Epoch
#> 4027            Standardized Disposition Term
#> 4028  Reported Term for the Disposition Event
#> 4029             Disposition Event Start Date
#> 4030             Disposition Event Start Time
#> 4031                               Death Date
#> 4032                         Subject Continue
#> 4033                               Next EPOCH
#> 4034                  SAE/Reaction Start Time
#> 4035                  SAE/Reaction Start Time
#> 4036                       Dechallenge Result
#> 4037                       Rechallenge Result
#> 4038                                Narrative
#> 4039                     Causality Assessment
#> 4040                   Adverse Event Assessed
#> 4041              Causality Assessment Source
#> 4042              Causality Assessment Method
#> 4043                   Reporter's Middle Name
#> 4044                      Reporter's Postcode
#> 4045             Reporter's State or Province
#> 4046                          Reporter's City
#> 4047                        Reporter's Street
#> 4048                     Reporter's Telephone
#> 4049                           Reporter's Fax
#> 4050  Date Rpt Was First Received from Source
#> 4051                         Reporter's Title
#> 4052                   Sender's Email Address
#> 4053           Report Nullification/amendment
#> 4054       Gestation Period of Fetus at Onset
#> 4055           Gestation Period at Onset Unit
#> 4056                         Study Identifier
#> 4057                    Study Site Identifier
#> 4058         Subject Identifier for the Study
#> 4059                               Visit Name
#> 4060                               Visit Date
#> 4061          Product Accountability Group ID
#> 4062         Product Accountability Performed
#> 4063                DA Category of Assessment
#> 4064             DA Subcategory of Assessment
#> 4065           DA Accountability Reference ID
#> 4066     DA Accountability Date of Assessment
#> 4067   DA Assessment Result in Original Units
#> 4068                        DA Original Units
#> 4069                         Study Identifier
#> 4070                    Study Site Identifier
#> 4071         Subject Identifier for the Study
#> 4072                               Visit Name
#> 4073                               Visit Date
#> 4074                 Any Death Detail Results
#> 4075               Category for Death Details
#> 4076            Subcategory for Death Details
#> 4077         Death Details Date of Collection
#> 4078                            Date of Death
#> 4079          Death Details Result or Finding
#> 4080                  Death Details Evaluator
#> 4081                         Study Identifier
#> 4082                    Study Site Identifier
#> 4083         Subject Identifier for the Study
#> 4084                               Visit Name
#> 4085                               Visit Date
#> 4086                         Category for ECG
#> 4087                      Subcategory for ECG
#> 4088                            ECG Performed
#> 4089                    ECG Repetition Number
#> 4090                         ECG Reference ID
#> 4091                       Method of ECG Test
#> 4092   ECG Lead Location Used for Measurement
#> 4093                  ECG Position of Subject
#> 4094                                 ECG Date
#> 4095              ECG Planned Time Point Name
#> 4096                                 ECG Time
#> 4097                         Study Identifier
#> 4098                    Study Site Identifier
#> 4099         Subject Identifier for the Study
#> 4100                               Visit Name
#> 4101                               Visit Date
#> 4102                         Category for ECG
#> 4103                      Subcategory for ECG
#> 4104                            ECG Performed
#> 4105                    ECG Repetition Number
#> 4106                       Method of ECG Test
#> 4107   ECG Lead Location Used for Measurement
#> 4108                  ECG Position of Subject
#> 4109                              Date of ECG
#> 4110              ECG Planned Time Point Name
#> 4111                              Time of ECG
#> 4112             ECG Test or Examination Name
#> 4113  ECG Result or Finding in Original Units
#> 4114                       ECG Original Units
#> 4115                ECG Clinical Significance
#> 4116                         Study Identifier
#> 4117                    Study Site Identifier
#> 4118         Subject Identifier for the Study
#> 4119                               Visit Name
#> 4120                               Visit Date
#> 4121                         Category for ECG
#> 4122                      Subcategory for ECG
#> 4123                            ECG Performed
#> 4124                    ECG Repetition Number
#> 4125                         ECG Reference ID
#> 4126                       Method of ECG Test
#> 4127   ECG Lead Location Used for Measurement
#> 4128                  ECG Position of Subject
#> 4129                              Date of ECG
#> 4130              ECG Planned Time Point Name
#> 4131                              Time of ECG
#> 4132                            ECG Evaluator
#> 4133                       ECG Interpretation
#> 4134                ECG Clinical Significance
#> 4135         Related Medical History Event ID
#> 4136                 Related Adverse Event ID
#> 4137                         Study Identifier
#> 4138                    Study Site Identifier
#> 4139         Subject Identifier for the Study
#> 4140                               Visit Name
#> 4141                               Visit Date
#> 4142                Category for Genomic Test
#> 4143             Subcategory for Genomic Test
#> 4144                   Genomic Test Performed
#> 4145            Genomic Specimen Reference ID
#> 4146     Genomic Test Planned Time Point Name
#> 4147         Genomic Specimen Collection Date
#> 4148         Genomic Specimen Collection Time
#> 4149                         Study Identifier
#> 4150                    Study Site Identifier
#> 4151         Subject Identifier for the Study
#> 4152                               Visit Name
#> 4153                               Visit Date
#> 4154                Category for Genomic Test
#> 4155             Subcategory for Genomic Test
#> 4156                   Genomic Test Performed
#> 4157                   Laboratory/Vendor Name
#> 4158                     Name of Genomic Test
#> 4159             Genomic Findings Test Detail
#> 4160                   Method of Genomic Test
#> 4161     Genomic Test Planned Time Point Name
#> 4162         Genomic Specimen Collection Date
#> 4163         Genomic Specimen Collection Time
#> 4164   GF Result or Finding in Original Units
#> 4165 Genomic Result or Finding Original Units
#> 4166                         Study Identifier
#> 4167                    Study Site Identifier
#> 4168         Subject Identifier for the Study
#> 4169                               Visit Name
#> 4170                               Visit Date
#> 4171                            Lab Performed
#> 4172                 Specimen Collection Date
#> 4173                 Specimen Collection Time
#> 4174                    Category for Lab Test
#> 4175                 Subcategory for Lab Test
#> 4176                         LB Specimen Type
#> 4177              Lab Planned Time Point Name
#> 4178                   Lab Test Condition Met
#> 4179                       Lab Fasting Status
#> 4180                          Lab Specimen ID
#> 4181                         Study Identifier
#> 4182                    Study Site Identifier
#> 4183         Subject Identifier for the Study
#> 4184                               Visit Name
#> 4185                               Visit Date
#> 4186                            Lab Performed
#> 4187                 Specimen Collection Date
#> 4188                 Specimen Collection Time
#> 4189                    Category for Lab Test
#> 4190                 Subcategory for Lab Test
#> 4191                         LB Specimen Type
#> 4192              Lab Planned Time Point Name
#> 4193                   Lab Test Condition Met
#> 4194                       Lab Fasting Status
#> 4195             Lab Test or Examination Name
#> 4196  Lab Result or Finding in Original Units
#> 4197                       Lab Original Units
#> 4198                Lab Clinical Significance
#> 4199                          Lab Specimen ID
#> 4200        Lab Method of Test or Examination
#> 4201                         Study Identifier
#> 4202                    Study Site Identifier
#> 4203         Subject Identifier for the Study
#> 4204                               Visit Name
#> 4205                               Visit Date
#> 4206                            Lab Performed
#> 4207                 Specimen Collection Date
#> 4208                 Specimen Collection Time
#> 4209                    Category for Lab Test
#> 4210                 Subcategory for Lab Test
#> 4211                         LB Specimen Type
#> 4212              Lab Planned Time Point Name
#> 4213                       Lab Fasting Status
#> 4214                   Lab Test Condition Met
#> 4215                   Lab Specimen Condition
#> 4216             Lab Test or Examination Name
#> 4217  Lab Result or Finding in Original Units
#> 4218        Lab Method of Test or Examination
#> 4219                       Lab Original Units
#> 4220          Lab Collected Non-Standard Unit
#> 4221              Lab Standard Toxicity Grade
#> 4222                             Lab Toxicity
#> 4223   Lab Ref Range Lower Limit in Orig Unit
#> 4224   Lab Ref Range Upper Limit in Orig Unit
#> 4225            Lab Reference Range Indicator
#> 4226                Lab Clinical Significance
#> 4227                              Vendor Name
#> 4228                         Study Identifier
#> 4229                    Study Site Identifier
#> 4230         Subject Identifier for the Study
#> 4231                               Visit Name
#> 4232                               Visit Date
#> 4233          Microbiology Sampling Performed
#> 4234                          MB Reference ID
#> 4235                              MB Group ID
#> 4236              MB Specimen Collection Date
#> 4237              MB Specimen Collection Time
#> 4238     MB Category for Microbiology Finding
#> 4239  MB Subcategory for Microbiology Finding
#> 4240                         MB Specimen Type
#> 4241                    MB Specimen Condition
#> 4242          MB Specimen Collection Location
#> 4243        MB Specimen Collection Laterality
#> 4244    MB Specimen Collection Directionality
#> 4245                         Study Identifier
#> 4246                    Study Site Identifier
#> 4247         Subject Identifier for the Study
#> 4248                               Visit Name
#> 4249                               Visit Date
#> 4250          Microbiology Sampling Performed
#> 4251                          MB Reference ID
#> 4252            MB Sponsor-Defined Identifier
#> 4253                              MB Group ID
#> 4254                               MB Link ID
#> 4255              MB Specimen Collection Date
#> 4256              MB Specimen Collection Time
#> 4257     MB Category for Microbiology Finding
#> 4258  MB Subcategory for Microbiology Finding
#> 4259        Microbiology Test or Finding Name
#> 4260          Microbiology Examination Detail
#> 4261   MB Result or Finding in Original Units
#> 4262                        MB Original Units
#> 4263                 MB Clinical Significance
#> 4264                       MB Result Category
#> 4265                           MB Vendor Name
#> 4266                         MB Specimen Type
#> 4267                    MB Specimen Condition
#> 4268          MB Specimen Collection Location
#> 4269        MB Specimen Collection Laterality
#> 4270    MB Specimen Collection Directionality
#> 4271         MB Method of Test or Examination
#> 4272                             MB Evaluator
#> 4273                         Study Identifier
#> 4274                    Study Site Identifier
#> 4275         Subject Identifier for the Study
#> 4276                               Visit Name
#> 4277                               Visit Date
#> 4278        Microscopic Examination Performed
#> 4279                          MI Reference ID
#> 4280                 Specimen Collection Date
#> 4281                 Specimen Collection Time
#> 4282         Category for Microscopic Finding
#> 4283      Subcategory for Microscopic Finding
#> 4284                MI Specimen Material Type
#> 4285                    MI Specimen Condition
#> 4286          MI Specimen Collection Location
#> 4287    MI Specimen Laterality within Subject
#> 4288 MI Specimen Directionality within Subjct
#> 4289                         Study Identifier
#> 4290                    Study Site Identifier
#> 4291         Subject Identifier for the Study
#> 4292                               Visit Name
#> 4293                               Visit Date
#> 4294        Microscopic Examination Performed
#> 4295                          MI Reference ID
#> 4296            MI Sponsor-Defined Identifier
#> 4297                 Specimen Collection Date
#> 4298                 Specimen Collection Time
#> 4299         Category for Microscopic Finding
#> 4300      Subcategory for Microscopic Finding
#> 4301             Microscopic Examination Name
#> 4302           Microscopic Examination Detail
#> 4303   MI Result or Finding in Original Units
#> 4304                        MI Original Units
#> 4305                 MI Clinical Significance
#> 4306                       MI Result Category
#> 4307                   Laboratory/Vendor Name
#> 4308                MI Specimen Material Type
#> 4309                    MI Specimen Condition
#> 4310          MI Specimen Collection Location
#> 4311    MI Specimen Laterality within Subject
#> 4312 MI Specimen Directionality within Subjct
#> 4313         MI Method of Test or Examination
#> 4314                             MI Evaluator
#> 4315                         Study Identifier
#> 4316                    Study Site Identifier
#> 4317         Subject Identifier for the Study
#> 4318                               Visit Name
#> 4319                               Visit Date
#> 4320                        MS Test Performed
#> 4321                          MS Reference ID
#> 4322              MS Specimen Collection Date
#> 4323              MS Specimen Collection Time
#> 4324        MS Category for Organism Findings
#> 4325     MS Subcategory for Organism Findings
#> 4326                         MS Specimen Type
#> 4327                    MS Specimen Condition
#> 4328          MS Specimen Collection Location
#> 4329        MS Specimen Collection Laterality
#> 4330    MS Specimen Collection Directionality
#> 4331                         Study Identifier
#> 4332                    Study Site Identifier
#> 4333         Subject Identifier for the Study
#> 4334                     Non-host Organism ID
#> 4335                               Visit Name
#> 4336                               Visit Date
#> 4337         MS Susceptibility Test Performed
#> 4338                          MS Reference ID
#> 4339            MS Sponsor-Defined Identifier
#> 4340                              MS Group ID
#> 4341                               MS Link ID
#> 4342              MS Specimen Collection Date
#> 4343              MS Specimen Collection Time
#> 4344        MS Category for Organism Findings
#> 4345     MS Subcategory for Organism Findings
#> 4346         MS Organism Test or Finding Name
#> 4347  Microbiology Susceptibility Test Detail
#> 4348        Microbiology Susceptibility Agent
#> 4349                   MS Agent Concentration
#> 4350              MS Agent Concentration Unit
#> 4351   MS Result or Finding in Original Units
#> 4352                        MS Original Units
#> 4353                 MS Clinical Significance
#> 4354                       MS Result Category
#> 4355                           MS Vendor Name
#> 4356                         MS Specimen Type
#> 4357                    MS Specimen Condition
#> 4358          MS Specimen Collection Location
#> 4359        MS Specimen Collection Laterality
#> 4360    MS Specimen Collection Directionality
#> 4361         MS Method of Test or Examination
#> 4362                             MS Evaluator
#> 4363                         Study Identifier
#> 4364                    Study Site Identifier
#> 4365         Subject Identifier for the Study
#> 4366                               Visit Name
#> 4367                               Visit Date
#> 4368                    PK Sampling Performed
#> 4369            PK Sampling Completion Status
#> 4370              PK Sampling Reason Not Done
#> 4371                PK Sample Collection Date
#> 4372                    PK Sampling Date Flag
#> 4373                PK Sample Collection Time
#> 4374      PK Sampling Planned Time Point Name
#> 4375               PK Sampling Fasting Status
#> 4376           PK Sampling Test Condition Met
#> 4377                 PK Sampling Reference ID
#> 4378                PK Sampling Specimen Type
#> 4379                    PK Sampling Test Name
#> 4380     PK Sampling Result in Original Units
#> 4381               PK Sampling Original Units
#> 4382                         Study Identifier
#> 4383                    Study Site Identifier
#> 4384         Subject Identifier for the Study
#> 4385                               Visit Name
#> 4386                               Visit Date
#> 4387                    PK Sampling Performed
#> 4388              PK Sampling Reason Not Done
#> 4389                PK Sample Collection Date
#> 4390                PK Sample Collection Time
#> 4391            PK Sample Collection End Date
#> 4392            PK Sample Collection End Time
#> 4393      PK Sampling Planned Time Point Name
#> 4394               PK Sampling Fasting Status
#> 4395           PK Sampling Test Condition Met
#> 4396                 PK Sampling Reference ID
#> 4397                PK Sampling Specimen Type
#> 4398                    PK Sampling Test Name
#> 4399     PK Sampling Result in Original Units
#> 4400               PK Sampling Original Units
#> 4401                         Study Identifier
#> 4402                    Study Site Identifier
#> 4403         Subject Identifier for the Study
#> 4404                               Visit Name
#> 4405                               Visit Date
#> 4406           Physical Examination Performed
#> 4407                 Category for Examination
#> 4408              Subcategory for Examination
#> 4409                Physical Examination Date
#> 4410                Physical Examination Time
#> 4411 Physical Exam Sponsor-Defined Identifier
#> 4412                     Body System Examined
#> 4413           Physical Exam Verbatim Finding
#> 4414          Physical Exam Abnormal Findings
#> 4415      Physical Exam Clinical Significance
#> 4416                  Physical Exam Evaluator
#> 4417        Physical Exam Reason Not Examined
#> 4418               Body System or Organ Class
#> 4419     Physical Exam Modified Reported Term
#> 4420        Location of Physical Exam Finding
#> 4421                 Physical Exam Laterality
#> 4422             Physical Exam Directionality
#> 4423          PE Location Portion or Totality
#> 4424         PE Method of Test or Examination
#> 4425                         Study Identifier
#> 4426                    Study Site Identifier
#> 4427         Subject Identifier for the Study
#> 4428                               Visit Name
#> 4429                               Visit Date
#> 4430      Category for Subject Characteristic
#> 4431   Subcategory for Subject Characteristic
#> 4432                  SC Assessment Performed
#> 4433         Subject Characteristics Group ID
#> 4434   SC Result or Finding in Original Units
#> 4435                         Study Identifier
#> 4436                    Study Site Identifier
#> 4437         Subject Identifier for the Study
#> 4438                               Visit Name
#> 4439                               Visit Date
#> 4440                    Vital Signs Performed
#> 4441                         Vital Signs Date
#> 4442                         Vital Signs Time
#> 4443                 Category for Vital Signs
#> 4444              Subcategory for Vital Signs
#> 4445                     Vital Signs Group ID
#> 4446      Vital Signs Planned Time Point Name
#> 4447            Vital Signs Completion Status
#> 4448   VS Result or Finding in Original Units
#> 4449                        VS Original Units
#> 4450        Vital Signs Clinical Significance
#> 4451          Vital Signs Position of Subject
#> 4452      Location of Vital Signs Measurement
#> 4453                   Vital Signs Laterality
#> 4454                         Study Identifier
#> 4455                    Study Site Identifier
#> 4456         Subject Identifier for the Study
#> 4457                                Birth Day
#> 4458                              Birth Month
#> 4459                               Birth Year
#> 4460                               Birth Time
#> 4461                                      Age
#> 4462                                Age Units
#> 4463             Demographics Collection Date
#> 4464                                      Sex
#> 4465                                Ethnicity
#> 4466                      Collected Ethnicity
#> 4467                                     Race
#> 4468                           Collected Race
#> 4469                               Race Other
#> 4470                         Study Identifier
#> 4471                    Study Site Identifier
#> 4472         Subject Identifier for the Study
#> 4473                               Birth Date
#> 4474                               Birth Time
#> 4475                                      Age
#> 4476                                Age Units
#> 4477             Demographics Collection Date
#> 4478                                      Sex
#> 4479                                Ethnicity
#> 4480                      Collected Ethnicity
#> 4481                                     Race
#> 4482                           Collected Race
#> 4483                               Race Other
#>                                                                                                                                                                                                                                    question_text
#> 3231                                                                                                                                                                                                               What is the study identifier?
#> 3232                                                                                                                                                                                                                What is the site identifier?
#> 3233                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3234                                                                                                                                                                                  What is the category for the [procedure/assessment agent]?
#> 3235                                                                                                                                                                               What is the subcategory for the [procedure/assessment agent]?
#> 3236                                                                                                                                                                    [Were/Was] there any [procedure/assessment agent(s)] taken/administered?
#> 3237                                                                                                                                                                                                                  [Sponsor defined question]
#> 3238                                                                                                                                                                                      What was the [procedure/assessment agent] [name/term]?
#> 3239                                                                                                                                                                                                                                        <NA>
#> 3240                                                                                                                                                                 [Has/Was] the subject (been) administered the [procedure/assessment agent]?
#> 3241                                                                                                                                                        What was the individual dose per administration of the [procedure/assessment agent]?
#> 3242                                                                                                                                                                           What was the individual dose of the [procedure/assessment agent]?
#> 3243                                                                                                                                                                        What is the unit (for the dose of the [procedure/assessment agent])?
#> 3244                                                                                                                                                                                 What was the dose form of the [procedure/assessment agent]?
#> 3245                                                                                                                                                                                 What was the frequency of the [procedure/assessment agent]?
#> 3246                                                                                                                                                                   What was the route of administration of the [procedure/assessment agent]?
#> 3247                                                                                                                                                                                        What was the procedure/assessment agent] start date?
#> 3248                                                                                                                                                                                       What was the [procedure/assessment agent] start time?
#> 3249                                                                                                          Was the [procedure/assessment agent] administered prior to AGSTTPT? Was the procedure/assessment agent given prior to study start?
#> 3250                                                                                                                                             Was the [procedure/assessment agent] ongoing (as of the [study-specific time point or period])?
#> 3251                                                                                                                                                                                       What was the [procedure/assessment agent's] end date?
#> 3252                                                                                                                                                                                       What was the [procedure/assessment agent's] end time?
#> 3253                                                                                                                                                                                                                                        <NA>
#> 3254                                                                                                                                                                                                                                        <NA>
#> 3255                                                                                                                                                                                                                                        <NA>
#> 3256                                                                                                                                                                                                               What is the study identifier?
#> 3257                                                                                                                                                                                                                What is the site identifier?
#> 3258                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3259                                                                                                                                                                  What is the category for the (concomitant) [medication/treatment/therapy]?
#> 3260                                                                                                                                                               What is the subcategory for the (concomitant) [medication/treatment/therapy]?
#> 3261                                                                                                                                                                 Were/Was any (concomitant) [medication(s)/treatment(s)/therapy(ies)] taken?
#> 3262                                                                                                                                                                                                                  [Sponsor-defined question]
#> 3263                                                                                                                                                                      What was the (concomitant) [medication/treatment/therapy] (name/term)?
#> 3264                                                                                                                                                                                                                                        <NA>
#> 3265                                                                 Did the subject take [prespecified (concomitant) medication/treatment/therapy/dose]?; Has the subject taken [prespecified (concomitant) medication/treatment/therapy/dose]?
#> 3266                                                                                                                                                                                                           What were the active ingredients?
#> 3267                                                                                                                                                             For what indication was the (concomitant) [medication/treatment/therapy] taken?
#> 3268                                                                                                                      What was the identifier for the adverse event(s) for which the (concomitant) [medication/treatment/therapy] was taken?
#> 3269                                                                                                              What was the identifier for the medical history event(s) for which the (concomitant) [medication/treatment/therapy] was taken?
#> 3270                                                                                                                                        What was the individual dose (of the concomitant [medication/treatment/therapy] per administration)?
#> 3271                                                                                                                                                           What was the individual dose of the (concomitant) [medication/treatment/therapy]?
#> 3272                                                                                                                                                          What was the total daily dose of the (concomitant) [medication/treatment/therapy]?
#> 3273                                                                                                                                                              What is the unit (for the dose of concomitant [medication/treatment/therapy])?
#> 3274                                                                                                                                                                 What was the dose form of the (concomitant) [medication/treatment/therapy]?
#> 3275                                                                                                                                                                 What was the frequency of the (concomitant) [medication/treatment/therapy]?
#> 3276                                                                                                                                                   What was the route of administration of the (concomitant) [medication/treatment/therapy]?
#> 3277                                                                                                                                                                  What was the (concomitant) [medication/treatment/therapy/dose] start date?
#> 3278                                                                                                                                                                  What was the (concomitant) [medication/treatment/therapy/dose] start time?
#> 3279                                                                Was the (concomitant) [medication/treatment/therapy] given/taken prior to [CMSTTPT]?; Was the (concomitant) [medication/treatment/therapy] given/taken prior to study start?
#> 3280                                                                                                                             Was the (concomitant) [medication/treatment/therapy] ongoing (as of [the study-specific time point or period])?
#> 3281                                                                                                                                                                    What was the (concomitant) [medication/treatment/therapy/dose] end date?
#> 3282                                                                                                                                                                                  What was the [medication/treatment/therapy/dose] end time?
#> 3283                                                                                                                               What was the reason the (concomitant) [medication/treatment/therapy/ --TRT] was [discontinued/stopped/ended]?
#> 3284                                                                                                                                                                                                                                        <NA>
#> 3285                                                                                                                                                                                                                                        <NA>
#> 3286                                                                                                                                                                                                                                        <NA>
#> 3287                                                                                                                                                                                                                                        <NA>
#> 3288                                                                                                                                                                                                                                        <NA>
#> 3289                                                                                                                                                                                                                                        <NA>
#> 3290                                                                                                                                                                                                                                        <NA>
#> 3291                                                                                                                                                                                                                                        <NA>
#> 3292                                                                                                                                                                                                                                        <NA>
#> 3293                                                                                                                                                                                                                                        <NA>
#> 3294                                                                                                                                                                                                                                        <NA>
#> 3295                                                                                                                                                                                                                                        <NA>
#> 3296                                                                                                                                                                                                                                        <NA>
#> 3297                                                                                                                                                                                                               What is the study identifier?
#> 3298                                                                                                                                                                                                                What is the site identifier?
#> 3299                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3300                                                                                                                                                                                                                    What is the trial epoch?
#> 3301                                                                                                                                                                                                       Were any[study treatment/dose] taken?
#> 3302                                                                                                                                                                                         What is the category of the [study treatment/dose]?
#> 3303                                                                                                                                                                                      What is the subcategory of the [study treatment/dose]?
#> 3304                                                                                                                                                                                What was the [study treatment/investigational product] name?
#> 3305                                                                                                                                                                                                                                        <NA>
#> 3306                                                                                                                                                     Was [study treatment/dose] administered?; Has the subject taken [study treatment/dose]?
#> 3307                                                                                                                                                                        What was the reason that the [study treatment/dose] was (not) taken?
#> 3308                                                                                                                                             Does this record describe scheduled [study treatment/dose] or performed [study treatment/dose]?
#> 3309                                                                                                                                                                                         What is the[study treatment/dose] label identifier?
#> 3310                                                                                                                                                                                  What was the lot number of the[study treatment/dose] used?
#> 3311                                                                                                                                                                                                                    Was the subject fasting?
#> 3312                                                                                                                                                                                       What was the dose form of the [study treatment/dose]?
#> 3313                                                                                                                                                             What was the ([intended/planned/actual]) ([study treatment/dose]) (start) date?
#> 3314                                                                                                                                                             What was the ([intended/planned/actual]) ([study treatment/dose]) (start) time?
#> 3315                                                                                                                                                               What was the ([intended/planned/actual]) ([study treatment/dose]) (end) date?
#> 3316                                                                                                                                                               What was the ([intended/planned/actual]) ([study treatment/dose]) (end) time?
#> 3317                                                                                                                                                                         What was the dose (per administration) (of [study treatment/dose])?
#> 3318                                                                                                                                                                                                           What were the units for the dose?
#> 3319                                                                                                                                                                                    What was the frequency of [study treatment/dose] dosing?
#> 3320                                                                                                                                                                       What was the route of administration (of the [study treatment/dose])?
#> 3321                                                                                                                                                                                                         What was the intended dose regimen?
#> 3322                                                                                                                                                                                                                      Was the dose adjusted?
#> 3323                                                                                                                                                                                                  What was the reason the dose was adjusted?
#> 3324                                                                                                                                                                                               Was the [(study) treatment/dose] interrupted?
#> 3325                                                                                                                                                                                        What was the duration of the treatment interruption?
#> 3326                                                                                                                                                                                                    What was the interruption duration unit?
#> 3327                                                                                                                                                            What was the anatomical location of the ([study treatment/dose]) administration?
#> 3328                                                                                                                                                What was the side of the anatomical location of the ([study treatment/dose]) administration?
#> 3329                                                                                                                                      What was the directionality of the anatomical location of the ([study treatment/dose]) administration?
#> 3330                                                                                                                                                        What was the total amount (Drug + Vehicle) (of [study treatment/dose]) administered?
#> 3331                                                                                                                                                                  What was the unit for the amount (of [study treatment/dose]) administered?
#> 3332                                                                                                                                                                                          What was the [study treatment/dose] infusion rate?
#> 3333                                                                                                                                                                           What was the unit for the ([study treatment/dose]) infusion rate?
#> 3334                                                                                                                                                                                 What was the planned time point for [study treatment/dose]?
#> 3335                                                                                                                                                                         Did the subject complete the full course of [study treatment/dose]?
#> 3336                                                                                                                                                                                                               What is the study identifier?
#> 3337                                                                                                                                                                                                                What is the site identifier?
#> 3338                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3339                                                                                                                                                                                                                    What is the trial epoch?
#> 3340                                                                                                                                                                                                       Were any[study treatment/dose] taken?
#> 3341                                                                                                                                                                                        What is the category of the [study treatment/dose] ?
#> 3342                                                                                                                                                                                     What is the subcategory of the [study treatment/dose] ?
#> 3343                                                                                                                                                                                What was the [study treatment/investigational product] name?
#> 3344                                                                                                                                                                                        What is the [study treatment/dose] label identifier?
#> 3345                                                                                                                                                                                  What was the lot number of the[study treatment/dose] used?
#> 3346                                                                                                                                                                                                                    Was the subject fasting?
#> 3347                                                                                                                                                                                      What was the dose form of the [study treatment/dose] ?
#> 3348                                                                                                                                                             What was the ([intended/planned/actual]) ([study treatment/dose]) (start) date?
#> 3349                                                                                                                                                             What was the ([intended/planned/actual]) ([study treatment/dose]) (start) time?
#> 3350                                                                                                                                                               What was the ([intended/planned/actual]) ([study treatment/dose]) (end) date?
#> 3351                                                                                                                                                               What was the ([intended/planned/actual]) ([study treatment/dose]) (end) time?
#> 3352                                                                                                                                                                        What was the dose [per administration] (of [study treatment/dose]) ?
#> 3353                                                                                                                                                                                                             What was the unit for the dose?
#> 3354                                                                                                                                                                                     What was the frequency of[study treatment/dose] dosing?
#> 3355                                                                                                                                                                      What was the route of administration (of the [study treatment/dose] )?
#> 3356                                                                                                                                                                        What was the intended dose regimen (of the [study treatment/dose] )?
#> 3357                                                                                                                                                                                                                      Was the dose adjusted?
#> 3358                                                                                                                                                                                   What was the reason the dose was adjusted (from planned)?
#> 3359                                                                                                                                                                                              Was the [ (study) treatment/dose] interrupted?
#> 3360                                                                                                                                                                                 If the dose was interrupted, how long was the interruption?
#> 3361                                                                                                                                                             If the dose was interrupted, what were the units for the interruption duration?
#> 3362                                                                                                                                                           What was the anatomical location of the ([study treatment/dose] ) administration?
#> 3363                                                                                                                                                        What was the total amount (Drug + Vehicle)(of [study treatment/dose] ) administered?
#> 3364                                                                                                                                                                 What was the unit for the amount (of [study treatment/dose] ) administered?
#> 3365                                                                                                                                                                                          What was the [study treatment/dose] infusion rate?
#> 3366                                                                                                                                                                           What were the units for the [study treatment/dose] infusion rate?
#> 3367                                                                                                                                                                                What was the planned time point for [study treatment/dose] ?
#> 3368                                                                                                                                                                        Did the subject complete the full course of [study treatment/dose] ?
#> 3369                                                                                                                                               What was the side of the anatomical location of the ([study treatment/dose] ) administration?
#> 3370                                                                                                                                     What was the directionality of the anatomical location of the ([study treatment/dose] ) administration?
#> 3371                                                                                                                                                                                                               What is the study identifier?
#> 3372                                                                                                                                                                                                                What is the site identifier?
#> 3373                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3374                                                                                                                                                                                           What is the category for the [meal/food product]?
#> 3375                                                                                                                                                                                        What is the subcategory for the [meal/food product]?
#> 3376                                                                                                                                                                          [Were/Was] any [meal/food product] [taken/consumed/administered] ?
#> 3377                                                                                                                                                                                                                  [Sponsor-defined question]
#> 3378                                                                                                                                                                                    What was the [meal/food product/sponsor-defined] (name)?
#> 3379                                                                                                                                                                                                                                        <NA>
#> 3380                                                                                                                                                       Did the subject take [MLTRT]?; Has the subject [taken/consumed/administered] [MLTRT]?
#> 3381                                                                                                                                                           What was the reason that the [MLTRT] was (not) consumed/taken/done/administered]?
#> 3382                                                                                                                                                             What was the reason for the [meal/food product] [[taken/consumed/administered]?
#> 3383                                                                                                                       What was the identifier for the clinical event s) for which the (meal/food product] was [taken/consumed/administered]
#> 3384                                                                                                                                                  What was the quantity/amount (of the) ([meal/food product]) [taken/consumed/administered]?
#> 3385                                                                                                                                                      What was quantity/amount (of the) ([meal/food product]) [taken/consumed/administered]?
#> 3386                                                                                                                                                                        What is the unit for the quantity/amount of the [meal/food product]?
#> 3387                                                                                                                                                  What was the (start) date the [meal/food product] was first [taken/consumed/administered]?
#> 3388                                                                                                                                                                                                What was the [meal/food product] start time?
#> 3389                                                                                                                                                                                                  What was the [meal/food product] end date?
#> 3390                                                                                                                                                                                                  What was the [meal/food product] end time?
#> 3391                                                                                                                                                                                                                                        <NA>
#> 3392                                                                                                                                                                                                                                        <NA>
#> 3393                                                                                                                                                                                                               What is the study identifier?
#> 3394                                                                                                                                                                                                                What is the site identifier?
#> 3395                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3396                                                                                                                                                                         Were any surgical, therapeutic, or diagnostic procedures performed?
#> 3397                                                                                                                                                                                                     What was the category of the procedure?
#> 3398                                                                                                                                                                                                  What was the subcategory of the procedure?
#> 3399                                                                                                                                                                                                                  [Sponsor-defined question]
#> 3400                                                                                                                                                                                                                What was the procedure name?
#> 3401                                                                                                                                                                                                                                        <NA>
#> 3402                                                                                                                                                                                                                                        <NA>
#> 3403                                                                                                                                                                                                                                        <NA>
#> 3404                                                                                                                                                                        Was [PRDECOD/PRTRT] performed?; Has the subject had [PRDECOD/PRTRT]?
#> 3405                                                                                                                                                                                    What was the reason that the procedure did or not occur?
#> 3406                                                                                                                                                                                                               What was the reason not done?
#> 3407                                                                                                                                          Was the procedure performed prior to [PRSTTPT]?; Was the procedure performed prior to study start?
#> 3408                                                                                                                                                                                                       What was the procedure (start) date ?
#> 3409                                                                                                                                                                 Was the procedure ongoing (as of the [study-specific timepoint or period])?
#> 3410                                                                                                                                                                                                          What was the procedure (end) date?
#> 3411                                                                                                                                                                                              For what indication was the [PRTRT] performed?
#> 3412                                                                                                                                                     What was the identifier for the adverse event(s) for which the procedure was performed?
#> 3413                                                                                                                                             What was the identifier for the medical history event(s) for which the procedure was performed?
#> 3414                                                                                                                                                               What was the [dose/amount] of [PRTRT] (per administration/for the procedure)?
#> 3415                                                                                                                                                                                                                          What was the unit?
#> 3416                                                                                                                                                                                                          What was the frequency of [PRTRT]?
#> 3417                                                                                                                                                                                      What was the route of administration of the procedure?
#> 3418                                                                                                                                                                         What was the anatomical location where the procedure was performed?
#> 3419                                                                                                                                                                         What was the side of the anatomical location of the administration?
#> 3420                                                                                                                                                                    What was the directionality of the anatomical location of the procedure?
#> 3421                                                                                                                                                               What was the portion or totality of the anatomical location that was treated?
#> 3422                                                                                                                                                                                                                    Was the subject fasting?
#> 3423                                                                                                                                                                                                    What was the intended procedure regimen?
#> 3424                                                                                                                                                                                                            Was the procedure dose adjusted?
#> 3425                                                                                                                                                                                        What was the reason the procedure dose was adjusted?
#> 3426                                                                                                                                                                                    Did the subject complete the full course of the [PRTRT]?
#> 3427                                                                                                                                                                                                              Was the procedure interrupted?
#> 3428                                                                                                                                                                                                          Why was the procedure interrupted?
#> 3429                                                                                                                                                                                        What was the duration of the procedure interruption?
#> 3430                                                                                                                                                                                                    What was the interruption duration unit?
#> 3431                                                                                                                                                                                                                                        <NA>
#> 3432                                                                                                                                                                                                                                        <NA>
#> 3433                                                                                                                                                                                                                                        <NA>
#> 3434                                                                                                                                                                                                                                        <NA>
#> 3435                                                                                                                                                                                                                                        <NA>
#> 3436                                                                                                                                                                                                                                        <NA>
#> 3437                                                                                                                                                                                                                                        <NA>
#> 3438                                                                                                                                                                                                                                        <NA>
#> 3439                                                                                                                                                                                                                                        <NA>
#> 3440                                                                                                                                                                                                               What is the study identifier?
#> 3441                                                                                                                                                                                                                What is the site identifier?
#> 3442                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3443                                                                                                                                                                                      What [is/was] the [name/type] of (the) substance used?
#> 3444                                                                                                                                                                                           What is/was the category of the substance (used)?
#> 3445                                                                                                                                                                                           What was the subcategory of the substance (used)?
#> 3446                                                                                                                                                                                                                                        <NA>
#> 3447                                                                                                                                                                           Were any [sponsor-phrase/substance name/recreational drugs] used?
#> 3448                                                                                                                                                                                         Has the subject ever [used/consumed] [SUTRT/SUCAT]?
#> 3449                                                                                                                                                                                                                  [Sponsor-defined question]
#> 3450                                                                                                                                                                                             What was the reason the data was not collected?
#> 3451                                                                                                                                                                                            What is/was the amount of [SUTRT] used/consumed?
#> 3452                                                                                                                                                                                   What [is/was] the frequency of [SUTRT] [use/consumption]?
#> 3453                                                                                                                                                                                   What was the start date of [SUTRT/SUCAT] use/consumption?
#> 3454                                                                                                                                                                                     What was the end date of [SUTRT/SUCAT] use/consumption?
#> 3455                                                                                                                                                                                     What was the duration of [SUTRT/SUCAT] use/consumption?
#> 3456                                                                                                                                                                             What was the unit of duration of [SUTRT/SUCAT] use/consumption?
#> 3457                                                                                                                                                                                                                                        <NA>
#> 3458                                                                                                                                                                                                                                        <NA>
#> 3459                                                                                                                                                                                                               What is the study identifier?
#> 3460                                                                                                                                                                                                                What is the site identifier?
#> 3461                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3462                                                                                                                                                                                                        Were any adverse events experienced?
#> 3463                                                                                                                                                                                                  What is the category of the adverse event?
#> 3464                                                                                                                                                                                               What is the subcategory of the adverse event?
#> 3465                                                                                                                                                                                                                  [Sponsor-defined question]
#> 3466                                                                                                                                                                                                             What is the adverse event term?
#> 3467                                                                                                                                                                  Did the subject have [prespecified adverse event/group of adverse events]?
#> 3468                                                                                                                                                                                                                                        <NA>
#> 3469                                                                                                                                                                                                       What is the adverse event start date?
#> 3470                                                                                                                                                                                                       What is the adverse event start time?
#> 3471                                                                                                                                                                                       What is the anatomical location of the adverse event?
#> 3472                                                                                                                                                                           What is the side of the anatomical location of the adverse event?
#> 3473                                                                                                                                                                 What is the directionality of the anatomical location of the adverse event?
#> 3474                                                                                                                                                            What is the portion or totality of the anatomical location of the adverse event?
#> 3475                                                                                                                                                             Is the adverse event ongoing (as of [the study-specific time point or period])?
#> 3476                                                                                                                                                                                                        What was the adverse event end date?
#> 3477                                                                                                                                                                                                        What was the adverse event end time?
#> 3478                                                                                                                                                                                                  What is the severity of the adverse event?
#> 3479                                                                                                                                                                What is the [NCI CTCAE/Name of scale (toxicity) grade] of the adverse event?
#> 3480                                                                                                                                                                                                              Was the adverse event serious?
#> 3481                                                                                                                                                                                                      Did the adverse event result in death?
#> 3482                                                                                                                                                                                                  What [is/was] the subject's date of death?
#> 3483                                                                                                                                                                                                     Was the adverse event life threatening?
#> 3484                                                                                                                                                       Did the adverse event result in initial or prolonged hospitalization for the subject?
#> 3485                                                                                                                                                                             Did the adverse event result in disability or permanent damage?
#> 3486                                                                                                                                                                 Was the adverse event associated with a congenital anomaly or birth defect?
#> 3487                                                                                                           Did the adverse event require intervention to prevent permanent impairment or damage resulting from the use of a medical product?
#> 3488                                                                                                                                                    Was the adverse event a medically important event not covered by other serious criteria?
#> 3489                                                                                                                                                                            Was the adverse event associated with the development of cancer?
#> 3490                                                                                                                                                                                               Did the adverse event occur with an overdose?
#> 3491                                                                                                                                                                                          Was this adverse event related to study treatment?
#> 3492                                                                                                                                                                                                 What action was taken with study treatment?
#> 3493                                                                                                                                                                                      What action was taken with a device used in the study?
#> 3494                                                                                                                                                                             Were any other actions taken in response to this adverse event?
#> 3495                                                                                                                                                                                                                What other action was taken?
#> 3496                                                                                                                                                                                                  What is the outcome of this adverse event?
#> 3497                                                                                                                                                                  Did the adverse event cause the subject to be discontinued from the study?
#> 3498                                                                                                                                                                         Was this adverse event due to treatment other than study treatment?
#> 3499                                                                                                                                                                                            What is the relationship to non-study treatment?
#> 3500                                                                                                                                                                                                          Is this event of special interest?
#> 3501                                                                                                                                                                                                          What is the adverse event pattern?
#> 3502                                                                                                                                                                  Was a concomitant or additional treatment given due to this adverse event?
#> 3503                                                                                                                                                                                                                                        <NA>
#> 3504                                                                                                                                                                                                                                        <NA>
#> 3505                                                                                                                                                                                                                                        <NA>
#> 3506                                                                                                                                                                                                                                        <NA>
#> 3507                                                                                                                                                                                                                                        <NA>
#> 3508                                                                                                                                                                                                                                        <NA>
#> 3509                                                                                                                                                                                                                                        <NA>
#> 3510                                                                                                                                                                                                                                        <NA>
#> 3511                                                                                                                                                                                                                                        <NA>
#> 3512                                                                                                                                                                                                                                        <NA>
#> 3513                                                                                                                                                                                                                                        <NA>
#> 3514                                                                                                                                                                                                               What is the study identifier?
#> 3515                                                                                                                                                                                                                What is the site identifier?
#> 3516                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3517                                                                                                                                                                                                 What is the category of the clinical event?
#> 3518                                                                                                                                                                                              What is the subcategory of the clinical event?
#> 3519                                                                                                                                                                                                       Were any clinical events experienced?
#> 3520                                                                                                                                                                                                                  [Sponsor defined question]
#> 3521                                                                                                                                                                                                            What is the clinical event term?
#> 3522                                                                                                                                                               Did the subject have [prespecified clinical event/group of clinical events ]?
#> 3523                                                                                                                                                                                                                                        <NA>
#> 3524                                                                                                                                                                                                   What was the [clinical event] start date?
#> 3525                                                                                                                                                                                                   What was the [clinical event] start time?
#> 3526                                                                                                                                                                                   What was the anatomical location of the [clinical event]?
#> 3527                                                                                                                                                                       What was the side of the anatomical location of the [clinical event]?
#> 3528                                                                                                                                                             What was the directionality of the anatomical location of the [clinical event]?
#> 3529                                                                                                                                                          What was the portion or totality of the anatomical location of the clinical event?
#> 3530                                                                                                                                                           Was the [clinical event] ongoing (as of [the study-specific timepoint or period]?
#> 3531                                                                                                                                                                                                     What was the [clinical event] end date?
#> 3532                                                                                                                                                                                                     What was the [clinical event] end time?
#> 3533                                                                                                                                                                                              What was the severity of the [clinical event]?
#> 3534                                                                                                                                                                                                   What was the description of the toxicity?
#> 3535                                                                                                                                                                                                                What was the toxicity grade?
#> 3536                                                                                                                                                                                                                                        <NA>
#> 3537                                                                                                                                                                                                                                        <NA>
#> 3538                                                                                                                                                                                                                                        <NA>
#> 3539                                                                                                                                                                                                                                        <NA>
#> 3540                                                                                                                                                                                                                                        <NA>
#> 3541                                                                                                                                                                                                                                        <NA>
#> 3542                                                                                                                                                                                                                                        <NA>
#> 3543                                                                                                                                                                                                                                        <NA>
#> 3544                                                                                                                                                                                                                                        <NA>
#> 3545                                                                                                                                                                                                                                        <NA>
#> 3546                                                                                                                                                                                                                                        <NA>
#> 3547                                                                                                                                                                                                               What is the study identifier?
#> 3548                                                                                                                                                                                                                What is the site identifier?
#> 3549                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3550                                                                                                                                                                                             What is the category of the protocol deviation?
#> 3551                                                                                                                                                                                          What is the subcategory of the protocol deviation?
#> 3552                                                                                                                                                                                                         Were there any protocol deviations?
#> 3553                                                                                                                                                                                What was the (standardized) protocol deviation (term/(code)?
#> 3554                                                                                                                                                                                                       What was the protocol deviation term?
#> 3555                                                                                                                                                                                                 What was the protocol deviation start date?
#> 3556                                                                                                                                                                                                 What was the protocol deviation start time?
#> 3557                                                                                                                                                                                                   What was the protocol deviation end date?
#> 3558                                                                                                                                                                                                   What was the protocol deviation end time?
#> 3559                                                                                                                                                                                                                  [Sponsor-defined question]
#> 3560                                                                                                                                                                                                               What is the study identifier?
#> 3561                                                                                                                                                                                                                What is the site identifier?
#> 3562                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3563                                                                                                                                                                                                       Were there any healthcare encounters?
#> 3564                                                                                                                                                                                          What was the category of the healthcare encounter?
#> 3565                                                                                                                                                                                       What was the subcategory of the healthcare encounter?
#> 3566                                                                                                                                                                              Did the subject have [prespecified healthcare encounter term]?
#> 3567                                                                                                                                                                                                                                        <NA>
#> 3568                                                                                                                                                                                            What was the reason the data were not collected?
#> 3569                                                                                                                                                                                                                  [Sponsor-defined question]
#> 3570                                                                                                                                                                                   What was the healthcare encounter?; If [HODECOD], specify
#> 3571                                                                                                                                                                               What was the (standardized) healthcare encounter (term/code)?
#> 3572                                                                                                                                                                          What was the [healthcare encounter/HOTERM] [start/admission] date?
#> 3573                                                                                                                                                                          What was the [healthcare encounter/HOTERM] [start/admission] time?
#> 3574                                                                                                                                                                            What was the [healthcare encounter/HOTERM] [end/discharge] date?
#> 3575                                                                                                                                                                            What was the [healthcare encounter/HOTERM] [end/discharge] time?
#> 3576                                                                                                                                                                                 What was the duration of the [healthcare encounter/HOTERM]?
#> 3577                                                                                                                                                                            What was the duration unit of the [healthcare encounter/HOTERM]?
#> 3578                                                                                                                                                 Was the [healthcare encounter/HOTERM] ongoing(as of the[study-specific timepoint or period?
#> 3579                                                                                                                                                                                  What was the reason for the [healthcare encounter/HOTERM]?
#> 3580                                                                                                                                     What was the identifier for the adverse event(s), which precipitated the [healthcare encounter/HOTERM]?
#> 3581                                                                                                                                                                                                               What is the study identifier?
#> 3582                                                                                                                                                                                                                What is the site identifier?
#> 3583                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3584                                                                                                                                      Were any medical conditions or events reported?; Has the subject had any medical conditions or events?
#> 3585                                                                                                                                                                                               What was the category of the medical history?
#> 3586                                                                                                                                                                                            What was the subcategory of the medical history?
#> 3587                                                                                                                                                                                        What was the date the medical history was collected?
#> 3588                                                                                                                                                                                                                  [Sponsor-defined question]
#> 3589                                                                                                                                                                                               What was the medical history event date type?
#> 3590                                                                                                                                                                                                What is the medical condition or event term?
#> 3591                                                                                                           Did the subject have [prespecified medical condition/event/group of medical conditions]; Is the [prespecified medical occurring]?
#> 3592                                                                                                                                                                                                                                        <NA>
#> 3593                                                                                                                Did the medical condition or event start prior to [MHSTTPT]?; Did the medical condition or event start prior to study start?
#> 3594                                                                                                                                                 Is the medical condition or event ongoing (as of the [study-specific timepoint or period])?
#> 3595                                                                                                                                                                                            Is the medical condition or event under control?
#> 3596                                                                                                                                                            What [is/was] the [medical event or condition/category of the event] start date?
#> 3597                                                                                                                                                                What[is/was] the[medical event or condition/category of the event] end date?
#> 3598                                                                                                                                                                         What was the anatomical location of the medical condition or event?
#> 3599                                                                                                                                                             What was the side of the anatomical location of the medical condition or event?
#> 3600                                                                                                                                                   What was the directionality of the anatomical location of the medical condition or event?
#> 3601                                                                                                                                       What was the portion or totality of the anatomical location of the of the medical condition or event?
#> 3602                                                                                                                                                                                                                                        <NA>
#> 3603                                                                                                                                                                                                                                        <NA>
#> 3604                                                                                                                                                                                                                                        <NA>
#> 3605                                                                                                                                                                                                                                        <NA>
#> 3606                                                                                                                                                                                                                                        <NA>
#> 3607                                                                                                                                                                                                                                        <NA>
#> 3608                                                                                                                                                                                                                                        <NA>
#> 3609                                                                                                                                                                                                                                        <NA>
#> 3610                                                                                                                                                                                                                                        <NA>
#> 3611                                                                                                                                                                                                                                        <NA>
#> 3612                                                                                                                                                                                                                                        <NA>
#> 3613                                                                                                                                                                                                               What is the study identifier?
#> 3614                                                                                                                                                                                                                What is the site identifier?
#> 3615                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3616                                                                                                                                                                                                                     What is the visit name?
#> 3617                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3618                                                                                                                                                                                                 What is the category of the cell phenotype?
#> 3619                                                                                                                                                                                             What is the subcategory of the cell phenotype ?
#> 3620                                                                                                                                                      Was the (cell phenotype) specimen collected?; Was the (cell phenotype) test performed?
#> 3621                                                                                                                                                             What was the (cell phenotype specimen) [reference identifier/accession number]?
#> 3622                                                                                                                                                                                          What was the planned time point of the collection?
#> 3623                                                                                                                                                                        What was the (start) date of the cell phenotype specimen collection?
#> 3624                                                                                                                                                                        What was the (start) time of the cell phenotype specimen collection?
#> 3625                                                                                                                                                                                                               What is the study identifier?
#> 3626                                                                                                                                                                                                                What is the site identifier?
#> 3627                                                                                                                                                                                                             What is the subject identifier?
#> 3628                                                                                                                                                                                                                     What is the visit name?
#> 3629                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3630                                                                                                                                                                                                    Was cardiovascular assessment performed?
#> 3631                                                                                                                                                                                  What was the date cardiovascular assessment was performed?
#> 3632                                                                                                                                                                               What was the time of the Cardiovascular assessment performed?
#> 3633                                                                                                                                                                What is the planned time point for this Cardiovascular assessment performed?
#> 3634                                                                                                                                                                                                       What is the cardiovascular test name?
#> 3635                                                                                                                                                                                            What is the category of the Cardiovascular test?
#> 3636                                                                                                                                                                                        What was the subcategory of the cardiovascular test?
#> 3637                                                                                                                                                                                                     What was the result of the measurement?
#> 3638                                                                                                                                                                                                            What was the unit of the result?
#> 3639                                                                                                                                                              Was the result (normal/abnormal/absent/present/ [sponsored defined response])?
#> 3640                                                                                                                                                           What was the description of the (abnormality/observed finding/[Sponsor-defined])?
#> 3641                                                                                                                                                              Indicate if the [CVTEST] was not [answered/assessed/done/evaluated/performed].
#> 3642                                                                                                          Was the was the reason that the cardiovascular (assessment/[CVTEST]) was not [collected / answered / done / assessed / evaluated]?
#> 3643                                                                                                                                                                                 What was the position of the subject during the assessment?
#> 3644                                                                                                                                                  What was the anatomical location where the assessment was performed/measurement was taken?
#> 3645                                                                                                                                                        What was the side of the anatomical location of the [measurement/test/examination])?
#> 3646                                                                                                                                                          What was the directionality of the anatomical location of the cardiovascular test?
#> 3647                                                                                                                                                                          What was the method (used for the [measurement/test/examination])?
#> 3648                                                                                                                                                                                                                      Who was the evaluator?
#> 3649                                                                                                                                                                                                    What is the identifier of the evaluator?
#> 3650                                                                                                                                                                                                               What is the study identifier?
#> 3651                                                                                                                                                                                                                What is the site identifier?
#> 3652                                                                                                                                                                                                             What is the subject identifier?
#> 3653                                                                                                                                                                                                                     What is the visit name?
#> 3654                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3655                                                                                                                                                                                                          Was drug accountability performed?
#> 3656                                                                                                                                                                   What was the type of study product for which accountability was assessed?
#> 3657                                                                                                                                                               What was the name of the study product for which accountability was assessed?
#> 3658                                                                                                                                                                              What was the date the accountability assessment was performed?
#> 3659                                                                                                                                                                                                What was the study product label identifier?
#> 3660                                                                                                                                                                                   What was the study product accountability being assessed?
#> 3661                                                                                                                                                                                        What is the result of the accountability assessment?
#> 3662                                                                                                                                                                                                                          What was the unit?
#> 3663                                                                                                                                                                                                               What is the study identifier?
#> 3664                                                                                                                                                                                                                What is the site identifier?
#> 3665                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3666                                                                                                                                                                                                                     What is the visit name?
#> 3667                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3668                                                                                                                                                                                                Were any death detail assessments collected?
#> 3669                                                                                                                                                                                  What was the date death detail assessments were collected?
#> 3670                                                                                                                                                                                                                  [Sponsor-defined question]
#> 3671                                                                                                                                                                                                       What was the subject's date of death?
#> 3672                                                                                                                                                                                             What was the death detail assessment test name?
#> 3673                                                                                                                                                                                         What was the result of the death detail assessment?
#> 3674                                                                                                                                                                                           What is the category of the death detail results?
#> 3675                                                                                                                                                                                       Who provided the death detail assessment information?
#> 3676                                                                                                                                                                                                               What is the study identifier?
#> 3677                                                                                                                                                                                                                What is the site identifier?
#> 3678                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3679                                                                                                                                                                                                                     What is the visit name?
#> 3680                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3681                                                                                                                                                                                                          Were all eligibility criteria met?
#> 3682                                                                                                                                                                        What was the date the eligibility criteria assessment was performed?
#> 3683                                                                                                                                                                                                     What was the category of the criterion?
#> 3684                                                                                                                                                                                                  What was the subcategory of the criterion?
#> 3685                                                                                                                     What was the identifier of the inclusion criterion the subject did not meet or the exclusion criterion the subject met?
#> 3686                                                                                                                    What was the description of the inclusion criterion the subject did not meet or the exclusion criterion the subject met?
#> 3687                                                                                                                                                                                                                         What is the result?
#> 3688                                                                                                                                                                                                               What is the study identifier?
#> 3689                                                                                                                                                                                                                What is the site identifier?
#> 3690                                                                                                                                                                                                             What is the subject identifier?
#> 3691                                                                                                                                                                                                                     What is the visit name?
#> 3692                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3693                                                                                                                                                                  Was a musculoskeletal system findings [measurement/examination] collected?
#> 3694                                                                                                                                                             What was the date the musculoskeletal system findings assessment was collected?
#> 3695                                                                                                                                              What was the time the musculoskeletal system findings [measurement/examination] was collected?
#> 3696                                                                                                                               What is the planned time point for this musculoskeletal system findings [measurement/examination] collection?
#> 3697                                                                                                                                                                                      What is the musculoskeletal system findings test name?
#> 3698                                                                                                                                                      What is the category of the musculoskeletal system findings [measurement/examination]?
#> 3699                                                                                                                                                  What was the subcategory of the musculoskeletal system findings [measurement/examination]?
#> 3700                                                                                                                                                                                                            What was the result of the test?
#> 3701                                                                                                                                                                                                            What was the unit of the result?
#> 3702                                                                                                                                                              Was the result (normal/abnormal/absent/present/ [sponsored defined response])?
#> 3703                                                                                                                                                           What was the description of the (abnormality/observed finding/[Sponsor-defined])?
#> 3704                                                                                                                                                                                If other is selected, [explain/specify/provide more detail].
#> 3705                                                                                                                                                            How do the reported values compare within the [reference/normal/expected] range?
#> 3706                                                                                                                                                                                 Indicate if the [MKTEST] was not [answered/done/performed].
#> 3707                                                                                                            Was the was the reason that the musculoskeletal system (measurement/examination/[MKTEST]) was not [collected / answered / done]?
#> 3708                                                                                                                                                                 What was the position of the subject during the [measurement/ examination]?
#> 3709                                                                                                                                                 What was the anatomical location where the [measurement/ examination] was [collected/done]?
#> 3710                                                                                                                                                             What was the side of the anatomical location of the [measurement/ examination]?
#> 3711                                                                                                                                                   What was the directionality of the anatomical location of the [measurement/ examination]?
#> 3712                                                                                                                                                                              What was the method (used for the [measurement/ examination])?
#> 3713                                                                                                                                                                                                                      Who was the evaluator?
#> 3714                                                                                                                                                                                                    What is the identifier of the evaluator?
#> 3715                                                                                                                                                                                   Was this record considered to be the accepted evaluation?
#> 3716                                                                                                                                                   What was the repetition number within the time point for this [measurement/ examination]?
#> 3717                                                                                                                                                                                                               What is the study identifier?
#> 3718                                                                                                                                                                                                                What is the site identifier?
#> 3719                                                                                                                                                                                                             What is the subject identifier?
#> 3720                                                                                                                                                                                                                     What is the visit name?
#> 3721                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3722                                                                                                                                                                                                       Was a neurology assessment performed?
#> 3723                                                                                                                                                                                      What was the date the neurology measurement was taken?
#> 3724                                                                                                                                                                                             What was the time of the neurology measurement?
#> 3725                                                                                                                                                                   What is the planned time point for this neurology assessment measurement?
#> 3726                                                                                                                                                                                                            What is the neurology test name?
#> 3727                                                                                                                                                                                          What was the category of the neurology assessment?
#> 3728                                                                                                                                                                                       What was the subcategory of the neurology assessment?
#> 3729                                                                                                                                                                                                     What was the result of the measurement?
#> 3730                                                                                                                                                                                                            What was the unit of the result?
#> 3731                                                                                                                                                              Was the result (normal/abnormal/absent/present/ [sponsored defined response])?
#> 3732                                                                                                                                                           What was the description of the (abnormality/observed finding/[Sponsor-defined])?
#> 3733                                                                                                                                                                                If other is selected, [explain/specify/provide more detail].
#> 3734                                                                                                                                                                                            What was the lower limit of the reference range?
#> 3735                                                                                                                                                                                            What was the upper limit of the reference range?
#> 3736                                                                                                                                                            How do the reported values compare within the [reference/normal/expected] range?
#> 3737                                                                                                                                                              Indicate if the [NVTEST] was not [answered/assessed/done/evaluated/performed].
#> 3738                                                                                                               Was the was the reason that the neurology (assessment/[NVTEST]) was not [collected / answered / done / assessed / evaluated]?
#> 3739                                                                                                                                                                                 What was the position of the subject during the assessment?
#> 3740                                                                                                                                                                           What was the anatomical location where the measurement was taken?
#> 3741                                                                                                                                                        What was the side of the anatomical location of the [measurement/test/examination])?
#> 3742                                                                                                                                                               What was the directionality of the anatomical location of the neurology test?
#> 3743                                                                                                                                                                          What was the method (used for the [measurement/test/examination])?
#> 3744                                                                                                                                                                                                                      Who was the evaluator?
#> 3745                                                                                                                                                                                                    What is the identifier of the evaluator?
#> 3746                                                                                                                                                                  What was the repetition number within the time point for this measurement?
#> 3747                                                                                                                                                                                                     Was this result clinically significant?
#> 3748                                                                                                                                                                                                               What is the study identifier?
#> 3749                                                                                                                                                                                                                What is the site identifier?
#> 3750                                                                                                                                                                                                             What is the subject identifier?
#> 3751                                                                                                                                                                                                                     What is the visit name?
#> 3752                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3753                                                                                                                                                                                                                             Which eye/eyes?
#> 3754                                                                                                                                                                                                    Was an ophthalmic examination performed?
#> 3755                                                                                                                                                                                What was the date of the ophthalmic examination measurement?
#> 3756                                                                                                                                                                                   What was the time the ophthalmic examination measurement?
#> 3757                                                                                                                                                                         What was the name of the ophthalmic [measurement/test/examination]?
#> 3758                                                                                                                                                                                    What was the [measurement/test/examination] detail name?
#> 3759                                                                                                                                                                                 What was the [type/category] of the ophthalmic examination?
#> 3760                                                                                                                                                                           What was the [subtype/subcategory] of the ophthalmic examination?
#> 3761                                                                                                                                                                                     What was the result of the ophthalmic examination test?
#> 3762                                                                                                                                                                                  What was the unit (of the [measurement/test/examination])?
#> 3763                                                                               What [is/was] the [result/amount] (of the [measurement/test/examination])?; [Is/Was] the result [normal/abnormal/absent/present/ sponsored defined response]?
#> 3764                                                                                                                                                                                If other is selected, [explain/specify/provide more detail].
#> 3765                                                                                                                                                    What was the lower limit of the reference range (for the [measurement/test/examination]?
#> 3766                                                                                                                                                   What was the upper limit of the reference range (for the [measurement/test/examination])?
#> 3767                                                                                                                                                              What was the normal reference range (for this [measurement/test/examination])?
#> 3768                                                                                                                                                            How do the reported values compare within the [reference/normal/expected] range?
#> 3769                                                                                                                                                                                           What is the the category for the reported values?
#> 3770                                                                                                                         What was the reason that the [ophthalmic examination finding] was not [collected/answered/done/assessed/evaluated]?
#> 3771                                                                                                                                                                             What was the anatomical location of the ophthalmic examination?
#> 3772                                                                                                                                                        What was the side of the anatomical location of the [measurement/test/examination])?
#> 3773                                                                                                                                             What was the directionality (of the anatomical location of the [measurement/test/examination])?
#> 3774                                                                                                                                        What was the portion or totality (of the anatomical location of the [measurement/test/examination])?
#> 3775                                                                                                                                                                          What was the method (used for the [measurement/test/examination])?
#> 3776                                                                                                                                                                                                                      Who was the evaluator?
#> 3777                                                                                                                                                                                                    What is the identifier of the evaluator?
#> 3778                                                                                                                                                                            Is this record considered to be the [accepted/final] evaluation?
#> 3779                                                                                                                                                                  What was the repetition number within the time point for this measurement?
#> 3780                                                                                                                                                                                                               What is the study identifier?
#> 3781                                                                                                                                                                                                                What is the site identifier?
#> 3782                                                                                                                                                                                                             What is the subject identifier?
#> 3783                                                                                                                                                                                                                     What is the visit name?
#> 3784                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3785                                                                                                                                                                                                     Was a respiratory assessment performed?
#> 3786                                                                                                                                                                                    What was the date the respiratory measurement was taken?
#> 3787                                                                                                                                                                                    What was the time of the respiratory system measurement?
#> 3788                                                                                                                                                                 What is the planned time point for this respiratory assessment measurement?
#> 3789                                                                                                                                                                                                          What is the respiratory test name?
#> 3790                                                                                                                                                                                               What is the category of the respiratory test?
#> 3791                                                                                                                                                                                     What was the subcategory of the respiratory assessment?
#> 3792                                                                                                                                                                                                     What was the result of the measurement?
#> 3793                                                                                                                                                                                                            What was the unit of the result?
#> 3794                                                                                                                                                              Was the result (normal/abnormal/absent/present/ [sponsored defined response])?
#> 3795                                                                                                                                                           What was the description of the (abnormality/observed finding/[Sponsor-defined])?
#> 3796                                                                                                                                                                                If other is selected, [explain/specify/provide more detail].
#> 3797                                                                                                                                                                                            What was the lower limit of the reference range?
#> 3798                                                                                                                                                                                            What was the upper limit of the reference range?
#> 3799                                                                                                                                                            How do the reported values compare within the [reference/normal/expected] range?
#> 3800                                                                                                                                                              Indicate if the [RETEST] was not [answered/assessed/done/evaluated/performed].
#> 3801                                                                                                             Was the was the reason that the respiratory (assessment/[RETEST]) was not [collected / answered / done / assessed / evaluated]?
#> 3802                                                                                                                                                                                 What was the position of the subject during the assessment?
#> 3803                                                                                                                                                                           What was the anatomical location where the measurement was taken?
#> 3804                                                                                                                                                        What was the side of the anatomical location of the [measurement/test/examination])?
#> 3805                                                                                                                                                             What was the directionality of the anatomical location of the respiratory test?
#> 3806                                                                                                                                                                          What was the method (used for the [measurement/test/examination])?
#> 3807                                                                                                                                                                                                                      Who was the evaluator?
#> 3808                                                                                                                                                                                                    What is the identifier of the evaluator?
#> 3809                                                                                                                                                                                   Was this record considered to be the accepted evaluation?
#> 3810                                                                                                                                                                  What was the repetition number within the time point for this measurement?
#> 3811                                                                                                                                                                                                     Was this result clinically significant?
#> 3812                                                                                                                                                                                                               What is the study identifier?
#> 3813                                                                                                                                                                                                                What is the site identifier?
#> 3814                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3815                                                                                                                                                                                                                     What is the visit name?
#> 3816                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3817                                                                                                                                                                                           What was the category of the reproductive system?
#> 3818                                                                                                                                                                                        What was the subcategory of the reproductive system?
#> 3819                                                                                                                                                                                             Was a reproductive system evaluation performed?
#> 3820                                                                                                                                                                         What was the reason the reproductive system test was not collected?
#> 3821                                                                                                                                                                                                Were there any reproductive system findings?
#> 3822                                                                                                                                                                                                                  [Sponsor-defined question]
#> 3823                                                                                                                                                                                                      What is the reproductive finding name?
#> 3824                                                                                                                                                                                   What was the result for the reproductive system question?
#> 3825                                                                                                                                                                                                            What was the unit of the result?
#> 3826                                                                                                                                                                           What was the date the reproductive system question was collected?
#> 3827                                                                                                                                                                                                               What is the study identifier?
#> 3828                                                                                                                                                                                                                What is the site identifier?
#> 3829                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3830                                                                                                                                                                                                                     What is the visit name?
#> 3831                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3832                                                                                             What is the [category/ criteria] for the [disease response/clinical classification] or What is the [response/clinical classification] criteria?
#> 3833                                                                                                                                                                 What is the subcategory for the [disease response/clinical classification]?
#> 3834                                                                                                                                                                  Was the [(disease) response/clinical classification] assessment performed?
#> 3835                                                                                                                                                            Why was the [disease response/clinical classification] assessment not performed?
#> 3836                                                                                                                                                                    What was the date the response or clinical classification was performed?
#> 3837                                                                                                                                       What was the role of the person performing the [disease response/clinical classification] assessment?
#> 3838                                                                                                                                                                                                           What is the evaluator identifier?
#> 3839                                                                                                                                                              What was the [Disease Response or Clinical Classification ]Link ID Identifier?
#> 3840                                                                                                                                                           What was the [Disease Response or Clinical Classification] Link Group Identifier?
#> 3841                                                                                                                                                                          What was the [disease response/clinical classification] test name?
#> 3842                                                                                                                                                                                    What was the [disease response/clinical classification]?
#> 3843                                                                                                                                                                               What was the [disease response/clinical classification] unit?
#> 3844                                                                                                                                                                                                               What is the study identifier?
#> 3845                                                                                                                                                                                                                What is the site identifier?
#> 3846                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3847                                                                                                                                                                                                                     What is the visit name?
#> 3848                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3849                                                                                                                                                                                       What was the category of the subject characteristics?
#> 3850                                                                                                                                                                                    What was the subcategory of the subject characteristics?
#> 3851                                                                                                                                                                                                     Were subject characteristics collected?
#> 3852                                                                                                                                                                                                                  [Sponsor-defined question]
#> 3853                                                                                                                                                                               What was the date the subject characteristics were collected?
#> 3854                                                                                                                                                                                                   What is the subject characteristics name?
#> 3855                                                                                                                                                                                                         What is the subject characteristic?
#> 3856                                                                                                                                                                                                               What is the study identifier?
#> 3857                                                                                                                                                                                                                What is the site identifier?
#> 3858                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3859                                                                                                                                                                                                                     What is the visit name?
#> 3860                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3861                                                                                                                                                                                        What was the [tumor/lesion] [link group] identifier?
#> 3862                                                                                                                                                                                         What is the category of the [tumor/lesion] results?
#> 3863                                                                                                                                                                                      What is the subcategory of the [tumor/lesion] results?
#> 3864                                                                                                                                                                                     Indicate if the [tumor/lesion] evaluation was not done.
#> 3865                                                                                                                                                                   What was the reason that the [tumor/lesion] was not [evaluated/assessed]?
#> 3866                                                                                                                                                                                       Who provided the information?; Who was the evaluator?
#> 3867                                                                                                                                                                                                   What was the identifier of the evaluator?
#> 3868                                                                                                                                                                      What was the date of the procedure used for [tumor/lesion] assessment?
#> 3869                                                                                                                                                                                                     What was the [tumor/lesion] Identifier?
#> 3870                                                                                                                                                                                        What was the [tumor/ lesion] (assessment) test name?
#> 3871                                                                                                                                                                                       What is the result for the [tumor/lesion assessment]?
#> 3872                                                                                                                                                                                              What was the unit of the [result/measurement]?
#> 3873                                                                                                                                                                                                       What was the name of the vendor used?
#> 3874                                                                                                                                                                                                               What is the study identifier?
#> 3875                                                                                                                                                                                                                What is the site identifier?
#> 3876                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3877                                                                                                                                                                                                                     What is the visit name?
#> 3878                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3879                                                                                                                                                                                  What is the category of the [tumor/lesion] identification?
#> 3880                                                                                                                                                                              What is the subcategory for the [tumor/lesion] identification?
#> 3881                                                                                                                                                               Were any [target/non-target/new/sponsor-defined) [tumors/lesions] identified?
#> 3882                                                                                                                                                    What was the date of the [examination/procedure] used for [tumor/lesion identification]?
#> 3883                                                                                                                                                                                       Who provided the information?; Who was the evaluator?
#> 3884                                                                                                                                                                                                   What was the identifier of the evaluator?
#> 3885                                                                                                                                                                                              What was the [tumor/lesion] (link) identifier?
#> 3886                                                                                                                                                            What was the identifier for the procedure used to identify this [tumor/lesion] ?
#> 3887                                                                                                                                                                         What was the method used to [evaluate/identify] the [tumor/lesion]?
#> 3888                                                                                                                                                                             What was the procedure [reference identifier/accession number]?
#> 3889                                                                                                                                                                                       What was the [tumor/lesion] Identification test name?
#> 3890                                                                                                                                              What is the [type/classification] of [tumor/lesion] as defined by the criteria being employed?
#> 3891                                                                                                                                                                        What was the anatomical location of the [tumor/lesion] (identified)?
#> 3892                                                                                                                                                                                         What was the laterality of the anatomical location?
#> 3893                                                                                                                                                                                     What was the directionality of the anatomical location?
#> 3894                                                                   What [were/are] additional details on the exact location of the [tumor/lesion] so that it can be distinguished from other [tumor/lesion] in the same anatomical location?
#> 3895                                                                                                                                                                                                       What was the name of the vendor used?
#> 3896                                                                                                                                                                                                               What is the study identifier?
#> 3897                                                                                                                                                                                                                What is the site identifier?
#> 3898                                                                                                                                                                                                             What is the subject identifier?
#> 3899                                                                                                                                                                                                                     What is the visit name?
#> 3900                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3901                                                                                                                                                                                                         Was a urinary assessment performed?
#> 3902                                                                                                                                                                                        What was the date the urinary measurement was taken?
#> 3903                                                                                                                                                                                        What was the time of the urinary system measurement?
#> 3904                                                                                                                                                                     What is the planned time point for this urinary assessment measurement?
#> 3905                                                                                                                                                                                                              What is the urinary test name?
#> 3906                                                                                                                                                                                                   What is the category of the urinary test?
#> 3907                                                                                                                                                                                         What was the subcategory of the urinary assessment?
#> 3908                                                                                                                                                                                                     What was the result of the measurement?
#> 3909                                                                                                                                                                                                            What was the unit of the result?
#> 3910                                                                                                                                                              Was the result (normal/abnormal/absent/present/ [sponsored defined response])?
#> 3911                                                                                                                                                           What was the description of the (abnormality/observed finding/[Sponsor-defined])?
#> 3912                                                                                                                                                                                If other is selected, [explain/specify/provide more detail].
#> 3913                                                                                                                                                              Indicate if the [URTEST] was not [answered/assessed/done/evaluated/performed].
#> 3914                                                                                                                 Was the was the reason that the urinary (assessment/[URTEST]) was not [collected / answered / done / assessed / evaluated]?
#> 3915                                                                                                                                                                           What was the anatomical location where the measurement was taken?
#> 3916                                                                                                                                                        What was the side of the anatomical location of the [measurement/test/examination])?
#> 3917                                                                                                                                                                 What was the directionality of the anatomical location of the urinary test?
#> 3918                                                                                                                                                                          What was the method (used for the [measurement/test/examination])?
#> 3919                                                                                                                                                                                                                      Who was the evaluator?
#> 3920                                                                                                                                                                                                    What is the identifier of the evaluator?
#> 3921                                                                                                                                                                                   Was this record considered to be the accepted evaluation?
#> 3922                                                                                                                                                                  What was the repetition number within the time point for this measurement?
#> 3923                                                                                                                                                                                                     Was this result clinically significant?
#> 3924                                                                                                                                                                                                               What is the study identifier?
#> 3925                                                                                                                                                                                                                What is the site identifier?
#> 3926                                                                                                                                                                                                             What is the subject identifier?
#> 3927                                                                                                                                                                                                                     What is the visit name?
#> 3928                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3929                                                                                                                                                                                                                 Were vital signs performed?
#> 3930                                                                                                                                                                                           What was the date of the vital signs measurement?
#> 3931                                                                                                                                                                                           What was the time of the vital signs measurement?
#> 3932                                                                                                                                                                                                                  [Sponsor-defined question]
#> 3933                                                                                                                                                                            What is the planned time point for this vital signs measurement?
#> 3934                                                                                                                                                                                                   What was the category of the vital signs?
#> 3935                                                                                                                                                                                                What was the subcategory of the vital signs?
#> 3936                                                                                                                                                                  What was the repetition number within the time point for this measurement?
#> 3937                                                                                                                                                                                                           What is the vital sign test name?
#> 3938                                                                                                                                                                                        Indicate if the vital signs measurement was not done
#> 3939                                                                                                                                                                                                     What was the result of the measurement?
#> 3940                                                                                                                                                                                                       What was the unit of the measurement?
#> 3941                                                                                                                                                                                                      Was the result clinically significant?
#> 3942                                                                                                                                                                           What was the anatomical location where the measurement was taken?
#> 3943                                                                                                                                                                                What was the position of the subject during the measurement?
#> 3944                                                                                                                                                                  What was the directionality of the anatomical location of the measurement?
#> 3945                                                                                                                                                                What was the side of the anatomical location of the vital signs measurement?
#> 3946                                                                                                                                                                                                               What is the study identifier?
#> 3947                                                                                                                                                                                                                What is the site identifier?
#> 3948                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3949                                                                                                                                                                                                                     What is the visit name?
#> 3950                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3951                                                                                                                                                                                                                  [Sponsored-defined phrase]
#> 3952              Has the subject had any [Findings topic(s)] (after/before [study specific time frame])?; [Was/Were] (there) any [Findings topic(s)] (reported) (after/before [study specific time frame])?; Were all eligibility criteria met?
#> 3953                                                                                                                    [Were any/Was the] [FATEST/topic] ([measurement(s)/test(s)/examination(s)/specimen(s)/sample(s))] [performed/collected]?
#> 3954                                                                                                                                                                              What was the date the findings about assessment was performed?
#> 3955                                                                                                                                                                                         What was the time of the findings about assessment?
#> 3956                                                                                                                                                                             What [is/was] the name (of the [measurement/test/examination])?
#> 3957                                                                                                                                                                               What [is/was] the [measurement/test/examination] detail name?
#> 3958                                                                                                                                             What [is/was] the [type/category/name] (of the [measurement/test/examination/specimen/sample])?
#> 3959                                                                                                                                          What [is/was] the [type/subcategory/name] (of the [measurement/test/examination/specimen/sample])?
#> 3960 In what position was the subject during the [measurement/ test/examination/specimen collection/sample collection]?; What was the position of the subject (during the [measurement/test/examination/specimen collection/sample collection])?
#> 3961                                                                                                                   What [is/was] the [result/amount/(subject's) characteristic] (of the [measurement/test/examination/question/assessment])?
#> 3962                                                                                                                                                                             What [is/was] the unit (of the [measurement/test/examination])?
#> 3963                                                                                                                                              What [is/was] the lower limit of the reference range (for the [measurement/test/examination])?
#> 3964                                                                                                                                              What [is/was] the upper limit of the reference range (for the [measurement/test/examination])?
#> 3965                                                                                                                                                      How [did/do] the reported values compare within the [reference/normal/expected] range?
#> 3966                                                                                       Was the [--TEST ] not [completed/answered/done/assessed/evaluated ]?; Indicate if the([--TEST] was) not [answered/assessed/done/evaluated/performed].
#> 3967                                                                                         Was the [is/was] the reason that the [Findings topic/data/information/sponsor-defined phrase] was not [collected/answered/done/assessed/evaluated]?
#> 3968                                                                                                                                                                                                            What [is/was] the specimen type?
#> 3969                                                                                                                                                                                                What [is/was] the condition of the specimen?
#> 3970                                                               What [is/was] the anatomical location (of the [measurement/test/examination]) or What [is/was] the anatomical location where the [measurement/specimen] was taken/collected)?
#> 3971                                                                                                                                                  What [is/was] the side (of the anatomical location of the [measurement/test/examination])?
#> 3972                                                                                                                                        What [is/was] the directionality (of the anatomical location of the [measurement/test/examination])?
#> 3973                                                                                                                                   What [is/was] the portion or totality (of the anatomical location of the [measurement/test/examination])?
#> 3974                                                                                                                                                                          What was the method (used for the [measurement/test/examination])?
#> 3975                                                                                                                                                                    What [is/was] the lead (used to measure [measurement/test/examination])?
#> 3976                                                                                                                                                  [Is/Was] the subject fasting (prior to the [test being performed/sample being collected])?
#> 3977                                                                                                                                                              Who provided the (sponsor-defined phrase) information?; Who was the evaluator?
#> 3978                                                                                                                      What [is/was] the identifier of the [evaluator name/reporter name] (providing the-sponsor-defined phrase-information)?
#> 3979                                                                                                                                                                [Is/Was] the ([measurement/test/examination]) result clinically significant?
#> 3980                                                                                                                                                                                                               What is the study identifier?
#> 3981                                                                                                                                                                                                                What is the site identifier?
#> 3982                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 3983                                                                                                                                                                                                                     What is the visit name?
#> 3984                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 3985                                                                                                                                                                                                         Was a skin response test performed?
#> 3986                                                                                                                                                                                                  What was the reason the test was not done?
#> 3987                                                                                                                                                                                                 What was the category of the skin response?
#> 3988                                                                                                                                                                                              What was the subcategory of the skin response?
#> 3989                                                                                                                                                                                                                  [Sponsor-defined question]
#> 3990                                                                                                                                                                                What intervention was performed to elicit the skin response?
#> 3991                                                                                                                                                              What was the date of the [intervention] performed to elicit the skin response?
#> 3992                                                                                                                                                              What was the time of the [intervention] performed to elicit the skin response?
#> 3993                                                                                                                                                                          What was the anatomical location of the skin response measurement?
#> 3994                                                                                                                                                              What was the side of the anatomical location of the skin response measurement?
#> 3995                                                                                                                                                                                                       What was the skin response test name?
#> 3996                                                                                                                                                                              What was the planned time point for skin response measurement?
#> 3997                                                                                                                                                                                         What was the date of the skin response measurement?
#> 3998                                                                                                                                                                                         What was the time of the skin response measurement?
#> 3999                                                                                                                                                    What was the directionality of the anatomical location of the skin response measurement?
#> 4000                                                                                                                                                                                                                      Who was the evaluator?
#> 4001                                                                                                                                                           What was the identifier of the evaluator providing the skin response information?
#> 4002                                                                                                                                                                                       What was the result of the skin response measurement?
#> 4003                                                                                                                                                                                         What was the unit of the skin response measurement?
#> 4004                                                                                                                                                      How [did/do] the reported values compare within the [reference/normal/expected] range?
#> 4005                                                                                                                                                                                                      Was the result clinically significant?
#> 4006                                                                                                                                                                                                               What is the study identifier?
#> 4007                                                                                                                                                                                                                What is the site identifier?
#> 4008                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4009                                                                                                                                                                                                      [Protocol-specified targeted question]
#> 4010                                                                                                                                                                                                               What is the study identifier?
#> 4011                                                                                                                                                                                                                What is the site identifier?
#> 4012                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4013                                                                                                                                                                                                   What was the category of the disposition?
#> 4014                                                                                                                                                                                                What was the subcategory of the disposition?
#> 4015                                                                                                                                                                                        What is the trial period for this disposition event?
#> 4016                                                                                                                                                                                                                           [Sponsor-defined]
#> 4017                                                                                                                                                                                                                           [Sponsor-defined]
#> 4018                                                                                                                                                                            What was the [protocol milestone/other event name] (start) date?
#> 4019                                                                                                                                                                            What was the [protocol milestone/other event name] (start) time?
#> 4020                                                                                                                                                                                                Was (study) treatment unblinded by the site?
#> 4021                                                                                                                                                                                                               What is the study identifier?
#> 4022                                                                                                                                                                                                                What is the site identifier?
#> 4023                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4024                                                                                                                                                                                                   What was the category of the disposition?
#> 4025                                                                                                                                                                                                What was the subcategory of the disposition?
#> 4026                                                                                                                                                                                        What is the trial period for this disposition event?
#> 4027                                                                                                                                                                     What was the subject's status (at the EPOCH/study specific time frame)?
#> 4028                                                                                                                                                                                       What was the subject's status?; If [DSDECOD], specify
#> 4029                                                                                                                                                                                                        What was the disposition event date?
#> 4030                                                                                                                                                                                                        What was the disposition event time?
#> 4031                                                                                                                                                                                                  What [is/was] the subject's date of death?
#> 4032                                                                                                                                                                                                                  Will the subject continue?
#> 4033                                                                                                                                                    What is the next [epoch/period/study/trial] the subject will [continue to/enter/enroll]?
#> 4034                                                                                                                                                                               What is the start time of the serious adverse event/reaction?
#> 4035                                                                                                                                                                                 What is the end time of the serious adverse event/reaction?
#> 4036                                                                                                                                                                                                         What was the result of dechallenge?
#> 4037                                                                                                                                                                                                         What was the result of rechallenge?
#> 4038                                                                                                                                                                                                 What are the additional details of the SAE?
#> 4039                                                                                                                                                             Could the event have been related to/caused by the drug or study participation?
#> 4040                                                                                                                                                                                Which event is being assessed for relatedness with the drug?
#> 4041                                                                                                                                                                                                                   Who made this assessment?
#> 4042                                                                                                                                                                                                               How was this assessment done?
#> 4043                                                                                                                                                                                                What is the middle name of the Investigator?
#> 4044                                                                                                                                                                                                                  What is the site postcode?
#> 4045                                                                                                                                                                                                         What is the site state or province?
#> 4046                                                                                                                                                                                                                      What is the site city?
#> 4047                                                                                                                                                                                                            What is the site street address?
#> 4048                                                                                                                                                                                                          What is the site telephone number?
#> 4049                                                                                                                                                                                                                What is the site fax number?
#> 4050                                                                                                                                                                                   What is the date the report was submitted to the sponsor?
#> 4051                                                                                                                                                                                                      What is the title of the investigator?
#> 4052                                                                                                                                                                                              What is the email address of the investigator?
#> 4053                                                                                                                                                                                                             What is the SAE report category
#> 4054                                                                                                                                             What is the gestational period of the fetus at the time the serious adverse event was observed?
#> 4055                                                                                                                                               What is the fetal gestational period unit at the time the serious adverse event was observed?
#> 4056                                                                                                                                                                                                               What is the study identifier?
#> 4057                                                                                                                                                                                                                What is the site identifier?
#> 4058                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4059                                                                                                                                                                                                                     What is the visit name?
#> 4060                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4061                                                                                                                                                                                                          What is the test group identifier?
#> 4062                                                                                                                                                                                                                     Was [DATEST] collected?
#> 4063                                                                                                                                                  What was the type of [treatment/study product/drug] for which accountability was assessed?
#> 4064                                                                                                                                              What was the name of the [treatment/study product/drug] for which accountability was assessed?
#> 4065                                                                                                                                                                                                      What is the [DATEST] label identifier?
#> 4066                                                                                                                                                                       What was the date [DATEST] study product accountability was assessed?
#> 4067                                                                                                                                                                               What is the amount of the [DATEST] accountability assessment?
#> 4068                                                                                                                                                                                                   What was the unit of the [DATEST] result?
#> 4069                                                                                                                                                                                                               What is the study identifier?
#> 4070                                                                                                                                                                                                                What is the site identifier?
#> 4071                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4072                                                                                                                                                                                                                     What is the visit name?
#> 4073                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4074                                                                                                                                                                                                Were any death detail assessments collected?
#> 4075                                                                                                                                                                                        What is the category of the death detail assessment?
#> 4076                                                                                                                                                                                     What is the subcategory of the death detail assessment?
#> 4077                                                                                                                                                                                         What was the date [DTHDX] assessment was collected?
#> 4078                                                                                                                                                                                                       What was the subject's date of death?
#> 4079                                                                                                                                                                                                What was the death detail assessment result?
#> 4080                                                                                                                                                                                       Who provided the death detail assessment information?
#> 4081                                                                                                                                                                                                               What is the study identifier?
#> 4082                                                                                                                                                                                                                What is the site identifier?
#> 4083                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4084                                                                                                                                                                                                                     What is the visit name?
#> 4085                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4086                                                                                                                                                                                                   What was the category of the ECG finding?
#> 4087                                                                                                                                                                                                What was the subcategory of the ECG finding?
#> 4088                                                                                                                                                                                                                      Was the ECG performed?
#> 4089                                                                                                                                                                                                        Which repetition of the ECG is this?
#> 4090                                                                                                                                                                                 What was the (ECG) [reference identifier/accession number]?
#> 4091                                                                                                                                                                                                       What was the method used for the ECG?
#> 4092                                                                                                                                                                                          Which lead location was used for this measurement?
#> 4093                                                                                                                                                                            What was the position of the subject during the ECG measurement?
#> 4094                                                                                                                                                                                                               What was the date of the ECG?
#> 4095                                                                                                                                                                                     What was the planned time point of the ECG measurement?
#> 4096                                                                                                                                                                                                    What was the time the ECG was collected?
#> 4097                                                                                                                                                                                                               What is the study identifier?
#> 4098                                                                                                                                                                                                                What is the site identifier?
#> 4099                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4100                                                                                                                                                                                                                     What is the visit name?
#> 4101                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4102                                                                                                                                                                                                   What was the category of the ECG finding?
#> 4103                                                                                                                                                                                                What was the subcategory of the ECG finding?
#> 4104                                                                                                                                                                                                                      Was the ECG performed?
#> 4105                                                                                                                                                                                                         What repetition of the ECG is this?
#> 4106                                                                                                                                                                                                       What was the method used for the ECG?
#> 4107                                                                                                                                                                                          Which lead location was used for this measurement?
#> 4108                                                                                                                                                                            What was the position of the subject during the ECG measurement?
#> 4109                                                                                                                                                                                                               What was the date of the ECG?
#> 4110                                                                                                                                                                                     What was the planned time point of the ECG measurement?
#> 4111                                                                                                                                                                                                    What was the time the ECG was collected?
#> 4112                                                                                                                                                                                                                 What was the ECG test name?
#> 4113                                                                                                                                                                                                             What was the result of the ECG?
#> 4114                                                                                                                                                                                                       What was the unit of the ECG results?
#> 4115                                                                                                                                                                                                         Was the ECG clinically significant?
#> 4116                                                                                                                                                                                                               What is the study identifier?
#> 4117                                                                                                                                                                                                                What is the site identifier?
#> 4118                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4119                                                                                                                                                                                                                     What is the visit name?
#> 4120                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4121                                                                                                                                                                                                   What was the category of the ECG finding?
#> 4122                                                                                                                                                                                                What was the subcategory of the ECG finding?
#> 4123                                                                                                                                                                                                                      Was the ECG performed?
#> 4124                                                                                                                                                                                                        Which repetition of the ECG is this?
#> 4125                                                                                                                                                                                 What was the (ECG) [reference identifier/accession number]?
#> 4126                                                                                                                                                                                                       What was the method used for the ECG?
#> 4127                                                                                                                                                                                          Which lead location was used for this measurement?
#> 4128                                                                                                                                                                            What was the position of the subject during the ECG measurement?
#> 4129                                                                                                                                                                                                               What was the date of the ECG?
#> 4130                                                                                                                                                                                     What was the planned time point of the ECG measurement?
#> 4131                                                                                                                                                                                                    What was the time the ECG was collected?
#> 4132                                                                                                                                                                                       Who provided the information?; Who was the evaluator?
#> 4133                                                                                                                                                                                                     What was the interpretation of the ECG?
#> 4134                                                                                                                                                                                                         Was the ECG clinically significant?
#> 4135                                                                                                                            What was the identifier for the medical history event that was reported as a clinically significant ECG finding?
#> 4136                                                                                                                                 What was the identifier for the adverse event(s) that was reported as a clinically significant ECG finding?
#> 4137                                                                                                                                                                                                               What is the study identifier?
#> 4138                                                                                                                                                                                                                What is the site identifier?
#> 4139                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4140                                                                                                                                                                                                                     What is the visit name?
#> 4141                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4142                                                                                                                                                                                                   What is the category of the genomic test?
#> 4143                                                                                                                                                                                                What is the subcategory of the genomic test?
#> 4144                                                                                                                                                                    Was the (genomic) specimen collected?; Was the (genomic) test performed?
#> 4145                                                                                                                                                                    What was the (genomic specimen) [reference identifier/accession number]?
#> 4146                                                                                                                                                                                          What was the planned time point of the collection?
#> 4147                                                                                                                                                                               What was the (start) date of the genomic specimen collection?
#> 4148                                                                                                                                                                               What was the (start) time of the genomic specimen collection?
#> 4149                                                                                                                                                                                                               What is the study identifier?
#> 4150                                                                                                                                                                                                                What is the site identifier?
#> 4151                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4152                                                                                                                                                                                                                     What is the visit name?
#> 4153                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4154                                                                                                                                                                                                   What is the category of the genomic test?
#> 4155                                                                                                                                                                                                What is the subcategory of the genomic test?
#> 4156                                                                                                                                                                    Was the (genomic) specimen collected?; Was the (genomic) test performed?
#> 4157                                                                                                                                                                                                   What was the name of the laboratory used?
#> 4158                                                                                                                                                                                                      What was the name of the genomic test?
#> 4159                                                                                                                                                                                                           What was the genomic test detail?
#> 4160                                                                                                                                                                                              What was the method used for the genomic test?
#> 4161                                                                                                                                                                                          What was the planned time point of the collection?
#> 4162                                                                                                                                                                               What was the (start) date of the genomic specimen collection?
#> 4163                                                                                                                                                                               What was the (start) time of the genomic specimen collection?
#> 4164                                                                                                                                                                                                    What was the result of the genomic test?
#> 4165                                                                                                                                                                                                      What was the unit of the genomic test?
#> 4166                                                                                                                                                                                                               What is the study identifier?
#> 4167                                                                                                                                                                                                                What is the site identifier?
#> 4168                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4169                                                                                                                                                                                                                     What is the visit name?
#> 4170                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4171                                                                                                                                                                                           Was the sample collected?; Was the lab performed?
#> 4172                                                                                                                                                                                   What was the (start) date of the lab specimen collection?
#> 4173                                                                                                                                                                                   What was the (start) time of the lab specimen collection?
#> 4174                                                                                                                                                                                                         What was the name of the lab panel?
#> 4175                                                                                                                                                                                                     What was the name of the lab sub-panel?
#> 4176                                                                                                                                                                                                         What is the specimen material type?
#> 4177                                                                                                                                                                                                 What was the planned time point of the lab?
#> 4178                                                                                                                                                                                           Were the protocol-defined testing conditions met?
#> 4179                                                                                                                                                                                                                    Was the subject fasting?
#> 4180                                                                                                                                                                     What was the (laboratory test) [reference identifier/accession number]?
#> 4181                                                                                                                                                                                                               What is the study identifier?
#> 4182                                                                                                                                                                                                                What is the site identifier?
#> 4183                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4184                                                                                                                                                                                                                     What is the visit name?
#> 4185                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4186                                                                                                                                                                                           Was the sample collected?; Was the lab performed?
#> 4187                                                                                                                                                                                    What was the (start) date of the lab specimen collection
#> 4188                                                                                                                                                                                   What was the (start) time of the lab specimen collection?
#> 4189                                                                                                                                                                                                         What was the name of the lab panel?
#> 4190                                                                                                                                                                                                     What was the name of the lab sub-panel?
#> 4191                                                                                                                                                                                                         What is the specimen material type?
#> 4192                                                                                                                                                                                                 What was the planned time point of the lab?
#> 4193                                                                                                                                                                                           Were the protocol-defined testing conditions met?
#> 4194                                                                                                                                                                                                                    Was the subject fasting?
#> 4195                                                                                                                                                                                                                 What was the lab test name?
#> 4196                                                                                                                                                                                                        What was the result of the lab test?
#> 4197                                                                                                                                                                                                        What was the unit of the lab result?
#> 4198                                                                                                                                                                                                     Was this result clinically significant?
#> 4199                                                                                                                                                                     What was the (laboratory test) [reference identifier/accession number]?
#> 4200                                                                                                                                                                                   What was the method used for the lab test or examination?
#> 4201                                                                                                                                                                                                               What is the study identifier?
#> 4202                                                                                                                                                                                                                What is the site identifier?
#> 4203                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4204                                                                                                                                                                                                                     What is the visit name?
#> 4205                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4206                                                                                                                                                                                           Was the sample collected?; Was the lab performed?
#> 4207                                                                                                                                                                                   What was the (start) date of the lab specimen collection?
#> 4208                                                                                                                                                                                   What was the (start) time of the lab specimen collection?
#> 4209                                                                                                                                                                                                         What was the name of the lab panel?
#> 4210                                                                                                                                                                                                     What was the name of the lab sub-panel?
#> 4211                                                                                                                                                                                                         What is the specimen material type?
#> 4212                                                                                                                                                                                                 What was the planned time point of the lab?
#> 4213                                                                                                                                                                                                                    Was the subject fasting?
#> 4214                                                                                                                                                                                           Were the protocol-defined testing conditions met?
#> 4215                                                                                                                                                                                                     What was the condition of the specimen?
#> 4216                                                                                                                                                                                                                 What was the lab test name?
#> 4217                                                                                                                                                                                                        What was the result of the lab test?
#> 4218                                                                                                                                                                                   What was the method used for the lab test or examination?
#> 4219                                                                                                                                                                                                        What was the unit of the lab result?
#> 4220                                                                                                                                                                                                        What was the unit of the lab result?
#> 4221                                                                                                                                                                                                                 What is the toxicity grade?
#> 4222                                                                                                                                                                                                    What is the description of the toxicity?
#> 4223                                                                                                                                                                          What was the lower limit of the reference range for this lab test?
#> 4224                                                                                                                                                                           What was the high limit of the reference range for this lab test?
#> 4225                                                                                                                                                      How [did/do] the reported values compare within the [reference/normal/expected] range?
#> 4226                                                                                                                                                                                                     Was this result clinically significant?
#> 4227                                                                                                                                                                                                   What was the name of the laboratory used?
#> 4228                                                                                                                                                                                                               What is the study identifier?
#> 4229                                                                                                                                                                                                                What is the site identifier?
#> 4230                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4231                                                                                                                                                                                                                     What is the visit name?
#> 4232                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4233                                                                                                                                                    Was the [microbiology test] performed? Was the [microbiology specimen/sample] collected?
#> 4234                                                                                                                                                                   What was the (microbiology test) [reference identifier/accession number]?
#> 4235                                                                                                                                                                            What [is/was] the [test/procedure/observation] group identifier?
#> 4236                                                                                                                                                                        What was the (start) date of the (microbiology) specimen collection?
#> 4237                                                                                                                                                                        What was the (start) time of the (microbiology) specimen collection?
#> 4238                                                                                                                                                                                          What was the category of the microbiology finding?
#> 4239                                                                                                                                                                                       What was the subcategory of the microbiology finding?
#> 4240                                                                                                                                                                                                         What is the specimen material type?
#> 4241                                                                                                                                                                                                     What was the condition of the specimen?
#> 4242                                                                                                                                                                          What was the anatomical location where the specimen was collected?
#> 4243                                                                                                                                                                    What was the side of the anatomical location of the specimen collection?
#> 4244                                                                                                                                                          What was the directionality of the anatomical location of the specimen collection?
#> 4245                                                                                                                                                                                                               What is the study identifier?
#> 4246                                                                                                                                                                                                                What is the site identifier?
#> 4247                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4248                                                                                                                                                                                                                     What is the visit name?
#> 4249                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4250                                                                                                                                                   Was the [microbiology test] performed? Was the [microbiology specimen/sample] collected?;
#> 4251                                                                                                                                                                   What was the (microbiology test) [reference identifier/accession number]?
#> 4252                                                                                                                                                                                                                  [Sponsor-defined question]
#> 4253                                                                                                                                                                            What [is/was] the [test/procedure/observation] group identifier?
#> 4254                                                                                                                                                                             What [is/was] the [test/procedure/observation] link identifier?
#> 4255                                                                                                                                                                        What was the (start) date of the (microbiology) specimen collection?
#> 4256                                                                                                                                                                        What was the (start) time of the (microbiology) specimen collection?
#> 4257                                                                                                                                                                                          What was the category of the microbiology finding?
#> 4258                                                                                                                                                                                       What was the subcategory of the microbiology finding?
#> 4259                                                                                                                                                                                            What was the microbiology examination test name?
#> 4260                                                                                                                                                                                               What was the microbiology examination detail?
#> 4261                                                                                                                                                                                                     What was the result of the examination?
#> 4262                                                                                                                                                                                                            What was the unit of the result?
#> 4263                                                                                                                                                                                                      Was the result clinically significant?
#> 4264                                                                                                                                                                                                               What was the result category?
#> 4265                                                                                                                                                                                                       What was the name of the vendor used?
#> 4266                                                                                                                                                                                                         What is the specimen material type?
#> 4267                                                                                                                                                                                                     What was the condition of the specimen?
#> 4268                                                                                                                                                                          What was the anatomical location where the specimen was collected?
#> 4269                                                                                                                                                                    What was the side of the anatomical location of the specimen collection?
#> 4270                                                                                                                                                          What was the directionality of the anatomical location of the specimen collection?
#> 4271                                                                                                                                                                                       What was the method used for the test or examination?
#> 4272                                                                                                                                                                                                                      Who was the evaluator?
#> 4273                                                                                                                                                                                                               What is the study identifier?
#> 4274                                                                                                                                                                                                                What is the site identifier?
#> 4275                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4276                                                                                                                                                                                                                     What is the visit name?
#> 4277                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4278                                                                                                                                                                        Was the microscopic examination performed? Was the sample collected?
#> 4279                                                                                                                                                                    What was the (microscopic test) [reference identifier/accession number]?
#> 4280                                                                                                                                                                                       What was the (start) date of the specimen collection?
#> 4281                                                                                                                                                                                       What was the (start) time of the specimen collection?
#> 4282                                                                                                                                                                                           What was the category of the microscopic finding?
#> 4283                                                                                                                                                                                        What was the subcategory of the microscopic finding?
#> 4284                                                                                                                                                                                                         What is the specimen material type?
#> 4285                                                                                                                                                                                                     What was the condition of the specimen?
#> 4286                                                                                                                                                                     What was the anatomical location from which the specimen was collected?
#> 4287                                                                                                                                                                    What was the side of the anatomical location of the specimen collection?
#> 4288                                                                                                                                                          What was the directionality of the anatomical location of the specimen collection?
#> 4289                                                                                                                                                                                                               What is the study identifier?
#> 4290                                                                                                                                                                                                                What is the site identifier?
#> 4291                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4292                                                                                                                                                                                                                     What is the visit name?
#> 4293                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4294                                                                                                                                                                        Was the microscopic examination performed? Was the sample collected?
#> 4295                                                                                                                                                                    What was the (microscopic test) [reference identifier/accession number]?
#> 4296                                                                                                                                                                                                                  [Sponsor-defined question]
#> 4297                                                                                                                                                                                       What was the (start) date of the specimen collection?
#> 4298                                                                                                                                                                                       What was the (start) time of the specimen collection?
#> 4299                                                                                                                                                                                           What was the category of the microscopic finding?
#> 4300                                                                                                                                                                                        What was the subcategory of the microscopic finding?
#> 4301                                                                                                                                                                 What [is/was] the name (of the microscopic [measurement/test/examination])?
#> 4302                                                                                                                                                                   What [is/was] the [microscopic measurement/test/examination] detail name?
#> 4303                                                                                                                                                                                                     What was the result of the examination?
#> 4304                                                                                                                                                                                                            What was the unit of the result?
#> 4305                                                                                                                                                                                                      Was the result clinically significant?
#> 4306                                                                                                                                                                                                               What was the result category?
#> 4307                                                                                                                                                                                                       What was the name of the vendor used?
#> 4308                                                                                                                                                                                                         What is the specimen material type?
#> 4309                                                                                                                                                                                                     What was the condition of the specimen?
#> 4310                                                                                                                                                                     What was the anatomical location from which the specimen was collected?
#> 4311                                                                                                                                                                    What was the side of the anatomical location of the specimen collection?
#> 4312                                                                                                                                                          What was the directionality of the anatomical location of the specimen collection?
#> 4313                                                                                                                                                                                       What was the method used for the test or examination?
#> 4314                                                                                                                                                                                                                      Who was the evaluator?
#> 4315                                                                                                                                                                                                               What is the study identifier?
#> 4316                                                                                                                                                                                                                What is the site identifier?
#> 4317                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4318                                                                                                                                                                                                                     What is the visit name?
#> 4319                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4320                                                                                                                      Was the [microbiology susceptibility test] performed? Was the [microbiology susceptibility specimen/sample] collected?
#> 4321                                                                                                                                                    What was the (microbiology susceptibility test) [reference identifier/accession number]?
#> 4322                                                                                                                                                                        What was the (start) date of the (microbiology) specimen collection?
#> 4323                                                                                                                                                                        What was the (start) time of the (microbiology) specimen collection?
#> 4324                                                                                                                                                                              What was the category of the microbiology susceptibility test?
#> 4325                                                                                                                                                                        What was the subcategory of the microbiology susceptibility finding?
#> 4326                                                                                                                                                                                                         What is the specimen material type?
#> 4327                                                                                                                                                                                                     What was the condition of the specimen?
#> 4328                                                                                                                                                                          What was the anatomical location where the specimen was collected?
#> 4329                                                                                                                                                                    What was the side of the anatomical location of the specimen collection?
#> 4330                                                                                                                                                          What was the directionality of the anatomical location of the specimen collection?
#> 4331                                                                                                                                                                                                               What is the study identifier?
#> 4332                                                                                                                                                                                                                What is the site identifier?
#> 4333                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4334                                                                                                                                                                                                          What was the non-host organism ID?
#> 4335                                                                                                                                                                                                                     What is the visit name?
#> 4336                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4337                                                                                                                      Was the [microbiology susceptibility test] performed? Was the [microbiology susceptibility specimen/sample] collected?
#> 4338                                                                                                                                                    What was the (microbiology susceptibility test) [reference identifier/accession number]?
#> 4339                                                                                                                                                                                                                  [Sponsor-defined question]
#> 4340                                                                                                                                                                            What [is/was] the [test/procedure/observation] group identifier?
#> 4341                                                                                                                                                                             What [is/was] the [test/procedure/observation] link identifier?
#> 4342                                                                                                                                                                        What was the (start) date of the (microbiology) specimen collection?
#> 4343                                                                                                                                                                             What was the (start) time of the the (microbiology) collection?
#> 4344                                                                                                                                                                           What was the category of the microbiology susceptibility finding?
#> 4345                                                                                                                                                                        What was the subcategory of the microbiology susceptibility finding?
#> 4346                                                                                                                                                                                         What was the microbiology susceptibility test name?
#> 4347                                                                                                                                                                                       What was the microbiology susceptibility test detail?
#> 4348                                                                                                                                                                        What was the name of the agent for which resistance is being tested?
#> 4349                                                                                                                                                                                                    What was the concentration of the agent?
#> 4350                                                                                                                                                                                                      What was the agent concentration unit?
#> 4351                                                                                                                                                                                                     What was the result of the examination?
#> 4352                                                                                                                                                                                                            What was the unit of the result?
#> 4353                                                                                                                                                                                                      Was the result clinically significant?
#> 4354                                                                                                                                                                                                               What was the result category?
#> 4355                                                                                                                                                                                                       What was the name of the vendor used?
#> 4356                                                                                                                                                                                                         What is the specimen material type?
#> 4357                                                                                                                                                                                                     What was the condition of the specimen?
#> 4358                                                                                                                                                                          What was the anatomical location where the specimen was collected?
#> 4359                                                                                                                                                                    What was the side of the anatomical location of the specimen collection?
#> 4360                                                                                                                                                          What was the directionality of the anatomical location of the specimen collection?
#> 4361                                                                                                                                                                                       What was the method used for the test or examination?
#> 4362                                                                                                                                                                                                                      Who was the evaluator?
#> 4363                                                                                                                                                                                                               What is the study identifier?
#> 4364                                                                                                                                                                                                                What is the site identifier?
#> 4365                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4366                                                                                                                                                                                                                     What is the visit name?
#> 4367                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4368                                                                                                                                                                                                                  Were PK samples collected?
#> 4369                                                                                                                                                                                       Record "Not Done" if the PK sample was not collected.
#> 4370                                                                                                                                                                                        What was the reason the PK sample was not collected?
#> 4371                                                                                                                                                                                              What was the date of the PK sample collection?
#> 4372                                                                                                                     Was the specimen/sample collected on the same date as the [last/previous specimen/sample] [collected/collection ended]?
#> 4373                                                                                                                                                                                              What was the time of the PK sample collection?
#> 4374                                                                                                                                                                                What was the planned time point of the PK sample collection?
#> 4375                                                                                                                                                                                                                    Was the subject fasting?
#> 4376                                                                                                                                                                                           Were the protocol-defined testing conditions met?
#> 4377                                                                                                                                                                                  What was the (PK) [reference identifier/accession number]?
#> 4378                                                                                                                                                                                                      What was the specimen (material) type?
#> 4379                                                                                                                                                                                                                     What was the test name?
#> 4380                                                                                                                                                                                                            What was the result of the test?
#> 4381                                                                                                                                                                                                            What was the unit of the result?
#> 4382                                                                                                                                                                                                               What is the study identifier?
#> 4383                                                                                                                                                                                                                What is the site identifier?
#> 4384                                                                                                                                                                                                             What is the subject identifier?
#> 4385                                                                                                                                                                                                                     What is the visit name?
#> 4386                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4387                                                                                                                                                                                                                  Were PK samples collected?
#> 4388                                                                                                                                                                                        What was the reason the PK sample was not collected?
#> 4389                                                                                                                                                                                              What was the date of the PK sample collection?
#> 4390                                                                                                                                                                                        What was the start time of the PK sample collection?
#> 4391                                                                                                                                                                                           What was the end date of the specimen collection?
#> 4392                                                                                                                                                                                                  What was the specimen collection end time?
#> 4393                                                                                                                                                                                What was the planned time point of the PK sample collection?
#> 4394                                                                                                                                                                                                                    Was the subject fasting?
#> 4395                                                                                                                                                                                           Were the protocol-defined testing conditions met?
#> 4396                                                                                                                                                                                  What was the (PK) [reference identifier/accession number]?
#> 4397                                                                                                                                                                                                      What was the specimen (material) type?
#> 4398                                                                                                                                                                                                                     What was the test name?
#> 4399                                                                                                                                                                                                            What was the result of the test?
#> 4400                                                                                                                                                                                                            What was the unit of the result?
#> 4401                                                                                                                                                                                                               What is the study identifier?
#> 4402                                                                                                                                                                                                                What is the site identifier?
#> 4403                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4404                                                                                                                                                                                                                     What is the visit name?
#> 4405                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4406                                                                                                                                                                                                     Was the physical examination performed?
#> 4407                                                                                                                                                                                          What was the category of the physical examination?
#> 4408                                                                                                                                                                                           What was subcategory of the physical examination?
#> 4409                                                                                                                                                                                              What was the date of the physical examination?
#> 4410                                                                                                                                                                                              What was the time of the physical examination?
#> 4411                                                                                                                                                                                                                  [Sponsor-defined question]
#> 4412                                                                                                                                                                                                          What was the body system examined?
#> 4413                                                                                                                                                                                             Were the results normal, abnormal, or not done?
#> 4414                                                                                                                                                                                         If the result was abnormal, what were the findings?
#> 4415                                                                                                                                                                                 Was the physical examination result clinically significant?
#> 4416                                                                                                                                                                                                                      Who was the evaluator?
#> 4417                                                                                                                                                                                            What is the reason that data were not collected?
#> 4418                                                                                                                                                                                                What is/was the [body system/ organ system]?
#> 4419                                                                                                                                                                                                                                        <NA>
#> 4420                                                                                                                                                                What was the anatomical location of the body system examined or the finding?
#> 4421                                                                                                                                                    What was the side of the anatomical location of the body system examined or the finding?
#> 4422                                                                                                                                   What was the directionality of the anatomical location of the of the body system examined or the finding?
#> 4423                                                                                                                                     What was the portion or totality of the anatomical location of the body system examined or the finding?
#> 4424                                                                                                                                                                                       What was the method used for the test or examination?
#> 4425                                                                                                                                                                                                               What is the study identifier?
#> 4426                                                                                                                                                                                                                What is the site identifier?
#> 4427                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4428                                                                                                                                                                                                                     What is the visit name?
#> 4429                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4430                                                                                                                                                                                      What was the category of the subject characteristics??
#> 4431                                                                                                                                                                                    What was the subcategory of the subject characteristics?
#> 4432                                                                                                                                                                                      Were subject characteristics collected for [SCTESTCD]?
#> 4433                                                                                                                                                                                                          What is the test group identifier?
#> 4434                                                                                                                                                                                                             What is the subject's [SCTEST]?
#> 4435                                                                                                                                                                                                               What is the study identifier?
#> 4436                                                                                                                                                                                                                What is the site identifier?
#> 4437                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4438                                                                                                                                                                                                                     What is the visit name?
#> 4439                                                                                                                                                                                                        What [is/was] the date of the visit?
#> 4440                                                                                                                                                                                                       Were [vital signs/[VSTEST] performed?
#> 4441                                                                                                                                                                                                    What was the date of the measurement(s)?
#> 4442                                                                                                                                                                                                    What was the time of the measurement(s)?
#> 4443                                                                                                                                                                                                   What was the category of the vital signs?
#> 4444                                                                                                                                                                                                What was the subcategory of the vital signs?
#> 4445                                                                                                                                                                                                   What is the vital signs group identifier?
#> 4446                                                                                                                                                                            What is the planned time point for this vital signs measurement?
#> 4447                                                                                                                                                                                          Indicate if the [VSTEST] measurement was not done.
#> 4448                                                                                                                                                                                            What was the result of the [VSTEST] measurement?
#> 4449                                                                                                                                                                                              What was the unit of the [VSTEST] measurement?
#> 4450                                                                                                                                                                                             Was the [VSTEST] result clinically significant?
#> 4451                                                                                                                                                                       What was the position of the subject during the [VSTEST] measurement?
#> 4452                                                                                                                                                                  What was the anatomical location where the [VSTEST] measurement was taken?
#> 4453                                                                                                                                                                   What was the side of the anatomical location of the [VSTEST] measurement?
#> 4454                                                                                                                                                                                                               What is the study identifier?
#> 4455                                                                                                                                                                                                                What is the site identifier?
#> 4456                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4457                                                                                                                                                                                                         What is the subject's day of birth?
#> 4458                                                                                                                                                                                                       What is the subject's month of birth?
#> 4459                                                                                                                                                                                                        What is the subject's year of birth?
#> 4460                                                                                                                                                                                                        What is the subject's time of birth?
#> 4461                                                                                                                                                                                                                  What is the subject's age?
#> 4462                                                                                                                                                                                                                  What is the age unit used?
#> 4463                                                                                                                                                                                                             What is the date of collection?
#> 4464                                                                                                                                                                                                             What is the sex of the subject?
#> 4465                                                                                                                                                                            Do you consider yourself Hispanic/Latino or not Hispanic/Latino?
#> 4466                                                                                                                                                                                                       What is the ethnicity of the subject?
#> 4467                                                                                                                                   Which of the following five racial designations best describes you? (More than one choice is acceptable.)
#> 4468                                                                                                                                          Which of the following racial designations best describes you? (More than 1 choice is acceptable.)
#> 4469                                                                                                                                                                                                                    What was the other race?
#> 4470                                                                                                                                                                                                               What is the study identifier?
#> 4471                                                                                                                                                                                                                What is the site identifier?
#> 4472                                                                                                                                                                                 What [is/was] the (study) [subject/participant] identifier?
#> 4473                                                                                                                                                                                                        What is the subject's date of birth?
#> 4474                                                                                                                                                                                                        What is the subject's time of birth?
#> 4475                                                                                                                                                                                                                  What is the subject's age?
#> 4476                                                                                                                                                                                                                  What is the age unit used?
#> 4477                                                                                                                                                                                                             What is the date of collection?
#> 4478                                                                                                                                                                                                             What is the sex of the subject?
#> 4479                                                                                                                                                                            Do you consider yourself Hispanic/Latino or not Hispanic/Latino?
#> 4480                                                                                                                                                                                                       What is the ethnicity of the subject?
#> 4481                                                                                                                                   Which of the following five racial designations best describes you? (More than one choice is acceptable.)
#> 4482                                                                                                                                        Which of the following racial designations best describes you? (More than one choice is acceptable.)
#> 4483                                                                                                                                                                                                                    What was the other race?
#>                                                                                                        prompt
#> 3231                                                                                         [Protocol/Study]
#> 3232                                                                                        Site (Identifier)
#> 3233                                                                       [Subject/Participant] (Identifier)
#> 3234                                                                           Procedure Agent Category; NULL
#> 3235                                                                        Procedure Agent Subcategory; NULL
#> 3236                                                                                     Any procedure agents
#> 3237                                                                                        [Sponsor defined]
#> 3238                                                                             [Procedure/Assessment Agent]
#> 3239                                                                                                     <NA>
#> 3240                                                                                                  [AGTRT]
#> 3241                                                                       [Dose/Amount] (per administration)
#> 3242                                                                                                     Dose
#> 3243                                                                                              (Dose) Unit
#> 3244                                                                                                Dose Form
#> 3245                                                                                                Frequency
#> 3246                                                                                                    Route
#> 3247                                                                                               Start Date
#> 3248                                                                                               Start Time
#> 3249                                                                       Prior to [AGSTTPT]; prior to study
#> 3250                                                Ongoing (as of [the study-specific time point or period])
#> 3251                                                                                                 End Date
#> 3252                                                                                                 End Time
#> 3253                                                                                                     <NA>
#> 3254                                                                                                     <NA>
#> 3255                                                                                                     <NA>
#> 3256                                                                                         [Protocol/Study]
#> 3257                                                                                        Site (Identifier)
#> 3258                                                                       [Subject/Participant] (Identifier)
#> 3259                                              (Concomitant) [Medication/Treatment/Therapy Category]; NULL
#> 3260                                           (Concomitant) [Medication/Treatment/Therapy subcategory]; NULL
#> 3261                                              Any (Concomitant) [Medication(s)/Treatment(s)/Therapy(ies)]
#> 3262                                                                                        [Sponsor defined]
#> 3263                                                             (Concomitant) [Medication/Treatment/Therapy]
#> 3264                                                                                                     <NA>
#> 3265                                                   [Specific (Concomitant) [Medication/Treatment/Therapy]
#> 3266                                                                                       Active Ingredients
#> 3267                                                                                               Indication
#> 3268                                                                                 Adverse Event Identifier
#> 3269                                                                         Medical History Event Identifier
#> 3270                                                                       [Dose/Amount] (per administration)
#> 3271                                                                                                     Dose
#> 3272                                                                                         Total Daily Dose
#> 3273                                                                                              (Dose) Unit
#> 3274                                                                                                Dose Form
#> 3275                                                                                                Frequency
#> 3276                                                                                                    Route
#> 3277                                                                                               Start Date
#> 3278                                                                                               Start Time
#> 3279                                                                       Prior to [CMSTTPT]; Prior to Study
#> 3280                                                Ongoing (as of [the study-specific time point or period])
#> 3281                                                                                                 End Date
#> 3282                                                                                                 End Time
#> 3283                                           Reason for discontinuation of concomitant medication/treatment
#> 3284                                                                                                     <NA>
#> 3285                                                                                                     <NA>
#> 3286                                                                                                     <NA>
#> 3287                                                                                                     <NA>
#> 3288                                                                                                     <NA>
#> 3289                                                                                                     <NA>
#> 3290                                                                                                     <NA>
#> 3291                                                                                                     <NA>
#> 3292                                                                                                     <NA>
#> 3293                                                                                                     <NA>
#> 3294                                                                                                     <NA>
#> 3295                                                                                                     <NA>
#> 3296                                                                                                     <NA>
#> 3297                                                                                         [Protocol/Study]
#> 3298                                                                                        Site (Identifier)
#> 3299                                                                       [Subject/Participant] (Identifier)
#> 3300                                                             [Epoch](Period/Phase/Sponsor-defined phrase)
#> 3301                                                                                     Any Study Treatments
#> 3302                                                                         [Study Treatment Category]; NULL
#> 3303                                                                      [Study Treatment Subcategory]; NULL
#> 3304                                                           [Study Treatment/Investigational Product Name]
#> 3305                                                                                                     <NA>
#> 3306                                                                             [Study Medication/Treatment]
#> 3307                                                                                       Reason (Not) Taken
#> 3308                                                                                      Scheduled/Performed
#> 3309                                                                       [Study Treatment] Label Identifier
#> 3310                                                                                               Lot Number
#> 3311                                                                                                  Fasting
#> 3312                                                                                                Dose Form
#> 3313                                                                                             (Start) Date
#> 3314                                                                                             (Start) Time
#> 3315                                                                                               (End) Date
#> 3316                                                                                               (End) Time
#> 3317                                                                                                     Dose
#> 3318                                                                                                    Units
#> 3319                                                                                                Frequency
#> 3320                                                                                                    Route
#> 3321                                                                                    Intended Dose Regimen
#> 3322                                                                                          (Dose) Adjusted
#> 3323                                                                                          Reason Adjusted
#> 3324                                                                   [(Study) Treatment / Dose] Interrupted
#> 3325                                                                                  (Interruption) Duration
#> 3326                                                                             (Interruption Duration) Unit
#> 3327                                                                                      Anatomical Location
#> 3328                                                                                                     Side
#> 3329                                                                                           Directionality
#> 3330                                                                            Total Amount (Drug + Vehicle)
#> 3331                                                                                                     Unit
#> 3332                                                                                            Infusion Rate
#> 3333                                                                                       Infusion Rate Unit
#> 3334                                                                                [Planned Time Point Name]
#> 3335                                                                                      Completed Treatment
#> 3336                                                                                         [Protocol/Study]
#> 3337                                                                                        Site (Identifier)
#> 3338                                                                       [Subject/Participant] (Identifier)
#> 3339                                                             [Epoch](Period/Phase/Sponsor-defined phrase)
#> 3340                                                                                     Any Study Treatments
#> 3341                                                                         [Study Treatment Category]; NULL
#> 3342                                                                      [Study Treatment Subcategory]; NULL
#> 3343                                                           [Study Treatment/Investigational Product Name]
#> 3344                                                                               Treatment Label Identifier
#> 3345                                                                                               Lot Number
#> 3346                                                                                                  Fasting
#> 3347                                                                                                Dose Form
#> 3348                                                                                             (Start) Date
#> 3349                                                                                             (Start) Time
#> 3350                                                                                               (End) Date
#> 3351                                                                                               (End) Time
#> 3352                                                                                                     Dose
#> 3353                                                                                                     Unit
#> 3354                                                                                                Frequency
#> 3355                                                                                                    Route
#> 3356                                                                                    Intended Dose Regimen
#> 3357                                                                                          (Dose) Adjusted
#> 3358                                                                                          Reason Adjusted
#> 3359                                                                   [(Study) Treatment / Dose] Interrupted
#> 3360                                                                                  (Interruption) Duration
#> 3361                                                                             (Interruption Duration) Unit
#> 3362                                                                                      Anatomical Location
#> 3363                                                                                             Total Amount
#> 3364                                                                                                     Unit
#> 3365                                                                                            Infusion Rate
#> 3366                                                                                     (Infusion Rate) Unit
#> 3367                                                                                [Planned Time Point Name]
#> 3368                                                                                      Completed Treatment
#> 3369                                                                                                     Side
#> 3370                                                                                           Directionality
#> 3371                                                                                         [Protocol/Study]
#> 3372                                                                                        Site (Identifier)
#> 3373                                                                       [Subject/Participant] (Identifier)
#> 3374                                                                      [Meal/Food Product] Category]; NULL
#> 3375                                                                   [Meal/Food Product] Subcategory]; NULL
#> 3376                                                  Any [meal/food product] [taken/consumed/administered] ?
#> 3377                                                                                        [Sponsor defined]
#> 3378                                                                                                   [Meal]
#> 3379                                                                                                     <NA>
#> 3380                                                                                                  [MLTRT]
#> 3381                                                                                   Reason for Occur Value
#> 3382                                                                                                   Reason
#> 3383                                                                                Clinical Event Identifier
#> 3384                                                                    [Quantity/Amount] (given at one time)
#> 3385                                                                                                     Dose
#> 3386                                                                                   (Quantity/Amount) Unit
#> 3387                                                                                             (Start) Date
#> 3388                                                                                               Start Time
#> 3389                                                                                                 End Date
#> 3390                                                                                                 End Time
#> 3391                                                                                                     <NA>
#> 3392                                                                                                     <NA>
#> 3393                                                                                         [Protocol/Study]
#> 3394                                                                                        Site (Identifier)
#> 3395                                                                       [Subject/Participant] (Identifier)
#> 3396                                                                                           Any Procedures
#> 3397                                                                               [Procedure Category]; NULL
#> 3398                                                                            [Procedure Subcategory]; NULL
#> 3399                                                                                        [Sponsor defined]
#> 3400                                                                        [Procedure Name]; (Specify) Other
#> 3401                                                                            [Standardized Procedure Name]
#> 3402                                                                                                     <NA>
#> 3403                                                                                                     <NA>
#> 3404                                                                                [PRDECOD/PRTRT] Performed
#> 3405                                                                                   Reason for Occur Value
#> 3406                                                                                          Reason not done
#> 3407                                                                       Prior to [PRSTTPT]; Prior to study
#> 3408                                                                                             (Start) Date
#> 3409                                                 Ongoing (as of the [study-specific timepoint or period])
#> 3410                                                                                               (End) Date
#> 3411                                                                                               Indication
#> 3412                                                                         Related Adverse Event Identifier
#> 3413                                                                 Related Medical History Event Identifier
#> 3414                                                                                            [Dose/Amount]
#> 3415                                                                                                     Unit
#> 3416                                                                                                Frequency
#> 3417                                                                                                    Route
#> 3418                                                                                      Anatomical Location
#> 3419                                                                                                     Side
#> 3420                                                                                           Directionality
#> 3421                                                                                      Portion or Totality
#> 3422                                                                                                  Fasting
#> 3423                                                                               Intended Procedure Regimen
#> 3424                                                                                          (Dose) Adjusted
#> 3425                                                                                          Reason Adjusted
#> 3426                                                                        Completed [PR Intervention Topic]
#> 3427                                                                                    Procedure Interrupted
#> 3428                                                                             Reason Procedure Interrupted
#> 3429                                                                                  (Interruption) Duration
#> 3430                                                                             (Interruption Duration) Unit
#> 3431                                                                                                     <NA>
#> 3432                                                                                                     <NA>
#> 3433                                                                                                     <NA>
#> 3434                                                                                                     <NA>
#> 3435                                                                                                     <NA>
#> 3436                                                                                                     <NA>
#> 3437                                                                                                     <NA>
#> 3438                                                                                                     <NA>
#> 3439                                                                                                     <NA>
#> 3440                                                                                         [Protocol/Study]
#> 3441                                                                                        Site (Identifier)
#> 3442                                                                       [Subject/Participant] (Identifier)
#> 3443                                                                                      [Type of Substance]
#> 3444                                                                        [Substance (Used) Category]; NULL
#> 3445                                                                     [Substance (Used) Subcategory]; NULL
#> 3446                                                                                                     <NA>
#> 3447                                                                              Any [Substance Name (Used)]
#> 3448                                                                                      ([Substance]) Usage
#> 3449                                                                                        [Sponsor defined]
#> 3450                                                                                     Reason Not Collected
#> 3451                                                                                                   Amount
#> 3452                                                                                                Frequency
#> 3453                                                                                               Start Date
#> 3454                                                                                                 End Date
#> 3455                                                                                                 Duration
#> 3456                                                                                          (Duration) Unit
#> 3457                                                                                                     <NA>
#> 3458                                                                                                     <NA>
#> 3459                                                                                         [Protocol/Study]
#> 3460                                                                                        Site (Identifier)
#> 3461                                                                       [Subject/Participant] (Identifier)
#> 3462                                                                                       Any Adverse Events
#> 3463                                                                           [Adverse Event Category]; NULL
#> 3464                                                                        [Adverse Event Subcategory]; NULL
#> 3465                                                                                        [Sponsor defined]
#> 3466                                                                                            Adverse Event
#> 3467                                                                                [Specific Adverse Event ]
#> 3468                                                                                                     <NA>
#> 3469                                                                                               Start Date
#> 3470                                                                                               Start Time
#> 3471                                                                                      Anatomical Location
#> 3472                                                                                                     Side
#> 3473                                                                                           Directionality
#> 3474                                                                                      Portion or Totality
#> 3475                                                Ongoing (as of [the study-specific time point or period])
#> 3476                                                                                                 End Date
#> 3477                                                                                                 End Time
#> 3478                                                                                                 Severity
#> 3479                                                          [NCI CTCAE/ Name of the scale] (Toxicity) Grade
#> 3480                                                                                                  Serious
#> 3481                                                                                                    Death
#> 3482                                                                                               Death Date
#> 3483                                                                                         Life Threatening
#> 3484                                                                   Hospitalization (initial or prolonged)
#> 3485                                                                           Disability or Permanent Damage
#> 3486                                                                       Congenital Anomaly or Birth Defect
#> 3487                                                                 Needs Intervention to Prevent Impairment
#> 3488                                                                 Other Serious (Important Medical Events)
#> 3489                                                                                                   Cancer
#> 3490                                                                                                 Overdose
#> 3491                                                                          Relationship to Study Treatment
#> 3492                                                                        Action Taken with Study Treatment
#> 3493                                                                                 Action Taken with Device
#> 3494                                                                                Any Other Action(s) Taken
#> 3495                                                                                       Other Action Taken
#> 3496                                                                                                  Outcome
#> 3497                                                                             Caused Study Discontinuation
#> 3498                                                                           Related to Non-Study Treatment
#> 3499                                                                      Relationship to Non-Study Treatment
#> 3500                                                                        Adverse Event of Special Interest
#> 3501                                                                                                  Pattern
#> 3502                                                 Concomitant or Additional Treatment Given Due to This AE
#> 3503                                                                                                     <NA>
#> 3504                                                                                                     <NA>
#> 3505                                                                                                     <NA>
#> 3506                                                                                                     <NA>
#> 3507                                                                                                     <NA>
#> 3508                                                                                                     <NA>
#> 3509                                                                                                     <NA>
#> 3510                                                                                                     <NA>
#> 3511                                                                                                     <NA>
#> 3512                                                                                                     <NA>
#> 3513                                                                                                     <NA>
#> 3514                                                                                         [Protocol/Study]
#> 3515                                                                                        Site (Identifier)
#> 3516                                                                       [Subject/Participant] (Identifier)
#> 3517                                                                          [Clinical Event Category]; NULL
#> 3518                                                                       [Clinical Event Subcategory]; NULL
#> 3519                                                                                      Any Clinical Events
#> 3520                                                                                        [Sponsor defined]
#> 3521                                                                [Clinical Event]; Specify (Other/Details)
#> 3522                                                                               [Specified Clinical Event]
#> 3523                                                                                                     <NA>
#> 3524                                                                                               Start Date
#> 3525                                                                                               Start Time
#> 3526                                                                                      Anatomical Location
#> 3527                                                                                                     Side
#> 3528                                                                                           Directionality
#> 3529                                                                                      Portion or Totality
#> 3530                                                 Ongoing (as of the [study-specific timepoint or period])
#> 3531                                                                                                 End Date
#> 3532                                                                                                 End Time
#> 3533                                                                                                 Severity
#> 3534                                                                                     [NCI CTCAE] Toxicity
#> 3535                                                                               [NCI CTCAE Toxicity] Grade
#> 3536                                                                                                     <NA>
#> 3537                                                                                                     <NA>
#> 3538                                                                                                     <NA>
#> 3539                                                                                                     <NA>
#> 3540                                                                                                     <NA>
#> 3541                                                                                                     <NA>
#> 3542                                                                                                     <NA>
#> 3543                                                                                                     <NA>
#> 3544                                                                                                     <NA>
#> 3545                                                                                                     <NA>
#> 3546                                                                                                     <NA>
#> 3547                                                                                         [Protocol/Study]
#> 3548                                                                                        Site (Identifier)
#> 3549                                                                       [Subject/Participant] (Identifier)
#> 3550                                                                      [Protocol Deviation Category]; NULL
#> 3551                                                                   [Protocol Deviation Subcategory]; NULL
#> 3552                                                                                           Any Deviations
#> 3553                                                                 (Standardized) Protocol Deviation (Term)
#> 3554                                                                             (Specify) Protocol Deviation
#> 3555                                                                                               Start Date
#> 3556                                                                                               Start Time
#> 3557                                                                                                 End Date
#> 3558                                                                                                 End Time
#> 3559                                                                                        [Sponsor defined]
#> 3560                                                                                         [Protocol/Study]
#> 3561                                                                                        Site (Identifier)
#> 3562                                                                       [Subject/Participant] (Identifier)
#> 3563                                                                                Any Healthcare Encounters
#> 3564                                                                    [Healthcare Encounter Category]; NULL
#> 3565                                                                 [Healthcare Encounter Subcategory]; NULL
#> 3566                                                                 [prespecified Healthcare Encounter Term]
#> 3567                                                                                                     <NA>
#> 3568                                                                                     Reason Not Collected
#> 3569                                                                                        [Sponsor-defined]
#> 3570                                                                        [Healthcare Encounter]; [Specify]
#> 3571                                                               (Standardized) Healthcare Encounter (Term)
#> 3572                                                                         ([HOTERM])[Start/Admission] Date
#> 3573                                                                         ([HOTERM])[Start/Admission] Time
#> 3574                                                                           ([HOTERM])[End/Discharge] Date
#> 3575                                                                            ([HOTERM])[End/Discharge]Time
#> 3576                                                                                                 Duration
#> 3577                                                                                          (Duration) Unit
#> 3578                                                    Ongoing as of the[study-specific timepoint or period]
#> 3579                                                                      Reason for the Healthcare Encounter
#> 3580                                                                                 Adverse Event Identifier
#> 3581                                                                                         [Protocol/Study]
#> 3582                                                                                        Site (Identifier)
#> 3583                                                                       [Subject/Participant] (Identifier)
#> 3584                                                                                      Any Medical History
#> 3585                                                                         [Medical History Category]; NULL
#> 3586                                                                      [Medical History Subcategory]; NULL
#> 3587                                                                                          Collection Date
#> 3588                                                                                        [Sponsor defined]
#> 3589                                                                          Medical History Event Date Type
#> 3590                                                                                     Medical History Term
#> 3591                                                                                [Medical condition/Event]
#> 3592                                                                                                     <NA>
#> 3593                                                                       Prior to [MHSTTPT]; Prior to Study
#> 3594                                                 Ongoing (as of the [study-specific timepoint or period])
#> 3595                                                                          Medical Condition Under Control
#> 3596                                                                                               Start Date
#> 3597                                                                                                 End Date
#> 3598                                                                                      Anatomical Location
#> 3599                                                                                                     Side
#> 3600                                                                                           Directionality
#> 3601                                                                                      Portion or Totality
#> 3602                                                                                                     <NA>
#> 3603                                                                                                     <NA>
#> 3604                                                                                                     <NA>
#> 3605                                                                                                     <NA>
#> 3606                                                                                                     <NA>
#> 3607                                                                                                     <NA>
#> 3608                                                                                                     <NA>
#> 3609                                                                                                     <NA>
#> 3610                                                                                                     <NA>
#> 3611                                                                                                     <NA>
#> 3612                                                                                                     <NA>
#> 3613                                                                                         [Protocol/Study]
#> 3614                                                                                        Site (Identifier)
#> 3615                                                                       [Subject/Participant] (Identifier)
#> 3616                                                                                                  [Visit]
#> 3617                                                                                             (Visit) Date
#> 3618                                                                          [Cell Phenotype Category]; NULL
#> 3619                                                                       [Cell Phenotype Subcategory]; NULL
#> 3620                                                        Cell Phenotype Test Performed; Specimen Collected
#> 3621                                        (Cell Phenotype specimen) [Reference identifier/Accession Number]
#> 3622                                                                                [Planned Time Point Name]
#> 3623                                                          Cell Phenotype Specimen Collection (Start) Date
#> 3624                                                          Cell Phenotype Specimen Collection (Start) Time
#> 3625                                                                                         [Protocol/Study]
#> 3626                                                                                        Site (Identifier)
#> 3627                                                                                                  Subject
#> 3628                                                                                                  [Visit]
#> 3629                                                                                             (Visit) Date
#> 3630                                                                      Cardiovascular Assessment Performed
#> 3631                                                                                                     Date
#> 3632                                                                                                     Time
#> 3633                                                                                [Planned Time Point Name]
#> 3634                                                                               [Cardiovascular Test Name]
#> 3635                                                                     [Cardiovascular Test Category]; NULL
#> 3636                                                                  [Cardiovascular Test Subcategory]; NULL
#> 3637                                                                                          [CVTEST] Result
#> 3638                                                                                                     Unit
#> 3639                                                                                                 (Result)
#> 3640                                                                                      (abnormal) Findings
#> 3641                                                                                                 Not Done
#> 3642                                        Reason Not [Answered/Collected/Done/Evaluated/Assessed/Available]
#> 3643                                                                                                 Position
#> 3644                                                                                      Anatomical Location
#> 3645                                                                                                     Side
#> 3646                                                                                           Directionality
#> 3647                                                                                                   Method
#> 3648                                                                                                Evaluator
#> 3649                                                                                     Evaluator Identifier
#> 3650                                                                                         [Protocol/Study]
#> 3651                                                                                        Site (Identifier)
#> 3652                                                                                                  Subject
#> 3653                                                                                                  [Visit]
#> 3654                                                                                             (Visit) Date
#> 3655                                                                                 Accountability Performed
#> 3656                                                                               [Study Product Type]; NULL
#> 3657                                                                               [Study Product Name]; NULL
#> 3658                                                                                                     Date
#> 3659                                                                           Study Product Label Identifier
#> 3660                                                                 [Study Product Accountability Test Name]
#> 3661                                                                                                   Amount
#> 3662                                                                                                     Unit
#> 3663                                                                                         [Protocol/Study]
#> 3664                                                                                        Site (Identifier)
#> 3665                                                                       [Subject/Participant] (Identifier)
#> 3666                                                                                                  [Visit]
#> 3667                                                                                             (Visit) Date
#> 3668                                                                                        Any Death Details
#> 3669                                                                                          Collection Date
#> 3670                                                                                        [Sponsor defined]
#> 3671                                                                                               Death Date
#> 3672                                                                     [Death Detail Assessment (Test Name]
#> 3673                                                                                                 (Result)
#> 3674                                                                    [Death Detail Results Category]; NULL
#> 3675                                                                                     [Evaluator/Reporter]
#> 3676                                                                                         [Protocol/Study]
#> 3677                                                                                        Site (Identifier)
#> 3678                                                                       [Subject/Participant] (Identifier)
#> 3679                                                                                                  [Visit]
#> 3680                                                                                             (Visit) Date
#> 3681                                                                                             Met Criteria
#> 3682                                                                                                     Date
#> 3683                                                                                           Criterion Type
#> 3684                                                                                [Criterion Subtype]; NULL
#> 3685                                                                           Exception Criterion Identifier
#> 3686                                                                          Exception Criterion Description
#> 3687                                                                                                 (Result)
#> 3688                                                                                         [Protocol/Study]
#> 3689                                                                                        Site (Identifier)
#> 3690                                                                                                  Subject
#> 3691                                                                                                  [Visit]
#> 3692                                                                                             (Visit) Date
#> 3693                                                                Musculoskeletal System Findings Collected
#> 3694                                                                                          Collection Date
#> 3695                                                                                          Collection Time
#> 3696                                                                                [Planned Time Point Name]
#> 3697                                                              [Musculoskeletal System Findings Test Name]
#> 3698                                                         [Musculoskeletal System Findings Category]; NULL
#> 3699                                                      [Musculoskeletal System Findings Subcategory]; NULL
#> 3700                                                                                          [MKTEST] Result
#> 3701                                                                                                     Unit
#> 3702                                                                                                 (Result)
#> 3703                                                                                      (Abnormal) Findings
#> 3704                                                                  [Specify Other/Explain/Specify Details]
#> 3705                                                          Comparison to [Reference/Expected/Normal] Range
#> 3706                                                                                                 Not Done
#> 3707                                                           Reason Not [Answered/Collected/Done/Available]
#> 3708                                                                                                 Position
#> 3709                                                                                      Anatomical Location
#> 3710                                                                                                     Side
#> 3711                                                                                           Directionality
#> 3712                                                                                                   Method
#> 3713                                                                                                Evaluator
#> 3714                                                                                     Evaluator Identifier
#> 3715                                                                                      Accepted Evaluation
#> 3716                                                                                        Repetition Number
#> 3717                                                                                         [Protocol/Study]
#> 3718                                                                                        Site (Identifier)
#> 3719                                                                                                  Subject
#> 3720                                                                                                  [Visit]
#> 3721                                                                                             (Visit) Date
#> 3722                                                                           Neurology Assessment Performed
#> 3723                                                                                                     Date
#> 3724                                                                                                     Time
#> 3725                                                                                [Planned Time Point Name]
#> 3726                                                                                    [Neurology Test Name]
#> 3727                                                                    [Neurology Assessment Category]; NULL
#> 3728                                                                 [Neurology Assessment Subcategory]; NULL
#> 3729                                                                                          [NVTEST] Result
#> 3730                                                                                                     Unit
#> 3731                                                                                                 (Result)
#> 3732                                                                                      (Abnormal) Findings
#> 3733                                                                  [Specify Other/Explain/Specify Details]
#> 3734                                                                                 Normal Range Lower Limit
#> 3735                                                                                 Normal Range Upper Limit
#> 3736                                                          Comparison to [Reference/Expected/Normal] Range
#> 3737                                                                                                 Not Done
#> 3738                                        Reason Not [Answered/Collected/Done/Evaluated/Assessed/Available]
#> 3739                                                                                                 Position
#> 3740                                                                                      Anatomical Location
#> 3741                                                                                                     Side
#> 3742                                                                                           Directionality
#> 3743                                                                                                   Method
#> 3744                                                                                                Evaluator
#> 3745                                                                                     Evaluator Identifier
#> 3746                                                                                        Repetition Number
#> 3747                                                                                   Clinically Significant
#> 3748                                                                                         [Protocol/Study]
#> 3749                                                                                        Site (Identifier)
#> 3750                                                                                                  Subject
#> 3751                                                                                                  [Visit]
#> 3752                                                                                             (Visit) Date
#> 3753                                                                                                 Eye/Eyes
#> 3754                                                                         Ophthalmic Examination Performed
#> 3755                                                                                                     Date
#> 3756                                                                                                     Time
#> 3757                                                                       [Ophthalmic Examination] Test Name
#> 3758                                                             [Measurement/Test/Examination] Detail (Name)
#> 3759                                                                  [Ophthalmic Examination Category]; NULL
#> 3760                                                               [Ophthalmic Examination Subcategory]; NULL
#> 3761                                                           ([Result/Amount] of) [value from OETEST]; NULL
#> 3762                                                                                                     Unit
#> 3763                                                                 ([Result/Amount] of) [value from OETEST]
#> 3764                                                                                Specify ([Other/Details])
#> 3765                                                                                 Normal Range Lower Limit
#> 3766                                                                                 Normal Range Upper Limit
#> 3767                                                                                   Normal Reference Range
#> 3768                                                          Comparison to [Reference/Expected/Normal] Range
#> 3769                                                                                          Result Category
#> 3770                                        Reason Not [Answered/Collected/Done/Evaluated/Assessed/Available]
#> 3771                                                                                      Anatomical Location
#> 3772                                                                                                     Side
#> 3773                                                                                           Directionality
#> 3774                                                                                      Portion or Totality
#> 3775                                                                                                   Method
#> 3776                                                                                                Evaluator
#> 3777                                                                                     Evaluator Identifier
#> 3778                                                                              [Accepted/Final] Evaluation
#> 3779                                                                                        Repetition Number
#> 3780                                                                                         [Protocol/Study]
#> 3781                                                                                        Site (Identifier)
#> 3782                                                                                                  Subject
#> 3783                                                                                                  [Visit]
#> 3784                                                                                             (Visit) Date
#> 3785                                                                         Respiratory Assessment Performed
#> 3786                                                                                                     Date
#> 3787                                                                                                     Time
#> 3788                                                                                [Planned Time Point Name]
#> 3789                                                                                  [Respiratory Test Name]
#> 3790                                                                        [Respiratory Test Category]; NULL
#> 3791                                                               [Respiratory Assessment Subcategory]; NULL
#> 3792                                                                                          [RETEST] Result
#> 3793                                                                                                     Unit
#> 3794                                                                                                 (Result)
#> 3795                                                                                      (Abnormal) Findings
#> 3796                                                                  [Specify Other/Explain/Specify Details]
#> 3797                                                                                 Normal Range Lower Limit
#> 3798                                                                                 Normal Range Upper Limit
#> 3799                                                          Comparison to [Reference/Expected/Normal] Range
#> 3800                                                                                                 Not Done
#> 3801                                        Reason Not [Answered/Collected/Done/Evaluated/Assessed/Available]
#> 3802                                                                                                 Position
#> 3803                                                                                      Anatomical Location
#> 3804                                                                                                     Side
#> 3805                                                                                           Directionality
#> 3806                                                                                                   Method
#> 3807                                                                                                Evaluator
#> 3808                                                                                     Evaluator Identifier
#> 3809                                                                                      Accepted Evaluation
#> 3810                                                                                        Repetition Number
#> 3811                                                                                   Clinically Significant
#> 3812                                                                                         [Protocol/Study]
#> 3813                                                                                        Site (Identifier)
#> 3814                                                                       [Subject/Participant] (Identifier)
#> 3815                                                                                                  [Visit]
#> 3816                                                                                             (Visit) Date
#> 3817                                                                     [Reproductive System Category]; NULL
#> 3818                                                                   Reproductive System Subcategory]; NULL
#> 3819                                                                 Reproductive System Evaluation Performed
#> 3820                                                                                          Reason Not Done
#> 3821                                                                         Any Reproductive System Findings
#> 3822                                                                                        [Sponsor defined]
#> 3823                                                                 [Reproductive System Findings Test Name]
#> 3824                                                                                                 (Result)
#> 3825                                                                                                     Unit
#> 3826                                                                                          Collection Date
#> 3827                                                                                         [Protocol/Study]
#> 3828                                                                                        Site (Identifier)
#> 3829                                                                       [Subject/Participant] (Identifier)
#> 3830                                                                                                  [Visit]
#> 3831                                                                                             (Visit) Date
#> 3832                                                [Disease Response/Clinical Classification Category]; NULL
#> 3833                                            [Disease Response/Clinical Classification Sub-Category]; NULL
#> 3834                                                    [Disease Response/Clinical Classification] Assessment
#> 3835                                                                 Reason Response Assessment Not Performed
#> 3836                                                                                                     Date
#> 3837                                                                                                Evaluator
#> 3838                                                                                     Evaluator Identifier
#> 3839                                                    [Disease Response or Clinical Classification ]Link ID
#> 3840                                                 [Disease Response or Clinical Classification ]Link Group
#> 3841                                                   [Disease Response / Clinical Classification Test Name]
#> 3842                                                                                                 (Result)
#> 3843                                                                                                     Unit
#> 3844                                                                                         [Protocol/Study]
#> 3845                                                                                        Site (Identifier)
#> 3846                                                                       [Subject/Participant] (Identifier)
#> 3847                                                                                                  [Visit]
#> 3848                                                                                             (Visit) Date
#> 3849                                                                [Subject Characteristics Category ]; NULL
#> 3850                                                              [Subject Characteristics Subcategory]; NULL
#> 3851                                                                        Subject Characteristics Collected
#> 3852                                                                                        [Sponsor defined]
#> 3853                                                                                                     Date
#> 3854                                                                       [Subject Characteristic Test Name]
#> 3855                                                                                                 (Result)
#> 3856                                                                                         [Protocol/Study]
#> 3857                                                                                        Site (Identifier)
#> 3858                                                                       [Subject/Participant] (Identifier)
#> 3859                                                                                                  [Visit]
#> 3860                                                                                             (Visit) Date
#> 3861                                                                           [Tumor/Lesion] [Link Group] ID
#> 3862                                                                  [Tumor/Lesion Result Category]; or NULL
#> 3863                                                               [Tumor/Lesion Result Subcategory]; or NULL
#> 3864                                                                                                 Not Done
#> 3865                                                                                          Reason Not Done
#> 3866                                                                                     [Evaluator/Reporter]
#> 3867                                                                                     Evaluator Identifier
#> 3868                                                                 [Tumor/Lesion] Assessment Procedure Date
#> 3869                                                                                       [Tumor/ Lesion] ID
#> 3870                                                                   [Tumor/Lesion] (Assessment) Test Name]
#> 3871                                                                                                 (Result)
#> 3872                                                                                                     Unit
#> 3873                                                                                              Vendor Name
#> 3874                                                                                         [Protocol/Study]
#> 3875                                                                                        Site (Identifier)
#> 3876                                                                       [Subject/Participant] (Identifier)
#> 3877                                                                                                  [Visit]
#> 3878                                                                                             (Visit) Date
#> 3879                                                         [Tumor/Lesion] Identification Category]; or NULL
#> 3880                                                       [Tumor/Lesion] Identification Subcategory; or NULL
#> 3881                                 Any ([Target/Non-target/New/Sponsor-defined) [Tumors/Lesions] Identified
#> 3882                                                             [Tumor/Lesion] Identification Procedure Date
#> 3883                                                                                     [Evaluator/Reporter]
#> 3884                                                                          [Evaluator/Reporter] Identifier
#> 3885                                                                                        [Tumor/Lesion] ID
#> 3886                                                                                     Procedure Identifier
#> 3887                                                                    Method of [Evaluation/Identification]
#> 3888                                                                              [Tumor/Lesion] Reference ID
#> 3889                                                                  [Tumor/Lesion Identification Test Name]
#> 3890                                                                                                 (Result)
#> 3891                                                                                      Anatomical Location
#> 3892                                                                       [Tumor/Lesion Identification] Side
#> 3893                                                             [Tumor/Lesion Identification] Directionality
#> 3894                                                            [Tumor/Lesion Identification] Location Detail
#> 3895                                                                [Tumor/Lesion Identification] Vendor Name
#> 3896                                                                                         [Protocol/Study]
#> 3897                                                                                        Site (Identifier)
#> 3898                                                                                                  Subject
#> 3899                                                                                                  [Visit]
#> 3900                                                                                             (Visit) Date
#> 3901                                                                             Urinary Assessment Performed
#> 3902                                                                                                     Date
#> 3903                                                                                                     Time
#> 3904                                                                                [Planned Time Point Name]
#> 3905                                                                                      [Urinary Test Name]
#> 3906                                                                            [Urinary Test Category]; NULL
#> 3907                                                                   [Urinary Assessment Subcategory]; NULL
#> 3908                                                                                          [URTEST] Result
#> 3909                                                                                                     Unit
#> 3910                                                                                                 (Result)
#> 3911                                                                                      (Abnormal) Findings
#> 3912                                                                  [Specify Other/Explain/Specify Details]
#> 3913                                                                                                 Not Done
#> 3914                                        Reason Not [Answered/Collected/Done/Evaluated/Assessed/Available]
#> 3915                                                                                      Anatomical Location
#> 3916                                                                                                     Side
#> 3917                                                                                           Directionality
#> 3918                                                                                                   Method
#> 3919                                                                                                Evaluator
#> 3920                                                                                     Evaluator Identifier
#> 3921                                                                                      Accepted Evaluation
#> 3922                                                                                        Repetition Number
#> 3923                                                                                   Clinically Significant
#> 3924                                                                                         [Protocol/Study]
#> 3925                                                                                        Site (Identifier)
#> 3926                                                                                                  Subject
#> 3927                                                                                                  [Visit]
#> 3928                                                                                             (Visit) Date
#> 3929                                                                                    Vital Signs Performed
#> 3930                                                                                                     Date
#> 3931                                                                                                     Time
#> 3932                                                                                        [Sponsor defined]
#> 3933                                                                                [Planned Time Point Name]
#> 3934                                                                             [Vital Signs Category]; NULL
#> 3935                                                                          [Vital Signs Subcategory]; NULL
#> 3936                                                                                        Repetition Number
#> 3937                                                                                  [Vital Signs Test Name]
#> 3938                                                                                                 Not Done
#> 3939                                                                                                 (Result)
#> 3940                                                                                                     Unit
#> 3941                                                                                   Clinically Significant
#> 3942                                                                                      Anatomical Location
#> 3943                                                                                                 Position
#> 3944                                                                                           Directionality
#> 3945                                                                                                     Side
#> 3946                                                                                         [Protocol/Study]
#> 3947                                                                                        Site (Identifier)
#> 3948                                                                       [Subject/Participant] (Identifier)
#> 3949                                                                                                  [Visit]
#> 3950                                                                                             (Visit) Date
#> 3951                                                                               [Sponsored-defined phrase]
#> 3952                                                                                      Any [Finding Topic]
#> 3953 ([FATEST/ topic] ([Measurement (s)/Test(s)/Examination(s)/Specimen(s)/Sample(s)]) [Performed/Collected]?
#> 3954                                                                                                     Date
#> 3955                                                                                                     Time
#> 3956                                                                   [Measurement/Test/Examination/] (Name)
#> 3957                                                             [Measurement/Test/Examination] Detail (Name)
#> 3958                                                                          [Category/Category Value]; NULL
#> 3959                                                              [FA Subcategory/FA Subcategory Value]; NULL
#> 3960                                                                                                 Position
#> 3961                                                                 ([Result/Amount] of) [value from FATEST]
#> 3962                                                                                                     Unit
#> 3963                                                                                 Normal Range Lower Limit
#> 3964                                                                                 Normal Range Upper Limit
#> 3965                                                          Comparison to [Reference/Expected/Normal] Range
#> 3966                                                                                                 Not Done
#> 3967                                        Reason Not [Answered/Collected/Done/Evaluated/Assessed/Available]
#> 3968                                                                                            Specimen Type
#> 3969                                                                                       Specimen Condition
#> 3970                                                                                      Anatomical Location
#> 3971                                                                                                     Side
#> 3972                                                                                           Directionality
#> 3973                                                                                      Portion or Totality
#> 3974                                                                                                   Method
#> 3975                                                                                                     Lead
#> 3976                                                                                                  Fasting
#> 3977                                                                                     [Evaluator/Reporter]
#> 3978                                                                          [Evaluator/Reporter] Identifier
#> 3979                                                 ([Measurement/Test/Examination/])/Clinically Significant
#> 3980                                                                                         [Protocol/Study]
#> 3981                                                                                        Site (Identifier)
#> 3982                                                                       [Subject/Participant] (Identifier)
#> 3983                                                                                                  [Visit]
#> 3984                                                                                             (Visit) Date
#> 3985                                                                             Skin Response Test Performed
#> 3986                                                                                          Reason Not Done
#> 3987                                                                           [Skin Response Category]; NULL
#> 3988                                                                        [Skin Response Subcategory]; NULL
#> 3989                                                                                        [Sponsor defined]
#> 3990                                                                                 [Intervention] Performed
#> 3991                                                                       [Intervention] Administration Date
#> 3992                                                                       [Intervention] Administration Time
#> 3993                                                                                      Anatomical Location
#> 3994                                                                                                     Side
#> 3995                                                                                [Skin Response Test Name]
#> 3996                                                                                [Planned Time Point Name]
#> 3997                                                                                                     Date
#> 3998                                                                                                     Time
#> 3999                                                                                           Directionality
#> 4000                                                                                     [Evaluator/Reporter]
#> 4001                                                                          [Evaluator/Reporter] Identifier
#> 4002                                                                                                 (Result)
#> 4003                                                                                                     Unit
#> 4004                                                          Comparison to [Reference/Expected/Normal] Range
#> 4005                                                                                   Clinically Significant
#> 4006                                                                                         [Protocol/Study]
#> 4007                                                                                        Site (Identifier)
#> 4008                                                                       [Subject/Participant] (Identifier)
#> 4009                                        [Abbreviated version of the protocol-specified targeted question]
#> 4010                                                                                         [Protocol/Study]
#> 4011                                                                                        Site (Identifier)
#> 4012                                                                       [Subject/Participant] (Identifier)
#> 4013                                                                                   [Disposition Category]
#> 4014                                                                          [Disposition Subcategory]; NULL
#> 4015                                                                                             Trial Period
#> 4016                                                                                        [Sponsor-defined]
#> 4017                                                                                        [Sponsor-defined]
#> 4018                                                       [Protocol Milestone/Other Event Name] (start) Date
#> 4019                                                       [Protocol Milestone/Other Event Name] (start) Time
#> 4020                                                                                                Unblinded
#> 4021                                                                                         [Protocol/Study]
#> 4022                                                                                        Site (Identifier)
#> 4023                                                                       [Subject/Participant] (Identifier)
#> 4024                                                                                   [Disposition Category]
#> 4025                                                                          [Disposition Subcategory]; NULL
#> 4026                                                                                             Trial Period
#> 4027                                                          Status (at the EPOCH/study specific time frame)
#> 4028                                                                                      [Status]; [Specify]
#> 4029                                                                                   Disposition Event Date
#> 4030                                                                                   Disposition Event Time
#> 4031                                                                                               Death Date
#> 4032                                                                                         Subject Continue
#> 4033                                                                          Next [Epoch/Period/Study/Trial]
#> 4034                                                                Serious adverse event/reaction start time
#> 4035                                                                 Serious adverse event/reaction end time.
#> 4036                                                                                       Dechallenge Result
#> 4037                                                                                       Rechallenge Result
#> 4038                                                                                                Narrative
#> 4039                                                                                     Causality assessment
#> 4040                                                                                   Adverse event assessed
#> 4041                                                                              Causality assessment source
#> 4042                                                                              Causality assessment method
#> 4043                                                                                 Investigator Middle Name
#> 4044                                                                                            Site Postcode
#> 4045                                                                                   Site State or Province
#> 4046                                                                                                Site City
#> 4047                                                                                      Site Street Address
#> 4048                                                                                    Site Telephone Number
#> 4049                                                                                          Site Fax Number
#> 4050                                                                                   Sponsor Awareness Date
#> 4051                                                                                       Investigator Title
#> 4052                                                                               Investigator Email Address
#> 4053                                                                                          Report Category
#> 4054                                                                                 Gestational Onset Period
#> 4055                                                                                  Gestational Period Unit
#> 4056                                                                                         [Protocol/Study]
#> 4057                                                                                        Site (Identifier)
#> 4058                                                                       [Subject/Participant] (Identifier)
#> 4059                                                                                                  [Visit]
#> 4060                                                                                             (Visit) Date
#> 4061                                                                                    Test Group Identifier
#> 4062                                                                                       [DATEST] Collected
#> 4063                                                                                           Treatment Type
#> 4064                                                                        [DATEST] [Treatment/Product] Name
#> 4065                                                                                [DSTEST] Label Identifier
#> 4066                                                                                            [DATEST] Date
#> 4067                                                                                          [DATEST] Amount
#> 4068                                                                                            [DATEST] Unit
#> 4069                                                                                         [Protocol/Study]
#> 4070                                                                                        Site (Identifier)
#> 4071                                                                       [Subject/Participant] (Identifier)
#> 4072                                                                                                  [Visit]
#> 4073                                                                                             (Visit) Date
#> 4074                                                                             Any Death Detail Assessments
#> 4075                                                                 [Death Detail Assessment Category]; NULL
#> 4076                                                              [Death Detail Assessment Subcategory]; NULL
#> 4077                                                                                             [DTHDX] Date
#> 4078                                                                                               Death Date
#> 4079                                                                                                   Result
#> 4080                                                                                     [Evaluator/Reporter]
#> 4081                                                                                         [Protocol/Study]
#> 4082                                                                                        Site (Identifier)
#> 4083                                                                       [Subject/Participant] (Identifier)
#> 4084                                                                                                  [Visit]
#> 4085                                                                                             (Visit) Date
#> 4086                                                                                     [ECG Category]; NULL
#> 4087                                                                                  [ECG Subcategory]; NULL
#> 4088                                                                                            ECG Performed
#> 4089                                                                                        Repetition number
#> 4090                                                            (ECG) [Reference Identifier/Accession Number]
#> 4091                                                                                                   Method
#> 4092                                                                                            Lead Location
#> 4093                                                                                                 Position
#> 4094                                                                                                 ECG Date
#> 4095                                                                                [Planned Time Point Name]
#> 4096                                                                                                 ECG Time
#> 4097                                                                                         [Protocol/Study]
#> 4098                                                                                        Site (Identifier)
#> 4099                                                                       [Subject/Participant] (Identifier)
#> 4100                                                                                                  [Visit]
#> 4101                                                                                             (Visit) Date
#> 4102                                                                                     [ECG Category]; NULL
#> 4103                                                                                  [ECG Subcategory]; NULL
#> 4104                                                                                            ECG Performed
#> 4105                                                                                        Repetition Number
#> 4106                                                                                                   Method
#> 4107                                                                                            Lead Location
#> 4108                                                                                                 Position
#> 4109                                                                                                 ECG Date
#> 4110                                                                                [Planned Time Point Name]
#> 4111                                                                                                 ECG Time
#> 4112                                                                                          [ECG Test Name]
#> 4113                                                                                                 (Result)
#> 4114                                                                                                     Unit
#> 4115                                                                                   Clinically Significant
#> 4116                                                                                         [Protocol/Study]
#> 4117                                                                                        Site (Identifier)
#> 4118                                                                       [Subject/Participant] (Identifier)
#> 4119                                                                                                  [Visit]
#> 4120                                                                                             (Visit) Date
#> 4121                                                                                     [ECG Category]; NULL
#> 4122                                                                                  [ECG Subcategory]; NULL
#> 4123                                                                                            ECG Performed
#> 4124                                                                                        Repetition Number
#> 4125                                                            (ECG) [Reference Identifier/Accession Number]
#> 4126                                                                                                   Method
#> 4127                                                                                            Lead Location
#> 4128                                                                                                 Position
#> 4129                                                                                                 ECG Date
#> 4130                                                                                [Planned Time Point Name]
#> 4131                                                                                                 ECG Time
#> 4132                                                                                     [Evaluator/Reporter]
#> 4133                                                                                           Interpretation
#> 4134                                                                                   Clinically Significant
#> 4135                                                                         Medical History Event Identifier
#> 4136                                                                                 Adverse Event Identifier
#> 4137                                                                                         [Protocol/Study]
#> 4138                                                                                        Site (Identifier)
#> 4139                                                                       [Subject/Participant] (Identifier)
#> 4140                                                                                                  [Visit]
#> 4141                                                                                             (Visit) Date
#> 4142                                                                                 [Genomic Category]; NULL
#> 4143                                                                              [Genomic Subcategory]; NULL
#> 4144                                                               Genomic Test Performed; Specimen Collected
#> 4145                                               (Genomic specimen) [Reference identifier/Accession Number]
#> 4146                                                                                [Planned Time Point Name]
#> 4147                                                                 Genomic Specimen Collection (Start) Date
#> 4148                                                                 Genomic Specimen Collection (Start) Time
#> 4149                                                                                         [Protocol/Study]
#> 4150                                                                                        Site (Identifier)
#> 4151                                                                       [Subject/Participant] (Identifier)
#> 4152                                                                                                  [Visit]
#> 4153                                                                                             (Visit) Date
#> 4154                                                                                 [Genomic Category]; NULL
#> 4155                                                                              [Genomic Subcategory]; NULL
#> 4156                                                               Genomic Test Performed; Specimen Collected
#> 4157                                                                                          Laboratory Name
#> 4158                                                                                      [Genomic Test Name]
#> 4159                                                                               [Genomic Test Name Detail]
#> 4160                                                                                 Method of [Genomic Test]
#> 4161                                                                                [Planned Time Point Name]
#> 4162                                                                 Genomic Specimen Collection (Start) Date
#> 4163                                                                 Genomic Specimen Collection (Start) Time
#> 4164                                                                                                 (Result)
#> 4165                                                                                                     Unit
#> 4166                                                                                         [Protocol/Study]
#> 4167                                                                                        Site (Identifier)
#> 4168                                                                       [Subject/Participant] (Identifier)
#> 4169                                                                                                  [Visit]
#> 4170                                                                                             (Visit) Date
#> 4171                                                                          Lab Performed; Sample Collected
#> 4172                                                                         Specimen Collection (Start) Date
#> 4173                                                                         Specimen Collection (Start) Time
#> 4174                                                                                   [Lab Panel Name]; NULL
#> 4175                                                                               [Lab Sub-Panel Name]; NULL
#> 4176                                                                                            Specimen Type
#> 4177                                                                                [Planned Time Point Name]
#> 4178                                                                                       Test Condition Met
#> 4179                                                                                                  Fasting
#> 4180                                                     (Laboratory) [Reference identifier/Accession Number]
#> 4181                                                                                         [Protocol/Study]
#> 4182                                                                                        Site (Identifier)
#> 4183                                                                       [Subject/Participant] (Identifier)
#> 4184                                                                                                  [Visit]
#> 4185                                                                                             (Visit) Date
#> 4186                                                                          Lab Performed; Sample Collected
#> 4187                                                                         Specimen Collection (Start) Date
#> 4188                                                                         Specimen Collection (Start) Time
#> 4189                                                                                   [Lab Panel Name]; NULL
#> 4190                                                                               [Lab Sub-Panel Name]; NULL
#> 4191                                                                                            Specimen Type
#> 4192                                                                                [Planned Time Point Name]
#> 4193                                                                                       Test Condition Met
#> 4194                                                                                                  Fasting
#> 4195                                                                                   [Laboratory Test Name]
#> 4196                                                                                                 (Result)
#> 4197                                                                                                     Unit
#> 4198                                                                                   Clinically Significant
#> 4199                                                (Laboratory test) [Reference identifier/Accession Number]
#> 4200                                                                            Method of Test or Examination
#> 4201                                                                                         [Protocol/Study]
#> 4202                                                                                        Site (Identifier)
#> 4203                                                                       [Subject/Participant] (Identifier)
#> 4204                                                                                                  [Visit]
#> 4205                                                                                             (Visit) Date
#> 4206                                                                          Sample Collected; Lab Performed
#> 4207                                                                         Specimen Collection (Start) Date
#> 4208                                                                         Specimen Collection (Start) Time
#> 4209                                                                                   [Lab Panel Name]; NULL
#> 4210                                                                               [Lab Sub-Panel Name]; NULL
#> 4211                                                                                            Specimen Type
#> 4212                                                                                [Planned Time Point Name]
#> 4213                                                                                                  Fasting
#> 4214                                                                                       Test Condition Met
#> 4215                                                                                       Specimen Condition
#> 4216                                                                                   [Laboratory Test Name]
#> 4217                                                                                                 (Result)
#> 4218                                                                             Method of [Test/Examination]
#> 4219                                                                                                     Unit
#> 4220                                                                                                     Unit
#> 4221                                                                                           Toxicity Grade
#> 4222                                                                                                 Toxicity
#> 4223                                                                                 Normal Range Lower Limit
#> 4224                                                                                 Normal Range Upper Limit
#> 4225                                                          Comparison to [Reference/Expected/Normal] Range
#> 4226                                                                                   Clinically Significant
#> 4227                                                                                          Laboratory Name
#> 4228                                                                                         [Protocol/Study]
#> 4229                                                                                        Site (Identifier)
#> 4230                                                                       [Subject/Participant] (Identifier)
#> 4231                                                                                                  [Visit]
#> 4232                                                                                             (Visit) Date
#> 4233                                 [Microbiology Test] Performed; [Microbiology Specimen/Sample] Collected;
#> 4234                                              (Microbiology Test) [Reference Identifier/Accession Number]
#> 4235                                                            [Test/Procedure/Observation] Group Identifier
#> 4236                                                                         Specimen Collection (Start) Date
#> 4237                                                                         Specimen Collection (Start) Time
#> 4238                                                                            [Microbiology Category]; NULL
#> 4239                                                                         [Microbiology Subcategory]; NULL
#> 4240                                                                                            Specimen Type
#> 4241                                                                                       Specimen Condition
#> 4242                                                                                      Anatomical Location
#> 4243                                                                                                     Side
#> 4244                                                                                           Directionality
#> 4245                                                                                         [Protocol/Study]
#> 4246                                                                                        Site (Identifier)
#> 4247                                                                       [Subject/Participant] (Identifier)
#> 4248                                                                                                  [Visit]
#> 4249                                                                                             (Visit) Date
#> 4250                                 [Microbiology Test] Performed; [Microbiology Specimen/Sample] Collected;
#> 4251                                              (Microbiology Test) [Reference identifier/Accession Number]
#> 4252                                                                                        [Sponsor defined]
#> 4253                                                            [Test/Procedure/Observation] Group Identifier
#> 4254                                                                     [Domain/Observation] Link Identifier
#> 4255                                                                         Specimen Collection (Start) Date
#> 4256                                                                         Specimen Collection (Start) Time
#> 4257                                                                            [Microbiology Category]; NULL
#> 4258                                                                         [Microbiology Subcategory]; NULL
#> 4259                                                                                 [Microbiology Test Name]
#> 4260                                                                                [Examination Name Detail]
#> 4261                                                                                                 (Result)
#> 4262                                                                                                     Unit
#> 4263                                                                                   Clinically Significant
#> 4264                                                                                          Result Category
#> 4265                                                                                              Vendor Name
#> 4266                                                                                            Specimen Type
#> 4267                                                                                       Specimen Condition
#> 4268                                                                                      Anatomical Location
#> 4269                                                                                                     Side
#> 4270                                                                                           Directionality
#> 4271                                                                                                   Method
#> 4272                                                                                     [Evaluator/Reporter]
#> 4273                                                                                         [Protocol/Study]
#> 4274                                                                                        Site (Identifier)
#> 4275                                                                       [Subject/Participant] (Identifier)
#> 4276                                                                                                  [Visit]
#> 4277                                                                                             (Visit) Date
#> 4278                                                      Microscopic Examination Performed; Sample Collected
#> 4279                                               (Microscopic test) [Reference Identifier/Accession Number]
#> 4280                                                                         Specimen Collection (Start) Date
#> 4281                                                                         Specimen Collection (Start) Time
#> 4282                                                                             [Microscopic Category]; NULL
#> 4283                                                                          [Microscopic Subcategory]; NULL
#> 4284                                                                                            Specimen Type
#> 4285                                                                                       Specimen Condition
#> 4286                                                                                      Anatomical Location
#> 4287                                                                                                     Side
#> 4288                                                                                           Directionality
#> 4289                                                                                         [Protocol/Study]
#> 4290                                                                                        Site (Identifier)
#> 4291                                                                       [Subject/Participant] (Identifier)
#> 4292                                                                                                  [Visit]
#> 4293                                                                                             (Visit) Date
#> 4294                                                      Microscopic Examination Performed; Sample Collected
#> 4295                                               (Microscopic test) [Reference identifier/Accession Number]
#> 4296                                                                                        [Sponsor defined]
#> 4297                                                                         Specimen Collection (Start) Date
#> 4298                                                                         Specimen Collection (Start) Time
#> 4299                                                                             [Microscopic Category]; NULL
#> 4300                                                                          [Microscopic Subcategory]; NULL
#> 4301                                                          [Microscopic Measurement/Test/Examination Name]
#> 4302                                                                                [Examination Name Detail]
#> 4303                                                                                                 (Result)
#> 4304                                                                                                     Unit
#> 4305                                                                                   Clinically Significant
#> 4306                                                                                          Result Category
#> 4307                                                                                              Vendor Name
#> 4308                                                                                            Specimen Type
#> 4309                                                                                       Specimen Condition
#> 4310                                                                                      Anatomical Location
#> 4311                                                                                                     Side
#> 4312                                                                                           Directionality
#> 4313                                                                                                   Method
#> 4314                                                                                     [Evaluator/Reporter]
#> 4315                                                                                         [Protocol/Study]
#> 4316                                                                                        Site (Identifier)
#> 4317                                                                       [Subject/Participant] (Identifier)
#> 4318                                                                                                  [Visit]
#> 4319                                                                                             (Visit) Date
#> 4320   [Microbiology Susceptibility Test] Performed; [Microbiology Susceptibility Specimen/Sample] Collected;
#> 4321                               (Microbiology Susceptibility Test) [Reference Identifier/Accession Number]
#> 4322                                                                         Specimen Collection (Start) Date
#> 4323                                                                         Specimen Collection (Start) Time
#> 4324                                                             [Microbiology Susceptibility Category]; NULL
#> 4325                                                          [Microbiology Susceptibility Subcategory]; NULL
#> 4326                                                                                            Specimen Type
#> 4327                                                                                       Specimen Condition
#> 4328                                                                                      Anatomical Location
#> 4329                                                                                                     Side
#> 4330                                                                                           Directionality
#> 4331                                                                                         [Protocol/Study]
#> 4332                                                                                        Site (Identifier)
#> 4333                                                                       [Subject/Participant] (Identifier)
#> 4334                                                                                     Non-host Organism ID
#> 4335                                                                                                  [Visit]
#> 4336                                                                                             (Visit) Date
#> 4337   [Microbiology Susceptibility Test] Performed; [Microbiology Susceptibility Specimen/Sample] Collected;
#> 4338                               (Microbiology Susceptibility test) [Reference identifier/Accession Number]
#> 4339                                                                                        [Sponsor defined]
#> 4340                                                            [Test/Procedure/Observation] Group Identifier
#> 4341                                                                     [Domain/Observation] Link Identifier
#> 4342                                                                         Specimen Collection (Start) Date
#> 4343                                                                         Specimen Collection (Start) Time
#> 4344                                                             [Microbiology Susceptibility Category]; NULL
#> 4345                                                          [Microbiology Susceptibility Subcategory]; NULL
#> 4346                                                                  [Microbiology Susceptibility Test Name]
#> 4347                                                                                              Test Detail
#> 4348                                                                        Microbiology Susceptibility Agent
#> 4349                                                                                      Agent Concentration
#> 4350                                                                                 Agent Concentration Unit
#> 4351                                                                                                 (Result)
#> 4352                                                                                                     Unit
#> 4353                                                                                   Clinically Significant
#> 4354                                                                                          Result Category
#> 4355                                                                                              Vendor Name
#> 4356                                                                                            Specimen Type
#> 4357                                                                                       Specimen Condition
#> 4358                                                                                      Anatomical Location
#> 4359                                                                                                     Side
#> 4360                                                                                           Directionality
#> 4361                                                                                                   Method
#> 4362                                                                                     [Evaluator/Reporter]
#> 4363                                                                                         [Protocol/Study]
#> 4364                                                                                        Site (Identifier)
#> 4365                                                                       [Subject/Participant] (Identifier)
#> 4366                                                                                                  [Visit]
#> 4367                                                                                             (Visit) Date
#> 4368                                                                                                Collected
#> 4369                                                                                                 Not Done
#> 4370                                                                                     Reason Not Collected
#> 4371                                                                                          Collection Date
#> 4372                                                   Same as Previous (Specimen/Sample Collection End) Date
#> 4373                                                                                          Collection Time
#> 4374                                                                                [Planned Time Point Name]
#> 4375                                                                                                  Fasting
#> 4376                                                                                       Test Condition Met
#> 4377                                                             (PK) [Reference Identifier/Accession Number]
#> 4378                                                                                          [Specimen Type]
#> 4379                                                                                              [Test Name]
#> 4380                                                                                                 (Result)
#> 4381                                                                                                     Unit
#> 4382                                                                                         [Protocol/Study]
#> 4383                                                                                        Site (Identifier)
#> 4384                                                                                                  Subject
#> 4385                                                                                                  [Visit]
#> 4386                                                                                             (Visit) Date
#> 4387                                                                                                Collected
#> 4388                                                                                     Reason Not Collected
#> 4389                                                                                          Collection Date
#> 4390                                                                                    Collection Start Time
#> 4391                                                                                    (Collection) End Date
#> 4392                                                                                    (Collection) End Time
#> 4393                                                                                [Planned Time Point Name]
#> 4394                                                                                                  Fasting
#> 4395                                                                                       Test Condition Met
#> 4396                                                             (PK) [Reference Identifier/Accession Number]
#> 4397                                                                                            Specimen Type
#> 4398                                                                                              [Test Name]
#> 4399                                                                                                 (Result)
#> 4400                                                                                                     Unit
#> 4401                                                                                         [Protocol/Study]
#> 4402                                                                                        Site (Identifier)
#> 4403                                                                       [Subject/Participant] (Identifier)
#> 4404                                                                                                  [Visit]
#> 4405                                                                                             (Visit) Date
#> 4406                                                                                  Physical Exam Performed
#> 4407                                                                                      [PE Category]; NULL
#> 4408                                                                                   [PE Subcategory]; NULL
#> 4409                                                                                                Exam Date
#> 4410                                                                                                Exam Time
#> 4411                                                                                        [Sponsor defined]
#> 4412                                                                                            [Body System]
#> 4413                                                                                                 (Result)
#> 4414                                                                                        Abnormal Findings
#> 4415                                                                                   Clinically Significant
#> 4416                                                                                     [Evaluator/Reporter]
#> 4417                                                                                          Reason Not Done
#> 4418                                                                               [Body System/Organ System]
#> 4419                                                                                                     <NA>
#> 4420                                                                                      Anatomical Location
#> 4421                                                                                                     Side
#> 4422                                                                                           Directionality
#> 4423                                                                                      Portion or Totality
#> 4424                                                                                                   Method
#> 4425                                                                                         [Protocol/Study]
#> 4426                                                                                        Site (Identifier)
#> 4427                                                                       [Subject/Participant] (Identifier)
#> 4428                                                                                                  [Visit]
#> 4429                                                                                             (Visit) Date
#> 4430                                                                 [Subject Characteristics Category]; NULL
#> 4431                                                              [Subject Characteristics Subcategory]; NULL
#> 4432                                                                                       [SCTEST] Collected
#> 4433                                                                                            Test Group ID
#> 4434                                                                                          [SCTEST] Result
#> 4435                                                                                         [Protocol/Study]
#> 4436                                                                                        Site (Identifier)
#> 4437                                                                       [Subject/Participant] (Identifier)
#> 4438                                                                                                  [Visit]
#> 4439                                                                                             (Visit) Date
#> 4440                                                               Vital Signs Performed ; [VSTEST] Performed
#> 4441                                                                                            [VSTEST] Date
#> 4442                                                                                            [VSTEST] Time
#> 4443                                                                             [Vital Signs Category]; NULL
#> 4444                                                                          [Vital Signs Subcategory]; NULL
#> 4445                                                                                            Test Group ID
#> 4446                                                                                [Planned Time Point Name]
#> 4447                                                                                                 Not Done
#> 4448                                                                                        [VSTEST] (Result)
#> 4449                                                                                            [VSTEST] Unit
#> 4450                                                                          [VSTEST] Clinically Significant
#> 4451                                                                                        [VSTEST] Position
#> 4452                                                                             [VSTEST] Anatomical Location
#> 4453                                                                                                     Side
#> 4454                                                                                         [Protocol/Study]
#> 4455                                                                                        Site (Identifier)
#> 4456                                                                       [Subject/Participant] (Identifier)
#> 4457                                                                                                Birth Day
#> 4458                                                                                              Birth Month
#> 4459                                                                                               Birth Year
#> 4460                                                                                               Birth Time
#> 4461                                                                                                      Age
#> 4462                                                                                                 Age Unit
#> 4463                                                                                          Collection Date
#> 4464                                                                                                      Sex
#> 4465                                                                                                Ethnicity
#> 4466                                                                                                Ethnicity
#> 4467                                                                                                     Race
#> 4468                                                                                                     Race
#> 4469                                                                                       Specify Other Race
#> 4470                                                                                         [Protocol/Study]
#> 4471                                                                                        Site (Identifier)
#> 4472                                                                       [Subject/Participant] (Identifier)
#> 4473                                                                                               Birth Date
#> 4474                                                                                               Birth Time
#> 4475                                                                                                      Age
#> 4476                                                                                                 Age Unit
#> 4477                                                                                          Collection Date
#> 4478                                                                                                      Sex
#> 4479                                                                                                Ethnicity
#> 4480                                                                                                Ethnicity
#> 4481                                                                                                     Race
#> 4482                                                                                                     Race
#> 4483                                                                                       Specify Other Race
#>      type core                                     sdtmig_target
#> 3231 Char   HR                                           STUDYID
#> 3232 Char   HR                                            SITEID
#> 3233 Char   HR                                            SUBJID
#> 3234 Char    O                                             AGCAT
#> 3235 Char    O                                            AGSCAT
#> 3236 Char    O                                              <NA>
#> 3237 Char    O                                            AGSPID
#> 3238 Char   HR                                             AGTRT
#> 3239 Char    O                                           AGPRESP
#> 3240 Char    O                                           AGOCCUR
#> 3241  Num    O                                            AGDOSE
#> 3242 Char    O                                  AGDOSE; AGDOSTXT
#> 3243 Char  R/C                                            AGDOSU
#> 3244 Char    O                                          AGDOSFRM
#> 3245 Char    O                                          AGDOSFRQ
#> 3246 Char  R/C                                           AGROUTE
#> 3247 Char  R/C                                           AGSTDTC
#> 3248 Char  R/C                                           AGSTDTC
#> 3249 Char    O                                  AGSTRF; AGSTRTPT
#> 3250 Char  R/C                                  AGENRF; AGENRTPT
#> 3251 Char  R/C                                           AGENDTC
#> 3252 Char  R/C                                           AGENDTC
#> 3253 Char    O                                           AGDECOD
#> 3254 Char    O                                            AGCLAS
#> 3255  Num    O                                          AGCLASCD
#> 3256 Char   HR                                           STUDYID
#> 3257 Char   HR                                            SITEID
#> 3258 Char   HR                                            SUBJID
#> 3259 Char    O                                             CMCAT
#> 3260 Char    O                                            CMSCAT
#> 3261 Char    O                                              <NA>
#> 3262 Char    O                                            CMSPID
#> 3263 Char   HR                                             CMTRT
#> 3264 Char    O                                           CMPRESP
#> 3265 Char    O                                           CMOCCUR
#> 3266 Char    O                                              <NA>
#> 3267 Char  R/C                                            CMINDC
#> 3268 Char    O                                              <NA>
#> 3269 Char    O                                              <NA>
#> 3270  Num    O                                            CMDOSE
#> 3271 Char    O                                  CMDOSTXT; CMDOSE
#> 3272  Num    O                                          CMDOSTOT
#> 3273 Char  R/C                                            CMDOSU
#> 3274 Char    O                                          CMDOSFRM
#> 3275 Char    O                                          CMDOSFRQ
#> 3276 Char  R/C                                           CMROUTE
#> 3277 Char  R/C                                           CMSTDTC
#> 3278 Char  R/C                                           CMSTDTC
#> 3279 Char    O                                  CMSTRF; CMSTRTPT
#> 3280 Char  R/C                                  CMENRF; CMENRTPT
#> 3281 Char  R/C                                           CMENDTC
#> 3282 Char  R/C                                           CMENDTC
#> 3283 Char    O                                          CMRSDISC
#> 3284 Char    O                                           CMDECOD
#> 3285 Char    O                                            CMCLAS
#> 3286  Num    O                                          CMCLASCD
#> 3287 Char    O                                              QVAL
#> 3288  Num    O                                              QVAL
#> 3289 Char    O                                              QVAL
#> 3290  Num    O                                              QVAL
#> 3291 Char    O                                              QVAL
#> 3292  Num    O                                              QVAL
#> 3293 Char    O                                              QVAL
#> 3294  Num    O                                              QVAL
#> 3295 Char    O                                              QVAL
#> 3296  Num    O                                              QVAL
#> 3297 Char   HR                                           STUDYID
#> 3298 Char   HR                                            SITEID
#> 3299 Char   HR                                            SUBJID
#> 3300 Char  R/C                                             EPOCH
#> 3301 Char    O                                              <NA>
#> 3302 Char    O                                             ECCAT
#> 3303 Char    O                                            ECSCAT
#> 3304 Char  R/C                                             ECTRT
#> 3305 Char    O                                           ECPRESP
#> 3306 Char    O                                           ECOCCUR
#> 3307 Char    O                                              QVAL
#> 3308 Char    O                                            ECMOOD
#> 3309 Char    O                                           ECREFID
#> 3310 Char  R/C                                             ECLOT
#> 3311 Char    O                                            ECFAST
#> 3312 Char  R/C                                          ECDOSFRM
#> 3313 Char   HR                                           ECSTDTC
#> 3314 Char  R/C                                           ECSTDTC
#> 3315 Char  R/C                                           ECENDTC
#> 3316 Char  R/C                                           ECENDTC
#> 3317 Char  R/C                                  ECDOSTXT; ECDOSE
#> 3318 Char  R/C                                            ECDOSU
#> 3319 Char  R/C                                          ECDOSFRQ
#> 3320 Char  R/C                                           ECROUTE
#> 3321 Char    O                                          ECDOSRGM
#> 3322 Char    O                                              <NA>
#> 3323 Char    O                                             ECADJ
#> 3324 Char    O                                              <NA>
#> 3325 Char    O                                              QVAL
#> 3326 Char    O                                              QVAL
#> 3327 Char    O                                             ECLOC
#> 3328 Char    O                                             ECLAT
#> 3329 Char    O                                             ECDIR
#> 3330  Num    O                                              <NA>
#> 3331 Char    O                                              <NA>
#> 3332  Num    O                                              QVAL
#> 3333 Char    O                                              QVAL
#> 3334 Char  R/C                                             ECTPT
#> 3335 Char    O                                              QVAL
#> 3336 Char   HR                                           STUDYID
#> 3337 Char   HR                                            SITEID
#> 3338 Char   HR                                            SUBJID
#> 3339 Char  R/C                                             EPOCH
#> 3340 Char    O                                              <NA>
#> 3341 Char    O                                             EXCAT
#> 3342 Char    O                                            EXSCAT
#> 3343 Char  R/C                                             EXTRT
#> 3344 Char  R/C                                           EXREFID
#> 3345 Char  R/C                                             EXLOT
#> 3346 Char    O                                            EXFAST
#> 3347 Char  R/C                                          EXDOSFRM
#> 3348 Char   HR                                           EXSTDTC
#> 3349 Char  R/C                                           EXSTDTC
#> 3350 Char  R/C                                           EXENDTC
#> 3351 Char  R/C                                           EXENDTC
#> 3352 Char  R/C                                  EXDOSTXT; EXDOSE
#> 3353 Char  R/C                                            EXDOSU
#> 3354 Char  R/C                                          EXDOSFRQ
#> 3355 Char  R/C                                           EXROUTE
#> 3356 Char    O                                          EXDOSRGM
#> 3357 Char    O                                              <NA>
#> 3358 Char    O                                             EXADJ
#> 3359 Char    O                                              <NA>
#> 3360 Char    O                                              QVAL
#> 3361 Char    O                                              QVAL
#> 3362 Char    O                                             EXLOC
#> 3363  Num    O                                              <NA>
#> 3364 Char    O                                              <NA>
#> 3365  Num    O                                              QVAL
#> 3366 Char    O                                              QVAL
#> 3367 Char  R/C                                             EXTPT
#> 3368 Char    O                                              QVAL
#> 3369 Char    O                                             EXLAT
#> 3370 Char    O                                             EXDIR
#> 3371 Char   HR                                           STUDYID
#> 3372 Char   HR                                            SITEID
#> 3373 Char   HR                                            SUBJID
#> 3374 Char    O                                             MLCAT
#> 3375 Char    O                                            MLSCAT
#> 3376 Char    O                                              <NA>
#> 3377 Char    O                                            MLSPID
#> 3378 Char   HR                                             MLTRT
#> 3379 Char    O                                           MLPRESP
#> 3380 Char    O                                           MLOCCUR
#> 3381 Char    O                                              QVAL
#> 3382 Char    O                                              QVAL
#> 3383 Char    O                                              <NA>
#> 3384  Num    O                                            MLDOSE
#> 3385 Char    O                                  MLDOSTXT; MLDOSE
#> 3386 Char  R/C                                            MLDOSU
#> 3387 Char  R/C                                           MLSTDTC
#> 3388 Char  R/C                                           MLSTDTC
#> 3389 Char  R/C                                           MLENDTC
#> 3390 Char  R/C                                           MLENDTC
#> 3391 Char    O                                              <NA>
#> 3392 Char    O                                              <NA>
#> 3393 Char   HR                                           STUDYID
#> 3394 Char   HR                                            SITEID
#> 3395 Char   HR                                            SUBJID
#> 3396 Char    O                                              <NA>
#> 3397 Char    O                                             PRCAT
#> 3398 Char    O                                            PRSCAT
#> 3399 Char    O                                            PRSPID
#> 3400 Char   HR                                             PRTRT
#> 3401 Char    O                                           PRDECOD
#> 3402 Char    O                                              <NA>
#> 3403 Char    O                                           PRPRESP
#> 3404 Char    O                                           PROCCUR
#> 3405 Char    O                                              <NA>
#> 3406 Char    O                                              <NA>
#> 3407 Char    O                                          PRSTRTPT
#> 3408 Char  R/C                                           PRSTDTC
#> 3409 Char    O                                          PRENRTPT
#> 3410 Char  R/C                                           PRENDTC
#> 3411 Char    O                                            PRINDC
#> 3412 Char    O                                              <NA>
#> 3413 Char    O                                              <NA>
#> 3414 Char    O                                  PRDOSE; PRDOSTXT
#> 3415 Char    O                                            PRDOSU
#> 3416 Char    O                                          PRDOSFRQ
#> 3417 Char    O                                           PRROUTE
#> 3418 Char    O                                             PRLOC
#> 3419 Char    O                                             PRLAT
#> 3420 Char    O                                             PRDIR
#> 3421 Char    O                                          PRPORTOT
#> 3422 Char    O                                              <NA>
#> 3423 Char    O                                          PRDOSRGM
#> 3424 Char    O                                              <NA>
#> 3425 Char    O                                              <NA>
#> 3426 Char    O                                              QVAL
#> 3427 Char    O                                              <NA>
#> 3428 Char    O                                              QVAL
#> 3429 Char    O                                              QVAL
#> 3430 Char    O                                              QVAL
#> 3431 Char    O                                              QVAL
#> 3432  Num    O                                              QVAL
#> 3433  Num    O                                              QVAL
#> 3434 Char    O                                              QVAL
#> 3435  Num    O                                              QVAL
#> 3436 Char    O                                              QVAL
#> 3437  Num    O                                              QVAL
#> 3438 Char    O                                              QVAL
#> 3439  Num    O                                              QVAL
#> 3440 Char   HR                                           STUDYID
#> 3441 Char   HR                                            SITEID
#> 3442 Char   HR                                            SUBJID
#> 3443 Char   HR                                             SUTRT
#> 3444 Char  R/C                                             SUCAT
#> 3445 Char    O                                            SUSCAT
#> 3446 Char    O                                           SUPRESP
#> 3447 Char    O                                              <NA>
#> 3448 Char  R/C SUOCCUR; SUSTRTPT; SUSTRF; SUENRTPT; SUENRF; QVAL
#> 3449 Char    O                                            SUSPID
#> 3450 Char    O                                          SUREASND
#> 3451 Char    O                          SUDOSE; SUDOSU; SUDOSTXT
#> 3452 Char    O                                          SUDOSFRQ
#> 3453 Char    O                                           SUSTDTC
#> 3454 Char    O                                           SUENDTC
#> 3455 Char    O                                             SUDUR
#> 3456 Char    O                                             SUDUR
#> 3457 Char    O                                          SUMODIFY
#> 3458 Char    O                                           SUDECOD
#> 3459 Char   HR                                           STUDYID
#> 3460 Char   HR                                            SITEID
#> 3461 Char   HR                                            SUBJID
#> 3462 Char    O                                              <NA>
#> 3463 Char    O                                             AECAT
#> 3464 Char    O                                            AESCAT
#> 3465 Char    O                                            AESPID
#> 3466 Char   HR                                            AETERM
#> 3467 Char    O                                              <NA>
#> 3468 Char    O                                           AEPRESP
#> 3469 Char   HR                                           AESTDTC
#> 3470 Char  R/C                                           AESTDTC
#> 3471 Char    O                                             AELOC
#> 3472 Char    O                                              <NA>
#> 3473 Char    O                                              <NA>
#> 3474 Char    O                                              <NA>
#> 3475 Char    O                                  AEENRTPT; AEENRF
#> 3476 Char  R/C                                           AEENDTC
#> 3477 Char  R/C                                           AEENDTC
#> 3478 Char  R/C                                             AESEV
#> 3479 Char  R/C                                           AETOXGR
#> 3480 Char  R/C                                             AESER
#> 3481 Char  R/C                                            AESDTH
#> 3482 Char    O                                            DTHDTC
#> 3483 Char  R/C                                           AESLIFE
#> 3484 Char  R/C                                           AESHOSP
#> 3485 Char  R/C                                          AESDISAB
#> 3486 Char  R/C                                           AESCONG
#> 3487 Char    O                                           AESINTV
#> 3488 Char  R/C                                            AESMIE
#> 3489 Char    O                                            AESCAN
#> 3490 Char    O                                             AESOD
#> 3491 Char   HR                                             AEREL
#> 3492 Char  R/C                                             AEACN
#> 3493 Char    O                                          AEACNDEV
#> 3494 Char    O                                              <NA>
#> 3495 Char    O                                          AEACNOTH
#> 3496 Char  R/C                                             AEOUT
#> 3497 Char    O                                              QVAL
#> 3498 Char    O                                              <NA>
#> 3499 Char    O                                          AERELNST
#> 3500 Char    O                                              <NA>
#> 3501 Char    O                                            AEPATT
#> 3502 Char    O                                          AECONTRT
#> 3503 Char  R/C                                          AEMODIFY
#> 3504 Char    O                                           AEDECOD
#> 3505 Char  R/C                                             AELLT
#> 3506  Num  R/C                                           AELLTCD
#> 3507  Num  R/C                                            AEPTCD
#> 3508 Char  R/C                                             AEHLT
#> 3509  Num  R/C                                           AEHLTCD
#> 3510 Char  R/C                                            AEHLGT
#> 3511  Num  R/C                                          AEHLGTCD
#> 3512 Char  R/C                                             AESOC
#> 3513  Num  R/C                                           AESOCCD
#> 3514 Char   HR                                           STUDYID
#> 3515 Char   HR                                            SITEID
#> 3516 Char   HR                                            SUBJID
#> 3517 Char    O                                             CECAT
#> 3518 Char    O                                            CESCAT
#> 3519 Char    O                                              <NA>
#> 3520 Char    O                                            CESPID
#> 3521 Char   HR                                            CETERM
#> 3522 Char    O                                           CEOCCUR
#> 3523 Char    O                                           CEPRESP
#> 3524 Char  R/C                                           CESTDTC
#> 3525 Char    O                                           CESTDTC
#> 3526 Char    O                                              <NA>
#> 3527 Char    O                                              <NA>
#> 3528 Char    O                                              <NA>
#> 3529 Char    O                                              <NA>
#> 3530 Char    O                                  CEENRTPT; CEENRF
#> 3531 Char  R/C                                           CEENDTC
#> 3532 Char    O                                           CEENDTC
#> 3533 Char    O                                             CESEV
#> 3534 Char    O                                              <NA>
#> 3535 Char    O                                           CETOXGR
#> 3536 Char    O                                              <NA>
#> 3537 Char    O                                           CEDECOD
#> 3538 Char    O                                              <NA>
#> 3539  Num    O                                              <NA>
#> 3540  Num    O                                              <NA>
#> 3541 Char    O                                              <NA>
#> 3542  Num    O                                              <NA>
#> 3543 Char    O                                              <NA>
#> 3544  Num    O                                              <NA>
#> 3545 Char    O                                              <NA>
#> 3546  Num    O                                              <NA>
#> 3547 Char   HR                                           STUDYID
#> 3548 Char   HR                                            SITEID
#> 3549 Char   HR                                            SUBJID
#> 3550 Char    O                                             DVCAT
#> 3551 Char    O                                            DVSCAT
#> 3552 Char    O                                              <NA>
#> 3553 Char  R/C                                           DVDECOD
#> 3554 Char  R/C                                            DVTERM
#> 3555 Char    O                                           DVSTDTC
#> 3556 Char    O                                           DVSTDTC
#> 3557 Char    O                                           DVENDTC
#> 3558 Char    O                                           DVENDTC
#> 3559 Char    O                                            DVSPID
#> 3560 Char   HR                                           STUDYID
#> 3561 Char   HR                                            SITEID
#> 3562 Char   HR                                            SUBJID
#> 3563 Char    O                                              <NA>
#> 3564 Char    O                                             HOCAT
#> 3565 Char    O                                            HOSCAT
#> 3566 Char    O                                           HOOCCUR
#> 3567 Char    O                                           HOPRESP
#> 3568 Char    O                                          HOREASND
#> 3569 Char    O                                            HOSPID
#> 3570 Char   HR                                            HOTERM
#> 3571 Char  R/C                                           HODECOD
#> 3572 Char    O                                           HOSTDTC
#> 3573 Char    O                                           HOSTDTC
#> 3574 Char    O                                           HOENDTC
#> 3575 Char    O                                           HOENDTC
#> 3576 Char    O                                             HODUR
#> 3577 Char    O                                             HODUR
#> 3578 Char    O                                          HOENRTPT
#> 3579 Char    O                                              QVAL
#> 3580 Char    O                                              <NA>
#> 3581 Char   HR                                           STUDYID
#> 3582 Char   HR                                            SITEID
#> 3583 Char   HR                                            SUBJID
#> 3584 Char    O                                              <NA>
#> 3585 Char  R/C                                             MHCAT
#> 3586 Char    O                                            MHSCAT
#> 3587 Char    O                                             MHDTC
#> 3588 Char    O                                            MHSPID
#> 3589 Char    O                                          MHEVDTYP
#> 3590 Char   HR                                            MHTERM
#> 3591 Char    O                                           MHOCCUR
#> 3592 Char    O                                           MHPRESP
#> 3593 Char    O                                              <NA>
#> 3594 Char    O                                  MHENRF; MHENRTPT
#> 3595 Char    O                                              QVAL
#> 3596 Char    O                                           MHSTDTC
#> 3597 Char    O                                           MHENDTC
#> 3598 Char    O                                              <NA>
#> 3599 Char    O                                              <NA>
#> 3600 Char    O                                              <NA>
#> 3601 Char    O                                              <NA>
#> 3602 Char    O                                          MHMODIFY
#> 3603 Char    O                                           MHDECOD
#> 3604 Char    O                                              <NA>
#> 3605  Num    O                                              <NA>
#> 3606  Num    O                                              <NA>
#> 3607 Char    O                                              <NA>
#> 3608  Num    O                                              <NA>
#> 3609 Char    O                                              <NA>
#> 3610  Num    O                                              <NA>
#> 3611 Char    O                                              <NA>
#> 3612  Num    O                                              <NA>
#> 3613 Char   HR                                           STUDYID
#> 3614 Char   HR                                            SITEID
#> 3615 Char   HR                                            SUBJID
#> 3616 Char  R/C                                             VISIT
#> 3617 Char  R/C                                              <NA>
#> 3618 Char  R/C                                             CPCAT
#> 3619 Char  R/C                                            CPSCAT
#> 3620 Char    O                                            CPSTAT
#> 3621 Char  R/C                                           CPREFID
#> 3622 Char  R/C                                             CPTPT
#> 3623 Char  R/C                                             CPDTC
#> 3624 Char  R/C                                             CPDTC
#> 3625 Char   HR                                           STUDYID
#> 3626 Char   HR                                            SITEID
#> 3627 Char   HR                                            SUBJID
#> 3628 Char  R/C                                             VISIT
#> 3629 Char  R/C                                              <NA>
#> 3630 Char    O                                            CVSTAT
#> 3631 Char  R/C                                             CVDTC
#> 3632 Char  R/C                                             CVDTC
#> 3633 Char  R/C                                             CVTPT
#> 3634 Char   HR                                  CVTEST; CVTESTCD
#> 3635 Char  R/C                                             CVCAT
#> 3636 Char    O                                            CVSCAT
#> 3637 Char   HR                                           CVORRES
#> 3638 Char  R/C                                          CVORRESU
#> 3639 Char    O                                           CVORRES
#> 3640 Char    O                                           CVORRES
#> 3641 Char    O                                            CVSTAT
#> 3642 Char    O                                          CVREASND
#> 3643 Char    O                                             CVPOS
#> 3644 Char    O                                             CVLOC
#> 3645 Char    O                                             CVLAT
#> 3646 Char    O                                             CVDIR
#> 3647 Char    O                                          CVMETHOD
#> 3648 Char    O                                            CVEVAL
#> 3649 Char    O                                          CVEVALID
#> 3650 Char   HR                                           STUDYID
#> 3651 Char   HR                                            SITEID
#> 3652 Char   HR                                            SUBJID
#> 3653 Char  R/C                                             VISIT
#> 3654 Char  R/C                                              <NA>
#> 3655 Char    O                                            DASTAT
#> 3656 Char    O                                             DACAT
#> 3657 Char    O                                            DASCAT
#> 3658 Char  R/C                                             DADTC
#> 3659 Char    O                                           DAREFID
#> 3660 Char   HR                                  DATEST; DATESTCD
#> 3661 Char   HR                                           DAORRES
#> 3662 Char   HR                                          DAORRESU
#> 3663 Char   HR                                           STUDYID
#> 3664 Char   HR                                            SITEID
#> 3665 Char   HR                                            SUBJID
#> 3666 Char  R/C                                              <NA>
#> 3667 Char  R/C                                              <NA>
#> 3668 Char    O                                              <NA>
#> 3669 Char  R/C                                             DDDTC
#> 3670 Char    O                                              <NA>
#> 3671 Char    O                                            DTHDTC
#> 3672 Char   HR                                  DDTEST; DDTESTCD
#> 3673 Char   HR                                           DDORRES
#> 3674 Char    O                                          DDRESCAT
#> 3675 Char    O                                            DDEVAL
#> 3676 Char   HR                                           STUDYID
#> 3677 Char   HR                                            SITEID
#> 3678 Char   HR                                            SUBJID
#> 3679 Char  R/C                                             VISIT
#> 3680 Char  R/C                                              <NA>
#> 3681 Char   HR                                              <NA>
#> 3682 Char    O                                             IEDTC
#> 3683 Char  R/C                                             IECAT
#> 3684 Char    O                                            IESCAT
#> 3685 Char   HR                                          IETESTCD
#> 3686 Char    O                                            IETEST
#> 3687 Char   HR                                           IEORRES
#> 3688 Char   HR                                           STUDYID
#> 3689 Char   HR                                            SITEID
#> 3690 Char   HR                                            SUBJID
#> 3691 Char  R/C                                             VISIT
#> 3692 Char  R/C                                              <NA>
#> 3693 Char    O                                            MKSTAT
#> 3694 Char  R/C                                             MKDTC
#> 3695 Char  R/C                                             MKDTC
#> 3696 Char  R/C                                             MKTPT
#> 3697 Char   HR                                  MKTEST; MKTESTCD
#> 3698 Char    O                                             MKCAT
#> 3699 Char    O                                            MKSCAT
#> 3700 Char   HR                                           MKORRES
#> 3701 Char  R/C                                          MKORRESU
#> 3702 Char    O                                           MKORRES
#> 3703 Char    O                                           MKORRES
#> 3704 Char    O                                           MKORRES
#> 3705 Char    O                                              <NA>
#> 3706 Char    O                                            MKSTAT
#> 3707 Char    O                                          MKREASND
#> 3708 Char    O                                             MKPOS
#> 3709 Char    O                                             MKLOC
#> 3710 Char    O                                             MKLAT
#> 3711 Char    O                                             MKDIR
#> 3712 Char    O                                          MKMETHOD
#> 3713 Char    O                                            MKEVAL
#> 3714 Char    O                                          MKEVALID
#> 3715 Char    O                                              <NA>
#> 3716 Char    O                                              <NA>
#> 3717 Char   HR                                           STUDYID
#> 3718 Char   HR                                            SITEID
#> 3719 Char   HR                                            SUBJID
#> 3720 Char  R/C                                             VISIT
#> 3721 Char  R/C                                              <NA>
#> 3722 Char    O                                            NVSTAT
#> 3723 Char  R/C                                             NVDTC
#> 3724 Char  R/C                                             NVDTC
#> 3725 Char  R/C                                             NVTPT
#> 3726 Char   HR                                  NVTEST; NVTESTCD
#> 3727 Char    O                                             NVCAT
#> 3728 Char    O                                            NVSCAT
#> 3729 Char   HR                                           NVORRES
#> 3730 Char  R/C                                          NVORRESU
#> 3731 Char    O                                           NVORRES
#> 3732 Char    O                                           NVORRES
#> 3733 Char    O                                           NVORRES
#> 3734 Char    O                                              <NA>
#> 3735 Char    O                                              <NA>
#> 3736 Char    O                                              <NA>
#> 3737 Char    O                                            NVSTAT
#> 3738 Char    O                                          NVREASND
#> 3739 Char    O                                              <NA>
#> 3740 Char    O                                             NVLOC
#> 3741 Char    O                                             NVLAT
#> 3742 Char    O                                             NVDIR
#> 3743 Char    O                                          NVMETHOD
#> 3744 Char    O                                            NVEVAL
#> 3745 Char    O                                          NVEVALID
#> 3746 Char    O                                              <NA>
#> 3747 Char    O                                              <NA>
#> 3748 Char   HR                                           STUDYID
#> 3749 Char   HR                                            SITEID
#> 3750 Char   HR                                            SUBJID
#> 3751 Char  R/C                                             VISIT
#> 3752 Char  R/C                                              <NA>
#> 3753 Char   HR                                             FOCID
#> 3754 Char    O                                            OESTAT
#> 3755 Char  R/C                                             OEDTC
#> 3756 Char  R/C                                             OEDTC
#> 3757 Char   HR                                            OETEST
#> 3758 Char    O                                          OETSTDTL
#> 3759 Char    O                                             OECAT
#> 3760 Char    O                                            OESCAT
#> 3761 Char   HR                                           OEORRES
#> 3762 Char  R/C                                          OEORRESU
#> 3763 Char    O                                           OEORRES
#> 3764 Char    O                                           OEORRES
#> 3765 Char    O                                          OEORNRLO
#> 3766 Char    O                                          OEORNRHI
#> 3767 Char    O                                           OESTNRC
#> 3768 Char    O                                           OENRIND
#> 3769 Char    O                                          OESTRESC
#> 3770 Char    O                                          OEREASND
#> 3771 Char    O                                             OELOC
#> 3772 Char    O                                             OELAT
#> 3773 Char    O                                             OEDIR
#> 3774 Char    O                                          OEPORTOT
#> 3775 Char  R/C                                          OEMETHOD
#> 3776 Char    O                                            OEEVAL
#> 3777 Char    O                                          OEEVALID
#> 3778 Char    O                                          OEACPTFL
#> 3779 Char    O                                          OEREPNUM
#> 3780 Char   HR                                           STUDYID
#> 3781 Char   HR                                            SITEID
#> 3782 Char   HR                                            SUBJID
#> 3783 Char  R/C                                             VISIT
#> 3784 Char  R/C                                              <NA>
#> 3785 Char    O                                            RESTAT
#> 3786 Char  R/C                                             REDTC
#> 3787 Char  R/C                                             REDTC
#> 3788 Char  R/C                                             RETPT
#> 3789 Char   HR                                  RETEST; RETESTCD
#> 3790 Char  R/C                                             RECAT
#> 3791 Char    O                                            RESCAT
#> 3792 Char   HR                                           REORRES
#> 3793 Char  R/C                                          REORRESU
#> 3794 Char    O                                           REORRES
#> 3795 Char    O                                           REORRES
#> 3796 Char    O                                           REORRES
#> 3797 Char    O                                              <NA>
#> 3798 Char    O                                              <NA>
#> 3799 Char    O                                              <NA>
#> 3800 Char    O                                            RESTAT
#> 3801 Char    O                                          REREASND
#> 3802 Char    O                                             REPOS
#> 3803 Char    O                                             RELOC
#> 3804 Char    O                                             RELAT
#> 3805 Char    O                                             REDIR
#> 3806 Char    O                                          REMETHOD
#> 3807 Char    O                                            REEVAL
#> 3808 Char    O                                          REEVALID
#> 3809 Char    O                                              <NA>
#> 3810 Char    O                                          REREPNUM
#> 3811 Char    O                                              <NA>
#> 3812 Char   HR                                           STUDYID
#> 3813 Char   HR                                            SITEID
#> 3814 Char   HR                                            SUBJID
#> 3815 Char  R/C                                             VISIT
#> 3816 Char  R/C                                              <NA>
#> 3817 Char    O                                             RPCAT
#> 3818 Char    O                                            RPSCAT
#> 3819 Char    O                                            RPSTAT
#> 3820 Char    O                                          RPREASND
#> 3821 Char    O                                              <NA>
#> 3822 Char    O                                            RPSPID
#> 3823 Char   HR                                  RPTEST; RPTESTCD
#> 3824 Char   HR                                           RPORRES
#> 3825 Char  R/C                                          RPORRESU
#> 3826 Char  R/C                                             RPDTC
#> 3827 Char   HR                                           STUDYID
#> 3828 Char   HR                                            SITEID
#> 3829 Char   HR                                            SUBJID
#> 3830 Char  R/C                                             VISIT
#> 3831 Char  R/C                                              <NA>
#> 3832 Char  R/C                                             RSCAT
#> 3833 Char  R/C                                            RSSCAT
#> 3834 Char    O                                            RSSTAT
#> 3835 Char    O                                          RSREASND
#> 3836 Char  R/C                                             RSDTC
#> 3837 Char  R/C                                            RSEVAL
#> 3838 Char    O                                          RSEVALID
#> 3839 Char    O                                           RSLNKID
#> 3840 Char    O                                          RSLNKGRP
#> 3841 Char   HR                                  RSTEST; RSTESTCD
#> 3842 Char   HR                                           RSORRES
#> 3843 Char   HR                                          RSORRESU
#> 3844 Char   HR                                           STUDYID
#> 3845 Char   HR                                            SITEID
#> 3846 Char   HR                                            SUBJID
#> 3847 Char  R/C                                             VISIT
#> 3848 Char  R/C                                              <NA>
#> 3849 Char    O                                             SCCAT
#> 3850 Char    O                                            SCSCAT
#> 3851 Char    O                                            SCSTAT
#> 3852 Char    O                                            SCSPID
#> 3853 Char  R/C                                             SCDTC
#> 3854 Char   HR                                  SCTEST; SCTESTCD
#> 3855 Char   HR                                           SCORRES
#> 3856 Char   HR                                           STUDYID
#> 3857 Char   HR                                            SITEID
#> 3858 Char   HR                                            SUBJID
#> 3859 Char  R/C                                             VISIT
#> 3860 Char  R/C                                              <NA>
#> 3861 Char    O                                          TRLNKGRP
#> 3862 Char    O                                              <NA>
#> 3863 Char    O                                              <NA>
#> 3864 Char    O                                            TRSTAT
#> 3865 Char    O                                          TRREASND
#> 3866 Char    O                                            TREVAL
#> 3867 Char    O                                          TREVALID
#> 3868 Char  R/C                                             TRDTC
#> 3869 Char  R/C                                           TRLNKID
#> 3870 Char   HR                                  TRTEST; TRTESTCD
#> 3871 Char   HR                         TRORRES; TRTESTCD; TRTEST
#> 3872 Char  R/C                                          TRORRESU
#> 3873 Char    O                                             TRNAM
#> 3874 Char   HR                                           STUDYID
#> 3875 Char   HR                                            SITEID
#> 3876 Char   HR                                            SUBJID
#> 3877 Char  R/C                                             VISIT
#> 3878 Char  R/C                                              <NA>
#> 3879 Char    O                                              <NA>
#> 3880 Char    O                                              <NA>
#> 3881 Char    O                                              <NA>
#> 3882 Char  R/C                                             TUDTC
#> 3883 Char    O                                            TUEVAL
#> 3884 Char    O                                          TUEVALID
#> 3885 Char   HR                                           TULNKID
#> 3886 Char    O                                              <NA>
#> 3887 Char    O                                          TUMETHOD
#> 3888 Char    O                                           TUREFID
#> 3889 Char   HR                                  TUTEST; TUTESTCD
#> 3890 Char   HR                                           TUORRES
#> 3891 Char    O                                             TULOC
#> 3892 Char    O                                             TULAT
#> 3893 Char    O                                             TUDIR
#> 3894 Char    O                                              QVAL
#> 3895 Char    O                                             TUNAM
#> 3896 Char   HR                                           STUDYID
#> 3897 Char   HR                                            SITEID
#> 3898 Char   HR                                            SUBJID
#> 3899 Char  R/C                                             VISIT
#> 3900 Char  R/C                                              <NA>
#> 3901 Char    O                                            URSTAT
#> 3902 Char  R/C                                             URDTC
#> 3903 Char  R/C                                             URDTC
#> 3904 Char  R/C                                             URTPT
#> 3905 Char   HR                                  URTEST; URTESTCD
#> 3906 Char  R/C                                             URCAT
#> 3907 Char    O                                            URSCAT
#> 3908 Char   HR                                           URORRES
#> 3909 Char  R/C                                          URORRESU
#> 3910 Char    O                                           URORRES
#> 3911 Char    O                                           URORRES
#> 3912 Char    O                                           URORRES
#> 3913 Char    O                                            URSTAT
#> 3914 Char    O                                          URREASND
#> 3915 Char    O                                             URLOC
#> 3916 Char    O                                             URLAT
#> 3917 Char    O                                             URDIR
#> 3918 Char    O                                          URMETHOD
#> 3919 Char    O                                            UREVAL
#> 3920 Char    O                                          UREVALID
#> 3921 Char    O                                              <NA>
#> 3922 Char    O                                              <NA>
#> 3923 Char    O                                              <NA>
#> 3924 Char   HR                                           STUDYID
#> 3925 Char   HR                                            SITEID
#> 3926 Char   HR                                            SUBJID
#> 3927 Char  R/C                                             VISIT
#> 3928 Char  R/C                                              <NA>
#> 3929 Char    O                                            VSSTAT
#> 3930 Char  R/C                                             VSDTC
#> 3931 Char  R/C                                             VSDTC
#> 3932 Char    O                                            VSSPID
#> 3933 Char  R/C                                             VSTPT
#> 3934 Char    O                                             VSCAT
#> 3935 Char    O                                            VSSCAT
#> 3936 Char    O                                              <NA>
#> 3937 Char   HR                                  VSTEST; VSTESTCD
#> 3938 Char    O                                            VSSTAT
#> 3939 Char   HR                                           VSORRES
#> 3940 Char  R/C                                          VSORRESU
#> 3941 Char    O                                           VSCLSIG
#> 3942 Char    O                                             VSLOC
#> 3943 Char  R/C                                             VSPOS
#> 3944 Char    O                                              <NA>
#> 3945 Char    O                                             VSLAT
#> 3946 Char   HR                                           STUDYID
#> 3947 Char   HR                                            SITEID
#> 3948 Char   HR                                            SUBJID
#> 3949 Char  R/C                                             VISIT
#> 3950 Char  R/C                                              <NA>
#> 3951 Char   HR                                             FAOBJ
#> 3952 Char    O                                              <NA>
#> 3953 Char    O                                            FASTAT
#> 3954 Char  R/C                                             FADTC
#> 3955 Char  R/C                                             FADTC
#> 3956 Char   HR                                  FATEST; FATESTCD
#> 3957 Char    O                                              <NA>
#> 3958 Char    O                                             FACAT
#> 3959 Char    O                                            FASCAT
#> 3960 Char    O                                              <NA>
#> 3961 Char   HR                                           FAORRES
#> 3962 Char  R/C                                          FAORRESU
#> 3963 Char    O                                              <NA>
#> 3964 Char    O                                              <NA>
#> 3965 Char    O                                              <NA>
#> 3966 Char    O                                            FASTAT
#> 3967 Char    O                                          FAREASND
#> 3968 Char    O                                              <NA>
#> 3969 Char    O                                              <NA>
#> 3970 Char    O                                             FALOC
#> 3971 Char    O                                             FALAT
#> 3972 Char    O                                              <NA>
#> 3973 Char    O                                              <NA>
#> 3974 Char    O                                              <NA>
#> 3975 Char    O                                              <NA>
#> 3976 Char    O                                              <NA>
#> 3977 Char    O                                            FAEVAL
#> 3978 Char    O                                              <NA>
#> 3979 Char    O                                              QVAL
#> 3980 Char   HR                                           STUDYID
#> 3981 Char   HR                                            SITEID
#> 3982 Char   HR                                            SUBJID
#> 3983 Char  R/C                                             VISIT
#> 3984 Char  R/C                                              <NA>
#> 3985 Char    O                                            SRSTAT
#> 3986 Char    O                                          SRREASND
#> 3987 Char    O                                             SRCAT
#> 3988 Char    O                                            SRSCAT
#> 3989 Char    O                                            SRSPID
#> 3990 Char   HR                                             SROBJ
#> 3991 Char  R/C                                          SRRFTDTC
#> 3992 Char  R/C                                          SRRFTDTC
#> 3993 Char    O                                             SRLOC
#> 3994 Char    O                                             SRLAT
#> 3995 Char   HR                                  SRTEST; SRTESTCD
#> 3996 Char  R/C                                             SRTPT
#> 3997 Char  R/C                                             SRDTC
#> 3998 Char  R/C                                             SRDTC
#> 3999 Char    O                                              <NA>
#> 4000 Char    O                                            SREVAL
#> 4001 Char    O                                              <NA>
#> 4002 Char   HR                                           SRORRES
#> 4003 Char  R/C                                          SRORRESU
#> 4004 Char    O                                              <NA>
#> 4005 Char    O                                              QVAL
#> 4006 Char   HR                                           STUDYID
#> 4007 Char   HR                                            SITEID
#> 4008 Char   HR                                            SUBJID
#> 4009 Char    O                                             COVAL
#> 4010 Char   HR                                           STUDYID
#> 4011 Char   HR                                            SITEID
#> 4012 Char   HR                                            SUBJID
#> 4013 Char   HR                                             DSCAT
#> 4014 Char    O                                            DSSCAT
#> 4015 Char  R/C                                             EPOCH
#> 4016 Char  R/C                                           DSDECOD
#> 4017 Char  R/C                                            DSTERM
#> 4018 Char  R/C                                           DSSTDTC
#> 4019 Char    O                                           DSSTDTC
#> 4020 Char    O                                   DSTERM; DSDECOD
#> 4021 Char   HR                                           STUDYID
#> 4022 Char   HR                                            SITEID
#> 4023 Char   HR                                            SUBJID
#> 4024 Char   HR                                             DSCAT
#> 4025 Char    O                                            DSSCAT
#> 4026 Char  R/C                                             EPOCH
#> 4027 Char  R/C                                           DSDECOD
#> 4028 Char  R/C                                            DSTERM
#> 4029 Char  R/C                                           DSSTDTC
#> 4030 Char    O                                           DSSTDTC
#> 4031 Char    O                                            DTHDTC
#> 4032 Char    O                                              QVAL
#> 4033 Char    O                                              <NA>
#> 4034 Char    O                                              <NA>
#> 4035 Char    O                                              <NA>
#> 4036 Char  R/C                                              <NA>
#> 4037 Char  R/C                                              <NA>
#> 4038 Char    O                                              <NA>
#> 4039 Char   HR                                              <NA>
#> 4040 Char    O                                              <NA>
#> 4041 Char    O                                              <NA>
#> 4042 Char    O                                              <NA>
#> 4043 Char    O                                              <NA>
#> 4044  Num   HR                                              <NA>
#> 4045 Char   HR                                              <NA>
#> 4046 Char   HR                                              <NA>
#> 4047 Char   HR                                              <NA>
#> 4048  Num   HR                                              <NA>
#> 4049  Num  R/C                                              <NA>
#> 4050 Char   HR                                              <NA>
#> 4051 Char   HR                                              <NA>
#> 4052 Char    O                                              <NA>
#> 4053 Char  R/C                                              <NA>
#> 4054  Num  R/C                                              <NA>
#> 4055 Char  R/C                                              <NA>
#> 4056 Char   HR                                           STUDYID
#> 4057 Char   HR                                            SITEID
#> 4058 Char   HR                                            SUBJID
#> 4059 Char  R/C                                             VISIT
#> 4060 Char  R/C                                              <NA>
#> 4061 Char    O                                           DAGRPID
#> 4062 Char    O                                            DASTAT
#> 4063 Char    O                                             DACAT
#> 4064 Char    O                                            DASCAT
#> 4065 Char    O                                           DAREFID
#> 4066 Char  R/C                                             DADTC
#> 4067 Char   HR                         DAORRES; DATEST; DATESTCD
#> 4068 Char   HR                                          DAORRESU
#> 4069 Char   HR                                           STUDYID
#> 4070 Char   HR                                            SITEID
#> 4071 Char   HR                                            SUBJID
#> 4072 Char  R/C                                              <NA>
#> 4073 Char  R/C                                              <NA>
#> 4074 Char    O                                              <NA>
#> 4075 Char    O                                              <NA>
#> 4076 Char    O                                              <NA>
#> 4077 Char  R/C                                             DDDTC
#> 4078 Char    O                                            DTHDTC
#> 4079 Char   HR                         DDORRES; DDTEST; DDTESTCD
#> 4080 Char    O                                            DDEVAL
#> 4081 Char   HR                                           STUDYID
#> 4082 Char   HR                                            SITEID
#> 4083 Char   HR                                            SUBJID
#> 4084 Char  R/C                                             VISIT
#> 4085 Char  R/C                                              <NA>
#> 4086 Char    O                                             EGCAT
#> 4087 Char    O                                            EGSCAT
#> 4088 Char    O                                            EGSTAT
#> 4089  Num    O                                          EGREPNUM
#> 4090 Char    O                                           EGREFID
#> 4091 Char    O                                          EGMETHOD
#> 4092 Char    O                                            EGLEAD
#> 4093 Char    O                                             EGPOS
#> 4094 Char  R/C                                             EGDTC
#> 4095 Char  R/C                                             EGTPT
#> 4096 Char  R/C                                             EGDTC
#> 4097 Char   HR                                           STUDYID
#> 4098 Char   HR                                            SITEID
#> 4099 Char   HR                                            SUBJID
#> 4100 Char  R/C                                             VISIT
#> 4101 Char  R/C                                              <NA>
#> 4102 Char    O                                             EGCAT
#> 4103 Char    O                                            EGSCAT
#> 4104 Char   HR                                            EGSTAT
#> 4105  Num    O                                          EGREPNUM
#> 4106 Char    O                                          EGMETHOD
#> 4107 Char    O                                            EGLEAD
#> 4108 Char    O                                             EGPOS
#> 4109 Char  R/C                                             EGDTC
#> 4110 Char  R/C                                             EGTPT
#> 4111 Char  R/C                                             EGDTC
#> 4112 Char   HR                                  EGTEST; EGTESTCD
#> 4113 Char   HR                                           EGORRES
#> 4114 Char  R/C                                          EGORRESU
#> 4115 Char    O                                           EGCLSIG
#> 4116 Char   HR                                           STUDYID
#> 4117 Char   HR                                            SITEID
#> 4118 Char   HR                                            SUBJID
#> 4119 Char  R/C                                             VISIT
#> 4120 Char  R/C                                              <NA>
#> 4121 Char    O                                             EGCAT
#> 4122 Char    O                                            EGSCAT
#> 4123 Char   HR                                            EGSTAT
#> 4124  Num    O                                          EGREPNUM
#> 4125 Char    O                                           EGREFID
#> 4126 Char    O                                          EGMETHOD
#> 4127 Char    O                                            EGLEAD
#> 4128 Char    O                                             EGPOS
#> 4129 Char  R/C                                             EGDTC
#> 4130 Char  R/C                                             EGTPT
#> 4131 Char  R/C                                             EGDTC
#> 4132 Char    O                                            EGEVAL
#> 4133 Char    O                                           EGORRES
#> 4134 Char   HR                                           EGCLSIG
#> 4135 Char    O                                              <NA>
#> 4136 Char    O                                              <NA>
#> 4137 Char   HR                                           STUDYID
#> 4138 Char   HR                                            SITEID
#> 4139 Char   HR                                            SUBJID
#> 4140 Char  R/C                                             VISIT
#> 4141 Char  R/C                                              <NA>
#> 4142 Char  R/C                                             GFCAT
#> 4143 Char  R/C                                            GFSCAT
#> 4144 Char    O                                            GFSTAT
#> 4145 Char  R/C                                           GFREFID
#> 4146 Char  R/C                                             GFTPT
#> 4147 Char  R/C                                             GFDTC
#> 4148 Char  R/C                                             GFDTC
#> 4149 Char   HR                                           STUDYID
#> 4150 Char   HR                                            SITEID
#> 4151 Char   HR                                            SUBJID
#> 4152 Char  R/C                                             VISIT
#> 4153 Char  R/C                                              <NA>
#> 4154 Char  R/C                                             GFCAT
#> 4155 Char  R/C                                            GFSCAT
#> 4156 Char   HR                                            GFSTAT
#> 4157 Char  R/C                                             GFNAM
#> 4158 Char   HR                                  GFTEST; GFTESTCD
#> 4159 Char    O                                          GFTSTDTL
#> 4160 Char  R/C                                          GFMETHOD
#> 4161 Char  R/C                                             GFTPT
#> 4162 Char  R/C                                             GFDTC
#> 4163 Char  R/C                                             GFDTC
#> 4164 Char   HR                                           GFORRES
#> 4165 Char  R/C                                          GFORRESU
#> 4166 Char   HR                                           STUDYID
#> 4167 Char   HR                                            SITEID
#> 4168 Char   HR                                            SUBJID
#> 4169 Char  R/C                                             VISIT
#> 4170 Char  R/C                                              <NA>
#> 4171 Char    O                                            LBSTAT
#> 4172 Char  R/C                                             LBDTC
#> 4173 Char  R/C                                             LBDTC
#> 4174 Char  R/C                                             LBCAT
#> 4175 Char  R/C                                            LBSCAT
#> 4176 Char  R/C                                            LBSPEC
#> 4177 Char  R/C                                             LBTPT
#> 4178 Char  R/C                                              QVAL
#> 4179 Char  R/C                                            LBFAST
#> 4180 Char  R/C                                           LBREFID
#> 4181 Char   HR                                           STUDYID
#> 4182 Char   HR                                            SITEID
#> 4183 Char   HR                                            SUBJID
#> 4184 Char  R/C                                             VISIT
#> 4185 Char  R/C                                              <NA>
#> 4186 Char   HR                                            LBSTAT
#> 4187 Char  R/C                                             LBDTC
#> 4188 Char  R/C                                             LBDTC
#> 4189 Char  R/C                                             LBCAT
#> 4190 Char  R/C                                            LBSCAT
#> 4191 Char  R/C                                            LBSPEC
#> 4192 Char  R/C                                             LBTPT
#> 4193 Char    O                                              QVAL
#> 4194 Char  R/C                                            LBFAST
#> 4195 Char   HR                                  LBTEST; LBTESTCD
#> 4196 Char   HR                                           LBORRES
#> 4197 Char    O                                          LBORRESU
#> 4198 Char   HR                                           LBCLSIG
#> 4199 Char  R/C                                           LBREFID
#> 4200 Char    O                                          LBMETHOD
#> 4201 Char   HR                                           STUDYID
#> 4202 Char   HR                                            SITEID
#> 4203 Char   HR                                            SUBJID
#> 4204 Char  R/C                                             VISIT
#> 4205 Char  R/C                                              <NA>
#> 4206 Char   HR                                            LBSTAT
#> 4207 Char  R/C                                             LBDTC
#> 4208 Char  R/C                                             LBDTC
#> 4209 Char  R/C                                             LBCAT
#> 4210 Char  R/C                                            LBSCAT
#> 4211 Char  R/C                                            LBSPEC
#> 4212 Char  R/C                                             LBTPT
#> 4213 Char  R/C                                            LBFAST
#> 4214 Char  R/C                                              QVAL
#> 4215 Char    O                                          LBSPCCND
#> 4216 Char   HR                                  LBTEST; LBTESTCD
#> 4217 Char   HR                                           LBORRES
#> 4218 Char    O                                          LBMETHOD
#> 4219 Char  R/C                                          LBORRESU
#> 4220 Char    O                                              QVAL
#> 4221 Char    O                                           LBTOXGR
#> 4222 Char    O                                             LBTOX
#> 4223 Char  R/C                                          LBORNRLO
#> 4224 Char  R/C                                          LBORNRHI
#> 4225 Char  R/C                                           LBNRIND
#> 4226 Char    O                                           LBCLSIG
#> 4227 Char  R/C                                             LBNAM
#> 4228 Char   HR                                           STUDYID
#> 4229 Char   HR                                            SITEID
#> 4230 Char   HR                                            SUBJID
#> 4231 Char  R/C                                             VISIT
#> 4232 Char  R/C                                              <NA>
#> 4233 Char    O                                            MBSTAT
#> 4234 Char    O                                           MBREFID
#> 4235 Char    O                                           MBGRPID
#> 4236 Char  R/C                                             MBDTC
#> 4237 Char  R/C                                             MBDTC
#> 4238 Char    O                                             MBCAT
#> 4239 Char    O                                            MBSCAT
#> 4240 Char  R/C                                            MBSPEC
#> 4241 Char  R/C                                          MBSPCCND
#> 4242 Char    O                                             MBLOC
#> 4243 Char    O                                             MBLAT
#> 4244 Char    O                                             MBDIR
#> 4245 Char   HR                                           STUDYID
#> 4246 Char   HR                                            SITEID
#> 4247 Char   HR                                            SUBJID
#> 4248 Char  R/C                                             VISIT
#> 4249 Char  R/C                                              <NA>
#> 4250 Char    O                                            MBSTAT
#> 4251 Char    O                                           MBREFID
#> 4252 Char    O                                            MBSPID
#> 4253 Char    O                                           MBGRPID
#> 4254 Char    O                                           MBLNKID
#> 4255 Char  R/C                                             MBDTC
#> 4256 Char  R/C                                             MBDTC
#> 4257 Char    O                                             MBCAT
#> 4258 Char    O                                            MBSCAT
#> 4259 Char   HR                                  MBTEST; MBTESTCD
#> 4260 Char    O                                          MBTSTDTL
#> 4261 Char   HR                                           MBORRES
#> 4262 Char  R/C                                          MBORRESU
#> 4263 Char    O                                              <NA>
#> 4264 Char    O                                          MBRESCAT
#> 4265 Char    O                                             MBNAM
#> 4266 Char    O                                            MBSPEC
#> 4267 Char    O                                          MBSPCCND
#> 4268 Char    O                                             MBLOC
#> 4269 Char    O                                             MBLAT
#> 4270 Char    O                                             MBDIR
#> 4271 Char    O                                          MBMETHOD
#> 4272 Char    O                                              <NA>
#> 4273 Char   HR                                           STUDYID
#> 4274 Char   HR                                            SITEID
#> 4275 Char   HR                                            SUBJID
#> 4276 Char  R/C                                             VISIT
#> 4277 Char  R/C                                              <NA>
#> 4278 Char    O                                            MISTAT
#> 4279 Char    O                                           MIREFID
#> 4280 Char  R/C                                             MIDTC
#> 4281 Char  R/C                                             MIDTC
#> 4282 Char    O                                             MICAT
#> 4283 Char    O                                            MISCAT
#> 4284 Char  R/C                                            MISPEC
#> 4285 Char  R/C                                          MISPCCND
#> 4286 Char    O                                             MILOC
#> 4287 Char    O                                             MILAT
#> 4288 Char    O                                             MIDIR
#> 4289 Char   HR                                           STUDYID
#> 4290 Char   HR                                            SITEID
#> 4291 Char   HR                                            SUBJID
#> 4292 Char  R/C                                             VISIT
#> 4293 Char  R/C                                              <NA>
#> 4294 Char    O                                            MISTAT
#> 4295 Char    O                                           MIREFID
#> 4296 Char    O                                            MISPID
#> 4297 Char  R/C                                             MIDTC
#> 4298 Char  R/C                                             MIDTC
#> 4299 Char    O                                             MICAT
#> 4300 Char    O                                            MISCAT
#> 4301 Char   HR                                  MITEST; MITESTCD
#> 4302 Char    O                                          MITSTDTL
#> 4303 Char   HR                                           MIORRES
#> 4304 Char  R/C                                          MIORRESU
#> 4305 Char    O                                              QVAL
#> 4306 Char    O                                          MIRESCAT
#> 4307 Char    O                                             MINAM
#> 4308 Char  R/C                                            MISPEC
#> 4309 Char  R/C                                          MISPCCND
#> 4310 Char    O                                             MILOC
#> 4311 Char    O                                             MILAT
#> 4312 Char    O                                             MIDIR
#> 4313 Char    O                                          MIMETHOD
#> 4314 Char    O                                            MIEVAL
#> 4315 Char   HR                                           STUDYID
#> 4316 Char   HR                                            SITEID
#> 4317 Char   HR                                            SUBJID
#> 4318 Char  R/C                                             VISIT
#> 4319 Char  R/C                                              <NA>
#> 4320 Char    O                                            MSSTAT
#> 4321 Char    O                                           MSREFID
#> 4322 Char  R/C                                             MSDTC
#> 4323 Char  R/C                                             MSDTC
#> 4324 Char    O                                             MSCAT
#> 4325 Char    O                                            MSSCAT
#> 4326 Char  R/C                                            MSSPEC
#> 4327 Char  R/C                                          MSSPCCND
#> 4328 Char    O                                             MSLOC
#> 4329 Char    O                                             MSLAT
#> 4330 Char    O                                             MSDIR
#> 4331 Char   HR                                           STUDYID
#> 4332 Char   HR                                            SITEID
#> 4333 Char   HR                                            SUBJID
#> 4334 Char    O                                             NHOID
#> 4335 Char  R/C                                             VISIT
#> 4336 Char  R/C                                              <NA>
#> 4337 Char    O                                            MSSTAT
#> 4338 Char    O                                           MSREFID
#> 4339 Char    O                                            MSSPID
#> 4340 Char    O                                           MSGRPID
#> 4341 Char    O                                           MSLNKID
#> 4342 Char  R/C                                             MSDTC
#> 4343 Char  R/C                                             MSDTC
#> 4344 Char    O                                             MSCAT
#> 4345 Char    O                                            MSSCAT
#> 4346 Char   HR                                  MSTEST; MSTESTCD
#> 4347 Char    O                                          MSTSTDTL
#> 4348 Char    O                                           MSAGENT
#> 4349 Char    O                                            MSCONC
#> 4350 Char    O                                           MSCONCU
#> 4351 Char   HR                                           MSORRES
#> 4352 Char  R/C                                          MSORRESU
#> 4353 Char    O                                              QVAL
#> 4354 Char    O                                          MSRESCAT
#> 4355 Char    O                                             MSNAM
#> 4356 Char  R/C                                            MSSPEC
#> 4357 Char    O                                          MSSPCCND
#> 4358 Char    O                                             MSLOC
#> 4359 Char    O                                             MSLAT
#> 4360 Char    O                                             MSDIR
#> 4361 Char    O                                          MSMETHOD
#> 4362 Char    O                                            MSEVAL
#> 4363 Char   HR                                           STUDYID
#> 4364 Char   HR                                            SITEID
#> 4365 Char   HR                                            SUBJID
#> 4366 Char  R/C                                             VISIT
#> 4367 Char  R/C                                              <NA>
#> 4368 Char    O                                            PCSTAT
#> 4369 Char   HR                                            PCSTAT
#> 4370 Char    O                                          PCREASND
#> 4371 Char   HR                                             PCDTC
#> 4372 Char    O                                              <NA>
#> 4373 Char   HR                                             PCDTC
#> 4374 Char  R/C                                             PCTPT
#> 4375 Char  R/C                                            PCFAST
#> 4376 Char  R/C                                              QVAL
#> 4377 Char    O                                           PCREFID
#> 4378 Char   HR                                            PCSPEC
#> 4379 Char    O                                  PCTEST; PCTESTCD
#> 4380 Char    O                                           PCORRES
#> 4381 Char    O                                          PCORRESU
#> 4382 Char   HR                                           STUDYID
#> 4383 Char   HR                                            SITEID
#> 4384 Char   HR                                            SUBJID
#> 4385 Char  R/C                                             VISIT
#> 4386 Char  R/C                                              <NA>
#> 4387 Char    O                                            PCSTAT
#> 4388 Char    O                                          PCREASND
#> 4389 Char   HR                                             PCDTC
#> 4390 Char   HR                                             PCDTC
#> 4391 Char   HR                                           PCENDTC
#> 4392 Char   HR                                           PCENDTC
#> 4393 Char  R/C                                             PCTPT
#> 4394 Char  R/C                                            PCFAST
#> 4395 Char  R/C                                              QVAL
#> 4396 Char    O                                           PCREFID
#> 4397 Char   HR                                            PCSPEC
#> 4398 Char    O                                  PCTEST; PCTESTCD
#> 4399 Char    O                                           PCORRES
#> 4400 Char    O                                          PCORRESU
#> 4401 Char   HR                                           STUDYID
#> 4402 Char   HR                                            SITEID
#> 4403 Char   HR                                            SUBJID
#> 4404 Char  R/C                                             VISIT
#> 4405 Char  R/C                                              <NA>
#> 4406 Char    O                                            PESTAT
#> 4407 Char    O                                             PECAT
#> 4408 Char    O                                            PESCAT
#> 4409 Char  R/C                                             PEDTC
#> 4410 Char    O                                             PEDTC
#> 4411 Char    O                                            PESPID
#> 4412 Char   HR                                  PETEST; PETESTCD
#> 4413 Char   HR                                           PEORRES
#> 4414 Char   HR                                           PEORRES
#> 4415 Char    O                                              <NA>
#> 4416 Char    O                                            PEEVAL
#> 4417 Char    O                                          PEREASND
#> 4418 Char    O                                          PEBODSYS
#> 4419 Char    O                                          PEMODIFY
#> 4420 Char    O                                             PELOC
#> 4421 Char    O                                             PELAT
#> 4422 Char    O                                              <NA>
#> 4423 Char    O                                              <NA>
#> 4424 Char    O                                          PEMETHOD
#> 4425 Char   HR                                           STUDYID
#> 4426 Char   HR                                            SITEID
#> 4427 Char   HR                                            SUBJID
#> 4428 Char  R/C                                             VISIT
#> 4429 Char  R/C                                              <NA>
#> 4430 Char    O                                             SCCAT
#> 4431 Char    O                                            SCSCAT
#> 4432 Char    O                                            SCSTAT
#> 4433 Char    O                                           SCGRPID
#> 4434 Char   HR                         SCORRES; SCTEST; SCTESTCD
#> 4435 Char   HR                                           STUDYID
#> 4436 Char   HR                                            SITEID
#> 4437 Char   HR                                            SUBJID
#> 4438 Char  R/C                                             VISIT
#> 4439 Char  R/C                                              <NA>
#> 4440 Char    O                                            VSSTAT
#> 4441 Char  R/C                                             VSDTC
#> 4442 Char  R/C                                             VSDTC
#> 4443 Char    O                                             VSCAT
#> 4444 Char    O                                            VSSCAT
#> 4445 Char    O                                           VSGRPID
#> 4446 Char  R/C                                             VSTPT
#> 4447 Char    O                                            VSSTAT
#> 4448 Char   HR                         VSORRES; VSTEST; VSTESTCD
#> 4449 Char  R/C                                          VSORRESU
#> 4450 Char    O                                           VSCLSIG
#> 4451 Char  R/C                                             VSPOS
#> 4452 Char    O                                             VSLOC
#> 4453 Char    O                                             VSLAT
#> 4454 Char   HR                                           STUDYID
#> 4455 Char   HR                                            SITEID
#> 4456 Char   HR                                            SUBJID
#> 4457 Char  R/C                                           BRTHDTC
#> 4458 Char  R/C                                           BRTHDTC
#> 4459 Char  R/C                                           BRTHDTC
#> 4460 Char    O                                           BRTHDTC
#> 4461  Num    O                                               AGE
#> 4462 Char    O                                              AGEU
#> 4463 Char  R/C                                             DMDTC
#> 4464 Char  R/C                                               SEX
#> 4465 Char    O                                            ETHNIC
#> 4466 Char    O                                              QVAL
#> 4467 Char  R/C                                              RACE
#> 4468 Char  R/C                                              QVAL
#> 4469 Char    O                                              QVAL
#> 4470 Char   HR                                           STUDYID
#> 4471 Char   HR                                            SITEID
#> 4472 Char   HR                                            SUBJID
#> 4473 Char  R/C                                           BRTHDTC
#> 4474 Char    O                                           BRTHDTC
#> 4475  Num    O                                               AGE
#> 4476 Char    O                                              AGEU
#> 4477 Char  R/C                                             DMDTC
#> 4478 Char  R/C                                               SEX
#> 4479 Char    O                                            ETHNIC
#> 4480 Char    O                                              QVAL
#> 4481 Char  R/C                                              RACE
#> 4482 Char  R/C                                              QVAL
#> 4483 Char    O                                              QVAL
#>         codelist_code codelist_submission_value
#> 3231             <NA>                      <NA>
#> 3232             <NA>                      <NA>
#> 3233             <NA>                      <NA>
#> 3234             <NA>                      <NA>
#> 3235             <NA>                      <NA>
#> 3236           C66742                        NY
#> 3237             <NA>                      <NA>
#> 3238             <NA>                      <NA>
#> 3239           C66742                        NY
#> 3240           C66742                        NY
#> 3241             <NA>                      <NA>
#> 3242             <NA>                      <NA>
#> 3243   C71620; C78417              UNIT; CMDOSU
#> 3244   C66726; C78418             FRM; CMDOSFRM
#> 3245   C71113; C78419            FREQ; CMDOSFRQ
#> 3246   C66729; C78420            ROUTE; CMROUTE
#> 3247             <NA>                      <NA>
#> 3248             <NA>                      <NA>
#> 3249           C66742                        NY
#> 3250           C66742                        NY
#> 3251             <NA>                      <NA>
#> 3252             <NA>                      <NA>
#> 3253             <NA>                      <NA>
#> 3254             <NA>                      <NA>
#> 3255             <NA>                      <NA>
#> 3256             <NA>                      <NA>
#> 3257             <NA>                      <NA>
#> 3258             <NA>                      <NA>
#> 3259             <NA>                      <NA>
#> 3260             <NA>                      <NA>
#> 3261           C66742                        NY
#> 3262             <NA>                      <NA>
#> 3263             <NA>                      <NA>
#> 3264           C66742                        NY
#> 3265           C66742                        NY
#> 3266             <NA>                      <NA>
#> 3267             <NA>                      <NA>
#> 3268             <NA>                      <NA>
#> 3269             <NA>                      <NA>
#> 3270             <NA>                      <NA>
#> 3271             <NA>                      <NA>
#> 3272             <NA>                      <NA>
#> 3273   C71620; C78417              UNIT; CMDOSU
#> 3274   C66726; C78418             FRM; CMDOSFRM
#> 3275   C71113; C78419            FREQ; CMDOSFRQ
#> 3276   C66729; C78420            ROUTE; CMROUTE
#> 3277             <NA>                      <NA>
#> 3278             <NA>                      <NA>
#> 3279           C66742                        NY
#> 3280           C66742                        NY
#> 3281             <NA>                      <NA>
#> 3282             <NA>                      <NA>
#> 3283             <NA>                      <NA>
#> 3284             <NA>                      <NA>
#> 3285             <NA>                      <NA>
#> 3286             <NA>                      <NA>
#> 3287             <NA>                      <NA>
#> 3288             <NA>                      <NA>
#> 3289             <NA>                      <NA>
#> 3290             <NA>                      <NA>
#> 3291             <NA>                      <NA>
#> 3292             <NA>                      <NA>
#> 3293             <NA>                      <NA>
#> 3294             <NA>                      <NA>
#> 3295             <NA>                      <NA>
#> 3296             <NA>                      <NA>
#> 3297             <NA>                      <NA>
#> 3298             <NA>                      <NA>
#> 3299             <NA>                      <NA>
#> 3300           C99079                     EPOCH
#> 3301           C66742                        NY
#> 3302             <NA>                      <NA>
#> 3303             <NA>                      <NA>
#> 3304             <NA>                      <NA>
#> 3305           C66742                        NY
#> 3306           C66742                        NY
#> 3307             <NA>                      <NA>
#> 3308          C125923                  BRDGMOOD
#> 3309             <NA>                      <NA>
#> 3310             <NA>                      <NA>
#> 3311           C66742                        NY
#> 3312   C66726; C78426             FRM; EXDOSFRM
#> 3313             <NA>                      <NA>
#> 3314             <NA>                      <NA>
#> 3315             <NA>                      <NA>
#> 3316             <NA>                      <NA>
#> 3317             <NA>                      <NA>
#> 3318   C71620; C78423              UNIT; EXDOSU
#> 3319   C71113; C78745            FREQ; EXDOSFRQ
#> 3320   C66729; C78425            ROUTE; EXROUTE
#> 3321             <NA>                      <NA>
#> 3322           C66742                        NY
#> 3323             <NA>                      <NA>
#> 3324           C66742                        NY
#> 3325             <NA>                      <NA>
#> 3326   C71620; C78427             UNIT; EXINTPU
#> 3327           C74456                       LOC
#> 3328           C99073                       LAT
#> 3329           C99074                       DIR
#> 3330             <NA>                      <NA>
#> 3331           C71620                      UNIT
#> 3332             <NA>                      <NA>
#> 3333   C71620; C78429             UNIT; EXFLRTU
#> 3334             <NA>                      <NA>
#> 3335           C66742                        NY
#> 3336             <NA>                      <NA>
#> 3337             <NA>                      <NA>
#> 3338             <NA>                      <NA>
#> 3339           C99079                     EPOCH
#> 3340           C66742                        NY
#> 3341             <NA>                      <NA>
#> 3342             <NA>                      <NA>
#> 3343             <NA>                      <NA>
#> 3344             <NA>                      <NA>
#> 3345             <NA>                      <NA>
#> 3346           C66742                        NY
#> 3347   C66726; C78426             FRM; EXDOSFRM
#> 3348             <NA>                      <NA>
#> 3349             <NA>                      <NA>
#> 3350             <NA>                      <NA>
#> 3351             <NA>                      <NA>
#> 3352             <NA>                      <NA>
#> 3353           C71620                      UNIT
#> 3354           C71113                      FREQ
#> 3355   C66729; C78425            ROUTE; EXROUTE
#> 3356             <NA>                      <NA>
#> 3357           C66742                        NY
#> 3358             <NA>                      <NA>
#> 3359           C66742                        NY
#> 3360             <NA>                      <NA>
#> 3361   C71620; C78427             UNIT; EXINTPU
#> 3362           C74456                       LOC
#> 3363             <NA>                      <NA>
#> 3364   C71620; C78428             UNIT; EXVOLTU
#> 3365             <NA>                      <NA>
#> 3366   C71620; C78429             UNIT; EXFLRTU
#> 3367             <NA>                      <NA>
#> 3368           C66742                        NY
#> 3369           C99073                       LAT
#> 3370           C99074                       DIR
#> 3371             <NA>                      <NA>
#> 3372             <NA>                      <NA>
#> 3373             <NA>                      <NA>
#> 3374             <NA>                      <NA>
#> 3375             <NA>                      <NA>
#> 3376           C66742                        NY
#> 3377             <NA>                      <NA>
#> 3378             <NA>                      <NA>
#> 3379           C66742                        NY
#> 3380           C66742                        NY
#> 3381             <NA>                      <NA>
#> 3382             <NA>                      <NA>
#> 3383             <NA>                      <NA>
#> 3384             <NA>                      <NA>
#> 3385             <NA>                      <NA>
#> 3386   C71620; C78417              UNIT; CMDOSU
#> 3387             <NA>                      <NA>
#> 3388             <NA>                      <NA>
#> 3389             <NA>                      <NA>
#> 3390             <NA>                      <NA>
#> 3391             <NA>                      <NA>
#> 3392             <NA>                      <NA>
#> 3393             <NA>                      <NA>
#> 3394             <NA>                      <NA>
#> 3395             <NA>                      <NA>
#> 3396           C66742                        NY
#> 3397             <NA>                      <NA>
#> 3398             <NA>                      <NA>
#> 3399             <NA>                      <NA>
#> 3400             <NA>                      <NA>
#> 3401          C101858                  PROCEDUR
#> 3402             <NA>                      <NA>
#> 3403           C66742                        NY
#> 3404           C66742                        NY
#> 3405             <NA>                      <NA>
#> 3406             <NA>                      <NA>
#> 3407           C66742                        NY
#> 3408             <NA>                      <NA>
#> 3409           C66742                        NY
#> 3410             <NA>                      <NA>
#> 3411             <NA>                      <NA>
#> 3412             <NA>                      <NA>
#> 3413             <NA>                      <NA>
#> 3414             <NA>                      <NA>
#> 3415           C71620                      UNIT
#> 3416           C71113                      FREQ
#> 3417           C66729                     ROUTE
#> 3418           C74456                       LOC
#> 3419           C99073                       LAT
#> 3420           C99074                       DIR
#> 3421           C99075                    PORTOT
#> 3422           C66742                        NY
#> 3423             <NA>                      <NA>
#> 3424           C66742                        NY
#> 3425             <NA>                      <NA>
#> 3426           C66742                        NY
#> 3427           C66742                        NY
#> 3428             <NA>                      <NA>
#> 3429             <NA>                      <NA>
#> 3430           C71620                      UNIT
#> 3431             <NA>                      <NA>
#> 3432             <NA>                      <NA>
#> 3433             <NA>                      <NA>
#> 3434             <NA>                      <NA>
#> 3435             <NA>                      <NA>
#> 3436             <NA>                      <NA>
#> 3437             <NA>                      <NA>
#> 3438             <NA>                      <NA>
#> 3439             <NA>                      <NA>
#> 3440             <NA>                      <NA>
#> 3441             <NA>                      <NA>
#> 3442             <NA>                      <NA>
#> 3443             <NA>                      <NA>
#> 3444             <NA>                      <NA>
#> 3445             <NA>                      <NA>
#> 3446           C66742                        NY
#> 3447           C66742                        NY
#> 3448   C78738; C83004                NCF; SUNCF
#> 3449             <NA>                      <NA>
#> 3450             <NA>                      <NA>
#> 3451             <NA>                      <NA>
#> 3452           C71113                      FREQ
#> 3453             <NA>                      <NA>
#> 3454             <NA>                      <NA>
#> 3455             <NA>                      <NA>
#> 3456           C71620                      UNIT
#> 3457             <NA>                      <NA>
#> 3458             <NA>                      <NA>
#> 3459             <NA>                      <NA>
#> 3460             <NA>                      <NA>
#> 3461             <NA>                      <NA>
#> 3462           C66742                        NY
#> 3463             <NA>                      <NA>
#> 3464             <NA>                      <NA>
#> 3465             <NA>                      <NA>
#> 3466             <NA>                      <NA>
#> 3467           C66742                        NY
#> 3468           C66742                        NY
#> 3469             <NA>                      <NA>
#> 3470             <NA>                      <NA>
#> 3471           C74456                       LOC
#> 3472           C99073                       LAT
#> 3473           C99074                       DIR
#> 3474           C99075                    PORTOT
#> 3475           C66742                        NY
#> 3476             <NA>                      <NA>
#> 3477             <NA>                      <NA>
#> 3478           C66769                     AESEV
#> 3479             <NA>                      <NA>
#> 3480           C66742                        NY
#> 3481           C66742                        NY
#> 3482             <NA>                      <NA>
#> 3483           C66742                        NY
#> 3484           C66742                        NY
#> 3485           C66742                        NY
#> 3486           C66742                        NY
#> 3487           C66742                        NY
#> 3488           C66742                        NY
#> 3489           C66742                        NY
#> 3490           C66742                        NY
#> 3491             <NA>                      <NA>
#> 3492           C66767                       ACN
#> 3493             <NA>                      <NA>
#> 3494           C66742                        NY
#> 3495             <NA>                      <NA>
#> 3496           C66768                       OUT
#> 3497           C66742                        NY
#> 3498           C66742                        NY
#> 3499             <NA>                      <NA>
#> 3500           C66742                        NY
#> 3501             <NA>                      <NA>
#> 3502           C66742                        NY
#> 3503             <NA>                      <NA>
#> 3504             <NA>                      <NA>
#> 3505             <NA>                      <NA>
#> 3506             <NA>                      <NA>
#> 3507             <NA>                      <NA>
#> 3508             <NA>                      <NA>
#> 3509             <NA>                      <NA>
#> 3510             <NA>                      <NA>
#> 3511             <NA>                      <NA>
#> 3512             <NA>                      <NA>
#> 3513             <NA>                      <NA>
#> 3514             <NA>                      <NA>
#> 3515             <NA>                      <NA>
#> 3516             <NA>                      <NA>
#> 3517             <NA>                      <NA>
#> 3518             <NA>                      <NA>
#> 3519           C66742                        NY
#> 3520             <NA>                      <NA>
#> 3521             <NA>                      <NA>
#> 3522           C66742                        NY
#> 3523           C66742                        NY
#> 3524             <NA>                      <NA>
#> 3525             <NA>                      <NA>
#> 3526           C74456                       LOC
#> 3527           C99073                       LAT
#> 3528           C99074                       DIR
#> 3529           C99075                    PORTOT
#> 3530           C66742                        NY
#> 3531             <NA>                      <NA>
#> 3532             <NA>                      <NA>
#> 3533             <NA>                      <NA>
#> 3534             <NA>                      <NA>
#> 3535             <NA>                      <NA>
#> 3536             <NA>                      <NA>
#> 3537             <NA>                      <NA>
#> 3538             <NA>                      <NA>
#> 3539             <NA>                      <NA>
#> 3540             <NA>                      <NA>
#> 3541             <NA>                      <NA>
#> 3542             <NA>                      <NA>
#> 3543             <NA>                      <NA>
#> 3544             <NA>                      <NA>
#> 3545             <NA>                      <NA>
#> 3546             <NA>                      <NA>
#> 3547             <NA>                      <NA>
#> 3548             <NA>                      <NA>
#> 3549             <NA>                      <NA>
#> 3550             <NA>                      <NA>
#> 3551             <NA>                      <NA>
#> 3552           C66742                        NY
#> 3553             <NA>                      <NA>
#> 3554             <NA>                      <NA>
#> 3555             <NA>                      <NA>
#> 3556             <NA>                      <NA>
#> 3557             <NA>                      <NA>
#> 3558             <NA>                      <NA>
#> 3559             <NA>                      <NA>
#> 3560             <NA>                      <NA>
#> 3561             <NA>                      <NA>
#> 3562             <NA>                      <NA>
#> 3563           C66742                        NY
#> 3564             <NA>                      <NA>
#> 3565             <NA>                      <NA>
#> 3566           C66742                        NY
#> 3567           C66742                        NY
#> 3568             <NA>                      <NA>
#> 3569             <NA>                      <NA>
#> 3570             <NA>                      <NA>
#> 3571             <NA>                      <NA>
#> 3572             <NA>                      <NA>
#> 3573             <NA>                      <NA>
#> 3574             <NA>                      <NA>
#> 3575             <NA>                      <NA>
#> 3576             <NA>                      <NA>
#> 3577           C71620                      UNIT
#> 3578           C66742                        NY
#> 3579             <NA>                      <NA>
#> 3580             <NA>                      <NA>
#> 3581             <NA>                      <NA>
#> 3582             <NA>                      <NA>
#> 3583             <NA>                      <NA>
#> 3584           C66742                        NY
#> 3585             <NA>                      <NA>
#> 3586             <NA>                      <NA>
#> 3587             <NA>                      <NA>
#> 3588             <NA>                      <NA>
#> 3589          C124301                  MHEDTTYP
#> 3590             <NA>                      <NA>
#> 3591           C66742                        NY
#> 3592           C66742                        NY
#> 3593           C66742                        NY
#> 3594           C66742                        NY
#> 3595           C66742                        NY
#> 3596             <NA>                      <NA>
#> 3597             <NA>                      <NA>
#> 3598           C74456                       LOC
#> 3599           C99073                       LAT
#> 3600           C99074                       DIR
#> 3601           C99075                    PORTOT
#> 3602             <NA>                      <NA>
#> 3603             <NA>                      <NA>
#> 3604             <NA>                      <NA>
#> 3605             <NA>                      <NA>
#> 3606             <NA>                      <NA>
#> 3607             <NA>                      <NA>
#> 3608             <NA>                      <NA>
#> 3609             <NA>                      <NA>
#> 3610             <NA>                      <NA>
#> 3611             <NA>                      <NA>
#> 3612             <NA>                      <NA>
#> 3613             <NA>                      <NA>
#> 3614             <NA>                      <NA>
#> 3615             <NA>                      <NA>
#> 3616             <NA>                      <NA>
#> 3617             <NA>                      <NA>
#> 3618             <NA>                      <NA>
#> 3619             <NA>                      <NA>
#> 3620           C66742                        NY
#> 3621             <NA>                      <NA>
#> 3622             <NA>                      <NA>
#> 3623             <NA>                      <NA>
#> 3624             <NA>                      <NA>
#> 3625             <NA>                      <NA>
#> 3626             <NA>                      <NA>
#> 3627             <NA>                      <NA>
#> 3628             <NA>                      <NA>
#> 3629             <NA>                      <NA>
#> 3630           C66742                        NY
#> 3631             <NA>                      <NA>
#> 3632             <NA>                      <NA>
#> 3633             <NA>                      <NA>
#> 3634          C101846                    CVTEST
#> 3635             <NA>                      <NA>
#> 3636             <NA>                      <NA>
#> 3637             <NA>                      <NA>
#> 3638           C71620                      UNIT
#> 3639             <NA>                      <NA>
#> 3640             <NA>                      <NA>
#> 3641           C66789                        ND
#> 3642             <NA>                      <NA>
#> 3643           C71148                  POSITION
#> 3644           C74456                       LOC
#> 3645           C99073                       LAT
#> 3646           C99074                       DIR
#> 3647           C85492                    METHOD
#> 3648           C78735                      EVAL
#> 3649           C96777                   MEDEVAL
#> 3650             <NA>                      <NA>
#> 3651             <NA>                      <NA>
#> 3652             <NA>                      <NA>
#> 3653             <NA>                      <NA>
#> 3654             <NA>                      <NA>
#> 3655           C66742                        NY
#> 3656             <NA>                      <NA>
#> 3657             <NA>                      <NA>
#> 3658             <NA>                      <NA>
#> 3659             <NA>                      <NA>
#> 3660           C78731                    DATEST
#> 3661             <NA>                      <NA>
#> 3662   C71620; C78421            UNIT; DAORRESU
#> 3663             <NA>                      <NA>
#> 3664             <NA>                      <NA>
#> 3665             <NA>                      <NA>
#> 3666             <NA>                      <NA>
#> 3667             <NA>                      <NA>
#> 3668           C66742                        NY
#> 3669             <NA>                      <NA>
#> 3670             <NA>                      <NA>
#> 3671             <NA>                      <NA>
#> 3672          C116107                     DTHDX
#> 3673             <NA>                      <NA>
#> 3674             <NA>                      <NA>
#> 3675           C78735                      EVAL
#> 3676             <NA>                      <NA>
#> 3677             <NA>                      <NA>
#> 3678             <NA>                      <NA>
#> 3679             <NA>                      <NA>
#> 3680             <NA>                      <NA>
#> 3681           C66742                        NY
#> 3682             <NA>                      <NA>
#> 3683           C66797                     IECAT
#> 3684             <NA>                      <NA>
#> 3685             <NA>                      <NA>
#> 3686             <NA>                      <NA>
#> 3687           C66742                        NY
#> 3688             <NA>                      <NA>
#> 3689             <NA>                      <NA>
#> 3690             <NA>                      <NA>
#> 3691             <NA>                      <NA>
#> 3692             <NA>                      <NA>
#> 3693           C66742                        NY
#> 3694             <NA>                      <NA>
#> 3695             <NA>                      <NA>
#> 3696             <NA>                      <NA>
#> 3697          C127270                    MUSCTS
#> 3698             <NA>                      <NA>
#> 3699             <NA>                      <NA>
#> 3700             <NA>                      <NA>
#> 3701           C71620                      UNIT
#> 3702             <NA>                      <NA>
#> 3703             <NA>                      <NA>
#> 3704             <NA>                      <NA>
#> 3705           C78736                     NRIND
#> 3706           C66789                        ND
#> 3707             <NA>                      <NA>
#> 3708           C71148                  POSITION
#> 3709           C74456                       LOC
#> 3710           C99073                       LAT
#> 3711           C99074                       DIR
#> 3712           C85492                    METHOD
#> 3713           C78735                      EVAL
#> 3714           C96777                   MEDEVAL
#> 3715           C66742                        NY
#> 3716             <NA>                      <NA>
#> 3717             <NA>                      <NA>
#> 3718             <NA>                      <NA>
#> 3719             <NA>                      <NA>
#> 3720             <NA>                      <NA>
#> 3721             <NA>                      <NA>
#> 3722           C66742                        NY
#> 3723             <NA>                      <NA>
#> 3724             <NA>                      <NA>
#> 3725             <NA>                      <NA>
#> 3726          C116103                    NVTEST
#> 3727             <NA>                      <NA>
#> 3728             <NA>                      <NA>
#> 3729             <NA>                      <NA>
#> 3730           C71620                      UNIT
#> 3731             <NA>                      <NA>
#> 3732             <NA>                      <NA>
#> 3733             <NA>                      <NA>
#> 3734             <NA>                      <NA>
#> 3735             <NA>                      <NA>
#> 3736           C78736                     NRIND
#> 3737           C66789                        ND
#> 3738             <NA>                      <NA>
#> 3739           C71148                  POSITION
#> 3740           C74456                       LOC
#> 3741           C99073                       LAT
#> 3742           C99074                       DIR
#> 3743           C85492                    METHOD
#> 3744           C78735                      EVAL
#> 3745           C96777                   MEDEVAL
#> 3746             <NA>                      <NA>
#> 3747           C66742                        NY
#> 3748             <NA>                      <NA>
#> 3749             <NA>                      <NA>
#> 3750             <NA>                      <NA>
#> 3751             <NA>                      <NA>
#> 3752             <NA>                      <NA>
#> 3753          C119013                   OEFOCUS
#> 3754           C66742                        NY
#> 3755             <NA>                      <NA>
#> 3756             <NA>                      <NA>
#> 3757          C117742                    OETEST
#> 3758             <NA>                      <NA>
#> 3759             <NA>                      <NA>
#> 3760             <NA>                      <NA>
#> 3761             <NA>                      <NA>
#> 3762           C71620                      UNIT
#> 3763             <NA>                      <NA>
#> 3764             <NA>                      <NA>
#> 3765             <NA>                      <NA>
#> 3766             <NA>                      <NA>
#> 3767             <NA>                      <NA>
#> 3768           C78736                     NRIND
#> 3769             <NA>                      <NA>
#> 3770             <NA>                      <NA>
#> 3771           C74456                       LOC
#> 3772           C99073                       LAT
#> 3773           C99074                       DIR
#> 3774           C99075                    PORTOT
#> 3775           C85492                    METHOD
#> 3776           C78735                      EVAL
#> 3777           C96777                   MEDEVAL
#> 3778           C66742                        NY
#> 3779             <NA>                      <NA>
#> 3780             <NA>                      <NA>
#> 3781             <NA>                      <NA>
#> 3782             <NA>                      <NA>
#> 3783             <NA>                      <NA>
#> 3784             <NA>                      <NA>
#> 3785           C66742                        NY
#> 3786             <NA>                      <NA>
#> 3787             <NA>                      <NA>
#> 3788             <NA>                      <NA>
#> 3789          C111107                    RETEST
#> 3790             <NA>                      <NA>
#> 3791             <NA>                      <NA>
#> 3792             <NA>                      <NA>
#> 3793           C71620                      UNIT
#> 3794             <NA>                      <NA>
#> 3795             <NA>                      <NA>
#> 3796             <NA>                      <NA>
#> 3797             <NA>                      <NA>
#> 3798             <NA>                      <NA>
#> 3799           C78736                     NRIND
#> 3800           C66789                        ND
#> 3801             <NA>                      <NA>
#> 3802           C71148                  POSITION
#> 3803           C74456                       LOC
#> 3804           C99073                       LAT
#> 3805           C99074                       DIR
#> 3806           C85492                    METHOD
#> 3807           C78735                      EVAL
#> 3808           C96777                   MEDEVAL
#> 3809           C66742                        NY
#> 3810             <NA>                      <NA>
#> 3811           C66742                        NY
#> 3812             <NA>                      <NA>
#> 3813             <NA>                      <NA>
#> 3814             <NA>                      <NA>
#> 3815             <NA>                      <NA>
#> 3816             <NA>                      <NA>
#> 3817             <NA>                      <NA>
#> 3818             <NA>                      <NA>
#> 3819           C66742                        NY
#> 3820             <NA>                      <NA>
#> 3821           C66742                        NY
#> 3822             <NA>                      <NA>
#> 3823          C106478                    RPTEST
#> 3824             <NA>                      <NA>
#> 3825           C71620                      UNIT
#> 3826             <NA>                      <NA>
#> 3827             <NA>                      <NA>
#> 3828             <NA>                      <NA>
#> 3829             <NA>                      <NA>
#> 3830             <NA>                      <NA>
#> 3831             <NA>                      <NA>
#> 3832 C118971; C124298           CCCAT; ONCRSCAT
#> 3833             <NA>                      <NA>
#> 3834           C66742                        NY
#> 3835             <NA>                      <NA>
#> 3836             <NA>                      <NA>
#> 3837           C78735                      EVAL
#> 3838           C96777                   MEDEVAL
#> 3839             <NA>                      <NA>
#> 3840             <NA>                      <NA>
#> 3841           C96781                    ONCRTS
#> 3842             <NA>                      <NA>
#> 3843           C71620                      UNIT
#> 3844             <NA>                      <NA>
#> 3845             <NA>                      <NA>
#> 3846             <NA>                      <NA>
#> 3847             <NA>                      <NA>
#> 3848             <NA>                      <NA>
#> 3849             <NA>                      <NA>
#> 3850             <NA>                      <NA>
#> 3851           C66742                        NY
#> 3852             <NA>                      <NA>
#> 3853             <NA>                      <NA>
#> 3854          C103330                    SCTEST
#> 3855             <NA>                      <NA>
#> 3856             <NA>                      <NA>
#> 3857             <NA>                      <NA>
#> 3858             <NA>                      <NA>
#> 3859             <NA>                      <NA>
#> 3860             <NA>                      <NA>
#> 3861             <NA>                      <NA>
#> 3862             <NA>                      <NA>
#> 3863             <NA>                      <NA>
#> 3864           C66789                        ND
#> 3865             <NA>                      <NA>
#> 3866           C78735                      EVAL
#> 3867           C96777                   MEDEVAL
#> 3868             <NA>                      <NA>
#> 3869             <NA>                      <NA>
#> 3870           C96778                    TRTEST
#> 3871             <NA>                      <NA>
#> 3872           C71620                      UNIT
#> 3873             <NA>                      <NA>
#> 3874             <NA>                      <NA>
#> 3875             <NA>                      <NA>
#> 3876             <NA>                      <NA>
#> 3877             <NA>                      <NA>
#> 3878             <NA>                      <NA>
#> 3879             <NA>                      <NA>
#> 3880             <NA>                      <NA>
#> 3881           C66742                        NY
#> 3882             <NA>                      <NA>
#> 3883           C78735                      EVAL
#> 3884           C96777                   MEDEVAL
#> 3885             <NA>                      <NA>
#> 3886             <NA>                      <NA>
#> 3887           C85492                    METHOD
#> 3888             <NA>                      <NA>
#> 3889           C96783                    TUTEST
#> 3890             <NA>                      <NA>
#> 3891           C74456                       LOC
#> 3892           C99073                       LAT
#> 3893           C99074                       DIR
#> 3894             <NA>                      <NA>
#> 3895             <NA>                      <NA>
#> 3896             <NA>                      <NA>
#> 3897             <NA>                      <NA>
#> 3898             <NA>                      <NA>
#> 3899             <NA>                      <NA>
#> 3900             <NA>                      <NA>
#> 3901           C66742                        NY
#> 3902             <NA>                      <NA>
#> 3903             <NA>                      <NA>
#> 3904             <NA>                      <NA>
#> 3905          C129941                    URNSTS
#> 3906             <NA>                      <NA>
#> 3907             <NA>                      <NA>
#> 3908             <NA>                      <NA>
#> 3909           C71620                      UNIT
#> 3910             <NA>                      <NA>
#> 3911             <NA>                      <NA>
#> 3912             <NA>                      <NA>
#> 3913           C66789                        ND
#> 3914             <NA>                      <NA>
#> 3915           C74456                       LOC
#> 3916           C99073                       LAT
#> 3917           C99074                       DIR
#> 3918           C85492                    METHOD
#> 3919           C78735                      EVAL
#> 3920           C96777                   MEDEVAL
#> 3921           C66742                        NY
#> 3922             <NA>                      <NA>
#> 3923           C66742                        NY
#> 3924             <NA>                      <NA>
#> 3925             <NA>                      <NA>
#> 3926             <NA>                      <NA>
#> 3927             <NA>                      <NA>
#> 3928             <NA>                      <NA>
#> 3929           C66742                        NY
#> 3930             <NA>                      <NA>
#> 3931             <NA>                      <NA>
#> 3932             <NA>                      <NA>
#> 3933             <NA>                      <NA>
#> 3934             <NA>                      <NA>
#> 3935             <NA>                      <NA>
#> 3936             <NA>                      <NA>
#> 3937           C67153                    VSTEST
#> 3938           C66789                        ND
#> 3939             <NA>                      <NA>
#> 3940           C71620                      UNIT
#> 3941           C66742                        NY
#> 3942           C74456                       LOC
#> 3943   C71148; C78431           POSITION; VSPOS
#> 3944           C99074                       DIR
#> 3945           C99073                       LAT
#> 3946             <NA>                      <NA>
#> 3947             <NA>                      <NA>
#> 3948             <NA>                      <NA>
#> 3949             <NA>                      <NA>
#> 3950             <NA>                      <NA>
#> 3951             <NA>                      <NA>
#> 3952           C66742                        NY
#> 3953           C66742                        NY
#> 3954             <NA>                      <NA>
#> 3955             <NA>                      <NA>
#> 3956             <NA>                      <NA>
#> 3957             <NA>                      <NA>
#> 3958             <NA>                      <NA>
#> 3959             <NA>                      <NA>
#> 3960           C71148                  POSITION
#> 3961             <NA>                      <NA>
#> 3962           C71620                      UNIT
#> 3963             <NA>                      <NA>
#> 3964             <NA>                      <NA>
#> 3965           C78736                     NRIND
#> 3966           C66789                        ND
#> 3967             <NA>                      <NA>
#> 3968           C78734                  SPECTYPE
#> 3969           C78733                  SPECCOND
#> 3970           C74456                       LOC
#> 3971           C99073                       LAT
#> 3972           C99074                       DIR
#> 3973           C99075                    PORTOT
#> 3974           C85492                    METHOD
#> 3975             <NA>                      <NA>
#> 3976           C66742                        NY
#> 3977           C78735                      EVAL
#> 3978           C96777                   MEDEVAL
#> 3979           C66742                        NY
#> 3980             <NA>                      <NA>
#> 3981             <NA>                      <NA>
#> 3982             <NA>                      <NA>
#> 3983             <NA>                      <NA>
#> 3984             <NA>                      <NA>
#> 3985           C66742                        NY
#> 3986             <NA>                      <NA>
#> 3987             <NA>                      <NA>
#> 3988             <NA>                      <NA>
#> 3989             <NA>                      <NA>
#> 3990             <NA>                      <NA>
#> 3991             <NA>                      <NA>
#> 3992             <NA>                      <NA>
#> 3993           C74456                       LOC
#> 3994           C99073                       LAT
#> 3995          C112023                    SRTEST
#> 3996             <NA>                      <NA>
#> 3997             <NA>                      <NA>
#> 3998             <NA>                      <NA>
#> 3999           C99074                       DIR
#> 4000           C78735                      EVAL
#> 4001           C96777                   MEDEVAL
#> 4002             <NA>                      <NA>
#> 4003           C71620                      UNIT
#> 4004           C78736                     NRIND
#> 4005           C66742                        NY
#> 4006             <NA>                      <NA>
#> 4007             <NA>                      <NA>
#> 4008             <NA>                      <NA>
#> 4009             <NA>                      <NA>
#> 4010             <NA>                      <NA>
#> 4011             <NA>                      <NA>
#> 4012             <NA>                      <NA>
#> 4013           C74558                     DSCAT
#> 4014             <NA>                      <NA>
#> 4015           C99079                     EPOCH
#> 4016 C114118; C150811        PROTMLST; OTHEVENT
#> 4017             <NA>                      <NA>
#> 4018             <NA>                      <NA>
#> 4019             <NA>                      <NA>
#> 4020           C66742                        NY
#> 4021             <NA>                      <NA>
#> 4022             <NA>                      <NA>
#> 4023             <NA>                      <NA>
#> 4024           C74558                     DSCAT
#> 4025             <NA>                      <NA>
#> 4026           C99079                     EPOCH
#> 4027           C66727                   NCOMPLT
#> 4028             <NA>                      <NA>
#> 4029             <NA>                      <NA>
#> 4030             <NA>                      <NA>
#> 4031             <NA>                      <NA>
#> 4032           C66742                        NY
#> 4033             <NA>                      <NA>
#> 4034             <NA>                      <NA>
#> 4035             <NA>                      <NA>
#> 4036             <NA>                      <NA>
#> 4037          C181163                    SARCRR
#> 4038             <NA>                      <NA>
#> 4039             <NA>                      <NA>
#> 4040             <NA>                      <NA>
#> 4041             <NA>                      <NA>
#> 4042             <NA>                      <NA>
#> 4043             <NA>                      <NA>
#> 4044             <NA>                      <NA>
#> 4045             <NA>                      <NA>
#> 4046             <NA>                      <NA>
#> 4047             <NA>                      <NA>
#> 4048             <NA>                      <NA>
#> 4049             <NA>                      <NA>
#> 4050             <NA>                      <NA>
#> 4051             <NA>                      <NA>
#> 4052             <NA>                      <NA>
#> 4053             <NA>                      <NA>
#> 4054             <NA>                      <NA>
#> 4055             <NA>                      <NA>
#> 4056             <NA>                      <NA>
#> 4057             <NA>                      <NA>
#> 4058             <NA>                      <NA>
#> 4059             <NA>                      <NA>
#> 4060             <NA>                      <NA>
#> 4061             <NA>                      <NA>
#> 4062           C66742                        NY
#> 4063             <NA>                      <NA>
#> 4064             <NA>                      <NA>
#> 4065             <NA>                      <NA>
#> 4066             <NA>                      <NA>
#> 4067             <NA>                      <NA>
#> 4068   C71620; C78421            UNIT; DAORRESU
#> 4069             <NA>                      <NA>
#> 4070             <NA>                      <NA>
#> 4071             <NA>                      <NA>
#> 4072             <NA>                      <NA>
#> 4073             <NA>                      <NA>
#> 4074           C66742                        NY
#> 4075             <NA>                      <NA>
#> 4076             <NA>                      <NA>
#> 4077             <NA>                      <NA>
#> 4078             <NA>                      <NA>
#> 4079             <NA>                      <NA>
#> 4080           C78735                      EVAL
#> 4081             <NA>                      <NA>
#> 4082             <NA>                      <NA>
#> 4083             <NA>                      <NA>
#> 4084             <NA>                      <NA>
#> 4085             <NA>                      <NA>
#> 4086             <NA>                      <NA>
#> 4087             <NA>                      <NA>
#> 4088           C66742                        NY
#> 4089             <NA>                      <NA>
#> 4090             <NA>                      <NA>
#> 4091           C71151                  EGMETHOD
#> 4092           C90013                    EGLEAD
#> 4093           C71148                  POSITION
#> 4094             <NA>                      <NA>
#> 4095             <NA>                      <NA>
#> 4096             <NA>                      <NA>
#> 4097             <NA>                      <NA>
#> 4098             <NA>                      <NA>
#> 4099             <NA>                      <NA>
#> 4100             <NA>                      <NA>
#> 4101             <NA>                      <NA>
#> 4102             <NA>                      <NA>
#> 4103             <NA>                      <NA>
#> 4104           C66742                        NY
#> 4105             <NA>                      <NA>
#> 4106           C71151                  EGMETHOD
#> 4107           C90013                    EGLEAD
#> 4108           C71148                  POSITION
#> 4109             <NA>                      <NA>
#> 4110             <NA>                      <NA>
#> 4111             <NA>                      <NA>
#> 4112           C71152                    EGTEST
#> 4113             <NA>                      <NA>
#> 4114   C71620; C78422            UNIT; EGORRESU
#> 4115           C66742                        NY
#> 4116             <NA>                      <NA>
#> 4117             <NA>                      <NA>
#> 4118             <NA>                      <NA>
#> 4119             <NA>                      <NA>
#> 4120             <NA>                      <NA>
#> 4121             <NA>                      <NA>
#> 4122             <NA>                      <NA>
#> 4123           C66742                        NY
#> 4124             <NA>                      <NA>
#> 4125             <NA>                      <NA>
#> 4126           C71151                  EGMETHOD
#> 4127           C90013                    EGLEAD
#> 4128           C71148                  POSITION
#> 4129             <NA>                      <NA>
#> 4130             <NA>                      <NA>
#> 4131             <NA>                      <NA>
#> 4132           C78735                      EVAL
#> 4133             <NA>                      <NA>
#> 4134           C66742                        NY
#> 4135             <NA>                      <NA>
#> 4136             <NA>                      <NA>
#> 4137             <NA>                      <NA>
#> 4138             <NA>                      <NA>
#> 4139             <NA>                      <NA>
#> 4140             <NA>                      <NA>
#> 4141             <NA>                      <NA>
#> 4142             <NA>                      <NA>
#> 4143             <NA>                      <NA>
#> 4144           C66742                        NY
#> 4145             <NA>                      <NA>
#> 4146             <NA>                      <NA>
#> 4147             <NA>                      <NA>
#> 4148             <NA>                      <NA>
#> 4149             <NA>                      <NA>
#> 4150             <NA>                      <NA>
#> 4151             <NA>                      <NA>
#> 4152             <NA>                      <NA>
#> 4153             <NA>                      <NA>
#> 4154             <NA>                      <NA>
#> 4155             <NA>                      <NA>
#> 4156           C66742                        NY
#> 4157             <NA>                      <NA>
#> 4158 C181179; C181178          GFTEST; GFTESTCD
#> 4159          C181180                   GFTSDTL
#> 4160           C85492                    METHOD
#> 4161             <NA>                      <NA>
#> 4162             <NA>                      <NA>
#> 4163             <NA>                      <NA>
#> 4164             <NA>                      <NA>
#> 4165           C71620                      UNIT
#> 4166             <NA>                      <NA>
#> 4167             <NA>                      <NA>
#> 4168             <NA>                      <NA>
#> 4169             <NA>                      <NA>
#> 4170             <NA>                      <NA>
#> 4171           C66742                        NY
#> 4172             <NA>                      <NA>
#> 4173             <NA>                      <NA>
#> 4174             <NA>                      <NA>
#> 4175             <NA>                      <NA>
#> 4176           C78734                  SPECTYPE
#> 4177             <NA>                      <NA>
#> 4178           C66742                        NY
#> 4179           C66742                        NY
#> 4180             <NA>                      <NA>
#> 4181             <NA>                      <NA>
#> 4182             <NA>                      <NA>
#> 4183             <NA>                      <NA>
#> 4184             <NA>                      <NA>
#> 4185             <NA>                      <NA>
#> 4186           C66742                        NY
#> 4187             <NA>                      <NA>
#> 4188             <NA>                      <NA>
#> 4189             <NA>                      <NA>
#> 4190             <NA>                      <NA>
#> 4191           C78734                  SPECTYPE
#> 4192             <NA>                      <NA>
#> 4193           C66742                        NY
#> 4194           C66742                        NY
#> 4195           C67154                    LBTEST
#> 4196             <NA>                      <NA>
#> 4197           C71620                      UNIT
#> 4198           C66742                        NY
#> 4199             <NA>                      <NA>
#> 4200           C85492                    METHOD
#> 4201             <NA>                      <NA>
#> 4202             <NA>                      <NA>
#> 4203             <NA>                      <NA>
#> 4204             <NA>                      <NA>
#> 4205             <NA>                      <NA>
#> 4206           C66742                        NY
#> 4207             <NA>                      <NA>
#> 4208             <NA>                      <NA>
#> 4209             <NA>                      <NA>
#> 4210             <NA>                      <NA>
#> 4211           C78734                  SPECTYPE
#> 4212             <NA>                      <NA>
#> 4213           C66742                        NY
#> 4214           C66742                        NY
#> 4215           C78733                  SPECCOND
#> 4216           C67154                    LBTEST
#> 4217             <NA>                      <NA>
#> 4218           C85492                    METHOD
#> 4219           C71620                      UNIT
#> 4220             <NA>                      <NA>
#> 4221             <NA>                      <NA>
#> 4222             <NA>                      <NA>
#> 4223             <NA>                      <NA>
#> 4224             <NA>                      <NA>
#> 4225           C78736                     NRIND
#> 4226           C66742                        NY
#> 4227             <NA>                      <NA>
#> 4228             <NA>                      <NA>
#> 4229             <NA>                      <NA>
#> 4230             <NA>                      <NA>
#> 4231             <NA>                      <NA>
#> 4232             <NA>                      <NA>
#> 4233           C66742                        NY
#> 4234             <NA>                      <NA>
#> 4235             <NA>                      <NA>
#> 4236             <NA>                      <NA>
#> 4237             <NA>                      <NA>
#> 4238             <NA>                      <NA>
#> 4239             <NA>                      <NA>
#> 4240           C78734                  SPECTYPE
#> 4241           C78733                  SPECCOND
#> 4242           C74456                       LOC
#> 4243           C99073                       LAT
#> 4244           C99074                       DIR
#> 4245             <NA>                      <NA>
#> 4246             <NA>                      <NA>
#> 4247             <NA>                      <NA>
#> 4248             <NA>                      <NA>
#> 4249             <NA>                      <NA>
#> 4250           C66742                        NY
#> 4251             <NA>                      <NA>
#> 4252             <NA>                      <NA>
#> 4253             <NA>                      <NA>
#> 4254             <NA>                      <NA>
#> 4255             <NA>                      <NA>
#> 4256             <NA>                      <NA>
#> 4257             <NA>                      <NA>
#> 4258             <NA>                      <NA>
#> 4259          C120528                    MBTEST
#> 4260             <NA>                      <NA>
#> 4261             <NA>                      <NA>
#> 4262           C71620                      UNIT
#> 4263           C66742                        NY
#> 4264             <NA>                      <NA>
#> 4265             <NA>                      <NA>
#> 4266           C78734                  SPECTYPE
#> 4267           C78733                  SPECCOND
#> 4268           C74456                       LOC
#> 4269           C99073                       LAT
#> 4270           C99074                       DIR
#> 4271           C85492                    METHOD
#> 4272           C78735                      EVAL
#> 4273             <NA>                      <NA>
#> 4274             <NA>                      <NA>
#> 4275             <NA>                      <NA>
#> 4276             <NA>                      <NA>
#> 4277             <NA>                      <NA>
#> 4278           C66742                        NY
#> 4279             <NA>                      <NA>
#> 4280             <NA>                      <NA>
#> 4281             <NA>                      <NA>
#> 4282             <NA>                      <NA>
#> 4283             <NA>                      <NA>
#> 4284           C78734                  SPECTYPE
#> 4285           C78733                  SPECCOND
#> 4286           C74456                       LOC
#> 4287           C99073                       LAT
#> 4288           C99074                       DIR
#> 4289             <NA>                      <NA>
#> 4290             <NA>                      <NA>
#> 4291             <NA>                      <NA>
#> 4292             <NA>                      <NA>
#> 4293             <NA>                      <NA>
#> 4294           C66742                        NY
#> 4295             <NA>                      <NA>
#> 4296             <NA>                      <NA>
#> 4297             <NA>                      <NA>
#> 4298             <NA>                      <NA>
#> 4299             <NA>                      <NA>
#> 4300             <NA>                      <NA>
#> 4301          C132262                      MITS
#> 4302          C125922                  MIFTSDTL
#> 4303             <NA>                      <NA>
#> 4304           C71620                      UNIT
#> 4305           C66742                        NY
#> 4306             <NA>                      <NA>
#> 4307             <NA>                      <NA>
#> 4308           C78734                  SPECTYPE
#> 4309           C78733                  SPECCOND
#> 4310           C74456                       LOC
#> 4311           C99073                       LAT
#> 4312           C99074                       DIR
#> 4313           C85492                    METHOD
#> 4314           C78735                      EVAL
#> 4315             <NA>                      <NA>
#> 4316             <NA>                      <NA>
#> 4317             <NA>                      <NA>
#> 4318             <NA>                      <NA>
#> 4319             <NA>                      <NA>
#> 4320           C66742                        NY
#> 4321             <NA>                      <NA>
#> 4322             <NA>                      <NA>
#> 4323             <NA>                      <NA>
#> 4324             <NA>                      <NA>
#> 4325             <NA>                      <NA>
#> 4326           C78734                  SPECTYPE
#> 4327           C78733                  SPECCOND
#> 4328           C74456                       LOC
#> 4329           C99073                       LAT
#> 4330           C99074                       DIR
#> 4331             <NA>                      <NA>
#> 4332             <NA>                      <NA>
#> 4333             <NA>                      <NA>
#> 4334             <NA>                      <NA>
#> 4335             <NA>                      <NA>
#> 4336             <NA>                      <NA>
#> 4337           C66742                        NY
#> 4338             <NA>                      <NA>
#> 4339             <NA>                      <NA>
#> 4340             <NA>                      <NA>
#> 4341             <NA>                      <NA>
#> 4342             <NA>                      <NA>
#> 4343             <NA>                      <NA>
#> 4344             <NA>                      <NA>
#> 4345             <NA>                      <NA>
#> 4346          C128687                    MSTEST
#> 4347             <NA>                      <NA>
#> 4348             <NA>                      <NA>
#> 4349             <NA>                      <NA>
#> 4350             <NA>                      <NA>
#> 4351             <NA>                      <NA>
#> 4352           C71620                      UNIT
#> 4353           C66742                        NY
#> 4354             <NA>                      <NA>
#> 4355             <NA>                      <NA>
#> 4356           C78734                  SPECTYPE
#> 4357           C78733                  SPECCOND
#> 4358           C74456                       LOC
#> 4359           C99073                       LAT
#> 4360           C99074                       DIR
#> 4361           C85492                    METHOD
#> 4362           C78735                      EVAL
#> 4363             <NA>                      <NA>
#> 4364             <NA>                      <NA>
#> 4365             <NA>                      <NA>
#> 4366             <NA>                      <NA>
#> 4367             <NA>                      <NA>
#> 4368           C66742                        NY
#> 4369           C66789                        ND
#> 4370             <NA>                      <NA>
#> 4371             <NA>                      <NA>
#> 4372             <NA>                      <NA>
#> 4373             <NA>                      <NA>
#> 4374             <NA>                      <NA>
#> 4375           C66742                        NY
#> 4376           C66742                        NY
#> 4377             <NA>                      <NA>
#> 4378           C78734                  SPECTYPE
#> 4379             <NA>                      <NA>
#> 4380             <NA>                      <NA>
#> 4381           C71620                      UNIT
#> 4382             <NA>                      <NA>
#> 4383             <NA>                      <NA>
#> 4384             <NA>                      <NA>
#> 4385             <NA>                      <NA>
#> 4386             <NA>                      <NA>
#> 4387           C66742                        NY
#> 4388             <NA>                      <NA>
#> 4389             <NA>                      <NA>
#> 4390             <NA>                      <NA>
#> 4391             <NA>                      <NA>
#> 4392             <NA>                      <NA>
#> 4393             <NA>                      <NA>
#> 4394           C66742                        NY
#> 4395           C66742                        NY
#> 4396             <NA>                      <NA>
#> 4397           C78734                  SPECTYPE
#> 4398             <NA>                      <NA>
#> 4399             <NA>                      <NA>
#> 4400             <NA>                      <NA>
#> 4401             <NA>                      <NA>
#> 4402             <NA>                      <NA>
#> 4403             <NA>                      <NA>
#> 4404             <NA>                      <NA>
#> 4405             <NA>                      <NA>
#> 4406           C66742                        NY
#> 4407             <NA>                      <NA>
#> 4408             <NA>                      <NA>
#> 4409             <NA>                      <NA>
#> 4410             <NA>                      <NA>
#> 4411             <NA>                      <NA>
#> 4412             <NA>                      <NA>
#> 4413             <NA>                      <NA>
#> 4414             <NA>                      <NA>
#> 4415           C66742                        NY
#> 4416           C78735                      EVAL
#> 4417             <NA>                      <NA>
#> 4418             <NA>                      <NA>
#> 4419             <NA>                      <NA>
#> 4420           C74456                       LOC
#> 4421           C99073                       LAT
#> 4422           C99074                       DIR
#> 4423           C99075                    PORTOT
#> 4424           C85492                    METHOD
#> 4425             <NA>                      <NA>
#> 4426             <NA>                      <NA>
#> 4427             <NA>                      <NA>
#> 4428             <NA>                      <NA>
#> 4429             <NA>                      <NA>
#> 4430             <NA>                      <NA>
#> 4431             <NA>                      <NA>
#> 4432           C66742                        NY
#> 4433             <NA>                      <NA>
#> 4434             <NA>                      <NA>
#> 4435             <NA>                      <NA>
#> 4436             <NA>                      <NA>
#> 4437             <NA>                      <NA>
#> 4438             <NA>                      <NA>
#> 4439             <NA>                      <NA>
#> 4440           C66742                        NY
#> 4441             <NA>                      <NA>
#> 4442             <NA>                      <NA>
#> 4443             <NA>                      <NA>
#> 4444             <NA>                      <NA>
#> 4445             <NA>                      <NA>
#> 4446             <NA>                      <NA>
#> 4447           C66789                        ND
#> 4448             <NA>                      <NA>
#> 4449           C71620                      UNIT
#> 4450           C66742                        NY
#> 4451   C71148; C78431           POSITION; VSPOS
#> 4452           C74456                       LOC
#> 4453           C99073                       LAT
#> 4454             <NA>                      <NA>
#> 4455             <NA>                      <NA>
#> 4456             <NA>                      <NA>
#> 4457             <NA>                      <NA>
#> 4458             <NA>                      <NA>
#> 4459             <NA>                      <NA>
#> 4460             <NA>                      <NA>
#> 4461             <NA>                      <NA>
#> 4462           C66781                      AGEU
#> 4463             <NA>                      <NA>
#> 4464           C66731                       SEX
#> 4465           C66790                    ETHNIC
#> 4466          C128690                   ETHNICC
#> 4467           C74457                      RACE
#> 4468          C128689                     RACEC
#> 4469             <NA>                      <NA>
#> 4470             <NA>                      <NA>
#> 4471             <NA>                      <NA>
#> 4472             <NA>                      <NA>
#> 4473             <NA>                      <NA>
#> 4474             <NA>                      <NA>
#> 4475             <NA>                      <NA>
#> 4476           C66781                      AGEU
#> 4477             <NA>                      <NA>
#> 4478           C66731                       SEX
#> 4479           C66790                    ETHNIC
#> 4480          C128690                   ETHNICC
#> 4481           C74457                      RACE
#> 4482          C128689                     RACEC
#> 4483             <NA>                      <NA>
get_cdash("CDASHIG", version = "2.1", domain = "LB")
#>      standard version    class domain                   scenario order variable
#> 1873  CDASHIG     2.1 Findings     LB         Central Processing     1  STUDYID
#> 1874  CDASHIG     2.1 Findings     LB         Central Processing     2   SITEID
#> 1875  CDASHIG     2.1 Findings     LB         Central Processing     3   SUBJID
#> 1876  CDASHIG     2.1 Findings     LB         Central Processing     4    VISIT
#> 1877  CDASHIG     2.1 Findings     LB         Central Processing     5   VISDAT
#> 1878  CDASHIG     2.1 Findings     LB         Central Processing     6   LBPERF
#> 1879  CDASHIG     2.1 Findings     LB         Central Processing     7    LBDAT
#> 1880  CDASHIG     2.1 Findings     LB         Central Processing     8    LBTIM
#> 1881  CDASHIG     2.1 Findings     LB         Central Processing     9    LBCAT
#> 1882  CDASHIG     2.1 Findings     LB         Central Processing    10   LBSCAT
#> 1883  CDASHIG     2.1 Findings     LB         Central Processing    11    LBTPT
#> 1884  CDASHIG     2.1 Findings     LB         Central Processing    12   LBCOND
#> 1885  CDASHIG     2.1 Findings     LB         Central Processing    13   LBFAST
#> 1886  CDASHIG     2.1 Findings     LB         Central Processing    14  LBREFID
#> 1887  CDASHIG     2.1 Findings     LB Central Processing with CS     1  STUDYID
#> 1888  CDASHIG     2.1 Findings     LB Central Processing with CS     2   SITEID
#> 1889  CDASHIG     2.1 Findings     LB Central Processing with CS     3   SUBJID
#> 1890  CDASHIG     2.1 Findings     LB Central Processing with CS     4    VISIT
#> 1891  CDASHIG     2.1 Findings     LB Central Processing with CS     5   VISDAT
#> 1892  CDASHIG     2.1 Findings     LB Central Processing with CS     6   LBPERF
#> 1893  CDASHIG     2.1 Findings     LB Central Processing with CS     7    LBDAT
#> 1894  CDASHIG     2.1 Findings     LB Central Processing with CS     8    LBTIM
#> 1895  CDASHIG     2.1 Findings     LB Central Processing with CS     9    LBCAT
#> 1896  CDASHIG     2.1 Findings     LB Central Processing with CS    10   LBSCAT
#> 1897  CDASHIG     2.1 Findings     LB Central Processing with CS    11    LBTPT
#> 1898  CDASHIG     2.1 Findings     LB Central Processing with CS    12   LBCOND
#> 1899  CDASHIG     2.1 Findings     LB Central Processing with CS    13   LBFAST
#> 1900  CDASHIG     2.1 Findings     LB Central Processing with CS    14   LBTEST
#> 1901  CDASHIG     2.1 Findings     LB Central Processing with CS    15  LBORRES
#> 1902  CDASHIG     2.1 Findings     LB Central Processing with CS    16 LBORRESU
#> 1903  CDASHIG     2.1 Findings     LB Central Processing with CS    17  LBCLSIG
#> 1904  CDASHIG     2.1 Findings     LB Central Processing with CS    18  LBREFID
#> 1905  CDASHIG     2.1 Findings     LB Central Processing with CS    19 LBMETHOD
#> 1906  CDASHIG     2.1 Findings     LB           Local Processing     1  STUDYID
#> 1907  CDASHIG     2.1 Findings     LB           Local Processing     2   SITEID
#> 1908  CDASHIG     2.1 Findings     LB           Local Processing     3   SUBJID
#> 1909  CDASHIG     2.1 Findings     LB           Local Processing     4    VISIT
#> 1910  CDASHIG     2.1 Findings     LB           Local Processing     5   VISDAT
#> 1911  CDASHIG     2.1 Findings     LB           Local Processing     6   LBPERF
#> 1912  CDASHIG     2.1 Findings     LB           Local Processing     7    LBDAT
#> 1913  CDASHIG     2.1 Findings     LB           Local Processing     8    LBTIM
#> 1914  CDASHIG     2.1 Findings     LB           Local Processing     9    LBCAT
#> 1915  CDASHIG     2.1 Findings     LB           Local Processing    10   LBSCAT
#> 1916  CDASHIG     2.1 Findings     LB           Local Processing    11    LBTPT
#> 1917  CDASHIG     2.1 Findings     LB           Local Processing    12   LBFAST
#> 1918  CDASHIG     2.1 Findings     LB           Local Processing    13   LBCOND
#> 1919  CDASHIG     2.1 Findings     LB           Local Processing    14 LBSPCCND
#> 1920  CDASHIG     2.1 Findings     LB           Local Processing    15   LBTEST
#> 1921  CDASHIG     2.1 Findings     LB           Local Processing    16  LBORRES
#> 1922  CDASHIG     2.1 Findings     LB           Local Processing    17 LBMETHOD
#> 1923  CDASHIG     2.1 Findings     LB           Local Processing    18 LBORRESU
#> 1924  CDASHIG     2.1 Findings     LB           Local Processing    19  LBCRESU
#> 1925  CDASHIG     2.1 Findings     LB           Local Processing    20  LBTOXGR
#> 1926  CDASHIG     2.1 Findings     LB           Local Processing    21    LBTOX
#> 1927  CDASHIG     2.1 Findings     LB           Local Processing    22 LBORNRLO
#> 1928  CDASHIG     2.1 Findings     LB           Local Processing    23 LBORNRHI
#> 1929  CDASHIG     2.1 Findings     LB           Local Processing    24  LBNRIND
#> 1930  CDASHIG     2.1 Findings     LB           Local Processing    25  LBCLSIG
#> 1931  CDASHIG     2.1 Findings     LB           Local Processing    26    LBNAM
#>                                        label
#> 1873                        Study Identifier
#> 1874                   Study Site Identifier
#> 1875        Subject Identifier for the Study
#> 1876                              Visit Name
#> 1877                              Visit Date
#> 1878                           Lab Performed
#> 1879                Specimen Collection Date
#> 1880                Specimen Collection Time
#> 1881                   Category for Lab Test
#> 1882                Subcategory for Lab Test
#> 1883             Lab Planned Time Point Name
#> 1884                  Lab Test Condition Met
#> 1885                      Lab Fasting Status
#> 1886                         Lab Specimen ID
#> 1887                        Study Identifier
#> 1888                   Study Site Identifier
#> 1889        Subject Identifier for the Study
#> 1890                              Visit Name
#> 1891                              Visit Date
#> 1892                           Lab Performed
#> 1893                Specimen Collection Date
#> 1894                Specimen Collection Time
#> 1895                   Category for Lab Test
#> 1896                Subcategory for Lab Test
#> 1897             Lab Planned Time Point Name
#> 1898                  Lab Test Condition Met
#> 1899                      Lab Fasting Status
#> 1900            Lab Test or Examination Name
#> 1901 Lab Result or Finding in Original Units
#> 1902                      Lab Original Units
#> 1903               Lab Clinical Significance
#> 1904                         Lab Specimen ID
#> 1905       Lab Method of Test or Examination
#> 1906                        Study Identifier
#> 1907                   Study Site Identifier
#> 1908        Subject Identifier for the Study
#> 1909                              Visit Name
#> 1910                              Visit Date
#> 1911                           Lab Performed
#> 1912                Specimen Collection Date
#> 1913                Specimen Collection Time
#> 1914                   Category for Lab Test
#> 1915                Subcategory for Lab Test
#> 1916             Lab Planned Time Point Name
#> 1917                      Lab Fasting Status
#> 1918                  Lab Test Condition Met
#> 1919                  Lab Specimen Condition
#> 1920            Lab Test or Examination Name
#> 1921 Lab Result or Finding in Original Units
#> 1922       Lab Method of Test or Examination
#> 1923                      Lab Original Units
#> 1924         Lab Collected Non-Standard Unit
#> 1925             Lab Standard Toxicity Grade
#> 1926                            Lab Toxicity
#> 1927  Lab Ref Range Lower Limit in Orig Unit
#> 1928  Lab Ref Range Upper Limit in Orig Unit
#> 1929           Lab Reference Range Indicator
#> 1930               Lab Clinical Significance
#> 1931                             Vendor Name
#>                                                                               question_text
#> 1873                                                          What is the study identifier?
#> 1874                                                           What is the site identifier?
#> 1875                            What [is/was] the (study) [subject/participant] identifier?
#> 1876                                                                What is the visit name?
#> 1877                                                   What [is/was] the date of the visit?
#> 1878                                      Was the sample collected?; Was the lab performed?
#> 1879                                      What was the date of the lab specimen collection?
#> 1880                              What was the (start) time of the lab specimen collection?
#> 1881                                                    What was the name of the lab panel?
#> 1882                                                What was the name of the lab sub-panel?
#> 1883                                            What was the planned time point of the lab?
#> 1884                                      Were the protocol-defined testing conditions met?
#> 1885                                                               Was the subject fasting?
#> 1886                What was the (laboratory test) [reference identifier/accession number]?
#> 1887                                                          What is the study identifier?
#> 1888                                                           What is the site identifier?
#> 1889                            What [is/was] the (study) [subject/participant] identifier?
#> 1890                                                                What is the visit name?
#> 1891                                                   What [is/was] the date of the visit?
#> 1892                                      Was the sample collected?; Was the lab performed?
#> 1893                                       What was the date of the lab specimen collection
#> 1894                              What was the (start) time of the lab specimen collection?
#> 1895                                                    What was the name of the lab panel?
#> 1896                                                What was the name of the lab sub-panel?
#> 1897                                            What was the planned time point of the lab?
#> 1898                                      Were the protocol-defined testing conditions met?
#> 1899                                                               Was the subject fasting?
#> 1900                                                            What was the lab test name?
#> 1901                                                   What was the result of the lab test?
#> 1902                                                   What was the unit of the lab result?
#> 1903                                                Was this result clinically significant?
#> 1904                What was the (laboratory test) [reference identifier/accession number]?
#> 1905                              What was the method used for the lab test or examination?
#> 1906                                                          What is the study identifier?
#> 1907                                                           What is the site identifier?
#> 1908                            What [is/was] the (study) [subject/participant] identifier?
#> 1909                                                                What is the visit name?
#> 1910                                                   What [is/was] the date of the visit?
#> 1911                                      Was the sample collected?; Was the lab performed?
#> 1912                                      What was the date of the lab specimen collection?
#> 1913                              What was the (start) time of the lab specimen collection?
#> 1914                                                    What was the name of the lab panel?
#> 1915                                                What was the name of the lab sub-panel?
#> 1916                                            What was the planned time point of the lab?
#> 1917                                                               Was the subject fasting?
#> 1918                                      Were the protocol-defined testing conditions met?
#> 1919                                                What was the condition of the specimen?
#> 1920                                                            What was the lab test name?
#> 1921                                                   What was the result of the lab test?
#> 1922                              What was the method used for the lab test or examination?
#> 1923                                                   What was the unit of the lab result?
#> 1924                                                   What was the unit of the lab result?
#> 1925                                                            What is the Toxicity Grade?
#> 1926                                               What is the description of the toxicity?
#> 1927                     What was the lower limit of the reference range for this lab test?
#> 1928                      What was the high limit of the reference range for this lab test?
#> 1929 How [did/do] the reported values compare within the [reference/normal/expected] range?
#> 1930                                                Was this result clinically significant?
#> 1931                                              What was the name of the laboratory used?
#>                                                         prompt type core
#> 1873                                          [Protocol/Study] Char   HR
#> 1874                                         Site (Identifier) Char   HR
#> 1875                        [Subject/Participant] (Identifier) Char   HR
#> 1876                                                   [Visit] Char  R/C
#> 1877                                              (Visit) Date Char  R/C
#> 1878                           Lab Performed; Sample Collected Char   HR
#> 1879                                           Collection Date Char  R/C
#> 1880                                   [Start] Collection Time Char  R/C
#> 1881                                    [Lab Panel Name]; NULL Char  R/C
#> 1882                                [Lab Sub-Panel Name]; NULL Char  R/C
#> 1883                                 [Planned Time Point Name] Char  R/C
#> 1884                                        Test Condition Met Char  R/C
#> 1885                                                   Fasting Char  R/C
#> 1886      (Laboratory) [Reference identifier/Accession Number] Char  R/C
#> 1887                                          [Protocol/Study] Char   HR
#> 1888                                         Site (Identifier) Char   HR
#> 1889                        [Subject/Participant] (Identifier) Char   HR
#> 1890                                                   [Visit] Char  R/C
#> 1891                                              (Visit) Date Char  R/C
#> 1892                           Lab Performed; Sample Collected Char   HR
#> 1893                                           Collection Date Char  R/C
#> 1894                                   [Start] Collection Time Char  R/C
#> 1895                                    [Lab Panel Name]; NULL Char  R/C
#> 1896                                [Lab Sub-Panel Name]; NULL Char  R/C
#> 1897                                 [Planned Time Point Name] Char  R/C
#> 1898                                        Test Condition Met Char    O
#> 1899                                                   Fasting Char  R/C
#> 1900                                    [Laboratory Test Name] Char   HR
#> 1901                                                  (Result) Char   HR
#> 1902                                                      Unit Char    O
#> 1903                                    Clinically Significant Char   HR
#> 1904 (Laboratory test) [Reference identifier/Accession Number] Char  R/C
#> 1905                             Method of Test or Examination Char    O
#> 1906                                          [Protocol/Study] Char   HR
#> 1907                                         Site (Identifier) Char   HR
#> 1908                        [Subject/Participant] (Identifier) Char   HR
#> 1909                                                   [Visit] Char  R/C
#> 1910                                              (Visit) Date Char  R/C
#> 1911                           Sample Collected; Lab Performed Char   HR
#> 1912                                           Collection Date Char  R/C
#> 1913                                   [Start] Collection Time Char  R/C
#> 1914                                    [Lab Panel Name]; NULL Char  R/C
#> 1915                                [Lab Sub-Panel Name]; NULL Char  R/C
#> 1916                                 [Planned Time Point Name] Char  R/C
#> 1917                                                   Fasting Char  R/C
#> 1918                                        Test Condition Met Char  R/C
#> 1919                                        Specimen Condition Char    O
#> 1920                                    [Laboratory Test Name] Char   HR
#> 1921                                                  (Result) Char   HR
#> 1922                              Method of [Test/Examination] Char    O
#> 1923                                                      Unit Char  R/C
#> 1924                                                      Unit Char    O
#> 1925                                            Toxicity Grade Char    O
#> 1926                                                  Toxicity Char    O
#> 1927                                  Normal Range Lower Limit Char  R/C
#> 1928                                  Normal Range Upper Limit Char  R/C
#> 1929           Comparison to [Reference/Expected/Normal] Range Char  R/C
#> 1930                                    Clinically Significant Char    O
#> 1931                                           Laboratory Name Char  R/C
#>         sdtmig_target codelist_code codelist_submission_value
#> 1873          STUDYID          <NA>                      <NA>
#> 1874           SITEID          <NA>                      <NA>
#> 1875           SUBJID          <NA>                      <NA>
#> 1876            VISIT          <NA>                      <NA>
#> 1877             <NA>          <NA>                      <NA>
#> 1878           LBSTAT        C66742                      <NA>
#> 1879            LBDTC          <NA>                      <NA>
#> 1880            LBDTC          <NA>                      <NA>
#> 1881            LBCAT          <NA>                      <NA>
#> 1882           LBSCAT          <NA>                      <NA>
#> 1883            LBTPT          <NA>                      <NA>
#> 1884             QVAL        C66742                      <NA>
#> 1885           LBFAST        C66742                      <NA>
#> 1886          LBREFID          <NA>                      <NA>
#> 1887          STUDYID          <NA>                      <NA>
#> 1888           SITEID          <NA>                      <NA>
#> 1889           SUBJID          <NA>                      <NA>
#> 1890            VISIT          <NA>                      <NA>
#> 1891             <NA>          <NA>                      <NA>
#> 1892           LBSTAT        C66742                      <NA>
#> 1893            LBDTC          <NA>                      <NA>
#> 1894            LBDTC          <NA>                      <NA>
#> 1895            LBCAT          <NA>                      <NA>
#> 1896           LBSCAT          <NA>                      <NA>
#> 1897            LBTPT          <NA>                      <NA>
#> 1898             QVAL        C66742                      <NA>
#> 1899           LBFAST        C66742                      <NA>
#> 1900 LBTEST; LBTESTCD        C67154                      <NA>
#> 1901          LBORRES          <NA>                      <NA>
#> 1902         LBORRESU        C71620                      <NA>
#> 1903             QVAL        C66742                      <NA>
#> 1904          LBREFID          <NA>                      <NA>
#> 1905         LBMETHOD        C85492                      <NA>
#> 1906          STUDYID          <NA>                      <NA>
#> 1907           SITEID          <NA>                      <NA>
#> 1908           SUBJID          <NA>                      <NA>
#> 1909            VISIT          <NA>                      <NA>
#> 1910             <NA>          <NA>                      <NA>
#> 1911           LBSTAT        C66742                      <NA>
#> 1912            LBDTC          <NA>                      <NA>
#> 1913            LBDTC          <NA>                      <NA>
#> 1914            LBCAT          <NA>                      <NA>
#> 1915           LBSCAT          <NA>                      <NA>
#> 1916            LBTPT          <NA>                      <NA>
#> 1917           LBFAST        C66742                      <NA>
#> 1918             QVAL        C66742                      <NA>
#> 1919         LBSPCCND        C78733                      <NA>
#> 1920 LBTESTCD; LBTEST        C67154                      <NA>
#> 1921          LBORRES          <NA>                      <NA>
#> 1922         LBMETHOD        C85492                      <NA>
#> 1923         LBORRESU        C71620                      <NA>
#> 1924             QVAL          <NA>                      <NA>
#> 1925          LBTOXGR          <NA>                      <NA>
#> 1926            LBTOX          <NA>                      <NA>
#> 1927         LBORNRLO          <NA>                      <NA>
#> 1928         LBORNRHI          <NA>                      <NA>
#> 1929          LBNRIND        C78736                      <NA>
#> 1930             QVAL        C66742                      <NA>
#> 1931            LBNAM          <NA>                      <NA>
get_cdash("CDASH", domain = "Findings")
#>      standard version    class domain order variable
#> 950     CDASH     1.3 Findings   <NA>     1     --YN
#> 951     CDASH     1.3 Findings   <NA>     2   --PERF
#> 952     CDASH     1.3 Findings   <NA>     3 --TESTCD
#> 953     CDASH     1.3 Findings   <NA>     4   --TEST
#> 954     CDASH     1.3 Findings   <NA>     5 --TSTDTL
#> 955     CDASH     1.3 Findings   <NA>     6    --CAT
#> 956     CDASH     1.3 Findings   <NA>     7   --SCAT
#> 957     CDASH     1.3 Findings   <NA>     8  --ORRES
#> 958     CDASH     1.3 Findings   <NA>     9 --ORRESU
#> 959     CDASH     1.3 Findings   <NA>    10  --CRESU
#> 960     CDASH     1.3 Findings   <NA>    11   --DESC
#> 961     CDASH     1.3 Findings   <NA>    12    --RES
#> 962     CDASH     1.3 Findings   <NA>    13 --RESOTH
#> 963     CDASH     1.3 Findings   <NA>    14 --RESCAT
#> 964     CDASH     1.3 Findings   <NA>    15 --ORNRLO
#> 965     CDASH     1.3 Findings   <NA>    16 --ORNRHI
#> 966     CDASH     1.3 Findings   <NA>    17 --CSTNRC
#> 967     CDASH     1.3 Findings   <NA>    18  --NRIND
#> 968     CDASH     1.3 Findings   <NA>    19   --STAT
#> 969     CDASH     1.3 Findings   <NA>    20 --REASND
#> 970     CDASH     1.3 Findings   <NA>    21    --NAM
#> 971     CDASH     1.3 Findings   <NA>    22  --LOINC
#> 972     CDASH     1.3 Findings   <NA>    23   --SPEC
#> 973     CDASH     1.3 Findings   <NA>    24 --ANTREG
#> 974     CDASH     1.3 Findings   <NA>    25 --SPCCND
#> 975     CDASH     1.3 Findings   <NA>    26 --CSPUFL
#> 976     CDASH     1.3 Findings   <NA>    27    --POS
#> 977     CDASH     1.3 Findings   <NA>    28    --LOC
#> 978     CDASH     1.3 Findings   <NA>    29    --LAT
#> 979     CDASH     1.3 Findings   <NA>    30    --DIR
#> 980     CDASH     1.3 Findings   <NA>    31 --LOCDTL
#> 981     CDASH     1.3 Findings   <NA>    32 --PORTOT
#> 982     CDASH     1.3 Findings   <NA>    33 --METHOD
#> 983     CDASH     1.3 Findings   <NA>    34   --LEAD
#> 984     CDASH     1.3 Findings   <NA>    35 --CSTATE
#> 985     CDASH     1.3 Findings   <NA>    36   --FAST
#> 986     CDASH     1.3 Findings   <NA>    37   --EVAL
#> 987     CDASH     1.3 Findings   <NA>    38 --EVALID
#> 988     CDASH     1.3 Findings   <NA>    39 --ACPTFL
#> 989     CDASH     1.3 Findings   <NA>    40    --TOX
#> 990     CDASH     1.3 Findings   <NA>    41  --TOXGR
#> 991     CDASH     1.3 Findings   <NA>    42    --SEV
#> 992     CDASH     1.3 Findings   <NA>    43  --CLSIG
#> 993     CDASH     1.3 Findings   <NA>    44 --DTHREL
#> 994     CDASH     1.3 Findings   <NA>    45  --CLLOQ
#> 995     CDASH     1.3 Findings   <NA>    46  --CULOQ
#> 996     CDASH     1.3 Findings   <NA>    47   --COND
#> 997     CDASH     1.3 Findings   <NA>    48 --REPNUM
#> 998     CDASH     1.3 Findings   <NA>    49  --DATFL
#> 999     CDASH     1.3 Findings   <NA>    50 --ENDATF
#> 1000    CDASH     1.3 Findings   <NA>    51    COVAL
#> 1001    CDASH     1.3 Findings   <NA>    52 --MODIFY
#> 1002    CDASH     1.3 Findings   <NA>    53 --BODSYS
#> 1003    CDASH     1.3 Findings   <NA>    54 --CNTMOD
#> 1004    CDASH     1.3 Findings   <NA>    55 --EPCHGI
#> 1005    CDASH     1.3 Findings   <NA>    56 --TMTHSN
#> 1006    CDASH     1.3 Findings   <NA>    57 --REASPF
#> 1007    CDASH     1.3 Findings   <NA>    58  --DISTR
#> 1008    CDASH     1.3 Findings   <NA>    59 --RESTYP
#> 1009    CDASH     1.3 Findings   <NA>    60 --RESSCL
#> 1010    CDASH     1.3 Findings   <NA>    61 --TSTCND
#> 1011    CDASH     1.3 Findings   <NA>    62 --CNDAGT
#> 1012    CDASH     1.3 Findings   <NA>    63 --BDAGNT
#> 1013    CDASH     1.3 Findings   <NA>    64 --TSTOPO
#> 1014    CDASH     1.3 Findings   <NA>    65 --COLSRT
#> 1015    CDASH     1.3 Findings   <NA>    66  --CHRON
#> 1016    CDASH     1.3 Findings   <NA>    67  --RUNID
#> 1108    CDASH     1.3 Findings     MS     1  MSAGENT
#> 1109    CDASH     1.3 Findings     MS     2   MSCONC
#> 1110    CDASH     1.3 Findings     MS     3  MSCONCU
#>                                             label domain_specific
#> 950                                 Any [Finding]              NA
#> 951                       [Observation] Performed              NA
#> 952      Short Name of Measurement, Test, or Exam              NA
#> 953            Name of Measurement, Test, or Exam              NA
#> 954       Measurement, Test or Examination Detail              NA
#> 955                                      Category              NA
#> 956                                   Subcategory              NA
#> 957           Result or Finding in Original Units              NA
#> 958                                Original Units              NA
#> 959                   Collected Non-Standard Unit              NA
#> 960                        Description of Finding              NA
#> 961                   Collected Result or Finding              NA
#> 962                                  Result Other              NA
#> 963                               Result Category              NA
#> 964      Normal Range Lower Limit- Original Units              NA
#> 965       Normal Range Upper Limit-Original Units              NA
#> 966      Collected Character/Ordinal Normal Range              NA
#> 967              Normal/Reference Range Indicator              NA
#> 968                             Completion Status              NA
#> 969                               Reason Not Done              NA
#> 970                        Laboratory/Vendor Name              NA
#> 971                                    LOINC Code              NA
#> 972                        Specimen Material Type              NA
#> 973                             Anatomical Region              NA
#> 974                            Specimen Condition              NA
#> 975             Collected Specimen Usability Flag              NA
#> 976        Position of Subject During Observation              NA
#> 977             Location Used for the Measurement              NA
#> 978                                    Laterality              NA
#> 979                                Directionality              NA
#> 980                               Location Detail              NA
#> 981                           Portion or Totality              NA
#> 982                 Method of Test or Examination              NA
#> 983       Lead Identified to Collect Measurements              NA
#> 984                           Consciousness State              NA
#> 985                                Fasting Status              NA
#> 986                                     Evaluator              NA
#> 987                          Evaluator Identifier              NA
#> 988                          Accepted Record Flag              NA
#> 989                                      Toxicity              NA
#> 990                                Toxicity Grade              NA
#> 991                                      Severity              NA
#> 992                         Clinical Significance              NA
#> 993                         Relationship to Death              NA
#> 994         Collected Lower Limit of Quantitation              NA
#> 995         Collected Upper Limit of Quantitation              NA
#> 996                            Test Condition Met              NA
#> 997                             Repetition Number              NA
#> 998       Same as Previous Sample Collection Date              NA
#> 999  Same as Current Sample Collection Start Date              NA
#> 1000                                      Comment              NA
#> 1001                                Modified Term              NA
#> 1002                   Body System or Organ Class              NA
#> 1003                                 Contact Mode              NA
#> 1004        Epi/Pandemic Related Change Indicator              NA
#> 1005                      Test Method Sensitivity              NA
#> 1006                        Reason Test Performed              NA
#> 1007              Distribution Pattern of Finding              NA
#> 1008                                  Result Type              NA
#> 1009                                 Result Scale              NA
#> 1010                               Test Condition              NA
#> 1011                         Test Condition Agent              NA
#> 1012                                Binding Agent              NA
#> 1013                   Test Operational Objective              NA
#> 1014                Collected Summary Result Type              NA
#> 1015                        Chronicity of Finding              NA
#> 1016                                       Run ID              NA
#> 1108                                   Agent Name            TRUE
#> 1109                          Agent Concentration            TRUE
#> 1110                    Agent Concentration Units            TRUE
#>                                                                                                                                                                                                                                                                           question_text
#> 950                                                               Has the subject had any [Findings topic(s)] ([study specific time frame])?; [Was/Were/Is] (there) [a/any] [Findings topic(s)] (reported/available) ([study specific time frame])?; Were all eligibility criteria met?
#> 951                                                                                                                              [Were (any)/Was (the)] [--TEST/topic] ([measurement(s)/test(s)/examination(s)/question(s)/assessment(s)/specimen(s)/sample(s)]) [performed/collected]?
#> 952                                                                                                                                                                                                                                                                                <NA>
#> 953                                                                                                                                                                                                 What [is/was] the name (of the [measurement/test/examination/question/assessment])?
#> 954                                                                                                                                                                                                   What [is/was] the [measurement/test/examination/question/assessment] detail name?
#> 955                                                                                                                                                                 What [is/was] the [type/category/name] (of the [measurement/test/examination/question/assessment/specimen/sample])?
#> 956                                                                                                                                                              What [is/was] the [type/subcategory/name] (of the [measurement/test/examination/question/assessment/specimen/sample])?
#> 957                                                                                                                                                           What [is/was] the [result/amount/(subject's) characteristic] (of the [measurement/test/examination/question/assessment])?
#> 958                                                                                                                                                                                                 What [is/was] the unit (of the [measurement/test/examination/question/assessment])?
#> 959                                                                                                                                                                                                 What [is/was] the unit (of the [measurement/test/examination/question/assessment])?
#> 960                                                                                                                                                                                            What [is/was] the (description) of the [(abnormality/observed finding/Sponsor-defined)]?
#> 961                                                                                                 What [is/was] the [result/amount] (of the [measurement/test/examination/question/assessment ] )?; [Is/Was] the result [normal/abnormal/absent/present/ sponsored defined response]?
#> 962                                                                                                                                                                                                                        If other is selected, [explain/specify/provide more detail]?
#> 963                                                                                                                                                                                      What [is/was] the result category (of the [measurement/test/examination/question/assessment])?
#> 964                                                                                                                                                                  What [is/was] the lower limit of the reference range (for the [measurement/test/examination/question/assessment])?
#> 965                                                                                                                                                                  What [is/was] the upper limit of the reference range (for the [measurement/test/examination/question/assessment])?
#> 966                                                                                                                                                                             What [is/was] the normal reference range (for this [measurement/test/examination/question/assessment])?
#> 967                                                                                                                                                                                              How [did/do] the reported values compare within the [reference/normal/expected] range?
#> 968                                                                                                                               Was the [--TEST ] not [completed/answered/done/assessed/evaluated]?; Indicate if (the [--TEST] was) not [answered/assessed/done/evaluated/performed].
#> 969                                                                                                                                    What [is/was] the reason that the [Findings topic/data/information/sponsor-defined phrase] was not [collected/answered/done/assessed/evaluated]?
#> 970                                                                                                                                                                                                                                             What was the name of the [vendor] used?
#> 971                                                                                                                                                                                                                                                       What [is/was] the LOINC code?
#> 972                                                                                                                                                                                                                                         What [is/was] the specimen (material) type?
#> 973                                                                                                                                                                                                 What [is/was] the anatomical or biological region (of the [organ specimen/tissue])?
#> 974                                                                                                                                                                                                                                        What [is/was] the condition of the specimen?
#> 975                                                                                                                                                                                                        What is/was the usability (of this specimen)?; [Is/Was] the specimen usable?
#> 976  In what position was the subject during the [measurement/test/examination/question/assessment/specimen collection/sample collection]?; What was the position of the subject (during the [measurement/test/examination/question/assessment/specimen collection/sample collection])?
#> 977                                                               What [is/was] the anatomical location (of the [measurement/test/examination/question/assessment])?; What [is/was] the anatomical location where the [measurement/specimen/question/assessment] was [taken/collected]?
#> 978                                                                                                                                                                      What [is/was] the side (of the anatomical location of the [measurement/test/examination/question/assessment])?
#> 979                                                                                                                                                            What [is/was] the directionality (of the anatomical location of the [measurement/test/examination/question/assessment])?
#> 980                                                                                                                    What [were/are] additional details on the exact location of the [finding] so that it can be distinguished from other [findings] in the same anatomical location?
#> 981                                                                                                                                                       What [is/was] the portion or totality (of the anatomical location of the [measurement/test/examination/question/assessment])?
#> 982                                                                                       What was the method (used for the [measurement/test/examination/question/assessment])?; What was the method (used to [measure/test/examine/question/assess/evaluate/identify] the [finding])?
#> 983                                                                                                                                                                                        What [is/was] the lead (used to measure [measurement/test/examination/question/assessment])?
#> 984                                                                                                                                                       What [is/was] the consciousness state of the subject (at the time of the [measurement/test/examination/question/assessment])?
#> 985                                                                                                                                                                                          [Is/Was] the subject fasting (prior to the [test being performed/sample being collected])?
#> 986                                                                                                                                                                                                      Who provided the (sponsor-defined phrase) information?; Who was the evaluator?
#> 987                                                                                                                                                             What [is/was] the identifier of the [evaluator name/reporter name] (providing the-sponsor-defined phrase- information)?
#> 988                                                                                                                                                                                                              [Is/Was] this record considered to be the [accepted/final] evaluation?
#> 989                                                                                                                                                                                                               What [is/was] the description of the [NCI CTCAE/scale name] toxicity?
#> 990                                                                                                                                                                                                                            What [is/was] the [NCI CTCAE Toxicity/scale name] grade?
#> 991                                                                                                                                                                                                                                        What [is/was] the severity (of the finding)?
#> 992                                                                                                                                                                                    [Is/Was] the ([measurement/test/examination/question/assessment]) result clinically significant?
#> 993                                                                                                                                                                                                                         [Is/Was] this findings related to the death of the subject?
#> 994                                                                                                                                                                                           What [is/was] the lower limit of quantification (for the [measurement/test/examination])?
#> 995                                                                                                                                                                                           What [is/was] the upper limit of quantification (for the [measurement/test/examination])?
#> 996                                                                                                                                                                                                                             [Are/Were] the protocol-defined testing conditions met?
#> 997                                                                                                                                             What was the repetition number within (the) [time point/visit/timeframe] (for this [measurement/test/examination/question/assessment])?
#> 998                                                                                                                                                       [Is/Was] this specimen/sample collected on the same date as the (last/previous specimen/sample) (collected/collection ended)?
#> 999                                                                                                                                                                       [Is/Was] this specimen/sample collection ended on the same day as the current specimen's/sample's start date?
#> 1000                                                                                                                                                                                                                                            [Protocol-specified Targeted Question]?
#> 1001                                                                                                                                                                                                                                                                               <NA>
#> 1002                                                                                                                                                                                                                                        What is/was the [body system/organ system]?
#> 1003                                                                                                                                                                                                                                                         What was the contact mode?
#> 1004                                                                                                                                                                                                                      Was the [event topic] changed due to an edidemic or pandemic?
#> 1005                                                                                                                                                                                                                                             What is the [test method] sensitivity?
#> 1006                                                                                                                                                                                                                                       What is the reason the [test] was performed?
#> 1007                                                                                                                                                                                             What is the [pattern/distribution] of the [findings/results] within the examined area?
#> 1008                                                                                                                                                                                                                       What is the [classification/type] of the [test/test result]?
#> 1009                                                                                                                                                                                                           What is the [scale classification/type] used for the [test/test result]?
#> 1010                                                                                                                                                                                                                                 What is the (planned) [condition] on the specimen?
#> 1011                                                                                                                                                                                                                                                What is the [test condition agent]?
#> 1012                                                                                                                                                                                                                                 What is the [binding agent] used for the [--test]?
#> 1013                                                                                                                                                                                                                          What is the [operational objective/reason] of the [test]?
#> 1014                                                                                                                                                                                                                          What type of [(summary)result for the test] is collected?
#> 1015                                                                                                                                                                                                                     What is the [chronicity of finding of the biological process]?
#> 1016                                                                                                                                                                                                                               What is the run-id for the [sample/batch/replicate]?
#> 1108                                                                                                                                                                   What is the name of the [(drug/material)] used for [genetic marker testing/phenotypic testing/in-vitro testing]?
#> 1109                                                                                                                                                                                                                                                 What is the [agent] concentration?
#> 1110                                                                                                                                                                                                                                            What is the [agent] concentration unit?
#>                                                                                                                               prompt
#> 950                                                                            Any [Findings topic(s)] ([study specific time frame])
#> 951  [--TEST/topic] ([Measurement (s)/Test(s)/Examination(s)/Specimen(s)/Assessment(s)/Question(s) Sample(s)]) [Performed/Collected]
#> 952                                                                                                                             <NA>
#> 953                                                                        [Measurement/Test/Examination/Question/Assessment] (Name)
#> 954                                                                 [Measurement/Test/Examination/Question/Assessment] Detail (Name)
#> 955                                                                                                  [Category/Category Value]; NULL
#> 956                                                                                           [(Domain Name/Name) Subcategory]; NULL
#> 957                                                                                         ([Result/Amount] of) [value from --TEST]
#> 958                                                                                                                             Unit
#> 959                                                                                                                             Unit
#> 960                                                                                                              (Abnormal) Findings
#> 961                                                                                         ([Result/Amount] of) [value from --TEST]
#> 962                                                                                          [Specify Other/Explain/Specify Details]
#> 963                                                                                                         [--TEST] Result Category
#> 964                                                                                                         Normal Range Lower Limit
#> 965                                                                                                         Normal Range Upper Limit
#> 966                                                                                                           Normal Reference Range
#> 967                                                                                  Comparison to [Reference/Expected/Normal] Range
#> 968                                                                                                                         Not Done
#> 969                                                                Reason Not [Answered/Collected/Done/Evaluated/Assessed/Available]
#> 970                                                                                                                    [Vendor Name]
#> 971                                                                                                                       LOINC Code
#> 972                                                                                                         Specimen (Material) Type
#> 973                                                                                        [Specimen/Organ/Tissue] Anatomical Region
#> 974                                                                                                               Specimen Condition
#> 975                                                                                                               Specimen Usability
#> 976                                                                                                                         Position
#> 977                                                                                                              Anatomical Location
#> 978                                                                                                                             Side
#> 979                                                                                                                   Directionality
#> 980                                                                                                        [Finding] Location Detail
#> 981                                                                                                              Portion or Totality
#> 982                                                                                                                           Method
#> 983                                                                                                                             Lead
#> 984                                                                                                              Consciousness State
#> 985                                                                                                                          Fasting
#> 986                                                                                                             [Evaluator/Reporter]
#> 987                                                                                                  [Evaluator/Reporter] Identifier
#> 988                                                                                                      [Accepted/Final] Evaluation
#> 989                                                                                                 [NCI CTCAE/Scale Name ] Toxicity
#> 990                                                                                            [NCI CTCAE Toxicity/scale name] Grade
#> 991                                                                                                                         Severity
#> 992                                                                         ([Measurement/Test/Examination/])/Clinically Significant
#> 993                                                                                                                 Related to Death
#> 994                                                                                                    Lower Limit of Quantification
#> 995                                                                                                    Upper Limit of Quantification
#> 996                                                                                                    Defined Testing Condition Met
#> 997                                                                      Repetition Number within (the) [time point/visit/timeframe]
#> 998                                                 Same as ([Last/Previous]) ([Specimen/Sample]) ([Collection/Collection End]) Date
#> 999                                                                        Same as Current (Specimen's/Sample Collection) Start Date
#> 1000                                                               [abbreviated version of the protocol-specified targeted question]
#> 1001                                                                                                                            <NA>
#> 1002                                                                                                      [Body System/Organ System]
#> 1003                                                                                                                    Contact Mode
#> 1004                                                                                           Epi/Pandemic Related Change Indicator
#> 1005                                                                                                       [Test Method] Sensitivity
#> 1006                                                                                                                [Test] Performed
#> 1007                                                                                                 Distribution Pattern of Finding
#> 1008                                                                                                                     Result Type
#> 1009                                                                                                                    Result Scale
#> 1010                                                                                                                  Test Condition
#> 1011                                                                                                          [Test Condition Agent]
#> 1012                                                                                                            [Test] Binding Agent
#> 1013                                                                                                    [Test] Operational Objective
#> 1014                                                                                               Collected [(summary) result] Type
#> 1015                                                                                                           Chronicity of Finding
#> 1016                                                                                                                          Run ID
#> 1108                                                                                                                      Agent Name
#> 1109                                                                                                           [Agent] Concentration
#> 1110                                                                                                      [Agent] Concentration Unit
#>      type sdtm_target codelist_code
#> 950  Char        <NA>        C66742
#> 951  Char      --STAT        C66742
#> 952  Char    --TESTCD          <NA>
#> 953  Char      --TEST          <NA>
#> 954  Char    --TSTDTL          <NA>
#> 955  Char       --CAT          <NA>
#> 956  Char      --SCAT          <NA>
#> 957  Char     --ORRES          <NA>
#> 958  Char    --ORRESU        C71620
#> 959  Char        QVAL          <NA>
#> 960  Char     --ORRES          <NA>
#> 961  Char     --ORRES          <NA>
#> 962  Char     --ORRES          <NA>
#> 963  Char    --RESCAT          <NA>
#> 964  Char    --ORNRLO          <NA>
#> 965  Char    --ORNRHI          <NA>
#> 966  Char     --STNRC          <NA>
#> 967  Char     --NRIND        C78736
#> 968  Char      --STAT        C66789
#> 969  Char    --REASND          <NA>
#> 970  Char       --NAM          <NA>
#> 971  Char     --LOINC          <NA>
#> 972  Char      --SPEC        C78734
#> 973  Char    --ANTREG          <NA>
#> 974  Char    --SPCCND        C78733
#> 975  Char    --SPCUFL        C66742
#> 976  Char       --POS        C71148
#> 977  Char       --LOC        C74456
#> 978  Char       --LAT        C99073
#> 979  Char       --DIR        C99074
#> 980  Char        QVAL          <NA>
#> 981  Char    --PORTOT        C99075
#> 982  Char    --METHOD        C85492
#> 983  Char      --LEAD          <NA>
#> 984  Char    --CSTATE          <NA>
#> 985  Char      --FAST        C66742
#> 986  Char      --EVAL        C78735
#> 987  Char    --EVALID        C96777
#> 988  Char    --ACPTFL        C66742
#> 989  Char       --TOX          <NA>
#> 990  Char     --TOXGR          <NA>
#> 991  Char       --SEV          <NA>
#> 992  Char     --CLSIG        C66742
#> 993  Char    --DTHREL        C66742
#> 994   Num      --LLOQ          <NA>
#> 995   Num      --ULOQ          <NA>
#> 996  Char        QVAL        C66742
#> 997  Char    --REPNUM          <NA>
#> 998  Char        <NA>          <NA>
#> 999  Char        <NA>          <NA>
#> 1000 Char       COVAL          <NA>
#> 1001 Char    --MODIFY          <NA>
#> 1002 Char    --BODSYS          <NA>
#> 1003 Char    --CNTMOD          <NA>
#> 1004 Char    --EPCHGI        C66742
#> 1005 Char    --TMTHSN       C179589
#> 1006 Char    --REASPF          <NA>
#> 1007 Char     --DISTR          <NA>
#> 1008 Char    --RESTYP       C179588
#> 1009 Char    --RESSCL       C177910
#> 1010 Char    --TSTCND          <NA>
#> 1011 Char    --CNDAGT          <NA>
#> 1012 Char    --BDAGNT          <NA>
#> 1013 Char    --TSTOPO          <NA>
#> 1014 Char    --COLSRT          <NA>
#> 1015 Char     --CHRON          <NA>
#> 1016 Char     --RUNID          <NA>
#> 1108 Char     MSAGENT          <NA>
#> 1109  Num      MSCONC          <NA>
#> 1110 Char     MSCONCU          <NA>
```
