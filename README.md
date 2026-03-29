
# cdiscdata

<!-- badges: start -->
[![R-CMD-check](https://github.com/humanpred/cdiscdata/actions/workflows/R-CMD-check.yaml/badge.svghttps://github.com/humanpred/cdiscdata/actions/workflows/R-CMD-check.yaml/badge.svghttps://github.com/humanpred/cdiscdata/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/humanpred/cdiscdata/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/humanpred/cdiscdata/graph/badge.svg)](https://app.codecov.io/gh/humanpred/cdiscdata)
<!-- badges: end -->

`cdiscdata` provides versioned CDISC Controlled Terminology (SDTM, ADaM)
and Define-XML schemas (XSD) and CDISC XSLT stylesheets. Uses a
validity-date design to store all historical CT versions compactly
without redundant row duplication. Intended as a shared data
dependency for pharmaverse-aligned packages.

## Installation

You can install the development version of cdiscdata from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("humanpred/cdiscdata")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(cdiscdata)
## basic example code
```
