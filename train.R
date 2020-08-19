install.packages("data.table")
install.packages("randomForest")
install.packages("ggplot2")

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

fileConn<-file("metrics.txt")

writeLines(c(
  
  paste0("Mean of squared residuals: ", rf_classify$mse[length(rf_classify$mse)][1]),
  paste0("% Var explained: ", rf_classify$rsq[length(rf_classify$rsq)][1])
  
), fileConn)

close(fileConn)

