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

## Plotting the data
with(data, {plot(Sub_metering_1 ~ Datetime, type = "l",
                ylab = "Energy sub metering", xlab = "")
points(Sub_metering_2 ~ Datetime, type = "l",
                ylab = "Energy sub metering", xlab = "",
                col = "red")
points(Sub_metering_3 ~ Datetime, type = "l",
                ylab = "Energy sub metering", xlab = "",
                col = "blue")})
legend("topright",  col = c("black", "red", "blue"), lty = 1, lwd = 2,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving plot as picture
png("plot3.png", width = 500, 500)
dev.off()
