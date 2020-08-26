library(cronR)
library(miniUI)
library(shiny)
library(shinyFiles)
library(rmarkdown)

setwd('/Users/matthewcoleman/Documents/GitHub/wildfiremap')

#Download file, unzip, and read in fire data
temp <- tempfile()
print('no error here 1')
url <- 'https://firms.modaps.eosdis.nasa.gov/data/active_fire/suomi-npp-viirs-c2/shapes/zips/SUOMI_VIIRS_C2_Global_24h.zip'
print('no error here 2')
download.file(url,temp)
print('no error here 3')
unzip(temp, 
      exdir = '/Users/matthewcoleman/Documents/GitHub/wildfiremap/data',
      overwrite = TRUE)
print('no error here 4')
unlink(temp)
print('no error here 5')

rmarkdown::render('/Users/matthewcoleman/Documents/GitHub/wildfiremap/wildfire_report.Rmd')

file.remove(c('/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/SUOMI_VIIRS_C2_Global_24h.cpg',
              '/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/SUOMI_VIIRS_C2_Global_24h.dbf',
              '/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/SUOMI_VIIRS_C2_Global_24h.prj',
              '/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/SUOMI_VIIRS_C2_Global_24h.shp',
              '/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/SUOMI_VIIRS_C2_Global_24h.shx'
              ))

print('no error here end')
