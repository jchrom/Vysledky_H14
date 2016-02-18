# Načtení dílčích souborů do jednoho datasetu

library(XLConnect)

URLs <- read.csv("./data/files_URLs.csv", stringsAsFactors=FALSE)

data.all <- readWorksheetFromFile(paste("./xlsx_data/", URLs$Soubor[1], sep = ""), 
                                  sheet = "Tab3_Pil1", 
                                  startRow = 5,
                                  header = TRUE)


for(i in 320:546) {  # celkem 546
    
    rawData <- readWorksheetFromFile(paste("./xlsx_data/", URLs$Soubor[i], sep = ""),
                                     sheet = "Tab3_Pil1", 
                                     startRow = 5,
                                     header = TRUE)
    
    data.all <- rbind(data.all, rawData)
    
    print(paste(i, " - Hotovo", sep = ""))
    
    # zatím háže chybu např. u 400, 319, atd.
    
}

write.csv(data.all, file = "./hodnoceni_14_data_all_bez_319.csv", row.names = FALSE)

# Je třeba provést u všech pilířů !!!