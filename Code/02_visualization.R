# R code for visualizing satellite data

# install.packages("devtools")
library(devtools)
install_github("ducciorocchini/imageRy")

library(terra)
library(imageRy)

im.list()

#for the whole course we are going to use = instead of <-

b2=im.import("sentinel.dolomites.b2.tif")
cl=colorRampPalette(c("black","dark grey","light grey"))(100)
plot(b2,col=cl)

cl2=colorRampPalette(c("blueviolet","gold2","seagreen1"))(100)
plot(b2,col=cl2)
