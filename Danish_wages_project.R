# Clear environment
rm(list = ls()) 

# Load Libraries
library(danstat)
library(tidyverse)
library(knitr)

# --- DATA PULL --------------------------------------------------------
# Table LONS40: Earnings per hour worked by industry (DB07), 2013-2024
# Source: Danmarks Statistik via danstat API

# get_table_metadata("LONS40", variables_only = TRUE) # Used during initial setup to inspect API codes


# Import selected data values through the API
wage_data <- get_data(
  table_id = "LONS40",
  variables = list(
    list(code = "BRANCHE07", values = NA),
    list(code = "SEKTOR", values = "1000"),
    list(code = "AFLOEN", values = "TIFA"),
    list(code = "LONGRP", values = "LTOT"),
    list(code = "LØNMÅL", values = "FORINKL"),
    list(code = "KØN", values = "MOK"),
    list(code = "Tid", values = NA)
  )
)


# view(wage_data) # intermediary debug check

# filter data and rename columns
wage_clean <- wage_data %>% 
  subset(select = c(BRANCHE07, TID, INDHOLD)) %>% 
  rename(
    hourly_wage = INDHOLD,
    industry = BRANCHE07,
    year = TID
    ) 

# view(wage_clean) # intermediary debug check

# --- DATA PULL --------------------------------------------------------
# Table RAS300: Employed (end November) by industry (DB07), 2008-2024
# Source: Danmarks Statistik via danstat API

# get_table_metadata("RAS300", variables_only = TRUE) # Used during initial setup to inspect API codes

# Import selected data values through the API
employed_data <- get_data(
  table_id = "RAS300",
  variables = list(
    list(code = "BRANCHE07", values = NA),
    list(code = "Tid", values = NA)
  )
)

# view(employed_data) # intermediary debug check

# filter data and rename columns
employed_clean = employed_data %>%
  filter(TID >= 2013) %>% 
  rename(
     num_employees = INDHOLD,
     industry = BRANCHE07,
     year = TID
     ) 

# view(employed_clean) # intermediary debug check


# 1. Merge datasets by industry and year and calculate total wage expenses (based on 1,600 yearly hours)
payroll <- inner_join(wage_clean, employed_clean, by = c("industry", "year")) %>%
  mutate(
    hourly_wage = as.numeric(hourly_wage) / 100, # scale by 100 to get true DKK/hr
    num_employees = as.numeric(num_employees),
    total_payroll_dkk = hourly_wage * num_employees * 1600
  )

# 2. Look at percentage change per industry
payroll_summary <- payroll %>%
  arrange(industry, year) %>%
  group_by(industry) %>%
  mutate(
    log_payroll = log(total_payroll_dkk),
    pct_growth = (total_payroll_dkk - lag(total_payroll_dkk)) / lag(total_payroll_dkk) * 100
  )

# view(payroll_summary) # intermediary debug check

# 1. total money drain: top 5 biggest payroll sectors in the most recent year
top_spenders <- payroll_summary %>%
  filter(!industry %in% c("TOT Industry, total", "TOT", "10000", "000000", "I alt")) %>%
  filter(year == max(year)) %>%
  arrange(desc(total_payroll_dkk)) %>%
  head(5)

# 2. velocity: top 5 fastest-growing sectors on average across all years
fastest_growing <- payroll_summary %>%
  filter(!industry %in% c("TOT Industry, total", "TOT", "10000", "000000", "I alt")) %>%
  filter(!is.na(pct_growth)) %>%
  group_by(industry) %>%
  summarise(avg_annual_growth = mean(pct_growth)) %>%
  arrange(desc(avg_annual_growth)) %>%
  head(5)


kable(top_spenders, caption = "Top 5 Sectors by Total Payroll Spend (DKK)")
kable(fastest_growing, caption = "Top 5 Sectors by Average Annual Growth Rate (%)")


# Plot total payroll trends over time for top industries (excluding totals)
payroll_summary %>% 
  filter(!industry %in% c("TOT Industry, total", "TOT", "10000", "000000", "I alt")) %>% 
  ggplot(aes(x = as.numeric(year), y = total_payroll_dkk / 1e9, color = industry)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  scale_y_continuous(labels = scales::label_dollar(prefix = "DKK ", suffix = "B")) +
  labs(
    title = "Annual Payroll Expenditure by Industry (Denmark)",
    subtitle = "Excludes total line to highlight sectoral growth dynamics",
    x = "Year",
    y = "Total Payroll (Billions DKK)",
    color = "Industry Code"
  ) +
  theme_minimal()

