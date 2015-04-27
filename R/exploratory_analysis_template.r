
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
    show_geo = F
  ,
    minimal = T
  ,
    rmarkdown = !minimal
  ,
    show_eml = T
    ){
txt0 <- load_template()
txt1 <- cleaning_template(datevar = "date")
txt2 <- data_dictionary_template()
txt3 <- taxonomic_template(target_col = "species")
txt <- paste(txt0, txt1, txt2, txt3)
if(show_header){
  hd <- header_template(titl=titl, projdir=projdir, packagedir=packagedir, outfile=outfile, indir=indir, infile=infile)
  txt <- paste(hd, txt) 
}
if(show_geo){
  geo <- geographic_template(titl=titl, indir=indir)
  txt <- paste(txt, geo) 
}
if(show_eml){
  eml <- eml_template()
  txt <- paste(txt, eml) 
}
  
# cat(txt)

return(txt)
}
