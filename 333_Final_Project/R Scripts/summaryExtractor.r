library(tidyverse)
pathToCSV <- "C:\\Users\\Maria\\Documents\\UNI\\Visual Studio UBC Workspace\\LING333GithubClone\\LING_333\\333_Final_Project\\data\\SpiCE_DrVot_Output_CSV.csv"
vot_data <- read.csv(pathToCSV)

can_k <- c()
can_g <- c()
can_kw <- c()
can_gw <- c()
eng_k <- c()
eng_g <- c()

cleaneddata <- vot_data%>%
    filter(vot_ms >= 10)

cleaneddata <- cleaneddata %>%
  group_by(phone) %>%
  filter(between(vot_ms, mean(vot_ms) - 2 * sd(vot_ms), mean(vot_ms) + 2 * sd(vot_ms))) %>%
  ungroup()

can_k  <- cleaneddata$vot_ms[cleaneddata$phone == "k"]
can_g  <- cleaneddata$vot_ms[cleaneddata$phone == "g"]
can_kw <- cleaneddata$vot_ms[cleaneddata$phone == "kw"]
can_gw <- cleaneddata$vot_ms[cleaneddata$phone == "gw"]
eng_k  <- cleaneddata$vot_ms[cleaneddata$phone == "K"]
eng_g  <- cleaneddata$vot_ms[cleaneddata$phone == "G"]

can_g
can_kw
can_gw
eng_k
eng_g

write.csv(can_k, file = "can_k.csv", row.names= FALSE)
write.csv(can_kw, file = "can_kw.csv", row.names= FALSE)
write.csv(can_gw, file = "can_gw.csv", row.names= FALSE)
write.csv(can_g, file = "can_g.csv", row.names= FALSE)
write.csv(eng_g, file = "eng_g.csv", row.names= FALSE)
write.csv(eng_k, file = "eng_k.csv", row.names= FALSE)