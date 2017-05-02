fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "./household_power_consumption.txt", method = "curl")
unzip("household_power_consumption.zip")
electricData <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
## cleans data
desiredData <- subset(electricData, electricData$Date == "1/2/2007" | electricData$Date == "2/2/2007")
desiredData$newDate <- with(desiredData, as.POSIXct(paste(Date, Time, sep = " "), format="%d/%m/%Y %H:%M:%S"))
pwr <- as.numeric(desiredData$Global_active_power)
## creates Plot 1
png("plot1.png")
hist(pwr, freq = TRUE, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
dev.off()