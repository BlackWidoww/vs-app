# server.R        ## Run once when app is launched, place source files, etc.

library(choroplethr); library(ggplot2); library(RColorBrewer); library(maps); library(data.table)
source("helpers.R", local=TRUE); source("chunks.R", local=TRUE)

shinyServer(function(input, output) {
  
  ###########  Dynamic Text Outputs  #############
  
  ##Text1: Headers for Overview Topics
  output$text1 <- renderText({ 
    args <- switch(input$topic,
                   "Overview" = paste("Equine Vesicular Stomatitis Virus (VSV)"),
                   "Outbreak Causes" = paste("Cause of Outbreaks in the U.S."),
                   "Diagnosis" = paste("Presentation and Diagnosis"),
                   "Outbreak Control" = paste("Outbreak Control"))
    paste(args)})
  
  ##Text2: Bodies for Overview Topics
  output$text2 <- renderText({
    args <- switch(input$topic,
                   "Overview" = paste("Vesicular stomatitis virus (VSV) is an acute viral disease of cattle, horses, deer, and pigs (and occassionally humans)."),
                   "Outbreak Causes" = paste("Phlebotomine sandflies are known vectors of VSV, and VSV can also be transmitted by direct contact between infected animals.  Outbreaks in the U.S. generally are found to originate with the movement of animals (or insect vectors) from Mexico."),
                   "Diagnosis" = paste("Infected animals present with fever 24-48 after infection, inflammatory lesions around the mouth, and excessive salivation due to rupture of lesions."),
                   "Outbreak Control" = paste("Outbreaks are controlled by quarantine, restriction of animal movement and insect control.  There is no commercially available VSV vaccines."))
    paste(args)})
  
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
                   "2004" = paste(input$year, "Outbreak - Colorado, New Mexico, and Texas"))
    paste(args)})
  
  output$text5 <- renderText({
    args <- switch(input$year,
                   "2012" = Chunk3,
                   "2010" = Chunk4, 
                   "2009" = Chunk5, 
                   "2006" = Chunk6, 
                   "2005" = Chunk7, 
                   "2004" = Chunk8)
    paste(args)})
  
  
  ############ Maps ################
  
  ## Current Outbreak Map - Duration Dynamic ##
  
  output$map1 <- renderPlot({
    
    ##Empty data.frame of county FIPS codes - Used by All Maps
    #####WARNING!!  Don't change region/value labels or choroplethr() function will crash
    data(county.fips, package = "maps")
    df = data.frame(region=county.fips$fips, value = NA)   # Default all counties to 0 cases
    
    
    ### Read/Clean Data
    map <- read.csv("data/vs_map_2014.csv", header=TRUE)   #Specifically calls 2014 outbreak 
    MAP <- vsMap(map)       #From helpers.R.  Cleans dates, compiles 4- or 5-digit FIPS codes
    day = max(na.omit(MAP$DURATION[MAP$DURATION <= input$days]))     #Set desired day to render.  Data is released
                                                                     #roughly weekly, so max() function allows smooth
                                                                     #slider input
    
    update.DF(MAP, day)})
  
  ## Historic Outbreak Maps - Date Dynamic ##
  output$map2 <- renderPlot({
    
    
    ##Empty data.frame of county FIPS codes - Used by All Maps
    #####WARNING!!  Don't change region/value labels or choroplethr() function will crash
    data(county.fips, package = "maps")
    df = data.frame(region=county.fips$fips, value = NA)   # Default all counties to 0 cases
    
    
    
    
    ### Read/Clean Data
    map2 <- read.csv(paste("data/vs_map_", input$year, ".csv", sep=""), header=TRUE)   #Dynamically calls year
    MAP <- vsMap(map2)       #From helpers.R.  Cleans dates, compiles 4- or 5-digit FIPS codes
    day = max(na.omit(MAP$DURATION[MAP$DURATION <= input$days2]))     #Set desired day to render.  Data is released
                                                                     #roughly weekly, so max() function allows smooth
                                                                     #slider input
    
    update.DF(MAP, day)})
  

})  