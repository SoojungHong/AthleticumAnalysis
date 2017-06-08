#----------------------------------------------
# Time Series Analysis on membership customer 
#
# Soojung Hong (June 8. 2017) 


#-------------------------
# package installation 
install.packages('plyr')
install.packages("ggplot2")


#-------------------------
# library for plot
library(ggplot2)


#---------------------------------------
# Set training data and connect to it 
# 
trainingData <- 'C:/Users/a613274/Downloads/AthExportData/factSalesTransaction.csv'
con = file(trainingData, "r")


#----------------
# Read 50000 rows
partialData <- read.csv(con, nrows=50000)
partialData
str(partialData)

#-----------------------------
# sort by DateID and TimeID
sortedData <- partialData[order(partialData$DateID, partialData$TimeID),]
sortedData

str(sortedData)


#-----------------------------------------------------------
# customers with membershipCardID and StoreID and productID
members <- sortedData[sortedData[, "MembershipCardID"] != -1,] 
str(members)
members_times_products <- data.frame(members$DateID, members$TimeID, members$MembershipCardID, members$ProductID)
members_times_products


#--------------------------------
# transaction date, time, membershipID, productID 
#time_product_Data <- data.frame(store_and_members$DateID, store_and_members$TimeID, store_and_members$MembershipCardID, store_and_members$ProductID)
#time_product_Data
colnames(members_times_products) <- c("DateID", "TimeID", "MembershipCardID", "ProductID")
members_times_products
#need to join with Product data 


#----------------------------------
#  Read product data 
productData <- 'C:/Users/a613274/Downloads/AthExportData/dimProduct.csv'
con2 = file(productData, "r")
productData <- read.csv(con2, nrows=621542) #All: 621542
#productData #DO NOT PRINT
str(productData)

#productData$ProductID
#productData$UniverseCodeDesc
#productData$WgrClassCodeDesc
columns <- c("ProductID", "UniverseCodeDesc", "WgrClassCodeDesc")
prodDesc <- productData[columns]
prodDesc



#------------------------------------------------------
# Join 'time_product_Data' and 'productData' by="productID"
joinedData <- merge(members_times_products, prodDesc, by="ProductID", all.x = TRUE)
joinedData
str(joinedData)
#simplify the time into two categories : before 1200, then 0, after 1200 then 1
#AM and PM 
#joinedData$TimeID[joinedData$TimeID < 1200] <- 0
#joinedData
#joinedData$TimeID[joinedData$TimeID >= 1200] <- 1
#joinedData

joinedData$TimeID[joinedData$TimeID < 1000] <- 0
joinedData
joinedData$TimeID[(joinedData$TimeID >= 1000) & (joinedData$TimeID < 1400) ] <- 1
joinedData
joinedData$TimeID[joinedData$TimeID >= 1400] <- 2 
joinedData

table(joinedData$WgrClassCodeDesc)
hist(joinedData$ProductID, col="green", breaks=30, xlab="WarenGrp", main="Histogram of # of WarenGroup") 
library(plyr)
count(joinedData$WgrClassCodeDesc)

#----------------------------------------------
# relationship between timeID and warenGroup
time2waren <- table(joinedData$TimeID, joinedData$WgrClassCodeDesc)
time2waren
barplot(time2waren,legend=T,beside=T,main='Purchased Time and WarenGroup')



