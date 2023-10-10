#réaliser une carte 
library(shiny)


ui <- fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      h1("First level title"), 
      h2("Second level title"),
      img(src = "rstudio.png", height = 360, width = 326)
    )
  )
)

# Run the application 
fr <- c(left = -6, bottom = 41, right = 10, top = 52)
get_stamenmap(fr, zoom = 5,"toner-lite") %>% ggmap()

shinyApp(ui = ui, server = server)

