library(sf)
library(tidyverse)
library(USAboundaries)
library(ggthemes)

#Download file, unzip, and read in data
temp <- tempfile()
url <- 'https://firms.modaps.eosdis.nasa.gov/data/active_fire/suomi-npp-viirs-c2/shapes/zips/SUOMI_VIIRS_C2_Global_24h.zip'
download.file(url,temp)
unzip(temp, exdir = 'data')
data <- read_sf('data/SUOMI_VIIRS_C2_Global_24h.shp', crs = 4326)
unlink(temp)

usstates_raw <- USAboundaries::us_counties(resolution = 'low') %>%  
  st_transform(crs = 4326) #%>% st_transform(5070)

california <- usstates_raw %>% filter(state_name == 'California') %>% 
  st_combine() # %>% st_cast('MULTILINESTRING')

ca_fires <- st_filter(data, california, .predicate = st_within) %>% st_as_sf() %>% mutate(area = 375)

g <- ggplot() +
  geom_sf(data = california) +
  geom_sf(data = ca_fires, col = 'red4', alpha = .5) +
  theme_minimal() +
  labs(x = 'Longitude',
       y = 'Latitude', 
       title = paste0('Location of Fires in California on ', format(Sys.Date(), format = '%b %d, %Y')))

g





