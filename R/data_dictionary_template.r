
data_dictionary_template <- function(){
#   ```{r echo = T, results = "asis", eval = F}
# NB this may get out of sync with the current dataset, especially if species names columns are added, so the data dictionary that appears in the HTML report is always regenerated

txt <- paste('

#### Data Dictionary ####
## do a data dictionary and add the variable names and types
dd <- data_dictionary(show_levels = 20, dat)
write.csv(dd, file.path(outdir, gsub(".csv","_data_dictionary.csv", outfile)), row.names = F)

#### now get variable names ####
dd$ordering <- 1:nrow(dd)
col_defs <- sqldf("
select Variable, Type
from dd
group by Variable, Type
order by ordering
")
col_defs <- col_defs[col_defs$Variable != "",]
col_defs

## the original names are treated as the labels.  To be expanded on during DDF
variable_labels <- read.csv(file.path(indir,infile), nrows = 1, header = F, stringsAsFactors = F)
variable_labels
vl <- as.data.frame(cbind(col_defs,t(variable_labels[1,])))
names(vl) <- c("ltern_name", "simple_type", "original_name")
vl$description <- ""
vl$nominal_ordinal_interval_ratio_date_time <- ""
vl$unit_of_measurement <- ""
vl$value_labels <- ""
vl$issue_description_and_suggested_change <- ""
vl$depositor_response <- ""
vl
write.csv(vl, file.path(outdir, gsub(".csv","_variable_names_and_labels.csv", outfile)), row.names = F)

', sep = '')
#   ```
return(txt)
}
