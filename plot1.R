## Downloading the files
if(!file.exists("./data")) {
        dir.create("./data")
}
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "./data")

## Read the data
require(lubridate)
power <- read.table(unzip("household_power_consumption.zip", "household_power_consumption.txt"), sep = ";", header = T)
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")
power$Time <- hms(power$Time)
data <- power[power$Date >= "2007-02-01" & power$Date <= "2007-02-02", ]

## Plotting the data
