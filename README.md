# Southeast Asian Income Convergence with the UK, 2000–2022

## Project description

This project analyses whether Southeast Asian economies closed their income gap with the UK faster or slower than East Asia between 2000 and 2022 using Maddison Project Database estimates. It includes one main question and two sub-questions: whether Southeast Asia converged faster than East Asia in relative income and growth terms, how the pandemic shock affected the pace of catch-up, and whether Viet Nam closed its income gap with the UK in relative and absolute terms.

The analysis follows one cycle of the CRISP-DM process and is written up as a reproducible Quarto report.

## Author

Hong Hanh Nguyen

## Repository contents

| Path | Description |
|---|---|
| `report.qmd` | Main Quarto report: runs the whole analysis and contains the write-up |
| `report.html` | Rendered report |
| `R/1_data_import.R` | Import the "Full data" sheet of the Maddison Project Database |
| `R/2_data_process.R` | Select economies and years, create groups, periods, growth rates and relative income |
| `R/3_data_analysis.R` | Create the summary tables and robustness check used in the report |
| `data/mpd2023_web.xlsx` | Raw data (Maddison Project Database 2023) |
| `SEA_income_analysis.Rproj` | RStudio project file |

## How to run

**Software**

- R (version 4.6.1)
- RStudio, which includes Quarto
- R packages: `tidyverse`, `readxl`, `knitr`

**Install the packages (once):**

```r
install.packages(c("tidyverse", "readxl", "knitr"))
```

**Steps**

1. Open `SEA_income_analysis.Rproj` in RStudio, so all file paths work.
2. Open `report.qmd`.
3. Click **Render** and **setup chunk**. The report runs all three scripts in `R/` automatically
   and produces `report.html`.

**Optional**: To explore the analysis step by step, run the
scripts in `R/` in numerical order (`1_data_import.R`, `2_data_process.R`,
`3_data_analysis.R`), because each script uses objects created by the previous one.
All file paths are relative, and the data is included, so no other setup is needed.

## Data source

Bolt, J. and van Zanden, J.L. (2024) Maddison Project Database, version 2023.
Groningen Growth and Development Centre, University of Groningen.
https://www.rug.nl/ggdc/historicaldevelopment/maddison/releases/maddison-project-database-2023

The data file is included in `data/` and was used as provided on the module's
Canvas page (no later updates).