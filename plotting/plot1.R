##NOTE: It is assumed that the zip file is downloaded and extracted in working directory!

#obtain lines with desired dates
lines <- grep('^[1-2]/2/2007', readLines('household_power_consumption.txt'))

#read the wanted lines from txt file with table header
data <- read.table("household_power_consumption.txt",
                  skip = lines[1]-1, nrow = length(lines), sep = ";", 
                  col.names = colnames(read.table(
                          "household_power_consumption.txt",
                          nrow = 1, header = TRUE, sep=";")))

#open a new window
windows()

#plot histogram of global active power with desired atributes
hist(data$Global_active_power, col="red", xlab= 'Global Active Power (kilowatts)', main='Global Active Power')

#save it to a PNG file
dev.copy(png, file='plot1.png', width=480, height=480)

#close the device
dev.off()