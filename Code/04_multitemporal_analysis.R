# R code for multitemporal analysis (= analizzare cambiamenti nel tempo)

install.packages("ggridges")     #needed to create ridgeline plots
library(terra)
library(imageRy)
library(viridis)
library(ggridges)     #non servirebbe perchè lo richiama im.ridgeline


im.list()

EN_01=im.import("EN_01.png")       #ossidi di azoto durante il lockdown (European Nitrogen)
EN_01=flip(EN_01)
plot(EN_01)                        #inizio gennaio

EN_13=im.import("EN_13.png")
EN_13=flip(EN_13)
plot(EN_13)                        #fine marzo

im.multiframe(1,2)
plot(EN_01)
plot(EN_13)

EN_dif = EN_01[[1]] - EN_13[[1]]         #queste immagini hanno 3 livelli per comporre i colori RGB, non sono associate a bande
plot(EN_dif)                         #quello che è chiaro aveva valore maggiore a gennaio, quello scuro aveva valore maggiore a marzo
plot(EN_dif,col=inferno(100))


# Greenland ice melt
gr=im.import("greenland")        #dati di temperatura (Copernicus) a 16 bit
grdif=gr[[4]]-gr[[1]]          #4 strati che corrispondono a 4 anni
plot(grdif)                #dove è giallo è aumentata la temperatura



ARRIVATO QUI



#ridgeline plots

im.ridgeline(gr, scale=1)
im.ridgeline(gr, scale=2)
im.ridgeline(gr, scale=2, palette="inferno")

im.list()
#exercise: import the NDVI data from sentinel
ndvi=im.import("Sentinel2")
im.ridgeline(ndvi,scale=2)   #male!

#changing names
#sources     : Sentinel2_NDVI_2020-02-21.tif  
#             Sentinel2_NDVI_2020-05-21.tif  
#             Sentinel2_NDVI_2020-08-01.tif  
#             Sentinel2_NDVI_2020-11-27.tif  

names(ndvi)=c("02_feb","05_may","08_aug","11_nov")
im.ridgeline(ndvi,scale=2)
im.ridgeline(ndvi,scale=2, palette="mako")


pairs(ndvi)

plot(ndvi[[1]],ndvi[[2]])
# y=x --> may=feb
# y = a + bx
# a=0, b=1 --> y=x
abline(0,1, col="red")
plot(ndvi[[1]],ndvi[[2]],xlim=c(-0.3,0.9),ylim=c(-0.3,0.9))
abline(0,1, col="red")

im.multiframe(1,3)
plot(ndvi[[1]])
plot(ndvi[[2]])
plot(ndvi[[1]],ndvi[[2]],xlim=c(-0.3,0.9),ylim=c(-0.3,0.9))
abline(0,1, col="red")
