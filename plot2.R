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
mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")
mydata<- transform(mydata, datetime =as.POSIXct(paste(mydata$Date, mydata$Time)), format = "%d/%m/%y %H:%M:%S")

#Creating the plot in png file
plot(mydata$datetime, mydata$Global_active_power, type ="l", xlab ="", ylab = "Global Active Power (kilowatts)") 
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
graphics.off()