# Recommendations and Executive Summary Outputs

library(dplyr)

cat("\nGenerating recommendations...\n")

# Most influential variables for PC1
top_pc1_vars <- read.csv(
  "outputs/tables/top_pc1_variables.csv"
)

# Most influential variables for PC2
top_pc2_vars <- read.csv(
  "outputs/tables/top_pc2_variables.csv"
)

# Cluster summary
cluster_summary <- read.csv(
  "outputs/tables/cluster_pc_summary.csv"
)

# Highest risk clusters
highest_pc1_cluster <- cluster_summary %>%
  arrange(desc(Mean_PC1)) %>%
  slice(1)

highest_pc2_cluster <- cluster_summary %>%
  arrange(desc(Mean_PC2)) %>%
  slice(1)

highest_pc3_cluster <- cluster_summary %>%
  arrange(desc(Mean_PC3)) %>%
  slice(1)

# Executive summary table
executive_summary <- data.frame(
  Finding = c(
    "Primary PCA Factor",
    "Secondary PCA Factor",
    "Most Affected Cluster (PC1)",
    "Most Affected Cluster (PC2)",
    "Most Affected Cluster (PC3)"
  ),
  Result = c(
    paste(top_pc1_vars$Variable[1:3], collapse = ", "),
    paste(top_pc2_vars$Variable[1:3], collapse = ", "),
    highest_pc1_cluster$ClusterID,
    highest_pc2_cluster$ClusterID,
    highest_pc3_cluster$ClusterID
  )
)

write.csv(
  executive_summary,
  "outputs/tables/executive_summary.csv",
  row.names = FALSE
)

# Generate recommendations
recommendations <- data.frame(
  Priority = c(
    "High",
    "High",
    "Medium",
    "Medium",
    "Low"
  ),
  Recommendation = c(
    "Investigate storage subsystem health and disk performance.",
    "Review servers with elevated temperatures and cooling efficiency.",
    "Analyze network latency and packet loss trends.",
    "Inspect security alerts and abnormal connection activity.",
    "Continue monitoring PCA anomaly scores for early warning detection."
  )
)

write.csv(
  recommendations,
  "outputs/tables/recommendations.csv",
  row.names = FALSE
)

# Console output
cat("\n============================\n")
cat("AETHERNET EXECUTIVE SUMMARY\n")
cat("============================\n")

print(executive_summary)

cat("\nRecommended Actions:\n")
print(recommendations)

cat("\nAll outputs generated successfully.\n")
cat("Check outputs/tables and outputs/figures.\n")