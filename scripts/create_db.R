library(tidyverse)
library(RSQLite)
db <- dbConnect(drv = SQLite(), dbname= "master.db")

dbCreateTable(db, "projects", c(id = "smallint",
                                title = "text",
                                subtitle = "text",
                                description = "smallint",
                                status = "text",
                                stream = "text",
                                tags = "text",
                                date = "datetime",
                                draft= "text",
                                featured = "text",
                                image_filename = "text",
                                image_focal_point = "text",
                                image_preview_only = "text"
                                ))

dbCreateTable(db, "streams", c(id = "smallint",
                               title = "text",
                               description = "text"))


dbCreateTable(db, "events", c(id = "smallint",
                             title = "text",
                             abstract = "text",
                             event = "text",
                             event_url = "text",
                             location = "smallint",
                             address_street = "text",
                             address_city = "text",
                             address_region = "text",
                             address_postcode = "text",
                             address_country = "text",
                             authors = "text",
                             tags = "text",
                             url_slides = "text",
                             date = "datetime",
                             date_end = "datetime",
                             all_day = "text"))

dbCreateTable(db, "people", c(id = "smallint",
                              name = "text",
                              role = "text",
                              avatar_filename = "text",
                              superuser = "text",
                              bio = "text",
                              user_groups = "text",
                              about = "text"
                              ))

dbCreateTable(db, "people_social_links", c(people_id = "smallint",
                                           icon = "text",
                                           icon_pack = "text",
                                           link = "text"))

dbCreateTable(db, "posts", c(id = "smallint",
                             date = "date",
                             image_url = "text",
                             image_focal_pint = "text",
                             main_body = "text"))

dbCreateTable(db, "publications", c(id = "smallint",
                                    title = "text",
                                    authors = "text",
                                    date = "datetime",
                                    doi = "text",
                                    publishDate = "datetime",
                                    type = "tinyint",
                                    source = "text",
                                    source_short = "text",
                                    absract = "text",
                                    tags = "text",
                                    featured = "text",
                                    url_pdf= "text",
                                    url_code= "text",
                                    url_dataset= "text",
                                    url_poster= "text",
                                    url_project= "text",
                                    url_slides= "text",
                                    url_source= "text",
                                    url_video= "text",
                                    project= "text"
))

dbCreateTable(db, "grants", c(id = "smallint",
                              type = "text",
                              title = "text",
                              authors = "text",
                              summary = "text",
                              funder = "text",
                              program = "text",
                              amount = "numeric",
                              currency = "text",
                              status = "text"
                              ))

dbCreateTable(db, "publications_people", c(publication_id = "smallint",
                                           person_id = "smallint",
                                           role = "text",
                                           position = "smallint"))

dbCreateTable(db, "events_people", c(event_id = "smallint",
                                     person_id = "smallint",
                                     role = "text",
                                     position = "smallint"))

dbCreateTable(db, "grants_people", c(grant_id = "smallint",
                                     person_id = "smallint",
                                     role = "text",
                                     position = "smallint"))

dbCreateTable(db, "projects_people", c(project_id = "smallint",
                                       person_id = "smallint",
                                       role = "text",
                                       position = "smallint"))

