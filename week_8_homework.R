library(tidyverse)
library(lubridate) ## Doing the data import
library(ggplot2)

mloa <- read_csv("https://raw.githubusercontent.com/ucd-r-davis/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv"
                 ) ## reading the CSV file

## I got 459769 obs. of 16 vars.

mloa[mloa == -999.9] <- NA

mloa_clean <- mloa %>%
  filter(!is.na(rel_humid) & !is.na(temp_C_2m) & !is.na(windSpeed_m_s))
## Removed rows with missing values in key columns

## Ended up with 458729 obs. of 16 vars.

mloa_clean <- mloa_clean %>%
  mutate(datetime = make_datetime(year, month, day, hour24, min))
## Created a datetime column

mloa_clean <- mloa_clean %>%
  mutate(datetimeLocal = with_tz(datetime, tzone = "Pacific/Honolulu"))
## Converted datetime to Honolulu time

mean_temp <- mloa_clean %>%
  mutate(month = month(datetimeLocal), hour = hour(datetimeLocal)) %>%
  group_by(month, hour) %>%
  summarize(mean_temp_C_2m = mean(temp_C_2m, na.rm = TRUE)) %>%
  ungroup()
## Calculated mean temp by month and hour

## I guess now I have to plot it?

ggplot(mean_temp, aes(x = month, y = mean_temp_C_2m, color = factor(hour))) + 
  geom_point() +
  labs(x = "Month", y = "Mean Temperature (degC)", color = "Hour") +
  theme_minimal()
## Le data is plotted, I think it worked! cool





