library(tidyverse)

canto_anova <- read_csv(r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\drvot sanitised data\drvotsanitised.csv)")

canto_anova

# filtering so we only get Canto 
anova <- filter(canto_anova, language == 'C')

# filtering OUT all the columns we don't want condensed into the two columns, including language! 
anova$Source.Name <- NULL
anova$speaker <- NULL
anova$language <- NULL
anova$clip <- NULL

anova

# now to do the tidying 
anova_tidy <- gather(anova, key = 'phone', value = 'vot_ms')
anova_tidy_minuskw <- anova[anova$phone != "kw",]
anova_tidy_minuskw

# We need to meet these next few assumptions to be able to run ANOVA: 

# Independence Assumption --> data collected randomly. well, hopefully. We collected everything, so. --> PASSED 

# Equal Variance Assumption --> use Levene's test -----------------------------------------------------> FAILED 
install.packages("car")
    # The downloaded source packages are in
          # ‘C:\Users\Cloud\AppData\Local\Temp\RtmpErIxbu\downloaded_packages’
library(car)

  # here's the Levene's test 
#leveneTest(phone - vot_ms, data = anova_tidy)
    # why does it say that object 'vot_ms' is not found...? 
    # oh, if I swap it, 'phone' is not found either... 



  # GOD - it was ~, not - 
leveneTest(vot_ms ~ phone, data = anova_tidy_minuskw)

  # Right, so... apparently, if Pr(>F) AKA p-value is higher than 0.05, we're good. 
      # It means that the variances are approximately equal across the groups. 
    # BUT it's not. It's omega low... < 2.2e-16 ... that's 15 zeroes plus the one before the decimal point. LOL 

# Normality of Residuals --> errors/residuals follow a normal distribution. ---------------------------> FAILED 
aov_anova <- aov(vot_ms ~ phone, data = anova_tidy_minuskw) # fit ANOVA model 

residuals_aov <- residuals(aov_anova) # extract residuals 

shapiro.test(residuals_aov) # run test for RESIDUALS (not the raw data) for normality 

  # And if the p-value from the Shapiro-Wilk is higher than 0.05, we're good. 
      # It means that the residuals don't significantly deviate from normality (AKA are normal). 
    # But they're not :) because p-value < 2.2e-16 

  # might as well see it 
window();
  hist(residuals_aov)
    # hey, it looks like a middle finger! It's not even THAT non-normal, come on... 



# ...well. I guess I'll run the ANOVA... 

aov_anova <- aov(vot_ms ~ phone, data = anova_tidy)

summary(aov_anova)

 # SO! Apparently, if the p-value is less than 0.05, we can reject H0. 
     # It means that at least one group mean differes from the others... but we don't know which one. 
        # though we can guess. lol 
    # p-value is < 2e-16. But it's not like it is valid. HAHA. 
