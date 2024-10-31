library(tidyverse)

## Question 1

url <- "https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv"

lap <- read_csv(url)
lap ## 8985 obs. of 12 vars.

view(lap)

## QUESTION 2 (filtering out running)

sport <- select(lap, sport)
sport

run_data <- filter(sport, sport == "running")
rm(sport)
rm(run_data) ##removing the two datas cause it only shows those columns

run_sport <- filter(lap, sport == "running") ## 8483 obs. of 12 vars.

summary(run_sport)

## QUESTION 3 (filter out > 5 min & < 10)

rm(run_times) ## renaming data set
normal_run_times <- filter(run_sport, minutes_per_mile >= 5 & minutes_per_mile <= 10)
## gives 7411 obs. of 12 vars.

## QUESTION 4 (create categories for paces being old or new)

pace_form <- normal_run_times %>%
  mutate(
    pace = case_when(
    minutes_per_mile < 6.00 ~ "fast",
    minutes_per_mile > 6.00 & minutes_per_mile < 8.00 ~ "medium",
    minutes_per_mile > 8 ~ "slow"
    ), 
    form = if_else(year(timestamp) == 2024, "new", "old")
    )

view(pace_form) ## same obvs. but 14 variables (added two columns pace & form)

## QUESTION 5 (doing avg steps per minute by form and pace)

comparing_pace_form <- pace_form %>%
  group_by(form, pace) %>%
  summarize(avg_steps_minute = mean(steps_per_minute)) %>%
  pivot_wider(id_cols = form, values_from = avg_steps_minute, names_from = pace) %>%
  select("form", "slow", "medium", "fast") %>%
  form = if_else(year(timestamp) == 2024, "new", "old")

view(comparing_pace_form) ## showing 2 obs. with the 3 speed columns

## QUESTION 6 (separating the first and second half of the year with min, mean, med, max)

comparing_pace_form <- run_sport %>%
  group_by(form, pace) %>%
  summarize(avg_steps_per_minute = mean(steps_per_minute, na.rm = TRUE)) %>%
  pivot_wider(names_from = pace, values_from = avg_steps_per_minute) %>%
  select(form, slow, medium, fast)

run_sport <- run_sport %>%
  filter(form == "new") %>%
  mutate(period = if_else(month(timestamp) <= 6, "Jan-Jun", "Jul-Oct")) %>%
  group_by(period) %>%
  summarize(
    min_steps_per_minute = min(steps_per_minute, na.rm = TRUE),
    mean_steps_per_minute = mean(steps_per_minute, na.rm = TRUE),
    median_steps_per_minute = median(steps_per_minute, na.rm = TRUE),
    max_steps_per_minute = max(steps_per_minute, na.rm = TRUE)
  )

print(comparing_pace_form) ## I got this

# A tibble: 2 × 4
# Groups:   form [2]
##form   slow medium  fast
##<chr> <dbl>  <dbl> <dbl>
##1 new    162.   166.  171.
##2 old    147.   149.  162.

## I'm not really sure what I messed up but i'm getting an error
## not getting a form column for a certain data list of run_sport

