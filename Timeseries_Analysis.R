#----------------------------------------------------
# Time-Series Analysis of factSalesTransaction.csv
# June 6. 2017 
#
# Soojung Hong 
#---------------------------------------------------

#--------------------
# library 
install.packages('plyr')

#plot
install.packages("ggplot2")
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


#----------------
# purchased time 
timeData <- data.frame(partialData$TimeID, partialData$GrossAmount)
                    
timeData

theme_set(theme_bw()) # Change the theme to my preference
ggplot(aes(x = partialData.TimeID, y = partialData.GrossAmount), data = timeData) + geom_point()

#time format conversion 
timeData <- formatC(partialData$TimeID, width=4, flag="0") #pad 0 if time has 3 digits
timeData
format(strptime(timeData, format="%H%M"), format = "%H:%M")
timeData
theme_set(theme_bw()) # Change the theme to my preference
ggplot(aes(x = timeID, y = GrossPrice), data = timeData) + geom_point()
