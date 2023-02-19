library(tidyverse)
library(RSQLite)
library(qsslabR)

db <- dbConnect(drv = SQLite(), dbname= "master.db")

publications<-dbReadTable(db, "publications") %>% 
  filter(on_website == 0) %>% 
  filter(publish == 1)
publications<-publications$id

for(id in publications) {
  publish_publications(id)
}
