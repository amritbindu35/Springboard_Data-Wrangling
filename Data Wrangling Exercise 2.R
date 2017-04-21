#Data Wrangling Exercise 2

##Loading appropriate libraries to complete Data Wrangling exercise #2
```library(readr)```  
```library(dplyr)```  
```library(tidyr)```  
```library(stringr)```  
``library(devtools)```  

##0: Load the data in RStudio

```titanic<- read_csv("/Users/miloneythakrar/Springboard_Data-Wrangling/titanic_original.csv")```

##Convert data to tbl class so that it’s easier to examine. 

```titanic_df <- tbl_df(titanic)```
```View(titanic_df)```

##1: Port of embarkation.

```summary(titanic_df)```
```na.strings=c(""," ","NA")```
```titanic_df$embarked[is.na(titanic_df$embarked)] = "S"```

##2: Age.

##Calculate the mean

```str(titanic_df$age)```
```mean_age = mean(titanic_df$age, na.rm = TRUE)```
``mean_age```
```titanic_df$age [which(is.na(titanic_df$age))] <- mean_age```

##Think about other ways you could have populated the missing values in the age column. Why would you pick any of those over the mean (or not)?
### Other ways I could have populated the missing values could have been median (or possibly mode).  These alternatives may be more favorable to use if there are a lot of outliers in the data that would skew the mean. 

##3: Life boat 

###This was completed in the first step. 

##4 Cabin
### No, it does not make sense to fill the missing values with a number.  A missing cabin number indicates it is unclear in which cabin the passenger was staying. 

```titanic_df <- mutate(titanic_df, has_cabin_number = ifelse(is.na(titanic_df$cabin), 0, 1))```

##6: Submit the project on Github
```write.csv(titanic_df, file = "titanic_clean.csv")```
