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

#plot2
par(bg="white")
barplot(as.numeric(datatoplot$Global_active_power), ylab="Global Active Power(Kilowatts)", names.arg = datatoplot$dayofweek, inside=FALSE)
dev.copy(png,file="plot2.png",units="px",width=480,height=480)
dev.off()