# Q.1 Display the first 4 rows of the ldt_data using head() function.
library(tidyverse)
ldt_data <- read.csv("ldt_data.csv")

print(head(ldt_data[1:4, ]))# Print all columns, rows 1:4

# Q2: Display the last 7 rows of the ldt_data. 

len <- nrow(ldt_data)
n <- len - 7
print(ldt_data[n:len, ]) # For some reason ldt_data[len-7:len,] does not work!!! Talk to prof # nolint: line_length_linter.

# Q3: View the summary statistics for the “Freq” column only using summary().

print(summary(ldt_data$Freq))
# You see minimum, max, mean, median, and quadrants

print("Q4: Create a new column named “Freq_Doubled” that contains twice the values of the “Freq” column.")

freq_double <- c(ldt_data$Freq) * 2 # New vector with doubled values
doubles_ldt_data <- cbind(ldt_data, "Freq_Doubled" = freqDouble) #cbind() to add a new column
print(doubles_ldt_data)

print("Q5: Create a for loop to iterate through each element in the “Length” column and print the length of each word.")
# Q5: Create a for loop to iterate through each element in the “Length” column and print the length of each word.

for (i in seq_len(nrow(ldt_data))){ # For i from 1:nrows
    print(nchar(ldt_data$Length[i])) # print nchar of the string in position i
}

print("Q6: Use a for loop to iterate through the “RT_speed” column and print only the “fast” values.")
# Q6: Use a for loop to iterate through the “RT_speed” column and print only the “fast” values.
for (i in seq_len(nrow(ldt_data))){ # For i from 1:nrows
    if (ldt_data$RT_speed[i] == "fast"){
        print(ldt_data$RT_speed[i])
    }
}

print("Q7: Write code for getting the minimum value in the column Mean_RT")
# Q7: Write code for getting the minimum value in the column Mean_RT

mean_RT <- c(ldt_data$Mean_RT)
print(ldt_data$Mean_RT[which(mean_RT == min(mean_RT))]) 
# which(mean_RT == min(mean_RT)) finds the index of the minimum value
# Print the value at the minimum index of the row

print("Q8: Write a code to check if the minimum value you got is smaller than 600.")
# Q8: Write a code to check if the minimum value you got is smaller than 600

mean_RT <- c(ldt_data$Mean_RT)
minimumMean <- ldt_data$Mean_RT[which(mean_RT == min(mean_RT))]
if (minimumMean > 600) {
    print("not smaller")
} else { #HAS TO BE INLINE WITH CLOSING THE IF STATEMENT
    print("smaller")
}


# Q9:Question:
# a. Create a new column by multiplying each value in the Length variable by 20 and store it as a column
# named Length_20
# b. get the values in the column Length_20 and store it as a vector named Length_20_v
# c. create another vector Length_20_v_sub containing only the 21st to 30th elements in Length_20_v
# d. write a for loop that prints the values in Length_20_v_sub, one by one, if they are smaller than 180.

# Q9 A:
Length_20_v <- c(ldt_data$Length) * 20 # New vector with 20x values
lenIncLtdData <- cbind(ldt_data, "Length_20" = Length_20_v) #cbind() to add a new column
print(lenIncLtdData)

# Q9 B: Already done above!

# Q9 C:
Length_20_v_sub <- c(Length_20_v[21:30])
print(Length_20_v_sub)

# Q9 D:
for (i in seq_len(length(Length_20_v_sub))){
    if (Length_20_v_sub[i]<180){
        print(Length_20_v_sub[i])
    }
}