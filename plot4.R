library(datasets)
zipFileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("powerconsumption.zip")) {
	download.file(zipFileUrl, destfile="powerconsumption.zip", method="curl")
	unzip("powerconsumption.zip")
}
data <- read.table('household_power_consumption.txt', sep=';', header=TRUE)
data$DateTime <- paste(data$Date, data$Time, sep=' ')
data[["Date"]] <- as.Date(data[["Date"]], format="%d/%m/%Y")
datasub <- subset(data, Date>="2007-02-01" & Date <="2007-02-02")
datasub[["DateTime"]] <- strptime(datasub[["DateTime"]], format="%d/%m/%Y %H:%M:%S")
GlobalActivePower <- as.numeric(as.character(datasub$Global_active_power))
Voltage <- as.numeric(as.character(datasub$Voltage))
SubMetering1 <- as.numeric(as.character(datasub$Sub_metering_1))
SubMetering2 <- as.numeric(as.character(datasub$Sub_metering_2))
SubMetering3 <- as.numeric(as.character(datasub$Sub_metering_3))
GlobalReactivePower <- as.numeric(as.character(datasub$Global_reactive_power))
par(mfrow=c(2,2))
plot(datasub[["DateTime"]], GlobalActivePower, xlab="", ylab="Global Active Power", bg="white", type="n")
lines(datasub[["DateTime"]], GlobalActivePower, col="black")
plot(datasub[["DateTime"]], Voltage, xlab="datetime", ylab="Voltage", bg="white", type="n")
lines(datasub[["DateTime"]], Voltage, col="black")
plot(datasub[["DateTime"]], SubMetering1, xlab="", ylab="Energy sub metering", bg="white", type="n")
lines(datasub[["DateTime"]], SubMetering1, col="black")
lines(datasub[["DateTime"]], SubMetering2, col="#fe2500")
lines(datasub[["DateTime"]], SubMetering3, col="#0034ff")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "#fe2500", "#0034ff"), lty=1, border="white")
plot(datasub[["DateTime"]], GlobalReactivePower, xlab="datetime", ylab="Global_reactive_power", bg="white", type="n")
lines(datasub[["DateTime"]], GlobalReactivePower, col="black")
dev.copy(png, "plot4.png", width=480, height=480, units="px", bg="white", col="black")
dev.off()
rm(data)
rm(datasub)
rm(zipFileUrl)