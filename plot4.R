# R Script for generating 4 plots (aka Plot 4)

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

par(mfcol = c(2,2), ps = 11, mar = c(5,4,3,2))

#Create time series plot for Global Active Power
with(data, plot(Date, Global_active_power, type = "l", ylab = "Global Active Power",
                xlab = ""))

#Create time series plot for Sub metering
with(data, plot(Date, Sub_metering_1, type = "n", ylab = "Energy sub metering",
                xlab = ""))
with(data, lines(Date, Sub_metering_1))
with(data, lines(Date, Sub_metering_2, col = "Red"))
with(data, lines(Date, Sub_metering_3, col = "Blue"))
legend("topright", lty = 1, legend = names(data)[6:8], bty = "n",
       col = c("black","red", "blue"), seg.len = 1)

#Create Voltage time series plot
with(data, plot(Date, Voltage, type = "l", xlab = "datetime"))

#Create Global reactive power time series plot
with(data, plot(Date, Global_reactive_power, type = "l", xlab = "datetime"))

#Save as PNG file
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()