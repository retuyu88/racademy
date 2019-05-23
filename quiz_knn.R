library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)
library(class)
library(tidyverse)

hr <- HR_Employee_Attrition
set.seed(0) # menjadi satu variasi hasil

dim(hr)
hr1 <- hr %>% 
  mutate_if(is.character, as.factor) %>%
  mutate_if(is.factor, as.numeric)



hr_n <- as.data.frame(lapply(hr1[,c(1,3:8,10:21,23:26,28:35)],scale))
index_train <- sample(1:nrow(hr_n), 0.7 * nrow(hr_n))
hr_train <- hr_n[index_train, ]
hr_test <- hr_n[-index_train, ]
dim(hr_train)
dim(hr_test)

hr_train_target<-hr[index_train,2]

hr_train_targeta <- as.matrix(hr_train_target)

class(hr_train_targeta)

hr_test_target<-hr[-index_train,2]



dim(hr_train_target)
sum(is.na(hr_n))
knnmodel <-knn(train=hr_train,test=hr_test,cl=hr_train_targeta,k=2)

confknn <- table(hr_test_targeta, knnmodel)
confknn

TPk <- confknn[1, 1] 
FNk <- confknn[1, 2] 
FPk <- confknn[2, 1] 
TNk <- confknn[2, 2]

#Melihat Nilai Akurasi K-NN
acck <- (TPk + TNk)/(TPk + FNk + FPk + TNk)
acck

#Melihat Nilai Precision K-NN
preck <- TPk / (TPk + FPk)
preck

#Melihat Nilai Recall K-NN
reck <- TPk / (TPk + FNk)
reck

