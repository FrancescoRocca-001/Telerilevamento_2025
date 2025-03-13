#code fro calculating spectral indices in R

library(imageRy)
library(terra)
library(viridis)

im.list()

mato1992=im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992=flip(mato1992)
plot(mato1992)

# 1=NIR
# 2=red
# 3=green

im.plotRGB(mato1992,r=1,g=2,b=3)
im.plotRGB(mato1992,r=2,g=1,b=3)
im.plotRGB(mato1992,r=2,g=3,b=1)

mato2006=im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006=flip(mato2006)
plot(mato2006)

im.plotRGB(mato2006,r=1,g=2,b=3)

im.multiframe(1,2)
im.plotRGB(mato1992,r=1,g=2,b=3)
im.plotRGB(mato2006,r=1,g=2,b=3)

im.multiframe(3,2)
#NIR on top of red
im.plotRGB(mato1992,r=1,g=2,b=3)
im.plotRGB(mato2006,r=1,g=2,b=3)
#NIR on top of green
im.plotRGB(mato1992,r=2,g=1,b=3)
im.plotRGB(mato2006,r=2,g=1,b=3)
#NIR on top of blue
im.plotRGB(mato1992,r=2,g=3,b=1)
im.plotRGB(mato2006,r=2,g=3,b=1)

dev.off()

# exercise: plot only the first layer of mato2006
plot(mato2006[[1]])
plot(mato2006[[1]],col=magma(100))


# DVI - Difference Vegetation Index
# tree: NIR=255 (8bit), red=0, DVI=NIR-red=255-0=255
# stressed tree: NIR=100, red=30, DVI=100-30=70

#calculating DVI
im.multiframe(1,2)
plot(mato1992)
plot(mato2006)

DVI1992=mato1992[[1]]-mato1992[[2]]     #NIR-red
dev.off()
plot(DVI1992)

#range DVI
#maximum: NIR-red=255-0
#minimum: NIR-red=0-255

plot(DVI1992, col=magma(100))

#calculate DVI for 2006
DVI2006=mato2006[[1]]-mato2006[[2]]
plot(DVI2006)

im.multiframe(1,2)
plot(DVI1992)
plot(DVI2006)


#different radiometric resolutions
#DVI 8 bit: range --> max:255, min:-255
#DVI 4 bit: range --> max:15, min:-15

#NDVI 8 bit (0-255)
#maximum: (NIR-red)/(NIR+red)=(255-0)/(255+0)=1
#minimum: (0-255)/(0+255)=-1
#NDVI 4 bit (0-15)
#max: (15-0)/(15+0)=1
#min: (0-15)/(0+15)=-1

ndvi1992=(mato1992[[1]]-mato1992[[2]])/(mato1992[[1]]+mato1992[[2]])
plot(ndvi1992)
ndvi2006=(mato2006[[1]]-mato2006[[2]])/(mato2006[[1]]+mato2006[[2]])
plot(ndvi2006)

#functions from imageRy
dvi1992auto=im.dvi(mato1992,1,2)
plot(dvi1992auto)
ndvi1992auto=im.ndvi(mato1992,1,2)
plot(ndvi1992auto)



