# Is Southeast Asia Catching Up? Income Convergence with the UK, 2000–2022

An exploratory data analysis in R comparing how quickly Southeast Asian and
East Asian economies closed their income gap with the UK, with a focus on Viet Nam.

** [Read the full report](https://<your-username>.github.io/SEA_income_analysis/report.html)**

## Key findings

- **Southeast Asia grew faster than East Asia** between 2000 and 2019, but East Asia
  gained more relative income, largely because its economies started from higher
  income levels.
- **COVID-19 slowed catch-up** in both regions, especially in Southeast Asia, but did
  not reverse the long-term trend.
- **Viet Nam rose from about 9% to 21% of UK income per person**, yet the absolute
  gap in PPP dollars per person still widened.
- The results held in a robustness check excluding economies with less reliable data
  (Myanmar and North Korea).

## Questions

1. From 2000 to 2022, did Southeast Asian economies close their income gap with the UK
   faster or slower than East Asian economies?
2. Did the COVID-19 shock interrupt catch-up, and was it larger in Southeast Asia or
   East Asia?
3. Is Viet Nam closing its gap with the UK in relative and absolute terms?

## Methods and tools

- **R** (tidyverse: dplyr, tidyr, ggplot2; readxl), **Quarto** for a fully
  reproducible report, **Git** for version control
- Structured using the **CRISP-DM** process: business understanding → data
  understanding → preparation → analysis → evaluation → communication
- Relative income (GDP per capita ÷ UK), absolute gap, average growth by period,
  and a robustness check

## Repository contents

| Path | Description |
|---|---|
| `report.qmd` | Quarto report: runs the whole analysis and contains the write-up |
| `report.html` | Rendered report |
| `R/1_data_import.R` | Imports the Maddison Project Database |
| `R/2_data_process.R` | Selects economies and years; creates groups, periods, growth, relative income and absolute gap |
| `R/3_data_analysis.R` | Creates summary tables and the robustness check |
| `data/mpd2023_web.xlsx` | Raw data (Maddison Project Database 2023) |

## How to run

1. Clone or download this repository (unzip it first if downloaded as a zip).
2. Open `SEA_income_analysis.Rproj` in RStudio.
3. Install the packages once: `install.packages(c("tidyverse", "readxl", "knitr"))`
4. Open `report.qmd` and click **Render**.

Developed with R 4.6.1. All file paths are relative and the data is included.

## Reference and Data source

Bolt, J. and van Zanden, J.L. (2024) 'Maddison style estimates of the evolution of the
world economy: A new 2023 update', *Journal of Economic Surveys*.
https://doi.org/10.1111/joes.12618

Maddison Project Database, version 2023, Groningen Growth and Development Centre,
University of Groningen:
https://www.rug.nl/ggdc/historicaldevelopment/maddison/releases/maddison-project-database-2023

The data is licensed under CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/).
The original country-level sources are listed in the source sheet of
`data/mpd2023_web.xlsx`.

## Author

Hong Hanh Nguyen