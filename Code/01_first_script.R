#first R coding from scratch

2+3

#OGGETTO e ASSEGNAZIONE
anna<-2+3 #assign an operation to an object
chiara<-4+6

anna+chiara


#VETTORE(ARRAY) = set di elementi(ARGOMENTI)
filippo <- c(0.2,0.4,0.6,0.8,0.9)           #concatenate
luca <- c(100,80,60,50,10)

#correlazione
plot(luca, filippo)
plot(luca,filippo,pch=19)       #point character
plot(luca,filippo,pch=19,col="blue")
plot(luca,filippo,pch=19,col="blue",cex=2)        #character exaggeration
plot(luca,filippo,pch=19,col="blue",cex=2,xlab="rubbish",ylab="biomass")



#installing packages
#CRAN
#terra: Spatial Data Analysis
install.packages("terra")        #funzione per installare dal CRAN
library(terra)                   #richiamare il pacchetto

install.packages("devtools")         #Tools to Make Developing R Packages Easier
library(devtools)
install_github("ducciorocchini/imageRy")         #installare da github (funzione dentro devtools)
library(imageRy)
