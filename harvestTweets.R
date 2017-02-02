source("textPreproc.R")
source("sentimentAnalysis.R")
source("auxFunctions.R")
source("twitterMining.R")
library("wordcloud")
library("maps")
library("mapdata")
library("rworldmap")
library("maptools")

#### Creating connection with Twitter App

connectTwitterApp()

#### Harvest Tweets

textToSearch <- "Bahia"
xlimits<-c(-46.600952, -37.3409874)
ylimits<-c(-18.328010, -8.5409874)
noOfTweets <- 10000

# harvest some tweets
some_tweets = searchTwitter(textToSearch, n=noOfTweets, lang='pt-br')

# plot on a map
df_tweets <- twListToDF(some_tweets)

png("Brazil.png",width=1980,height=1280,res=300)
map("world","Brazil")
points(df_tweets$longitude,df_tweets$latitude)
dev.off();

##### ---> https://dioferrari.wordpress.com/2014/11/27/plotting-maps-using-r-example-with-brazilian-municipal-level-data/

municBR   <- readShapePoly(fn='geodata/municipios_2010.shp')
statesBR  <- readShapePoly(fn='geodata/estados_2010.shp')
regionsBR <- readShapePoly(fn='geodata/regioes_2010.shp')

png("Bahia.png",width=1980,height=1280,res=300)
plot(municBR[(municBR@data$estado_id)==5,]) ####Plotting Bahia
points(df_tweets$longitude,df_tweets$latitude,col="red",pch=19)
dev.off()

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
