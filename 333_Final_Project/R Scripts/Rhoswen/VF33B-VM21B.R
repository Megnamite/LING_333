
# 2025-12-01 
# Significance testing for within-speaker Canto k and English K 
# Rhoswen The 

#--------------- 

# COMPARING ENG /k/ AND CANTO JYUTPING "k" 


library(tidyverse)

######## 
# VF33B  

drvot <- read_csv(file.choose())

drvot 

vf33b_canto_k <- filter(drvot, speaker == 'VF33B' & phone == 'k' & language == 'C')
vf33b_canto_k 
shapiro.test(vf33b_canto_k$vot_ms)

vf33b_eng_k <- filter(drvot, speaker == 'VF33B' & phone == 'K' & language == 'E')
vf33b_eng_k
shapiro.test(vf33b_eng_k$vot_ms) # came out non-normal 


t.test(vf33b_canto_k$vot_ms, vf33b_eng_k$vot_ms) # not this test 

format(8.455e-05, scientific = FALSE)

wilcox.test(vf33b_canto_k$vot_ms, vf33b_eng_k$vot_ms) # <-- this test 
    # p-value = 5.28e-05 -------------------------------------------------------------> PASS 




######## 
# VM19A  

drvot 

vm19a_canto_k <- filter(drvot, speaker == 'VM19A' & phone == 'k' & language == 'C')
vm19a_canto_k 
shapiro.test(vm19a_canto_k$vot_ms)

vm19a_eng_k <- filter(drvot, speaker == 'VM19A' & phone == 'K' & language == 'E')
vm19a_eng_k
shapiro.test(vm19a_eng_k$vot_ms)


t.test(vm19a_canto_k$vot_ms, vm19a_eng_k$vot_ms)
  # p-value = 0.4067 -----------------------------------------------------------------> FAIL 





######## 
# VM19B  

drvot 

vm19b_canto_k <- filter(drvot, speaker == 'VM19B' & phone == 'k' & language == 'C')
vm19b_canto_k 
shapiro.test(vm19b_canto_k$vot_ms) # came out non-normal 

vm19b_eng_k <- filter(drvot, speaker == 'VM19B' & phone == 'K' & language == 'E')
vm19b_eng_k
shapiro.test(vm19b_eng_k$vot_ms)


t.test(vm19b_canto_k$vot_ms, vm19b_eng_k$vot_ms) # not this test 

wilcox.test(vm19b_canto_k$vot_ms, vm19b_eng_k$vot_ms) # this test 
  # p-value = 0.7603 -----------------------------------------------------------------> FAIL 
  # warning: cannot compute exact p-value with ties 





######## 
# VM19C 

drvot <- read_csv("drvotsanitised.csv")

drvot 

vm19c_canto_k <- filter(drvot, speaker == 'VM19C' & phone == 'k' & language == 'C')
vm19c_canto_k 
shapiro.test(vm19c_canto_k$vot_ms)

vm19c_eng_k <- filter(drvot, speaker == 'VM19C' & phone == 'K' & language == 'E')
vm19c_eng_k
shapiro.test(vm19c_eng_k$vot_ms)


t.test(vm19c_canto_k$vot_ms, vm19c_eng_k$vot_ms)
  # p-value = 0.493 ------------------------------------------------------------------> FAIL 





######## 
# VM19D 

drvot <- read_csv("drvotsanitised.csv")

drvot 

vm19d_canto_k <- filter(drvot, speaker == 'VM19D' & phone == 'k' & language == 'C')
vm19d_canto_k 
shapiro.test(vm19d_canto_k$vot_ms)

vm19d_eng_k <- filter(drvot, speaker == 'VM19D' & phone == 'K' & language == 'E')
vm19d_eng_k
shapiro.test(vm19d_eng_k$vot_ms)


t.test(vm19d_canto_k$vot_ms, vm19d_eng_k$vot_ms)
  # p-value 0.08578 ------------------------------------------------------------------> FAIL 





######## 
# VM20B

drvot <- read_csv("drvotsanitised.csv")

drvot 

vm20b_canto_k <- filter(drvot, speaker == 'VM20B' & phone == 'k' & language == 'C')
vm20b_canto_k 
shapiro.test(vm20b_canto_k$vot_ms)

vm20b_eng_k <- filter(drvot, speaker == 'VM20B' & phone == 'K' & language == 'E')
vm20b_eng_k
shapiro.test(vm20b_eng_k$vot_ms)


t.test(vm20b_canto_k$vot_ms, vm20b_eng_k$vot_ms)
  # p-value = 0.2516 ------------------------------------------------------------------> FAIL 




######## 
# VM21A

drvot <- read_csv("drvotsanitised.csv")

drvot 

vm21a_canto_k <- filter(drvot, speaker == 'VM21A' & phone == 'k' & language == 'C')
vm21a_canto_k 
shapiro.test(vm21a_canto_k$vot_ms)

vm21a_eng_k <- filter(drvot, speaker == 'VM21A' & phone == 'K' & language == 'E')
vm21a_eng_k
shapiro.test(vm21a_eng_k$vot_ms)


t.test(vm21a_canto_k$vot_ms, vm21a_eng_k$vot_ms)
  # p-value = 0.2791 -------------------------------------------------------------------> FAIL 





######## 
# VM21B

drvot <- read_csv("drvotsanitised.csv")

drvot 

vm21b_canto_k <- filter(drvot, speaker == 'VM21B' & phone == 'k' & language == 'C')
vm21b_canto_k 
shapiro.test(vm21b_canto_k$vot_ms)

vm21b_eng_k <- filter(drvot, speaker == 'VM21B' & phone == 'K' & language == 'E')
vm21b_eng_k
shapiro.test(vm21b_eng_k$vot_ms)


t.test(vm21b_canto_k$vot_ms, vm21b_eng_k$vot_ms)
  # p-value = 0.6751 -------------------------------------------------------------------> FAIL 




