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

## Plotting the data
hist(data$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")

## Saving plot as picture
png("plot1.png", width = 500, 500)
dev.off()
