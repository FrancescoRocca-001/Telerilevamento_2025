#calculating spatial variability

library(terra)
library(imageRy)
library(viridis)
library(patchwork)
install.packages("RStoolbox")
install.packages("sf")
library(RStoolbox)
library(sf)

# 24 26 25
M=(24+26+25)/3
sc_quad=(24-M)^2+(26-M)^2+(25-M)^2
v=sc_quad/3
sd=sqrt(v)

sd(c(24,25,26))

sd(c(24,25,26,49))



im.list()
sent=im.import("sentinel.png")
sent=flip(sent)
#band1=NIR, 2=red, 3=green

#exercise: plot the image in RGB with the NIR on top of the red component
im.plotRGB(sent, r=1,g=2,b=3)

#exercise: make three plots with NIR on top of each component
im.multiframe(1,3)
im.plotRGB(sent, r=1,g=2,b=3)
im.plotRGB(sent, r=2,g=1,b=3)
im.plotRGB(sent, r=3,g=2,b=1)


nir=sent[[1]]

#exercise: plot the nir band with the inferno color ramp palette
dev.off()
plot(nir, col=inferno(100))


sd3=focal(nir, w=c(3,3), fun="sd")
plot(sd3)

im.multiframe(1,2)
im.plotRGB(sent, r=1, g=2, b=3)
plot(sd3)

sd5=focal(nir, w=c(5,5), fun="sd")
plot(sd5)

#exercise: use ggplot to plot the standard deviation
im.ggplot(sd3)

#exercise: plot the two sd maps one beside another with ggplot
p_sd3=im.ggplot(sd3)
p_sd5=im.ggplot(sd5)
p_sd3+p_sd5


#plot the original dev and the stdev
p_nir=im.ggplot(nir)
p_nir + p_sd3
