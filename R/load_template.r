
################################################################
load_template <- function(){
#   ```{r, echo = TRUE, eval = FALSE}
ld <- '
#### load ####
print(file.path(indir,infile))
dat <- read.csv(file.path(indir,infile), stringsAsFactors = F)
    
#### check ####
str(dat)
# write down the nrows and ncols here for future reference
head(dat) 
tail(dat)
summary(dat)
# lapply(dat, table)
'
# ```
return(ld)
}
