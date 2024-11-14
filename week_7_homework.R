library(tidyverse)

gapminder <- read_csv("data/gapminder.csv") ##PULLING THE DATA FROM THE CSV
## CONTAINS POP & DEMOGRAPHIC DATA FROM VARIOUS COUNTRIES

view(gapminder)

pg <- gapminder %>%
  select(country, year, pop, continent) %>%
  filter(year > 2000) %>%
  pivot_wider(names_from = year, values_from = pop) %>%
  mutate(pop_change_0207 = `2007`-`2002`)

## CREATES TABLE WITH POP DIFFERENCE

view(pg)  

pg %>%
  filter(continent != "Oceania") %>% ## REMOVES COUNTRIES AUS & NZ
  ggplot(aes(x = reorder(country, pop_change_0207), y = pop_change_0207)) +
  geom_col(aes(fill = continent)) +
  facet_wrap(~continent, scales = "free") +
  theme_bw() +
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position = "none") +
  xlab("Country") +
  ylab("Change in Population Between 2002 & 2007")
  
  ## CREATES FOUR BAR GRAPHS OF COUNTRIES SHOWING DIFFERENCE OF POP FROM 02 TO O7
  
  
  