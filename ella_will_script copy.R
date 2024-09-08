library(ggplot2) 
library(tidyverse)
setwd("/Users/ella/Desktop/BIOL3140 R/Module 1/Scales")

5000/3

dat <- read.csv("scales.csv")

dim(dat)
head(dat)

#using $
class(dat$N)
class(dat$quadrant)
class(dat$species)
class(dat$specimen)

mean(dat$N)
mean(dat$quadrant)

sapply(dat,class)
?sapply()

#num of species? 
dat$species <- as.factor(dat$species)
species <- levels(dat$species)
species

length(species)

#subset data frame 
dat$species==species[1]

#find length of sub-set vectors
A.rup<-length(dat$species[dat$species==species[1]])
L.gib<-length(dat$species[dat$species==species[2]])
L.mac<-length(dat$species[dat$species==species[3]])
M.sal<-length(dat$species[dat$species==species[4]])
M.sax<-length(dat$species[dat$species==species[5]])
P.fla<-length(dat$species[dat$species==species[6]])

#combine results with species
species.obs <- data.frame(sp=species,n=c(A.rup,L.gib,L.mac,M.sal,M.sax,P.fla))
species.obs 

#find num of punctures/species
dat %>%
  group_by(species) %>%
  summarise(n = n())

#save num of punctures/species in variable
species.n<- dat %>%
  group_by(species) %>%
  summarise(n = n())
species.n

#num of specimens/species? 
dat %>% 
  count(species,specimen) %>%
  print() %>%
  count(species,name = "n.specimens")

#iterating through operations using a for loop
for(i in 1:10) print(i)

for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}

#save as PDF
pdf("species_quadrant.pdf")
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot()+geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}
dev.off()

list.files(pattern=".pdf")