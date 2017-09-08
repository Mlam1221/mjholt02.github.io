publish <- function(file_name, title,tags){
  # file_name <- "2017-9-5-babyTrackerUI.md"
  # title <- "my title"
  # tags <- "tag1, tag2, tag3"
  
  
  line1="---"
  line2=paste0("title: '", title, "'")
  line3 = paste0("tags: [" ,  tags  ,"]")
  
  my_from <- paste0(getwd(),"/",file_name)
  my_to <- paste0("../_posts","/",file_name)

  
  write(line1,file=my_to,append=FALSE)
  write(line2,file=my_to,append=TRUE)
  write(line3,file=my_to,append=TRUE)
  write(line1,file=my_to,append=TRUE)
  file.append(my_to, my_from)
 
}