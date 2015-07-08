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

#plot - global active power vs days
plot(dtime, as.numeric(data$Global_active_power), type="l", xlab="", ylab="Global Active Power (kilowatts)")

#save it to a PNG file
dev.copy(png, file='plot2.png', width=480, height=480)

#close the device
dev.off()