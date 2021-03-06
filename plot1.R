# This block of code is to read file from URL and create subset of data for plot function

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("data")){
        dir.create("data")
}

if(!file.exists("./data/exdata-data-household_power_consumption.zip")){
        download.file(fileURL,"./data/exdata-data-household_power_consumption.zip")
        unzip("./data/exdata-data-household_power_consumption.zip", exdir="./data")
}

filename <- "./data/household_power_consumption.txt"
        
df <- read.table(filename,header=TRUE,sep=";",colClasses=c("character","character",rep("numeric",7)),na="?")

df$Time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

df$Date <- as.Date(df$Date, "%d/%m/%Y")

dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")

df <- subset(df, Date %in% dates)

# Following block of code creates the graph using base package

png("plot1.png", width=400, height=400)

hist(df$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     col="red")

dev.off()



