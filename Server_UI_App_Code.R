# Define UI
ui <- fluidPage(
  titlePanel("Vehicle Selector Based on Transmission and MPG"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons("transmission", "Transmission Type:",
                   choices = list("Automatic" = 0, "Manual" = 1)),
      sliderInput("mpg",
                  "Minimum MPG:",
                  min = 0,  # Updated to avoid dependency on mtcars when defining UI
                  max = 40, # Updated to avoid dependency on mtcars when defining UI
                  value = 0.0), # Default value set for a better user experience
      actionButton("submit", "Submit"),
      actionButton("reset", "Reset")
    ),
    
    mainPanel(
      textOutput("vehicleList")
    )
  )
)

# Define server logic
server <- function(input, output, session) {
  # Load mtcars dataset into the environment
  data(mtcars)
  
  # Variable to track whether transmission selection has been made
  transmissionSelected <- reactiveVal(FALSE)
  
  observeEvent(input$transmission, {
    # Set transmissionSelected to TRUE when a selection is made
    transmissionSelected(TRUE)
    # Disable the radioButtons control to prevent further toggling
    updateRadioButtons(session, "transmission", choices = list("Automatic" = 0, "Manual" = 1), disabled = TRUE)
  })
  
  observeEvent(input$reset, {
    # Reset the transmission selection and enable the radioButtons control
    transmissionSelected(FALSE)
    updateRadioButtons(session, "transmission", choices = list("Automatic" = 0, "Manual" = 1), selected = NULL, disabled = FALSE)
  })
  
  observeEvent(input$submit, {
    # Check if mtcars dataset is available
    req(mtcars)
    
    # Proceed with your submit logic here
    # ...
  })
}

# Run the app
shinyApp(ui = ui, server = server)
