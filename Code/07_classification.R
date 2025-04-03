#code for classifying images

install.packages("patchwork")
library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

im.list()

mato1992=im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992=flip(mato1992)
plot(mato1992)

mato2006=im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006=flip(mato2006)
plot(mato2006)

mato1992c=im.classify(mato1992, num_clusters=2)
#class1=forest  class2=human
mato2006c=im.classify(mato2006, num_clusters=2)
#class1=forest  class2=human

f1992=freq(mato1992c)
tot1992=ncell(mato1992c)
prop1992=f1992/tot1992
perc1992=prop1992*100
#human=17%  forest=83%

tot2006=ncell(mato2006c)
perc1992=freq(mato2006c)*100/tot2006
#human=54%  forest=45%

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
