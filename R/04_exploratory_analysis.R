# 04_exploratory_analysis.R
# Exploratory Data Analysis

library(ggplot2)

cat("\nRunning Exploratory Data Analysis...\n")


# Create output folders if needed
dir.create("outputs", showWarnings = FALSE)
dir.create("outputs/figures", showWarnings = FALSE)
dir.create("outputs/tables", showWarnings = FALSE)


# Correlation Matrix
cor_matrix <- cor(
  telemetry_numeric_imputed,
  use = "complete.obs"
)

png(
  "outputs/figures/correlation_matrix.png",
  width = 1400,
  height = 1200,
  res = 150
)

corrplot::corrplot(
  cor_matrix,
  method = "color",
  type = "upper",
  tl.cex = 0.7,
  number.cex = 0.6
)

dev.off()


# Cluster Summary Statistics
cluster_summary <- telemetry_clean %>%
  group_by(ClusterID) %>%
  summarise(
    across(
    where(is.numeric),
    \(x) mean(x, na.rm = TRUE)
    )
  )

write.csv(
  cluster_summary,
  "outputs/tables/cluster_summary.csv",
  row.names = FALSE
)


# Temperature by Cluster
p1 <- ggplot(
  telemetry_clean,
  aes(
    x = ClusterID,
    y = Temperature_Celsius
  )
) +
  geom_boxplot() +
  labs(
    title = "Temperature Distribution by Cluster",
    x = "Cluster",
    y = "Temperature (°C)"
  )

ggsave(
  "outputs/figures/temperature_by_cluster.png",
  p1,
  width = 8,
  height = 5
)


# Latency by Cluster
p2 <- ggplot(
  telemetry_clean,
  aes(
    x = ClusterID,
    y = Latency_ms
  )
) +
  geom_boxplot() +
  labs(
    title = "Latency Distribution by Cluster",
    x = "Cluster",
    y = "Latency (ms)"
  )

ggsave(
  "outputs/figures/latency_by_cluster.png",
  p2,
  width = 8,
  height = 5
)


# Disk Errors by Cluster
p3 <- ggplot(
  telemetry_clean,
  aes(
    x = ClusterID,
    y = Disk_Errors_Corrected
  )
) +
  geom_boxplot() +
  labs(
    title = "Disk Errors by Cluster",
    x = "Cluster",
    y = "Corrected Disk Errors"
  )

ggsave(
  "outputs/figures/disk_errors_by_cluster.png",
  p3,
  width = 8,
  height = 5
)


# Time Series Overview
daily_metrics <- telemetry_clean %>%
  group_by(as.Date(Timestamp)) %>%
  summarise(
    Avg_Latency = mean(Latency_ms, na.rm = TRUE),
    Avg_Temperature = mean(Temperature_Celsius, na.rm = TRUE),
    Avg_DiskErrors = mean(Disk_Errors_Corrected, na.rm = TRUE)
  )

p4 <- ggplot(
  daily_metrics,
  aes(x = `as.Date(Timestamp)`)
) +
  geom_line(aes(y = Avg_DiskErrors)) +
  labs(
    title = "Average Disk Errors Over Time",
    x = "Date",
    y = "Average Disk Errors"
  )

ggsave(
  "outputs/figures/disk_errors_over_time.png",
  p4,
  width = 10,
  height = 5
)

cat("\nEDA completed successfully.\n")
cat("Figures saved in outputs/figures/\n")
cat("Tables saved in outputs/tables/\n")