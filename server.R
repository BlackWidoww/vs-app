# server.R        ## Run once when app is launched, place source files, etc.

library(choroplethr); library(ggplot2); library(RColorBrewer); library(maps)
source("helpers.R")

shinyServer(function(input, output) {
  
  ########## Dynamic Text Outputs ###########
  
  ##Text1: Headers for Overview Topics
  output$text1 <- renderText({ 
    args <- switch(input$topic,
                   "Overview" = paste("Equine Vesicular Stomatitis Virus (VSV)"),
                   "Outbreak Causes" = paste("Cause of Outbreaks in the U.S."),
                   "Diagnosis" = paste("Presentation and Diagnosis"),
                   "Outbreak Control" = paste("Outbreak Control"))
    paste(args)
  })
  
  ##Text2: Bodies for Overview Topics
  output$text2 <- renderText({
    args <- switch(input$topic,
                   "Overview" = paste("Vesicular stomatitis virus (VSV) is an acute viral disease of cattle, horses, deer, and pigs (and occassionally humans)."),
                   "Outbreak Causes" = paste("Phlebotomine sandflies are known vectors of VSV, and VSV can also be transmitted by direct contact between infected animals.  Outbreaks in the U.S. generally are found to originate with the movement of animals (or insect vectors) from Mexico."
                        ),
                   "Diagnosis" = paste(
                        "Infected animals present with fever 24-48 after infection, inflammatory lesions around the mouth, and excessive salivation due to rupture of lesions."
                        ),
                   "Outbreak Control" = paste(
                        "Outbreaks are controlled by quarantine, restriction of animal movement and insect control.  There is no commercially available VSV vaccines."
                        ))
     paste(args)
  })

  ##Text3: Map Tab Subtext for Current Outbreak
  output$text3 <- renderText({
    paste("Current outbreak at ", format((Sys.Date()-as.Date("2014/05/23")), format="S%d"), ".  Data compiled for first 64 days.")})
  
  ##Text 4: Overview Tab for Historic Outbreak Cycles
  output$text4 <- renderText({
    args <- switch(input$year,
                   "2012" = paste(input$year, "Outbreak - New Mexico and Colorado"),
                   "2010" = paste(input$year, "Outbreak - Arizona"),
                   "2009" = paste(input$year, "Outbreak - Texas and New Mexico"),
                   "2006" = paste(input$year, "Outbreak - Wyoming"),
                   "2005" = paste(input$year, "Outbreak - Western United States"),
                   "2004" = paste(input$year, "Outbreak - Colorado, New Mexico, and Texas"))}) 

    
  output$text5 <- renderText({
    args <- switch(input$year,
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
  
  
  ############ Maps ################
  
  ## Current Outbreak Map - Duration Dynamic ##
  
      ##Empty data.frame of county FIPS codes - Used by All Maps
      data(county.fips, package = "maps")
      df = data.frame(region=county.fips$fips, value = NA)   # Default all counties to 0 cases

  output$map1 <- renderPlot({
    
    map <- read.csv("data/vs_map_2014.csv", header=TRUE)
    MAP <- vsMap(map)       #From helpers.R.  Cleans dates, compiles 4- or 5-digit FIPS codes

    day = max(na.omit(MAP$DURATION[MAP$DURATION <= input$days]))
    cases = subset(MAP, MAP$DURATION==day)
    for(i in 1:nrow(cases))  {
      df[df$region==cases$FIPS_CODE[i],2] = cases$CUMULATIVE[i]    #Replace $value with $CUMULATIVE for each $region
    }
    
    choroplethr(df, lod="county", num_buckets=9) + scale_fill_brewer(palette="YlOrRd", na.value="white")
  })
  
  ## Historic Outbreak Maps - Date Dynamic ##
  output$map2 <- renderPlot({
    
    map2 <- read.csv(paste("data/vs_map_", input$year, ".csv", sep=""), header=TRUE)
    MAP2 <- vsMap(map2)       #From helpers.R.  Cleans dates, compiles 4- or 5-digit FIPS codes
   
    day2 = max(na.omit(MAP2$DURATION[MAP2$DURATION <= input$days]))
    cases2 = subset(MAP2, MAP2$DURATION==day)
    for(i in 1:nrow(cases2))  {
      df[df$region==cases2$FIPS_CODE[i],2] = cases2$CUMULATIVE[i]    #Replace $value with $CUMULATIVE for each $region
      #df[df$region==FIPS_CODE,$value] = cases$desired[i]   #21_DAY quarantine
    }
    
    choroplethr(df, lod="county", num_buckets=9) + scale_fill_brewer(palette="YlOrRd", na.value="white")
  })
  

})