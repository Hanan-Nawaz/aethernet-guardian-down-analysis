library(dplyr)

# 03_clean_data.R
# Clean and Prepare Data for PCA
cat("\nCleaning dataset...\n")


# Start from raw data
telemetry_clean <- telemetry_raw


# Remove irrelevant / non-PCA columns
pca_excluded_columns <- c(
  "Timestamp",
  "ServerID",
  "ClusterID",
  "Sensor_ID_Check",
  "Log_Entry_Details"
)

telemetry_metadata <- telemetry_clean %>%
  select(any_of(c("Timestamp", "ServerID", "ClusterID")))

telemetry_numeric <- telemetry_clean %>%
  select(where(is.numeric)) %>%
  select(-any_of(c("Sensor_ID_Check")))


# Handle missing values
# Median imputation for numeric variables
telemetry_numeric_imputed <- telemetry_numeric %>%
  mutate(
    across(
      everything(),
      ~ ifelse(is.na(.x), median(.x, na.rm = TRUE), .x)
    )
  )


# Check remaining missing values
remaining_missing <- colSums(is.na(telemetry_numeric_imputed))

cat("\nRemaining missing values after imputation:\n")
print(remaining_missing)


# Standardize numeric variables for PCA
telemetry_scaled <- scale(telemetry_numeric_imputed)
telemetry_scaled <- as.data.frame(telemetry_scaled)


# Save cleaned dataset
telemetry_cleaned_full <- bind_cols(
  telemetry_metadata,
  telemetry_numeric_imputed
)

write.csv(
  telemetry_cleaned_full,
  "data/processed/telemetry_cleaned.csv",
  row.names = FALSE
)

write.csv(
  telemetry_scaled,
  "data/processed/telemetry_scaled_for_pca.csv",
  row.names = FALSE
)

cat("\nCleaned data saved to data/processed/\n")
cat("Data cleaning completed successfully.\n")