# 12/12/2015
# Based on: http://www.r-bloggers.com/twitter-sentiment-analysis-with-r/
# with updated authentication 

#connect all libraries
 library(twitteR)
 library(ROAuth)
 library(plyr)
 library(dplyr)
 library(stringr)
 library(ggplot2)

 reqURL <- 'https://api.twitter.com/oauth/request_token'
 accessURL <- 'https://api.twitter.com/oauth/access_token'
 authURL <- 'https://api.twitter.com/oauth/authorize'
 #put the Consumer Key from Twitter Application
 consumerKey <- 'thd2KhXUX4i2RZWR1eNVJZslR'
 #put the Consumer Secret from Twitter Application
 consumerSecret <- 'kRFZuZNeUIVGKNzusOyFgPfKJLpq6l4ZR8GpppLlJxgZNRKDcX'
 access_token <- '2923086225-ItNFqBtNuI3PVsleJCoozukcwiBomypmtKikS0J'
 access_secret <- 'UpiTPF2FmyIfaxujcOnYjXQD3GGGzmeWgJ4FhDgvuohj8'

write("To do authentication ...", file='') 

options(httr_oauth_cache=F)
setup_twitter_oauth(consumerKey, consumerSecret, access_token, access_secret)

write("Done authentication ...", file='') 

#the function of tweets accessing and analyzing
search <- function(searchterm)
 {
 #access tweets and create cumulative file

list <- searchTwitter(searchterm, n=1500, lang='en')
 df <- twListToDF(list)
 df <- df[, order(names(df))]
 df$created <- strftime(df$created, '%Y-%m-%d')
# if (file.exists(paste(searchterm, '_stack.csv', sep=''))==FALSE) { 
    write.csv(df, file=paste(searchterm, '_stack.csv', sep=''), row.names=F)
# }

 write("Done search ...", file='') 

#merge last access with cumulative file and remove duplicates
# stack <- read.csv(file=paste(searchterm, '_stack.csv', sep=''))
# stack <- rbind(stack, df)
# stack <- subset(stack, !duplicated(stack$text))
# write.csv(stack, file=paste(searchterm, '_stack.csv', sep=''), row.names=F)
# write("Done merging ...", file='') 

stack <- df

#evaluation tweets function
 score.sentiment <- function(sentences, pos.words, neg.words, .progress='none')
 {
 require(plyr)
 require(stringi)
 require(stringr)
 scores <- laply(sentences, function(sentence, pos.words, neg.words){
    sentence <- gsub('[[:punct:]]', "", sentence)
    sentence <- gsub('[[:cntrl:]]', "", sentence)
    sentence <- gsub('\\d+', "", sentence)
    write(paste(sentence, "\n"), file='') 
    sentence <- tolower(iconv(sentence, "ASCII", "UTF-8", sub=""))
    word.list <- str_split(sentence, '\\s+')
    write(" inside sentiment 0 ...", file='') 
    words <- unlist(word.list)
    write(" inside sentiment 1 ...", file='') 
    pos.matches <- match(words, pos.words)
    neg.matches <- match(words, neg.words)
    pos.matches <- !is.na(pos.matches)
    neg.matches <- !is.na(neg.matches)
    write(" inside sentiment 2 ...", file='') 
    score <- sum(pos.matches) - sum(neg.matches)
    write(" inside sentiment 3 ...", file='') 
    return(score)
 }, pos.words, neg.words, .progress=.progress)
 scores.df <- data.frame(score=scores, text=sentences)
 write(" inside sentiment 4 ...", file='') 
 return(scores.df)
 }  # end of score.sentiment function

#folder with positive dictionary
pos <- scan('positive-words.txt', what='character', comment.char=';') 
#folder with negative dictionary
neg <- scan('negative-words.txt', what='character', comment.char=';') 
 pos.words <- c(pos, 'upgrade')
 neg.words <- c(neg, 'wtf', 'wait', 'waiting', 'epicfail')

 write("Done readling dictionaries ...", file='') 

#save evaluation results into the file
Dataset <- stack
 Dataset$text <- as.factor(Dataset$text)
 write("to call score.sentiment  ...", file='') 
 scores <- score.sentiment(Dataset$text, pos.words, neg.words, .progress='text')
 write("called score.sentiment  ...", file='') 
 write.csv(scores, file=paste(searchterm, '_scores.csv', sep=''), row.names=TRUE) 

 write("Scores saved ...", file='') 

#total evaluation: positive / negative / neutral
 stat <- scores
 stat$created <- stack$created
 stat$created <- as.Date(stat$created)
 stat <- mutate(stat, tweet=ifelse(stat$score > 0, 'positive', ifelse(stat$score < 0, 'negative', 'neutral')))
 by.tweet <- group_by(stat, tweet, created)
 by.tweet <- summarise(by.tweet, number=n())
 write.csv(by.tweet, file=paste(searchterm, '_opin.csv', sep=''), row.names=TRUE)

 write("Done evaluation ...", file='') 

#create chart
 ggplot(by.tweet, aes(created, number)) + geom_line(aes(group=tweet, color=tweet), size=2) +
   geom_point(aes(group=tweet, color=tweet), size=4) +
   theme(text = element_text(size=18), axis.text.x = element_text(angle=90, vjust=1)) +
 #stat_summary(fun.y = 'sum', fun.ymin='sum', fun.ymax='sum', colour = 'yellow', size=2, geom = 'line') +
 ggtitle(searchterm)

ggsave(file=paste(searchterm, '_plot.jpeg', sep=''))

}

search("walmart") #enter keyword

