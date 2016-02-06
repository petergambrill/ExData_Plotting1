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

##Create variable to plot
Global_active_power <- as.numeric(as.character(hhpower$Global_active_power))

##Plot 1
par( mfcol = c(1,1))
hist(Global_active_power, xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", col = "Red")

##Copy out to PNG file
dev.copy(png, file = "plot1.png") 
dev.off()