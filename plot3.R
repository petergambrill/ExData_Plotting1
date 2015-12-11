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

##create variables to plot
datetime <- paste(hhpower$Date, hhpower$Time, sep = " ")
datetime <- strptime(datetime, format = "%Y-%m-%d %H:%M:%S")
Sub_metering_1 <- as.numeric(as.character(hhpower$Sub_metering_1))
Sub_metering_2 <- as.numeric(as.character(hhpower$Sub_metering_2))
Sub_metering_3 <- as.numeric(as.character(hhpower$Sub_metering_3))

##Open a graphics window (will only work in windows not OSX)
windows(5,5)

##Plot 3
par( mfcol = c(1,1))
plot(datetime, Sub_metering_1, type="o", pch="", ylab="Energy sub metering", xlab="")
points(datetime, Sub_metering_2, type="o", pch="", col="Red")
points(datetime, Sub_metering_3, type="o", pch="", col="Blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1
       ,col=c('black', 'red', 'blue'), cex = 0.8)

##Save plot as PNG
savePlot( filename = "plot3", type = "png")

##Close grahpics window
graphics.off()