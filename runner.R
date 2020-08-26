library(cronR)
library(miniUI)
library(shiny)
library(shinyFiles)
library(rmarkdown)

#Download file, unzip, and read in fire data
temp <- tempfile()
url <- 'https://firms.modaps.eosdis.nasa.gov/data/active_fire/suomi-npp-viirs-c2/shapes/zips/SUOMI_VIIRS_C2_Global_24h.zip'
download.file(url,temp)
unzip(temp, exdir = '/Users/matthewcoleman/Documents/GitHub/wildfiremap/data')
#unlink(temp)

rmarkdown::render('/Users/matthewcoleman/Documents/GitHub/wildfiremap/wildfire_report.Rmd')
