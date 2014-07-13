###############################################
#READ DATA FOR Feb, 1, 2007 through Feb 2, 2007
#convert date and time columns to date and time
###############################################

power <- read.table("household_power_consumption.txt", header = FALSE,
                    sep =";", na.strings = "?", stringsAsFactors = FALSE, 
                    col.names = c("Date", "Time", "Global_active_power", 
                                  "Global_reactive_power", "Voltage", 
                                  "Global_intensity", "Sub_metering_1", 
                                  "Sub_metering_2", "Sub_metering_3"), 
                    skip = 66637, nrows = 2880)
power$DateTime <- as.POSIXct(paste(power$Date, power$Time), format="%d/%m/%Y %H:%M:%S")
power$Time <- strptime(power$Time, "%T")
power$Date <- as.Date(power$Date, "%d/%m/%Y")


#Open PNG Device
png(filename = "plot4.png", width = 480, height = 480)

#Build Histogram
par(mfrow = c(2, 2), bg=NA)
with(power, {
        plot(DateTime, Global_active_power, xlab= "", ylab="Global Active Power", type = "l")
        plot(DateTime, Voltage, xlab = "datetime", ylab="Voltage", type = "l")
        with(power, plot(DateTime, Sub_metering_1, xlab= "", ylab="Energy sub metering", type = "l"))
        with(power, lines(DateTime, Sub_metering_2, col = "red3"))
        with(power, lines(DateTime, Sub_metering_3, col = "blue"))
        legend("topright", bty = "n", lty = 1, col = c("black", "blue", "red3"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(DateTime, Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l")
})

#exit graphic device
dev.off()