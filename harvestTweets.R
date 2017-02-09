setwd("/home/cdesantana/TwitterAnalytics/ObjectivaR")

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

textToSearch <- "@costa_rui"
xlimits<-c(-46.600952, -37.3409874)
ylimits<-c(-18.328010, -8.5409874)
noOfTweets <- 1000

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
library(wordcloud)
cname <- "/home/cdesantana/TwitterAnalytics/ObjectivaR/texts_rui"
docs <- Corpus(DirSource(cname)) 
docs <- tm_map(docs, removeWords, c("httpstcoxeoz","pra","como","dos","uma","por","das","httpstcohinafl","costarui","que","para"))
docs <- tm_map(docs, removePunctuation)   
docs <- tm_map(docs, removeNumbers)   
docs <- tm_map(docs, tolower)      
docs <- tm_map(docs, PlainTextDocument)   
tdm <- TermDocumentMatrix(docs)   
m1 <- as.matrix(tdm)
freq <- colSums(as.matrix(tdm))
v1 <- sort(rowSums(m1), decreasing = TRUE)
d1 <- data.frame(word = names(v1), freq = v1)
wordcloud(d1$word, d1$freq, col = brewer.pal(8, "Set2"), min.freq = 50)
