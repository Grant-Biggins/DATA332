install.packages("readxl")
library(readxl)
library(dplyr)
library(ggplot2)
library(lubridate)
setwd("C:\\Users\\13038\\Downloads\\Student Data GB")
list.files()
course <- read_excel("Course.xlsx")

registration <- read_excel("Registration.xlsx")

student <- read_excel("Student.xlsx")

View(course)
View(registration)
View(student)

#Left Join
student_registration <- left_join(registration, student, by = "Student ID")

full_data <- left_join(student_registration, course, by = "Instance ID")

# Count of all majors
major_count <- full_data %>%
  count(Title)

ggplot(major_count, aes( x = Title, y = n, fill = Title)) + 
  geom_bar(stat = "identity") +
  theme_minimal() + 
  labs(tittle = "Number of Students per Major", x = "Majors", y = "Count")
#Birth Year
#NA Values in Birth Year Only
birth_year_counts <- student %>%
  mutate(Birth_Year = year(`Birth Date`)) %>%
  count(Birth_Year, name = "count")
# Display the counts
print(birth_year_counts)

#Cost per major 
cost_per_major <- full_data %>%
  group_by(Title, `Payment Plan`) %>%
  summarise(Cost = sum(Cost, na.rm = TRUE))

ggplot(cost_per_major, aes(x = Title, y = Cost, fill = `Payment Plan`)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "Total Cost per Major by Payment Plan", x = "Title", y = "Cost")

#Total Balance Due
balance_per_major <- full_data %>%
  group_by(Title, `Payment Plan`) %>%
  summarise(Balance_Due = sum(`Balance Due`, na.rm = TRUE))

ggplot(balance_per_major, aes(x = Title, y = Balance_Due, fill = `Payment Plan`)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "Total Balance Due per Major by Payment Plan", x = "Title", y = "Balance Due")



