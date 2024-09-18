# Original code: Elisa Thouverai

#  Ciao Duccio!
#
# Ti allego un'idea di come potrebbe essere strutturato il codice, senza i dati per provarlo è solo un'idea.
# Visto che non mi era molto chiara la struttura dei dati di input trovi due casi:
#
#     Le immagini di input  (ndvi200,ndvi2001,ndvi2022) vengono considerate come immagini annuali di NDVI e viene plottata la frequenza dell`NDVI per ogni anno;
#     Le immagini annuali contengono come bande immagini mensili per l'NDVI e viene plottata la variazione per ogni anno dell'NDVI medio dell'immagine.
#
#
# Fammi sapere se ci sono problemi, se qualcosa non funziona puoi mandarmi le immagini di partenza per fare delle prove.
#
# Intanto buon pomeriggio,
# Elisa

library(sf)
library(terra)
library(tidyverse)
library(ggplot2)

#FREQUENZA AREA PER ANNO

#Carico lo stack con immagini mensili per ogni anno in una lista
fim <- list.files("...", full.names = T)
ndvi <- rast(fim)

#Stack it
g2000 <- im.import("greenland.2000.tif")
g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

ndvi <- c(g2000, g2005, g2010, g2015)

#Dataframe per il plot
dfndvi <- as.data.frame(ndvi) %>%
  flatten_dbl() %>%
  as.data.frame() %>%
  mutate(year = rep(2000:(2000 + nlyr(r) - 1), each = ncell(r)))
colnames(dfndvi)[1] <- "ndvi"

#Plot frequenze
ggplot(dfndvi, aes(x = ndvi, y = as.factor(year), fill = stat(x))) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
  scale_fill_viridis_c(name = "NDVI", option = "C") 

#SERIE TEMPORALE

#Carico lo stack con immagini mensili per ogni anno in una lista
fim <- list.files("...", full.names = T)
lndvi <- lapply(fim, rast)

#Estraggo ndvi medio 
lndvi <- lapply(lndvi, function(im) {
  df <- as.data.frame(im)
  return(colMeans(df, na.rm = T))
})

#Dataframe per il plot
dfndvi <- do.call(rbind, lndvi)
dfndvi$month <- rep(1:12, each = length(lndvi))

#Plot frequenze
ggplot(dfndvi, aes(x = ndvi, y = month, fill = stat(x))) +
  geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
  scale_fill_viridis_c(name = "NDVI", option = "C") 


