
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

## Chart Descriptions & Insights

> All visualizations are shown **inside the Shiny app**, not here.

- **Trips by Hour**:  
  Peak ride volume consistently occurs between **4 PM – 7 PM**, likely due to commuting.

- **Trips by Day**:  
  Most days have steady usage, but **weekends tend to spike**, especially around the 10th and 20th of each month.

- **Trips by Month**:  
  **July and August** are the highest-traffic months — this could be linked to summer tourism or local events.

- **Trips by Base + Month**:  
  **Base B02617** has the most pickups across all months. It may serve a larger area or operate longer hours.

- **Heatmap: Hour vs Weekday**:  
  **Late afternoon and evening hours** on **Fridays and Saturdays** have the highest density of trips.

- **Heatmap: Month vs Day**:  
  Certain days in **August and July** are particularly heavy — likely weekends or holidays.

- **Heatmap: Month vs Week**:  
  Shows consistent ride patterns throughout each month, with weekly peaks repeating.

- **Heatmap: Base vs Day of Week**:  
  Some bases (like **B02617** and **B02598**) are heavily active on weekends, while others are more balanced.

- **Leaflet Map**:  
  Shows high-density pickups in **Manhattan**, especially Midtown and Downtown — Uber’s core service area.

- **Daily Trip Trend**:  
  Visualizes consistent daily activity with periodic dips, likely due to weather or holidays.

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
