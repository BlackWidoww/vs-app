#chunks.R

##In-app repository for all large text chunks used in vs-app


##USDA Hyperlink

USDA <- p("All data used is publicly available from",
  a(img(src = "USDA_APHIS.png", height = 200, width = 300), href="http://1.usa.gov/1r2bsbJ", target="_blank"))

##Signature Block

Ferdi <- img(src = "IMG_9711.jpg", height = 200, width = 200)

GitHub<- a("@_BlackWidoww", href="https://github.com/BlackWidoww", target="_blank")

quoteImage <- img(src = "quote-hi.png", height = 50, width = 50)

Quote<- em("I keep saying the sexy job in the next ten years will be statisticians.")

Varian <- em("... Hal Varian", align="right")



#Bodies for Current/Historic Overview Tabs

Chunk1 <- "On May 23, 2014, four horses were confirmed to be infected with vesicular stomatitis virus (VSV) (New Jersey serotype) 
          on a single premise in Kinney County, Texas. On June 6, 2014 one horse was found to be infected in Hidalgo County, TX.  
          By June 13, 2014 infections were confirmed on a second premise in Hidalgo County, as well as three horses on two premises 
          in San Patricio County, TX.  By June 18, 2014 infection had spread to one new  premise in Nueces County, TX."

Chunk2 <- "By July 3, 2014 infection had spread to an additional premise in Nueces County, TX for a total of seven (7) VSV-positive equine 
          premises in Texas, including 3 premises on a 21-day countdown to quarantine release and the index case in Kinney County, 
          TX, which was released from quarantine.  On July 8, 2014 one (1) VSV-infected bovine premises has been identified in Jim 
          Wells County, Texas. By July 11, 2014 infection had spread to two additional counties: Bastrop and Travis, each with 
          infection found on a single premise.  On July 17, 2014, vesicular stomatitis virus (VSV) infection (New Jersey serotype) 
          was found on two (2) equine premises in Weld County, Colorado. Three affected horses on one premises and one affected horse 
          on the other  premises met the case definition of VSV infection.  On July 21, 2014 four (4) new VSV-positive premises (New 
          Jersey  serotype) were confirmed; three (3) equine premises in Texas and one (1) equine premises in Colorado.  The outbreak  
          spread to twelve (12) new premises: eight (8) equine premises in Texas and four (4) equine premises in Colorado.  The outbreak 
          began spreading more rapidly by the end of July.  On July 30, 2014 thirty-five (35) new premises were confirmed: twelve (12) 
          equine premises and two (2) bovine premises in Texas and twenty-one (21) equine premises in Colorado."

Chunk3 <- "Cumulative number of case positive premises and animals associated with the 2012 U.S. vesicular stomatitis outbreak (April 
          30, 2012 - December 24, 2012). New Mexico and Colorado were the only States affected in the 2012 outbreak."

Chunk4 <- "Cumulative number of case positive premises and animals associated with the 2010 U.S. vesicular stomatitis outbreak (May 26, 
          2010 - July 23, 2010). Arizona was the only State affected in the 2010 outbreak."

Chunk5 <- "Cumulative number of case positive premises and animals associated with the 2009 United States vesicular stomatitis outbreak 
          ( June 10, 2009 - August 18, 2009). Texas and New Mexico were the only States affected in the 2009 outbreak."

Chunk6 <- "Cumulative number of case positive premises and animals associated with the 2006 United States vesicular stomatitis outbreak 
          (August 17, 2006 through December 21, 2006). Wyoming was the only state affected in the 2006 outbreak."

Chunk7 <- "Cumulative number of case positive premises and animals for the 2005 United States vesicular stomatitis outbreak (April 27, 
          2005 through April 11, 2006) ..... NOT COMPLETE."

Chunk8 <- "Cumulative number of case positive premises and animals for the 2004 United States vesicular stomatitis outbreak (May 18, 
          2004 through January 14, 2005) ..... NOT COMPLETE"


###About Tab
Resume <- "This web application has been created to accompany my Epidemiology PhD application in order to convey my love and interest
          in bringing biology, statistics, and applied mathematics to lfe.  In the near future, this Statistics tab will include 
          interpretation of each outbreak cycle in light of Kermack and McKendrick's S-I-R Model of disease spread to predict outbreak 
          behavior using machine learning techniques.  I have focused on Equine Vesicular Stomatitis because of my interests in equine 
          health, the relative ease of acquiring and compiling current and historic data from public sources, and because I love my pony."

Reproduce <- p("All documentation for this application is available on",
          a("GitHub", href="https://github.com/BlackWidoww/vs-app", target="_blank"))

Thanks <- "Special thanks go to Drs. Roger Peng, Jeff Leek, and Brian Caffo at the Johns Hopkins Bloomberg School of Public Health." 
          
