library(rvest)

pocet.stran <- 14421  # max = 14421

data.url <- data.frame(a=character(), b=character(), stringsAsFactors=FALSE)

for(i in 1:100) {
    
    my.html <- read_html(paste("http://www.isvav.cz/h14/fulltext.jsp?page=", 
                               as.character(i), sep = ""))

    nazev <- my.html %>% 
        html_nodes(xpath="//ol/li/a") %>% 
        html_text()    
    
    popis <- my.html %>% 
        html_nodes(xpath="//ol/li/div") %>% 
        html_text()    
    
    data1 <- data.frame(nazev, popis)
    names(data1) <- c("Nazev", "Popis")
    
    data.url <- rbind(data.url, data1)
    names(data1) <- c("Nazev", "Popis")
    
    print(paste(i, " - Hotovo", sep = ""))
    
}


write.csv(data.url, file = "./data/abstracts_all.csv", row.names = FALSE)


rm(data.url)
rm(data1)
rm(nazev)
rm(popis)
rm(i)
rm(my.html)
rm(pocet.stran)