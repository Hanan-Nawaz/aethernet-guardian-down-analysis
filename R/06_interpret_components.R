# Component Interpretation

library(dplyr)
library(ggplot2)

cat("\nInterpreting principal components...\n")

# Extract loadings
loadings_df <- as.data.frame(pca_result$rotation)

# Top variables for PC1
pc1_loadings <- loadings_df %>%
  mutate(
    Variable = rownames(loadings_df),
    Absolute_Loading = abs(PC1)
  ) %>%
  arrange(desc(Absolute_Loading))

top_pc1 <- head(pc1_loadings, 10)

write.csv(
  top_pc1,
  "outputs/tables/top_pc1_variables.csv",
  row.names = FALSE
)

# Top variables for PC2
pc2_loadings <- loadings_df %>%
  mutate(
    Variable = rownames(loadings_df),
    Absolute_Loading = abs(PC2)
  ) %>%
  arrange(desc(Absolute_Loading))

top_pc2 <- head(pc2_loadings, 10)

write.csv(
  top_pc2,
  "outputs/tables/top_pc2_variables.csv",
  row.names = FALSE
)

# Top variables for PC3
pc3_loadings <- loadings_df %>%
  mutate(
    Variable = rownames(loadings_df),
    Absolute_Loading = abs(PC3)
  ) %>%
  arrange(desc(Absolute_Loading))

top_pc3 <- head(pc3_loadings, 10)

write.csv(
  top_pc3,
  "outputs/tables/top_pc3_variables.csv",
  row.names = FALSE
)

# PC1 Loading Plot
pc1_plot <- ggplot(
  top_pc1,
  aes(
    x = reorder(Variable, Absolute_Loading),
    y = Absolute_Loading
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top Variables Contributing to PC1",
    x = "",
    y = "Absolute Loading"
  )

ggsave(
  "outputs/figures/top_pc1_loadings.png",
  pc1_plot,
  width = 8,
  height = 5
)

# PC2 Loading Plot
pc2_plot <- ggplot(
  top_pc2,
  aes(
    x = reorder(Variable, Absolute_Loading),
    y = Absolute_Loading
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top Variables Contributing to PC2",
    x = "",
    y = "Absolute Loading"
  )

ggsave(
  "outputs/figures/top_pc2_loadings.png",
  pc2_plot,
  width = 8,
  height = 5
)

# PC3 Loading Plot
pc3_plot <- ggplot(
  top_pc3,
  aes(
    x = reorder(Variable, Absolute_Loading),
    y = Absolute_Loading
  )
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top Variables Contributing to PC3",
    x = "",
    y = "Absolute Loading"
  )

ggsave(
  "outputs/figures/top_pc3_loadings.png",
  pc3_plot,
  width = 8,
  height = 5
)

# Interpretation Table
component_summary <- data.frame(
  Component = c("PC1", "PC2", "PC3"),
  Interpretation = c(
    "Likely hardware/storage stress",
    "Likely network congestion/performance stress",
    "Likely operational instability"
  )
)

write.csv(
  component_summary,
  "outputs/tables/component_interpretation.csv",
  row.names = FALSE
)

cat("\nComponent interpretation completed.\n")