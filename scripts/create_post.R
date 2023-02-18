library(tidyverse)
library(RSQLite)
library(rstudioapi)

#' @export
create_post <- function(){
  temp_db <- dbConnect(drv = SQLite(), dbname= "master.db")
  date<-showPrompt(title = "Date", 
                   message = "Publication date (yyyy-mm-dd)", 
                   default = as.character(Sys.Date()))
  short_title<-showPrompt(title = "Short title for URL", 
                          message = "Enter a short version of the title. This will only be used for creating the folder and the URL")
  title<-showPrompt(title = "Post title", 
                    message = "Enter the title of the post")
  
  main_body<-showPrompt(title = "Main body", 
                        message = "Paste the main body of the post (in Markdown format) in this box")
  
  folder<-str_c("content/post/",date,"-",str_replace(str_squish(str_to_lower(short_title))," ","-"))
  file<-str_c(folder,"/index.md")
  dir.create(folder)
  file.create(file)
  write("---",file, append = TRUE)
  write(str_c("title: \"",title,"\""), file, append = TRUE)
  write(str_c("date: ",date), file, append = TRUE)
  write("image:", file, append=T)
  write("  focal point: 'right'", file, append=TRUE)
  write("---", file, append=TRUE)
  write("\n", file, append=T)
  write(main_body, file, append=T)
  print("Post created!")
  dbDisconnect(temp_db)
}

