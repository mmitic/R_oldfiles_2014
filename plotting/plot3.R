##NOTE: It is assumed that the zip file is downloaded and extracted in working directory!

#obtain lines with desired dates
lines <- grep('^[1-2]/2/2007', readLines('household_power_consumption.txt'))

#read the wanted lines from txt file with table header
data <- read.table("household_power_consumption.txt",
                   skip = lines[1]-1, nrow = length(lines), sep = ";", 
                   col.names = colnames(read.table(
                           "household_power_consumption.txt",
                           nrow = 1, header = TRUE, sep=";")))

#obtain days from $Date and $Time
dtime <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

#open a new window
windows()

#plot - Sub metering vs days
plot(dtime, as.numeric(data$Sub_metering_1), type="l", xlab="", ylab="Energy sub metering")
lines(dtime, as.numeric(data$Sub_metering_2),type="l", col="red")
lines(dtime, as.numeric(data$Sub_metering_3),type="l", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), cex=0.95, lwd=1, col=c("black","red","blue"))

#save it to a PNG file
dev.copy(png, file='plot3.png', width=480, height=480)

#close the device
dev.off()