fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "./household_power_consumption.txt", method = "curl")
unzip("household_power_consumption.zip")
electricData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
## cleans data
desiredData <- subset(electricData, electricData$Date == "1/2/2007" | electricData$Date == "2/2/2007")
desiredData$newDate <- with(desiredData, as.POSIXct(paste(Date, Time, sep = " "), format="%d/%m/%Y %H:%M:%S"))
pwr <- as.numeric(desiredData$Global_active_power)
desiredData$Global_active_power <- as.numeric(as.character(desiredData$Global_active_power))
## creates Plot 2
png("plot2.png")
plot(desiredData$newDate, desiredData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()