# Coursera: Exploratory Data Analysis
# Project : Project 1
# File    : plot4.R
# Date:   : July 12, 2014
# Summary : This reads a data file from the UC Irvine Machine Learning Repository
#           on Electric Power Consumption and creates a plot, one of four, that
#           matches a layout presented in the assignment.
# Input   : This code presumes the file household_power_consumption.txt is in
#           the current working directory. 
#           NOTE: Per the TAs in the Forums it was validated this presumption 
#           worked with the need to document it.
# Output   : plot4.png - in your current working directory the file plot4.png is created
# Details : See Coursera Project description online for detailed descrption

# If your running this code by hand **remember** to set your current working directory

# an approach to just get the selected dates from the file
library(sqldf) 
loadhpcdf <- read.csv2.sql("household_power_consumption.txt",sql="SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'",sep=";",na.strings="?" )
hpcdf <- loadhpcdf
# convert Date value to a date, per layout date in format dd/mm/yyyy
hpcdf$Date <- as.Date(hpcdf$Date, format="%d/%m/%Y")
# Need to get POSIX style time so need to combine date and time, note paste
# creates a character vector
temp <- paste(hpcdf$Date, hpcdf$Time)
# now convert it to POSIXlt time format
temp <- strptime(temp, format="%Y-%m-%d %H:%M:%S")
hpcdf$Time <- temp
# Build Graphics output
png("plot4.png", width = 480, height = 480, unit = "px")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1)) ## set margins smaller, and out margin bigger
with(hpcdf, {
  plot(Time, Global_active_power, type="l", ylab="Global Active Power", xlab="")
  plot(Time, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Time,Sub_metering_1, type = "l", ylab="Energy sub metering", xlab="")
  lines(hpcdf$Time,hpcdf$Sub_metering_2, col = "red")
  lines(hpcdf$Time,hpcdf$Sub_metering_3, col = "blue")
  legtext <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  legend("topright", legend = legtext, col=c("black", "red", "blue"), lty = 1, bty ="n")
  plot(Time, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
})
dev.off()