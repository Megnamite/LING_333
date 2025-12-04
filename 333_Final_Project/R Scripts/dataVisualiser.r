library(tidyverse)
theme_set(theme_bw(base_size = 12)) 

dr_df <- read.csv(r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\drvot sanitised data\drvotsanitised.csv)")
man_df <- read.csv(r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\manual sanitised data\manualsanitised.csv)")

head(dr_df)

ggplot(dr_df, aes(x = phone, y = vot_ms)) +
geom_boxplot()

ggplot(man_df, aes(x = phone, y = vot_ms)) +
geom_boxplot()


#####################
#
# T Tests for within speaker across 2 speakers
#
#####################
library(tidyverse)
inputcsv <- read.csv(r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\drvot sanitised data\drvotsanitised.csv)")
unpairedttestvalues <- filter(unpairedttestvalues, speaker == "VM25B")
speaker_canto_k <- unpairedttestvalues$vot_ms[unpairedttestvalues$phone == "k"]
speaker_canto_g <- unpairedttestvalues$vot_ms[unpairedttestvalues$phone == "g"]
speaker_eng_k <- unpairedttestvalues$vot_ms[unpairedttestvalues$phone == "K"]
speaker_eng_g <- unpairedttestvalues$vot_ms[unpairedttestvalues$phone == "G"]

length(speaker_canto_k)
length(speaker_canto_g)
length(speaker_eng_k)
length(speaker_eng_g)

k_ttest_result <- t.test(speaker_canto_k, speaker_eng_k, paired = FALSE)
g_ttest_result <- t.test(speaker_canto_g, speaker_eng_g, paired = FALSE)

'VM25B /k/ t-test results'
k_ttest_result
'VM25B /g/ t-test results'
g_ttest_result

speaker_canto_g <- NULL
speaker_canto_k <- NULL
speaker_eng_g <- NULL
speaker_eng_k <- NULL

unpairedttestvalues <- filter(inputcsv, speaker == "VM34A")
speaker_canto_k <- unpairedttestvalues$vot_ms[unpairedttestvalues$phone == "k"]
speaker_canto_g <- unpairedttestvalues$vot_ms[unpairedttestvalues$phone == "g"]
speaker_eng_k <- unpairedttestvalues$vot_ms[unpairedttestvalues$phone == "K"]
speaker_eng_g <- unpairedttestvalues$vot_ms[unpairedttestvalues$phone == "G"]

length(speaker_canto_k)
length(speaker_canto_g)
length(speaker_eng_k)
length(speaker_eng_g)

k_ttest_result <- t.test(speaker_canto_k, speaker_eng_k, paired = FALSE)
g_ttest_result <- t.test(speaker_canto_g, speaker_eng_g, paired = FALSE)

'VM34A /k/ t-test results'
k_ttest_result
'VM34A /g/ t-test results'
g_ttest_result

############################
#
# Used for making charts
#
############################
library(tidyverse)
theme_set(theme_bw(base_size = 12)) 
inputcsv <- read.csv(r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\drvot sanitised data\drvotsanitised.csv)")
unpairedttestvalues <- inputcsv %>%
    select(-speaker, -clip, -Source.Name, -language)

speaker_canto_k <- unpairedttestvalues[unpairedttestvalues$phone == "k",]
speaker_canto_g <- unpairedttestvalues[unpairedttestvalues$phone == "g",]
speaker_eng_k <- unpairedttestvalues[unpairedttestvalues$phone == "K",]
speaker_eng_g <- unpairedttestvalues[unpairedttestvalues$phone == "G",]


head(speaker_canto_k)

windows();
ggplot(speaker_canto_k, aes(x = vot_ms)) +
    geom_density() +
    ggtitle("Canto /k/")
