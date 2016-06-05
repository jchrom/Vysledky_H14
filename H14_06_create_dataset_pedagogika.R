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




# Je třeba provést základní čištění dat:
# - Opravit časopisy alespoň v kategriích: Jimp, Jsc, Jneimp, Jrec
# - Opravit nakladatele (sloupec NAKNAZ)

j_opravy <- read.csv("./data_ped/j_opravy_nazvu.csv", stringsAsFactors=FALSE)
data_ped$DOKNAZPRI <- tolower(data_ped$DOKNAZPRI)

for (i in 1:nrow(data_ped)){
    for (j in 1:nrow(j_opravy)){
        if (data_ped$DOKNAZPRI[i] == j_opravy$nazev_k_oprave[j]) {
            
            data_ped$DOKNAZPRI[i] <- j_opravy$spravny_nazev[j]
        
        }
    }
}


# Uložení hotového "čistého" souboru pro pedagogiku
write.csv(data_ped, file = "./data_ped/data_ped.csv", row.names = FALSE)



