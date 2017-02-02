source("textPreproc.R")
source("sentimentAnalysis.R")
source("auxFunctions.R")
source("twitterMining.R")
library("wordcloud")

#### Creating connection with Twitter App

connectTwitterApp()

#### Harvest Tweets

textToSearch <- "Bahia"
noOfTweets <- 10000

# harvest some tweets
some_tweets = searchTwitter(textToSearch, n=noOfTweets, lang='pt-br')

# get the text
some_txt = sapply(some_tweets, function(x) x$getText())
some_txt <- textPreprocessing(some_txt)

##### playing with word clouds
##R package for text mining --- tm
library(tm)
cname <- "/home/cdesantana/TwitterAnalytics/ObjectivaR/texts"
docs <- Corpus(DirSource(cname)) 
docs <- tm_map(docs, removePunctuation)   
docs <- tm_map(docs, removeNumbers)   
docs <- tm_map(docs, tolower)      
docs <- tm_map(docs, PlainTextDocument)   
dtm <- TermDocumentMatrix(docs)   
freq <- colSums(as.matrix(dtm))
