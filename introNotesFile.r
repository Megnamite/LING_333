# R Notes Document
# Sebastiano Giannelli Viscardi
# September 12th
# LING 333

library(tidyverse)

windows();
plot(1, 3) # create a plot in a separate window, works much nicer than just plot() # nolint: line_length_linter.

# Use arrow or equals to create variables
x <- 5
x = 5

# Use paste if you want to print with numerous fields
paste(x, "plus 3 equals:", x+3)

# Can also combine strings
firstName = "Sebastiano"
lastName = "Giannelli Viscardi"
fullName = paste0(firstName, " ", lastName) # Need the space otherwise there is none, can also just use paste() instead of paste0() # nolint: line_length_linter.
# fullName = paste(firstName, lastName) this works without a space in the middle! # nolint
fullName

# Syntax of reading from files
df = read_csv(file.choose())
df

# Creating lists and vectors
# Vectors contain only 1 datatype, lists can contain variety
decimalVector = 1.5:6.5 # creates [1.5, 2.5, 3.5, 4.5, 5.5, 6.5] # nolint

numberVector = c(1, 2, 4, 6, 8) #c() used to combine items

exampleList = list(numberVector, decimalVector) #list created with list(), combines datatypes

#length(exampleList) returns 2, not 1
#exampleList [2] refers to decimalVector, not an error


# Intro to filetypes
b <- TRUE 
class(b) # "Logical" is the binary logic class, can also be considered 1 for mathematical purposes
# I.e. TRUE + 1 == 2

a <- 5
class(a) # "Numerical" is the number data type, including floats and negative numbers

c <- 3L 
class(c) # Integer is the normal integer data type, can go negative but not float

d <- "Friday"
class(d) # Character dataset encapsulates both characters and strings

# ****************
# *DATA STRUCTURE*
# ****************
# Four options, Vectors, Lists, Matrices, Arrays, and Data Frames
# Created using c() function (the concatenate function)

# Vectors only contain the same type
# Ordered, changeable, Indexed
monthList <- c('january', 'february', 'march', 'april', 'may', 'june', "etc") #notice I can use both single and double quotes
numbers <- c(1, 2, 3, 4, 5)
testvect <- c(monthList, numbers) # Here both variable types within the vector are also vectors, so this actually works!!
print(testvect)  # See here
print(monthList) # or paste(monthList)

# Vectors can also have operations run on them
# e.g.
numbers <- c(1, 2, 3, 4, 5)
numbers * 2 # Multiply each element in the vector by 2
numbers > 3 # Compare each element in the vector with 3
print(numbers>3) # Keep in mind it returns binary logic values!!! Not the values of the items in the set
numbersLogic <- c(numbers > 3)
print(numbers[numbersLogic]) # SEE THIS WORKS, Create a set based on the truth values and access those truth values

test <- c("len", "leng", "lengt", "length")
test2 <- c("length", "lengt", "leng", "len")
test2 > test # The comparison seems to be based on string length?

#############

# Lists can contain multiple variable types
# Ordered, changeable
# Created using list() rather than c()
fruitList <- list("Apple", "Banana", 5.5, 10.5)
paste(fruitList) # Can Not use print!!

############

# Matrix
# Akin to python dict, except closer to a table with rows and columns
thismatrix <- matrix(c(1,2,3,4,5,6), nrow = 3, ncol = 2) # 3 rows, 2 columns, 
print(thismatrix) # Numbers are added to the matrix top down left to right
# Can also contain chars, or other values, 
# You can access values with square brackets,
# Value 1 is the row, value 2 is the column
print(thismatrix[2, 2])

# Can also access whole rows and columns
print(thismatrix[,1]) # This accesses all of column 1
print(thismatrix[1:2,]) # This accessses all of row 1 to row 2
# Can always use c() to access numerous rows or columns

# Can add additional columns with cbind()
thismatrix <- matrix(c("apple", "banana", "cherry","orange","grape", "pineapple", "pear", "melon", "fig"), nrow = 3, ncol = 3)
newmatrix <- cbind(thismatrix, c("strawberry", "blueberry", "raspberry"))
thismatrix <- cbind(thismatrix, c("strawberry", "blueberry", "raspberry"))
print(thismatrix) # This works to change the matrix, or you can make a new one

# Add additional rows with rbind()
thismatrix <- matrix(c("apple", "banana", "cherry", "orange","grape", "pineapple", "pear", "melon", "fig"), nrow = 3, ncol = 3)
newmatrix <- rbind(thismatrix, c("strawberry", "blueberry", "raspberry"))
print(newmatrix)

# Use [-c(1), ]

thismatrix <- matrix(c("apple", "banana", "cherry", "orange", "mango", "pineapple"), nrow = 3, ncol =2)
#Remove the first row and the first column
thismatrix
thismatrix <- thismatrix[-c(1), -c(1)]
thismatrix 

####################

# Accessing Items from data structures
# Just use [] and a number for exact address
# Remember 1 counting, not zero counting
# i.e. vector_name[1] is the first item
# vector_name [1:3] is first to third item
# vector_name[c(1, 3)] is only first and third item
#vector_name[-2] excludes the 2nd item 
fruit <- c("Apple", "Banana", "Peach", "Strawberry", "Plum")
print(fruit[2])
print(fruit[2:5])
print(fruit[c(2, 5)])
print(fruit[-3])
# You won't get out of bounds errors but a vector will just return NA
# e.g.
print(fruit[7]) # Returns NA

# Binary Logical Operators
# & 	Element-wise Logical AND operator. Returns TRUE if both elements are TRUE
# && 	Logical AND operator - Returns TRUE if both statements are TRUE
# | 	Elementwise- Logical OR operator. Returns TRUE if one of the statements is TRUE
# || 	Logical OR operator. Returns TRUE if one of the statements is TRUE
# !     Logical NOT - Returns FALSE if statement is TRUE, used as negation
