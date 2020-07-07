#R-Car-Dashboard 
library(shinydashboard)

#ui 
ui <- dashboardPage(
  #header 
  dashboardHeader(title = "Car Dashboard",
                  dropdownMenu(type = "messages",
                               messageItem(
                                 from = "Sales Dept",
                                 message = "Sales are steady this month."
                               ),
                               messageItem(
                                 from = "New User",
                                 message = "How do I register?",
                                 icon = icon("question"),
                                 time = Sys.time()
                               ),
                               messageItem(
                                 from = "Support",
                                 message = "The new server is ready.",
                                 icon = icon("life-ring"),
                                 time = Sys.Date()
                               )
                  )),
  #sidebar
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "Dashboard", icon = icon("Dashboard")),
      menuItem("Widgets", tabName = "widgets", icon = icon("th"))
    )
  ),
  #body
  dashboardBody(
    tabItems(
      tabItem(tabName = "Dashboard", 
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
            ),
      tabItem(tabName = "widgets",
              h2("Widgets tab content")
              )
      )
    )
    
)

#server
server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

#Perform the App
shinyApp(ui, server)
