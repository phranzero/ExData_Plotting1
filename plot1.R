# R Script for generating Global Active Power histogram (aka Plot 1)

# Check for existing data set in working directory. Download/decompress if needed
if(!file.exists("household_power_consumption.txt")) {
    if(!file.exists("exdata%2Fdata%2Fhousehold_power_consumption.zip")){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      "exdata%2Fdata%2Fhousehold_power_consumption.zip", mode = "wb")
    }
    unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")
}


data <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings = "?",
                   colClasses = c("character","character", rep("numeric", 7)))

# Subset to specific dates of interest
data <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007",]

# Combine date and time columns into one and convert to Date class
data$Date <- with(data, paste(Date, Time))
data$Date <- strptime(data$Date, format="%d/%m/%Y %H:%M:%S")
data$Time <- NULL

#Create histogram plot
hist(data$Global_active_power, main = "Global Active Power", col = "#DC401A", 
     xlab = "Global Active Power (kilowatts)")

#Save as PNG file
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()