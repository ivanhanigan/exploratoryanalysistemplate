
################################################################
exploratory_analysis_template <- function(
    projdir = ""
  ,
    packagedir =  ""
  ,
    outfile = ""
  ,
    indir = ""
  ,
    infile = ""
  ,
    titl = ""
  ,
    show_header = T
  ,
    show_geo = T  
    ){
  
txt <- taxonomic_template(target_col = "species")
if(show_header){
hd <- sprintf('
%s
---

```{r echo = T, results = "asis", eval = T}
projdir <- "%s"
outdir <- file.path(projdir, "%s")
# if(!file.exists(outdir)) dir.create(outdir)
outfile <- "%s"
file.path(outdir, outfile) 
setwd(outdir)
```
```{r, echo = TRUE, eval = FALSE}
library(gdata)
library(disentangle)
library(EML)
library(sqldf)
library(taxize)
indir <- "%s"

dir(indir)
infile <- "%s"

#### load ####
print(file.path(indir,infile))
dat <- read.csv(file.path(indir,infile), stringsAsFactors = F)
  
#### check ####
str(dat)

head(dat) 
tail(dat)
```
', titl, projdir, packagedir, outfile, indir, infile
)
txt <- paste(hd, txt) 
}

# cat(txt)

return(txt)
}
