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

## Key Findings

- **Manufacturing is Denmark's fastest-growing payroll sector** at 7.82% 
  annual growth — outpacing Information & Communication (3.38%), 
  Financial Services (6.93%), and Business Services (6.06%). This 
  reflects structural upgrading in advanced manufacturing rather than 
  decline.

- **The digital sector underperforms expectations**: Information & 
  Communication pays the second-highest hourly wage (457 DKK/hr) but 
  shows the slowest payroll growth among high-wage industries — 
  suggesting stable, highly-paid headcount rather than rapid expansion.

- **Financial & Insurance commands the highest hourly wages** (539 
  DKK/hr) while maintaining Denmark's smallest major industry workforce 
  (90,420 employees) — the clearest example of high-skill labor 
  concentration in the Danish economy.

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

## Live Report

[View the rendered analysis](https://oliwier-ferenc.github.io/danish-payroll-analysis/)