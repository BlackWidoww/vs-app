# server.R        ## Run once when app is launched, place source files, etc.

library(choroplethr); library(ggplot2); library(RColorBrewer); library(maps)

shinyServer(function(input, output) {
  
    
  ##Empty data.frame of county FIPS codes
  data(county.fips, package = "maps")
  df = data.frame(region=county.fips$fips, value = NA)   # Default all counties to 0 cases
  
  output$text1 <- renderText({
    paste(input$year, "Outbreak")
  })
  
  output$text2 <- renderText({
    args <- switch(input$year,
                   "2014" = paste("May 23, 2014 - PRESENT.  Currently at ", format((Sys.Date()-as.Date("2014/05/23")), format="S%d")),
                   "2012" = paste("April 30, 2012 - December 24, 2012.   238 days total"),
                   "2010" = paste("May 26, 2010 - June 23, 2010.   XXX days total."), 
                   "2009" = paste("June 10, 2009 - August 18, 2009.   XXX days total."), 
                   "2006" = paste("August 17, 2006 - December 24, 2006.   XXX days total."), 
                   "2005" = paste("April 27, 2005 through April 11, 2006.   XXX days total."), 
                   "2004" = paste("May 18, 2004 - January 14, 2005.   XXX days total."))
    paste(args)
  })
  output$text3 <- renderText({
    args <- switch(input$year,
                   "2014" = paste("NOTE: Data currently available for 64 days since initial outbreak."),
                   "2012" = paste("NOTE: Available data is cumulative only."),
                   "2010" = paste("NOTE: Available data is cumulative only."), 
                   "2009" = paste("NOTE: Available data is cumulative only."), 
                   "2006" = paste("NOTE: Available data is cumulative only."), 
                   "2005" = paste("NOTE: Available data is cumulative only."), 
                   "2004" = paste("NOTE: Available data is cumulative only."))
    paste(args)
  })
  
  output$map <- renderPlot({
    map <- read.csv(paste("data/vs_map_", input$year, ".csv", sep=""), header=TRUE)
    
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

    day = max(na.omit(MAP$DURATION[MAP$DURATION <= input$days]))
    cases = subset(MAP, MAP$DURATION==day)
    for(i in 1:nrow(cases))  {
      df[df$region==cases$FIPS_CODE[i],2] = cases$CUMULATIVE[i]    #Replace $value with $CUMULATIVE for each $region
      #df[df$region==FIPS_CODE,$value] = cases$desired[i]   #21_DAY quarantine
    }
    
    choroplethr(df, lod="county", num_buckets=9) + scale_fill_brewer(palette="YlOrRd", na.value="white")
  })
  
  output$text4 <- renderText({
    args <- switch(input$year,
                   "2014" = paste("On May 23, 2014, four horses were confirmed to be infected with vesicular stomatitis virus (VSV) on a single 
                      premise in Kinney County, Texas."),
                   "2012" = paste("On April 30, 2012, two horses were confirmed to be infected with vesicular stomatitis virus (New Jersey serotype) 
                      on an equine premises in Otero County, New Mexico. On August 1, 2012, one infected horse was confirmed on an equine 
                      premises in Las Animas County, Colorado. As of October 4, 2012, all VSV-affected premises in Colorado have been 
                      released from quarantine and no new cases have been identified. As of December 24, 2012, all VSV-affected premises 
                      in New Mexico have been released from quarantine."),
                   "2010" = paste("Data not yet compiled.  Please check back later."), 
                   "2009" = paste("Data not yet compiled.  Please check back later."), 
                   "2006" = paste("Data not yet compiled.  Please check back later."), 
                   "2005" = paste("Data not yet compiled.  Please check back later."), 
                   "2004" = paste("Data not yet compiled.  Please check back later."))
    paste(args)
  })  
})
