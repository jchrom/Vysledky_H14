# Načtení dílčích souborů do jednoho datasetu

library(XLConnect)

URLs <- read.csv("./data/files_URLs.csv", stringsAsFactors=FALSE)

data.Pil1 <- readWorksheetFromFile(paste("./xlsx_files/", 
                                         URLs$Soubor[1], sep = ""), 
                                  sheet = "Tab3_Pil1", 
                                  startRow = 5,
                                  header = TRUE)

for(i in 320:length(URLs$URL)) {  # celkem 546 - může házet chybu u i = 319
    
    rawData <- readWorksheetFromFile(paste("./xlsx_files/",
                                           URLs$Soubor[i], sep = ""),
                                     sheet = "Tab3_Pil1", 
                                     startRow = 5,
                                     header = TRUE)
    
    data.Pil1 <- rbind(data.Pil1, rawData)
    
    print(paste(i, " - Pil1 = OK", sep = ""))
    
    
}

write.csv(data.Pil1, file = "./data/dataset_Pil1-w319.csv", row.names = FALSE)


# Ještě je třeba vyřešit pro Pilíř 2 a 3


