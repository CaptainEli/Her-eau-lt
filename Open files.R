# Libraries
install.packages("raster")
install.packages("ncdf4")

# Load packages
library(raster)
library(ncdf4)
df2015 <- raster("C:/Documents/Etudes/M2 & doctorat - UT2J/Doctorat/Workshops/Hackathon le climat en données 2 - 4-12-25/Hackathon-climat-github/data/2015.nc")

### SCRATCH THAT
## Using script from Pignard et al. (2023) here: 
# https://entrepot.recherche.data.gouv.fr/dataset.xhtml?persistentId=doi:10.57745/KQPYA4

## Nettoyage de l'environnement de travail
rm(list=ls())

## Download missing packages
install.packages("RNetCDF")
install.packages("FAO56")

## Chargement des packages
library(RNetCDF) #package pour lire les données météo
library(lubridate) #package pour manipuler les dates
library(readr)
library(FAO56)

## Direction fichier de travail
setwd(choose.dir("C:/Documents/Etudes/M2 & doctorat - UT2J/Doctorat/Workshops/Hackathon le climat en données 2 - 4-12-25/Hackathon-climat-github/data")) #bien mettre des anti slash et pas slash

##ouverture fichiers
pluies_histo <- open.nc("2015.nc", TRUE) #ouvre les fichiers nc
liste_pr_histo <- read.nc(pluies_histo, TRUE) #permet de lire les fichiers nc sous forme de liste
