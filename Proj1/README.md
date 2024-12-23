##Project Overview 
#This is a project completed in R Studio using R. This project includes data preprocessing steps and the development of 2 different neural networks to predict the risk intensity of pregnant woman. Two confusion matrix were then developed to evaluate the performance of the neural networks. 

##About dataset 
#The maternal health risk dataset monitors pregnant women for the purpose of predicting maternal health risk during pregnancy. Data has been collected from different hospitals, community clinics, maternal health cares from rural areas in Bangladesh through a IoT based monitoring system. The target variable is categorical and there are 6 explanatory variables. 

##Preprocessing steps
#To prepare for the neural networks, I scaled all the explanatory variables to ranges of 0 to 1. Since the target variable is categoric, I created dummy variables for each of the categories. To generate a confusion matrix, I created a column that combines all the dummy variables depending on the result.
