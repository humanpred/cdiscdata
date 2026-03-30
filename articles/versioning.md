# Validity-Date Versioning Design

## The problem: storing many CT versions compactly

CDISC Controlled Terminology is released quarterly. Each release
contains roughly 45,000 rows. Storing every version as a separate file
would mean 45,000 × 40+ releases ≈ 1.8 million rows and significant
duplication, since most terms do not change between releases.

## The solution: validity-date design

`cdiscdata` uses a *validity-date* design. Each row represents a unique
**term-state**: the set of values for a term at a given point in time.

| Column       | Meaning                                                                              |
|--------------|--------------------------------------------------------------------------------------|
| `valid_from` | Date of the first CT release in which this term-state appeared                       |
| `valid_to`   | Date of the last CT release in which this term-state appeared; `NA` if still current |

When a term’s content changes between releases: 1. The old row is
*closed* by setting `valid_to = new_release_date - 1`. 2. A new row is
added with `valid_from = new_release_date` and `valid_to = NA`.

When a term is retired: - Its current row is closed with
`valid_to = retirement_date - 1`. - No new row is added.

## Querying a specific version

[`get_ct()`](https://humanpred.github.io/cdiscdata/reference/get_ct.md)
and
[`get_dataset()`](https://humanpred.github.io/cdiscdata/reference/get_dataset.md)
filter the table to rows valid at the requested date:

``` r
# Rows where valid_from <= query_date AND (valid_to >= query_date OR valid_to is NA)
tbl[tbl$valid_from <= query_date &
      (is.na(tbl$valid_to) | tbl$valid_to >= query_date), ]
```

The query date must exactly match one of the release dates returned by
[`available_ct_versions()`](https://humanpred.github.io/cdiscdata/reference/available_ct_versions.md).
This ensures reproducibility: the same version string always returns the
same rows.

## Growth rate

Because most terms are stable across releases, only a small fraction of
rows change per quarter (~1,000–1,500 new rows per release vs. 45,000+
total terms). The full historical archive therefore grows slowly,
keeping the package size manageable for CRAN submission.

## Example

``` r
# How many rows represent "closed" (historical) term states?
n_closed  <- sum(!is.na(ct_sdtm$valid_to))
n_current <- sum(is.na(ct_sdtm$valid_to))
cat("Current rows:", n_current, "\nHistorical rows:", n_closed, "\n")
#> Current rows: 46774 
#> Historical rows: 68588
```
