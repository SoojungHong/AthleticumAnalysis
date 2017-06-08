#--------------------------
# Shoes sales per month 
# 
# Soojung Hong 
# (June 8. 2017)


#-------------------------
# package installation 
install.packages('plyr')
install.packages("ggplot2")
install.packages("vcd")

#-------------------------
# library for plot
library(ggplot2)
library(vcd)

#---------------------------------------
# Set training data and connect to it 
# 
trainingData <- 'C:/Users/a613274/Downloads/AthExportData/factSalesTransaction.csv'
con = file(trainingData, "r")


#------------------
# Read 50000 rows
partialData <- read.csv(con, nrows=1048576) 
partialData                        
str(partialData)


#-----------------------------
# sort by DateID and TimeID
sortedData <- partialData[order(partialData$DateID),]
sortedData

str(sortedData)

#------------------------------------------------------------
# ToDo : Differentiate between Membership vs. non-Membership
#members <- sortedData[sortedData[, "MembershipCardID"] != -1,] 
#str(members)
date_products <- data.frame(sortedData$DateID, sortedData$ProductID)
date_products
range(date_products$sortedData.DateID) #20110512 20110827

date_products
#--------------------
# groupng by month 
date_products$sortedData.DateID[date_products$sortedData.DateID < 20110601] <- 5
date_products
date_products$sortedData.DateID[(date_products$sortedData.DateID >= 20110601) & (date_products$sortedData.DateID < 20110701) ] <- 6
date_products
date_products$sortedData.DateID[(date_products$sortedData.DateID >= 20110701) & (date_products$sortedData.DateID < 20110801) ] <- 7
date_products
date_products$sortedData.DateID[(date_products$sortedData.DateID >= 20110801) & (date_products$sortedData.DateID < 20110901) ] <- 8

colnames(date_products) <- c("DateID", "ProductID")
date_products


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
joinedData <- merge(date_products, prodDesc, by="ProductID", all.x = TRUE)
joinedData
str(joinedData)

table(joinedData)
hist(joinedData$ProductID, col="green", breaks=30, xlab="WarenGrp", main="Histogram of # of WarenGroup") 
library(plyr)
count(joinedData$WgrClassCodeDesc)


month_wgr_table <- table(joinedData$DateID, joinedData$WgrClassCodeDesc)
month_wgr_table

#-----------------------------------
# Visualize the contingency table 
mosaic(month_wgr_table, shade=TRUE, legend=TRUE)
#assoc(month_wgr_table, shade=TRUE, legend=TRUE)
