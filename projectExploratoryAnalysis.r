
library(dplyr)
library(lubridate)

print("Preparing data")

household <<- fread("household_power_consumption.txt", sep=";", nrows=2100000, header=TRUE, data.table=FALSE, colClasses="character", stringsAsFactors=FALSE)
household <- tbl_df(household)


household <- filter(household, dmy(Date) <= ymd("2007-02-02"), dmy(Date) >= ymd("2007-02-01"))
household <- mutate(household, wday = lubridate::wday(Date, label=TRUE))

household$datetime <- strptime(paste(household$Date, household$Time), format="%d/%m/%Y %H:%M:%S")
household$Date <- as.Date(household$Date, format="%d/%m/%Y")

household$Global_active_power <- as.numeric(household$Global_active_power)
household$Voltage <- as.numeric(household$Voltage)
household$Global_intensity <- as.numeric(household$Global_intensity)
household$Global_reactive_power <- as.numeric(household$Global_reactive_power)

household$Sub_metering_1 <- as.numeric(household$Sub_metering_1)
household$Sub_metering_2 <- as.numeric(household$Sub_metering_2)
household$Sub_metering_3 <- as.numeric(household$Sub_metering_3)


print("Preparing process finished.")

###########PLOT FUNCTIONS###########

plot1 <- function(){
        hist(household$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
}


plot2 <- function(){
        with(household, plot(datetime, Global_active_power, type="n", ylab="Global Active Power (kilowatts)", ann=FALSE))
        with(household, lines(datetime, Global_active_power))
}

plot3 <- function(){
        
        with(household, plot(datetime, Sub_metering_1, type="n", ylab="Energy sub metering", ann=FALSE))
        with(household, lines(datetime, Sub_metering_1))
        with(household, lines(datetime, Sub_metering_2, col="red"))
        with(household, lines(datetime, Sub_metering_3, col="blue"))
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n")

}


plot4topright <- function(){
        with(household, plot(datetime, Voltage, type="n", ylab="Voltage"))
        with(household, lines(datetime, Voltage))
        
}

plot4bottomright <- function(){
        with(household, plot(datetime, Global_reactive_power, type="n"))
        with(household, lines(datetime, Global_reactive_power))
        
}