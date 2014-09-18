# ui.R

###### LOAD DATA ######
data <- read.csv("data/vesicular_stomatitis_2014.csv", header=TRUE)
library(lubridate)
data$DATE<-as.Date(data$DATE, "%m/%d/%Y")     # Convert dates to class "Date"

## Create new column of outbreak duration
DURATION<-as.numeric(data$DATE-data$DATE[1]) 
data<-data.frame(data,DURATION)


shinyUI(fluidPage(
  tags$head(
    tags$style("body {background-color: WhiteSmoke; }")),
  titlePanel(h1("Equine Vesicular Stomatitis", style="color: #61300D", align="center")),
  h3("Outbreaks in the US 2004-2012", style = "color:#6F370F", align="center"),
  br(),
  br(),
  h3("Background Information", style = "color:#7D3E11"),
  p("Vesicular stomatitis virus (VSV) is an acute viral disease of cattle, horses, deer, and pigs (and occassionally
    humans).  Phlebotomine sandflies are known vectors of VSV, and VSV can also be transmitted by direct contact between
    infected animals.  Outbreaks in the U.S. generally are found to originate with the movement of animals (or insect vectors) from Mexico.
    Infected animals present with fever 24-48 after infection, inflammatory lesions around the mouth, and excessive 
    salivation due to rupture of lesions.  Outbreaks are controlled by quarantine, restriction of animal movement
    and insect control.  There is no commercially available VSV vaccines."),
  br(), 
  p("Vesicular stomatitis outbreaks in the U.S. are monitored and publicly reported by the U.S. Department of Agriculture (USDA) Animal and Plant Health 
    Inspection Service."),
  br(),
  helpText(  "Situation reports for current and historical outbreaks are available",
           a("here", href="http://1.usa.gov/1r2bsbJ", target="_blank")
           ),

  br(),
  br(),
  
  h3("Geographic Outbreak Patterns By Year", style = "color:#8B4513"),
  

  
  sidebarLayout(
    
    sidebarPanel(
      selectInput("year", 
          label = h5("Select Year", style="color:#97582B"), 
          choices = c("2014", "2012", "2010", "2009", "2006", "2005", "2004"),
          selected = "2014"),
      br(),
      sliderInput("days", 
          label = h5("Days since Initial Case:", style="color:#A26A42"),
          min = 0, max=300, value=0),
      br(),
      br(),
      br(),
      br(),
      img(src = "IMG_9711.jpg", height = 200, width = 200),
      a("@BlackWidoww", href="https://github.com/BlackWidoww", target="_blank"),
      br(),
      br(),
      img(src = "quote-hi.png", height = 50, width = 50),
      em("I keep saying the sexy job in the next ten years will be statisticians."),
      br(),
      em("... Hal Varian", align="right") 
      
      ),
  
    mainPanel(
      tabsetPanel(
        tabPanel("Map",
          h3(textOutput("text1"), style="color:#A6790A", align="center"),
          h5(textOutput("text2"), style="color:#B8860B", align="center"),
          em(textOutput("text3"), style = "color:OliveDrab"),
          plotOutput("map"),
          textOutput("text4")
        ),
        tabPanel("Statistics")
    )
    )
  )
))
