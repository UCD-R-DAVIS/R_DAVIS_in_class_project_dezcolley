##problem 1

surveys <- read.csv("data/portal_data_joined.csv")

colnames(surveys) ##a list of column names

surveys_base <- surveys[1:5000, c(6, 9, 13)]

surveys_base <- surveys_base[complete.cases(surveys_base), ]

surveys_base$species_id <- factor(surveys_base$species_id)

surveys_base$plot_type <- factor(surveys_base$plot_type)

levels(surveys_base$species_id) #exp of factors

typeof(surveys_base$species_id) #gives me integer

class(surveys_base$species_id) #gives factor

#challenge

challenge_base <- surveys_base[surveys_base[, 2]>150, ]

## this selects just the weights in the second column



