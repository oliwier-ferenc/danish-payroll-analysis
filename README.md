# Danish Payroll Expenditure & Sectoral Growth Analysis

An automated R Markdown pipeline analyzing annual payroll expenditure 
and growth dynamics across Danish industries, using live administrative 
data pulled directly from Danmarks Statistik via API.

## What This Project Does

Integrates industry-level hourly earnings (LONS40) with total employment 
statistics (RAS300) to model aggregate annual payroll spend across the 
Danish economy from 2013 to 2024. The analysis surfaces two 
counterintuitive findings about where Danish labor value is actually 
concentrating.

## Key Findings & Sector Positioning

This analysis tests conventional economic intuitions against Danmarks Statistik data (2013-2024), revealing four core insights:

- **Advanced Manufacturing Outpaces Digital Expectations:** Manufacturing has emerged as Denmark's fastest-growing payroll sector (7.82% annual growth in 2024, expanding from 150B to 247B DKK since 2013). It is the only sector combining high wages (417 DKK/hr), momentum, and large-scale employment (369,716 employees).

- **Tech Hiring is a Quality Game:** 
While Information & Communication offers high compensation (457 DKK/hr), payroll growth slowed to 3.38% in 2024 as post-pandemic hiring stabilized, indicating selective, high-value talent retention over headcount expansion.

- **Financial Services Sets the Premium Wage Benchmark:** 
Commanding the highest hourly rate (539 DKK/hr) alongside 6.93% payroll growth, Financial & Insurance concentrates premium compensation within a compact, highly specialized workforce (90,420 employees).

- **Scale vs. Momentum in the Public Sector:** 
Public Sector represents the largest total payroll spend (558B DKK in 2024), yet exhibits a flatter long-term growth trajectory (143 index score vs. Manufacturing's 165, relative to 2013 baselines).

## Data Sources

- **LONS40**: Earnings per hour worked by industry (DB07) — Danmarks 
  Statistik
- **RAS300**: Employed persons by industry (DB07), end November — 
  Danmarks Statistik

Data is pulled live via the danstat API each time the document is knit. 
Results automatically reflect the latest available statistics.

## How to Run

```r
install.packages(c("danstat", "tidyverse", "knitr", "rmarkdown"))
```

Open `Danish_wages_project.Rmd` in RStudio and click Knit. The pipeline 
pulls fresh data and renders the full analysis automatically.

## Presentation & Report

- [Interactive slide deck]((https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Fraw.githubusercontent.com%2Foliwier-ferenc%2Fdanish-payroll-analysis%2Fmain%2FDanish_Labour_Market_Analysis_2026.pptx))

- [Rendered HTML analysis](https://oliwier-ferenc.github.io/danish-payroll-analysis/)

- [Download raw pptx file](./Danish_Labour_Market_Analysis_2026.pptx)
