# Libraries
install.packages("raster")
install.packages("ncdf4")

# Load packages
library(raster)
library(ncdf4)
df2015 <- raster("C:/Documents/Etudes/M2 & doctorat - UT2J/Doctorat/Workshops/Hackathon le climat en données 2 - 4-12-25/Hackathon-climat-github/data/2015.nc")
