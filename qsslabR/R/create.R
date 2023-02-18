#' @export
create_post <- function(){
  temp_db <- RSQLite::dbConnect(drv = SQLite(), dbname= "master.db")
  date<-rstudioapi::showPrompt(title = "Date", 
                   message = "Publication date (yyyy-mm-dd)", 
                   default = as.character(Sys.Date()))
  short_title<-rstudioapi::showPrompt(title = "Short title for URL", 
                          message = "Enter a short version of the title. This will only be used for creating the folder and the URL")
  title<-rstudioapi::showPrompt(title = "Post title", 
                    message = "Enter the title of the post")
  
  main_body<-rstudioapi::showPrompt(title = "Main body", 
                        message = "Paste the main body of the post (in Markdown format) in this box")
  
  folder<-stringr::str_c("content/post/",date,"-",stringr::str_replace_all(stringr::str_squish(stringr::str_to_lower(short_title))," ","-"))
  file<-stringr::str_c(folder,"/index.md")
  dir.create(folder)
  file.create(file)
  write("---",file, append = TRUE)
  write(stringr::str_c("title: \"",title,"\""), file, append = TRUE)
  write(stringr::str_c("date: ",date), file, append = TRUE)
  write("image:", file, append=T)
  write("  focal point: 'right'", file, append=TRUE)
  write("---", file, append=TRUE)
  write("\n", file, append=T)
  write(main_body, file, append=T)
  
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


#' @export
list_posts<-function() {
  list.dirs("content/post")
}

post_dir<-"content/post/2023-02-18-test"

#' @export
delete_posts<-function(post_dir) {
  unlink(post_dir, recursive = TRUE, force = TRUE, expand = TRUE)
  temp_db <- RSQLite::dbConnect(drv = SQLite(), dbname= "master.db")
  dbExecute(temp_db,stringr::str_c("delete from posts where path = '",post_dir,"';"))
  RSQLite::dbDisconnect(temp_db)
  print("post deleted don't forget to push changes to github")
}