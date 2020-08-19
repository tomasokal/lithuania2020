library(data.table)
library(randomForest)
library(ggplot2)

df <- data.table::fread("wine_quality.csv")

inTrain <- sample(df[, .I], floor(df[, .N] * 0.75))
df_train <- df[inTrain]
df_test <- df[-inTrain]

rf_classify <- randomForest::randomForest(quality ~ .
                                          , data = df_train
                                          , ntree = 100
                                          , mtry = 2
                                          , importance = TRUE)



