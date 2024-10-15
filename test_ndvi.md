## Input data:

```r
library(terra)

setwd("~/Downloads/ndvi_ggrdiges_data/per_duccio")

NDVI_2023_01 <- rast("NDVI_2023_01.tif")
NDVI_2023_02 <- rast("NDVI_2023_02.tif")
NDVI_2023_03 <- rast("NDVI_2023_03.tif")
NDVI_2023_04 <- rast("NDVI_2023_04.tif")
NDVI_2023_05 <- rast("NDVI_2023_05.tif")
NDVI_2023_06 <- rast("NDVI_2023_06.tif")
NDVI_2023_07 <- rast("NDVI_2023_07.tif")
NDVI_2023_08 <- rast("NDVI_2023_08.tif")
NDVI_2023_09 <- rast("NDVI_2023_09.tif")
NDVI_2023_10 <- rast("NDVI_2023_10.tif")
NDVI_2023_11 <- rast("NDVI_2023_11.tif")
NDVI_2023_12 <- rast("NDVI_2023_12.tif")

rn <- c(NDVI_2023_01, NDVI_2023_02, NDVI_2023_03, NDVI_2023_04, NDVI_2023_05, NDVI_2023_06, NDVI_2023_07, NDVI_2023_08, NDVI_2023_09, NDVI_2023_10, NDVI_2023_11, NDVI_2023_12)
```

## New names:
``` r
names(rn) <- c("n01_2023", "n02_2023", "n03_2023", "n04_2023", "n05_2023", "n06_2023", "n07_2023", "n08_2023", "n09_2023", "n10_2023", "n11_2023", "n12_2023")
```

## Convert to dataframe
``` r
df <- as.data.frame(rn) 
head(df)
```

and to matrix:
``` r
dfpl <- df %>%
  flatten_dbl() %>%
  as.data.frame() %>%
  mutate(year = rep(names(rn), each = nrow(df)))

colnames(dfpl)[1] <- "value"
```

## Final plot
``` r
ggplot(dfpl, aes(x = value, y = as.factor(year), fill = stat(x))) +
  geom_density_ridges_gradient(scale = 2, rel_min_height = 0.01) +
  scale_fill_viridis_c(option = "magma") 
```
