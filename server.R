# server.R        ## Run once when app is launched, place source files, etc.

library(choroplethr); library(ggplot2); library(RColorBrewer); library(maps)

shinyServer(function(input, output) {
  
    
  ##Empty data.frame of county FIPS codes
  data(county.fips, package = "maps")
  df = data.frame(region=county.fips$fips, value = NA)   # Default all counties to 0 cases
  
  output$text1 <- renderText({
    args <- switch(input$year,
                   "Overview" = paste("BACKGROUND INFORMATION"),
                   "2014" = paste(input$year, "Outbreak"),
                   "2012" = paste(input$year, "Outbreak"),
                   "2010" = paste(input$year, "Outbreak"),
                   "2009" = paste(input$year, "Outbreak"),
                   "2006" = paste(input$year, "Outbreak"),
                   "2005" = paste(input$year, "Outbreak"),
                   "2004" = paste(input$year, "Outbreak"),
    )    
  })
  
  output$text2 <- renderText({
    args <- switch(input$year,
                   "Overview" = paste("Outbreaks in the United States: 2004-PRESENT"),
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
                   "Overview" = paste("Vesicular stomatitis virus (VSV) is an acute viral disease of cattle, horses, deer, and pigs (and occassionally
    humans).  Phlebotomine sandflies are known vectors of VSV, and VSV can also be transmitted by direct contact between
    infected animals.  Outbreaks in the U.S. generally are found to originate with the movement of animals (or insect vectors) from Mexico.
    Infected animals present with fever 24-48 after infection, inflammatory lesions around the mouth, and excessive 
    salivation due to rupture of lesions.  Outbreaks are controlled by quarantine, restriction of animal movement
    and insect control.  There is no commercially available VSV vaccines."),
                   "2014" = paste("On May 23, 2014, four horses were confirmed to be infected with vesicular stomatitis virus (VSV) (New Jersey serotype) 
                                  on a single premise in Kinney County, Texas. On June 6, 2014 one horse was found to be infected in Hidalgo County, TX.  
                                  By June 13, 2014 infections were confirmed on a second premise in Hidalgo County, as well as three horses on two premises 
                                  in San Patricio County, TX.  By June 18, 2014 infection had spread to one new  premise in Nueces County, TX.  By July 3, 
                                  2014 infection had spread to an additional premise in Nueces County, TX for a total of seven (7) VSV-positive equine 
                                  premises in Texas, including 3 premises on a 21-day countdown to quarantine release and the index case in Kinney County, 
                                  TX, which was released from quarantine.  On July 8, 2014 one (1) VSV-infected bovine premises has been identified in Jim 
                                  Wells County, Texas. By July 11, 2014 infection had spread to two additional counties: Bastrop and Travis, each with 
                                  infection found on a single premise.  On July 17, 2014, vesicular stomatitis virus (VSV) infection (New Jersey serotype) 
                                  was found on two (2) equine premises in Weld County, Colorado. Three affected horses on one premises and one affected horse 
                                  on the other  premises met the case definition of VSV infection.  On July 21, 2014 four (4) new VSV-positive premises (New 
                                  Jersey  serotype) were confirmed; three (3) equine premises in Texas and one (1) equine premises in Colorado.  The outbreak  
                                  spread to twelve (12) new premises: eight (8) equine premises in Texas and four (4) equine premises in Colorado.  The outbreak 
                                  began spreading more rapidly by the end of July.  On July 30, 2014 thirty-five (35) new premises were confirmed: twelve (12) 
                                  equine premises and two (2) bovine premises in Texas and twenty-one (21) equine premises in Colorado."),
                   "2012" = paste("Cumulative number of case positive premises and animals associated with the 2012 U.S. vesicular stomatitis outbreak (April 
                                  30, 2012 - December 24, 2012). New Mexico and Colorado were the only States affected in the 2012 outbreak."),
                   "2010" = paste("Cumulative number of case positive premises and animals associated with the 2010 U.S. vesicular stomatitis outbreak (May 26, 
                                  2010 - July 23, 2010). Arizona was the only State affected in the 2010 outbreak."), 
                   "2009" = paste("Cumulative number of case positive premises and animals associated with the 2009 United States vesicular stomatitis outbreak 
                                  ( June 10, 2009 - August 18, 2009). Texas and New Mexico were the only States affected in the 2009 outbreak."), 
                   "2006" = paste("Cumulative number of case positive premises and animals associated with the 2006 United States vesicular stomatitis outbreak 
                                  (August 17, 2006 through December 21, 2006). Wyoming was the only state affected in the 2006 outbreak."), 
                   "2005" = paste("Cumulative number of case positive premises and animals for the 2005 United States vesicular stomatitis outbreak (April 27, 
                                  2005 through April 11, 2006) ..... "), 
                   "2004" = paste("Cumulative number of case positive premises and animals for the 2004 United States vesicular stomatitis outbreak (May 18, 
                                  2004 through January 14, 2005) ..... "))
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
