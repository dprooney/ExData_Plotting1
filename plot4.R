## Load data from file
hpc<-read.table("household_power_consumption.txt",sep=";",nrows=100000,header=TRUE,na.strings="?")

## Select out rows from Feb. 1-2, 2006
hpc$Date<-as.Date(hpc$Date,"%d/%m/%Y")
hpc<-hpc[hpc$Date>=as.Date("2007-02-01") & hpc$Date <=as.Date("2007-02-02"),]

## Convert Date and Time to POSIXct format
hpc$Date<-as.character(hpc$Date)
hpc$Time<-as.character(hpc$Time)
hpc2<-data.frame(strptime(paste(hpc$Date,hpc$Time),format="%Y-%m-%d %H:%M:%S"),hpc[,3:9])
names(hpc2)<-c("DateTime",names(hpc2[,2:8]))

## Plot to .png file

png(file="plot4.png")

par(mfrow=c(2,2))

with(hpc2,plot(DateTime,Global_active_power,type="l",xlab="",ylab="Global Active Power"))

with(hpc2,plot(DateTime,Voltage,type="l",xlab="datetime",ylab="Voltage"))

with(hpc2,plot(DateTime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
lines(hpc2$DateTime,hpc2$Sub_metering_2,col="red")
lines(hpc2$DateTime,hpc2$Sub_metering_3,col="blue")
legend("topright",legend=names(hpc2[,6:8]),col=c("black", "red", "blue"),lty=1,bty="n")

with(hpc2,plot(DateTime,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power (kilowatt)"))

dev.off()