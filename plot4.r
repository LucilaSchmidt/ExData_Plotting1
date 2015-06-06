source("projectExploratoryAnalysis.r")

png(filename="plot4.png", width = 480, height = 480)

par(mfcol=c(2,2))

plot2()
plot3()
plot4topright()
plot4bottomright()


dev.off()


