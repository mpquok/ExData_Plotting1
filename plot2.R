###############################################
#READ DATA FOR Feb, 1, 2007 through Feb 2, 2007
#convert date and time columns to date and time
#add column combining date and time columns into
#date AND time structure
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
png(filename = "plot2.png", width = 480, height = 480)

#Build Scatterplot
par(bg=NA)
with(power, plot(DateTime, Global_active_power, xlab= "", ylab="Global Active Power (kilowatts)", type = "l"))

#exit graphic device
dev.off()
