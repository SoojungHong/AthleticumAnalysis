#----------------------------------------------------
# Time-Series Analysis of factSalesTransaction.csv
# June 6. 2017 
#
# Soojung Hong 
#---------------------------------------------------

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
# Read 10000 rows
partialData <- read.csv(con, nrows=10)
partialData
str(partialData)

#-----------------
# sort by DateID
sortedData <- partialData[order(partialData$DateID),]
sortedData

str(sortedData)

#----------------------------------
# transaction time & gross amount 
time_grossamount_Data <- data.frame(sortedData$TimeID, sortedData$GrossAmount)
time_grossamount_Data

theme_set(theme_bw()) # Change the theme to my preference
ggplot(aes(x = sortedData.TimeID, y = sortedData.GrossAmount), data = time_grossamount_Data
) + geom_point()


#--------------------------------
# transaction time & warengroup 
time_product_Data <- data.frame(sortedData$DateID, sortedData$TimeID, sortedData$ProductID)
time_product_Data
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
joinedData <- merge(time_product_Data, prodDesc, by="ProductID", all.x = TRUE)
joinedData
str(joinedData)
table(joinedData$WgrClassCodeDesc)
hist(joinedData$ProductID, col="green", breaks=30, xlab="WarenGrp", main="Histogram of # of WarenGroup") 
library(plyr)
count(joinedData$WgrClassCodeDesc)



#----------------------------
# Etc
# 1. time format conversion 
timeData <- formatC(sortedData$TimeID, width=4, flag="0") #pad 0 if time has 3 digits
timeData
format(strptime(timeData, format="%H%M"), format = "%H:%M")
timeData
