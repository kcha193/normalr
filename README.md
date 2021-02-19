# normalr
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/normalr)](https://cran.r-project.org/package=normalr)
[![Build Status](https://travis-ci.org/kcha193/normalr.png?branch=master)](https://travis-ci.org/kcha193/normalr)
[![Coverage Status](https://img.shields.io/codecov/c/github/kcha193/normalr/master.svg)](https://codecov.io/github/kcha193/normalr?branch=master)
[![Rdoc](http://www.rdocumentation.org/badges/version/normalr)](http://www.rdocumentation.org/packages/normalr)


The normalr allows you to perform normalisation on multiple variables in large-scale datasets. 

## Installation

normalr is available from CRAN. Install it with:

``` r
install.packages("normalr")
```

You can install normalr from github with:

``` r
# install.packages("devtools")
devtools::install_github("kcha193/normalr")
```
## Examples

The following example uses normalr to normalise 11 continous variables in mtcars dataset.

```R
library(normalr)

normaliseData(mtcars, getLambda(mtcars))
```

## Shiny apps

The following example run a shiny appliaction uses normalr to normalise any dataset that the user input.

```R
library(normalr)

normalrShiny()
```
The shiny app is also available from [shinyapps.io](https://autopsych.shinyapps.io/normalr/).


## Citation

To cite this R package, please use the following,
Courtney, M. G. R., and Chang, K. C. (2018) Dealing with non-normality: an introduction and step-by-step guide using R. TEST, doi: 10.1111/test.12154.
