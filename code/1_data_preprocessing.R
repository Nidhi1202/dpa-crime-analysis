# 1_data_preprocessing.R
# -----------------------
# Crime Data Preprocessing Script
# Author: Nidhi Shrivastav, Lavisha Chhatwani, Gladys Gince Skariah
# Project: Crime Analysis
# Date: Spring 2025

library(tidyverse)
library(lubridate)

data_path <- "data/Illinois_Crime_Data.csv"
output_path <- "data/cleaned_crime_data.csv"

if (!file.exists(data_path)) {
  stop("Data file not found. Please place the raw crime data inside the 'data' folder.")
}

crime_data <- read_csv(data_path, col_types = cols())

final <- crime_data %>%
  select(Date, `Primary Type`, Description, `Location Description`, Arrest, Domestic, Latitude, Longitude) %>%
  na.omit() %>%
  rename(
    Primary.Type = `Primary Type`,
    Location.Description = `Location Description`
  )

final <- final %>%
  mutate(
    Date = as.POSIXct(Date, format = "%m/%d/%Y %I:%M:%S %p"),
    Hour = hour(Date),
    Month = months(Date, abbreviate = TRUE),
    Year = year(Date),
    Day = weekdays(Date, abbreviate = TRUE),
    TimeOfDay = ifelse(Hour >= 6 & Hour < 18, "Day", "Night"),
    Season = case_when(
      Month %in% c("Mar", "Apr", "May") ~ "Spring",
      Month %in% c("Jun", "Jul", "Aug") ~ "Summer",
      Month %in% c("Sep", "Oct", "Nov") ~ "Fall",
      TRUE ~ "Winter"
    )
  )

x_mid <- mean(range(final$Longitude, na.rm = TRUE))
y_mid <- mean(range(final$Latitude, na.rm = TRUE))

final <- final %>%
  mutate(
    Quadrant = as.factor(ifelse(
      Longitude < x_mid & Latitude >= y_mid, 1,
      ifelse(Longitude >= x_mid & Latitude >= y_mid, 2,
             ifelse(Longitude < x_mid & Latitude < y_mid, 3, 4))
    ))
  )

write_csv(final, output_path)

cat("\n Preprocessing done! Cleaned file saved to:", output_path, "\n")
