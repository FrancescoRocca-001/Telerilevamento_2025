#R code for principal component analysis

library(terra)
library(imageRy)

im.list()

sent=im.import("sentinel.png")
sent=flip(sent)
plot(sent)

sent=c(sent[[1]],sent[[2]],sent[[3]])
# band1=nir band2=red band3=green

sent_pca=im.pca(sent)
tot=73+55+6
#134
73*100/tot
sent_pca=im.pca(sent, n_samples=100000)

sd_pc1=focal(sent_pca[[1]], w=c(3,3), fun="sd")
plot(sd_pc1)


