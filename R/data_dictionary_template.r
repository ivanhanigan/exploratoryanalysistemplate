
data_dictionary_template <- function(){
#   ```{r echo = T, results = "asis", eval = F}
# NB this may get out of sync with the current dataset, especially if species names columns are added, so the data dictionary that appears in the HTML report is always regenerated

txt <- paste('

#### Data Dictionary ####
## do a data dictionary and add the variable names and types
dd <- data_dictionary(show_levels = 20, dat)
write.csv(dd, file.path(outdir, gsub(".csv","_data_dictionary.csv", outfile)), row.names = F)
vl <- variable_names_and_labels(
  infile = file.path(indir, infile), datadict = dd, insert_labels = T)
vl
write.csv(vl, file.path(outdir, gsub(".csv","_variable_names_and_labels.csv", outfile)), row.names = F)

', sep = '')
#   ```
return(txt)
}
