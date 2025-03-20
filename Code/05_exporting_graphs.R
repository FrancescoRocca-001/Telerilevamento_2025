#this code helps exporting graphs to images

setwd("C:/Users/franc/Downloads")
getwd()

pdf("output.pdf")
plot(grdif)
dev.off()

jpeg("output.jpeg")
plot(grdif)
dev.off()
