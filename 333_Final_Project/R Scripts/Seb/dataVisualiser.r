# Author: Sebastiano
# Date last updated: Dec 14th, 2025
# Description: Used for creating graphics for data analysis and presentation

library(tidyverse)
library(patchwork)
#citation()
#citation("tidyverse")
#citation("patchwork")
#citation('ggplot2')
#citation('rstatix')
citation('car')
theme_set(theme_bw(base_size = 12)) 

dr_df <- read.csv(r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\drvot sanitised data\drvotsanitised.csv)")
#man_df <- read.csv(r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\manual sanitised data\manualsanitised.csv)")
range(dr_df$vot_ms[dr_df$language == "E"])
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
ggplot(speaker_eng_kw, aes(x = vot_ms)) 
    geom_density() +
    ggtitle("Canto /kw/")


#####################
# Patchwork multigraph boxplot
######################
library(tidyverse)
library(patchwork)

femalespeakerlist <- c("VF19A", "VF19B", "VF19C", "VF19D", "VF20A", "VF20B", "VF21A", "VF21B", "VF21C", "VF21D", "VF22A", "VF23B", "VF23C", "VF26A", "VF27A", "VF32A", "VF33B")
malespeakerlist <- c("VM19A", "VM19B", "VM19C", "VM19D", "VM20B", "VM21A", "VM21B", "VM21C", "VM21D", "VM21E", "VM22A", "VM22B", "VM23A", "VM24A", "VM25A", "VM25B", "VM34A")
femaleimagelist <- vector("list", length(femalespeakerlist))
maleimagelist <- vector("list", length(malespeakerlist))
phone_order <- c("K", "G", "k", "kw", "g", "gw")
inputcsv <- read.csv(r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\drvot sanitised data\drvotsanitised.csv)")
inputcsv$phone <- factor(inputcsv$phone, levels = phone_order)
for(i in seq_along(femalespeakerlist)){
    speaker <- femalespeakerlist[i]
    speaker2 <- malespeakerlist[i]
    p <- ggplot(inputcsv[inputcsv$speaker == speaker,],
      aes(x=phone, y=vot_ms)) +
      geom_boxplot() +
      coord_flip() +
      ggtitle(speaker)
    femaleimagelist[[i]] <- p
    g <- ggplot(inputcsv[inputcsv$speaker == speaker2,],
      aes(x=phone, y=vot_ms)) +
      geom_boxplot() +
      coord_flip() +
      ggtitle(speaker2)

    maleimagelist[[i]] <- g
}

windows();
  wrap_plots(femaleimagelist)
  wrap_plots(maleimagelist)

windows();
newdf <- filter(inputcsv, phone == "k" | phone == "K")
ggplot(newdf, aes(x = speaker, 
                  y = vot_ms, 
                  colour = speaker, 
                  shape = language)) +
  geom_point(size = 2, alpha = 0.7, stroke = 1.5) +
  scale_shape_manual(
    values = c(E = 16, C = 4)  # 16 = dot, 4 = cross
  ) +
  labs(
    x = "Speaker",
    y = "VOT (ms)",
    shape = "Language",
    colour = "Speaker"
  ) +
  theme_bw() +
  theme(
    legend.position = "right",
    axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)
  )