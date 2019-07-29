### Code to generate the first plot of the assignment
library(lubridate)
# Downlooad the raw data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "exdata_data_household_power_consumption.zip")

#unzip the raw data folder
unzip("../exdata_data_household_power_consumption.zip")

housePower <- read.table("household_power_consumption.txt", sep = ";", 
                         header = TRUE, 
                         na.strings = "?",
                         stringsAsFactors = FALSE)

housePower$NewTime <- dmy_hms(paste0(housePower$Date," ",housePower$Time))
housePower$Date <- dmy(housePower$Date) 

febHP <- subset(housePower, Date == "2007-02-01" | Date == "2007-02-02")

febHP$day <- wday(febHP$NewTime, label = TRUE)

png("plot4.png", height = 480, width = 480)

par(mfrow=c(2,2))
#plot1
plot(as.numeric(febHP$Global_active_power) ~ febHP$NewTime, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power")

#plot2
plot(as.numeric(febHP$Voltage) ~ febHP$NewTime, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage")

#plot3
plot(x = febHP$NewTime, y = as.numeric(febHP$Sub_metering_3), 
     type = "n", 
     xlab = "", 
     ylab = "Energy sub metering",
     ylim = c(0,40))
lines(x = febHP$NewTime, y = as.numeric(febHP$Sub_metering_1))
lines(x = febHP$NewTime, y = as.numeric(febHP$Sub_metering_2), col="red")
lines(x= febHP$NewTime, y = as.numeric(febHP$Sub_metering_3), col="blue")

legend("topright", 
       lty=1,
       col = c("black","red","blue"), 
       legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty = "n")

#plot4
plot(as.numeric(febHP$Global_reactive_power) ~ febHP$NewTime, 
     type = "l", 
     xlab = "", 
     ylab = "Global_reactive_power")


dev.off()

