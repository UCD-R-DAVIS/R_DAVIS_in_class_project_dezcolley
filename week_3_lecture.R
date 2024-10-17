# Homework 3 Review -----
#Load your survey data frame with the read.csv() function. 
surveys <- read.csv("data/portal_data_joined.csv")

##Create a new data frame called surveys_base with only the species_id, the weight, and the plot_type columns. 
surveys_base <- surveys[, c(6, 9, 13)]
surveys_base <- surveys[, c("species_id", "weight", "plot_type")]
surveys_base <- select(surveys, species_id, weight, plot_type)

## Have this data frame only be the first 5,000 rows. 
surveys_base <- surveys[1:5000, c("species_id", "weight", "plot_type")]
1:5

#Convert both species_id and plot_type to factors. Remove all rows where there is an NA in the weight column. 
surveys_base$species_id <- factor(surveys_base$species_id)
class(surveys_base$species_id)
str(surveys_base)

surveys_base_species_id <- factor(surveys_base$species_id)
surveys_base_species_id
surveys_base

#Explore these variables and try to explain why a factor is different from a character. Why might we want to use factors? Can you think of any examples?



#CHALLENGE: Create a second data frame called challenge_base that only consists of individuals from your surveys_base data frame with weights greater than 150g.












