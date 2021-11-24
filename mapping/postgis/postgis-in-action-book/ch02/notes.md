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