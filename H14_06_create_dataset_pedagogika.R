data_all <- read.csv("./data/dataset_Pil1-filtered.csv", stringsAsFactors=FALSE)
data_ped <- data_all[data_all$CR_OBR == "AM - Pedagogika a školství", ]
rm(data_all)

# Je třeba vyřešit duplicity na výzkumných organizacích a u autorů publikací
# - AUTOŘI: Stává se, že u též publikace jsou uvádění různé kombinace autořů.
#           Nejjednodušší by bylo vzít prostě ten nejdelší řetězec autorů.
#           Asi by však nemělo vadit, prostě všechny řetězce autorů spojit.
# - VO: Asi nejlépe vyřešit tak, že se jako hlavní VO uvede ta, která má
#       největší podíl bodů na výsledku. Co v případě stejného podílu?



# Seřazení podle podílu bodů (duplicated pak zachová jen první výskyt)
data_ped <- data_ped[order(data_ped$VYSNID, data_ped$VYSBOD, -data_ped$VYSPDL), ]

# Zbavení se duplikací podle vnitřního ID
data_ped <- data_ped[!duplicated(data_ped$VYSNID), ]

# Uložení hotového "čistého" souboru pro pedagogiku
write.csv(data_ped, file = "./data_ped/data_ped.csv", row.names = FALSE)

