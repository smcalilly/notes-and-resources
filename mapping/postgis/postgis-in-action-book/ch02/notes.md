# ch2 - spatial data types

```sql
CREATE SCHEMA ch02;
```

create geometry column:
```
CREATE TABLE ch02.my_geometries(id serial PRIMARY KEY, name text, geom geometry);
```

this table "would welcome any kind of geometry in the geom column" :)

### type modifiers
sometimes known as *typmods*. when you declare as column as character(8), the number `8` is a type modifier of the type `character`, specifically the length modifier. when you write `numeric(8,2)`, you're declaring the data type to be `numeric`, the length (precision) type modifier to be `8`, and the scale type modifier to be `2`.

generally, you specify the type modifiers when you declare the data type of a column. alternatively, you can use check constraints to achieve the same effect after the column is created. ex: you can declare the column and then add a check constraint that limits the length to 8. you can add constraints to any attributes of a column, but not all constraints are type modifiers.

#### subtype modifiers
in postgis, `geometry` and `geography` data types have subtype type modifiers. although they're types in their own right, you should avoid declaring columns as these paretnal types without subtype modifiers. examples of the `geometry` subtypes:
- `POINTZ`
- `POINT`
- `LINESTRING`
- `LINESTRINGM`
- `POLYGON`
- `POLYGONZ`
- `POLYHEDRALSURFACE`
- `POLYHEDRALSURFACEZ`
- `TIN`
- `TINZ`

a typical type declaration in posgis is `geometry(POINT, 4326)`, where `geometry` is the data type, `POINT` is the subtype type modifier, and `4326` is the SRID type modifier. we capitalize subtypes to make them stand out from other type modifiers, though postgres is case insensitive for types and type modifiers.

these type modifiers constrain the *coordinate dimension* of a `geometry`:
- `GEOMETRY`
- `GEOMETRYZ`
- `GEOMETRYZM`

if you declare a column as `geometry(GEOMETRY)`, the geometry column is constrained to allow only two-dimensional geometries (Q? this implies that it could accept 3-D columns, no?)

only `geometry` and `geography` data types support type modifiers. the postgis `raster` type doesn't, nor does the `topogeometry` data type.

#### spatial reference indentifier
all postgis spatial data types have a spatial reference identifier **SRID**. two postgis data types must share a common SRID if you wanna overlay the pair. use **ST_Transform()** function to tranform data types from one SRID to another. if the SIRD is unspecified, but known, you can set the SRID using **ST_SetSRID()**.

postgis relies on the **spatial_ref_sys** table to figure out if an SRID is valid and how to perform the reprojection to transform between SRIDs. the `spatial_ref_sys` table 9is the only table created and populated during the installation of postgis. most SRIDs you'll need are here. you can add missing SRIDs to the table but be sure to include reprojection information.

you can leave the SRID unknown. geometry, raster, and topogeometry default to 0. the SRID for `geography` is never unknown, if not specified, it's assumed to be 4326 (WGS 84 lon/lat). so like a blueprint doesn't need an SRID until you buy some land for it.

### geometry
analytical geometry, all `geometry` subtypes assume a Cartesian coordinate system: parallel lines never meet, the pythagorean theorem applies, distances between coordinates are uniform throughout.

if you use lon/lat in geometry, then that means there area is small enough (or should be small enough) that you can consider degrees of lon/lat as uniform and the earth's curve doesn't come into play.

when dealing with distances on a global scale, the geometry type is wrong. use the `geography` type.

#### points
subtypes of points differentiate themselves by the dimension of the cartesian space (X,Y,Z). they can alos have a `measured` (M) coordinate value.

they are:
- `POINT`: a point in 2D space, specified by X and Y coordinates
- `POINTZ`: 3D space - X, Y, Z coordinates
- `POINTM`: 2D space with a measured value specified by its spatial X and Y coords, plus an M value
- `POINTZM`: 3D space with a measured value specified by its X, Y, Z coords, plus an M value

create a table with one column for each of the point subtypes, and append a record:
```sql
CREATE TABLE ch02.my_points (
    id serial PRIMARY KEY,
    p geometry(POINT),
    pz geometry(POINTZ),
    pm geometry(POINTM),
    pzm geometry(POINTZM),
    p_srid geometry(POINT,4269)
);
INSERT INTO ch02.my_points (p, pz, pm, pzm, p_srid)
VALUES (
    ST_GeomFromText('POINT(1 -1)'),
    ST_GeomFromText('POINT Z(1 -1 1)'),
    ST_GeomFromText('POINT M(1 -1 1)'),
    ST_GeomFromText('POINT ZM(1 -1 1 1)'),
    ST_GeomFromText('POINT(1 -1)', 4269)
);
```

we only added SRID to the last point. when not specified, SRIDs take the value of 0. SRID 4269 is North American Datum 1983 Lon/Lat (NAD 83).

## Linestrings
connected straight lines between two or more distinct points form **linestrings**. individual lines between points are called **segments**. segments are data types or subtypes, but it's possible for a linestring to have just one segment.

- `LINESTRING`: a linestring in 2D specified by two or more distinct `POINT`s
- `LINSTRINGZ`: 3D space, specified by two or more distinct `POINTZ`s
- `LINESTRINGM`: 2D space with measure values, specified by two or more distinct `POINTM`s
- `LINSTRINGZM`: 3D space with measure values specified by two or more distinct `POINTZM`s

add some 2D linestrings:
```sql
CREATE TABLE ch02.my_linestrings (
    id serial PRIMARY KEY,
    name varchar(20),
    my_linestrings geometry(LINESTRING)
);

INSERT INTO ch02.my_linestrings (name, my_linestrings)
VALUES
    ('Open', ST_GeomFromText('LINESTRING(0 0, 1 1, 1 -1)')),
    ('Closed', ST_GeomFromText('LINESTRING(0 0, 1 1, 1 -1, 0 0)'));
```

this creates a new table to hold 2D linestrings in an unknown SRID, with a set of values to insert into the table. `Open` is an example of an *open linestring*, where the start and end points aren't the same. `Closed` is an example of a *closed linestring*, where start/end is the same, forming a loop. in real-world geographic features, open linestrings predominate over closed. rivers, trails, fault lines, and roads don't start where they end. however, closed linestrings play an indispensable part in constructing polygons.

*simple* and *non-simple* geometries. a simple linestring can't have self-intersections (can't cross itself) except at the start and end points. all points being unique enforces this. a linestring with self-intersection is *non-simple*.

postgis provides a geometry function to test for simpleness: `ST_IsSimple`. the following query returns false:
```sql
SELECT ST_IsSimple(ST_GeomFromText('LINESTRING(2 0, 0 0, 1 1, 1 -1)'));
```

#### polygons
closed linestrings are the building blocks of polygons. by definition, a polygon contains all the enclosed area and its boundary -- the linestring that forms the perimeter. the closed linestring boundary is called the *ring of the polygon* when used in this context; more specifically, it's the *exterior ring*.

form a solid polygon whose boundary is the closed linestring from listing 2.2:
```sql
ALTER TABLE ch02.my_geometries ADD COLUMN my_polygons geometry(POLYGON);
INSERT INTO ch02.my_geometries (name, my_polygons)
VALUES (
    'Triangle',
    ST_GeomFromText('POLYGON((0 0, 1 1, 1 -1, 0 0))')
);
```

a polygon can have a single ring as its outside boundary, but they can also have multiple rings, carving out holes. a polygon must have exactly one exterior ring and can have one or more inner rings. each interior ring creates a hole in the overall polygon. this is why you need the set of parenthese in the text representations of polygons. the well-known text representation (WKT) is a set of closed linestrings. the first one designates the exterior ring and all subsequent ones designate inner rings. always include the extra set of parentheses in the WKT, even if the polygon only has a single ring.

create a polygon with two holes:
```sql
INSERT INTO ch02.my_geometries (name, my_polygons)
VALUES (
    'Square with two holes',
    ST_GeomFromText(
        'POLYGON(
            (-0.25 -1.25, -0.25 1.25, 2.5 -1.25, -0.25 -1.25),
            (2.25 0, 1.25 1, 1.25 -1, 2.25 0), (1 -1, 1 1, 0 0, 1 -1)
        )'
    )
);
```

in the real world, multi-ring polygons play an important part in excluding bodies of water within geo boundaries. for example, create a polygon of a city. plan the public transportation by using pgRouting to find the shortest routes. but it keeps going through the lake. so create an inner polygon to outline the lake. this way, if you run a query finding the shortest path between two points, you won't end up going through the lake.

*validity*: the rings of a valid polygon may only intersect at distinct points. rings can't overlap nore share a common boundary. a polygon whose inner rings partly lie outside its exterior ring is also invalid.

postgis functions for dealing with invalid geometries:
- `ST_IsValid` returns true/false
- `ST_IsValidReason` returns a detailed description of why the geometry is invalid (if it is)
- `ST_IsValidDetail` returns itemized details if there are many kinds of invalidities
- `ST_MakeValid` converts an invalid geometry to a valid one. this might turn a polygon into a multipolygon or geometry collection

#### collection geometries
think of how might store the entire US states as polygons. how might you handle hawaii with the 5 different islands? collections of geometries groups distinct geometries that logically belong together. with the use of collections, each of the fifty states becomes a collection of polygons -- a **multipolygon**.

in postgis, all single geometry subtypes have a collection counterpart: multipoints, multilinestrings, and multipolygons. in addition, posgis includes a datatype called `geometrycollection`. this data type can include any kind of geometry as long as all geometries in the set have the same SRID and the same coordinate dimensions.

#### multipoints
nothing more than collections of points. WKT syntax for multipoints:
```sql
SELECT ST_GeomFromText('MULTIPOINT(-1 1, 0 0, 2 3)');
```

if you have an additional coordinate, such as a coord that measures elevation, then you'd have a Z coordinate. if you need to track another coord that's not necessarily spatial in anture, you'd use the M coordinate. M coordinate is often used to measure time or some other kind of measurement like a mile marker position.

see page 40 for various ways of syntax.

#### multilinestrings
is a collection of linestrings. be mindful of the extra sets of parenthese in the WKT representation of a multiline string that surround each individual linestring in the set.

example
```sql
SELECT ST_GeomFromText('MULTILINESTRING((0 0, 0 1, 1 1), (-1 1, -1 -1))');
```
see page 40 for more exmaples.

simple vs non-simple applies here too. if you create a multilinestring with two intersecting simple linestrings, the resultant multilinestring isn't simple.

#### multipolygons
the WKY of multipolygons has even more parentheses than its singular counterpart.

here's an example:
```sql
SELECT 'MULTIPOLYGON(
    ((2.25 0, 1.25 1, 1.25 -1, 2.25 0)),
    ((1 -1, 1 1, 0 0, 1 -1))
)'::geometry;
```

see some Z and M examples on page 41

note!
you can use `ST_GeomFromText` or `'somewktwkb'::geometry` (like above) to convert well-known text to a geometry. both approaches "are more or less equivalent", except `::geometry` is a bit shorter to write and works with other geometry string representations such as well-known binary. since postgis 3.1 `::geometry` will work for converting the geoJSON string format to postgis geometry.

for a multipolygon to qualify as valid, it must pass two tests:
- each constituent polygon must be valid in its own right
- constituent polygons can't overlap. once you lay down a polygon, subsequent polygons can't be laid on top.

#### GEOMETRYCOLLECTION
is a postgis geometry subtype that can contain heterogenous geometries. unlike multi-geometries, where constituent geometries must be the same subtype, `GEOMETRYCOLLECTION` can include points, linestrings, polygons, and their collection counterparts. it can even contain other geometry collections. you can stuff every geometry subtype known to postgis into a `GEOMETRYCOLLECTION`.

this example presents a WKT for geometry collections, but instead of building the geometries using `ST_GeomFromTGext` and the WKT representation, we'll build them by collecting simpler geometries using the `ST_Collect` function.

```sql
SELECT ST_AsText(ST_Collect(g))
FROM (
    SELECT ST_GeomFromText('MULTIPOINT(-1 1, 0 0, 2 3)') AS g
    UNION ALL
    SELECT ST_GeomFromText(
        'MULTILINESTRING((0 0, 0 1, 1 1), (-1 1, -1 -1))'
    ) AS g
    UNION ALL
    SELECT ST_GeomFromText(
        'POLYGON(
            (-0.25 -1.25, -0.25 1.25, 2.5 1.25, 2.5 -1.25, -0.25 -1.25),
            (2.25 0, 1.25 1, 1.25 -2, 2.25 0),
            (1 -1, 1 1, 0 0, 1 -1)
        )'
    ) AS g
) x;
```

in real world applications, you should rarely define a data column as `geometrycollection`. having a colleciton is perfectly reasonable, but using it within a function rarely makes sense. geometry collections almost always originate as the result of queries rather than predefined geometries. you should be prepared to work with them, but avoid using them in your table design.

a geometrycollection is valid if all the geometries in the collection are valid. it's invalid if any of the geometries are invalid.

#### the M coordinate
an additional coordinate added for the convenience of recording measured values taken at various points along spatial coordinates. benefit of M becomes clear as soon as you move beyond points. it doesn't need any spatial interpretation. it can be negative or positive and the units have no relationship to the uinits of other spatial coordinates. the M coordinates are unchanged when you convert a geometry to another spatial reference system.

there are some functions for it. see page 43-44.

all postgis functions assume that the M dimension is linear, as opposed to logarithmic.

#### Z coordinate
just because a geometry has a Z coordinate doesn't make it a volumetric geometry. a polygon in 3D space is still a planar 2D geometry. it has an area but no volume. this will get a little more interesting when we get to polyhedral surfaces in the next section.

some common functions:
- `ST_3DIntersects`
- `ST_3DDistance`
- `ST_3DDWithin` for 3D radius searches
- `ST_3DMaxDistance`
- `ST_3DClosestPoint`

we'll cover spatial indexes in chapter 15.

postgis 2.1 introduced additional functions based on the SFCGAL library. see page 45 for more details and how to download it.

#### polyhedral surfaces and TINs
float a bunch of polygons in 3D space and glue them together at their edges, and you'll form a patchwork referred to as a polyhedral surface. polygons in a polyhedral surface almost always share edges, versus polygons in a multipolygon which can't share edges. polygons can't overlap, and each edge can be mated with at most one other edge. geodetic domes, a jigsawe puzzle that you pieced together but got wet and now has warped, a honeycomb, the checkered flag at a car race as it flaps in the wind.

polyhedral surfaces allow you to create closed surfaces in three dimensions. a polyhedral surface that is closed can be treated as a solid, with a geometry dimension of three, or as a surface, with a geometry dimension of two. a sold would mean that all points inside the surface would count as part of the geometry, and the intersectino of two solids could generate another solid.

functions:
- `ST_MakeSolid` will mark a closed polyhedral surface as solid
- `ST_IsSolid` will return true/false to denote whether a 3D geometry is solid.
- SFCGAL engine treats the surfaces as solid

TINs stands for *triangular irregular networks*. a subset of polyhedral surfaces where all the constituent polygons must be triangles. TINs are widely used to describe terrain surfaces. the minimum number of points needed to form an area: three -- a triangle. the mathematical underpinning of TINs is based on triangulating key peak and valley point locations of a surface to form non-overlapping connected area pockets. the most comment form of triangulation used in GIS is Delaunay triangulation

- page 48 for sql to generate polyhedral surfaces
- page 49 for sql to generate TINs

#### curved geometries
postgis has almost complete support for what's defined in some specs, but tools for rendering postgis curved geometries still lag . curved geometries aren't as mature and widely used as other geometries. linestrings are mostly appropriate for modeling these geometries.

ST_CurvedToLine

- circularstrings
- compound curves / curvepolygon
- curvepolygons