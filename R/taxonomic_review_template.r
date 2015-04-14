
################################################################
# name:taxonomic_review_template

taxonomic_template <- function(target_col = "species"){
  
txt <- paste('
```{r echo = T, results = "asis", eval = F}
#### Taxonomic review ####
tx <- as.data.frame(table(dat$',target_col,'))
names(tx) <- c("',target_col,'", "Frequency")
write.csv(tx, file.path(outdir, gsub(".csv","_taxonomic_coverage.csv", outfile)), row.names = F)  
# Test new version?
tx <- as.data.frame(table(dat$',target_col,'))
names(tx) <- c("',target_col,'", "Frequency")
splist <- tx$',target_col,'
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
out3 <- sqldf(\'select submitted_name, matched_name2 as match_via_database, max(score) as max_database_score, "" as change_note, "" as update_to
  from out2
  group by submitted_name, matched_name2\')
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
idx <- names(table(dat$',target_col,'))
head(idx)
idy <- tx$submitted_name
head(idy)
idx[-which(idx in idy)]
idy[-which(idy in idx)]

# if all good then merge
dat <- merge(dat, tx, by.x = "',target_col,'", by.y = "submitted_name", all.x = T)
str(dat)

# reorder cols
paste(names(dat), collapse = "\',\'", sep = "")
namelist <- c("visitcode","surveyyear", "',target_col,'")

dat <- dat[,namelist]
names(dat) <- gsub("update_to" , "',target_col,'", names(dat))
str(dat)  
```
', sep = "")
#cat(txt)
return(txt)

}
