source("utils.R")

shinyServer(function(input, output) {
  
  observeEvent(input$map_click, {
    click = input$map_click
    leafletProxy('map') %>% 
      clearMarkers() %>% 
      addMarkers(lng = Lng(), lat = Lat())
  })
  
  Lat <- eventReactive(input$map_click, { 
    click = input$map_click    
    out <- click$lat

    })
  
  Lng <- eventReactive(input$map_click, { 
    click <- input$map_click
    out <- click$lng
  })
  
  output$isocoords <- renderText({
    str_c('<h4>Lon: ', 
          round(isoCoords()[['lon']],4),' <br> ',
          'Lat: ', 
          round(isoCoords()[['lat']],4), '</h4>')
  })
  
  isoCoords <- reactive({
    coords <- c(lat = Lat(),
                lon = Lng())
    print(coords)
    coords
  })
  
  isochrone <- eventReactive(input$submit, {
    withProgress(message = 'Sending Request',
                 isochrone <- osrmIsochrone(loc = c(isoCoords()[['lon']],
                                                    isoCoords()[['lat']]),
                                            breaks = as.numeric(input$driveTime),
                                            res = 40) %>%
                   st_as_sf()
    )
    isochrone
  })
  
  output$map <- renderLeaflet({
    leaflet() %>%
      setView(lat = -12.0365032,lng = -80.0278665, zoom = 3) %>% 
      addProviderTiles(providers[['OpenStreetMap']])
  })
  
  
  observeEvent(input$submit , {
    
    steps <- sort(as.numeric(input$driveTime))
    print(steps)
    isochrone <- cbind(steps = steps[isochrone()[['id']]], isochrone())
    pal <- colorFactor(viridis::plasma(nrow(isochrone), direction = -1), 
                       isochrone$steps)
    
    leafletProxy("map") %>%
      clearShapes() %>% 
      clearMarkers() %>%
      clearControls() %>%
      addPolygons(data = isochrone,
                  weight = .5, 
                  color = ~pal(steps)) %>%
      addLegend(data = isochrone,
                pal = pal, 
                values = ~steps,
                title = 'Drive Time (min.)',
                opacity = 1) %>%
      addMarkers(lng = isoCoords()[['lon']], isoCoords()[['lat']]) %>%
      setView(isoCoords()[['lon']], isoCoords()[['lat']], zoom = 9)
  })
  
  observe({
    leafletProxy("map") %>%
      clearTiles() %>%
      addProviderTiles(providers[[leaflet::providers$OpenStreetMap]])
  })
  
  output$dlIsochrone <- downloadHandler(
    filename = function() {
      paste0("drivetime_isochrone", input$shapeOutput)
    },
    content = function(file) {
      st_write(isochrone(), file)
    }
  )
  
})

