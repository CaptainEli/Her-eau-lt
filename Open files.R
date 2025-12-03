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

## Chargement des packages
library(RNetCDF) #package pour lire les données météo
library(lubridate) #package pour manipuler les dates
library(readr)
library(FAO56)


# Année 2016
## Ouverture des fichiers de données
# Ce premier bloc de code permet d'ouvrir les fichiers NetCDF sous forme de liste de liste.

## Ouverture fichiers
pluies_histo <- open.nc("data/precip_merged_with_dates.nc", TRUE) #ouvre les fichiers nc
liste_pr_histo <- read.nc(pluies_histo, TRUE) #permet de lire les fichiers nc sous forme de liste

tmoy_histo<-open.nc("data/temp_herault_2042_2061_with_dates.nc",TRUE)
liste_tmoy_histo<- read.nc(tmoy_histo,TRUE)

## Récupération des données
# Ce bloc de code permet de récupérer dans chaque sous-liste les données nous intéressant (pluies, rayonnement, températures, vent, neige) ainsi que les latitudes, longitudes de chaque point et les dates associées. 

## Récupération des données nécessaires
pluies <- liste_pr_histo[[4]] #matrice des pluies
tmoy <- liste_tmoy_histo[[4]] #matrice des températures

lat <- c(liste_pr_histo[[7]]) #vecteur des latitudes 
latok <- rep(lat,length(liste_pr_histo[[5]])) #vecteur des latitudes répétées 87084 fois (nombre d'heures dans une année bissextile, 2016)
long <- c(liste_pr_histo [[8]]) #vecteur longitudes
longok <-rep(long,length(liste_pr_histo[[5]])) 
time <- c(liste_pr_histo[[5]]) #vecteurs des temps (format étrange)
time2 <- c(as.Date(liste_pr_histo[[10]])) #vecteurs des temps (format YYY-MM-DD CDO)
timerep <- sort(rep(time2,length(liste_pr_histo[[8]]))) #répétition sur les X points en longitude
# as_date(timerep,origin = "1951-01-01") #conversion des chiffres en dates, origine fixé pour avoir un début le 01/01/2043 cf. données

## Extraction des variables d'intérêt
# Ce bloc de code, par une boucle for, permet d'extraire pour chaque jour et chaque point donnée les variables d'intérêt dans le but d'en former plus tard un data frame. Attention, ce bloc de code peut prendre un certain temps à s'exécuter. 

## Boucles for pour obtenir vecteur temps et pluies
prtot=c() #initialisation vecteur pluies vide
tmoyok=c()

for (i in 1:length(liste_pr_histo[[5]])){
  prtot<-c(prtot,c(pluies[,,i]))
  #tmoyok<-c(tmoyok,c(tmoy[,,i]))
} #boucle for qui extrait pour les différentes heures les pluies à chaque point

## Conversion des variables d'intérêt
# Ce bloc de code permet de convertir les pluies en mm/h (à partir de Kg/m2/sec) et les températures en °C (à partir de K).

## Conversion 
pluiesmm <- prtot*3600
tmoy_degree <- tmoyok - 273.15

# Le bloc de code suivant permet:
# - de créer un data frame à partir des vecteurs extraits précédemments
# - de joindre à ces données, les altitudes des X points en longitude de l'Hérault, renseignés dans un tableur excel téléchargés sur le site DRIAS. Ces altitudes sont nécessaires pour calculer ensuite les ETP selon la méthode FAO 56. 

data_lat <- data.frame(latok)
data_long <- data.frame (longok)
data_pluies <- data.frame(pluiesmm)
data_tmoy <-data.frame (tmoy_degree)
data_time<-data.frame(time2)
dataok <-cbind(data_time,data_lat,data_long,data_pluies, data_tmoy)
colnames(dataok)<-c("Date","Latitude","Longitude","Pluies_mm", "Tmoy_degree")

## Output
write_tsv(dataok,"data/data_full.txt")