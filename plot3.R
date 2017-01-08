library(dplyr)
library(lubridate)
library (graphics)
library (grDevices)
#Reading the entire data and converting dates
data <- read.table(file = "household_power_consumption.txt", header=T, sep = ";", dec = ".")

## Subsetting the data
mydata <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
mydata <- na.omit(mydata)
mydata$Sub_metering_1 <- as.numeric(as.character(mydata$Sub_metering_1))
mydata$Sub_metering_2 <- as.numeric(as.character(mydata$Sub_metering_2))
mydata$Sub_metering_3 <- as.numeric(as.character(mydata$Sub_metering_3))
rm(data)

#Converting dates and time
mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")
mydata<- transform(mydata, datetime =as.POSIXct(paste(mydata$Date, mydata$Time)), format = "%d/%m/%y %H:%M:%S")

#Creating the plot in png file
png (file="plot3.png", width=480, height=480)
plot(mydata$datetime, mydata$Sub_metering_1, type ="l", xlab ="", ylab = "Energy Sub Metering", col ="black")
lines(mydata$datetime, mydata$Sub_metering_2,col = "red")
lines(mydata$datetime, mydata$Sub_metering_3,col = "blue")
legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, lwd=2)
dev.off()
graphics.off()