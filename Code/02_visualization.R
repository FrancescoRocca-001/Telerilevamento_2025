# R code for visualizing satellite data

install.packages("viridis")
# install.packages("devtools")
library(devtools)
install_github("ducciorocchini/imageRy")

library(terra)
library(imageRy)
library(viridis)


#for the whole course we are going to use = instead of <-


im.list()

#sentinel bands: https://custom-scripts.sentinel-hub.com/custom-scripts/sentinel-2/bands/

#importiamo la banda 2 di sentinel = riflettanza delle tofane nella lunghezza d'onda del blu, rappresentata con scala blu-giallo
b2=im.import("sentinel.dolomites.b2.tif")
cl=colorRampPalette(c("black","dark grey","light grey"))(100)         #cambiare scala colori (tra parentesi il numero di gamme)
plot(b2,col=cl)
cl = colorRampPalette(c("black", "dark grey", "light grey"))(3)
plot(b2, col=cl)

# Exercise: make your own color ramp
cl2=colorRampPalette(c("blueviolet","gold2","seagreen1"))(100)
plot(b2,col=cl2)


#importing other bands
b3=im.import("sentinel.dolomites.b3.tif")          #banda del verde
b4=im.import("sentinel.dolomites.b4.tif")          #rosso
b8=im.import("sentinel.dolomites.b8.tif")          #NIR


#funzione grafica per aprire finestre vuote
par(mfrow=c(1,4))         #multiframe = grafico con più immagini all'interno
plot(b2)
plot(b3)
plot(b4)
plot(b8)

dev.off()         #spegne il device grafico (usare quando abbiamo problemi di natura grafica)

im.multiframe(1,4)         #fa la stessa cosa con una funzione sola (pacchetto imageRy)
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

cl=colorRampPalette(c("black","light gray"))(100)            #se non si fa dev.off(), rimane il multiframe impostato
plot(b2,col=cl)
plot(b3,col=cl)
plot(b4,col=cl)
plot(b8,col=cl)


# STACK (pacchetto di dati) = creare l'immagine satellitare intera con tutte le bande messe insieme
# terra prende le bande come elementi di un vettore
sent=c(b2,b3,b4,b8)            #dati impacchettati
plot(sent,col=cl)              #con uno stack, vengono plottati anche i nomi delle immagini

names(sent)=c("b2-blue","b3-green","b4-red","b8-NIR")              #cambiare i nomi (funzione names)
plot(sent,col=cl)
plot(sent)         #tornare al colore originale

#plottare un solo elemento da uno stack
dev.off()
plot(sent$b8NIR)        #ho dovuto cambiare il nome perchè non va bene il trattino
plot(sent[[4]])         #subset: []


#importing several bands altogether (perchè sono simili e impilabili)
sentdol=im.import("sentinel.dolomites")            #si usa la parte comune del nome di tutti i dati che vogliamo

pairs(sentdol)          #correlazioni tra i layer



#viridis (colorblind friendly): https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
plot(sentdol,col=viridis(100))
plot(sentdol,col=mako(100))



# 1 - band 2(blue)
# 2 - band 3(green)
# 3 - band 4(red)
# 4 - band 8(NIR)

# plottare più bande insieme per ottenere un'immagine a colori (usando schema RGB)
# Natural colors
im.plotRGB(sentdol,r=3,g=2,b=1)           #associare i layer ai tre canali
          # il nostro occhio fa fatica a distinguere gli oggetti, non c'è un buon contrasto
          # usiamo anche il NIR, che ci permette di distinguere bene le piante

# False colors
im.plotRGB(sentdol,r=4,g=3,b=2)           #non si possono usare 4 layer: li facciamo scorrere ed eliminiamo il blu (quella che dà meno info)
          # ora il rosso ci indica la vegetazione e la risoluzione è migliore
im.plotRGB(sentdol,r=3,g=4,b=2)

im.multiframe(1,2)
im.plotRGB(sentdol,r=2,g=4,b=3)         #r e b sono invertibili perchè le bande del visibile sono molto correlate (pairs)
im.plotRGB(sentdol,r=3,g=4,b=1)

dev.off()
im.plotRGB(sentdol,r=3,g=2,b=4)       #di solito così il suolo diventa giallo per i minerali presenti (non si vede qui)

# si può usare anche come im.plotRGB(name, 1, 2, 3)
