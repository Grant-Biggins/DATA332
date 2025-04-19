library(shiny)
library(ggplot2)
library(DT)
library(dplyr)
library(readxl)
library(RCurl)
library(bslib)


data_url <- getURL("https://raw.githubusercontent.com/1R0NCL4D-B4ST10N/DATA332/main/carTracker/carTracker.csv")

dataset <- read.csv(text = data_url)

dataset <- dataset[, 1:7]  # Drop unnamed column if it exists
dataset <- dataset %>% filter(!is.na(MPH))  # Ensure MPH is valid
column_names <- colnames(dataset)

ui <- fluidPage(
  theme = bs_theme(
    version = 5,
    bootswatch = "darkly"
  ),
  
  titlePanel("Car Tracking Analysis Dashboard"),
  
  tabsetPanel(
    tabPanel("Data Explorer",
             sidebarLayout(
               sidebarPanel(
                 selectInput("X", "Choose X", column_names, "Color"),
                 selectInput("Y", "Choose Y", column_names, "MPH"),
                 selectInput("Splitby", "Split By", column_names, "Student")
               ),
               mainPanel(
                 plotOutput("plot_01")
               )
             )
    ),
    
    tabPanel("Color by Student",
             plotOutput("color_barplot")
    ),
    
    tabPanel("Speed Histogram",
             plotOutput("speed_hist")
    ),
    
    tabPanel("Speed by Student",
             plotOutput("speed_boxplot")
    ),
    
    tabPanel("Summary Statistics",
             verbatimTextOutput("stats_output")
    ),
    
    tabPanel("Data Table",
             DT::dataTableOutput("data_table")
    )
  )
)

server <- function(input, output) {
  
  # Original scatter plot
  output$plot_01 <- renderPlot({
    ggplot(dataset, aes_string(x = input$X, y = input$Y, colour = input$Splitby)) +
      geom_point(size = 3, alpha = 0.7) +
      theme_minimal() +
      labs(title = "Data Explorer")
  })
  
  # Bar chart of car colors by student
  output$color_barplot <- renderPlot({
    ggplot(dataset, aes(x = Color, fill = Student)) +
      geom_bar(position = "dodge") +
      theme_minimal() +
      labs(title = "Car Colors by Student", x = "Color", y = "Count")
  })
  
  # Histogram of MPH
  output$speed_hist <- renderPlot({
    ggplot(dataset, aes(x = MPH)) +
      geom_histogram(binwidth = 2, fill = "#738595", color = "black") +
      theme_minimal() +
      labs(title = "Distribution of Vehicle Speeds (MPH)", x = "Speed (MPH)", y = "Frequency")
  })
  
  # Boxplot of MPH by Student
  output$speed_boxplot <- renderPlot({
    ggplot(dataset, aes(x = Student, y = MPH, fill = Student)) +
      geom_boxplot() +
      theme_minimal() +
      labs(title = "Speed by Student", x = "Student", y = "MPH")
  })
  
  # Summary stats
  output$stats_output <- renderPrint({
    stats <- dataset$MPH
    
    # Identify rows for min and max
    min_row <- dataset[which.min(dataset$MPH), ]
    max_row <- dataset[which.max(dataset$MPH), ]
    
    # Build output with full sentences
    cat(paste0("There are ", length(stats), " vehicle observations recorded.\n"))
    cat(paste0("The minimum recorded speed is ", min(stats), " MPH, observed on a ", min_row$Color, " car.\n"))
    cat(paste0("The maximum recorded speed is ", max(stats), " MPH, observed on a ", max_row$Color, " car.\n"))
    cat(paste0("The average speed is ", round(mean(stats), 2), " MPH.\n"))
    cat(paste0("The median speed is ", median(stats), " MPH.\n"))
    cat(paste0("The standard deviation of speed is ", round(sd(stats), 2), " MPH.\n"))
  })
  
  # Full data table
  output$data_table <- DT::renderDataTable({
    DT::datatable(dataset, options = list(pageLength = 10))
  })
}

shinyApp(ui = ui, server = server)