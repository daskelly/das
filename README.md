# My personal `R` package

This package contains convenience functions that I use regularly.

Here are two helpful links that I used when building
this package:
 1. https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/
 2. http://kbroman.org/pkg_primer/

```r
library(devtools)
library(roxygen2)

setwd("~/repos")
create("das")
# manually add functions ...
# ...
setwd('./das')
document()
```

Two easy methods to keep code tidy and well-formatted:
```r
formatR::tidy_dir("R")
lintr::lint_package()
```
See [here](http://r-pkgs.had.co.nz/r.html).
