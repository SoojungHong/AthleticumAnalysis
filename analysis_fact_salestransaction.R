#---------------------------------------
# Analysis of factSalesTransaction.csv
# May 29. 2017 
#
# Soojung Hong 
#---------------------------------------

#--------------------
# library 
install.packages('plyr')

#---------------------------------------
# Set training data and connect to it 
# 
trainingData <- 'C:/Users/a613274/Downloads/AthExportData/factSalesTransaction.csv'
con = file(trainingData, "r")

#----------------
# Read 10000 rows
partialData <- read.csv(con, nrows=10000)
partialData
str(partialData)

#---------------------------
# percentage of membership
table(partialData$MembershipCardID)
plot(table(partialData$MembershipCardID))
library(plyr)
count(partialData$MembershipCardID)


#--------------------------------------------
# customers with membershipCardID analysis 
members <- partialData[partialData[, "MembershipCardID"] != -1,] 
str(members)
store_and_members <- data.frame(members$MembershipCardID, members$StoreID)
store_and_members

#------------------------------------------
# example membership A6004520201646057019
#example <- store_and_members[store_and_members[,"members.MembershipCardID"] == "A6004520201646057019",]
#example

#------------------------------------------
# example of StoreID
str(store_and_members$members.StoreID)
range(store_and_members$members.StoreID)

# show the storeID with the number of MembershipID
table(store_and_members)
h <- hist(store_and_members$members.StoreID, col="blue", breaks=30, xlab="StoreID", main="Histogram of # of Transactions per Stores") 
h

#---------------------------
# Gross price distribution 
density(partialData$GrossPrice)
plot(density(partialData$GrossPrice), main = "Gross Price")
plot(partialData$GrossPrice)
price <- partialData$GrossPrice
h<-hist(price, breaks=10, col="red", xlab="Gross price", main="Histogram with Gross Price Bucket") 
plot(partialData$GrossPrice)
