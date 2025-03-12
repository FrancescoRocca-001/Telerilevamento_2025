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

