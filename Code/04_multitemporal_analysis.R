# R code for multitemporal analysis (= analizzare cambiamenti nel tempo)

install.packages("ggridges")     #needed to create ridgeline plots (based on ggplot2)
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



# RIDGELINE PLOTS:
# dai dati originali, creano una distribuzione di frequenze per ogni anno (si può fare con qualsiasi tipo di dataset)

im.ridgeline(gr, scale=1)        #prende il valore di tutti i pixel e ne calcola la frequenza (richiama delle funzioni di ggridges)
im.ridgeline(gr, scale=2)        #scale definisce quanto può essere alto al massimo un picco
im.ridgeline(gr, scale=2, palette="inferno")        #argomento non obbligatorio


#exercise: import the NDVI data from Sentinel (arco alpino)
im.list()
ndvi=im.import("Sentinel2_NDVI")

im.ridgeline(ndvi,scale=2)      #male! si ottiene un grafico solo perchè le 4 immagini hanno lo stesso nome

# changing names
#sources: Sentinel2_NDVI_2020-02-21.tif  
#         Sentinel2_NDVI_2020-05-21.tif  
#         Sentinel2_NDVI_2020-08-01.tif  
#         Sentinel2_NDVI_2020-11-27.tif  

names(ndvi)=c("02_feb","05_may","08_aug","11_nov")
im.ridgeline(ndvi,scale=2)           #si vede il cambiamento di biomassa con le stagioni
im.ridgeline(ndvi,scale=2, palette="mako")

# questo tipo di output fa vedere come varia tutto il dataset, anzichè solo la differenza tra due immagini



# plottare un dataset rispetto ad un altro
pairs(ndvi)       #questo plotta tutti i layer
plot(ndvi[[1]],ndvi[[2]])       #così plotto solo due layer

# aggiungiamo una linea 1:1 (dove sarebbero i dati se fossero uguali nei due mesi)
# y=x --> may=feb
# y = a + bx
# a=0, b=1 --> y=x
abline(0,1, col="red")
plot(ndvi[[1]],ndvi[[2]],xlim=c(-0.3,0.9),ylim=c(-0.3,0.9))       #stabiliamo gli intervalli mostrati dei due assi
abline(0,1, col="red")
        #i dati di maggio sono quasi sempre maggiori di quelli di febbraio

im.multiframe(1,3)
plot(ndvi[[1]])
plot(ndvi[[2]])
plot(ndvi[[1]],ndvi[[2]],xlim=c(-0.3,0.9),ylim=c(-0.3,0.9))
abline(0,1, col="red")
