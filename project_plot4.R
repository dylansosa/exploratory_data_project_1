setwd("/Users/Dylan/Documents/Semester\ 4.2/Data\ Science/ExplData")

inf <- "data.zip"
if (!file.exists(inf)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, inf, method="curl")
}  
if (!file.exists("household_power_consumption")) { 
    unzip(inf) 
}

dataFile <- "./household_power_consumption.txt"
household_data <- read.table(dataFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subsetted_household_data <- household_data[household_data$Date %in% c("1/2/2007","2/2/2007") ,]

date_time <- strptime(paste(subsetted_household_data$Date, subsetted_household_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
global_active_power <- as.numeric(subsetted_household_data$Global_active_power)
global_reactive_power <- as.numeric(subsetted_household_data$Global_reactive_power)
voltage <- as.numeric(subsetted_household_data$Voltage)
sub_metering_1 <- as.numeric(subsetted_household_data$Sub_metering_1)
sub_metering_2 <- as.numeric(subsetted_household_data$Sub_metering_2)
sub_metering_3 <- as.numeric(subsetted_household_data$Sub_metering_3)

png("plot44.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2, col="darkgreen")

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="",col="green")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="yellow")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("green", "red", "yellow"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()