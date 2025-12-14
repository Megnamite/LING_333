#Remi Sinclaire 51278307

library(tidyverse)
drvot_df <- read.csv("drvotsanitised.csv")

#VF21C----
VF21C_df <- filter(drvot_df, speaker == 'VF21C')


VF21C_can_df <- filter(VF21C_df, language == 'C' & phone == 'k')
ggplot(VF21C_can_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot()
ggplot(VF21C_can_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF21C_can_df$vot_ms)


VF21C_eng_df <- filter(VF21C_df, language == 'E' & phone == 'k' | phone == "K")
ggplot(VF21C_eng_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot() 
ggplot(VF21C_eng_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF21C_eng_df$vot_ms)


t.test(VF21C_can_df$vot_ms, VF21C_eng_df$vot_ms)

#VF21D----
VF21D_df <- filter(drvot_df, speaker == 'VF21D')


VF21D_can_df <- filter(VF21D_df, language == 'C' & phone == 'k')
ggplot(VF21D_can_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot() 
ggplot(VF21D_can_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF21D_can_df$vot_ms)


VF21D_eng_df <- filter(VF21D_df, language == 'E' & phone == 'k' | phone == "K")
ggplot(VF21D_eng_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot() 
ggplot(VF21D_eng_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF21D_eng_df$vot_ms)


t.test(VF21D_can_df$vot_ms, VF21D_eng_df$vot_ms)

#VF22A----
VF22A_df <- filter(drvot_df, speaker == 'VF22A')


VF22A_can_df <- filter(VF22A_df, language == 'C' & phone == 'k')
ggplot(VF22A_can_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot()
ggplot(VF22A_can_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF22A_can_df$vot_ms)


VF22A_eng_df <- filter(VF22A_df, language == 'E' & phone == 'k' | phone == "K")
ggplot(VF22A_eng_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot()
ggplot(VF22A_eng_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF22A_eng_df$vot_ms)


wilcox.test(VF22A_can_df$vot_ms, VF22A_eng_df$vot_ms)
mean(VF22A_can_df$vot_ms)
mean(VF22A_eng_df$vot_ms)

#VF23B----
VF23B_df <- filter(drvot_df, speaker == 'VF23B')


VF23B_can_df <- filter(VF23B_df, language == 'C' & phone == 'k')
ggplot(VF23B_can_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot()
ggplot(VF23B_can_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF23B_can_df$vot_ms)


VF23B_eng_df <- filter(VF23B_df, language == 'E' & phone == 'k' | phone == "K")
ggplot(VF23B_eng_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot()
ggplot(VF23B_eng_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF23B_eng_df$vot_ms)


wilcox.test(VF23B_can_df$vot_ms, VF23B_eng_df$vot_ms)
mean(VF23B_can_df$vot_ms)
mean(VF23B_eng_df$vot_ms)

#VF23C----
VF23C_df <- filter(drvot_df, speaker == 'VF23C')


VF23C_can_df <- filter(VF23C_df, language == 'C' & phone == 'k')
ggplot(VF23C_can_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot()
ggplot(VF23C_can_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF23C_can_df$vot_ms)


VF23C_eng_df <- filter(VF23C_df, language == 'E' & phone == 'k' | phone == "K")
ggplot(VF23C_eng_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot()
ggplot(VF23C_eng_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF23C_eng_df$vot_ms)


wilcox.test(VF23C_can_df$vot_ms, VF23C_eng_df$vot_ms)
mean(VF23C_can_df$vot_ms)
mean(VF23C_eng_df$vot_ms)

#VF26A----
VF26A_df <- filter(drvot_df, speaker == 'VF26A')


VF26A_can_df <- filter(VF26A_df, language == 'C' & phone == 'k')
ggplot(VF26A_can_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot()
ggplot(VF26A_can_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF26A_can_df$vot_ms)


VF26A_eng_df <- filter(VF26A_df, language == 'E' & phone == 'k' | phone == "K")
ggplot(VF26A_eng_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot()
ggplot(VF26A_eng_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF26A_eng_df$vot_ms)


t.test(VF26A_can_df$vot_ms, VF26A_eng_df$vot_ms)

#VF27A----
VF27A_df <- filter(drvot_df, speaker == 'VF27A')


VF27A_can_df <- filter(VF27A_df, language == 'C' & phone == 'k')
ggplot(VF27A_can_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot()
ggplot(VF27A_can_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF27A_can_df$vot_ms)


VF27A_eng_df <- filter(VF27A_df, language == 'E' & phone == 'k' | phone == "K")
ggplot(VF27A_eng_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot()
ggplot(VF27A_eng_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF27A_eng_df$vot_ms)


wilcox.test(VF27A_can_df$vot_ms, VF27A_eng_df$vot_ms)
mean(VF27A_can_df$vot_ms)
mean(VF27A_eng_df$vot_ms)


#VF32A----
VF32A_df <- filter(drvot_df, speaker == 'VF32A')


VF32A_can_df <- filter(VF32A_df, language == 'C' & phone == 'k')
ggplot(VF32A_can_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot()
ggplot(VF32A_can_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF32A_can_df$vot_ms)


VF32A_eng_df <- filter(VF32A_df, language == 'E' & phone == 'k' | phone == "K")
ggplot(VF32A_eng_df, aes(x = phone, y = vot_ms)) +
  geom_boxplot()
ggplot(VF32A_eng_df, aes(x = vot_ms)) +
  geom_histogram(bins = 13, color = 'black', fill = 'lightblue')
shapiro.test(VF32A_eng_df$vot_ms)


t.test(VF32A_can_df$vot_ms, VF32A_eng_df$vot_ms)

