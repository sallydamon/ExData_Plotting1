fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "./household_power_consumption.txt", method = "curl")
unzip("household_power_consumption.zip")
electricData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
## cleans data
desiredData <- subset(electricData, electricData$Date == "1/2/2007" | electricData$Date == "2/2/2007")
desiredData$newDate <- with(desiredData, as.POSIXct(paste(Date, Time, sep = " "), format="%d/%m/%Y %H:%M:%S"))
pwr <- as.numeric(desiredData$Global_active_power)
desiredData$Global_active_power <- as.numeric(as.character(desiredData$Global_active_power))
desiredData$newMeter1 <- as.numeric(as.character(desiredData$Sub_metering_1))
desiredData$newMeter2 <- as.numeric(as.character(desiredData$Sub_metering_2))
desiredData$newMeter3 <- as.numeric(as.character(desiredData$Sub_metering_3))
## creates Plot 3
png("plot3.png")
plot(desiredData$newDate, desiredData$newMeter1, type = "l", ylim = c(0, max(desiredData$newMeter1, desiredData$newMeter3, desiredData$newMeter2)), xlab = "", ylab = "Energy sub metering")
lines(desiredData$newDate, desiredData$newMeter2, type = "l", col = "red")
lines(desiredData$newDate, desiredData$newMeter3, type = "l", col = "blue")
legend("topright", lty = c(1,1,1), col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()