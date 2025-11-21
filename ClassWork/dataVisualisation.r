library(tidyverse)
theme_set(theme_bw(base_size = 12)) # Theme for plot consistency (b&w, font 12)

ldt_df <- read.csv("C:/Users/Maria/Documents/UNI/Visual Studio UBC Workspace/LING_333/ldt_data.csv")

# In ggplot, plus means we are giving extra value according to the original plot

ggplot(ldt_df, aes(x = Mean_RT)) + #initialise plot with data, specifiy mean_rt at x
geom_histogram(bins = 13, color = 'black', fill = 'lightblue') #create histogram, 13 "bins", black border light blue inside
ggsave("meanrthisto.png", h = 5, w = 7, units = "in")

ggplot(ldt_df, aes(x = Length)) + #initialise plot with data, specifiy mean_rt at x
geom_histogram(bins = 10, color = 'black', fill = 'lightblue')
ggsave("lengthhisto.png", h = 5, w = 7, units = "in")

ggplot(ldt_df, aes(x = Length_type, y = Mean_RT)) +
geom_boxplot()

# Keep only "long" and "short" categories
subset_df <- filter(ldt_df, Length_type == "long" | Length_type == 'short')
# Plot with the subset
ggplot(subset_df, aes(x = Length_type, y = Mean_RT)) +
geom_boxplot()

# Keep only "long" category
subset_df <- filter(ldt_df, Length_type == "long")
# Plot with the subset
ggplot(subset_df, aes(x = Length_type, y = Mean_RT)) +
geom_boxplot()

ggplot(subset_df, aes(x = Length, y = RT_speed)) +
geom_boxplot()

# Keep only "fast" and "slow" categories
subset_df <- filter(ldt_df, RT_speed == "fast" | RT_speed == 'slow')
# Plot with the subset
Length_7 <- filter(ldt_df, Length>7)
ggplot(subset_df, aes(x = RT_speed, y = Length_7)) +
geom_boxplot()

#Create a scatterplot of Length vs. Mean_RT
ggplot(ldt_df, aes(x = Length, y = Mean_RT)) +
geom_point()

# Create a scatterplot with customized points
ggplot(ldt_df, aes(x = Length, y = Mean_RT)) +
geom_point(pch = 1, size = 2)
#pch = 1: Changes point shape (1 = hollow circle)
#size = 2: Adjusts point size

# Scatterplot of Freq vs. Mean_RT (without transformation)
ggplot(ldt_df, aes(x = Freq, y = Mean_RT)) +
geom_point(pch = 1, size = 2)

# Create a new variable with log-transformed frequency
ldt_df <- ldt_df %>%
mutate(log_Freq = log(Freq)) #simple math, applies log to freq
# Plot with the transformed variable
ggplot(ldt_df, aes(x = log_Freq, y = Mean_RT)) +
geom_point(pch = 1, size = 2)

#  scatterplot to explore the relationship between Length and Freq
ggplot(ldt_df, aes(x = Length, y = Freq)) +
geom_point(pch = 1, size = 2) +
geom_smooth(method = "lm") 
# Add a smoothing line, the line is pretty weird tho

