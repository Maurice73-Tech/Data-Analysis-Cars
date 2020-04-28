# Zuerst muessen die notwendigen Pakete installiert werden
# Um die Pakete zu installieren: Kommentieren Sie die Zeile aus und fuehren Sie diese mit Ctrl+Enter aus

# install.packages("shiny")
# install.packages("DT")

# Nachdem Sie das Paket installiert haben, kommentieren Sie die Zeile wieder aus und fahren mit dem Import
# der Bibliothek fort

library(shiny)
library(DT)

ui <- fluidPage(
  
  # Hier koennen Sie einen Titel festlegen
  titlePanel("Technologien und Tools für Data Science"),
  
  # Das sidebarLayout dient dazu Eingabemoeglichkeiten von den designierten Ausgaben zu trennen
  sidebarLayout(
    
    # Es wird ein sidebarPanel fuer die Inputs generiert
    sidebarPanel(
      
      # Input: Ein Slider mit einem Minimum von 1, Maximum von 40 und einem Default Wert von 10
      # Input: Ein Input kann mittels seiner inputId referenziert werden
      sliderInput(inputId = "bins",
                  label = "Anzahl der Behälter:",
                  min = 1,
                  max = 40,
                  value = 10),
      selectInput(inputId = "car_models",
                  label = "Wählen Sie das Auto!",
                  choices = rownames(mtcars),
                  multiple = TRUE,
                  selected = rownames(mtcars),
                  selectize = FALSE)
      
    ),
    
    # Das Main Panel soll dazu dienen, Outputs anzuzeigen ----
    mainPanel(
      
      # Hier erstellen wir einen Platzhalter, 
      # an dem der Plot mit der ID distPlot angezeigt werden soll ----
      plotOutput(outputId = "distPlot"),
      plotOutput(outputId = "scatterplot"),
      dataTableOutput(outputId = "table")
      # --- Hier soll eine tabellarische Uebersicht der Daten angezeigt werden ---
      # Hinweis: verwenden Sie eine Funktion des Pakets DT
      
    )
  )
)

# Um Berechnungen auszufuehren benoetigen wir eine Serverfunktion
# Berechnungen sind nur innerhalb der Serverfunktion zulaessig, nicht im UI!
server <- function(input, output) {
  
  # Hier werden die Daten angelegt
  car_data <- reactive({
    car_data <- mtcars # Die Daten stammen aus dem MTCars Datensatz
    print(car_data)
    colnames(car_data)[1] <- "Liter pro 100KM"
    car_data[1] <- car_data[1] * 1.609344 # Kilometer pro Gallone
    car_data[1] <- 100 / car_data[1] # Gallonen pro 100km
    car_data[1] <- round((car_data[1] * 3.78541), digits = 3) # Liter pro 100km
    # --- Benennen Sie die Spalte MPG in Liters um ---
    # --- Berechnen Sie anhand der Umrechnungsformel den Verbrauch in Litern pro 100 Km ---
    car_data[input$car_models,]
  })
  
  # Fuer jede Berechnung oder Ausgabe wird eine eigene Funktion erstellt
  # Diese kann anschliessend im UI referenziert werden
  output$distPlot <- renderPlot({
    
    x    <- car_data()$Liter # Variablen lassen sich ganz normal definieren
    # --- Bitte rechnen Sie den Kraftstoffverbrauch in Liter pro 100 KM um ---
    bins <- seq(min(x), max(x)+1, length.out = input$bins + 1) # Erstellen von Bins eines Histogramms
    hist(x, breaks = bins, col = "#75AADB", border = "white", # Mit der hist Funktion kann ein Histogramm geplottet werden
         xlab = "Verbrauch in Liter pro 100 KM", # Dabei werden Daten sowie optionale Bins spezifiziert
         main = "Histogramm Kraftstoffverbrauch") # Ebenfalls koennen visuelle Parameter uebergeben werden, wie bspw. die Farbe
    
  })
  
  
  # --- Hier soll eine grafische Uebersicht der Daten generiert werden ---
  # Hinweis: verwenden Sie die Funktion plot
  
  output$scatterplot <- renderPlot({
    x <- car_data()$disp
    y <- car_data()$hp
    
    plot(x, y, col = car_data()$cyl, pch=19, xlab = "Hubraum", ylab = "PS", main = "Hubraum vs. PS nach Zylinder")
    abline(v=mean(x), col="green")
    abline(h=mean(y), col="red")
    legend(x="topright", legend = unique(car_data()$cyl), pch = 1, col = c("blue", "purple", "grey"), title = "Zylinder")
  })
  
  # --- Hier soll eine tabellarische Uebersicht der Daten generiert werden ---
  # Hinweis: verwenden Sie eine Funktion des Pakets DT
  
  output$table <- renderDataTable({
    car_data()
  })
  
}


# ---  Starten Sie den Shiny Server ---
shiny::shinyApp(ui, server)
