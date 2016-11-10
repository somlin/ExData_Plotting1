#Reading 4000 rows of data from the data while starting when date=="1/2/2007" 
header <- read.table('household_power_consumption.txt', nrows = 1, 
                     header = FALSE, sep =';', stringsAsFactors = FALSE)
consum.data <- read.table("household_power_consumption.txt",header=TRUE,
                          sep=";",skip=(grep("1/2/2007", 
                          readLines("household_power_consumption.txt"))),
                          nrows=4000,stringsAsFactors = FALSE)
colnames( consum.data ) <- unlist(header)

#Convert the data in Date field to class Date with as.Date()
consum.data$Date <- as.Date(strptime(consum.data$Date,format="%d/%m/%Y"))

# Get all the data for 2 days ( 2007-02-01 to 2007-02-02 )
final.data <- subset(consum.data,Date<="2007-02-02")

#Generate the plot nad save it to the disk
png(filename="plot1.png")
with(final.data,hist(Global_active_power,col="red",
                     xlab="Global Active Power (kilowatts)",
                     main="Global Active Power"))
dev.off()