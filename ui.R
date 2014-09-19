# ui.R

shinyUI(navbarPage("vs-app",
                   tabPanel("Overview",
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("topic",
                                            label = h5("Select Topic", style="color:#97582B"),
                                            choices = c("Overview", "Diagnosis", "Outbreak Causes", "Outbreak Control"),
                                            selected =  "Overview"),
                                p("All data used is publicly available from",
                                  a(img(src = "USDA-Logo.jpg", height = 75, width = 75), href="http://1.usa.gov/1r2bsbJ", target="_blank")),
                                
                                img(src = "IMG_9711.jpg", height = 200, width = 200),
                                a("@BlackWidoww", href="https://github.com/BlackWidoww", target="_blank"),
                                
                                img(src = "quote-hi.png", height = 50, width = 50),
                                em("I keep saying the sexy job in the next ten years will be statisticians."),
                                br(),
                                em("... Hal Varian", align="right")),
                              
                              mainPanel(
                                h2(textOutput("text1"), style="color:#A6790A", align="center"),
                                textOutput("text2")))),
                   
                   tabPanel("Current Outbreak",
                            sidebarLayout(
                              sidebarPanel(
                                h5("Outbreak began on May 23, 2014 in Kinney County, TX"),
                                sliderInput("days",
                                            label = "Days since initial outbreak",
                                            min = 0, max = as.numeric(Sys.Date()-as.Date("2014/05/23")),
                                            value = 0),
                                img(src = "IMG_9711.jpg", height = 200, width = 200),
                                a("@BlackWidoww", href="https://github.com/BlackWidoww", target="_blank"),
                                br(),
                                br(),
                                img(src = "quote-hi.png", height = 50, width = 50),
                                em("I keep saying the sexy job in the next ten years will be statisticians."),
                                br(),
                                em("... Hal Varian", align="right")),
                              
                              mainPanel(
                                tabsetPanel(
                                  tabPanel("Overview",
                                           h3(paste("Duration:",  as.numeric(Sys.Date()-as.Date("2014/05/23")), "days"), style="color:#A6790A", align="center"), 
                                           
                                           p("On May 23, 2014, four horses were confirmed to be infected with vesicular stomatitis virus (VSV) (New Jersey serotype) 
                                             on a single premise in Kinney County, Texas. On June 6, 2014 one horse was found to be infected in Hidalgo County, TX.  
                                             By June 13, 2014 infections were confirmed on a second premise in Hidalgo County, as well as three horses on two premises 
                                             in San Patricio County, TX.  By June 18, 2014 infection had spread to one new  premise in Nueces County, TX."),
                                           
                                           br(),
                                           
                                           p("By July 3, 2014 infection had spread to an additional premise in Nueces County, TX for a total of seven (7) VSV-positive equine 
                                             premises in Texas, including 3 premises on a 21-day countdown to quarantine release and the index case in Kinney County, 
                                             TX, which was released from quarantine.  On July 8, 2014 one (1) VSV-infected bovine premises has been identified in Jim 
                                             Wells County, Texas. By July 11, 2014 infection had spread to two additional counties: Bastrop and Travis, each with 
                                             infection found on a single premise.  On July 17, 2014, vesicular stomatitis virus (VSV) infection (New Jersey serotype) 
                                             was found on two (2) equine premises in Weld County, Colorado. Three affected horses on one premises and one affected horse 
                                             on the other  premises met the case definition of VSV infection.  On July 21, 2014 four (4) new VSV-positive premises (New 
                                             Jersey  serotype) were confirmed; three (3) equine premises in Texas and one (1) equine premises in Colorado.  The outbreak  
                                             spread to twelve (12) new premises: eight (8) equine premises in Texas and four (4) equine premises in Colorado.  The outbreak 
                                             began spreading more rapidly by the end of July.  On July 30, 2014 thirty-five (35) new premises were confirmed: twelve (12) 
                                             equine premises and two (2) bovine premises in Texas and twenty-one (21) equine premises in Colorado.")),
                                  
                   tabPanel("Map",
                                           
                                           plotOutput("map")),
                                  
                                  tabPanel("Statistics"))))),
                   
                   tabPanel("Historic Outbreaks",
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("year", 
                                            label = h5("Select Year", style="color:#97582B"), 
                                            choices = c("2012", "2010", "2009", "2006", "2005", "2004"),
                                            selected = "2012"),
                                sliderInput("days",
                                            label = h5("Days since Initial Case:", style="color:#A26A42"),
                                            min = 0, max=300, value=0),
                                img(src = "IMG_9711.jpg", height = 200, width = 200),
                                a("@BlackWidoww", href="https://github.com/BlackWidoww", target="_blank"),
                                br(),
                                br(),
                                img(src = "quote-hi.png", height = 50, width = 50),
                                em("I keep saying the sexy job in the next ten years will be statisticians."),
                                br(),
                                em("... Hal Varian", align="right")),
                              
                              mainPanel(
                                tabsetPanel(
                                  tabPanel("Overview"),
                                  tabPanel("Map"),
                                  tabPanel("Statistics")))))
                              )) 

