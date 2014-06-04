library(datasets)
zipFileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("powerconsumption.zip")) {
	download.file(zipFileUrl, destfile="powerconsumption.zip", method="curl")
	unzip("powerconsumption.zip")
}
data <- read.table('household_power_consumption.txt', sep=';', header=TRUE)
data[["Date"]] <- as.Date(data[["Date"]], format="%d/%m/%Y")
datasub <- subset(data, Date>="2007-02-01" & Date <="2007-02-02")
GlobalActivePower <- as.numeric(as.character(datasub$Global_active_power))
hist(GlobalActivePower, col="#fe2500", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, "plot1.png", width=480, height=480, units="px")
dev.off()
rm(data)
rm(datasub)
rm(GlobalActivePower)
rm(zipFileUrl)