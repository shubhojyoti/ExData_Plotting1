library(datasets)
zipFileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (file.exists("powerconsumption.zip")) {
	download.file(zipFileUrl, destfile="powercomsumption.zip", method="curl")
	unzip("powercomsumption.zip")
}
data <- read.table('household_power_consumption.txt', sep=';', header=TRUE)
data$DateTime <- paste(data$Date, data$Time, sep=' ')
data[["Date"]] <- as.Date(data[["Date"]], format="%d/%m/%Y")
datasub <- subset(data, Date>="2007-02-01" & Date <="2007-02-02")
datasub[["DateTime"]] <- strptime(datasub[["DateTime"]], format="%d/%m/%Y %H:%M:%S")
plot(datasub[["DateTime"]], datasub[["Sub_metering_1"]], xlab="", ylab="Energy sub metering", bg="white", type="n")
lines(datasub[["DateTime"]], datasub[["Sub_metering_1"]], col="black")
lines(datasub[["DateTime"]], datasub[["Sub_metering_2"]], col="red")
lines(datasub[["DateTime"]], datasub[["Sub_metering_3"]], col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "#fe2500", "#0034ff"), lty=1)
dev.copy(png, "plot3.png", width=480, height=480, units="px", bg="white", col="black")
dev.off()
rm(data)
rm(datasub)
rm(zipFileUrl)