# 02_load_data.R
# Load and Inspect Dataset

cat("\nLoading dataset...\n")

# Read CSV File
telemetry_raw <- readr::read_csv(
  "data/raw/server_telemetry_data.csv",
  show_col_types = FALSE
)

# Initial Inspection
cat("\nDataset Dimensions:\n")
print(dim(telemetry_raw))

cat("\nColumn Names:\n")
print(names(telemetry_raw))

cat("\nStructure:\n")
str(telemetry_raw)

cat("\nFirst 6 Rows:\n")
print(head(telemetry_raw))

# Convert Timestamp
telemetry_raw <- telemetry_raw %>%
  mutate(
    Timestamp = ymd_hms(Timestamp)
  )

# Missing Values Summary
missing_summary <- data.frame(
  Variable = names(telemetry_raw),
  Missing_Count = colSums(is.na(telemetry_raw)),
  Missing_Percent = round(
    colSums(is.na(telemetry_raw)) / nrow(telemetry_raw) * 100,
    2
  )
)

cat("\nMissing Values Summary:\n")
print(missing_summary)

# Save summary
write.csv(
  missing_summary,
  "outputs/tables/missing_values_summary.csv",
  row.names = FALSE
)

# Basic Descriptive Statistics
numeric_vars <- telemetry_raw %>%
  select(where(is.numeric))

desc_stats <- psych::describe(numeric_vars)

write.csv(
  desc_stats,
  "outputs/tables/descriptive_statistics.csv"
)

cat("\nDescriptive statistics saved.\n")

# Dataset Overview
cat("\nNumber of Servers:\n")
print(length(unique(telemetry_raw$ServerID)))

cat("\nClusters:\n")
print(unique(telemetry_raw$ClusterID))

cat("\nDate Range:\n")
print(range(telemetry_raw$Timestamp))

cat("\nDataset loaded successfully.\n")