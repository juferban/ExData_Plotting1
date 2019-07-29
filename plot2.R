### Code to generate the first plot of the assignment
library(lubridate)
# Downlooad the raw data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "exdata_data_household_power_consumption.zip")

#unzip the raw data folder
unzip("../exdata_data_household_power_consumption.zip")

housePower <- read.table("household_power_consumption.txt", sep = ";", 
                         header = TRUE, 
                         stringsAsFactors = FALSE)

febHP <- subset(housePower, Date %in% c("2/1/2007","2/2/2007")) 

febHP$NewTime <- as.POSIXct(paste0(febHP$Date," ",febHP$Time),
                          format = "%m/%d/%Y %H:%M:%S")

febHP$day <- wday(febHP$NewTime, label = TRUE)

png("plot2.png", height = 480, width = 480)
plot(as.numeric(febHP$Global_active_power) ~ febHP$NewTime, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")

dev.off()
