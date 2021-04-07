source("utils.R")


navbarPage("SCL-Lab", id="nav",
           tabPanel("Isochrones",
                    div(class="outer",
                        tags$head(
                          # Include our custom CSS
                          includeCSS("styles.css")
                        ),
                        
                        # If not using custom CSS, set height of leafletOutput to a number instead of percent
                        leafletOutput("map", width="100%", height="100%"),
                        
                        absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                      draggable = TRUE, top = 60, left = "5%", 
                                      right = 20, bottom = "auto",
                                      width = 330, height = "auto",
                                      h2("Time-distance matrix - App "),
                                      h4("Pick a location in the map"),
                                      htmlOutput('isocoords'),
                                      selectInput("driveTime",
                                                  "Drive Time (min.)",
                                                  seq(10, 100, 10),
                                                  selected = c(30, 60),
                                                  multiple = TRUE),
                                      actionButton("submit", "Submit",
                                                   icon = icon("ok",
                                                               lib = "glyphicon")),
                                      br(),
                                      br(),
                                      
                                      h4("Download Results"),
                                      selectInput("shapeOutput",
                                                  "Select Output Type",
                                                  c("Shapefile" = ".shp",
                                                    "GeoJSON" = ".geojson"),
                                                  selected = ".geojson"
                                      ),
                                      downloadButton("dlIsochrone", "Download")
                                      
                                      # plotOutput("histCentile", height = 200),
                                      # plotOutput("scatterCollegeIncome", height = 250)
                        ),
                        
                        tags$div(id="SCLData + OpenStreetMap services"
                        )
                    )
           )
)           

# shinyUI(fluidPage(theme = shinytheme('journal'),
#                   h2("Small app - Isochrone Calculator"),
#                   
#                   sidebarLayout(
#                     sidebarPanel(
#                       br(),
#                       br(),
#                       h4("Pick a location in the map"),
#                       selectInput("driveTime",
#                                   "Drive Time (min.)",
#                                   seq(10, 60, 10),
#                                   selected = seq(10, 50, 20),
#                                   multiple = TRUE),
#                       actionButton("submit", "Submit", 
#                                    icon = icon("ok",
#                                                lib = "glyphicon")),
#                       br(),
#                       br(),
#                       
#                       h4("Download Results"),
#                       selectInput("shapeOutput",
#                                   "Select Output Type",
#                                   c("Shapefile" = ".shp",
#                                     "GeoJSON" = ".geojson"),
#                                   selected = ".geojson"
#                       ),
#                       downloadButton("dlIsochrone", "Download")
#                     ),
#                     mainPanel(
#                       leafletOutput("map", height = 600),
#                                             
#                     )
#                   )        
# ))

