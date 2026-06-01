# Temporal and Cluster Analysis

library(dplyr)
library(ggplot2)
library(lubridate)

cat("\nRunning temporal and cluster analysis...\n")

# Add date and hour columns
pca_scores <- pca_scores %>%
  mutate(
    Date = as.Date(Timestamp),
    Hour = hour(Timestamp)
  )

# Average PC scores by date and cluster
daily_pc_cluster <- pca_scores %>%
  group_by(Date, ClusterID) %>%
  summarise(
    Avg_PC1 = mean(PC1, na.rm = TRUE),
    Avg_PC2 = mean(PC2, na.rm = TRUE),
    Avg_PC3 = mean(PC3, na.rm = TRUE),
    .groups = "drop"
  )

write.csv(
  daily_pc_cluster,
  "outputs/tables/daily_pc_cluster_scores.csv",
  row.names = FALSE
)

# PC1 over time by cluster
pc1_time_plot <- ggplot(
  daily_pc_cluster,
  aes(
    x = Date,
    y = Avg_PC1,
    group = ClusterID
  )
) +
  geom_line() +
  geom_point() +
  facet_wrap(~ ClusterID, ncol = 1) +
  labs(
    title = "PC1 Over Time by Cluster",
    subtitle = "PC1 represents likely hardware/storage stress",
    x = "Date",
    y = "Average PC1 Score"
  )

ggsave(
  "outputs/figures/pc1_over_time_by_cluster.png",
  pc1_time_plot,
  width = 10,
  height = 8
)

# PC2 over time by cluster
pc2_time_plot <- ggplot(
  daily_pc_cluster,
  aes(
    x = Date,
    y = Avg_PC2,
    group = ClusterID
  )
) +
  geom_line() +
  geom_point() +
  facet_wrap(~ ClusterID, ncol = 1) +
  labs(
    title = "PC2 Over Time by Cluster",
    subtitle = "PC2 represents likely network stress",
    x = "Date",
    y = "Average PC2 Score"
  )

ggsave(
  "outputs/figures/pc2_over_time_by_cluster.png",
  pc2_time_plot,
  width = 10,
  height = 8
)

# PC3 over time by cluster
pc3_time_plot <- ggplot(
  daily_pc_cluster,
  aes(
    x = Date,
    y = Avg_PC3,
    group = ClusterID
  )
) +
  geom_line() +
  geom_point() +
  facet_wrap(~ ClusterID, ncol = 1) +
  labs(
    title = "PC3 Over Time by Cluster",
    subtitle = "PC3 represents likely operational instability",
    x = "Date",
    y = "Average PC3 Score"
  )

ggsave(
  "outputs/figures/pc3_over_time_by_cluster.png",
  pc3_time_plot,
  width = 10,
  height = 8
)

# Cluster-level PC summary
cluster_pc_summary <- pca_scores %>%
  group_by(ClusterID) %>%
  summarise(
    Mean_PC1 = mean(PC1, na.rm = TRUE),
    Mean_PC2 = mean(PC2, na.rm = TRUE),
    Mean_PC3 = mean(PC3, na.rm = TRUE),
    SD_PC1 = sd(PC1, na.rm = TRUE),
    SD_PC2 = sd(PC2, na.rm = TRUE),
    SD_PC3 = sd(PC3, na.rm = TRUE),
    .groups = "drop"
  )

write.csv(
  cluster_pc_summary,
  "outputs/tables/cluster_pc_summary.csv",
  row.names = FALSE
)

# Identify highest PC1, PC2, PC3 clusters
highest_pc1_cluster <- cluster_pc_summary %>%
  arrange(desc(Mean_PC1)) %>%
  slice(1)

highest_pc2_cluster <- cluster_pc_summary %>%
  arrange(desc(Mean_PC2)) %>%
  slice(1)

highest_pc3_cluster <- cluster_pc_summary %>%
  arrange(desc(Mean_PC3)) %>%
  slice(1)

write.csv(
  highest_pc1_cluster,
  "outputs/tables/highest_pc1_cluster.csv",
  row.names = FALSE
)

write.csv(
  highest_pc2_cluster,
  "outputs/tables/highest_pc2_cluster.csv",
  row.names = FALSE
)

write.csv(
  highest_pc3_cluster,
  "outputs/tables/highest_pc3_cluster.csv",
  row.names = FALSE
)

# Detect unusually high PC scores using 95th percentile thresholds
pc_thresholds <- data.frame(
  Component = c("PC1", "PC2", "PC3"),
  Threshold_95th_Percentile = c(
    quantile(pca_scores$PC1, 0.95, na.rm = TRUE),
    quantile(pca_scores$PC2, 0.95, na.rm = TRUE),
    quantile(pca_scores$PC3, 0.95, na.rm = TRUE)
  )
)

write.csv(
  pc_thresholds,
  "outputs/tables/pc_anomaly_thresholds.csv",
  row.names = FALSE
)

pc_anomalies <- pca_scores %>%
  mutate(
    PC1_Anomaly = PC1 > quantile(PC1, 0.95, na.rm = TRUE),
    PC2_Anomaly = PC2 > quantile(PC2, 0.95, na.rm = TRUE),
    PC3_Anomaly = PC3 > quantile(PC3, 0.95, na.rm = TRUE)
  ) %>%
  filter(
    PC1_Anomaly == TRUE |
      PC2_Anomaly == TRUE |
      PC3_Anomaly == TRUE
  )

write.csv(
  pc_anomalies,
  "outputs/tables/pca_anomalies.csv",
  row.names = FALSE
)

cat("\nTemporal and cluster analysis completed.\n")