# Get path to a Define-XML XSD schema file

Get path to a Define-XML XSD schema file

## Usage

``` r
schema_path(define_version = c("2.1", "2.0"))
```

## Arguments

- define_version:

  One of `"2.1"` or `"2.0"`.

## Value

Full file path to the primary XSD file.

## Examples

``` r
schema_path("2.1")
#> [1] "/home/runner/work/_temp/Library/cdiscdata/extdata/schema/define-xml-2.1/define2-1-0.xsd"
schema_path("2.0")
#> [1] "/home/runner/work/_temp/Library/cdiscdata/extdata/schema/define-xml-2.0/define2-0-0.xsd"
```
