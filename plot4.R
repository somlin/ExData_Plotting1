#Reading 4000 rows of data from the data while starting when date=="1/2/2007" 
header <- read.table('household_power_consumption.txt', nrows = 1, 
                     header = FALSE, sep =';', stringsAsFactors = FALSE)
consum.data <- read.table("household_power_consumption.txt",header=TRUE,
                          sep=";",skip=(grep("1/2/2007", 
                                             readLines("household_power_consumption.txt"))),
                          nrows=4000,stringsAsFactors = FALSE)
colnames( consum.data ) <- unlist(header)

#Convert the data in Date field to class Date with as.Date()
consum.data$Date <- strptime(paste(consum.data$Date,consum.data$Time),
                             format="%d/%m/%Y %H:%M:%S")

# Get all the data for 2 days ( 2007-02-01 to 2007-02-02 )
final.data <- subset(consum.data,Date < "2007-02-03 00:00:00")

#Generate the plot and save it to the disk
png(filename="plot4.png")
#Break the complete pgae to accomodate 4 plots
par(mfrow=c(2,2))
#Plot-1
#--------
plot(final.data$Date,final.data$Global_active_power,pch=".",xlab="",
     ylab="Global Active Power")
lines(final.data$Date,final.data$Global_active_power)
#Plot-2
#-------
plot(final.data$Date,final.data$Voltage,pch=".",xlab="datetime",ylab="Voltage")
lines(final.data$Date,final.data$Voltage)
#Plot-3
#--------
plot(final.data$Date,final.data$Sub_metering_1,pch=".",type="l",
     xlab="",ylab="Energy sub metering")
lines(final.data$Date,final.data$Sub_metering_2,col="red")
lines(final.data$Date,final.data$Sub_metering_3,col="blue")
legend("topright", legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty ="n",lty=1,lwd=1,col=c("black","red","blue"))
#Plot-4
#-------
plot(final.data$Date,final.data$Global_reactive_power,pch=".",
     xlab="datetime",ylab="Global_reactive_power",yaxt="n")
lines(final.data$Date,final.data$Global_reactive_power)
axis(2, at=pretty(final.data$Global_reactive_power), 
     lab=pretty(final.data$Global_reactive_power), las=TRUE)
#Close the graphic device
dev.off()