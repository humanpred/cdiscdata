# Get path to a Define-XML XSLT stylesheet

Get path to a Define-XML XSLT stylesheet

## Usage

``` r
stylesheet_path(define_version = c("2.1", "2.0"))
```

## Arguments

- define_version:

  One of `"2.1"` or `"2.0"`.

## Value

Full file path to the XSL stylesheet.

## Examples

``` r
stylesheet_path("2.1")
#> [1] "/home/runner/work/_temp/Library/cdiscdata/extdata/stylesheet/define2-1-0.xsl"
stylesheet_path("2.0")
#> [1] "/home/runner/work/_temp/Library/cdiscdata/extdata/stylesheet/define2-0-0.xsl"
```
