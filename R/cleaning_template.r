
################################################################
cleaning_template <- function(datevar = "date"){
txt <- paste('
```{r echo = T, results = "asis", eval = F}
#### clean ####
names(dat) <- lcu(names(dat))    
## Dates
# If you see a date variable need to change it (R reads CSV dates as text)
# to first test the conversion just do one
dat$',datevar,'[1]        
as.Date(dat$',datevar,'[1], format = "%d/%m/%Y")
# if that worked then do the whole vector
dat$',datevar,' <- as.Date(dat$',datevar,', format = "%d/%m/%Y")
table(dat$',datevar,')
## nominal variables coded with integers
# these can be coerced to character
for(i in c("pqplot", "row", "column")){
  print(table(dat[,i]))
  dat[,i] <- as.character(dat[,i])
}
## Species is a reserved word only allowed for lists of proper names
# otherwise we use descriptor
names(dat) <- gsub("species", "fauna_descriptor", names(dat))
str(dat)
```', sep = '')
return(txt)
}
