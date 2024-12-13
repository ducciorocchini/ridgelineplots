library(terra)
library(imageRy)
library(ggplot2)

# Example (Figure 1)

ndvin <- im.import("NDVI_2020")
names(ndvin) <- c("layer1", "layer1", "layer1", "layer1")
im.ridgeline(ndvin, 2, "magma")

# NDVI set sempirical example

# Data
setwd("~/Downloads/brentasent/sentinel_2_rgb_ndvi_dolomiti_brenta")

# NDVI file
l <- list.files(pattern="NDVI")
n <- lapply(l, rast)

ndvi <- c(n[[1]], n[[2]], n[[3]], n[[4]], n[[5]], n[[6]], n[[7]], n[[8]], n[[9]], n[[10]], n[[1]], n[[12]])

# Ridgeline plot
names(ndvi) <- c("01 January","02 February","03 March","04 April","05 May","06 June","07 July","08 August","09 September","10 October","11 November","12 December")
im.ridgeline(ndvi, 2, "mako")

