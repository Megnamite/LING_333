# Filename: ANOVA_Canto.R
# Last Updated: 7/12/2025
# Author: Yerin


library(tidyverse)
Canto_df <- read_csv(r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\drvot sanitised data\drvotsanitised.csv)")
Canto_df

Canto_k <- filter(Canto_df, phone == 'k')

Canto_k$Source.Name <- NULL
Canto_k$speaker <- NULL
Canto_k$language <- NULL
Canto_k$clip <- NULL
Canto_k$phone <- NULL

Canto_k

names(Canto_k)[names(Canto_k) == 'vot_ms'] <- 'k'

Canto_k

#----------------

Canto_kw <- filter(Canto_df, phone == 'kw')

Canto_kw$Source.Name <- NULL
Canto_kw$speaker <- NULL
Canto_kw$language <- NULL
Canto_kw$clip <- NULL
Canto_kw$phone <- NULL

names(Canto_kw)[names(Canto_kw) == 'vot_ms'] <- 'kw'

Canto_kw

#-----------

Canto_g <- filter(Canto_df, phone == 'g')

Canto_g$Source.Name <- NULL
Canto_g$speaker <- NULL
Canto_g$language <- NULL
Canto_g$clip <- NULL
Canto_g$phone <- NULL

names(Canto_g)[names(Canto_g) == 'vot_ms'] <- 'g'

Canto_g

#-----------

Canto_gw <- filter(Canto_df, phone == 'gw')

Canto_gw$Source.Name <- NULL
Canto_gw$speaker <- NULL
Canto_gw$language <- NULL
Canto_gw$clip <- NULL
Canto_gw$phone <- NULL

names(Canto_gw)[names(Canto_gw) == 'vot_ms'] <- 'gw'

Canto_gw

#---------

Eng_K <- filter(Canto_df, phone == 'K')

Eng_K$Source.Name <- NULL
Eng_K$speaker <- NULL
Eng_K$language <- NULL
Eng_K$clip <- NULL
Eng_K$phone <- NULL

names(Eng_K)[names(Eng_K) == 'vot_ms'] <- 'K'

Eng_K

#-----------

Eng_G <- filter(Canto_df, phone == 'G')

Eng_G$Source.Name <- NULL
Eng_G$speaker <- NULL
Eng_G$language <- NULL
Eng_G$clip <- NULL
Eng_G$phone <- NULL

names(Eng_G)[names(Eng_G) == 'vot_ms'] <- 'G'

Eng_G

#------------

Canto_df

Canto_four <- filter(Canto_df, phone == 'k'| phone == 'kw'|phone == 'g'|phone == 'gw')


Canto_four$Source.Name <- NULL
Canto_four$speaker <- NULL
Canto_four$language <- NULL
Canto_four$clip <- NULL

Canto_four

Canto_four <- Canto_four[order(Canto_four$phone),]

Canto_four

#--------

Canto_four %>%
  ggplot(aes(x = phone, y = vot_ms)) +
  geom_boxplot() +
  ggtitle("Cantonese Velar Plosives") +
  xlab("Phones") + ylab("VOT (ms)")

#ggsave('Cantonese_Velar_Plosives.png', h = 5, w = 7, units = 'in')


#----------

library(car)

#------------

leveneTest(vot_ms ~ phone, data = Canto_four)

#------

library(dplyr)

group_by(Canto_four, phone) %>%
  summarise(
    count = n(),
    mean = mean(vot_ms, na.rm = TRUE),
    sd = sd(vot_ms, na.rm = TRUE),
    median = median(vot_ms, na.rm = TRUE),
    IQR = IQR(vot_ms, na.rm = TRUE)
  )

if(!require(devtools)) install.packages("devtools")
devtools::install_github("kassambara/ggpubr")

library("ggpubr")
windows();
  ggboxplot(Canto_four, x = "phone", y = "vot_ms", 
          color = "phone", palette = c("#00AFBB", "#E7B800", "#FC4E07", "#044c2f"),
          order = c("k", "kw", "g", "gw"),
          ylab = "VOT (ms)", xlab = "Cantonese Velar Plosive")

kruskal.test(vot_ms ~ phone, data = Canto_four)

pairwise.wilcox.test(Canto_four$vot_ms, Canto_four$phone,
                     p.adjust.method = "BH")

#-----


Canto_three <- filter(Canto_four, phone == "k" |phone == "g" |phone == "gw" )

Canto_three %>%
  ggplot(aes(x = phone, y = vot_ms)) +
  geom_boxplot() +
  ggtitle("Cantonese Velar Plosives (minus kw)") +
  xlab("Phones") + ylab("VOT (ms)")

ggsave('Cantonese_Velar_Plosives_minus_kw.png', h = 5, w = 7, units = 'in')


library(car)


leveneTest(vot_ms ~ phone, data = Canto_four)

library(dplyr)

group_by(Canto_three, phone) %>%
  summarise(
    count = n(),
    mean = mean(vot_ms, na.rm = TRUE),
    sd = sd(vot_ms, na.rm = TRUE),
    median = median(vot_ms, na.rm = TRUE),
    IQR = IQR(vot_ms, na.rm = TRUE)
  )
windows();
ggboxplot(Canto_three, x = "phone", y = "vot_ms", 
          color = "phone", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          order = c("k", "g", "kw"),
          ylab = "VOT (ms)", xlab = "Cantonese Velar Plosive")

kruskal.test(vot_ms ~ phone, data = Canto_three)

pairwise.wilcox.test(Canto_three$vot_ms, Canto_three$phone,
                     p.adjust.method = "BH")