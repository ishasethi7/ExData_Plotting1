#### Download data if it dosen't exist
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("power.zip")) {
  download.file(fileurl, dest="power.zip", mode="wb")
}
#### Read the data in data frame : power
power <- read.table(unz("power.zip", "household_power_consumption.txt"), sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
## Convert the Date column to date class
power$Date <- as.Date(power$Date, "%d/%m/%Y")
## Subset the dataframe to select for 2 dates
subset_power <- subset(power, Date == '2007-02-01'| Date == '2007-02-02')
## Make a datetime variable and add it back to the subsetted dataframe 
DateTime <- paste(subset_power$Date, subset_power$Time)
DateTime <- strptime(DateTime, format = "%Y-%m-%d %H:%M:%S")
subset_power <- transform(subset_power, DateTime = DateTime)
## Code for creating the plot
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(subset_power$DateTime, subset_power$Global_active_power, ylab = "Global Active Power", xlab = "", pch ="")
lines(subset_power$DateTime, subset_power$Global_active_power)
plot(subset_power$DateTime, subset_power$Voltage, ylab = "Voltage", xlab = "datetime", pch ="")
lines(subset_power$DateTime, subset_power$Voltage)
plot(subset_power$DateTime, subset_power$Sub_metering_1, pch ="", ylab = "Energy sub metering", xlab = "")
lines(subset_power$DateTime, subset_power$Sub_metering_1)
lines(subset_power$DateTime, subset_power$Sub_metering_2, col = "red")
lines(subset_power$DateTime, subset_power$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty =1, col = c("Black", "Red", "Blue"))
plot(subset_power$DateTime, subset_power$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", pch ="")
lines(subset_power$DateTime, subset_power$Global_reactive_power)
dev.off()
