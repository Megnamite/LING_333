#Title: Cantonese_Contrast_Significance
#Details: data summary, boxplots, Kruskal-Wallis, Dunn's test, density plot
#Last updated: 2025-12-14
#Author: Yerin Hur

#-----Load in data

library(tidyverse)
Canto_df <- read_csv("drvotsanitised.csv")
Canto_df

#-----Split data into English and Cantonese

Eng_both <- filter(Canto_df, language == 'E')

Canto_four <- filter(Canto_df, language == 'C')

#-----Cantonese (Canto_four) will be tested for significant differences
#-----Remove all columns but 'phone' and 'vot_ms'

Canto_four$Source.Name <- NULL
Canto_four$speaker <- NULL
Canto_four$language <- NULL
Canto_four$clip <- NULL

Canto_four

#-----Tidy rows based on alphabetizing 'phone' column

Canto_four <- Canto_four[order(Canto_four$phone),]

Canto_four

#-----Install and load package for checking assumptions in ANOVA

install.packages("car")

library(car)

#-----Start testing Equal Variance Assumption (Homogeneity of Variance)

leveneTest(vot_ms ~ phone, data = Canto_four)

#-----P-value of < 2.2e-16
#-----Does not satisfy the assumption since it is < 0.05
#-----Must do a Kruskal-Wallis test according to the flowchart
#-----Tutorial: https://www.sthda.com/english/wiki/kruskal-wallis-test-in-r

install.packages("dplyr")

library(dplyr)

#-----Summarise Cantonese phones dataframe

group_by(Canto_four, phone) %>%
  summarise(
    count = n(),
    mean = mean(vot_ms, na.rm = TRUE),
    sd = sd(vot_ms, na.rm = TRUE),
    median = median(vot_ms, na.rm = TRUE),
    IQR = IQR(vot_ms, na.rm = TRUE)
  )

#-----Summarise English phones dataframe

group_by(Eng_both, phone) %>%
  summarise(
    count = n(),
    mean = mean(vot_ms, na.rm = TRUE),
    sd = sd(vot_ms, na.rm = TRUE),
    median = median(vot_ms, na.rm = TRUE),
    IQR = IQR(vot_ms, na.rm = TRUE)
  )

#-----Summarise Cantonese and English phones dataframe

group_by(Canto_df, phone) %>%
  summarise(
    count = n(),
    mean = mean(vot_ms, na.rm = TRUE),
    sd = sd(vot_ms, na.rm = TRUE),
    median = median(vot_ms, na.rm = TRUE),
    IQR = IQR(vot_ms, na.rm = TRUE)
  )

#-----Install and load recommended package for data visualization
#CREDIT:
#title = {ggpubr: 'ggplot2' Based Publication Ready Plots}
#author = {Alboukadel Kassambara}
#year = {2025}
#note = {R package version 0.6.1}
#url = {https://rpkgs.datanovia.com/ggpubr/}

if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/ggpubr")

library("ggpubr")

#-----Create and save boxplot for Cantonese phones

ggboxplot(Canto_four, x = "phone", y = "vot_ms", 
          color = "phone", palette = c("#00AFBB","#008000", "#E7B800", "#FC4E07"),
          order = c("k", "kw", "g", "gw"),
          ylab = "VOT (ms)", xlab = "Cantonese Velar Plosive")

ggsave('Cantonese_Velar_Plosives_colour.png', h = 5, w = 7, units = 'in')

#-----Create and save boxplot for English phones

ggboxplot(Eng_both, x = "phone", y = "vot_ms", 
          color = "phone", palette = c("#A020F0", "#FF69B4"),
          order = c("K","G"),
          ylab = "VOT (ms)", xlab = "English Velar Plosive")

ggsave('English_Velar_Plosives_colour.png', h = 5, w = 7, units = 'in')

#-----Create and save boxplot for Cantonese and English phones

ggboxplot(Canto_df, x = "phone", y = "vot_ms", 
          color = "phone", palette = c("#A020F0","#00AFBB","#008000", "#FF69B4", "#E7B800", "#FC4E07"),
          order = c("K", "k", "kw",  "G", "g", "gw"),
          ylab = "VOT (ms)", xlab = "Cantonese (k, kw, g, gw) and English (K, G)")

ggsave('Bilingual_Velar_Plosives_colour.png', h = 5, w = 7, units = 'in')

#-----Run Kruskal-Wallis test on Cantonese

kruskal.test(vot_ms ~ phone, data = Canto_four)

#-----P-value of < 2.2e-16
#-----Value is < 0.05
#-----Significant differences between the Cantonese phones
#-----Calculate pairwise comparisons between phones according to tutorial

pairwise.wilcox.test(Canto_four$vot_ms, Canto_four$phone,
                     p.adjust.method = "BH")

#-----All pairings except any with kw are significantly different (p < 0.05)
#-----The phone kw only had two tokens so it may be too skewed
#-----Exclude kw since it is not reliable data
#-----Filter out kw for new dataframe

Canto_three <- filter(Canto_four, phone == "k" |phone == "g" |phone == "gw" )

#-----Rerun all tests and make new boxplots with new data excluding kw

leveneTest(vot_ms ~ phone, data = Canto_three)

#-----P-value < 2.2e-16
#-----Does not satisfy Homogeneity of Variance assumption

group_by(Canto_three, phone) %>%
  summarise(
    count = n(),
    mean = mean(vot_ms, na.rm = TRUE),
    sd = sd(vot_ms, na.rm = TRUE),
    median = median(vot_ms, na.rm = TRUE),
    IQR = IQR(vot_ms, na.rm = TRUE)
  )

ggboxplot(Canto_three, x = "phone", y = "vot_ms", 
          color = "phone", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          order = c("k", "g", "gw"),
          ylab = "VOT (ms)", xlab = "Cantonese Velar Plosive")

ggsave('Cantonese_Velar_Plosives_minus_kw_colour.png', h = 5, w = 7, units = 'in')

kruskal.test(vot_ms ~ phone, data = Canto_three)

#-----P-value < 2.2e-16
#-----Significant differences between the three Cantonese phones

pairwise.wilcox.test(Canto_three$vot_ms, Canto_three$phone,
                     p.adjust.method = "BH")

#-----All pairings are significantly different (p < 0.05)
#-----The pairing of g and gw are not as drastic as other pairs

#-----The tutorial used the Pairwise Wilcoxon test for ad-hoc
#-----Our class flowchart says to run the Dunn's Test
#-----Tutorial: https://rpkgs.datanovia.com/rstatix/reference/dunn_test.html
#CREDIT:
  #title = {rstatix: Pipe-Friendly Framework for Basic Statistical Tests}
  #author = {Alboukadel Kassambara}
  #year = {2023}
  #note = {R package version 0.7.2}
  #url = {https://rpkgs.datanovia.com/rstatix/}

if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/rstatix")

library(rstatix) 

#-----Redo Kruskal-Wallis test with new package
#-----Tutorial: https://rpkgs.datanovia.com/rstatix/reference/kruskal_test.html

kruskal_test(Canto_three, formula = vot_ms ~ phone)

#-----P-value 1.07e-255
#-----P < 0.05 so significant differences
#-----Run post-hoc Dunn's Test of Multiple Comparisons

dunn_test(Canto_three, formula = vot_ms ~ phone, p.adjust.method = "holm", detailed = FALSE)

#Conclusion:
#Excluding kw due to limited data,
#Cantonese phones seem to have significant differences between all three paired groupings
#g and k are the most significant with a p-value of 3.18e-257
#gw and k are the next in significance with a p-value of 6.96e-33
#g and gw are the least yet still significant with a p-value of 2.18e-2

#-----Density plots for all phones

Canto_k <- filter(Canto_df, phone == 'k')
mean(Canto_k$vot_ms)

ggdensity(Canto_k, x = "vot_ms",
          add = "mean", 
          title = "Cantonese k",
          color = "#00AFBB", fill = "#00AFBB")

ggsave('Cantonese_k.png', h = 5, w = 7, units = 'in')



Canto_kw <- filter(Canto_df, phone == 'kw')
mean(Canto_kw$vot_ms)

ggdensity(Canto_kw, x = "vot_ms",
          add = "mean", 
          title = "Cantonese kw",
          color = "#008000", fill = "#008000")

ggsave('Cantonese_kw.png', h = 5, w = 7, units = 'in')



Canto_g <- filter(Canto_df, phone == 'g')
mean(Canto_g$vot_ms)

ggdensity(Canto_g, x = "vot_ms",
          add = "mean", 
          title = "Cantonese g",
          color = "#E7B800", fill = "#E7B800")

ggsave('Cantonese_g.png', h = 5, w = 7, units = 'in')



Canto_gw <- filter(Canto_df, phone == 'gw')
mean(Canto_gw$vot_ms)

ggdensity(Canto_gw, x = "vot_ms",
          add = "mean", 
          title = "Cantonese gw",
          color = "#FC4E07", fill = "#FC4E07")

ggsave('Cantonese_gw.png', h = 5, w = 7, units = 'in')



Eng_K <- filter(Canto_df, phone == 'K')
mean(Eng_K$vot_ms)

ggdensity(Eng_K, x = "vot_ms",
          add = "mean", 
          title = "English K",
          color = "#A020F0", fill = "#A020F0")

ggsave('English_K.png', h = 5, w = 7, units = 'in')



Eng_G <- filter(Canto_df, phone == 'G')
mean(Eng_G$vot_ms)

ggdensity(Eng_G, x = "vot_ms",
          add = "mean", 
          title = "English G",
          color = "#FF69B4", fill = "#FF69B4")

ggsave('English_G.png', h = 5, w = 7, units = 'in')

