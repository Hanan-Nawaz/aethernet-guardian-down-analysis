# AetherNet Guardian Down – PCA-Based Telemetry Analysis

## Overview

This project investigates performance degradation within the AetherNet server infrastructure using **Principal Component Analysis (PCA)** and exploratory data analysis techniques.

The objective is to identify the primary drivers of system instability, determine which server clusters are most affected, and establish a timeline for the observed degradation.

The analysis focuses on server telemetry metrics including:

* CPU utilization
* Memory usage
* Disk I/O activity
* Disk queue depth
* Temperature
* Power consumption
* Fan speed
* Network throughput
* Packet loss
* Latency
* Security alerts
* Kernel errors
* Application crashes
* Memory page faults

---

## Project Structure

```text
aethernet-guardian-down/
│
├── data/
│   ├── raw/
│   │   └── server_telemetry_data.csv
│   │
│   └── processed/
│       └── telemetry_clean.csv
│
├── outputs/
│   ├── figures/
│   └── tables/
│
├── R/
│   ├── 01_load_libraries.R
│   ├── 02_load_data.R
│   ├── 03_clean_data.R
│   ├── 04_exploratory_analysis.R
│   ├── 05_pca_analysis.R
│   ├── 06_interpret_components.R
│   ├── 07_temporal_cluster_analysis.R
│   └── 08_recommendations.R
│
├── report/
│   └── AetherNet_Guardian_Down_Report.docx
│
├── main.R
└── README.md
```

---

## Methodology

### 1. Data Preparation

The dataset is cleaned and standardized before analysis.

Processing steps include:

* Missing value handling
* Duplicate removal
* Variable standardization
* Metadata separation
* Export of cleaned dataset

---

### 2. Exploratory Data Analysis

EDA is performed to understand relationships between telemetry variables.

Outputs include:

* Correlation matrix
* Descriptive statistics
* Cluster comparisons
* Temporal trend analysis

---

### 3. Principal Component Analysis (PCA)

PCA is used to reduce dimensionality and identify latent operational factors.

Key outputs:

* Scree plot
* PCA loadings
* PCA scores
* Variable contribution plots

---

### 4. Component Interpretation

The major contributors to each principal component are extracted and interpreted.

Observed components:

* **PC1:** Storage and hardware stress
* **PC2:** Network performance degradation
* **PC3:** Operational instability

---

### 5. Temporal and Cluster Analysis

Principal component scores are analyzed across:

* Time
* Server clusters

This enables identification of:

* Incident onset
* Affected clusters
* Progression of degradation

---

## Main Findings

### PC1 – Storage and Hardware Stress

Dominant variables:

* Disk Errors Corrected
* Disk Queue Depth
* Disk I/O Write
* Temperature
* Disk I/O Read

Interpretation:

Storage subsystem degradation and thermal stress are major contributors to performance issues.

---

### PC2 – Network Performance Degradation

Dominant variables:

* Latency
* Memory Usage
* CPU Utilization
* Packet Loss
* Connections Established

Interpretation:

Network congestion and communication inefficiencies contribute significantly to system degradation.

---

### PC3 – Operational Instability

Dominant variables:

* Memory Page Faults
* Fan Speed
* Power Consumption
* Process Count
* Security Alerts

Interpretation:

This component reflects broader operational instability and abnormal system behaviour.

---

## Key Results

### Variance Explained

| Component | Variance Explained |
| --------- | ------------------ |
| PC1       | 9.57%              |
| PC2       | 7.45%              |
| PC3       | 5.40%              |

The first three components explain approximately **22.4%** of the total variance.

---

### Most Affected Cluster

**Cluster 3** exhibited the strongest deterioration patterns.

Evidence includes:

* Declining PC1 scores
* Increasing disk errors
* Elevated temperatures
* Sustained degradation after April 10

---

### Incident Timeline

| Period    | Observation                      |
| --------- | -------------------------------- |
| Apr 5–8   | Stable operation                 |
| Apr 9–10  | Initial storage stress           |
| Apr 10–11 | Disk degradation becomes visible |
| Apr 11–12 | Network performance deteriorates |
| Apr 12–15 | Sustained cluster degradation    |

---

## Generated Outputs

### Figures

The analysis generates:

* Correlation heatmap
* Scree plot
* PCA variable plot
* Temperature by cluster
* Latency by cluster
* Disk errors by cluster
* PC1 over time
* PC2 over time
* PC3 over time
* Variable contribution plots

Saved in:

```text
outputs/figures/
```

---

### Tables

Generated tables include:

* Descriptive statistics
* PCA variance explained
* PCA loadings
* PCA scores
* Cluster summaries
* Component interpretations
* Recommendations

Saved in:

```text
outputs/tables/
```

---

## Running the Project

### Step 1

Open the project in RStudio or VS Code with R installed.

### Step 2

Place the dataset in:

```text
data/raw/server_telemetry_data.csv
```

### Step 3

Run scripts sequentially:

```r
source("R/01_load_libraries.R")
source("R/02_load_data.R")
source("R/03_clean_data.R")
source("R/04_exploratory_analysis.R")
source("R/05_pca_analysis.R")
source("R/06_interpret_components.R")
source("R/07_temporal_cluster_analysis.R")
source("R/08_recommendations.R")
```

Alternatively:

```r
source("main.R")
```

---

## Recommendations

### High Priority

* Investigate storage infrastructure associated with Cluster 3.
* Review corrected disk error logs.
* Evaluate disk queue depth and I/O bottlenecks.
* Inspect cooling systems and thermal controls.

### Medium Priority

* Analyze latency and packet loss sources.
* Review network utilization patterns.
* Investigate memory pressure and page faults.

### Long-Term Improvements

* Deploy PCA-based anomaly detection.
* Implement automated alerting thresholds.
* Schedule preventative maintenance for high-risk clusters.

---

## Author

Multivariate Data Analysis Project

AetherNet Guardian Down Case Study

Principal Component Analysis of Server Telemetry Data
