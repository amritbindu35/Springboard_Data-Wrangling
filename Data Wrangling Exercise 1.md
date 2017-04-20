#Data Wrangling Exercise 1

##Load appropriate libraries to complete Data Wrangling exercise 1. 
```library(readr)```    
```library(dplyr)```    
```library(tidyr)```    
```library(stringr)```   
```library(devtools)```  

##Load file csv file into RStudio. 

```refine <- read_csv("/Users/miloneythakrar/Springboard_Data-Wrangling/refine_original.csv")```

##Convert data to tbl class. 

```refine_df <- tbl_df(refine)```

##View data frame to examine.

```View(refine_df)```  

##1: Clean up brand names.

```refine_df<-arrange(refine_df,company)```  
```refine_df$company <- gsub(pattern = "^[Ppf].*p[Ss]$","philips", refine_df$company)```      
```refine_df$company <- gsub(pattern = "^[Un].*[r]$", "unilever", refine_df$company)```    
```refine_df$company <- gsub(pattern = "^[Aa].*[Oo0]$", "akzo", refine_df$company)```  
```refine_df$company <- gsub(pattern = "^[Vv].*[Nn]$", "van houten", refine_df$company)```  

##2 Separate product code and number.  

```refine_df <- separate(refine_df, `Product code / number`, into = c("product_code", "product_number"), sep = "-")```

##3: Add product categories.  

```categories <- c(p = "Smartphone", v = "TV", x = "Laptop", q = "Tablet")
refine_df <-mutate(refine_df, category = categories[product_code])```  

##4: Add full address for geocoding.

```refine_df <- mutate(refine_df, full_address = paste(address, city, country, sep = ", "))```

##5: Create dummy variables for company and product category.

```refine_df <-  mutate(refine_df, company_philips = ifelse(company == "philips", 1, 0))```
```refine_df <- mutate(refine_df, company_akzo = ifelse(company == "akzo", 1, 0))```
```refine_df <- mutate(refine_df, company_van_houten = ifelse(company == "van houten", 1, 0))```
```refine_df <- mutate(refine_df, company_unilever = ifelse(company == "unilever", 1, 0))```
```refine_df <- mutate(refine_df, product_smartphone = ifelse(category =="Smartphone", 1, 0))```
```refine_df <- mutate(refine_df, product_tv = ifelse(category =="TV", 1, 0))```
```refine_df <- mutate(refine_df, product_laptop = ifelse(category == "Laptop", 1, 0))```
```refine_df <- mutate(refine_df, product_tablet = ifelse (category == "Tablet", 1, 0))```
