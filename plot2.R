filePath <- "exdata_data_household_power_consumption\\household_power_consumption.txt"
data <- read.table(file = filePath, sep = ";", header = TRUE, na.strings = c("?"), colClasses = c("character","character","numeric",rep("NULL", 6)))
data <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
data$Date <- as.character(as.Date(data$Date, format = "%d/%m/%Y"))
data$DateTime <- paste(data$Date, data$Time, sep = " ")
data <- data[order(data$DateTime),c("DateTime","Global_active_power")]
data <- data[!is.na(data$Global_active_power),]
data$DateTimePOSIX <- strptime(data$DateTime,format='%Y-%m-%d %H:%M:%S')

png(file="plot2.png", width = 480, height = 480, units = "px")
plot(data$DateTimePOSIX,data$Global_active_power, main = "", xlab = "", ylab = "Global Active Power (kilowatts)", col = "black", type = "l")
dev.off()