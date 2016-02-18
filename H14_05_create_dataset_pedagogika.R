data_all <- read.csv("./data/dataset_Pil1-filtered.csv", stringsAsFactors=FALSE)

data_ped <- data_all[data_all$CR_OBR == "AM - Pedagogika a školství", ]

uuu <- data_ped[ , c(1:3, 6, 8, 11, 17)]
data_ped <- data_ped[!duplicated(uuu), ]

write.csv(data_ped, file = "./data/data_ped.csv", row.names = FALSE)
