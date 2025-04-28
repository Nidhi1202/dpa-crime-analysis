# 4_XGboost_modeling.R
# ---------------------------
# XGboost Modeling Script
# Author: Nidhi Shrivastav, Lavisha Chhatwani, Gladys Gince Skariah
# Project: Crime Analysis
# Date: Spring 2025

install.packages("xgboost")
install.packages("caret")
library(caret)
library(Matrix)
library(xgboost)


install.packages("Matrix") 

final <- read_csv("data/cleaned_crime_data_grouped.csv", col_types = cols())

final$CrimeCategory <- as.factor(final$CrimeCategory)

data_for_model <- final %>%
  select(-Date, -Primary.Type, -Description, -Location.Description, -Latitude, -Longitude, -Hour)

dummies <- dummyVars(CrimeCategory ~ ., data = data_for_model)
x_data <- predict(dummies, newdata = data_for_model)

x_matrix <- as.matrix(x_data)

y_label <- as.numeric(data_for_model$CrimeCategory) - 1  # XGBoost needs labels starting from 0

set.seed(123)
trainIndex <- createDataPartition(y_label, p = 0.8, list = FALSE)

x_train <- x_matrix[trainIndex, ]
y_train <- y_label[trainIndex]

x_test <- x_matrix[-trainIndex, ]
y_test <- y_label[-trainIndex]


set.seed(123)

xgb_model <- xgboost(
  data = x_train,
  label = y_train,
  objective = "multi:softmax",
  num_class = 3,      
  nrounds = 100,
  eta = 0.3,
  max_depth = 6,
  eval_metric = "merror",
  verbose = 0
)

cat("\n XGBoost Training Completed!\n")


train_pred <- predict(xgb_model, x_train)
test_pred <- predict(xgb_model, x_test)

train_accuracy <- mean(train_pred == y_train)
cat("\n XGBoost Training Accuracy:", round(train_accuracy * 100, 2), "%\n")

test_accuracy <- mean(test_pred == y_test)
cat(" XGBoost Testing Accuracy:", round(test_accuracy * 100, 2), "%\n")

conf_matrix <- table(Predicted = test_pred, Actual = y_test)
print(conf_matrix)

xgb.save(xgb_model, "output/xgboost_crime_model.model")
cat("\n XGBoost Model Saved Successfully.\n")

