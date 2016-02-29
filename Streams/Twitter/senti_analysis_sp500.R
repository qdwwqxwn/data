# 12/12/2015
# Based on: http://www.r-bloggers.com/twitter-sentiment-analysis-with-r/
# with updated authentication, and simplified data flow and data output
# put in a cron job and run daily at the end of the day


#connect all libraries
 library(twitteR)
 library(ROAuth)
 library(plyr)
 library(dplyr)
 library(stringr)
 library(ggplot2)

# what to search
 outdir <- "SP500" 
 searchterm <- "#SP500 OR @SP500 OR SP55" 

# ---- users: do not change below ----------
 searchdate <- format(Sys.time(), "%Y-%m-%d") 
 yesterday <- format(Sys.Date()-1, "%Y-%m-%d") 
 setwd("/data/Streams/Twitter") 
 reqURL <- 'https://api.twitter.com/oauth/request_token'
 accessURL <- 'https://api.twitter.com/oauth/access_token'
 authURL <- 'https://api.twitter.com/oauth/authorize'
 #put the Consumer Key from Twitter Application
 consumerKey <- 'thd2KhXUX4i2RZWR1eNVJZslR'
 #put the Consumer Secret from Twitter Application
 consumerSecret <- 'kRFZuZNeUIVGKNzusOyFgPfKJLpq6l4ZR8GpppLlJxgZNRKDcX'
 access_token <- '2923086225-ItNFqBtNuI3PVsleJCoozukcwiBomypmtKikS0J'
 access_secret <- 'UpiTPF2FmyIfaxujcOnYjXQD3GGGzmeWgJ4FhDgvuohj8'

 options(httr_oauth_cache=F)
 setup_twitter_oauth(consumerKey, consumerSecret, access_token, access_secret)

 list <- searchTwitter(searchterm, n=5000, lang='en', since=yesterday, until=searchdate)
 len = length(list) 
 df <- twListToDF(list)
 df <- df[, order(names(df))]
 df$created <- strftime(df$created, '%Y-%m-%d')

 dir.create(outdir) 
 write.csv(df, file=paste(outdir, "/", paste(searchdate, 'text.csv', sep='_'), 
                     sep=''), row.names=F)

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
 # write.csv() does not support 'append' 
 write.table(output, file=paste(outdir, "/daily_scores.csv", sep=''), sep=",", 
             col.names=FALSE, append=TRUE) 
 

