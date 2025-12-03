library(tidyverse)
theme_set(theme_bw(base_size = 12)) 

dr_df <- read.csv(r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\drvot sanitised data\drvotsanitised.csv)")
man_df <- read.csv(r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\manual sanitised data\manualsanitised.csv)")

head(dr_df)

ggplot(dr_df, aes(x = phone, y = vot_ms)) +
geom_boxplot()

ggplot(man_df, aes(x = phone, y = vot_ms)) +
geom_boxplot()