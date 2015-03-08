library("grDevices")
library("graphics")

### PREP DATA
# First read in a few rows to get the class vector
tab5rows <- read.table("household_power_consumption.txt", header = TRUE, nrows = 5, sep = ";")
classes <- sapply(tab5rows, class)

# Read in the first 500,000 rows specifying the column classes to optimize read time
mydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = classes, na.strings = "?", nrows=500000)
summary(mydata)
#str(mydata$Date)
#head(mydata$Date, 20)
#unique(mydata$Date)

# Subset the data to 1 Feb 2007 and 2 Feb 2007 - note the European format
mydata <- mydata[mydata$Date=="1/2/2007" | mydata$Date=="2/2/2007", ]
#summary(mydata)

# Format the Date and Time variables
mydata$DateTime <- strptime(paste(mydata$Date, mydata$Time), "%d/%m/%Y %H:%M:%S")
#class(mydata$DateTime)
#str(mydata$DateTime)
#head(mydata$DateTime, 20)


### CREATE PLOT
# Set up PNG device - transparent background
png(filename="plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "transparent")
hist(mydata$Global_active_power, freq=TRUE, col="red", 
     border="black", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylim = c(0, 1200))
#axis(side=2, at=c(0, 200, 400, 600, 800, 1000, 1000, 1200))
dev.off()


