EDA template
---

This is designed to create code snippets.  These can be used as standalone R scripts or incorporated into complicated workflows such as ProjectTemplate [http://projecttemplate.net/](http://projecttemplate.net/) or [http://cran.r-project.org/web/packages/makeProject/index.html](http://cran.r-project.org/web/packages/makeProject/index.html)

#### To install
    library(devtools)
    install_bitbucket(repo = "exploratoryanalysistemplate", username = "asn-ltern")
    
    
#### To use
    textdata <- exploratory_analysis_template(
      projdir = "~/path/to/project",
      packagedir =  "a_package_is_a_discrete_chunk_of_work",
      outfile = "this_is_the_result.csv",
      indir = "~/path/to/input/data",
      infile = "this_is_the_input_data.csv",
      titl = "Title of the code snippet",
      show_header = TRUE)
    cat(textdata)
    # check the codes, if ok sink to a r markdown script
    sink("tests/test_taxo_review.Rmd")
    cat(textdata)
    sink()

#### Results 
    Title of the code snippet
    ---
     
    ```{r echo = T, results = "asis", eval = T}
    projdir <- "~/path/to/project"
    outdir <- file.path(projdir, "a_package_is_a_discrete_chunk_of_work")
    # if(!file.exists(outdir)) dir.create(outdir)
    outfile <- "this_is_the_result.csv"
    file.path(outdir, outfile) 
    setwd(outdir)
    ```
    ```{r, echo = TRUE, eval = FALSE}
    library(gdata)
    library(disentangle)
    library(EML)
    library(sqldf)
    library(taxize)
    indir <- "~/path/to/input/data"
     
    dir(indir)
    infile <- "this_is_the_input_data.csv"
     
    #### load ####
    print(file.path(indir,infile))
    dat <- read.csv(file.path(indir,infile), stringsAsFactors = F)
      
    #### check ####
    str(dat)
     
    head(dat) 
    tail(dat)
    ```
     
    ```{r echo = T, results = "asis", eval = F}
    #### Taxonomic review ####
    tx <- as.data.frame(table(dat$species))
    names(tx) <- c("species", "Frequency")
    write.csv(tx, file.path(outdir, gsub(".csv","_taxonomic_coverage.csv", outfile)), row.names = F)  
    # Test new version?
    tx <- as.data.frame(table(dat$species))
    names(tx) <- c("species", "Frequency")
    splist <- tx$species
    sources <- gnr_datasources()
    sources
     
    eol <- sources$id[sources$title == "EOL"]
    gbif_backbone <- sources$id[sources$title == "GBIF Backbone Taxonomy"]
    ipni <- sources$id[sources$title == "The International Plant Names Index"]
    zk <- sources$id[sources$title == "ZooKeys"]
    zb <- sources$id[sources$title == "ZooBank"]
    c(eol, gbif_backbone, ipni, zk, zb)
    out <- gnr_resolve(splist, data_source_ids=c(eol, gbif_backbone, ipni, zk, zb), stripauthority=TRUE)
     
    out2 <- unique(out$results)
    out3 <- sqldf('select submitted_name, matched_name2 as match_via_database, max(score) as max_database_score, "" as change_note, "" as update_to
      from out2
      group by submitted_name, matched_name2')
    out3[which(out3$submitted_name == out3$match_via_database),"max_database_score"] <- ""
    out3[which(out3$submitted_name == out3$match_via_database),"match_via_database"] <- ""
    out3
    write.csv(out3, file.path(outdir, gsub(".csv","_taxonomic_coverage.csv", outfile)), row.names = F)  
    #### TODO: 
    # you should go to this CSV file and edit the final columns, 
    # take notes on decisions and create the updates list.  Save as new file with 2.csv at end.
    ####
     
    # Post review merge fixed names and remove old names
    dir(outdir)
    tx_file <- "xxx_taxonomic_coverage2.csv"
    tx <- read.csv(file.path(outdir, tx_file), stringsAsFactor = F)
    nrow(tx)
    head(tx)
    tx[tx[,grep("change_note", names(tx))]!="",]                                          
    str(dat)
     
    # check that linking variable is identical
    idx <- names(table(dat$species))
    head(idx)
    idy <- tx$submitted_name
    head(idy)
    idx[-which(idx in idy)]
    idy[-which(idy in idx)]
     
    # if all good then merge
    dat <- merge(dat, tx, by.x = "species", by.y = "submitted_name", all.x = T)
    str(dat)
     
    # reorder cols
    paste(names(dat), collapse = "','", sep = "")
    namelist <- c("visitcode","surveyyear", "species")
     
    dat <- dat[,namelist]
    names(dat) <- gsub("update_to" , "species", names(dat))
    str(dat)  
    ```
