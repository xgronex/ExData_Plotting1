filePath <- "exdata_data_household_power_consumption\\household_power_consumption.txt"
data <- read.table(file = filePath, sep = ";", header = TRUE, na.strings = c("?"), colClasses = c("character","character",rep("numeric", 3), "NULL", rep("numeric",3)))
data <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
data$Date <- as.character(as.Date(data$Date, format = "%d/%m/%Y"))
data$DateTime <- paste(data$Date, data$Time, sep = " ")
data <- data[order(data$DateTime),]
data$DateTimePOSIX <- strptime(data$DateTime,format='%Y-%m-%d %H:%M:%S')

png(file="plot4.png", width = 480, height = 480, units = "px")

par(mfcol=c(2,2))
par(mar=c(4,4,4,2))

##### 4.1
plot(data$DateTimePOSIX,data$Global_active_power, main = "", xlab = "", ylab = "Global Active Power", col = "black", type = "l")

##### 4.2
plot(data$DateTimePOSIX,data$Sub_metering_1, main = "", xlab = "", ylab = "Energy sub metering", type = "n")
points(data$DateTimePOSIX, data$Sub_metering_1, col="black", type="l")
points(data$DateTimePOSIX, data$Sub_metering_2, col="red", type="l")
points(data$DateTimePOSIX, data$Sub_metering_3, col="blue", type="l")
legend("topright", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), bty = "n")

##### 4.3
plot(data$DateTimePOSIX,data$Voltage, main = "", xlab = "datetime", ylab = "Voltage", col = "black", type = "l")

##### 4.4
plot(data$DateTimePOSIX,data$Global_reactive_power, main = "", xlab = "datetime", ylab = "Global_reactive_power", col = "black", type = "l")

dev.off()