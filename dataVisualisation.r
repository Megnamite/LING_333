library(tidyverse)
theme_set(theme_bw(base_size = 12)) # Theme for plot consistency (b&w, font 12)

ldt_df <- read.csv("ldt_data.csv")

ggplot(ldt_df, aes(x = Mean_RT)) + #initialise plot with data, specifiy mean_rt at x
geom_histogram(bins = 13, color = 'black', fill = 'lightblue') #create histogram, 13 "bins", black border light blue inside

