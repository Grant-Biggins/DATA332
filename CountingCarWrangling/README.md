# All Cars - Counting Car Observations

## Overview
This project combines car observation data collected by multiple students in DATA 332. Each group submitted vehicle speed, color, and observer info from local data collection efforts. The data has been cleaned, unified, and visualized in an interactive Shiny dashboard.

Live App: [https://grant-biggins.shinyapps.io/All_Cars/](https://grant-biggins.shinyapps.io/All_Cars/)  
Data Source: [combined_car_data.csv on GitHub](https://raw.githubusercontent.com/Grant-Biggins/DATA332/refs/heads/main/combined_car_data.csv)

## Dataset Details

| Column   | Description                          |
|----------|--------------------------------------|
| `Date`   | Date of vehicle observation          |
| `Time`   | Time of observation (if provided)    |
| `MPH`    | Recorded vehicle speed (miles/hour)  |
| `Color`  | Color or type of vehicle             |
| `Student`| Observer's name or initials          |

## Dashboard Tabs

- Data Explorer – Scatter plot of user-selected X and Y columns, grouped by student
- Color by Student – Bar chart of car colors by observer
- Speed Histogram – Histogram of recorded car speeds
- Speed by Student – Boxplot comparing student-observed speed distributions
- Summary Stats – Summary of min, max, mean, median, and standard deviation
- Data Table – Full interactive view of the cleaned dataset

## Data Wrangling Process

- Imported `.csv` and `.xlsx` files from classmates
- Standardized columns using `dplyr::rename()` and `readxl`
- Filled missing values (e.g. median for speed, "Unknown" for observer)
- Converted inconsistent date formats with `lubridate::parse_date_time()`
- Combined all datasets using `bind_rows()`
- Hosted the cleaned dataset on GitHub for lightweight Shiny deployment

## What I Learned

This assignment showed me how difficult it can be to collect consistent data across multiple observers. Even with the same goal in mind, each student recorded slightly different column names, formats, or levels of detail. These small differences made data cleaning a major part of the project. I learned that strong data collection requires clear standards up front like naming conventions, required fields, and formatting expectations. Beyond that, we also encountered issues like duplicated headers, misspelled column names, conflicting column types (e.g. numeric vs character), and non-standard timestamp entries. Some spreadsheets had merged cells or used unexpected labels, like “Initial_Read” instead of “Speed,” which had to be manually mapped. We also had to rotate axis labels in our plots to make charts readable and avoid app deployment issues related to unrelated files in the Shiny folder. This experience reinforced the importance of careful planning when designing a data collection process, especially in group settings or collaborative research.
