##helpers.R

## Functions called from vs-app server.R.  


##vsMap() cleans county FIPS codes and dates.  Adds DURATION column.  

vsMap <- function(map)  {
  
  ### Create 5-digit FIPS codes from county codes
  for (i in 1:nrow(map))  {
            if (map$STATE[i] =="TX")  map$region[i] <-as.numeric(sprintf("48%s", sprintf("%03d", map$region[i])))
            if (map$STATE[i] == "CO")  map$region[i] <- as.numeric(sprintf("08%s", sprintf("%03d", map$region[i])))
            if (map$STATE[i] == "NM") map$region[i] <- as.numeric(sprintf("35%s", sprintf("%03d", map$region[i])))
     }
  
  ### Create new column of outbreak duration
  map$DATE<-as.Date(map$DATE, "%m/%d/%Y")     # Convert dates to class "Date"
  DURATION<-as.numeric(map$DATE-map$DATE[1]) 
  data.frame(DURATION, map)
}




##update.DF() creates a data frame of all U.S. county FIPS and fills by cumulative outbreak cases
## in each county.  Default is NA so that map initially renders white 

update.DF <- function(MAP, day)  {
    
  cases = subset(MAP, MAP$DURATION == day)
  for(i in 1:nrow(cases))  {
    df[df$region==cases$region[i], 2] = cases$CUMULATIVE[i]    #Replaces $value with $CUMULATIVE for each $region
    }
  
  choroplethr(df, lod="county", num_buckets=9, warn_na=FALSE, renderAsInsets=TRUE) + scale_fill_brewer(palette="YlOrRd", na.value="white")
}
