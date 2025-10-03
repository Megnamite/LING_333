library(tidyverse)
ldt_data <- read.csv("ldt_data.csv")

unique(ldt_data$RT_speed) # Prints out all unique possible values in RT_speed

# Filter:
# First argument is datatable, 
# Second argument is column and desired value to filter for
# Print all rows for which the desired column value is true
filter(ldt_data, RT_speed == "fast")

# New datatable produced from list
ldt_data_2 <- filter(ldt_data, RT_speed == "fast")

# Can also use numeric or binary comparisons
filter(ldt_data, Length != 9) # ! is inverse operator as normal

# Binary operators can be used for logic
filter(ldt_data, Length == 9 & RT_speed == "slow" )
# List of Binary Operators found in intro notres file line 145 ish

filter(ldt_data, Length < 6 | Length > 11)

mutate(ldt_data, Length_10 = Length*10) # Need notes on mutate function
# Basically just adds a new column called $Length_10 which is $Length multiplied by 10

mutate(ldt_data, Length_Freq_Ratio = Length/Freq)


df1 <- filter(ldt_data, Length < 9)
df2 <- mutate(df1, Length_2 = Length * 20)
df3 <- filter(df2, Mean_RT > 880)
# This can all be combined with R "pipes"
# Syntax is the operator %>%

# For example this achieves the same thing:
df4 <- ldt_data %>%
    filter(Length < 9)%>%
    mutate(length_2 = Length * 20) %>%
    filter(Mean_RT > 880) #No pipe needed here for some reason
df4 # Everything with %>% modifies the ldt_data%>%
# %>% takes what comes in before, passes onto the next step,
# Think of everything connected with %>% as just being one big one liner equation
