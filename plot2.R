if(!file.exists("power.zip")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","power.zip")
  unzip("power.zip")
}
data_h<-read.delim2("household_power_consumption.txt",sep=";",na.strings = "?",nrows = 100)
mem_required<-object.size(data_h) * 2075259/100
  print(paste("The object size is",mem_required/1000000,"MB. Memory available is",memory.limit()," MB"));
  
# The required data starts from 66638 to 69517
data<-read.delim2("household_power_consumption.txt",sep=";",na.strings = "?",skip=66636,nrows = 69517 -66637)
  colnames(data)<-colnames(data_h)
  datetime<-dmy_hms(paste(data$Date,data$Time,sep  = " "))
  data<-cbind(data,datetime)
  data<-data[complete.cases(data),]
  
  #Plot 2
 with (data,plot(x=datetime,y=extract_numeric(Global_active_power),ylab="Global Active Power (Kilowatts)",xlab="",type="n"))
with (data,lines(x=datetime,y=extract_numeric(Global_active_power)),ylab="Global Active Power (Kilowatts)")
  dev.copy(device=png,file="Plot2.png",width=480,height=480)
  dev.off()
