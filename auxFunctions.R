#### Functions to read and write Twitter data

getTweets <- function(search.string = "Good Morning", no.of.tweets = 100, language.of.tweets = "en", output.file = "tweets.csv"){
   tweets <- searchTwitter(search.string, n=no.of.tweets, language.of.tweets);
   write.csv(twListToDF(tweets), file=output.file)
   return(tweets)
}

#### Build network from twitter files

getNodes<-function(dat){
   tweetnodes<-as.character(unlist(dat$screenName));
   retweetnodes<-dat$replyToSN[which(!is.na(as.character(unlist(dat$replyToSN))))]
   allnodes<-c(tweetnodes,retweetnodes)
   return(allnodes)
}

getEdges<-function(dat,allnodes){
   
}

#### Get information from Authorization file

getAPIKey <- function(authorizationFile){
   auth<-read.csv(authorizationFile,sep=";",header=FALSE)
   APIKey<-as.character(auth$V2[1]);
}

getAPISecret <- function(authorizationFile){
   auth<-read.csv(authorizationFile,sep=";",header=FALSE)
   APIKey<-as.character(auth$V2[2]);
}

