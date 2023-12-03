# shiny.R
library(shiny)
library(httr)

# Define UI
ui <- fluidPage(
  titlePanel("Calificación de Vino"),
  sidebarLayout(
    sidebarPanel(
      numericInput("density", "Densidad:", value = 0),
      numericInput("alcohol", "Alcohol:", value = 0),
      numericInput("citric_acid", "Ácido cítrico:", value = 0),
      numericInput("residual_sugar", "Azúcar residual:", value = 0),
      numericInput("pH", "pH:", value = 0),
      radioButtons("wine_type", "Tipo de Vino:",
                   choices = c("Blanco" = "white", "Rojo" = "red"),
                   selected = "white"),
      actionButton("predict_button", "Predecir")
    ),
    mainPanel(
      h3("Resultado de la Predicción:"),
      verbatimTextOutput("prediction_output")
    )
  )
)

# Define server logic
server <- function(input, output) {
  observeEvent(input$predict_button, {
    # Construir el objeto JSON con las características del vino
    wine_data <- list(
      density = input$density,
      alcohol = input$alcohol,
      citric_acid = input$citric_acid,
      residual_sugar = input$residual_sugar,
      pH = input$pH,
      type = input$wine_type
    )
    
    # Realizar la solicitud a la API Flask para obtener la predicción
    response <- POST("http://flask-api:5000/predict",
                     body = list(data = toJSON(wine_data)),
                     encode = "json")
    
    # Extraer y mostrar la predicción
    prediction <- content(response, "text")
    output$prediction_output <- renderText(paste("Calificación predicha:", prediction))
  })
}

# Run the application
shinyApp(ui = ui, server = server)
