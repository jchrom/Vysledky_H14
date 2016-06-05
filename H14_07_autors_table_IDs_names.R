library(stringr)
library(stringi)

raw_data <- read.csv("./data_ped/data_ped.csv", stringsAsFactors=FALSE)
raw_data <- as.data.frame(raw_data[ , 4])

# Odstranit mezery
raw_data <- as.data.frame(stri_replace_all_charclass(raw_data[ , 1],
                                                     "\\p{WHITE_SPACE}", ""))
# Převést na jeden řádek = jedno jméno
jmena <- as.data.frame(unlist(str_split(raw_data[ , 1], ";")))

# Odstranit duplicity
jmena <- as.data.frame(jmena[!duplicated(jmena), ])

# Celé to převést na tabulku Příjmení, Jméno, ID + doplnit NA do řádků,
# kde chybí unikátní identifikátor jména/člověka (asi prasácké řešení)
a <- str_count(jmena[ , 1], ",")

jmena1 <- as.data.frame(jmena[a == 1, ])
jmena2 <- as.data.frame(jmena[a == 2, ])

### Varianta pro jména s ID
jmena_l <- unlist(str_split(jmena2[ , 1], ","))

prijmeni <- seq(1,length(jmena_l),3)
jmeno <- seq(2,length(jmena_l),3)
jmeno_id <- seq(3,length(jmena_l),3)

jmena2 <- data.frame(jmena_l[prijmeni], jmena_l[jmeno], jmena_l[jmeno_id])

names(jmena2) <- c("prijmeni", "jmeno", "ID")

jmena2 <- jmena2[!duplicated(jmena2$ID), ]

### Varianta pro jména bez ID
jmena_l <- unlist(str_split(jmena1[ , 1], ","))

prijmeni <- seq(1,length(jmena_l),2)
jmeno <- seq(2,length(jmena_l),2)
jmeno_id <- rep(NA, length(jmena_l)/2)

jmena1 <- data.frame(jmena_l[prijmeni], jmena_l[jmeno], jmeno_id)

names(jmena1) <- c("prijmeni", "jmeno", "ID")

### Spojení obou variant
jmena <- rbind(jmena1, jmena2)
jmena <- jmena[order(jmena$prijmeni, jmena$jmeno), ]

write.csv(jmena, file = "./data_ped/names_table.csv", row.names = FALSE)







