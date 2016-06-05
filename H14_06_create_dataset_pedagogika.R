data_all <- read.csv("./data/dataset_Pil1-filtered.csv", stringsAsFactors=FALSE)
data_ped <- data_all[data_all$CR_OBR == "AM - Pedagogika a školství", ]
rm(data_all)

# Zbavení se duplikací podle vnitřního ID
data_ped <- data_ped[!duplicated(data_ped$VYSNID), ]

# Uložení hotového "čistého" souboru pro pedagogiku
write.csv(data_ped, file = "./data_ped/data_ped.csv", row.names = FALSE)
