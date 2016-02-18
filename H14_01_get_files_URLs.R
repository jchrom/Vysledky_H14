library(rvest)

# Zjištění URL adres potřebných souborů

my.html <- read_html("http://www.isvav.cz/h14/listResearchOrganisationUnits.do",
                     encoding = "utf-8")

table <- my.html %>% 
    html_nodes(".embedded") %>% 
    html_table(fill = FALSE)

table <- as.data.frame(table, stringsAsFactors = FALSE)

names(table) <- c("Organizace", "P1.vysledky", "P1.body", "P2.bonifikace", 
                  "P2.excelent", "P3.body", "Body2012", "Celkem", "Soubor")

URL <- my.html %>% 
    html_nodes(".external") %>% 
    html_attr("href")

URL <- as.data.frame(URL, stringsAsFactors = FALSE)

table <- cbind(table, URL)
table$Soubor <- substr(table$URL, 32, nchar(table$URL))

dir.create(file.path(getwd(), "data"), showWarnings = FALSE)

write.csv(table, file = "./data/files_URLs.csv", fileEncoding = "utf-8", 
          row.names = FALSE)

rm(my.html)
rm(table)
rm(URL)