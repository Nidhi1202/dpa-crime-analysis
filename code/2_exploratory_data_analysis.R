# 2_exploratory_data_analysis.R
# ------------------------------
# Exploratory Data Analysis (EDA) Script
# Author: Nidhi Shrivastav, Lavisha Chhatwani, Gladys Gince Skariah
# Project: Crime Analysis
# Date: Spring 2025

library(tidyverse)

data_path <- "data/cleaned_crime_data.csv"
output_dir <- "output/eda_plots/"

if (!file.exists(data_path)) {
  stop("Cleaned data file not found. Please run preprocessing first.")
}

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

final <- read_csv(data_path, col_types = cols())

theme_set(theme_minimal())

# --------------------------
# 1. Crime Type Distribution
# --------------------------

p1 <- final %>%
  count(Primary.Type) %>%
  ggplot(aes(x = reorder(Primary.Type, -n), y = n, fill = Primary.Type)) +
  geom_col() +
  scale_fill_viridis_d(option = "plasma")+
  labs(title = "Crime Type Distribution", x = "Primary Type", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")

ggsave(filename = paste0(output_dir, "crime_type_distribution.png"), plot = p1, width = 8, height = 5)

# --------------------------
# 2. Time of Day Crime Trend
# --------------------------

p2 <- final %>%
  count(TimeOfDay) %>%
  ggplot(aes(x = TimeOfDay, y = n, fill = TimeOfDay)) +
  geom_col() +
  scale_fill_brewer(palette = "Pastel2") +
  labs(title = "Crime Count by Time of Day", x = "Time of Day", y = "Count") +
  theme(legend.position = "none")

ggsave(filename = paste0(output_dir, "crime_time_of_day.png"), plot = p2, width = 6, height = 4)

# --------------------------
# 3. Seasonality in Crime
# --------------------------

p3 <- final %>%
  count(Season) %>%
  ggplot(aes(x = Season, y = n, fill = Season)) +
  geom_col() +
  scale_fill_brewer(palette = "Set2") +
  labs(title = "Crime Count by Season", x = "Season", y = "Count") +
  theme(legend.position = "none")

ggsave(filename = paste0(output_dir, "crime_seasonality.png"), plot = p3, width = 6, height = 4)

# --------------------------
# 4. Arrests by Location (Top 10)
# --------------------------

p4 <- final %>%
  filter(Arrest == 1) %>%
  count(Location.Description) %>%
  top_n(10, n) %>%
  ggplot(aes(x = reorder(Location.Description, n), y = n, fill = Location.Description)) +
  geom_col() +
  coord_flip() +
  scale_fill_brewer(palette = "Paired") +
  labs(title = "Top 10 Locations with Arrests", x = "Location", y = "Arrest Count") +
  theme(legend.position = "none")

ggsave(filename = paste0(output_dir, "arrests_by_location.png"), plot = p4, width = 8, height = 6)

# --------------------------
# 5. Crimes by Hour of the Day
# --------------------------

p5 <- final %>%
  count(Hour) %>%
  ggplot(aes(x = Hour, y = n)) +
  geom_line(color = "steelblue", linewidth = 1) +
  geom_point(color = "darkorange", size = 2) +
  labs(title = "Crimes by Hour of the Day", x = "Hour", y = "Number of Crimes")

ggsave(filename = paste0(output_dir, "crimes_by_hour.png"), plot = p5, width = 7, height = 5)

# --------------------------
# 6. Crime Distribution by Quadrant
# --------------------------

p6 <- final %>%
  count(Quadrant) %>%
  mutate(Quadrant = as.factor(Quadrant)) %>%
  ggplot(aes(x = Quadrant, y = n, fill = Quadrant)) +
  geom_col() +
  scale_fill_brewer(palette = "Accent") +
  labs(title = "Crime Distribution by Quadrant", x = "Quadrant", y = "Crime Count") +
  theme(legend.position = "none")

ggsave(filename = paste0(output_dir, "crime_by_quadrant.png"), plot = p6, width = 6, height = 4)

cat("\n Exploratory Data Analysis Completed Successfully. Plots saved in:", output_dir, "\n")
