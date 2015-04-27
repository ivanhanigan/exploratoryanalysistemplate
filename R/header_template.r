
################################################################
header_template <- function(titl, projdir, packagedir, outfile, indir, infile, libraries = c("sqldf")){
#  ```{r echo = T, results = "asis", eval = T}
hd <- sprintf('
"
%s
---
"

# Project: temp123
# Author: Your Name
# Maintainer: Who to complain to <yourfault@somewhere.net>

#### Set any global variables here ####
projdir <- "%s"
outdir <- file.path(projdir, "%s")
# if(!file.exists(outdir)) dir.create(outdir)
outfile <- "%s"
file.path(outdir, outfile) 
setwd(outdir)

#### Load any needed libraries #### 
library(gdata)
library(disentangle)
library(EML)
library(sqldf)
library(taxize)
indir <- "%s"

#### Identify your data inputs ####
dir(indir)
infile <- "%s"

', titl, projdir, packagedir, outfile, indir, infile
)
# ```
return(hd)
}
