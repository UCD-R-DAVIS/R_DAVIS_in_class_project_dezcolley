surveys <- read.csv("data/portal_data_joined.csv")

nrow(surveys)
ncol(surveys)
dim(surveys)

?str #Compactly Display the Structure of an Arbitrary R Object

str(surveys)

summary(surveys)

summary(surveys$record_id)

summary.data.frame(surveys)
?summary.data.frame

dim(surveys)

surveys[1:5]

surveys[c(1, 5, 24, 3001),]
        
surveys[,1]        ##looks like a vector
surveys[,1:5] ##gives data series

dim(surveys[,1:5])

dim(surveys[1])

colnames(surveys)

cols_to_grab = c('record_id', 'year', 'day')        
cols_to_grab        

surveys[cols_to_grab]        

tail(surveys)        
head(surveys)        

surveys[1:6,]        

surveys[1,]


head(surveys["genus"])
head(surveys[["genus"]])
head(surveys[,'genus'])

str(surveys)

surveys$genus

install.packages('tidyverse')
library(tidyverse)

?read_csv
t_surveys <- read_csv('data/portal_data_joined.csv')
class(t_surveys)
t_surveys



