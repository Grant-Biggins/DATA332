
# app.R

library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)
library(plotly)
library(dplyr)
library(readr)
library(lubridate)
library(bslib)

options(scipen = 999)

# Load and combine all CSVs from folder
csv_files <- list.files("uber_raw_csvs", pattern = "uber-raw-data-.*\\.csv", full.names = TRUE)
uber_data <- bind_rows(lapply(csv_files, read_csv))

# Clean and create new time-based features
uber_data <- uber_data %>%
  mutate(`Date/Time` = as.POSIXct(`Date/Time`, format = "%m/%d/%Y %H:%M:%S"),
         Hour = hour(`Date/Time`),
         Day = day(`Date/Time`),
         Weekday = wday(`Date/Time`, week_start = 1) - 1,
         Month = month(`Date/Time`, label = TRUE, abbr = FALSE),
         Week = isoweek(`Date/Time`))

# UI
ui <- dashboardPage(
  skin = "black",
  dashboardHeader(title = "Uber Trips Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview"),
      menuItem("Trips by Time", tabName = "time"),
      menuItem("Trips by Base", tabName = "base"),
      menuItem("Heatmaps", tabName = "heat"),
      menuItem("Geo Map", tabName = "map"),
      menuItem("Prediction", tabName = "predict")
    )
  ),
  dashboardBody(
    theme = bs_theme(bootswatch = "darkly"),
    tabItems(
      tabItem("overview", fluidRow(
        box(title = "Summary", width = 12, verbatimTextOutput("summary"))
      )),
      tabItem("time", fluidRow(
        box(title = "Trips by Hour", width = 6, plotlyOutput("hourPlot")),
        box(title = "Trips by Day", width = 6, plotlyOutput("dayPlot"))
      ), fluidRow(
        box(title = "Trips by Month", width = 12, plotlyOutput("monthPlot"))
      )),
      tabItem("base", fluidRow(
        box(title = "Trips by Base and Month", width = 12, plotlyOutput("basePlot"))
      )),
      tabItem("heat", 
        fluidRow(
          box(title = "Heatmap: Hour vs Weekday", width = 12, plotOutput("heatHourWeekday"))
        ),
        fluidRow(
          box(title = "Heatmap: Month vs Day", width = 12, plotOutput("heatMonthDay"))
        ),
        fluidRow(
          box(title = "Heatmap: Month vs Week", width = 12, plotOutput("heatMonthWeek"))
        ),
        fluidRow(
          box(title = "Heatmap: Base vs Day of Week", width = 12, plotOutput("heatBaseWeekday"))
        )
      ),
      tabItem("map", fluidRow(
        box(title = "Uber Pickups Map", width = 12, leafletOutput("pickupMap", height = 600))
      )),
      tabItem("predict", fluidRow(
        box(title = "Trip Forecast Placeholder", width = 12, plotOutput("modelPlot"))
      ))
    )
  )
)

# Server
server <- function(input, output, session) {
  output$summary <- renderPrint({ summary(uber_data) })

  output$hourPlot <- renderPlotly({
    data <- uber_data %>% count(Hour)
    ggplotly(ggplot(data, aes(x = Hour, y = n)) +
               geom_col(fill = "steelblue") +
               labs(y = "Trips", title = "Trips by Hour"))
  })

  output$dayPlot <- renderPlotly({
    data <- uber_data %>% count(Day)
    ggplotly(ggplot(data, aes(x = Day, y = n)) +
               geom_col(fill = "firebrick") +
               labs(y = "Trips", title = "Trips by Day"))
  })

  output$monthPlot <- renderPlotly({
    data <- uber_data %>% count(Month)
    ggplotly(ggplot(data, aes(x = Month, y = n)) +
               geom_col(fill = "forestgreen") +
               labs(y = "Trips", x = "Month", title = "Trips by Month"))
  })

  output$basePlot <- renderPlotly({
    data <- uber_data %>% count(Base, Month)
    ggplotly(ggplot(data, aes(x = Base, y = n, fill = Month)) +
               geom_col(position = "dodge") +
               labs(title = "Trips by Base and Month", y = "Trips", fill = "Month"))
  })

  output$heatHourWeekday <- renderPlot({
    data <- uber_data %>% count(Weekday, Hour)
    ggplot(data, aes(x = Hour, y = Weekday, fill = n)) +
      geom_tile() +
      scale_fill_viridis_c() +
      labs(title = "Heatmap: Hour vs Weekday", y = "Weekday", x = "Hour")
  })

  output$heatMonthDay <- renderPlot({
    data <- uber_data %>% count(Month, Day)
    ggplot(data, aes(x = Day, y = Month, fill = n)) +
      geom_tile() +
      scale_fill_viridis_c() +
      labs(title = "Heatmap: Month vs Day", x = "Day", y = "Month")
  })

  output$heatMonthWeek <- renderPlot({
    data <- uber_data %>% count(Month, Week)
    ggplot(data, aes(x = Week, y = Month, fill = n)) +
      geom_tile() +
      scale_fill_viridis_c() +
      labs(title = "Heatmap: Month vs Week", x = "Week", y = "Month")
  })

  output$heatBaseWeekday <- renderPlot({
    data <- uber_data %>% count(Base, Weekday)
    ggplot(data, aes(x = Weekday, y = Base, fill = n)) +
      geom_tile() +
      scale_fill_viridis_c() +
      labs(title = "Heatmap: Base vs Day of Week", x = "Weekday", y = "Base")
  })

  output$pickupMap <- renderLeaflet({
    leaflet(data = uber_data[1:5000, ]) %>%
      addProviderTiles("CartoDB.DarkMatter") %>%
      addCircleMarkers(~Lon, ~Lat, radius = 2, color = "orange", opacity = 0.7)
  })

  output$modelPlot <- renderPlot({
    model_data <- uber_data %>% count(Date = as.Date(`Date/Time`))
    ggplot(model_data, aes(x = Date, y = n)) +
      geom_line(color = "skyblue") +
      labs(title = "Trips Over Time", y = "Trips per Day")
  })
}

shinyApp(ui, server)
