
# 2025-12-01 
# Overall means for English K and English G 
# Rhoswen The 

#--------------- 


library(tidyverse)
drvot <- read_csv("drvotsanitised.csv")
drvot

#----------

#install.packages("car")

library(car)

#------
#install.packages("dplyr")


#-----


Eng_means <- filter(drvot, language == "E")

Eng_means %>%
  ggplot(aes(x = phone, y = vot_ms)) +
  geom_boxplot() +
  ggtitle("English K and G means") +
  xlab("Phones") + ylab("VOT (ms)")

ggsave('English_K_and_G_means.png', h = 5, w = 7, units = 'in')

Eng_means$Source.Name <- NULL
Eng_means$speaker <- NULL
Eng_means$language <- NULL
Eng_means$clip <- NULL



library(dplyr)

group_by(Eng_means, phone) %>%
  summarise(
    count = n(),
    mean = mean(vot_ms, na.rm = TRUE),
    sd = sd(vot_ms, na.rm = TRUE),
    median = median(vot_ms, na.rm = TRUE),
    IQR = IQR(vot_ms, na.rm = TRUE)
  )