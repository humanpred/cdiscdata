## Resubmission

This is a resubmission of cdiscdata 0.2.0, a new package. In this version I
have addressed each of the reviewer's comments:

* **Acronyms in the Description.** Every acronym is now explained where it
  first appears: CDISC (Clinical Data Interchange Standards Consortium), CT
  (Controlled Terminology), SDTM (Study Data Tabulation Model), ADaM
  (Analysis Data Model), SDTMIG (SDTM Implementation Guide), SENDIG
  (Standard for Exchange of Nonclinical Data Implementation Guide), ADaMIG
  (ADaM Implementation Guide), CDASH (Clinical Data Acquisition Standards
  Harmonization), QRS (Questionnaires, Ratings, and Scales), XML (Extensible
  Markup Language), XSD (XML Schema Definition), and XSLT (Extensible
  Stylesheet Language Transformations).

* **References.** The package provides reference data from the CDISC
  standards with functions to retrieve it; it implements no published
  method, so there is no method reference to cite. The Description now links
  the CDISC standards in angle brackets, <https://www.cdisc.org/standards>.

* **Installing packages.** No function, example, or vignette installs a
  package. The one installation was in a test
  (tests/testthat/test-attach.R), which, when the tests ran from a source
  tree, built the package and installed it into a temporary library; that
  test was already skipped on CRAN. It no longer installs anything: it runs
  only against the installed copy that R CMD check provides and skips
  otherwise. pkgbuild, which only that test used, is removed from Suggests.

Since the first submission, the package also gained the variable metadata of
the remaining CDISC implementation guides, the CDASH model and
implementation guide, and the QRS supplements (see NEWS.md); the version
number is unchanged because 0.2.0 has not been released.

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new submission.

## Notes on the submission

* The package contains data (plus accessor functions) and has no runtime
  dependencies.
* Bundled third-party files are listed with their copyright holders and
  licenses in inst/COPYRIGHTS and in Authors@R: the Define-XML schema files
  (CDISC, MIT License) and stylesheets (Lex Jansen, MIT License). The CDISC
  Controlled Terminology data is published by the NCI Enterprise Vocabulary
  Services as a public-domain work of the US Government. The variable
  metadata of the CDISC standards carries only names, labels, types, and
  similar fields, not the standards' text.
* The words flagged by the spell check in DESCRIPTION (ADaM, ADaMIG, CDASH,
  CDISC, QRS, SDTM, SDTMIG, SENDIG, XSD, XSLT, pharmaverse) are standards
  names and acronyms, each explained in the Description.

## Test environments

* Local: Windows 11, R 4.6.1 (R CMD check --as-cran)
