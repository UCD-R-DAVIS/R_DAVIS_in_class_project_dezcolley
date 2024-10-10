## Homework 2 Class Notes

## hw2[!is.na(hw2)]
## !is.na(hw2) #will give you TRUE or FALSE
## na.omit(hw2) ##gets rid of all NAs
## hw2[complete.cases(hw2)]

## hw2[!is.na(hw2) & hw2 >= 14 & hw2 <= 38]

## hw2[c(14:38)] ## is an index vector ## not used for this

## times3 <- prob1 * 3 ##times three

## plus10 <- times3 + 10 ##adding ten
## plus10

## str(plus10) #27
## class(plus10)

## cbind(hw2, hw2, hw2 + hw2) ## combines vectors and shows them as a matrix or array
## cbind(hw2, plus10, hw2 + plus10) ## 

## NOTES

# Other Data Types
## Lists
c(4, 6, "dog")
a <- list(4, 6, "dog")
class(a)
str(a)

# Data.frames
letters
data.frame(letters)
df <- data.frame(letters)
as.data.frame(t(df))

length(df)
dim(df)
nrow(df)
ncol(df)


#factors

animals <- factor(c("duck", "duck", "goose", "goose"))
animals

animals <- factor(c("pigs", "duck", "duck", "goose", "goose"))
animals

class(animals)
levels(animals)
nlevels(animals)


animals <- factor(x = animals, levels = c("goose", "pigs", "duck"))
animals

year <- factor(c(1978, 1980, 1939, 1979))
year
class(year)
as.numeric(year)
levels(year)

as.numeric(animals)
as.character(animals)
