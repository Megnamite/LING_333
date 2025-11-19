
library(tidyverse)
theme_set(theme_bw(base_size = 12)) # Theme for plot consistency (b&w, font 12)

ldt_df <- read.csv("D:\\UBC Coding Environment\\VIsual Studio\\LING_333-1\\ClassWork\\ldt_data.csv")

#ggplot(ldt_df, aes(x = Mean_RT)) + #initialise plot with data, specifiy mean_rt at x
#geom_histogram(bins = 13, color = 'black', fill = 'lightblue') #create histogram, 13 "bins", black border light blue inside

ggplot(ldt_df, aes(x = Length, y = Mean_RT)) +
geom_point() 