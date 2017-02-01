# Perform Sentiment Analysis
# classify emotion

performSentimentAnalysis <- function(some_txt){
   class_emo = classify_emotion(some_txt, algorithm='bayes', prior=1.0)
   # get emotion best fit
   emotion = class_emo[,7]
   # substitute NA's by 'unknown'
   emotion[is.na(emotion)] = 'unknown'
   
   # classify polarity
   class_pol = classify_polarity(some_txt, algorithm='bayes')
   # get polarity best fit
   polarity = class_pol[,4]
   # Create data frame with the results and obtain some general statistics
   # data frame with results
   sent_df = data.frame(text=some_txt, emotion=emotion,
                        polarity=polarity, stringsAsFactors=FALSE)
   
   # sort data frame
   sent_df = within(sent_df,
                    emotion <- factor(emotion, levels=names(sort(table(emotion), decreasing=TRUE))))
   
   return(sent_df)
}
