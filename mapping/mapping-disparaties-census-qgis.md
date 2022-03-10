Mapping disparaties in the news
github.com/ruthwtalbot/nicar-2022

github nprapps

Collected addresses for covid sites and mapped them on census data

1, 2, 3 steps
Get the data for the vaccine sites
Get the census shapefiles and demographic data
Join all together and run analysis

A note about addresses
gotta get those on a map
aka geocoding
Taking address info and putting it on a map with lat/long

geocode.io is free
Worth double checking, accuracy score. Above .95 then they go with it, anything below the nix
You can upload a csv
Can add census identifier, fips code

TIGER shapefiles
2019 ACS, make sure your geos match with the ACS

Demographic data
advanced search
Geography > state > all census tracts
Income and poverty. We want median income in the past 12 months

Qgis
Layer > add layer > add vector layer > … to get your file
Census tracts
Grocery stores
Poverty csv : layer > add layer > delimited text. Geometry definition: no geometry. Add


Filtering. You can use mapshapper but also qgis
layer, right click, open attributes table
Select by expression
Layer export > save selected features as. Save

Join the tracts 
Need to clean the geoid colum
Select racts > field calculator

Graduated data
Categorized data
