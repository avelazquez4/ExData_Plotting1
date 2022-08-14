# Plot 3

## Load packages
library(dplyr)
library(ggplot2)
library(png)

## Estimate memory needed 
# memory required = no. of column * no. of rows * 8 bytes/numeric
# memory = 9 * 2075259 * 8 = 149,418,648

## read in data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip")

epc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
object.size(epc)
#actual memory is 150,050,248 bytes

# Format Date and Time columns
epc$Date <- as.Date(epc$Date, format = "%d/%m/%Y")
epc$Time <- format(epc$Time, format = "%H:%M:%S")
str(epc)
summary(epc)

#Filter tp only use data from the dates 2007-02-01 and 2007-02-02. 
epc <- epc %>%
  filter(Date >= "2007-02-01" & Date<= "2007-02-02")

summary(epc)
str(epc)

#Convert columns to numeric
epc[3:8] <- lapply(epc[3:8], FUN = function(y){as.numeric(y)})
str(epc)
summary(epc)


#Plot 3
png("plot3.png")
plot(epc$Sub_metering_1, type = "l", main = "", col = "black", ylab = "Energy sub metering", xlab = "", axes=FALSE, ylim = c(0,40))
par(new=T)
plot(epc$Sub_metering_2, type = "l", main = "", col = "red", ylab = "", xlab = "", axes=FALSE, ylim = c(0,40))
par(new=T)
plot(epc$Sub_metering_3, type = "l", main = "", col = "blue", ylab = "", xlab = "", axes=FALSE, ylim = c(0,40))
axis(1, at = c(0, 1500, 2900), labels = c("Thu", "Fri", "Sat"))
axis(2, at = c(0, 10, 20, 30))
legend("topright",legend=c("sub-metering1","sub-metering2","sub-metering3"),col=c("black","red","blue"),lty=c(1,1,1),lwd=2)
box(lty = 1, col = 'black')
dev.off()

