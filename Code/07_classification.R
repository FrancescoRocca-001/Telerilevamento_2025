# Code for classifying images
# finora abbiamo fatto analisi non statistiche, ora calcoliamo una percentuale di cambiamento (usando la CLASSIFICAZIONE)
# data un'immagine colorata con una certa composizione di bande, possiamo visualizzare come ogni pixel si distribuisce nello spazio spettrale plottandolo in un grafico a tre assi (riflettanza tre bande)
# i pixel dello steso "tipo" si distribuiranno nella stessa zona dello spazio spettrale: possiamo quindi creare delle CLASSI
# dato un nuovo pixel, possiamo calcolarne la distanza spettrale dalle varie classi: apparterrà alla classe da cui ha la distanza minima (si può ripetere il processo per ogni pixel)
# --> creiamo dei "training sites" (pixel iniziali per definire le classi) e tutto il resto viene classificato automaticamente associando i pixel alla classe più vicina


install.packages("patchwork")      #serve per unire tra loro dei grafici fatti con ggplot2 (più velocemente che con un multiframe)
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
     #forest=45%  human=55%


# creating DATAFRAME (= tabella)
class=c("Forest","Human")        #definiamo le tre colonne della tabella
year1992=c(83,17)
year2006=c(45,55)
tab_mato=data.frame(class,year1992,year2006)       #crea una tabella

p1 = ggplot(tab_mato,          #funzione base per fare plot in ggplot2: crea solo la struttura del grafico
          aes(x=class, y=year1992, color=class))          #aesthetics: definire chi va in x, chi va in y, come colorare diversamente gli istogrammi (solo contorno)
     + geom_bar(               #funzione per definire tipo di grafico (geom_points è un'altra)
          stat="identity",          #tipo di statistica: non dobbiamo fare medie, deviazioni standard... solo usare i valori iniziali
          fill="white")          #colore interno istogrammi
     + ylim(c(0,100))          #definisce limiti del grafico (perchè siano tutti e due in scala), qui è una funzione!!

p2 = ggplot(tab_mato, aes(x=class, y=year2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))

p1+p2       #mettere accanto due grafici (patchwork), serve che siano associati a oggetti
p1/p2       #metterli in verticale

# --> ora abbiamo un grafico statistico reale


p0=im.ggplot(mato1992)       #funzione di imageRy (ma pensata per plottare una banda sola: plotta la prima -> NIR)
p00=im.ggplot(mato2006)
p0+p00+p1+p2


# per mettere colonne uniche che vanno a 100%:
# https://stackoverflow.com/questions/52684424/show-the-percentage-instead-of-count-in-histogram-using-ggplot2-r

# per colorare le colonne come il contorno basta mettere "fill" in "aes"
ggplot(tab_mato, aes(x=class, y=y2006, fill=class, color=class)) + geom_bar(stat="identity") + ylim(c(0,100))

# https://www.sthda.com/english/wiki/ggplot2-barplots-quick-start-guide-r-software-and-data-visualization

# barre orizzontali: funzione coord_flip()
ggplot(tab_mato, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100)) + coord_flip()
ggplot(tab_mato, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100)) + coord_flip()

# dataframe un po' diverso per poter plottare 4 colonne insieme
classall = c("Forest1992","Human1992","Forest2006","Human2006")
percentage = c(83,17,45,55)
all = data.frame(classall, percentage)
ggplot(all, aes(x=classall, y=percentage, color=classall)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))




# Solar Orbiter
im.list()
solar=im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")        #gas del sole a diversi livelli energetici

# exercise: classify the image in 3 classes (livelli energetici)
solar_c=im.classify(solar, num_clusters=3)
# exercise: plot the original image beside the classified one
im.multiframe(1,2)
plot(solar)
plot(solar_c)

# 1=low   2=high   3=medium
# rinominare le classi (così non importa l'ordine)
dev.off()
solar_c_s=subst(solar_c, c(1,2,3), c("low","high","medium"))        #funzione per sostituire dei valori nelle celle
plot(solar_c_s)

# exercise: calculate the percentages of the sun energy classes with one line of code
perc_solar=freq(solar_c_s)*100/ncell(solar_c_s)        #non funziona stavolta perchè "freq(solar_c_s)" contiene una colonna di stringhe (high, low, medium) che non possono essere moltiplicate *100
perc_solar=freq(solar_c_s)$count*100/ncell(solar_c_s)        #viene moltiplicata solo la colonna "count"
      # low = 37.33   medium = 41.45   high = 21.22

#create dataframe
class=freq(solar_c_s)$value
perc=perc_solar
tabsol=data.frame(class,perc)

#final ggplot
ggplot(tabsol, aes(x=class, y=perc, fill=class, col=class)) + geom_bar(stat="identity") + coord_flip()
     # + ylim(c(0,100)) 
