install.packages("tidyverse")
library(tidyverse)

surveys <- read.csv("data/portal_data_joined.csv")
mloa <- read.csv("data/mauna_loa_met_2001_minute.csv")


## LISTING COLUMNS WE WANT TO ANALYSE
cols_of_interest <- c("windDir", "windSpeed_m_s", "baro_hPa", "temp_C_2m", "temp_C_10m", "temp_C_towertop", "rel_humid", "precip_intens_mm_hr")

## USING MAP TO FIND THE MAX OF EACH COLUMN
max_values <- map(mloa[cols_of_interest], max, na.rm = TRUE)

## RESULTS PRINT
print(max_values)

## CONVERTING TO degF
C_to_F <- function(celsius) {
  return(celsius * 1.8 + 32)
}

## ADDING NEW degF COLUMNS
mloa <- mloa %>%
  mutate(
    temp_F_2m = C_to_F(temp_C_2m),
    temp_F_10m = C_to_F(temp_C_10m),
    temp_F_towertop = C_to_F(temp_C_towertop)
  )

## BONUS > CREATING NEW COLUMNS WITH map_df
farenheit_cols <- map_df(mloa[c(
  "temp_C_2m", 
  "temp_C_10m", 
  "temp_C_towertop")], C_to_F)

## RENAMING COLUMNS
colnames(farenheit_cols) <- c(
  "temp_F_2m", 
  "temp_F_10m", 
  "temp_F_towertop")

## ADDING NEW COLUMNS
mloa <- bind_cols(mloa, farenheit_cols)

head(mloa)

filename siteID year month day hour24 min windDir
1 met_mlo_insitu_1_obop_minute_2001_01.txt    MLO 2001     1   1      0   0     340
2 met_mlo_insitu_1_obop_minute_2001_01.txt    MLO 2001     1   1      0   1     334
3 met_mlo_insitu_1_obop_minute_2001_01.txt    MLO 2001     1   1      0   2     314
4 met_mlo_insitu_1_obop_minute_2001_01.txt    MLO 2001     1   1      0   3     323
5 met_mlo_insitu_1_obop_minute_2001_01.txt    MLO 2001     1   1      0   4     349
6 met_mlo_insitu_1_obop_minute_2001_01.txt    MLO 2001     1   1      0   5     345
windSpeed_m_s windSteady baro_hPa temp_C_2m temp_C_10m temp_C_towertop rel_humid
1           3.4         -9   -999.9      12.7       11.2            10.2        53
2           2.8         -9   -999.9      12.5       11.2            10.5        54
3           3.3         -9   -999.9      12.5       11.2            10.5        54
4           2.4         -9   -999.9      11.6       10.6            10.3        57
5           0.4         -9   -999.9      11.2       10.8            10.4        57
6           1.8         -9   -999.9      12.0       11.1            10.6        54
precip_intens_mm_hr temp_F_2m...17 temp_F_10m...18 temp_F_towertop...19
1                   0          54.86           52.16                50.36
2                   0          54.50           52.16                50.90
3                   0          54.50           52.16                50.90
4                   0          52.88           51.08                50.54
5                   0          52.16           51.44                50.72
6                   0          53.60           51.98                51.08
temp_F_2m...20 temp_F_10m...21 temp_F_towertop...22
1          54.86           52.16                50.36
2          54.50           52.16                50.90
3          54.50           52.16                50.90
4          52.88           51.08                50.54
5          52.16           51.44                50.72
6          53.60           51.98                51.08

## CHALLENGE
## USING lapply

surveys %>% mutate (genusspecies = lapply(
  1:nrow(surveys), function(i){
    paste0(surveys$genus[i], "", surveys$species[i])
  }
))

## I think this is done, Thanks!



