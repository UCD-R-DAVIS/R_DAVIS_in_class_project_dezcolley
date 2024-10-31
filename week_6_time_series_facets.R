library(tidyverse)

surveys_complete <- read_csv('data/portal_data_joined.csv') %>%
  filter(complete.cases(.))

# these are two different ways of doing the same thing
head(surveys_complete %>% count(year,species_id))
head(surveys_complete %>% group_by(year,species_id) %>% tally())

yearly_counts <- surveys_complete %>% count(year,species_id)

head(yearly_counts)

ggplot(data = yearly_counts,
       mapping = aes(x = year, y = n)) +
  geom_point()

ggplot(data = yearly_counts,
       mapping = aes(x = year, y= n)) +
  geom_line() +
  geom_point()

ggplot(data = yearly_counts,
       mapping = aes(x = year, y= n,group = species_id)) +
  geom_line(aes(colour = species_id)) ## colored combined


ggplot(data = yearly_counts,
       mapping = aes(x = year, y= n, colour = species_id)) +
  geom_line() +
  facet_wrap(~species_id) ## colored separated


ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id) ## Black and white separated


ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
  geom_line() +
  facet_wrap(~ species_id,scales = 'free')