#Import Necessary Library
library(lubridate)
library(ggplot2)
library(tidyverse)
library(dplyr)
library(astsa)
library(forecast)
library(readxl)
library(urca)
library(ggfortify)
library(tsutils)
library(writexl)


#Converting To Time Series
bwn_ts <- ts(data = bwn[,2], frequency = 12, start = c(1992,1))
#Selecting Data 
bwn_ts <- window(bwn_ts, start=c(1992,1))

bwn_ts

#Plot Time Series Data
autoplot(bwn_ts) + ylab("Precipitation (mm)") + xlab("Datetime") + 
  scale_x_date(date_labels = '%b - %Y', breaks = '4 year', minor_breaks = '2 month') +
  theme_bw() + ggtitle("Bahawalnagar Precipitation 1992 - 2021")

#Decomposition using stl()
decomp <- stl(bwn_ts[,1], s.window = 'periodic')
#Plot decomposition
autoplot(decomp) + theme_bw() + scale_x_date(date_labels = '%b - %Y', breaks = '4 year', minor_breaks = '2 month') +
  ggtitle("Remainder")

Tt <- trendcycle(decomp)
St <- seasonal(decomp)
Rt <- remainder(decomp)
#Trend Strength Calculation
Ft <- round(max(0,1 - (var(Rt)/var(Tt + Rt))),1)
#Seasonal Strength Calculation
Fs <- round(max(0,1 - (var(Rt)/var(St + Rt))),1)

data.frame('Trend Strength' = Ft , 'Seasonal Strength' = Fs)

#Seasonal Plot
seasonplot(bwn_ts, year.labels = TRUE, col = 1:13, 
           main =  "Bahawalnagar Seasonal Plot", ylab= "Precipitation (mm)")

#Seasonal Sub-Series Plot
seasplot(bwn_ts, outplot = 3, trend = FALSE, 
         main = "Seasonal Subseries Plot", ylab= "Precipitation (mm)")
#Seasonal Boxplot
seasplot(bwn_ts, outplot = 2, trend = FALSE, 
         main = "Seasonal Box Plot", ylab= "Precipitation (mm)")

#Create Train Set
bwn_train <- window(bwn_ts, end = c(2018,12))
#Create Test Set 
bwn_test <- window(bwn_ts, start = c(2019,1))

#Kwiatkowski–Phillips–Schmidt–Shin Test
summary(ur.kpss(bwn_train)) 
#Dickey-Fuller Test
summary(ur.df(bwn_train)) 

#ETS Model
fit_ets <- ets(bwn_train, damped =TRUE)

checkresiduals(fit_ets)

#ETS Model Accuracy
accuracy(forecast(fit_ets, h=240), bwn_test)

ETS_Model <- ets(bwn_ts, damped = TRUE, model = "AAA")

#ETS Model Forecast
autoplot(forecast(ETS_Model, h=240)) + theme_bw() + 
  ylab("Prec") + xlab("Datetime") + 
  scale_x_date(date_labels = '%b - %Y', breaks = '4 year', 
               minor_breaks = '2 month') +
  theme_bw() + ggtitle("Bahawalnagar Precipitation ETS Forecast 2022-2041")

#ETS Model Forecast
forecast_dataa <- forecast(ETS_Model, h = 240)

# Convert forecast data to data frame
forecast_dff <- as.data.frame(forecast_dataa)

# Save forecast data to Excel
write_xlsx(list(forecast_dff = forecast_dff), "forecast_dataa.xlsx")