# R code for visualizing satellite data

install.packages("viridis")
# install.packages("devtools")
library(devtools)
install_github("ducciorocchini/imageRy")

library(terra)
library(imageRy)
library(viridis)

im.list()
#sentinel bands: link

#for the whole course we are going to use = instead of <-

b2=im.import("sentinel.dolomites.b2.tif")
cl=colorRampPalette(c("black","dark grey","light grey"))(100)
plot(b2,col=cl)

cl2=colorRampPalette(c("blueviolet","gold2","seagreen1"))(100)
plot(b2,col=cl2)


# bands
b3=im.import("sentinel.dolomites.b3.tif")
b4=im.import("sentinel.dolomites.b4.tif")
b8=im.import("sentinel.dolomites.b8.tif")

par(mfrow=c(1,4))
plot(b2)
plot(b3)
plot(b4)
plot(b8)

dev.off()     #cancella il grafico

im.multiframe(1,4)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

#Exercise: plot the bands using im.multiframe() one on top of the other
im.multiframe(4,1)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

im.multiframe(2,2)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

cl=colorRampPalette(c("black","light gray"))(100)
plot(b2,col=cl)
plot(b3,col=cl)
plot(b4,col=cl)
plot(b8,col=cl)

sent=c(b2,b3,b4,b8)
plot(sent,col=cl)

names(sent)=c("b2-blue","b3-green","b4-red","b8-NIR")
plot(sent,col=cl)
plot(sent)     #tornare al colore originale

plot(sent$b8NIR)      #ho dovuto cambiare il nome perchè non va bene il -
plot(sent[[4]])

#importing several bands altogether
sentdol=im.import("sentinel.dolomites")

#how to import several sets altogether
pairs(sentdol)



#viridis
plot(sentdol,col=viridis(100))
plot(sentdol,col=mako(100))


# 1 - band 2(blue)
# 2 - band 3(green)
# 3 - band 4(red)
# 4 - band 8(NIR)

# Natural colors
im.plotRGB(sentdol,r=3,g=2,b=1)

# False colors
im.plotRGB(sentdol,r=4,g=3,b=2)

im.plotRGB(sentdol,r=3,g=4,b=2)

im.multiframe(1,2)
im.plotRGB(sentdol,r=2,g=4,b=3)
im.plotRGB(sentdol,r=3,g=4,b=1)

dev.off()
im.plotRGB(sentdol,r=3,g=2,b=4)

