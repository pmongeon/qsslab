library(tidyverse)
library(RSQLite)
library(qsslabR)

db <- dbConnect(drv = SQLite(), dbname= "master.db")

events<-dbReadTable(db, "events") %>% 
  filter(on_website == 0) %>% 
  filter(publish == 1)
events<-events$id
N
for(id in events) {
  publish_events(id)
}
