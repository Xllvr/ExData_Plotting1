## Downloading the files
if(!file.exists("./data")) {
        dir.create("./data")
}
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "./data")
setwd("./data")

## Read the data
require(lubridate)
power <- read.table("household_power_consumption.txt", na.strings = "?",
                    sep = ";", header = T, stringsAsFactors = FALSE)
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
data <- power[power$Date >= "2007-02-01" & power$Date <= "2007-02-02", ]

## Create data for date-time
require(dplyr)
data <- mutate(data, Datetime = as.POSIXct(paste(data$Date, data$Time)))

## Setting parameters
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

## Plotting the data
with(data, {
        plot(Global_active_power ~ Datetime, type = "l",
             ylab = "Global Active Power (kilowatts)", xlab = "")
        plot(Voltage ~ Datetime, type = "l",
             ylab = "Voltage", xlab = "datetime")
        {plot(Sub_metering_1 ~ Datetime, type = "l",
             ylab = "Energy sub metering", xlab = "")
        points(Sub_metering_2 ~ Datetime, type = "l",
               ylab = "Energy sub metering", xlab = "",
               col = "red")
        points(Sub_metering_3 ~ Datetime, type = "l",
               ylab = "Energy sub metering", xlab = "",
               col = "blue")
        legend("topright",  col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))}
        plot(Global_reactive_power ~ Datetime, type = "l",
             ylab = "Global_reactive_power", xlab = "datetime")
})

## Saving plot as picture
png("plot4.png", width = 500, 500)
dev.off()
