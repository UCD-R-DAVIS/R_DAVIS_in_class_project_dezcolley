library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv") ##brings out obs. w/ 13 var

surveys <- surveys %>%
  filter(weight > 30 & weight < 60) ## parsing down to certain weight 30-60

biggest_critters <- surveys %>% ## 34 obs of 3 variables
  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>%
  summarise(max_weight = max(weight))

biggest_critters %>% arrange(max_weight) ## arrange by max weight 30-60

## species_id sex   max_weight
##  <chr>      <chr>      <dbl>
## 1 PM         F           35
## 2 OT         M           36
## 3 OL         NA          37
## 4 PE         F           38
## 5 PE         M           40
## 6 PP         F           41
## 7 PH         M           42
## 8 PP         M           42
## 9 SF         NA          45
## 10 OT        F          46

surveys %>%
  filter(!is.na(weight)) %>%
  group_by(species) %>%
  tally() %>%
  arrange(desc(n))

surveys %>%
  filter(!is.na(weight)) %>%
  group_by(plot_id) %>%
  tally() %>%
  arrange(desc(n))

surveys %>%
  filter(!is.na(weight)) %>%
  group_by(year) %>%
  tally() %>%
  arrange(desc(n))

surveys_avg_weight <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>%
  mutate(avg_weight = mean(weight)) %>%
  select(species_id, sex, weight, avg_weight)

surveys_avg_weight

# A tibble: 14,730 × 4
# Groups:   species_id, sex [34]
##species_id sex   weight avg_weight
##<chr>      <chr>  <dbl>      <dbl>
  #1 NL         F         40       46.5
##2 DM         M         51       45.3
##3 DM         M         44       45.3
##4 DM         M         39       45.3
##5 DM         M         49       45.3
##6 DM         M         47       45.3
##7 DM         M         41       45.3
##8 DM         F         55       42.6
##9 DM         F         36       42.6
##10 DM         M         47       45.3
# ℹ 14,720 more rows

surveys_avg_weight <- surveys_avg_weight %>%
  mutate(above_average = weight > avg_weight)

surveys_avg_weight

# A tibble: 14,730 × 5
# Groups:   species_id, sex [34]
##species_id sex   weight avg_weight above_average
##  1 NL         F         40       46.5 FALSE        
##2 DM         M         51       45.3 TRUE         
##3 DM         M         44       45.3 FALSE        
##4 DM         M         39       45.3 FALSE        
##5 DM         M         49       45.3 TRUE         
##6 DM         M         47       45.3 TRUE         
##7 DM         M         41       45.3 FALSE        
##8 DM         F         55       42.6 TRUE         
##9 DM         F         36       42.6 FALSE        
##10 DM         M         47       45.3 TRUE         
# ℹ 14,720 more rows
# ℹ Use `print(n = ...)` to see more rows
