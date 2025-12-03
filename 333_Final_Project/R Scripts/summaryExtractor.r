library(tidyverse)
pathToCSVA <- r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\manual presanitise with clips.csv)"
pathToCSV <- r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\DrVot_Output_presanitise.csv)"
manual_data <- read.csv(pathToCSVA)
vot_data <- read.csv(pathToCSV)

votcleaneddata <- vot_data%>%
    filter(vot_ms >= 10)

votcleaneddata <- votcleaneddata %>%
  group_by(phone) %>%
  filter(between(vot_ms, mean(vot_ms) - 2 * sd(vot_ms), mean(vot_ms) + 2 * sd(vot_ms))) %>%
  ungroup()

head(votcleaneddata)
head(manualcleaneddata)

manualcleaneddata <- read.csv(r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\manual sanitised data\manualsanitisedwithclips.csv)")

mat = matrix(ncol = 6, nrow = 0)
df = data.frame(mat)
for (x in seq_len(nrow(votcleaneddata))){
  for (n in seq_len(nrow(manualcleaneddata))){
    if (votcleaneddata$speaker[x] == manualcleaneddata$speaker[n] 
    && votcleaneddata$language[x] == manualcleaneddata$language[n] 
    && votcleaneddata$clip[x] == manualcleaneddata$clip[n] 
    && votcleaneddata$phone[x] == manualcleaneddata$phone[n]){
      df = rbind(df, votcleaneddata[x, ])
    }
  }
}
head(df)
write.csv(df, file="tester.csv", row.names=FALSE)

df2 = data.frame(mat)
drvotvalues <- read.csv(r"(D:\UBC Coding Environment\VIsual Studio\LING_333-1\333_Final_Project\data\drvot sanitised data\drvot_ttest_values.csv)")

for (x in seq_len(nrow(manualcleaneddata))){
  for (n in seq_len(nrow(drvotvalues))){
    if (manualcleaneddata$speaker[x] == drvotvalues$speaker[n] 
    && manualcleaneddata$language[x] == drvotvalues$language[n] 
    && manualcleaneddata$clip[x] == drvotvalues$clip[n] 
    && manualcleaneddata$phone[x] == drvotvalues$phone[n]){
      df2 = rbind(df, drvotvalues[x, ])
    }
  }
}
head(df2)
write.csv(df2, file="manualsanioverlap.csv", row.names=FALSE)

can_k  <- cleaneddata$vot_ms[cleaneddata$phone == "k"]
can_g  <- cleaneddata$vot_ms[cleaneddata$phone == "g"]
can_kw <- cleaneddata$vot_ms[cleaneddata$phone == "kw"]
can_gw <- cleaneddata$vot_ms[cleaneddata$phone == "gw"]
eng_k  <- cleaneddata$vot_ms[cleaneddata$phone == "K"]
eng_g  <- cleaneddata$vot_ms[cleaneddata$phone == "G"]

write.csv(cleaneddata, file= "manualsanitised.csv", row.names=FALSE)
write.csv(can_k, file = "can_k.csv", row.names= FALSE)
write.csv(can_kw, file = "can_kw.csv", row.names= FALSE)
write.csv(can_gw, file = "can_gw.csv", row.names= FALSE)
write.csv(can_g, file = "can_g.csv", row.names= FALSE)
write.csv(eng_g, file = "eng_g.csv", row.names= FALSE)
write.csv(eng_k, file = "eng_k.csv", row.names= FALSE)