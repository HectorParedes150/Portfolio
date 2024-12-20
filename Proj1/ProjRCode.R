mht.df <- read.csv("Maternal Health Risk Data Set.csv", header = T)
View(mht.df)

maxA <- max(mht.df$Age)
minA <- min(mht.df$Age)

mht.df$AgeS <- (mht.df$Age - minA)/(maxA - minA)

maxSB <- max(mht.df$SystolicBP)
minSB <- min(mht.df$SystolicBP)

mht.df$SystolicBPs <- (mht.df$SystolicBP - minSB)/(maxSB - minSB)

maxDB <- max(mht.df$DiastolicBP)
minDB <- min(mht.df$DiastolicBP)

mht.df$DiastolicBPs <- (mht.df$DiastolicBP - minDB)/(maxDB - minDB)

maxBS <- max(mht.df$BS)
minBS <- min(mht.df$BS)

mht.df$BSs <- (mht.df$BS - minBS)/(maxBS - minBS)

maxBT <- max(mht.df$BodyTemp)
minBT <- min(mht.df$BodyTemp)

mht.df$BodyTempS <- (mht.df$BodyTemp - minBT)/(maxBT - minBT)

maxHR <- max(mht.df$HeartRate)
minHR <- min(mht.df$HeartRate)

mht.df$HeartRateS <- (mht.df$HeartRate - minHR)/(maxHR - minHR)

mht.df$RiskLevelH <- ifelse(mht.df$RiskLevel == "high risk", 1, 0)
mht.df$RiskLevelM <- ifelse(mht.df$RiskLevel == "mid risk", 1, 0)
mht.df$RiskLevelL <- ifelse(mht.df$RiskLevel == "low risk", 1, 0)

mht.df$RiskLevelResult <- apply(mht.df[, c("RiskLevelH", "RiskLevelM", "RiskLevelL")], 1, function(x) which.max(x) - 1)

View(mht.df)

write.csv(mht.df, "mhtPP.csv")


set.seed(123)

trains.rows.m <- sample(rownames(mht.df), dim(mht.df)[1]*.60)
train.data.m <- mht.df[trains.rows.m, ]
valid.rows.m <- setdiff(rownames(mht.df), trains.rows.m)
valid.data.m <- mht.df[valid.rows.m, ]

library(neuralnet)
set.seed(123)
nn.mht <- neuralnet(RiskLevelH + RiskLevelM + RiskLevelL ~ AgeS + SystolicBPs + DiastolicBPs + BSs + BodyTempS + HeartRateS, train.data.m, linear.output = FALSE, hidden = 3)

plot(nn.mht, rep="best")


library(caret)
library(e1071)

valid.pred.m = predict(nn.mht, valid.data.m [, c(8:13)])
valid.class.m = apply(valid.pred.m, 1, which.max)-1

confusionMatrix(as.factor(valid.class.m), as.factor(mht.df[valid.rows.m,]$RiskLevelResult))

set.seed(123)
nn.mht2 <- neuralnet(RiskLevelH + RiskLevelM + RiskLevelL ~ AgeS + SystolicBPs + DiastolicBPs + BSs + BodyTempS + HeartRateS, train.data.m, linear.output = FALSE, threshold = .10, hidden=c(2,2))
plot(nn.mht2, rep = "best")

valid.pred.m2 = predict(nn.mht2, valid.data.m [, c(8:13)])
valid.class.m2 = apply(valid.pred.m2, 1, which.max)-1

confusionMatrix(as.factor(valid.class.m2), as.factor(mht.df[valid.rows.m,]$RiskLevelResult))

