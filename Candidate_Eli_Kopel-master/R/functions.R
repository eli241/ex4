# R functions to be placed here
# Note: do not put calls to library() in here, but rather in the "setup" chunk in the .Rmd script

#' Prints a Greeting Message
#'
#' @param name a character string that specifies the name of the person to greet.
#' It is concatenated to the greeting words.
#' @param text a character string that specifies the greeting words.
#' @param print_date a logical flag that indicates whether the current date should be 
#' printed as a header.
#' 
#' @examples
#' hello_world("Bob")
#' hello_world("Bob", text = "Good morning")
#' hello_world("Bob", print_date = TRUE)
#' 
hello_world <- function(name, text = "Hello", print_date = FALSE){
  msg <- sprintf("%s%s %s", 
                 if( print_date ) paste0(date(), "\n") else "", 
                 text, name)
  message(msg)
  
}
