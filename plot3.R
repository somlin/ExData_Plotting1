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

#Get all the data for 2 days ( 2007-02-01 to 2007-02-02 )
final.data <- subset(consum.data,Date < "2007-02-03 00:00:00")

#Generate the plot and save it to the disk
png(filename="plot3.png")
plot(final.data$Date,final.data$Sub_metering_1,pch=".",type="l",
     xlab="",ylab="Energy sub metering")
lines(final.data$Date,final.data$Sub_metering_2,col="red")
lines(final.data$Date,final.data$Sub_metering_3,col="blue")
legend("topright", legend= c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,lwd=1,col=c("black","red","blue"))
#Close the Graphic device
dev.off()