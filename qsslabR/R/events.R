#' @export
publish_events <- function(){
  temp_db <- RSQLite::dbConnect(drv = SQLite(), dbname= "master.db")
  events<-dbReadTable(temp_db, "events") %>% 
    filter(publish == 1) %>% 
    filter(is.na(on_website) | on_website == 0 | on_website == "false") %>% 
    filter(!is.na(title))
  for(event in events) {
  event[is.na(event)] <- ""
  a<-stringr::str_squish(unlist(strsplit(event$authors, ",")))[1]
  folder<-stringr::str_c("content/event/",event$date,"-",stringr::str_replace_all(stringr::str_squish(stringr::str_to_lower(a))," ","-"))
  file<-stringr::str_c(folder,"/index.md")
  dir.create(folder)
  file.create(file)
  write("---",file, append = TRUE)
  write(stringr::str_c("title: \"",event$title,"\""), file, append = TRUE)
  write(stringr::str_c("\nevent: ",event$event),file, append = TRUE)
  write(stringr::str_c("event_url: ",event$event_url),file, append = TRUE)
  write(stringr::str_c("\nlocation: ",event$location),file, append = TRUE)
  write(stringr::str_c("address:"),file, append = TRUE)
  write(stringr::str_c("  street: ",event$address_street),file, append = TRUE)
  write(stringr::str_c("  city: ",event$address_city),file, append = TRUE)
  write(stringr::str_c("  region: ",event$address_region),file, append = TRUE)
  write(stringr::str_c("  postcode: ",event$address_postcode),file, append = TRUE)
  write(stringr::str_c("  country: ",event$address_country),file, append = TRUE)
  write("\nauthors:",file, append = TRUE)
  authors<-stringr::str_squish(unlist(strsplit(event$authors, ",")))
  for(author in authors) {
    write(stringr::str_c("  - ",author),file, append = TRUE)
  }
  write("\ntags:",file, append = TRUE)
  tags<-stringr::str_squish(unlist(strsplit(event$tags, ",")))
  for(tag in tags) {
    write(stringr::str_c("  - ",tag),file, append = TRUE)
  }
  write(stringr::str_c("\nurl_slides: ",event$url_slides),file, append = TRUE)
  write(stringr::str_c("\nabstract:\n \"",event$abstract,"\""),file, append = TRUE)
  write("\n# Talk start and end times",file, append=TRUE)
  if(event$start_time!="") write(stringr::str_c("date: '",event$date,"T",event$start_time,":00Z'"),file, append=TRUE)
  if(event$start_time=="") write(stringr::str_c("date: '",event$date),file, append=TRUE)
  if(event$end_time!="") write(stringr::str_c("date_end: '",event$date,"T",event$end_time,":00Z'"),file, append=TRUE)
  write(stringr::str_c("all_day: ",event$all_day),file, append=TRUE)
  write("# Do not modify this next line\npublishDate: '2022-06-15T00:00:00Z'",file, append=TRUE)
  write("---", file, append=TRUE)
  dbExecute(temp_db, str_c("update events set on_website = 1 where id = ",event$id,";"))
  print(stringr::str_c("Event ",id," files created."))
  }    
  print("All events created. Don't forget to push them to github!")
  RSQLite::dbDisconnect(temp_db)
}


publish_events()

