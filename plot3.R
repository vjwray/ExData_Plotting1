# Coursera: Exploratory Data Analysis
# Project : Project 1
# File    : plot3.R
# Date:   : July 12, 2014
# Summary : This reads a data file from the UC Irvine Machine Learning Repository
#           on Electric Power Consumption and creates a plot, one of four, that
#           matches a layout presented in the assignment.
# Input   : This code presumes the file household_power_consumption.txt is in
#           the current working directory. 
#           NOTE: Per the TAs in the Forums it was validated this presumption 
#           worked with the need to document it.
# Output   : plot3.png - in your current working directory the file plot3.png is created
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
# The graphic device being used is PNG file
png("plot3.png", width = 480, height = 480, unit = "px")
with(hpcdf, plot(Time,Sub_metering_1, type = "l", ylab="Energy sub metering", xlab=""))
# use lines to add more lines to the original plot without overwriting it
lines(hpcdf$Time,hpcdf$Sub_metering_2, col = "red")
lines(hpcdf$Time,hpcdf$Sub_metering_3, col = "blue")
# Build legend
legtext <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", legend = legtext, col=c("black", "red", "blue"), lty = 1)
#dev.copy(png, file="plot3.png", width = 480, height = 480) # copy my plot to a PNG file
dev.off()                             # close the PNG device
