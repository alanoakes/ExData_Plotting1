#!/bin/bash

## LOAD LIBRARY & DATASET
library(lubridate)
Plots.x1<-read.table("household_power_consumption.txt",
               header=T,sep=";")

## FORMAT, SUBSET & CREATE DATES --------------------------
### format date data types in 'Plot.x1' and 
Plots.x1$Date<-as.character(Plots.x1$Date)
Plots.x1$Time<-as.character(Plots.x1$Time)
Plots.x1$Date<-dmy(Plots.x1$Date)
Plots.x1$Time<-hms::as.hms(Plots.x1$Time)
### subset for 48 hours in February 2007
Plots.x1<-subset(Plots.x1,Date>="2007-02-01"&Date<="2007-02-02")
### make 'datetime' vector
Plots.x1$datetime<-paste(Plots.x1$Date,Plots.x1$Time,sep=" ")
Plots.x1$datetime<-as.POSIXct(Plots.x1$datetime,format=c("%Y-%m-%d %H:%M:%OS"))

## format needed data types in 'Plot.x1' -------------------
Plots.x1$Global_active_power  <-as.integer(Plots.x1$Global_active_power)
Plots.x1$Global_active_power  <-Plots.x1$Global_active_power/1000
Plots.x1$Global_reactive_power<-as.integer(Plots.x1$Global_reactive_power)
Plots.x1$Voltage              <-as.integer(Plots.x1$Voltage)
Plots.x1$Sub_metering_1       <-as.integer(Plots.x1$Sub_metering_1)
Plots.x1$Sub_metering_2       <-as.integer(Plots.x1$Sub_metering_2)
Plots.x1$Sub_metering_3       <-as.integer(Plots.x1$Sub_metering_3)

## PLOT4 ---------------------------------------------------
png("Plot4",width=480,height=480)
par(mfrow=c(2,2))
plot(Plots.x1$datetime,Plots.x1$Global_active_power,type="l",
     xlab="",ylab="Global Active Power (kilowatts)")
plot(Plots.x1$datetime,Plots.x1$Voltage,type="l",
     xlab="datetime",ylab="Voltage")
plot(Plots.x1$datetime,Plots.x1$Sub_metering_1,type="n",
     xlab="",ylab="Energy Sub Metering")
  points(Plots.x1$datetime,Plots.x1$Sub_metering_1,type="l",col="black")
  points(Plots.x1$datetime,Plots.x1$Sub_metering_2,type="l",col="red")
  points(Plots.x1$datetime,Plots.x1$Sub_metering_3,type="l",col="blue")
  legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(Plots.x1$datetime,Plots.x1$Global_reactive_power,type="l",
     xlab="datetime",ylab="Global_Reactive_Power")
dev.off()