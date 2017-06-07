#---------------------------------------
# Analysis of dimProduct.csv
# May 29. 2017 
#
# Soojung Hong 
#---------------------------------------

#---------------------------------------
# Set training data and connect to it 
# 
trainingData <- 'C:/Users/a613274/Downloads/AthExportData/dimProduct.csv'
con = file(trainingData, "r")

#----------------
# Read 20 rows
partialData <- read.csv(con, nrows=100)
partialData
str(partialData)

