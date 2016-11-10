#Reading 4000 rows of data from the data while starting when date=="1/2/2007" 
header <- read.table('household_power_consumption.txt', nrows = 1, 
                     header = FALSE, sep =';', stringsAsFactors = FALSE)
consum.data <- read.table("household_power_consumption.txt",header=TRUE,
                          sep=";",skip=(grep("1/2/2007", 
                          readLines("household_power_consumption.txt"))),
                          nrows=4000,stringsAsFactors = FALSE)
colnames( consum.data ) <- unlist(header)

#Convert the data in Date field to class Date with as.Date()
consum.data$Date <- strptime(paste(consum.data1$Date,consum.data1$Time),
                             format="%d/%m/%Y %H:%M:%S")

# Get all the data for 2 days ( 2007-02-01 to 2007-02-02 )
final.data <- subset(consum.data1,Date < "2007-02-03 00:00:00")

#Generate the plot and save it to the disk
png(filename="plot2.png")
with(final.data,plot(Date,Global_active_power,pch=".",
                     xlab="",ylab="Global Active Power (kilowatts)"))
lines(final.data$Date,final.data$Global_active_power)
dev.off()