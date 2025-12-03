library(tidyverse)

theme_set(theme_bw(base_size = 12))

######## 
# Canto /k/ 

drvot <- read_csv("drvot_ttest_values.csv")
manual <- read_csv("manualsanioverlap.csv")

drvot 
manual

canto_k_dr <- filter(drvot, phone == 'k' & language == 'C')
canto_k_man <- filter(manual, phone == 'k' & language == 'C')

canto_k_dr 
canto_k_man

mean(canto_k_dr$vot_ms)
mean(canto_k_man$vot_ms)

canto_k_mean_diff <- canto_k_dr$vot_ms - canto_k_man$vot_ms
canto_k_mean_diff

shapiro.test(canto_k_mean_diff)

t.test(canto_k_dr$vot_ms, canto_k_man$vot_ms, paired = TRUE)


######## 
# Canto /g/ 

drvot <- read_csv("drvot_ttest_values.csv")
manual <- read_csv("manualsanioverlap.csv")

drvot 
manual

canto_g_dr <- filter(drvot, phone == 'g' & language == 'C')
canto_g_man <- filter(manual, phone == 'g' & language == 'C')

canto_g_dr 
canto_g_man

mean(canto_g_dr$vot_ms)
mean(canto_g_man$vot_ms)

canto_g_mean_diff <- canto_g_dr$vot_ms - canto_g_man$vot_ms
canto_g_mean_diff

shapiro.test(canto_g_mean_diff)

t.test(canto_g_dr$vot_ms, canto_g_man$vot_ms, paired = TRUE)


######## 
# Canto /gw/ 

drvot <- read_csv("drvot_ttest_values.csv")
manual <- read_csv("manualsanioverlap.csv")

drvot 
manual

canto_gw_dr <- filter(drvot, phone == 'gw' & language == 'C')
canto_gw_man <- filter(manual, phone == 'gw' & language == 'C')

canto_gw_dr 
canto_gw_man

mean(canto_gw_dr$vot_ms)
mean(canto_gw_man$vot_ms)

canto_gw_mean_diff <- canto_gw_dr$vot_ms - canto_gw_man$vot_ms
canto_gw_mean_diff

shapiro.test(canto_gw_mean_diff) # this gets an error cuz sample size must be higher than 3 

t.test(canto_gw_dr$vot_ms, canto_gw_man$vot_ms, paired = TRUE)


######## 
# Canto /kw/ 

drvot <- read_csv("drvot_ttest_values.csv")
manual <- read_csv("manualsanioverlap.csv")

drvot 
manual

canto_kw_dr <- filter(drvot, phone == 'kw' & language == 'C')
canto_kw_man <- filter(manual, phone == 'kw' & language == 'C')

canto_kw_dr 
canto_kw_man

mean(canto_kw_dr$vot_ms)
mean(canto_kw_man$vot_ms)

canto_kw_mean_diff <- canto_kw_dr$vot_ms - canto_kw_man$vot_ms
canto_kw_mean_diff

shapiro.test(canto_kw_mean_diff) # this gets an error cuz sample size must be higher than 3 

t.test(canto_kw_dr$vot_ms, canto_kw_man$vot_ms, paired = TRUE) # straight up doesn't run the test 



######## 
# English /k/ 

drvot <- read_csv("drvot_ttest_values.csv")
manual <- read_csv("manualsanioverlap.csv")

drvot 
manual

eng_k_dr <- filter(drvot, phone == 'K' & language == 'E')
eng_k_man <- filter(manual, phone == 'K' & language == 'E')

eng_k_dr 
eng_k_man

mean(eng_k_dr$vot_ms)
mean(eng_k_man$vot_ms)

eng_k_mean_diff <- eng_k_dr$vot_ms - eng_k_man$vot_ms
eng_k_mean_diff

shapiro.test(eng_k_mean_diff)

t.test(eng_k_dr$vot_ms, eng_k_man$vot_ms, paired = TRUE)



######## 
# English /g/ 

drvot <- read_csv("drvot_ttest_values.csv")
manual <- read_csv("manualsanioverlap.csv")

drvot 
manual

eng_g_dr <- filter(drvot, phone == 'G' & language == 'E')
eng_g_man <- filter(manual, phone == 'G' & language == 'E')

eng_g_dr 
eng_g_man

mean(eng_g_dr$vot_ms)
mean(eng_g_man$vot_ms)

eng_g_mean_diff <- eng_g_dr$vot_ms - eng_g_man$vot_ms
eng_g_mean_diff

shapiro.test(eng_g_mean_diff)

t.test(eng_g_dr$vot_ms, eng_g_man$vot_ms, paired = TRUE)





























