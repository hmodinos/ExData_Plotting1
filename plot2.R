url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip<-"power.zip"
unzip<-"household_power_consumption.txt"

# To avoid uncessary downloads 
# if the file exists skip the download
if(!file.exists("power.zip")){
  file.create("power.zip")
  file<-download.file(url,zip)
}

rawdata <- unz(zip, unzip)
data <- read.table(
  rawdata, header=T, sep=';', na.strings="?", 
  colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
)

data <- data[(data$Date == "1/2/2007") | (data$Date == "2/2/2007"),]
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")  


png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(
  data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"
    )
dev.off()