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

sub_metering_1 <- as.numeric(subsetted_household_data$Sub_metering_1)
sub_metering_2 <- as.numeric(subsetted_household_data$Sub_metering_2)
sub_metering_3 <- as.numeric(subsetted_household_data$Sub_metering_3)

png("plot3.png", width=500, height=500)
plot(datetime, sub_metering_1, type="l", ylab="Energy sub_metering", xlab="", col="green")
lines(datetime, sub_metering_2, type="l", col="red")
lines(datetime, sub_metering_3, type="l", col="yellow")
legend("right", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("green", "red", "yellow"))
dev.off()

