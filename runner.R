library(cronR)
library(miniUI)
library(shiny)
library(shinyFiles)
library(rmarkdown)

setwd('/Users/matthewcoleman/Documents/GitHub/wildfiremap')

#Download file, unzip, and read in fire data
#temp <- tempfile()
# url <- 'https://firms.modaps.eosdis.nasa.gov/data/active_fire/suomi-npp-viirs-c2/shapes/zips/SUOMI_VIIRS_C2_Global_24h.zip'
# print('error 1')
# download.file(url,'/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/data.zip')
# print('error 2')
# unzip('/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/data.zip', exdir = '/Users/matthewcoleman/Documents/GitHub/wildfiremap/data')
# print('error 3')
# #unlink(temp)


rmarkdown::render('/Users/matthewcoleman/Documents/GitHub/wildfiremap/wildfire_report.Rmd')

file.remove(c('/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/data.zip',
              '/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/SUOMI_VIIRS_C2_Global_24h.cpg',
              '/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/SUOMI_VIIRS_C2_Global_24h.dbf',
              '/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/SUOMI_VIIRS_C2_Global_24h.prj',
              '/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/SUOMI_VIIRS_C2_Global_24h.shp',
              '/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/SUOMI_VIIRS_C2_Global_24h.shx'
              ))

print('Job Well Done!')
