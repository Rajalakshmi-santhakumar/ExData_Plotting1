library(dplyr)
library(lubridate)
library (graphics)
library (grDevices)
#Reading the entire data and converting dates
data <- read.table(file = "household_power_consumption.txt", header=T, sep = ";", dec = ".")

## Subsetting the data
mydata <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
mydata <- na.omit(mydata)
mydata$Global_active_power <- as.numeric(as.character(mydata$Global_active_power))
rm(data)

#Converting dates and time
mydata[,1] <- as.Date(mydata[,1], format="%d/%m/%Y")
datetime <- strptime(paste(mydata$Date, mydata$Time, sep=""), format = "%d/%m/%y %H:%M:%S")

#Creating a histogram in png file
hist(mydata$Global_active_power, col ="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power") 
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
graphics.off()