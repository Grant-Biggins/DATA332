
# Uber NYC Trips Dashboard

This Shiny app analyzes over 4.5 million Uber pickup records across NYC from April–September 2014. The app is fully interactive and includes bar charts, heatmaps, and a leaflet geospatial map. Data is fully wrangled in R.

## Live App

[https://grantbiggins.shinyapps.io/UberTripDashboard/](https://grantbiggins.shinyapps.io/UberTripDashboard/)

---

## Project Structure

```
UberTripDashboard/
├── app.R                  # Final Shiny app script
└── uber_raw_csvs/         # Raw Uber CSVs (Apr–Sep 2014)
```

---

## Data Cleaning & Transformation in R

```r
csv_files <- list.files("uber_raw_csvs", pattern = "uber-raw-data-.*\.csv", full.names = TRUE)
uber_data <- bind_rows(lapply(csv_files, read_csv)) %>%
  mutate(`Date/Time` = as.POSIXct(`Date/Time`, format = "%m/%d/%Y %H:%M:%S"),
         Hour = hour(`Date/Time`),
         Day = day(`Date/Time`),
         Weekday = wday(`Date/Time`, week_start = 1) - 1,
         Month = month(`Date/Time`, label = TRUE, abbr = FALSE),
         Week = isoweek(`Date/Time`))
```

---

## Chart Code Snippets & Insights

> All charts are rendered inside the app. Below are code snippets that create them.

### Trips by Hour
```r
output$hourPlot <- renderPlotly({
  data <- uber_data %>% count(Hour)
  ggplotly(ggplot(data, aes(x = Hour, y = n)) +
             geom_col(fill = "steelblue") +
             labs(y = "Trips", title = "Trips by Hour"))
})
```
Insight: Peak usage between 4–7 PM, reflecting commuter trends.

---

### Trips by Day
```r
output$dayPlot <- renderPlotly({
  data <- uber_data %>% count(Day)
  ggplotly(ggplot(data, aes(x = Day, y = n)) +
             geom_col(fill = "firebrick") +
             labs(y = "Trips", title = "Trips by Day"))
})
```
Insight: Slight increase on weekends, especially around the 10th and 20th of each month.

---

### Trips by Month
```r
output$monthPlot <- renderPlotly({
  data <- uber_data %>% count(Month)
  ggplotly(ggplot(data, aes(x = Month, y = n)) +
             geom_col(fill = "forestgreen") +
             labs(y = "Trips", x = "Month", title = "Trips by Month"))
})
```
Insight: July and August are the highest-traffic months.

---

### Trips by Base + Month
```r
output$basePlot <- renderPlotly({
  data <- uber_data %>% count(Base, Month)
  ggplotly(ggplot(data, aes(x = Base, y = n, fill = Month)) +
             geom_col(position = "dodge") +
             labs(title = "Trips by Base and Month", y = "Trips", fill = "Month"))
})
```
Insight: Base B02617 consistently records the most pickups.

---

### Heatmap: Hour vs Weekday
```r
output$heatHourWeekday <- renderPlot({
  data <- uber_data %>% count(Weekday, Hour)
  ggplot(data, aes(x = Hour, y = Weekday, fill = n)) +
    geom_tile() +
    scale_fill_viridis_c() +
    labs(title = "Heatmap: Hour vs Weekday", y = "Weekday", x = "Hour")
})
```
Insight: Most intense pickup volume occurs Friday/Saturday evenings.

---

### Heatmap: Month vs Day
```r
output$heatMonthDay <- renderPlot({
  data <- uber_data %>% count(Month, Day)
  ggplot(data, aes(x = Day, y = Month, fill = n)) +
    geom_tile() +
    scale_fill_viridis_c() +
    labs(title = "Heatmap: Month vs Day", x = "Day", y = "Month")
})
```
Insight: Spikes around specific weekends in August and July.

---

### Heatmap: Month vs Week
```r
output$heatMonthWeek <- renderPlot({
  data <- uber_data %>% count(Month, Week)
  ggplot(data, aes(x = Week, y = Month, fill = n)) +
    geom_tile() +
    scale_fill_viridis_c() +
    labs(title = "Heatmap: Month vs Week", x = "Week", y = "Month")
})
```
Insight: Strong weekly patterns suggest regular rider behavior.

---

### Heatmap: Base vs Day of Week
```r
output$heatBaseWeekday <- renderPlot({
  data <- uber_data %>% count(Base, Weekday)
  ggplot(data, aes(x = Weekday, y = Base, fill = n)) +
    geom_tile() +
    scale_fill_viridis_c() +
    labs(title = "Heatmap: Base vs Day of Week", x = "Weekday", y = "Base")
})
```
Insight: Base B02617 has weekend spikes, B02598 is more balanced.

---

### Leaflet Map
```r
output$pickupMap <- renderLeaflet({
  leaflet(data = uber_data[1:5000, ]) %>%
    addProviderTiles("CartoDB.DarkMatter") %>%
    addCircleMarkers(~Lon, ~Lat, radius = 2, color = "orange", opacity = 0.7)
})
```
Insight: Manhattan is the most concentrated pickup zone.

---

### Daily Trip Trend
```r
output$modelPlot <- renderPlot({
  model_data <- uber_data %>% count(Date = as.Date(`Date/Time`))
  ggplot(model_data, aes(x = Date, y = n)) +
    geom_line(color = "skyblue") +
    labs(title = "Trips Over Time", y = "Trips per Day")
})
```
Insight: Overall stable usage with consistent weekend dips.

---

## Run the App Locally

```r
# Set working directory
setwd("C:/Users/13038/Downloads/UberTripDashboard")

# Run the app
source("app.R")
```

---

## Required Packages

```r
install.packages(c(
  "shiny", "shinydashboard", "leaflet", "ggplot2",
  "plotly", "dplyr", "readr", "lubridate", "bslib"
))
```

---

## Note

All data wrangling was performed in R — **no Excel manipulation was used**. All charts and graphs are embedded in the Shiny app.
