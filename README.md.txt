# Danish Payroll Expenditure & Sectoral Growth Analysis

An automated R Markdown pipeline analyzing annual payroll expenditure and sectoral growth dynamics across Danish industries using live data pulled from **Danmarks Statistik** via API.

## Data Sources
* **Table LONS40:** Earnings per hour worked by industry (DB07)
* **Table RAS300:** Employed (end November) by industry (DB07)

## Requirements
To run the analysis locally, install the required R packages:
```R
install.packages(c("danstat", "tidyverse", "knitr", "rmarkdown"))