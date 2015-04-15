
################################################################
geographic_template <- function(titl, indir){
txt <- sprintf('
%s Geographic Coverage 
---

- plots are shown in map

![alttext](map.png)

```{r echo = TRUE, results = "asis", eval = FALSE}
#require(devtools)
#install_github("disentangle", "ivanhanigan")
require(disentangle)
require(xtable)
require(rgdal)
require(gisviz)

## if using coordinates supplied
gis_dir <- "%s"
flist <- dir(gis_dir)
#flist
# flist[grep(XXX, flist)]
fi = "xxx.shp"
#d <- read.csv()
#epsg <- make_EPSG()
## epsg[grep("GDA94$", epsg$note),]
#projection  <- "4283"
#shp <- SpatialPointsDataFrame(cbind(d$lon, d$lat), d,
#  proj4string=CRS(epsg$prj4[grep(projection,epsg$code)]))

wd <- getwd()
setwd(gis_dir)
shp <- readOGR(fi,
               gsub(".shp", "", basename(fi))
               )
setwd(wd)
#str(shp)
loc  <- morpho_bounding_box(x = shp)
#loc
png("map.png")
plotMyMap(shp, xl = c(100,155), yl = c(-45, -10))
dev.off()
print(xtable(loc), type = "html")
```
', titl, indir)
return(txt)
}
