# Code for classifying images
# finora abbiamo fatto analisi non statistiche, ora calcoliamo una percentuale di cambiamento (usando la CLASSIFICAZIONE)
# data un'immagine colorata con una certa composizione di bande, possiamo visualizzare come ogni pixel si distribuisce nello spazio spettrale plottandolo in un grafico a tre assi (riflettanza tre bande)
# i pixel dello steso "tipo" si distribuiranno nella stessa zona dello spazio spettrale: possiamo quindi creare delle CLASSI
# dato un nuovo pixel, possiamo calcolarne la distanza spettrale dalle varie classi: apparterrà alla classe da cui ha la distanza minima (si può ripetere il processo per ogni pixel)
# --> creiamo dei "training sites" (pixel iniziali per definire le classi) e tutto il resto viene classificato automaticamente associando i pixel alla classe più vicina


install.packages("patchwork")
library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)


im.list()

mato1992=im.import("matogrosso_l5_1992219_lrg.jpg")       #il NIR è montato sulla componente rossa
mato1992=flip(mato1992)
plot(mato1992)                                            #quanto sarà la percentuale di foresta?
mato2006=im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006=flip(mato2006)
plot(mato2006)

mato1992c=im.classify(mato1992, num_clusters=2)        #cluster = classe
     #class1=forest  class2=human (in realtà tutto ciò che non è foresta: l'acqua non si può distinguere dal suolo)
#non sempre le classi hanno lo stesso ordine: l'inizio dei training sites è casuale!
#unsupervised classification = non inseriamo noi i training sites, fa da sola

mato2006c=im.classify(mato2006, num_clusters=2)
     #class1=forest  class2=human
#si può far sì che la classificazione parta sempre allo stesso modo dando un numero nell'argomento "seed"


f1992=freq(mato1992c)         #frequenze dei pixel (riportate come "count")
tot1992=ncell(mato1992c)         #totale pixel dell'immagine
prop1992=f1992/tot1992         #proporzioni dei pixel ("count")
perc1992=prop1992*100
     #forest=83%  human=17%

tot2006=ncell(mato2006c)
perc2006=freq(mato2006c)*100/tot2006         #fatto in un passaggio solo
     #forest=45%  human=54%


# creating dataframe
class=c("Forest","Human")
y1992=c(83,17)
y2006=c(45,55)
tab_mato=data.frame(class,y1992,y2006)

p1=ggplot(tab_mato, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2=ggplot(tab_mato, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1+p2
p1/p2

p0=im.ggplot(mato1992)
p00=im.ggplot(mato2006)
p0+p00+p1+p2



#--- solar orbiter
im.list()
solar=im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#exercise: classify the image in 3 classes
solar_c=im.classify(solar, num_clusters=3)
#eexercise: plot the original image beside the classified one
im.multiframe(1,2)
plot(solar)
plot(solar_c)

# 1=low
# 2=medium
# 3=high
dev.off()
solar_c_s=subst(solar_c, c(1,2,3), c("low","medium","high"))
plot(solar_c_s)

#exercise: calculate the percentages of the sun energy classes with one line of code
perc_solar=freq(solar_c_s)*100/ncell(solar_c_s)   #non funzia
perc_solar=freq(solar_c_s)$count*100/ncell(solar_c_s)
#create dataframe
class=solar_c_s$value
perc=perc_solar
tabsol=data.frame(class,perc)     #non funziona

#final ggplot
ggplot(tabsol, aes(x=class, y=perc, fill=class, col=class)) + geom_bar(stat="identity") +
  coord_flip
