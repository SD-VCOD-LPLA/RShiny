library(leaflet)
library(shiny)
library(DT)
library(shinythemes)

# Créez une base de données VELOVS à des fins de démonstration
VELOVS <- 

ui <- fluidPage(
  theme = shinytheme("flatly"),
  navbarPage(
    "Vélo'v",
    tabPanel("Régions",
             sidebarPanel(
               textInput("txt", "Text input:", "general"),
               actionButton("do", "Click Me", class = "btn-primary"),
               actionButton("Effacer", "Effacer"),
               hr(),
               plotOutput("plot")
             ),
             mainPanel(
               tabsetPanel(
                 tabPanel("Tab 1",
                          h4("Table"),
                          tableOutput("table"),
                          h4("Verbatim text output"),
                          verbatimTextOutput("txtout")
                 )
               )
             )
    ),
    tabPanel("Carte Stations",
             sidebarLayout(
               sidebarPanel("Information", width = 3),       
               mainPanel(width = 9,
                         leafletOutput("map_leaflet")  # Définissez la sortie Leaflet ici
               )
             )),
    tabPanel("Base de données",
             fluidPage(
               fluidRow(
                 column(6,
                        selectInput("name",
                                    "Nom:",
                                    c("Toutes les stations", unique(as.character(VELOVS$name)))
                        )
                 ),
                 column(6,
                        selectInput("address",
                                    "Adresse:",
                                    c("Toutes les adresses", unique(as.character(VELOVS$address)))
                        )
                 )
               ),
               dataTableOutput("table_db")
             )
    )
  )
)

server <- function(input, output) {
  output$txtout <- renderText({
    paste(input$txt, input$slider, format(input$date), sep = ", ")
  })
  
  v <- reactiveValues(data = NULL)
  
  observeEvent(input$do, {
    v$data <- runif(100)
  })
  
  observeEvent(input$Effacer, {
    v$data <- NULL
  })
  
  output$plot <- renderPlot({
    if (is.null(v$data)) return()
    hist(v$data)
  })
  
  output$map_leaflet <- renderLeaflet({
    my_map <- leaflet() %>%
      addTiles() %>%
      setView(4.85, 45.75 , zoom = 10)
    my_map <- addCircleMarkers(
      map = my_map,
      data = VELOVS,
      lat = ~position.lat,
      lng = ~position.lng,
      radius = 5,
      color = "blue",
      fill = TRUE,
      fillOpacity = 0.5
    )
    
    my_map
  })
  
  output$table_db <- renderDataTable({
    my_data_filtered <- VELOVS
    
    if (input$name != "Toutes les stations") {
      my_data_filtered <- my_data_filtered[my_data_filtered$name == input$name, ]
    }
    
    if (input$address != "Toutes les adresses") {
      my_data_filtered <- my_data_filtered[my_data_filtered$address == input$address, ]
    }
    
    my_data_filtered
  })
}

shinyApp(ui, server)


  