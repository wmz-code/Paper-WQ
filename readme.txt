This repository includes main scripts for data processing, analysis, and result generation, following the workflow outlined below. 

Please note: This code was developed for research purposes and may not meet professional software development standards for elegance or efficiency.

### Workflow
1. Data Preprocessing
(See /code/Data preprocessing folder)

Phenology Data:
Extracted and summarized using /code/Data preprocessing/Phenology_data_process.m

Climate Data:
Extracted climate data for ISIMIP climate data during the entire growth period was provided (/code/Data preprocessing/Climate_data_exact.m). A similar procedure was applied to extract ERA5-Land data.

2. Analysis
(See /code/Analysis folder)

Bayesian Mixed Models:
Estimated national-scale wheat quality responses to climate (Bayesian_mixed_models.R). Zone-specific models and sensitivity analysis follow a similar structure.

REML-based national estimation provided (Model_REML.R).

Projection of Climate Impacts:
Example for projections of eight quality indicators (ProjectionOfIndicators.m).

3. Results
Raw and source data corresponding to results for each figure in the manuscript are included in the /data folder.

### Software Requirements
R 4.3.2
MATLAB R2022b

### R packages
brms
rstan
dplyr
lme4
boot
pheatmap
openxlsx
ggplot2
RColorBrewer





