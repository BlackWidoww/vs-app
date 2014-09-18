# ui.R

shinyUI(fluidPage(
  tags$head(
    tags$style("body {background-color: WhiteSmoke; }")),
  titlePanel(h1("Equine Vesicular Stomatitis", style="color: #61300D", align="center")),

  p("Vesicular stomatitis outbreaks in the U.S. are monitored and publicly reported by the U.S. Department of Agriculture (USDA) Animal and Plant Health 
    Inspection Service.  Situation reports for current and historical outbreaks are available",
             a("here", href="http://1.usa.gov/1r2bsbJ", target="_blank")
  ),
  
  sidebarLayout(
    
    sidebarPanel(
      selectInput("year", 
                  label = h5("Select Year", style="color:#97582B"), 
                  choices = c("Overview", "2014", "2012", "2010", "2009", "2006", "2005", "2004"),
                  selected = "Overview"),
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
        tabPanel("Overview",
                 h3(textOutput("text1"), style="color:#A6790A", align="center"),
                 h5(textOutput("text2"), style="color:#B8860B", align="center"),
                 textOutput("text3")
                 ),
        tabPanel("Map",
                 plotOutput("map"),
                 textOutput("text4")
        ),
        tabPanel("Statistics")
      )
    )
  )
  ))
