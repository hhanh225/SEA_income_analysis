# Define groups by country code, because Maddison's region column merges Southeast Asia with South Asia 
# Setup the values within chosen countries and years
sea_codes = c("IDN", "KHM", "LAO", "MMR", "MYS", "PHL", "SGP", "THA", "VNM")
east_asia_codes = c("CHN", "HKG", "JPN", "KOR", "PRK", "TWN")
benchmark_code = "GBR"
study_countries = c(sea_codes, east_asia_codes, benchmark_code) 
study_data = raw_maddison |> filter(countrycode %in% study_countries, year >= 2000 & year <= 2022)

