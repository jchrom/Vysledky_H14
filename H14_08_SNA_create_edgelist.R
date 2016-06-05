library(stringr)
library(stringi)
library(caTools)
library(plyr)


raw_data <- read.csv("./data_ped/data_ped.csv", stringsAsFactors=FALSE)
raw_data <- as.data.frame(raw_data[ , 4])

# Odstranit mezery
raw_data <- as.data.frame(stri_replace_all_charclass(raw_data[ , 1],
                                                     "\\p{WHITE_SPACE}", ""))
# Vytáhnout jen ID a doplnit NAs
numeric_data <- str_extract_all(raw_data[ , 1], "[0-9]+", simplify = TRUE)
numeric_data[numeric_data == ""] <- NA

# Předělat to vše do dvou sloupců ID
pocet_cisel <- rowSums(!is.na(numeric_data))
edgelist <- numeric_data[pocet_cisel == 2, 1:2]
tri_plus <- numeric_data[pocet_cisel >= 3, ]

for(i in 1:nrow(tri_plus)) {

   temp_data <- combs(tri_plus[i, !is.na(tri_plus[i, ])], 2)

   edgelist <- rbind(edgelist, temp_data)

}

edgelist <- as.data.frame(edgelist)

edgelist$V1 <- as.numeric(as.character(edgelist$V1))
edgelist$V2 <- as.numeric(as.character(edgelist$V2))

# Seřeadit si ID, aby nevznikaly duplicity
for(i in 1:nrow(edgelist)) {

   if (edgelist$V1[i] > edgelist$V2[i]) {

      edgelist$V3[i] <- edgelist$V1[i]
      edgelist$V4[i] <- edgelist$V2[i]

      } else {
         edgelist$V3[i] <- edgelist$V2[i]
         edgelist$V4[i] <- edgelist$V1[i]

         }
}

edgelist$V1 <- NULL
edgelist$V2 <- NULL

# Spočítání váhy a uložení
edgelist <- count(edgelist, c("V3", "V4"))
names(edgelist) <- c("Source", "Target", "weight")

write.csv(edgelist, file = "./data_ped/ped_edgelist.csv", row.names = FALSE)


# Vytvoření nodelistu
nodelist <- unlist(as.data.frame(numeric_data))
nodelist <- as.numeric(as.character(nodelist))
nodelist <- as.data.frame(nodelist)
nodelist <- count(nodelist, c("nodelist"))
nodelist <- nodelist[1:(nrow(nodelist)-1), ]

# Doplnění jmen k ID v nodelistu
names_table <- read.csv("./data_ped/names_table.csv", stringsAsFactors=FALSE)
names_table <- names_table[!is.na(names_table$ID), ]
nodelist <- merge(nodelist, names_table, by.x = "nodelist", by.y = "ID")
nodelist$label <- str_c(nodelist$prijmeni, ", ", nodelist$jmeno)

# Uložení nodelistu
write.csv(nodelist, file = "./data_ped/ped_nodelist.csv", row.names = FALSE)
