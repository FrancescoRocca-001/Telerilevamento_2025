# Calculating spatial variability
# finora abbiamo analizzato solo la variabilità nel tempo
# la variabilità nello spazio può essere relazionata alla biodiversità (diversità spettrale -> classi vegetazionali -> numero di specie)
# in geologia un'intrusione di minerali può dare un aumento di variabilità

library(terra)
library(imageRy)
library(viridis)
library(patchwork)
install.packages("RStoolbox")
library(RStoolbox)


# STANDARD DEVIATION: https://www.cuemath.com/data/standard-deviation/
# tre età: 24 26 25
M=(24+26+25)/3      #media
sc_quad=(24-M)^2+(26-M)^2+(25-M)^2      #scarto quadratico
v=sc_quad/3      #varianza
sd=sqrt(v)

sd(c(24,25,26))      #questa però calcola la SD del campione (N-1) -> non fa differenza quando il campione è grande

sd(c(24,25,26,49))      #inserendo un dato fuori dalla distribuzione originale, SD aumenta
mean(c(24,26,25,49))      #anche la media si sposta: quando abbiamo un outlier si usa la mediana anzichè la media, perchè varia molto meno



im.list()
sent=im.import("sentinel.png")       #immagine pre-analizzata del ghiacciaio del similaun
sent=flip(sent)
plot(sent)       # band1=NIR, 2=red, 3=green, 4: solo una banda di controllo

# exercise: plot the image in RGB with the NIR on top of the red component
sent_rgb=im.plotRGB(sent, r=1,g=2,b=3)

# exercise: make three plots with NIR on top of each component
im.multiframe(1,3)
im.plotRGB(sent, r=1,g=2,b=3)
im.plotRGB(sent, r=2,g=1,b=3)
im.plotRGB(sent, r=3,g=2,b=1)
      #la parte evidenziata dal NIR sono praterie di alta quota, il nero è l'acqua, il giallo (nel terzo) è il suolo nudo, il bianco è neve o nuvole (con dati ottici non si possono rimuovere, con radar sì)




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




#what to do in case of huge images
sent=im.import("sentinel.png")
sent=flip(sent)
plot(sent)

ncell(sent)*nlyr(sent)

sent_agg=aggregate(sent, fact=2)
ncell(sent_agg)*nlyr(sent_agg)

sent_agg5=aggregate(sent, fact=5)
ncell(sent_agg5)*nlyr(sent_agg5)

#exercise: make a multiframe and plot in RGB the 3 images
im.multiframe(1,3)
im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent_agg, r=1, g=2, b=3)
im.plotRGB(sent_agg5, r=1, g=2, b=3)

#calculating standard deviation
dev.off()
nir_agg=sent_agg[[1]]
sd3_agg=focal(nir_agg, w=c(3,3), fun="sd")
plot(sd3_agg)

#exercise: calculate the standard deviation for the factor 5 image
nir_agg5=sent_agg5[[1]]
sd3_agg5=focal(nir_agg5, w=c(3,3), fun="sd")
plot(sd3_agg5)

sd5_agg5=focal(nir_agg5, w=c(5,5), fun="sd")
plot(sd5_agg5)


im.multiframe(2,2)
plot(sd3)
plot(sd3_agg)
plot(sd3_agg5)
plot(sd5_agg5)

p1=im.ggplot(sd3)
p2=im.ggplot(sd3_agg)
p3=im.ggplot(sd3_agg5)
p4=im.ggplot(sd5_agg5)
p1+p2+p3+p4


#variance
var3=sd3^2
dev.off()
plot(var3)

im.multiframe(1,2)
plot(sd3)
plot(var3)

sd5=focal(nir, w=c(5,5), fun="sd")
var5=sd5^2
plot(sd5)
plot(var5)
