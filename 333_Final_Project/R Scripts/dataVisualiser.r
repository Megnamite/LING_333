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
unpairedttestvalues <- filter(inputcsv, speaker == "VM25B")
speaker_canto_k <- unpairedttestvalues$vot_ms[unpairedttestvalues$phone == "k"]
speaker_canto_g <- unpairedttestvalues$vot_ms[unpairedttestvalues$phone == "g"]
speaker_eng_k <- unpairedttestvalues$vot_ms[unpairedttestvalues$phone == "K"]
speaker_eng_g <- unpairedttestvalues$vot_ms[unpairedttestvalues$phone == "G"]

shapiro.test(speaker_canto_g)
shapiro.test(speaker_canto_k)
shapiro.test(speaker_eng_g)
shapiro.test(speaker_eng_k)

cank = unpairedttestvalues[unpairedttestvalues$phone == "k",]
cang = unpairedttestvalues[unpairedttestvalues$phone == "g",]
engk = unpairedttestvalues[unpairedttestvalues$phone == "K",]
engg = unpairedttestvalues[unpairedttestvalues$phone == "G",]

windows();
ggplot(cank, aes(x = vot_ms)) +
    geom_density() +
    ggtitle("Canto /k/")
windows();
ggplot(cang, aes(x = vot_ms)) +
    geom_density() +
    ggtitle("speaker_canto_g")
windows();
ggplot(engk, aes(x = vot_ms)) +
    geom_density() +
    ggtitle("speaker_eng_k")
windows();
ggplot(engg, aes(x = vot_ms)) +
    geom_density() +
    ggtitle("speaker_eng_g")

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

shapiro.test(speaker_canto_g)
shapiro.test(speaker_canto_k)
shapiro.test(speaker_eng_g)
shapiro.test(speaker_eng_k)

cank = unpairedttestvalues[unpairedttestvalues$phone == "k",]
cang = unpairedttestvalues[unpairedttestvalues$phone == "g",]
engk = unpairedttestvalues[unpairedttestvalues$phone == "K",]
engg = unpairedttestvalues[unpairedttestvalues$phone == "G",]

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
speaker_eng_kw <- unpairedttestvalues[unpairedttestvalues$phone == "kw",]


windows();
ggplot(speaker_eng_kw, aes(x = vot_ms)) +
    geom_density() +
    ggtitle("Canto /kw/")
