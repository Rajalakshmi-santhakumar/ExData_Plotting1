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
mydata$Global_reactive_power <- as.numeric(as.character(mydata$Global_reactive_power))
mydata$Voltage <- as.numeric(as.character(mydata$Voltage))
mydata$Sub_metering_1 <- as.numeric(as.character(mydata$Sub_metering_1))
mydata$Sub_metering_2 <- as.numeric(as.character(mydata$Sub_metering_2))
mydata$Sub_metering_3 <- as.numeric(as.character(mydata$Sub_metering_3))
rm(data)

#Converting dates and time
mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")
mydata<- transform(mydata, datetime =as.POSIXct(paste(mydata$Date, mydata$Time)), format = "%d/%m/%y %H:%M:%S")

#Creating the plots (row-wise) in png file
png (file="plot4.png", width=480, height=480)
par (mfrow = c (2, 2), mar = c (4,4,2,1), oma=c(0,0,2,0))
with(mydata, {
plot(Global_active_power~datetime, type ="l", xlab ="", ylab = "Global Active Power")
plot(Voltage~datetime, type ="l", xlab ="datetime", ylab = "Voltage")
plot(Sub_metering_1~datetime, type ="l", xlab ="", ylab = "Energy Sub Metering", col ="black")
lines(Sub_metering_2~datetime,col = "red")
lines(Sub_metering_3~datetime,col = "blue")
legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1, lwd=2, bty="n")
plot(Global_reactive_power~datetime, type ="l", xlab ="datetime", ylab = "Global Reactive Power")
})
dev.off()
graphics.off()