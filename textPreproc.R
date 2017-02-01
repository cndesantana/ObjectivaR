textPreprocessing <- function(some_txt){
   
   # remove retweet entities
   some_txt = gsub('(RT|via)((?:\\b\\W*@\\w+)+)', '', some_txt)
   # remove at people
   some_txt = gsub('@\\w+', '', some_txt)
   # remove punctuation
   some_txt = gsub('[[:punct:]]', '', some_txt)
   # remove numbers
   some_txt = gsub('[[:digit:]]', '', some_txt)
   # remove html links
   some_txt = gsub('http\\w+', '', some_txt)
   # remove unnecessary spaces
   some_txt = gsub('[ \t]{2,}', '', some_txt)
   some_txt = gsub('^\\s+|\\s+$', '', some_txt)
   
   # define 'tolower error handling' function
   try.error = function(x)
   {
      # create missing value
      y = NA
      # tryCatch error
      try_error = tryCatch(tolower(x), error=function(e) e)
      # if not an error
      if (!inherits(try_error, 'error'))
         y = tolower(x)
      # result
      return(y)
   }
   # lower case using try.error with sapply
   some_txt = sapply(some_txt, try.error)
   
   # remove NAs in some_txt
   some_txt = some_txt[!is.na(some_txt)]
   names(some_txt) = NULL
   
   return(some_txt)
}
