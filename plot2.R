###################################################
## 1.3.2017 
## Exploratory Analysis Project 1 - Part 2 of 4
## UC Irvine Data set: Electric power consumption
## Reproduce a histogram of Global Active Power
## Create plot2.png
## Restrict Dates to: 2007-02-01 and 2007-02-02
## Note: missing data is coded as ? in dataset
###################################################

## Get data

fileloc <- "./exdata_data_household_power_consumption/household_power_consumption.txt"
readLines(fileloc,10)
## Note: setting column class to "date" expects a certain ordering "year/month/day"
##      however the data is set up as "day/month/year".  can use read.zoo to set date format, 
##      but chose to import as character and convert to date
columnClasses <- c("character","character","numeric","numeric","numeric","numeric","numeric", "numeric","numeric")
EPCdata <- read.table(fileloc, header = TRUE, sep = ";", na.strings = "?", colClasses = columnClasses)

##Data checks
summary(EPCdata)
colSums(is.na(EPCdata))
table(EPCdata$Date)

## subset data on dates: 2007-02-01 & 2007-02-02
## "Date" is still character vector, will convert after subsetting 
## current format: "d/m/yyyy"
EPC <- EPCdata[EPCdata$Date == "1/2/2007"|EPCdata$Date == "2/2/2007", ]
## add datetime; not necessary for plot 1 but needed for the others
EPC$Datetime <- strptime(paste(EPC$Date,EPC$Time, sep =" "),format = "%d/%m/%Y %H:%M:%S")

## Open graphical device: png 
png(filename = "plot2.png")

## Recreate graph
with(EPC, plot(Datetime,Global_active_power, type = "l", xlab = "",
               ylab = "Global Active Power (kilowatts)"))

## Close graphics device
dev.off()
