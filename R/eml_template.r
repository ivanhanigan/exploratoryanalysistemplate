
################################################################
eml_template <- function(outfile){
txt <- sprintf('

#### Write out a CSV and an EML file ####
unit_defs <- reml_boilerplate(dat, enumerated = NA)
col_defs <- names(dat)
ds <- eml_dataTable(dat,
              col.defs = col_defs,
              unit.defs = unit_defs,
              description = "TBA", 
              filename = "%s")
# now write EML metadata file
eml_config(creator="TBA")
eml_write(ds,
          file = "%s",
          title = "TBA"
)
', outfile, gsub(".csv", ".xml", outfile)
)

return(txt)
}
