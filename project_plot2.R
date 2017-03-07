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

datetime <- strptime(paste(subsetted_household_data$Date, subsetted_household_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalActivePower <- as.numeric(subsetted_household_data$Global_active_power)
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kW)")
dev.off()
