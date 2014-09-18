#### First attempts at interactive outbreak map ####

library(choroplethr); library(ggplot2); library(RColorBrewer)

#For county level chropleths _region_ must be a 4 or 5 digit county FIPS code:
data(county.fips, package = "maps")
map <- read.csv("data/vs_map.csv", header=TRUE)

### Create 5-digit FIPS codes from county codes
for (i in 1:nrow(map))  {
  if (map$STATE[i] =="TX")  map$FIPS_CODE[i] <-as.numeric(sprintf("48%s", sprintf("%03d", map$FIPS_CODE[i])))
  if (map$STATE[i] == "CO")  map$FIPS_CODE[i] <- as.numeric(sprintf("08%s", sprintf("%03d", map$FIPS_CODE[i])))
}

### Create new column of outbreak duration
map$DATE<-as.Date(map$DATE, "%m/%d/%Y")     # Convert dates to class "Date"
DURATION<-as.numeric(map$DATE-map$DATE[1]) 
MAP <- data.frame(DURATION, map)


### Vector of cases by day
df = data.frame(region=county.fips$fips, value = NA)   # Default all counties to 0 cases
day = day
cases = subset(MAP, MAP$DURATION==day)
for(i in 1:nrow(cases))  {
  df[df$region==cases[i,6],2] = cases[i,7]    #Replace $value with $ACTIVE for each $region
  #df[df$region==cases[i,6],3] = cases[i,10]   #21_DAY quarantine
}

choroplethr(df, lod="county", num_buckets=9) + scale_fill_brewer(palette="YlOrRd", na.value="white") # Works to render map
#df[df$region==FIPSCode,2] = CASES   works to replace value