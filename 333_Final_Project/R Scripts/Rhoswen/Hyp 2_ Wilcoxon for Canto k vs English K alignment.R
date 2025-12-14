
# 2025-12-08 
# Wilcoxon for finding significance of Cantonese k and English K difference (Hypothesis 2)
# Rhoswen The 

#--------------- 

library(tidyverse)
drvot <- read_csv("drvotsanitised.csv")
drvot

#----------

# Shapiro first for normality 
Shapiro_Canto <- filter(drvot, phone == 'k')
drvot$Source.Name <- NULL
drvot$speaker <- NULL
drvot$language <- NULL
drvot$clip <- NULL

Shapiro_Canto

shapiro.test(Shapiro_Canto$vot_ms)
    # p-value = 8.517e-05 --> Failed. Non-normal distribution. Will do Wilcoxon. 

#---- Want to see Eng normality too. 
Shapiro_Eng <- filter(drvot, phone == 'K')
drvot$Source.Name <- NULL
drvot$speaker <- NULL
drvot$language <- NULL
drvot$clip <- NULL

Shapiro_Eng

shapiro.test(Shapiro_Eng$vot_ms)
    # p-value = 7.638e-11 --> Failed. Non-normal distribution. Definitely doing Wilcoxon. 


#------------ 
# Here is the Wilcoxon test! 
wilcox.test(Shapiro_Canto$vot_ms, Shapiro_Eng$vot_ms) # I sure hope the order doesn't matter this time 




#----------------- 
# Okay, so we did a test that tells us that there is a significant difference. 
  # Now, for part two of Hypothesis 2, we have a directional hypothesis to validate. 

#---- 
# This Wilcoxon says that we think Canto vot_ms is going to be greater than Eng vot_ms! 
wilcox.test(Shapiro_Canto$vot_ms, Shapiro_Eng$vot_ms, alternative = 'greater')







