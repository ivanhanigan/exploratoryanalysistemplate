
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
txt1 <- cleaning_template(datevar = "date")
txt2 <- data_dictionary_template()
txt3 <- taxonomic_template(target_col = "species")
txt <- paste(txt1, txt2, txt3)
if(show_header){
  hd <- header_template(titl=titl, projdir=projdir, packagedir=packagedir, outfile=outdir, indir=indir, infile=infile)
  txt <- paste(hd, txt) 
}
if(show_geo){
  geo <- geographic_template(titl=titl, indir=indir)
  txt <- paste(txt, geo) 
}

# cat(txt)

return(txt)
}
