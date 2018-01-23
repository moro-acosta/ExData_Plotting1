#read a data file
library(data.table)
mydata<-fread("household_power_consumption.txt")

#Handle date/time fields
mydata[,strdate:=paste(Date, Time)]
mydata[,complete_date:=strptime(strdate, "%d/%m/%Y %H:%M:%S", tz = "")]

#subsetting rows between 2007-02-01 and 2007-02-02
initialDate <- strptime("2007-02-01","%Y-%m-%d")
finalDate <- strptime("2007-02-02","%Y-%m-%d")

datatoplot <- mydata[mydata$complete_date >= initialDate & mydata$complete_date <= finalDate,]

#Add column with day of week.
datatoplot[,dayofweek:=weekdays(as.Date(datatoplot$Date))]

#plot3
par(bg="white")
with(datatoplot,barplot(as.numeric(datatoplot$Sub_metering_3), ylim=c(0,35),border = "dark blue", density=FALSE,  space=0)) 
with(datatoplot,barplot(as.numeric(datatoplot$Sub_metering_1), ylab="Energy submettering", names.arg = datatoplot$dayofweek, ylim=c(0,35), border="black", density=FALSE, inside=FALSE, add=TRUE))
with(datatoplot,barplot(as.numeric(datatoplot$Sub_metering_2), ylim=c(0,35),border = "red", density=FALSE,add=TRUE, inside=FALSE))
legend("topright",  legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "dark blue"), lty=c(1,1,1), cex=0.8)
dev.copy(png,file="plot3.png",units="px",width=480,height=480)
dev.off()