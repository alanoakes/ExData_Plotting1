#!bin/bash

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

## format needed data types in 'Plot.x1' -------------------
Plots.x1$Global_active_power  <-as.integer(Plots.x1$Global_active_power)
Plots.x1$Global_active_power  <-Plots.x1$Global_active_power/1000

## PLOT1 ---------------------------------------------------
png("Plot1",width=480,height=480)
hist(Plots.x1$Global_active_power,
    col="red",
    main="Global Active Power",
    xlab="Global Active Power (kilowatts)",
    ylab="Frequency"
)
dev.off()