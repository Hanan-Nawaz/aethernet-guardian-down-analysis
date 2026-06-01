# 01_load_libraries.R
# Load Required Packages

required_packages <- c(
  "tidyr",
  "stringr",
  "psych",
  "readr",
  "ggplot2",
  "lubridate",
  "dplyr",
  "missForest",
  "factoextra",
  "stats",
  "mice",
  "VIM",
  "zoo"
)

# Install Missing Packages

installed <- rownames(installed.packages())

for(pkg in required_packages){
  
  if(!(pkg %in% installed)){
    install.packages(pkg, dependencies = TRUE)
  }
  
  library(pkg, character.only = TRUE)
}

# Global Theme

theme_set(
  theme_minimal(base_size = 12)
)

options(
  scipen = 999,
  dplyr.summarise.inform = FALSE
)

cat("Libraries loaded successfully\n")