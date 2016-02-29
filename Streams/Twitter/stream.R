# $Id: stream.R,v 1.2 2015/12/14 21:12:43 ec2-user Exp ec2-user $  
# Get twitter streams for a period of time (< 1 hour) and same sentiment scores. 
# put in a cron job and run hourly 


#connect all libraries
 library(streamR)
 library(twitteR)
 library(ROAuth)
 library(plyr)
 library(dplyr)
 library(stringr)

# what to search
 searchterm <- "United Airlines" 

# ---- system config ----------
 searchdate <- format(Sys.time(), "%Y-%m-%d_%H:%M")
 setwd("/data/Streams/Twitter") 
 sample_len = 60*30  # 30 minutes 
# ----------------------------- 
 reqURL <- 'https://api.twitter.com/oauth/request_token'
 accessURL <- 'https://api.twitter.com/oauth/access_token'
 authURL <- 'https://api.twitter.com/oauth/authorize'
 #put the Consumer Key from Twitter Application
 consumerKey <- 'thd2KhXUX4i2RZWR1eNVJZslR'
 #put the Consumer Secret from Twitter Application
 consumerSecret <- 'kRFZuZNeUIVGKNzusOyFgPfKJLpq6l4ZR8GpppLlJxgZNRKDcX'
 access_token <- '2923086225-ItNFqBtNuI3PVsleJCoozukcwiBomypmtKikS0J'
 access_secret <- 'UpiTPF2FmyIfaxujcOnYjXQD3GGGzmeWgJ4FhDgvuohj8'

# do the following only once the first time 
#my_oauth <- OAuthFactory$new(consumerKey = consumerKey, consumerSecret = consumerSecret, 
#    requestURL = reqURL, accessURL = accessURL, authURL = authURL)
#my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
#save(my_oauth, file = "twitter_oauth.Rdata")

load("twitter_oauth.Rdata")

dir.create(searchterm) 
sfile <- paste(searchterm, "/stream-", searchdate, ".json", sep="")

# 5 min sample 
filterStream(sfile, track = searchterm, timeout = sample_len, oauth = my_oauth)
df <- parseTweets(sfile, simplify=TRUE) 

 # lexicon loading 
 pos.words <- scan('positive-words.txt', what='character', comment.char=';') 
 neg.words <- scan('negative-words.txt', what='character', comment.char=';') 

 df$text <- as.factor(df$text)

 scores <- laply(df$text, function(sentence, pos.words, neg.words){
    sentence <- gsub('[[:punct:]]', "", sentence)
    sentence <- gsub('[[:cntrl:]]', "", sentence)
    sentence <- gsub('\\d+', "", sentence)
    sentence <- tolower(iconv(sentence, "ASCII", "UTF-8", sub=""))
    word.list <- str_split(sentence, '\\s+')
    words <- unlist(word.list)
    pos.matches <- match(words, pos.words)
    neg.matches <- match(words, neg.words)
    pos.matches <- !is.na(pos.matches)
    neg.matches <- !is.na(neg.matches)
    pscore <- sum(pos.matches)
    nscore <- sum(neg.matches)
    neutral <- 0
    #  one point for each tweet: pos, neg, or netural
    if (pscore > nscore ) { 
        pscore = 1 
        nscore = 0 
        neutral = 0 
    } else if (pscore < nscore ) { 
        pscore = 0 
        nscore = 1 
        neutral = 0 
    } else { 
        pscore = 0 
        nscore = 0 
        neutral = 1
    } 
    return(c(pscore, nscore, neutral) )
 }, pos.words, neg.words, .progress='text')

 #put data in data frame
 output = data.frame(searchdate, t(colSums(scores)))
 scorefile <- paste(searchterm, "/stream-scores-", searchdate, ".json", sep="")
 write.table(output, file=scorefile, sep=",", col.names=FALSE) 
 
