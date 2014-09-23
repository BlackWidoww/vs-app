# ui.R

source("chunks.R", local=TRUE)

shinyUI(navbarPage("vs-app",
                   
                   tabPanel("Overview",
                            sidebarLayout(
                              sidebarPanel(
                                
                       ## Overview Tab Dynamic Inputs
                                selectInput("topic",
                                            label = h5("Select Topic", style="color:#97582B"),
                                            choices = c("Overview", "Diagnosis", "Outbreak Causes", "Outbreak Control"),
                                            selected =  "Overview"),
                                br(),
                                USDA,
                                 
                       ## Overview Tab Signature Block
                       br(),
                       Ferdi,
                       br(),
                       GitHub,
                       br(),
                       br(),
                       quoteImage,
                       Quote,
                       br(),
                       Varian
                       ),
                       
                       ## Overview Tab Dynamic Output
                              mainPanel(
                                h3(textOutput("text1"), style="color:#A6790A", align="center"),
                                textOutput("text2")))),
                   
                   tabPanel("Current Outbreak",
                            sidebarLayout(
                              sidebarPanel(
                                
                      ## Current Outbreak Dynamic inputs          
                                h5("May 23, 2014 - PRESENT", style="color:#97582B"),
                                sliderInput("days",
                                            label = "Days since initial outbreak",
                                            min = 0, max = as.numeric(Sys.Date()-as.Date("2014/05/23")),
                                            value = 0),
                               
                      ## Current Outbreak Signature Block  
                      br(),
                      br(),
                      br(),
                      br(), 
                      Ferdi,
                      br(),
                      GitHub,
                      br(),
                      br(),
                      quoteImage,
                      Quote,
                      br(),
                      Varian
                      ),
                        
                      ## Current Outbreak Dynamic Output
                              mainPanel(
                                tabsetPanel(
                                  tabPanel("Overview",
                                           h3(paste("Duration:",  as.numeric(Sys.Date()-as.Date("2014/05/23")), "days"), style="color:#A6790A", align="center"),                                   
                                           Chunk1,
                                           br(),
                                           br(),  
                                           Chunk2
                                           ),
                                  
                          tabPanel("Map",
                                           
                                           plotOutput("map1"),
                                           textOutput("text3")),
                                  
                          tabPanel("Statistics"))))),
                   
                   tabPanel("Historic Outbreaks",
                        ## Historic Tab Dynamic Inputs    
                            sidebarLayout(
                              sidebarPanel(
                                selectInput("year", 
                                            label = h5("Select Year", style="color:#97582B"), 
                                            choices = c("2012", "2010", "2009", "2006", "2005", "2004"),
                                            selected = "2012"),
                                sliderInput("days2",
                                            label = h5("Days since Initial Case:", style="color:#A26A42"),
                                            min = 0, max=300, value=0),
                     
                        ## Historic Tab Signature Block 
                                br(),
                                br(),
                                br(),
                                Ferdi,
                                br(),
                                GitHub,
                                br(),
                                br(),
                                quoteImage,
                                Quote,
                                br(),
                                Varian
                        ),
                              
                        ## Historic Tab Dynamic Outputs
                              mainPanel(
                                tabsetPanel(
                                  tabPanel("Overview",
                                           h3(textOutput("text4"), style="color:#97582B", align="center"),
                                           textOutput("text5")),
                                  tabPanel("Map",
                                           plotOutput("map2")),
                                  tabPanel("Statistics"))))),
                   tabPanel("About",
                            sidebarLayout(
                              sidebarPanel(
                                ## About Tab Signature Block
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                br(),
                                Ferdi,
                                br(),
                                GitHub,
                                br(),
                                br(),
                                quoteImage,
                                Quote,
                                br(),
                                Varian
                              ),
                              mainPanel(
                                        h3("About this project", style="color:#97582B", align="center"),
                                        Resume,
                                        br(),
                                        br(),
                                        Reproduce, 
                                        br(),
                                        br(),
                                        em(Thanks),
                                        br(),
                                        br(),
                                        strong("Author"),
                                        br(),
                                        "Courtney Shelley (and Ferdi)",
                                        br(),
                                        GitHub,
                                        br(),
                                        br(),
                                        "UCLA - BS, Evolution, Behavior, and Ecology")))
                              )) 
