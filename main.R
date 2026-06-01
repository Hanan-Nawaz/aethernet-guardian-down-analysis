# AetherNet Cloud Solutions
# Operation Guardian Down
# Main Execution Script

cat("=====================================\n")
cat(" AetherNet - Operation Guardian Down\n")
cat(" PCA Diagnostic Analysis\n")
cat("=====================================\n\n")

# Load Libraries
source("R/01_load_libraries.R")

# Load Data
source("R/02_load_data.R")

# Clean & Prepare Data
source("R/03_clean_data.R")

# Exploratory Data Analysis
source("R/04_exploratory_analysis.R")

# Principal Component Analysis
source("R/05_pca_analysis.R")

# Component Interpretation
source("R/06_interpret_components.R")

# Temporal & Cluster Analysis
source("R/07_temporal_cluster_analysis.R")

# Recommendations & Summary Tables
source("R/08_recommendations.R")

cat("\n=====================================\n")
cat(" Analysis Completed Successfully\n")
cat(" Results saved to outputs/\n")
cat("=====================================\n")