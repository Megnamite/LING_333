
# 2025-12-08 
# Levene's Test for variance in English and Cantonese phones ("spread") (Hypothesis 1)
# Rhoswen The 

#--------------- 
# Levene's for variance -- seeing if English phones have a spread that is significantly different than Canto phones. 

library(tidyverse)
drvot <- read_csv("drvotsanitised.csv")
drvot

#----------

#install.packages("car")

library(car)

#------
#install.packages("dplyr")


#-----


drvot$Source.Name <- NULL
drvot$speaker <- NULL
drvot$phone <- NULL
drvot$clip <- NULL

drvot

table(drvot$language)

leveneTest(vot_ms ~ language, data = drvot)
    # interestingly, Levene's Test requires one categorical and one numeric variable to run... 
      # ...and R expects the DV (numeric) to be on the left and the IV (categorical) to be on the right. 
        # That's why it's vot_ms ~ language, not the other way. 


#------------------ 
# Now we need to find out if Cantonese is really the wider spread. 
    # All we know is that there's a significant difference in the spread right now. 

# SD by language 
tapply(drvot$vot_ms, drvot$language, sd)

# Variance by language 
tapply(drvot$vot_ms, drvot$language, var)


