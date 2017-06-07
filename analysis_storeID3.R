#------------------------
# StoreID = 3 analysis 
# What product be purchased by customers who have membership card from store has large membership customer
# result : Textil


#---------------------------------------
# Set training data and connect to it 
# 
transactionData <-'C:/Users/a613274/Downloads/AthExportData/factSalesTransaction.csv'
con = file(transactionData, "r")


#---------------------------------------
# Read 20000 rows in transaction data 
partialData <- read.csv(con, nrows=20000)
#partialData
str(partialData)
transacCols <- c("DateID", "StoreID", "ProductID", "MembershipCardID")
partialTransactData <- partialData[transacCols]
partialTransactData

#-----------------------------------------------------------
# customers with membershipCardID and StoreID and productID
members <- partialTransactData[partialTransactData[, "MembershipCardID"] != -1,] 
str(members)
store_and_members <- data.frame(members$MembershipCardID, members$StoreID, members$ProductID)
store_and_members


#-----------------------------------------------------
# show the storeID with the number of MembershipID
table(store_and_members)
h <- hist(store_and_members$members.StoreID, col="blue", breaks=30, xlab="StoreID", main="Histogram of # of Transactions per Stores") 
h

members_in_store3 <- members[members[, "StoreID"] == 3,]
members_in_store3
str(members_in_store3) #in storeID = 3, 41 customers with memberships
table(members_in_store3$MembershipCardID)
plot(table(members_in_store3$MembershipCardID))
members_in_store3 <- members_in_store3[c("ProductID", "MembershipCardID")]
members_in_store3
range(members_in_store3$ProductID)

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
# Join 'store_and_members' and 'productData' by="productID"
joinedData <- merge(members_in_store3, prodDesc, by="ProductID", all.x = TRUE)
joinedData
str(joinedData)
table(joinedData$WgrClassCodeDesc)
hist(joinedData$ProductID, col="green", breaks=30, xlab="WarenGrp", main="Histogram of # of WarenGroup") 
library(plyr)
count(joinedData$WgrClassCodeDesc)


