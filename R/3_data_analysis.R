library(tidyverse)

# Create a table which shows each economy's position relative to the UK at the start: 2000, before COVID: 2019 and at the end: 2022 to see whether the gap closed
relative_income_key_years = compare_data |> 
  filter(year %in% c(2000, 2019, 2022)) |> 
  select(countrycode, country, group, year, relative_income) |> 
  pivot_wider(names_from = year,
              values_from = relative_income,
              names_prefix = "relative_income_") |> 
  mutate(change_2000_2022 = relative_income_2022 - relative_income_2000) |>
  mutate(change_2019_2022 = relative_income_2022 - relative_income_2019) |> 
  arrange(group, desc(change_2000_2022))
relative_income_key_years_by_group = relative_income_key_years |> 
  group_by(group) |> 
  summarise(avg_change_2000_2022 = mean(change_2000_2022), 
            avg_change_2019_2022 = mean(change_2019_2022))

# Look up one value from the relative income table to insert in the qmd file
relative_income_value = function(code, column) 
  {relative_income_key_years |>
    filter(countrycode == code) |>
    pull({{ column }}) |>
    round(2)}

relative_income_key_years_by_group_value = function(group_name, column) 
{relative_income_key_years_by_group |>
    filter(group == group_name) |>
    pull({{ column }}) |>
    round(2)}

# Create a table and bar chart which shows each group's annual growth rate to see whether each group grew faster than the UK in each period
# Remove NA data in 2000 because the growth rates start from 2001
# Calculate average growth rate economy then average growth rate group per period
growth_by_period = analysis_data |> 
  filter(!is.na(annual_growth_rate)) |> 
  group_by(country, group, period) |> 
  summarise(avg_growth = mean(annual_growth_rate), .groups = "drop")
group_growth_by_period = growth_by_period |>
  group_by(group, period) |> 
  summarise(avg_growth = mean(avg_growth), .groups = "drop")

# Look up one value from the group growth by period table to insert in the qmd file
growth_value = function(group_name, period_label) 
{group_growth_by_period |>
    filter(group == group_name, period == period_label) |>
    pull(avg_growth) |>
    round(2)}

# Create a table of Viet Nam's relative income and absolute gap over time to answer sub-question (b)
vietnam_gap = compare_data |>
  filter(countrycode == "VNM") |>
  select(year, relative_income, absolute_gap)

# Reshape both measures into one column so they can be shown as two panels in one chart
vietnam_gap_long = vietnam_gap |>
  pivot_longer(cols = c(relative_income, absolute_gap),
               names_to = "measure",
               values_to = "value") |>
  mutate(measure = case_when(
    measure == "relative_income" ~ "Relative income (UK = 1)",
    measure == "absolute_gap" ~ "Absolute gap (2011 int. $ per person)"))

# Look up one value from the Viet Nam table to insert in the qmd file
vietnam_gap_value = function(yr, column)
{vietnam_gap |>
    filter(year == yr) |>
    pull({{ column }})}

# Robustness check: recalculate group growth without the two economies to see whether the group comparison changes
group_growth_robust = growth_by_period |>
  filter(!country %in% c("Myanmar", "D.P.R. of Korea")) |>
  group_by(group, period) |>
  summarise(avg_growth_robust = mean(avg_growth), .groups = "drop")
# Join and compare group growth robustness table with original group growth one
robustness_comparison = group_growth_by_period |>
  left_join(group_growth_robust, by = c("group", "period"))