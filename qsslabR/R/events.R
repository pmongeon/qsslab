#' @export
create_events <- function(){
  temp_db <- RSQLite::dbConnect(drv = SQLite(), dbname= "master.db")
  date<-rstudioapi::showPrompt(title = "Date", 
                               message = "Publication date (yyyy-mm-dd)")
  start_time<-rstudioapi::showPrompt(title = "Time start", 
                               message = "Starting time (hh:mm) (optional)")
  end_time<-rstudioapi::showPrompt(title = "Time end", 
                               message = "Ending time (hh:mm) (optional)")
  short_title<-rstudioapi::showPrompt(title = "Short title", 
                                      message = "Enter a short version of the title. This will only be used for creating the folder and the URL")
  title<-rstudioapi::showPrompt(title = "Title", 
                                message = "Enter the title of the talk")
  main_body<-rstudioapi::showPrompt(title = "Main body", 
                                    message = "Summary of the talk (in Markdown) (optional)")
  
  folder<-stringr::str_c("content/event/",date,"-",stringr::str_replace_all(stringr::str_squish(stringr::str_to_lower(short_title))," ","-"))
  file<-stringr::str_c(folder,"/index.md")
  dir.create(folder)
  file.create(file)
  write("---",file, append = TRUE)
  write(stringr::str_c("title: \"",title,"\""), file, append = TRUE)
  write(stringr::str_c("\nevent: ",event),file, append = TRUE)
  write(stringr::str_c("event_url: ",event_url),file, append = TRUE)
  write(stringr::str_c("\nlocation: ",location),file, append = TRUE)
  write(stringr::str_c("address:"),file, append = TRUE)
  write(stringr::str_c("  street: ",address_street),file, append = TRUE)
  write(stringr::str_c("  city: ",address_city),file, append = TRUE)
  write(stringr::str_c("  region: ",address_region),file, append = TRUE)
  write(stringr::str_c("  postcode: ",address_postcode),file, append = TRUE)
  write(stringr::str_c("  country: ",address_country),file, append = TRUE)
  write("\nauthors:",file, append = TRUE)
  for(author in authors) {
    write(stringr::str_c("  -",author),file, append = TRUE)
  }
  write("\ntags:",file, append = TRUE)
  for(tag in tags) {
    write(stringr::str_c("  -",tags),file, append = TRUE)
  }
  write(stringr::str_c("\nurl_slides: ",url_slides),file, append = TRUE)
  write(stringr::str_c("\nabstract: ",abstract),file, append = TRUE)
  write("\n# Talk start and end times",file, append=TRUE)
  write(stringr::str_c("date: '",date,"T",start_time,":00Z'"),file, append=TRUE)
  write(stringr::str_c("date_end: '",date,"T",end_time,":00Z'"),file, append=TRUE)
  write(stringr::str_c("all_day: ",all_day),file, append=TRUE)
  write("\n# Do not modify this next line",file, append=TRUE)
  write("# Do not modify this next line\npublishDate: '2022-06-15T00:00:00Z'",file, append=TRUE)
  write("---", file, append=TRUE)
  ---
    

  
  t<-tibble(id = as.numeric(dbGetQuery(temp_db, "select max(id) from posts"))+1,
            date = date,
            image_url = NA,
            image_focal_point = "right",
            main_body = main_body,
            title = title,
            short_title = short_title,
            path=folder)
  dbWriteTable(temp_db, "posts", t, row.names = F, overwrite=F, append=T)
  print("Post files created and post added to the db! Don't forget to push them to github!")
  RSQLite::dbDisconnect(temp_db)
}
