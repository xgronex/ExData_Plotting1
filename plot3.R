filePath <- "exdata_data_household_power_consumption\\household_power_consumption.txt"
data <- read.table(file = filePath, sep = ";", header = TRUE, na.strings = c("?"), colClasses = c("character","character",rep("NULL", 4),rep("numeric",3)))
data <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
data$Date <- as.character(as.Date(data$Date, format = "%d/%m/%Y"))
data$DateTime <- paste(data$Date, data$Time, sep = " ")
data <- data[order(data$DateTime),c("DateTime", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]
data <- data[!(is.na(data$Sub_metering_1)|is.na(data$Sub_metering_2)|is.na(data$Sub_metering_3)),]
data$DateTimePOSIX <- strptime(data$DateTime,format='%Y-%m-%d %H:%M:%S')

png(file="plot3.png", width = 480, height = 480, units = "px")
plot(data$DateTimePOSIX,data$Sub_metering_1, main = "", xlab = "", ylab = "Energy sub metering", type = "n")
points(data$DateTimePOSIX, data$Sub_metering_1, col="black", type="l")
points(data$DateTimePOSIX, data$Sub_metering_2, col="red", type="l")
points(data$DateTimePOSIX, data$Sub_metering_3, col="blue", type="l")
legend("topright", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1))
dev.off()