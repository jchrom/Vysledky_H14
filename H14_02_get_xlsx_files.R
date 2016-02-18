# Stažení xlsx souborů

library(downloader)

URLs <- read.csv("./data/files_URLs.csv", stringsAsFactors=FALSE)

puvodni.dir <- getwd()

dir.create(file.path(getwd(), "xlsx_files"), showWarnings = FALSE)
setwd(file.path(getwd(), "xlsx_files"))

for(i in 1:length(URLs$URL)) {
    download(url = URLs$URL[i], destfile = URLs$Soubor[i], mode = "wb")
}

setwd(puvodni.dir)