# Car Tracker Analysis Dashboard

This Shiny app presents an analysis of vehicle speed data collected by two students at 30th Street in Rock Island and 7th Street in Moline, IL. The dashboard includes interactive charts, summary statistics, and raw data tables for exploring patterns in vehicle speed and appearance.

---

## Dataset Information

- **Source**: The dataset is pulled dynamically from [GitHub](https://github.com/1R0NCL4D-B4ST10N/DATA332/tree/main/carTracker) (this GitHub) using the `RCurl` package.
- **Columns Used**:
  - `TimeTracked`: Date/time of observation. Grant recorded times in the afternoon/evening, whilst Xander recorded times at noon.
  - `SpeedLimit`: Posted speed limit at the site
  - `MPH`: Actual measured speed
  - `Color`: Color of the car
  - `Student`: Observer's name
  - `Location`: General location label

---

## Data Collection & Collaboration

Each student independently recorded vehicle speeds at different times of the day using a radar gun. Coordination was maintained via messaging apps and Google Docs to ensure full coverage of the assignment area. Observations were split equally and merged into a single dataset for analysis.

---

## Dashboard Features

### 1. Data Explorer

This scatter plot is completely customizeable by the user, allowing them to look at the data in any way they wish. It is by default set to Color by MPH, split by Student.

### 2. Car Colors by Student
![colorByStudent](https://github.com/user-attachments/assets/a3809f57-43ac-4d50-909a-1785884bc4dc)

This chart displays the distribution of car colors as recorded by each student. Grant observed more black and red vehicles, while Xander noted a large spike in white vehicles. This could be due to different collection times or directional traffic flow.

---

### 3. Distribution of Vehicle Speeds (MPH)
![speedHistogram](https://github.com/user-attachments/assets/1585b7af-a9ca-46b3-b4f9-ab551a72a90f)

This histogram shows the overall spread of vehicle speeds. Most vehicles were recorded between 27–35 MPH, with very few extreme outliers. The shape suggests a roughly normal distribution with a slight right skew.

---

### 4. Speed by Student
![speedByStudent](https://github.com/user-attachments/assets/db0e116e-4eb3-47ad-b3a2-dc3a8b8752f4)


The boxplot compares speed distributions for each student. Grant observed a wider range with multiple low outliers, while Xander recorded more upper-range speeds, including the highest single value. This may reflect time-of-day differences or local traffic conditions.

---

## 5. Statistical Summary

- A total of **151 vehicle observations** were recorded.
- The **minimum speed** was **14 MPH**, observed on a **Red** car.
- The **maximum speed** was **44 MPH**, observed on a **Silver** car.
- The **average speed** was **30.15 MPH**.
- The **median speed** was **30 MPH**, very close to the mean.
- The **standard deviation** was **4.51 MPH**, indicating moderate spread in values.

---

## How to Run This App

1. Clone or download the repository.
2. Open `app.R` in RStudio.
3. Ensure the following packages are installed:

```r
install.packages(c("shiny", "ggplot2", "DT", "dplyr", "RCurl", "bslib"))
```

4. Click **Run App** in RStudio.

---

## Conclusion

This dashboard allowed us to identify potential factors that impact traffic speed (like vehicle color trends or student timing). Collaboration, time management, and effective use of Shiny/R helped streamline our analysis process and visualize the data clearly.
If we had to change anything, we believe the main thing we would change is how we tracked the cars. We most likely should have gone with models over colors, like Sedan, SUV, or Truck. We also should have both taken pictures to get completely accurate time stamps.
