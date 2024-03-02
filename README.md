# Rainfall Forecasting using ETS
Application of the Error, Trend, Seasonality (ETS) model to forecast rainfall patterns. Leveraging time-series analysis techniques, it predicts future rainfall levels by analyzing historical data specifically from Bahwalnagar District, Punjab, Pakistan. Additionally, this project aids in anticipating drought patterns across the region.

![Rainfall Forecasting ETS](/output-rainfall-forecast-ets.png)

# Model Type
The ETS (Error, Trend, Seasonality) model implemented in this repository offers a robust approach to forecasting rainfall patterns. ETS models are adept at capturing various components of time series data, including error, trend, and seasonality, making them suitable for modeling and predicting complex temporal phenomena such as rainfall fluctuations. An ETS model is specified by an error type (E; additive or multiplicative), a trend type (T; additive or multiplicative, both damped or undamped, or none), and a seasonality type (S; additive or multiplicative or none).

# Data
The repository contains time series data consisting of monthly rainfall data spanning from 1992 to 2021. This data was meticulously recorded by the Pakistan Meteorological Department and obtained for M.Phil Research purposes.

# Requirements
- RStudio version 2023.06.1 Build 524
- **R Libraries:** lubridate, ggplot2, readxl, tidyverse, dplyr, astsa, forecast, urca, ggfortify, tsutils, writexl

# Citation
If you use this repository or the data provided, please cite the following:
- Rehman, E. (2024). Rainfall Forecasting ETS. GitHub. https://github.com/ebadatibnbabar/Rainfall-Forecasting-ETS
- Pakistan Meteorological Department. (1992-2021). Rainfall Data. Retrieved from https://www.pmd.gov.pk/en/
