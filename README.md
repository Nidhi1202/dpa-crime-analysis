# Crime Analysis and Prediction at Illinois Institute of Technology (IIT)

## Project Overview
This project analyzes crime data around the Illinois Institute of Technology (IIT) area to explore patterns and predict the type of crime occurring based on time, location, and other temporal factors.  
The goal was to preprocess real-world crime data, perform exploratory data analysis (EDA), engineer meaningful features, and build machine learning models to predict broader categories of crimes.

---

##️ Folder Structure

```text
/dpa-crime-analysis/
├── data/
│   ├── cleaned_crime_data.csv
│   ├── cleaned_crime_data_grouped.csv
│   ├── cleaned_crime_data_grouped_with_features.csv
├── code/
│   ├── 1_data_preprocessing.R
│   ├── 2_exploratory_data_analysis.R
│   ├── 3_random_forest_grouped_with_features.R
│   ├── 4_xgboost_grouped.R
├── output/
│   ├── EDA plots (.png files)
│   ├── random_forest_grouped_with_features_model.rds
│   ├── xgboost_crime_model.model
├── README.md

```
---

## Project Workflow

### 1. Data Preprocessing
- Loaded original IIT crime dataset.
- Selected relevant fields: Date, Primary Type, Arrest, Domestic, Location, Latitude, Longitude.
- Created additional features:
  - **TimeOfDay** (Day/Night)
  - **Season** (Spring, Summer, Fall, Winter)
  - **Quadrant** (based on Latitude and Longitude)
  - **Weekend** (Weekend/Weekday)
  - **TimePeriod** (Late Night, Morning, Afternoon, Evening)

- Grouped crime types into three broad categories:
  - **Property Crime** (e.g., THEFT, BURGLARY)
  - **Violent Crime** (e.g., ASSAULT, BATTERY)
  - **Other Crime** (e.g., Fraud, Narcotics)

- Final cleaned dataset: `cleaned_crime_data_grouped_with_features.csv`.

### 2. Exploratory Data Analysis (EDA)
- Analyzed distribution of crime types.
- Analyzed trends across:
  - Time of Day
  - Seasons
  - Weekend vs Weekday
  - Crime Quadrants

- Generated plots saved in the `output/` folder.

### 3. Machine Learning Modeling

- **Model Used: Random Forest Classifier**
- **New engineered features (Weekend, TimePeriod) were included** for better prediction.

#### Model Performance:
| Metric | Value |
|:---|:---|
| Training Accuracy | 86.49% |
| Testing Accuracy | **59.58%** |

- The final Random Forest model achieved **59.58% testing accuracy**, showing good generalization on unseen data.

- **XGBoost** was also tried as an additional model:
  - Training Accuracy: 74.01%
  - Testing Accuracy: 58.1%
  - **Random Forest performed slightly better**, hence selected as the final model.

---

## Final Model Summary

| Model | Training Accuracy | Testing Accuracy | Decision |
|:---|:---|:---|:---|
| Random Forest (with new features) | 86.49% | **59.58%** | Final model |
| XGBoost (grouped) | 74.01% | 58.1% | Experimented |

*Random Forest** was finalized for deployment because of slightly better testing performance.

---

## How to Run

1. Set your working directory to the project folder. (It is necessary to set the main folder(dpa-crime-analysis) as the working directory via session tab in R.)
2. Run `1_data_preprocessing.R` to generate cleaned data.
3. Run `2_exploratory_data_analysis.R` to generate plots.
4. Run `3_random_forest_grouped_with_features.R` to train and evaluate the final Random Forest model.
5. (Optional) Run `4_xgboost_grouped.R` to see XGBoost experimental results.
6. Outputs (plots, models) will be saved inside the `output/` folder.

---

## Future Improvements
- Further feature engineering (e.g., create holiday labels, distance from IIT center).
- Advanced hyperparameter tuning using grid search.
- Apply balancing techniques (e.g., SMOTE) to handle class imbalance.
- Expand the dataset to citywide crime data for broader modeling.

---

## Authors
- **Nidhi Shrivastav**
- **Lavisha Chhatwani**
- **Gladys Gince Skariah**

Spring 2025 | Data Preparation and Analysis (CSP 571) | Illinois Institute of Technology

---

## References and Resources
- [Crime Analysis Using R (ResearchGate)](https://www.researchgate.net/publication/337414019_Crime_Analysis_Using_R)
- [Nowcasting Chicago Crime with R (Dataversity)](https://www.dataversity.net/nowcasting-chicago-crime-with-r/)
- [rcrimeanalysis R Package Documentation (CRAN)](https://cran.r-project.org/web/packages/rcrimeanalysis/rcrimeanalysis.pdf)
- [Chicago Crime Analysis using R Programming (Academia.edu)](https://www.academia.edu/44802248/Chicago_Crime_Analysis_using_R_Programming)
- [Homicide and Violent Crime in Chicago (Dataversity)](https://www.dataversity.net/homicide-violent-crime-chicago-first-look-data-r/)
- [Crime Data Analysis in Chicago (RPubs - Charlie Rosemond)](https://rpubs.com/charlie_rosemond/data607final)
- [Crime Analysis in Chicago City (ResearchGate)](https://www.researchgate.net/publication/335361962_Crime_Analysis_in_Chicago_City)
- [Chicago Crime Dataset - City of Chicago Open Data](https://data.cityofchicago.org/Public-Safety/Chicago-Police-Department-Illinois-Uniform-Crime-R/c7ck-438e/about_data)
- [Chicago Crime Analysis (RPubs - racha)](https://rpubs.com/racha/chicagocrimes)
- [Chicago Crime Data Analysis (Kaggle - kritisriv)](https://www.kaggle.com/code/kritisriv/chicago-crime-data-analysis)
- [An Introduction to Statistical Learning with Applications in R (ISLR, 2nd Edition)](https://www.statlearning.com/)

