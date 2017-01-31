
library("maps")
library("devtools")
library("streamR")
library("RCurl")
library("RJSONIO")
library("stringr")
library("ROAuth")
library("twitteR")
library("ROAuth")
source("./auxFunctions.R")


# Set SSL certs globally
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"

apiKey <-  getAPIKey("../authorization.txt")
apiSecret <- getAPISecret("../authorization.txt")

twitCred <- OAuthFactory$new(
   consumerKey = apiKey, 
   consumerSecret = apiSecret,
   requestURL = reqURL,
   accessURL = accessURL, 
   authURL = authURL
)

twitCred$handshake(
   cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")
)

registerTwitterOAuth(twitCred)
