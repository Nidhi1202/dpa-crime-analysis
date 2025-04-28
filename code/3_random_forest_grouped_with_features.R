# 3_random_forest.R
# -----------------------
# Crime Data Preprocessing Script
# Author: Nidhi Shrivastav, Lavisha Chhatwani, Gladys Gince Skariah
# Project: Crime Analysis
# Date: Spring 2025
 
library(tidyverse)

final <- read_csv("data/cleaned_crime_data_grouped.csv", col_types = cols())

final$CrimeCategory <- as.factor(final$CrimeCategory)

# ---------------------------
# ADD NEW FEATURES
# ---------------------------

final$Weekend <- ifelse(final$Day %in% c("Sat", "Sun"), "Weekend", "Weekday")
final$Weekend <- as.factor(final$Weekend)

final$TimePeriod <- case_when(
  final$Hour >= 0 & final$Hour < 6 ~ "Late Night",
  final$Hour >= 6 & final$Hour < 12 ~ "Morning",
  final$Hour >= 12 & final$Hour < 18 ~ "Afternoon",
  final$Hour >= 18 & final$Hour <= 23 ~ "Evening"
)
final$TimePeriod <- as.factor(final$TimePeriod)

cat("\n New Features 'Weekend' and 'TimePeriod' added successfully.\n")

# ---------------------------
# Save updated dataset
# ---------------------------

write_csv(final, "data/cleaned_crime_data_grouped_with_features.csv")
cat("\n Saved updated dataset with new features: 'data/cleaned_crime_data_grouped_with_features.csv'\n")


final <- read_csv("data/cleaned_crime_data_grouped_with_features.csv", col_types = cols())

final <- final %>%
  mutate(
    CrimeCategory = as.factor(CrimeCategory),
    Weekend = as.factor(Weekend),
    TimePeriod = as.factor(TimePeriod),
    Arrest = as.factor(Arrest),
    Domestic = as.factor(Domestic),
    Quadrant = as.factor(Quadrant),
    Season = as.factor(Season),
    TimeOfDay = as.factor(TimeOfDay),
    Month = as.factor(Month),
    Day = as.factor(Day),
    Year = as.factor(Year)
  )

data_for_model <- final %>%
  select(-Date, -Primary.Type, -Description, -Location.Description, -Latitude, -Longitude, -Hour)

# ---------------------------
# Train-Test Split (90-10)
# ---------------------------

set.seed(123)
trainIndex <- createDataPartition(data_for_model$CrimeCategory, p = 0.9, list = FALSE)
train_data <- data_for_model[trainIndex, ]
test_data <- data_for_model[-trainIndex, ]

# ---------------------------
# Train Random Forest
# ---------------------------

library(randomForest)

set.seed(123)
rf_model_features <- randomForest(CrimeCategory ~ ., data = train_data, ntree = 200, importance = TRUE)

train_pred <- predict(rf_model_features, train_data)
train_accuracy <- mean(train_pred == train_data$CrimeCategory)
cat("\n Training Accuracy with new features:", round(train_accuracy * 100, 2), "%\n")

test_pred <- predict(rf_model_features, test_data)
test_accuracy <- mean(test_pred == test_data$CrimeCategory)
cat(" Testing Accuracy with new features:", round(test_accuracy * 100, 2), "%\n")

library(caret)
conf_matrix <- confusionMatrix(test_pred, test_data$CrimeCategory)
print(conf_matrix)

saveRDS(rf_model_features, "output/random_forest_grouped_with_features_model.rds")
cat("\n Random Forest Model (with new features) saved.\n")
