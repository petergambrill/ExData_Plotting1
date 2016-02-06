## Download and unzip file if not already done so
if (!file.exists("household_power_consumption.txt")) {
  library(downloader)
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download(url, dest="dataset.zip", mode="wb") 
  unzip ("dataset.zip")
  dateDownloaded <- date()
}

## Read file and subset
setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
hhpower <- read.csv2("household_power_consumption.txt", colClasses = c("Date" = "myDate"))
hhpower <- subset(hhpower, hhpower$Date >= "2007/02/01" & hhpower$Date <= "2007/02/02")

##Create variables to plot
Global_active_power <- as.numeric(as.character(hhpower$Global_active_power))
datetime <- paste(hhpower$Date, hhpower$Time, sep = " ")
datetime <- strptime(datetime, format = "%Y-%m-%d %H:%M:%S")
Sub_metering_1 <- as.numeric(as.character(hhpower$Sub_metering_1))
Sub_metering_2 <- as.numeric(as.character(hhpower$Sub_metering_2))
Sub_metering_3 <- as.numeric(as.character(hhpower$Sub_metering_3))
Voltage <- as.numeric(as.character(hhpower$Voltage))
Global_reactive_power <- as.numeric(as.character(hhpower$Global_reactive_power))

##Open a graphics window (will only work in windows not OSX)
windows(5,5)

##Plot 4

##Top left
par( mfcol = c(2,2),mar = c(4, 4, 2, 2))
plot(datetime, Global_active_power, type="o",pch="", ylab="Global Active Power (kilowatts)",
     xlab="")

##Bottom left
plot(datetime, Sub_metering_1, type="o", pch="", ylab="Energy sub metering", xlab="")
points(datetime, Sub_metering_2, type="o", pch="", col="Red")
points(datetime, Sub_metering_3, type="o", pch="", col="Blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       , col=c('black', 'red', 'blue'), lty = 1, cex = 0.5)

##Top right
plot(datetime, Voltage, type="o",pch="", ylab="Voltage",
     xlab="datetime")

##Bottom right
plot(datetime, Global_reactive_power, type="o",pch="", ylab="Global_reactive_power",
     xlab="datetime")

## Save plot as PNG file
savePlot( filename = "plot4", type = "png")

##Close graphics window
graphics.off()

