library("grDevices")
library("graphics")

### PREP DATA
# The data is in the working directory
# First read in a few rows to get the class vector
tab5rows <- read.table("household_power_consumption.txt", header = TRUE, nrows = 5, sep = ";")
classes <- sapply(tab5rows, class)

# Read in the first 500,000 rows specifying the column classes to optimize read time
mydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = classes, na.strings = "?", nrows=500000)
summary(mydata)


# Subset the data to 1 Feb 2007 and 2 Feb 2007 - note the European format
mydata <- mydata[mydata$Date=="1/2/2007" | mydata$Date=="2/2/2007", ]


# Format the Date and Time variables
mydata$DateTime <- strptime(paste(mydata$Date, mydata$Time), "%d/%m/%Y %H:%M:%S")



### CREATE PLOT
# Set up PNG device - transparent background
png(filename="plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "transparent")
plot(mydata$DateTime, mydata$Sub_metering_1, 
     type = "l",
     ylab = "Energy sub metering",
     ylim = c(0, 38),
     xlab = "")
lines(mydata$DateTime, mydata$Sub_metering_2, type = "l", col = "red")
lines(mydata$DateTime, mydata$Sub_metering_3, type = "l", col = "blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lty = 1,
       lwd = 1.5)
dev.off()



