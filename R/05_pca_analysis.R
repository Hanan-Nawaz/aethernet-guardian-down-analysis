# PCA Analysis

library(dplyr)
library(ggplot2)
library(factoextra)

cat("\nRunning PCA analysis...\n")

# Run PCA
pca_result <- prcomp(
  telemetry_scaled,
  center = FALSE,
  scale. = FALSE
)

# Variance explained
pca_variance <- data.frame(
  Principal_Component = paste0("PC", seq_along(pca_result$sdev)),
  Eigenvalue = pca_result$sdev^2,
  Variance_Explained = (pca_result$sdev^2) / sum(pca_result$sdev^2),
  Cumulative_Variance = cumsum((pca_result$sdev^2) / sum(pca_result$sdev^2))
)

write.csv(
  pca_variance,
  "outputs/tables/pca_variance.csv",
  row.names = FALSE
)

print(pca_variance)

# Scree plot
scree_plot <- fviz_eig(
  pca_result,
  addlabels = TRUE
) +
  labs(
    title = "Scree Plot: Variance Explained by Principal Components",
    x = "Principal Component",
    y = "Percentage of Explained Variance"
  )

ggsave(
  "outputs/figures/scree_plot.png",
  scree_plot,
  width = 8,
  height = 5
)

# PCA loadings
pca_loadings <- as.data.frame(pca_result$rotation)
pca_loadings$Metric <- rownames(pca_loadings)

write.csv(
  pca_loadings,
  "outputs/tables/pca_loadings.csv",
  row.names = FALSE
)

# PCA scores
pca_scores <- as.data.frame(pca_result$x)

pca_scores <- bind_cols(
  telemetry_metadata,
  pca_scores
)

write.csv(
  pca_scores,
  "outputs/tables/pca_scores.csv",
  row.names = FALSE
)

# Variable plot PC1 and PC2
# This is faster than fviz_pca_biplot because it does not plot all observations
pca_variable_plot <- fviz_pca_var(
  pca_result,
  repel = TRUE
) +
  labs(
    title = "PCA Variable Plot: PC1 vs PC2"
  )

ggsave(
  "outputs/figures/pca_variable_plot_pc1_pc2.png",
  pca_variable_plot,
  width = 10,
  height = 7
)

# PC1 by cluster
pc1_cluster_plot <- ggplot(
  pca_scores,
  aes(
    x = ClusterID,
    y = PC1
  )
) +
  geom_boxplot() +
  labs(
    title = "PC1 Scores by Cluster",
    x = "Cluster",
    y = "PC1 Score"
  )

ggsave(
  "outputs/figures/pc1_scores_by_cluster.png",
  pc1_cluster_plot,
  width = 8,
  height = 5
)

# PC2 by cluster
pc2_cluster_plot <- ggplot(
  pca_scores,
  aes(
    x = ClusterID,
    y = PC2
  )
) +
  geom_boxplot() +
  labs(
    title = "PC2 Scores by Cluster",
    x = "Cluster",
    y = "PC2 Score"
  )

ggsave(
  "outputs/figures/pc2_scores_by_cluster.png",
  pc2_cluster_plot,
  width = 8,
  height = 5
)

cat("\nPCA analysis completed successfully.\n")