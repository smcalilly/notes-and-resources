# PostGIS in Action

postgis is a spatial database extender for posgres. adds several spatial data types and over 400 functions for working with these types.

## Chapter 1 - what is a spatial database?
geographic information systems

### thinking spatially
mapping can be a good resource for analyzing patterns in data

a spatial database is a db with column data types specifically designed to store objects in space -- these data types can be added to db tables. info stored is usally geographic in nature, such as a point location or the boundary of a lake.

spatial db also provides functions and indexes for querying and manipulating spatial data, which can be called from something like SQL.

spatial db gives you a storage tool, an anlaysis tool, and an organizing tool all in one.

presenting spatial data isn't a spatial db's only goal. you can store an infinite number of attributes. you don't have to return spatial data either, but you can query within a space and get all the data that returns from it. like, "show me the region with the highest number of households where the average closest distance to any pizza parlor with a star-ranking below 5 is greater than 16 kilometers (10 miles)"

a spatially enabled database can istrinsically work with data types like coastlines (modeled as linestrings), buffer zones (modeled as polygons), and beach houses (modeled as points)

### postgis
- functions to work with geojson, kml, mtv
- geometry processing functions
- built-in 3d and topolgy support
- over 300 operations for workin with vectors and rasters in tandem, as well as for converting between the two

talks about the history and alternative gis databases

### install on ubuntu
https://www.digitalocean.com/community/tutorials/how-to-install-postgresql-on-ubuntu-20-04-quickstart

https://www.vultr.com/docs/install-the-postgis-extension-for-postgresql-on-ubuntu-linux

https://www.pgadmin.org/download/pgadmin-4-apt/

create postgis db:
```psql
postgres@meerk:~$ psql
psql (13.5 (Ubuntu 13.5-0ubuntu0.21.04.1))
Type "help" for help.

postgres=# CREATE DATABASE postgis_in_action;
CREATE DATABASE
postgres=# \c postgis_in_action
You are now connected to database "postgis_in_action" as user "postgres".
postgis_in_action=# CREATE SCHEMA postgis;
CREATE SCHEMA
postgis_in_action=# GRANT USAGE ON schema postgis to public;
GRANT
postgis_in_action=# CREATE EXTENSION postgis SCHEMA postgis;
CREATE EXTENSION
postgis_in_action=# ALTER DATABASE postgis_in_action SET search_path=public,postgis,contrib;
ALTER DATABASE
```

tip: although it's not required, they always install postgis in a separate schema such as `postgis` so the functions don't clutter up the default public schema.

with postgis 3, you might need to add raster support so you can use raster and raster functions: `CREATE EXTENSION postgis_raster SCHEMA postgis;`

#### verify versions of postgis and postgres
`SELECT postgis_full_version();`

```
postgis_full_version                                                                        
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
 POSTGIS="3.1.1 aaf4c79" [EXTENSION] PGSQL="130" GEOS="3.9.0-CAPI-1.16.2" PROJ="7.2.1" LIBXML="2.9.10" LIBJSON="0.15" LIBPROTOBUF="1.3.3" WAGYU="0.5.0 (Internal)"
```

### spatial data types
fopur key spatial data types:
- `geometry`
  - the planar type. this is the very first model and it's still the most popular type. it's the foundation of the other types. it uses cartesian math.
- `geography`
  - the spheroidal geodetic type. lines and polygons are drawn on the earth's curved surface, so they're curved rather than straight lines.
- `raster`
  - the multi-band cell type. rasters model space as a grid of rectangular cells, each containing a numeric array of values.
- `topology`
  - the relational model. topology models the world as a network of connected nodes, edges, and faces. objects are composed of these elements and may share these with other objects. there are really two related concepts in topology -- the network, which defines what elements each thing is composed of, and routing.
  - net work topology ensures that when you change the edge of an object, other objects sharing that edge will change accordingly. routing is commonly used with postgis via an add-on called `pgRouting`. routing not only cares about connectedness, but also how costly that connectedness is. pgRouting is mostly used for building trip navigation applications (taking into account the cost of tolls or delays due to construction), but it can be used for any application where costs along a path are important.

all these four types can coexist in the same database and even as separate columns in the same table. fo example, you can have a geometry that defines the boundaries of a plant, and you can have a raster that defines the concentration of toxic waste along each part of the boundary.


#### geometry type
in two dimensions, you can represent all geographical entites with three building blocks:
- **points**
- **linestrings**
- **polygons**

a highway (linestring) with gas stations (points) through states (polygon). but a road atlas isn't the only use case. look around your house: wires, pippes, rooms. just by abstracting the landscape to 2D points, linestrings, and polygons, you have enough to model everything that could crop up on a map or a blueprint.

the geometry type treats the world as a flat cartesian grid. but, that's a flat earth!

#### geography type
curve of earth comes into play when you're modeling anything that extends beyond the visual horizon. geometry works for floor plans, city blocks, and runway diagrams, but it comes up short when you model shipping lanes, airways, or continents, or whenever you consider two locations that are far apart. you can still perform distance computation without abandoing the cartesian underpinnings by sprinkling a few sines and cosines into your formulas, but the minute you need to compute areas, the math becomes intractable.

a better solution is to use a family of data types based on **geodetic coordinates** -- geography. geography shields the complexity of the math from the postgis user (!). as a trade off, geography offers fewer functions and it trails geometry in speed. you'll find the same point, linestring, and polygon data types in geography, just keep in mind that the linestrings and points conform to the curves of a globe.

#### raster type
geometry and geography are vector-based data types. vectors are well suited to modeling designed or constructed features, but suppose you snap a color of the coral-rich coral sea. you're gonna have a hard time constructing lines and polygons out of the photo. best bet is to quantize the photo into microscopic rectangles and assign a color value to each. **raster data** is this -- a mosaic of pixels.

tv screen, computer screen, etc. each pixel stores three different color values: RGB. in raster-speak, each color is called a **band**. pixel represents some area of geographic space, which can vary based on the dimensions of the film you're watching and the number of pixels on your tv.

raster data almost always originates from instrumental data collection and often serves as the raw material for generatin vector data. as such, you'll encounter a lot more sources of raster data than vector data. postgis will let you overlay vector data atop raster data and vice versa. think of a saatellite view: you see roads (vector data) superimpoosed on top of the satellite imagery (raster)

raster appears in the following applications:
- land coverage or land use
- temperature and elevation variations. this is a single-=band raster where each square holds a measured temperature or elevation value.
- color aerial and satellite photos. these have four bands: one for each of the RGB and A for alpha intensity color space.

#### topology type
the connectedness/relationship between the parts. the interwoven network of points, linestrings, and polygons. topology recognizes the inherent interconnection of geogrpahic features and exploits it to help you better manage the data.

topology isn't concerned with the exact shpae and location of geogrpahic features, but with how they're connected to each other. 

useful in the following applications:
- parcel data, where tyou want to ensure that the change of one parcel boundary adjusts all other parcels that share that boundary change as well
- road management, water boundaries, and jurisdiction divisions. the US census MAF/Topologically Integrated Geographic Encoding and Referncing system (TIGER) data is a perfect example
- architecture

### hello real world
gonna do this:
- digest a problem and formulate a solution
- modeling
- gathering and loading data
- writing a query
- viewing the result

how many fast-food restaurants are within one mile of a highway?

#### modeling
need to translate the real world to a model that is composed of database objects. for this example, you'll represent the highway as a geometric linestring and locations of fast-food restaurants as points. you'll then create two tables: highways and restuarants.

- create schema
  - schema: a container, similar to a directory, that you'll find in most high-end databases. it logically segments objects (tables, views, functions, and so on) for easier managemnet:
  - `CREATE SCHEMA ch01;`

- create restaurants table
  - need a lookup table to map franchise codes to meaningful names. then add all the franchises you'll be dealing with
```sql
CREATE TABLE ch01.lu_franchises(id char(3) PRIMARY KEY, franchise varchar(30));

INSERT INTO ch01.lu_franchises(id, franchise)
VALUES
  ('BKG', 'Burger King'),
  ('CJR', 'Carls Jr.'),
  ('HDE', 'Hardee'),
  ('INO', 'In-N-Out'),
  ('JIB', 'Jack in the Box'),
  ('KFC', 'Kentucky Fried Chicken'),
  ('MCD', 'McDonald'),
  ('PZH', 'Pizza Hut'),
  ('TCB', 'Taco Bell'),
  ('WDY', 'Wendys');
```

create a table to hold the data you'll be loading:
```
CREATE TABLE ch01.restaurants
(
    id serial primary key,
    franchise char(3) NOT NULL,
    geom geometry(point, 2163) -- this is the spatial geometry column
);
```

for later analysis, i'll need to uniquely identify restaurants so that i don't double count them. also, certain mapping servers and viewers, such as mapserver and QGIS, balk at tables without  integer primary keys or unique indexes. the restaurant data has no primary key, and nothing in the data file lends itself to a good natural primary key, so you create an autonumber pk.

need to place a **spatial index** on your geometry column. this step can be done before or after the data load:
```sql
CREATE INDEX ix_code_restaurants_geom
  ON ch01.restaurants USING gist(geom); -- todo: what is gist?
```

if you're planning to load a lot of data into the table, it's more efficient to create the spatial index and any other indexes after the data load is complete so the indexing of each record doesn't impact the load performance.

as part of the definitino for postgres, you must specify the type of index. postgis special indexes are these inedex types:
- `gist`
- `spgist`
- `brin`

you'll mostly want to stick with `gist`. we'll go over when to use each index type later in the book.

not necessary for this particular data set, but you'll create a foreign key relationship between the franchise column in the restaurants table and the lookup table. this helps prevent people from mistyping franchises in the restaurants table. adding `CASCADE UPDATE DELETE` rules when you add foriegn key relationships will allow you to change the franchise ID for your franchises if you want, and to have those changes update the restaurants table automatically:
```sql
ALTER TABLE ch01.restaurants
  ADD CONSTRAINT fk_restaurants_lu_franchises
  FOREIGN KEY (franchise)
  REFERENCES ch01.lu_franchises (id)
  ON UPDATE CASCADE ON DELETE RESTRICT;
  ```

restrict deletes to prevent inadvertant removal of franchises with restaurants. 

create an index to make the join between the two tables more efficient:
```
CREATE INDEX fi_restaurants_franchises
  ON ch01.restaurants (franchise);
```

create a highway table to contain the road segments that are highways:
```sql
CREATE TABLE ch01.highways
(
    gid integer NOT NULL,
    feature character varying(80),
    name character varying(120),
    state character varying(2),
    geom geometry(multilinestring,2163), -- multilinestring equal area
    CONSTRAINT pk_highways PRIMARY KEY (gid)
);

CREATE INDEX ix_highways
  ON ch01.highways USING gist(geom);
```

#### loading data
data isn't always clean and you gotta make it translate to your model. always give primacy to your model. a well-thought out model can often ride out the vagaries of a data source. 

import a csv file, but first create a staging table:
```sql
CREATE TABLE ch01.restaurants_staging (
    franchise text, lat double precision, lon double precision);
```

use psql \copy command to imporrt the file into staging table:
```
\copy ch01.restaurants_staging FROM '/home/sam/code/notes-and-resources/mapping/postgis/restaurants.csv' DELIMITER as ',';
```

get the csv data into the restaurants table:
```
INSERT INTO ch01.restaurants (franchise, geom)
SELECT franchise,
  ST_Transform(
      ST_SetSRID(ST_Point(lon, lat), 4326), 2163) AS geom
FROM ch01.restaurants_staging;
```

wtf?

you're using a point geometry column to store your restaurants locations. the second argument to the geometry function indicates the **spatial reference ID (SRID)** that you've selected for the restaurant data. the SRID denotes the coordinate range and how the spherical space is projected on a flat surface. in this example we use SRID 4326 (which corresponds to WGS 84 lon/lat), but then transform all the data to our desired planar projection for faster analysis. 

you gotta have common projections before you can compare two data sets. this example uses EPSG:2136, which is an equal-area projection covering the continental US.

SRID and spatial reference systems. these refer to records in the spatial_re_sys table, where srid is the column that uniquely identifies the record. ID 4326 is the most popular and refers to a spatial reference system called WGS 84 lon/lat. (this will be covered in chapter 3)