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
## Code for creating the plot
png("plot1.png", width = 480, height = 480)
hist(subset_power$Global_active_power, col = "red", xlab = "Global active Power (kilowatts)", main = "Global Active Power")
dev.off()
