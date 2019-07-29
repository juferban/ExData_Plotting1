### Code to generate the first plot of the assignment

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

png("plot1.png", height = 480, width = 480)

hist(as.numeric(febHP$Global_active_power), 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",) 

dev.off()

