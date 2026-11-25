# This code helps exporting graphs to images

setwd("C:/Users/franc/Downloads")        #selezionare la cartella di lavoro (working directory)
                #windows usa i backslash, ma il vero percorso usa gli slash normali
getwd()

pdf("output.pdf")        #crea un file pdf
plot(grdif)         #plottato dentro il pdf
dev.off()         #chiudere il file, altrimenti non viene creato
# file creato nella working directory!

jpeg("output.jpeg")
plot(grdif)
dev.off()

# un pdf è sempre meglio perchè è vettoriale: risoluzione migliore
