# Vytvoření popisků pro pilíř 1

l_Pil1 <- readWorksheetFromFile(paste("./xlsx_data/", URLs$Soubor[3], sep = ""),
                                sheet = "Tab3_Pil1", 
                                startRow = 4,
                                endRow = 5,
                                header = FALSE)

l_Pil1 <- as.data.frame(t(l_Pil1))
l_Pil1[ , 3] <- l_Pil1[ , 1]
l_Pil1[ , 1] <- NULL
names(l_Pil1) <- c("Kod", "Popisek")

write.csv(l_Pil1, file = "./h14_data_labels_Pil1.csv", row.names = FALSE)



# Vytvoření popisků pro pilíř 2

l_Pil2 <- readWorksheetFromFile(paste("./xlsx_data/", URLs$Soubor[3], sep = ""),
                                sheet = "Tab3_Pil2", 
                                startRow = 4,
                                endRow = 5,
                                header = FALSE)

l_Pil2 <- as.data.frame(t(l_Pil2))
l_Pil2[ , 3] <- l_Pil2[ , 1]
l_Pil2[ , 1] <- NULL
names(l_Pil2) <- c("Kod", "Popisek")

write.csv(l_Pil2, file = "./h14_data_labels_Pil2.csv", row.names = FALSE)



# Vytvoření popisků pro pilíř 3

l_Pil3 <- readWorksheetFromFile(paste("./xlsx_data/", URLs$Soubor[3], sep = ""),
                                sheet = "Tab3_Pil3", 
                                startRow = 4,
                                endRow = 5,
                                header = FALSE)

l_Pil3 <- as.data.frame(t(l_Pil3))
l_Pil3[ , 3] <- l_Pil3[ , 1]
l_Pil3[ , 1] <- NULL
names(l_Pil3) <- c("Kod", "Popisek")

write.csv(l_Pil3, file = "./h14_data_labels_Pil3.csv", row.names = FALSE)
