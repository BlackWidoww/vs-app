#### Helper Function for vs-map ####

library(maps)
vsMap <- function(year)  {
  map <- read.csv(paste("data/vs_map_", year, ".csv", sep=""), header=TRUE)

  ### Create 5-digit FIPS codes from county codes
  for (i in 1:nrow(map))  {
     if (map$STATE[i] =="TX")  map$FIPS_CODE[i] <-as.numeric(sprintf("48%s", sprintf("%03d", map$FIPS_CODE[i])))
     if (map$STATE[i] == "CO")  map$FIPS_CODE[i] <- as.numeric(sprintf("08%s", sprintf("%03d", map$FIPS_CODE[i])))
     if (map$STATE[i] == "NM") map$FIPS_CODE[i] <- as.numeric(sprintf("35%s", sprintf("%03d", map$FIPS_CODE[i])))
  }

  ### Create new column of outbreak duration
  map$DATE<-as.Date(map$DATE, "%m/%d/%Y")     # Convert dates to class "Date"
  DURATION<-as.numeric(map$DATE-map$DATE[1]) 
  MAP <- data.frame(DURATION, map)
  
  #list(year, MAP)
}
