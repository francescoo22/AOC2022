sayHello <- function(){
   my_data <- read.delim("input.txt", header = FALSE, sep = " ")
   print(my_data[2][1])
}

sayHello()