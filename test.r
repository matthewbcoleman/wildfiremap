library(tidyverse)
library(USAboundaries)
library(ggthemes)
library(units)
library(plotly)

print(2)
#temp <- tempfile()

print(11)
url <- 'http://firms.modaps.eosdis.nasa.gov/data/active_fire/suomi-npp-viirs-c2/shapes/zips/SUOMI_VIIRS_C2_Global_24h.zip'
print(12)
download.file(url,'/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/data.zip', mode = 'wb')
print(13)
unzip('/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/data.zip', exdir = '/Users/matthewcoleman/Documents/GitHub/wildfiremap/data')
print(14)
#unlink(temp)



#Download file, unzip, and read in fire data

# url <- 'https://firms.modaps.eosdis.nasa.gov/data/active_fire/suomi-npp-viirs-c2/shapes/zips/SUOMI_VIIRS_C2_Global_24h.zip'
# 
# download.file(url,'/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/data.zip')
# 
# unzip('/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/data.zip',
#       exdir = '/Users/matthewcoleman/Documents/GitHub/wildfiremap/data')

#unlink(temp)
print(2)
library(sf)
print(3)
data <- read_sf('/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/SUOMI_VIIRS_C2_Global_24h.shp', crs = 4326) %>% st_transform(5070)
# unlink(temp)

#data <- read_sf('/Users/matthewcoleman/Documents/GitHub/wildfiremap/data/SUOMI_VIIRS_C2_Global_24h.shp', crs = 4326) %>% st_transform(5070)



print(4)    
#get the county data, filter to CA and add area column for point area.

counties_raw <- USAboundaries::us_counties(resolution = 'low') %>%  
  st_transform(crs = 4326) %>% st_transform(5070)

counties_ca <- counties_raw %>% filter(state_name == 'California') #%>% st_combine() 

california <- counties_ca %>% st_combine() 

ca_fires <- st_filter(data, california, .predicate = st_within) %>% 
  st_as_sf() %>% 
  mutate(area_km = (375^2)/1000000)

county_indices <- st_within(ca_fires, counties_ca)

ca_fires <- ca_fires %>% mutate(county = counties_ca$name[unlist(county_indices)]) %>% 
  st_buffer(375)

   
print(5)
    
point_in_polygon = function(points, polygon, id){
  st_join(points, polygon) %>%
    st_drop_geometry() %>%
    count(.data[[id]]) %>%
    setNames(c(id, "n")) %>%
    left_join(polygon, by = id) %>%
    st_as_sf()
}

fire_counts <- point_in_polygon(ca_fires, counties_ca, 'countyfp')
   



print(6)
#Plot Map

g <- ggplot() +
  geom_sf(data = california, col = 'snow3') +
  geom_sf(data = fire_counts, aes(fill = n), alpha = .9) +
  geom_sf(data = ca_fires, col = 'red4', alpha = .5, size = .5) +
  scale_fill_gradient(low = 'grey', high = "orange", name ='Fire Pixel\n Count' ) +
  theme_linedraw() +
  labs(x = 'Longitude',
       y = 'Latitude', 
       title = paste0('Location of Fires in California on ', format(Sys.Date(), format = '%b %d, %Y')),
       subtitle = 'Highlighted counties have at least one active fire')

ggplotly(g)
   
print('done')

   