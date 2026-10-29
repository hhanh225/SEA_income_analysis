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
  summarise(mean(change_2000_2022), mean(change_2019_2022))

# Look up one value from the relative income table to insert in the qmd file
relative_income_value = function(code, column) 
  {relative_income_key_years |>
    filter(countrycode == code) |>
    pull({{ column }}) |>
    round(2)}

relative_income_key_years_by_group_value = function(code, column) 
{relative_income_key_years_by_group |>
    filter(group == code) |>
    pull({{ column }}) |>
    round(2)}

# Create line chart which shows each economy's relative income to the UK from 2000 to 2022 to see the trend and whether group closed the gap faster
compare_data |> 
  ggplot(aes(x = year, y = relative_income, color = country)) +
  geom_line() +
  labs(title = "Chart of relative income for each group over 2000–2022",
       x = "Year", y = "Relative income (UK = 1)") +
  geom_hline(yintercept = 1, linetype = "dashed") +
  facet_wrap(. ~ group)

# Create a table and bar chart which shows each group's annual growth rate to see whether whether each group grew faster than the UK in each period
# Remove NA data in 2000 because the growth rate start from 2001
# Calculate average growth rate economy then average growth rate group per period
growth_by_period = analysis_data |> 
  filter(!is.na(annual_growth_rate)) |> 
  group_by(country, group, period) |> 
  summarise(avg_growth = mean(annual_growth_rate), .groups = "drop")
group_growth_by_period = growth_by_period |>
  group_by(group, period) |> 
  summarise(avg_growth = mean(avg_growth), .groups = "drop")

# Look up one value from the group growth by period table to insert in the qmd file
group_growth_by_period_value = function(group_name, period_label) 
{group_growth_by_period |>
    filter(group == group_name, period == period_label) |>
    pull(avg_growth) |>
    round(2)}

ggplot(group_growth_by_period, aes(x = period, y = avg_growth, fill = group)) +
  geom_col(position = "dodge")