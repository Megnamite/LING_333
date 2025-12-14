#Title: VF19A-VF21B
#Details: Shapiro-Wilk, Welch unpaired t-test, Wilcoxon rank sum, barplot
#Last updated: 2025-12-14
#Author: Yerin Hur

library(tidyverse)

drvot_df <- read.csv("drvotsanitised.csv")
drvot_df

#----------VF19A----------

VF19A_df <- filter(drvot_df, speaker == "VF19A")
VF19A_df

VF19A_k_df <- filter(VF19A_df, phone == "k" | phone == "K")
VF19A_k_df

ggplot(VF19A_k_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot() +
  labs(title = "VF19A")

ggsave('VF19A_phones.png', h = 5, w = 7, units = 'in')

VF19A_Canto_k_df <- filter(drvot_df, speaker == "VF19A" & language == "C" & phone == "k")
VF19A_Canto_k_df

VF19A_Eng_K_df <- filter(drvot_df, speaker == "VF19A" & language == "E" & phone == "K")
VF19A_Eng_K_df

ggplot(VF19A_Canto_k_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF19A Cantonese k")

ggsave('VF19A_Canto.png', h = 5, w = 7, units = 'in')

mean(VF19A_Canto_k_df$vot_ms)

shapiro.test(VF19A_Canto_k_df$vot_ms)

ggplot(VF19A_Eng_K_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF19A English K")

ggsave('VF19A_Eng.png', h = 5, w = 7, units = 'in')

mean(VF19A_Eng_K_df$vot_ms)

shapiro.test(VF19A_Eng_K_df$vot_ms)

diff_19a <- VF19A_Canto_k_df$vot_ms - VF19A_Eng_K_df$vot_ms

diff_19a

shapiro.test(diff_19a)

#Tried paired t-test since the speakers were the same for both datasets
#Got "Error in complete.cases(x, y) : not all arguments have the same length"
#Pivot to unpaired t-test

t.test(VF19A_Canto_k_df$vot_ms, VF19A_Eng_K_df$vot_ms)



#----------VF19B----------

VF19B_df <- filter(drvot_df, speaker == "VF19B")
VF19B_df

VF19B_k_df <- filter(VF19B_df, phone == "k" | phone == "K")
VF19B_k_df

ggplot(VF19B_k_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot() +
  labs(title = "VF19B")

ggsave('VF19B_phones.png', h = 5, w = 7, units = 'in')

VF19B_Canto_k_df <- filter(drvot_df, speaker == "VF19B" & language == "C" & phone == "k")
VF19B_Canto_k_df

VF19B_Eng_K_df <- filter(drvot_df, speaker == "VF19B" & language == "E" & phone == "K")
VF19B_Eng_K_df

ggplot(VF19B_Canto_k_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF19B Cantonese k")

ggsave('VF19B_Canto.png', h = 5, w = 7, units = 'in')

mean(VF19B_Canto_k_df$vot_ms)

shapiro.test(VF19B_Canto_k_df$vot_ms)

ggplot(VF19B_Eng_K_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF19B English K")

ggsave('VF19B_Eng.png', h = 5, w = 7, units = 'in')

mean(VF19B_Eng_K_df$vot_ms)

shapiro.test(VF19B_Eng_K_df$vot_ms)

t.test(VF19B_Canto_k_df$vot_ms, VF19B_Eng_K_df$vot_ms)



#----------VF19C----------

VF19C_df <- filter(drvot_df, speaker == "VF19C")
VF19C_df

VF19C_k_df <- filter(VF19C_df, phone == "k" | phone == "K")
VF19C_k_df

ggplot(VF19C_k_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot() +
  labs(title = "VF19C")

ggsave('VF19C_phones.png', h = 5, w = 7, units = 'in')

VF19C_Canto_k_df <- filter(drvot_df, speaker == "VF19C" & language == "C" & phone == "k")
VF19C_Canto_k_df

VF19C_Eng_K_df <- filter(drvot_df, speaker == "VF19C" & language == "E" & phone == "K")
VF19C_Eng_K_df

ggplot(VF19C_Canto_k_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF19C Cantonese k")

ggsave('VF19C_Canto.png', h = 5, w = 7, units = 'in')

mean(VF19C_Canto_k_df$vot_ms)

shapiro.test(VF19C_Canto_k_df$vot_ms)

ggplot(VF19C_Eng_K_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF19C English K")

ggsave('VF19C_Eng.png', h = 5, w = 7, units = 'in')

mean(VF19C_Eng_K_df$vot_ms)

shapiro.test(VF19C_Eng_K_df$vot_ms)

#The vot_ms for VF19C_Eng_K_df is not normally distributed
#Wilcoxon test for non-parametric alternative

wilcox.test(VF19C_Canto_k_df$vot_ms, VF19C_Eng_K_df$vot_ms)



#----------VF19D----------

VF19D_df <- filter(drvot_df, speaker == "VF19D")
VF19D_df

VF19D_k_df <- filter(VF19D_df, phone == "k" | phone == "K")
VF19D_k_df

ggplot(VF19D_k_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot() +
  labs(title = "VF19D")

ggsave('VF19D_phones.png', h = 5, w = 7, units = 'in')

VF19D_Canto_k_df <- filter(drvot_df, speaker == "VF19D" & language == "C" & phone == "k")
VF19D_Canto_k_df

VF19D_Eng_K_df <- filter(drvot_df, speaker == "VF19D" & language == "E" & phone == "K")
VF19D_Eng_K_df

ggplot(VF19D_Canto_k_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF19D Cantonese k")

ggsave('VF19D_Canto.png', h = 5, w = 7, units = 'in')

mean(VF19D_Canto_k_df$vot_ms)

shapiro.test(VF19D_Canto_k_df$vot_ms)

ggplot(VF19D_Eng_K_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF19D English K")

ggsave('VF19D_Eng.png', h = 5, w = 7, units = 'in')

mean(VF19D_Eng_K_df$vot_ms)

shapiro.test(VF19D_Eng_K_df$vot_ms)

t.test(VF19D_Canto_k_df$vot_ms, VF19D_Eng_K_df$vot_ms)



#----------VF20A----------

VF20A_df <- filter(drvot_df, speaker == "VF20A")
VF20A_df

VF20A_k_df <- filter(VF20A_df, phone == "k" | phone == "K")
VF20A_k_df

ggplot(VF20A_k_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot() +
  labs(title = "VF20A")

ggsave('VF20A_phones.png', h = 5, w = 7, units = 'in')

VF20A_Canto_k_df <- filter(drvot_df, speaker == "VF20A" & language == "C" & phone == "k")
VF20A_Canto_k_df

VF20A_Eng_K_df <- filter(drvot_df, speaker == "VF20A" & language == "E" & phone == "K")
VF20A_Eng_K_df

ggplot(VF20A_Canto_k_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF20A Cantonese k")

ggsave('VF20A_Canto.png', h = 5, w = 7, units = 'in')

mean(VF20A_Canto_k_df$vot_ms)

shapiro.test(VF20A_Canto_k_df$vot_ms)

ggplot(VF20A_Eng_K_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF20A English K")

ggsave('VF20A_Eng.png', h = 5, w = 7, units = 'in')

mean(VF20A_Eng_K_df$vot_ms)

shapiro.test(VF20A_Eng_K_df$vot_ms)

#The vot_ms for VF20A_Eng_K_df is not normally distributed
#Wilcoxon test for non-parametric alternative

wilcox.test(VF20A_Canto_k_df$vot_ms, VF20A_Eng_K_df$vot_ms)



#----------VF20B----------

VF20B_df <- filter(drvot_df, speaker == "VF20B")
VF20B_df

VF20B_k_df <- filter(VF20B_df, phone == "k" | phone == "K")
VF20B_k_df

ggplot(VF20B_k_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot() +
  labs(title = "VF20B")

ggsave('VF20B_phones.png', h = 5, w = 7, units = 'in')

VF20B_Canto_k_df <- filter(drvot_df, speaker == "VF20B" & language == "C" & phone == "k")
VF20B_Canto_k_df

VF20B_Eng_K_df <- filter(drvot_df, speaker == "VF20B" & language == "E" & phone == "K")
VF20B_Eng_K_df

ggplot(VF20B_Canto_k_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF20B Cantonese k")

ggsave('VF20B_Canto.png', h = 5, w = 7, units = 'in')

mean(VF20B_Canto_k_df$vot_ms)

shapiro.test(VF20B_Canto_k_df$vot_ms)

ggplot(VF20B_Eng_K_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF20B English K")

ggsave('VF20B_Eng.png', h = 5, w = 7, units = 'in')

mean(VF20B_Eng_K_df$vot_ms)

shapiro.test(VF20B_Eng_K_df$vot_ms)

#The vot_ms for VF20B_Eng_K_df is not normally distributed
#Wilcoxon test for non-parametric alternative

wilcox.test(VF20B_Canto_k_df$vot_ms, VF20B_Eng_K_df$vot_ms)



#----------VF21A----------

VF21A_df <- filter(drvot_df, speaker == "VF21A")
VF21A_df

VF21A_k_df <- filter(VF21A_df, phone == "k" | phone == "K")
VF21A_k_df

ggplot(VF21A_k_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot() +
  labs(title = "VF21A")

ggsave('VF21A_phones.png', h = 5, w = 7, units = 'in')

VF21A_Canto_k_df <- filter(drvot_df, speaker == "VF21A" & language == "C" & phone == "k")
VF21A_Canto_k_df

VF21A_Eng_K_df <- filter(drvot_df, speaker == "VF21A" & language == "E" & phone == "K")
VF21A_Eng_K_df

ggplot(VF21A_Canto_k_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF21A Cantonese k")

ggsave('VF21A_Canto.png', h = 5, w = 7, units = 'in')

mean(VF21A_Canto_k_df$vot_ms)

shapiro.test(VF21A_Canto_k_df$vot_ms)

ggplot(VF21A_Eng_K_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF21A English K")

ggsave('VF21A_Eng.png', h = 5, w = 7, units = 'in')

mean(VF21A_Eng_K_df$vot_ms)

shapiro.test(VF21A_Eng_K_df$vot_ms)

t.test(VF21A_Canto_k_df$vot_ms, VF21A_Eng_K_df$vot_ms)



#----------VF21B----------

VF21B_df <- filter(drvot_df, speaker == "VF21B")
VF21B_df

VF21B_k_df <- filter(VF21B_df, phone == "k" | phone == "K")
VF21B_k_df

ggplot(VF21B_k_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot() +
  labs(title = "VF21B")

ggsave('VF21B_phones.png', h = 5, w = 7, units = 'in')

VF21B_Canto_k_df <- filter(drvot_df, speaker == "VF21B" & language == "C" & phone == "k")
VF21B_Canto_k_df

VF21B_Eng_K_df <- filter(drvot_df, speaker == "VF21B" & language == "E" & phone == "K")
VF21B_Eng_K_df

ggplot(VF21B_Canto_k_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF21B Cantonese k")

ggsave('VF21B_Canto.png', h = 5, w = 7, units = 'in')

mean(VF21B_Canto_k_df$vot_ms)

shapiro.test(VF21B_Canto_k_df$vot_ms)

ggplot(VF21B_Eng_K_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue') +
  labs(title = "VF21B English K")

ggsave('VF21B_Eng.png', h = 5, w = 7, units = 'in')

mean(VF21B_Eng_K_df$vot_ms)

shapiro.test(VF21B_Eng_K_df$vot_ms)

t.test(VF21B_Canto_k_df$vot_ms, VF21B_Eng_K_df$vot_ms)


#-----Barplots for all within-speaker significant differences

sigdiff <- c(10, 24)

barplot(sigdiff, 
        main = "Within-Speaker Cantonese k vs. English K", 
        xlab = "Significant Difference", 
        ylab = "Number of Speakers",
        names.arg = c("Yes (10)", "No (24)"),
        ylim=range(pretty(c(0,max(sigdiff)))),
        col = c("#CAEEC2", "#FCBABA")
        )

ggsave('SigDiff_YesNo.png', h = 5, w = 7, units = 'in')
