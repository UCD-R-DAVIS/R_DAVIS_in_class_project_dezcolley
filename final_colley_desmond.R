## LOADING THE LIBRARY & CSV FILE
library(ggplot2)
df <- read.csv("data/tyler_activity_laps_12-6.csv") ## 9039 obs. of 12 variables

## 1. FILTER OUT NON-RUNNING
df_running <- df %>% filter(sport == "running") ## 8533 obs. of 12 variables

## 2. FILTER OUT LAPS BASED ON PACE & TIME
## with pace > 10 min/mile or < 5 min/mile, 
## & removing laps where elapsed time is <= 60 seconds
df_running <- df_running %>%
  filter(minutes_per_mile >= 5, minutes_per_mile <= 10, total_elapsed_time_s > 60)
## 6983 obs. of 12 variables

## 3. GROUP DATA INTO 3 TIME PERIODS
## Creating a new 'period' column based on yr & mo
df_running <- df_running %>%
  mutate(period = case_when(
    year < 2024 ~ "Pre-2024",
    year == 2024 & month <= 6 ~ "Initial Rehab",
    TRUE ~ "Post-Intervention"
  )) ## I hope that worked

## 4. SCATTER PLOT of SPM v. Speed
## Calculating into miles per hour
df_running <- df_running %>%
  mutate(speed_mph = (total_distance_m / 1609.34) / (total_elapsed_time_s / 3600))

## Creating scatter plot
ggplot(df_running, aes(x = speed_mph, y = steps_per_minute, color = period)) +
  geom_point() +
  labs(title = "SPM vs. Speed by Lap",
       x = "Speed (mph)",
       y = "Steps Per Minute (SPM)")
## woah weird lookin dot plot, but i think its fine
## the initial rehab and post-intervention dots are higher steps & slower

## 5. CHANGING PLOT AESTHETICS
ggplot(df_running, aes(x = speed_mph, y = steps_per_minute, color = period)) +
  geom_point(size = 2, alpha = 0.6) +   ## Changing point size and transparency
  theme_minimal() +                     ## Changing theme
  labs(title = "SPM vs. Speed by Lap",
       x = "Speeed (mph)",
       color = "Time Period") +
  theme(plot.title = element_text(hjust = 0.5, size = 16)) +. ## Center & enlarge title
  scale_color_manual(values = c("Pre-2024" = "blue",          ## Color changes
                                "Initial Rehab" = "orange",
                                "Post-Intervention" = "green"))

  ## I guess that looks cool
  
## 6. ADDING TRENDLINES
  ggplot(df_running, aes(x = speed_mph, y = steps_per_minute, color = period)) +
    geom_point(size = 2, alpha = 0.6) +
    geom_smooth(method = "lm", se = FALSE) +      ## Adding linear trendlines             
    theme_minimal() +
    labs(title = "SPM vs. Speed with Trendlines",
         x = "Speed (mph)",
         y = "Steps Per Minute (SPM)",
         color = "Time Period")

## the trendlines are included but the same color as the dots
  
  ## 7. ANALYSE FATIGUE POST-INTERVENTION
  ## filtering for post-intervention runs and plotting SPM vs. Speed
  
  df_post <- df_running %>% filter(period == "Post-Intervention")
## 212 obs. of 14 variables
  
  ggplot(df_post, aes(x = speed_mph, y = steps_per_minute)) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    labs(title = "Post-Intervention SPM vs. Speed",
         x = "Speed (mph)",
         y = "Steps Per Minute (SPM)")

  ## Views as black dots with a blue trendline gong through
  
  ## ASSIGNING LAP NUMBERS based on timestamp, grouped by date
  df_running <- df_running %>%
    group_by(date = as.Date(timestamp)) %>%
    mutate(lap_number = rank(timestamp))

  ## Selecting only laps 1-3
  df_laps_1_3 <- df_running %>% filter(lap_number <= 3)
## gave me 2525 obs. of 16 variables
  
  ## 9. PLOTTING SPM, SPEED, & LAP NUMBER
  ggplot(df_laps_1_3, aes(x = lap_number, y = steps_per_minute, color = speed_mph)) +
    geom_point(size = 3) +
    labs(title = "SPM and Speed by Lap Number",
         x = "Lap Number",
         y = "Steps Per Minute (SPM)",
         color = "Speed (mph)") +
    theme_minimal()

  ## the plot gave me vertical/straight dot plots for laps 1, 2, and 3
  ## with gradual coloring, higher speeds lighter in color
  
  ## It looks as if when Tyler gets to the third lap,
  ## he is going faster in speed relative to laps 1 & 2
  ## maybe he is getting past the warmup period
  
  ## I THINK THATS IT, THANKS!
  
  
  
  







