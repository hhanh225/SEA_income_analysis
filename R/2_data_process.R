library(tidyverse)
# Define groups by country code, because Maddison's region column merges Southeast Asia with South Asia 
# Setup the values within chosen countries and years

sea_codes = c("IDN", "KHM", "LAO", "MMR", "MYS", "PHL", "SGP", "THA", "VNM")
east_asia_codes = c("CHN", "HKG", "JPN", "KOR", "PRK", "TWN")
benchmark_code = "GBR"
study_countries = c(sea_codes, east_asia_codes, benchmark_code) 
study_data = raw_maddison |> filter(countrycode %in% study_countries, 
                                    year >= 2000 & year <= 2022)

# Create analysis data, assign each country and year to defined groups and periods and remove the region column because it does not show exactly the defined group of countries in the project
analysis_data = study_data |>
  mutate(group = case_when(
    countrycode %in% sea_codes ~ "Southeast Asia",
    countrycode %in% east_asia_codes ~ "East Asia",
    countrycode == benchmark_code ~ "Benchmark")) |>
  mutate(group = factor(group, levels = c("Southeast Asia", "East Asia", "Benchmark"))) |> 
  mutate(period = case_when(
    year >= 2000 & year <= 2007 ~ "2000-2007 Pre-crisis",
    year >= 2008 & year <= 2019 ~ "2008-2019 GFC and recovery",
    year >= 2020 & year <= 2022 ~ "2020-2022 COVID")) |> 
  mutate(period = factor(period, levels = c("2000-2007 Pre-crisis", "2008-2019 GFC and recovery", "2020-2022 COVID"))) |> 
# Create new annual economic growth column to compare growth across groups and countries  
  group_by(countrycode) |>
  arrange(year, .by_group = TRUE) |>
  mutate(annual_growth_rate = (gdppc / lag(gdppc) - 1) * 100) |>
  ungroup() |>
  select(-region)

# Create a new separate table for the UK benchmark to compare each economy’s GDP per capita with the UK’s in the same year
uk_benchmark = analysis_data |> 
  filter(countrycode == benchmark_code) |> 
  rename(uk_gdppc = gdppc) |> 
  select(year, uk_gdppc)
# Left join 2 tables: analysis_data and uk_benchmark with key value: year to keep every row of the main data and calculate new column relative_income and absolute_gap
analysis_data = analysis_data |>   
  left_join(uk_benchmark, by = "year") |> 
  mutate(relative_income = gdppc / uk_gdppc,
         absolute_gap = uk_gdppc - gdppc)
# Remove the UK rows because the UK is the benchmark, not part of the comparison groups
compare_data = analysis_data |> 
  filter(countrycode != benchmark_code)



