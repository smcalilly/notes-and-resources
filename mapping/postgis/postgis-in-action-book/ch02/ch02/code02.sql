-- tag::code_my_geometries[] --
CREATE TABLE ch02.my_geometries(id serial PRIMARY KEY,name text, geom geometry);
-- end::code_my_geometries[] --

-- convert PostgreSQL polygon to PostGIS geometry  --
-- tag::code_pg_geometry[] --
SELECT polygon('((10,20),(25,30),(30, 30),(10,20))')::geometry
UNION ALL
SELECT path('(1,21), (5,15), (9,20), (12,5)')::geometry
UNION ALL
SELECT box('(10, 21)'::point, '(16,10)'::point)::polygon::geometry
UNION ALL
SELECT circle('(20,10)'::point, 3)::polygon::geometry;
-- end::code_pg_geometry[] --

-- tag::code_my_points[] --
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
	ST_GeomFromText('POINT(1 -1)',4269)
);
-- end::code_my_points[] --

-- tag::code_my_geometries_add_linestrings[] --
CREATE TABLE ch02.my_linestrings (
	id serial PRIMARY KEY, 
	name varchar(20),
	my_linestrings geometry(LINESTRING)
); -- <1>
  
INSERT INTO ch02.my_linestrings (name, my_linestrings)
VALUES 
	('Open', ST_GeomFromText('LINESTRING(0 0, 1 1, 1 -1)')), -- <2>
	('Closed', ST_GeomFromText('LINESTRING(0 0, 1 1, 1 -1, 0 0)'))
; -- <3>
-- end::code_my_geometries_add_linestrings[] --

-- Add polygon
-- tag::my_geometries_add_polygons[] --
ALTER TABLE ch02.my_geometries ADD COLUMN my_polygons geometry(POLYGON);
INSERT INTO ch02.my_geometries (name, my_polygons)
VALUES (
	'Triangle',
	ST_GeomFromText('POLYGON((0 0, 1 1, 1 -1, 0 0))')
);
-- end::my_geometries_add_polygons[] --
  
-- Polygon with 2 holes
-- tag::my_geometries_polygon_holes[]
INSERT INTO ch02.my_geometries (name,my_polygons)
VALUES (
	'Square with two holes',
	ST_GeomFromText(
        'POLYGON(
            (-0.25 -1.25,-0.25 1.25,2.5 1.25,2.5 -1.25,-0.25 -1.25),
            (2.25 0,1.25 1,1.25 -1,2.25 0),(1 -1,1 1,0 0,1 -1)
        )'
	)
);
SELECT my_polygons 
FROM ch02.my_geometries
WHERE name = 'Square with two holes';
-- end::my_geometries_polygon_holes[]

-- Listing Forming geometrycollections from constituent geometries
-- tag::code_geometrycollection[]
SELECT ST_AsText(ST_Collect(g))
FROM (
	SELECT ST_GeomFromText('MULTIPOINT(-1 1, 0 0, 2 3)') As g
	UNION ALL
	SELECT ST_GeomFromText(
		'MULTILINESTRING((0 0, 0 1, 1 1), (-1 1, -1 -1))'
	) As g
	UNION ALL
	SELECT ST_GeomFromText(
		'POLYGON(
			(-0.25 -1.25, -0.25 1.25, 2.5 1.25, 2.5 -1.25, -0.25 -1.25), 
			(2.25 0, 1.25 1, 1.25 -1, 2.25 0), 
			(1 -1, 1 1, 0 0, 1 -1)
		)'
	) As g
) x;
-- end::code_geometrycollection[]


-- tag::code_geometrycollectionm[]
SELECT ST_AsText(ST_Collect(g)) 
FROM (
	SELECT ST_GeomFromEWKT('MULTIPOINTM(-1 1 4, 0 0 2, 2 3 2)') As g
	UNION ALL
	SELECT ST_GeomFromEWKT(
		'MULTILINESTRINGM((0 0 1, 0 1 2, 1 1 3), (-1 1 1,-1 -1 2))'
	) As g
	UNION ALL 
	SELECT ST_GeomFromEWKT(
		'POLYGONM(
			(-0.25 -1.25 1, -0.25 1.25 2, 2.5 1.25 3, 2.5 -1.25 1, -0.25 -1.25 1), 
			(2.25 0 2, 1.25 1 1, 1.25 -1 1, 2.25 0 2), 
			(1 -1 2,1 1 2,0 0 2,1 -1 2)
		)'
	) As g
) x;
-- end::code_geometrycollectionm[]

-- code to generate figure 2.13 --
-- the points
SELECT geom, CASE WHEN mod(path[1],6) = 5 THEN 'End ' || ( path[1]/3 + 1) 
    WHEN mod(path[1],2) = 0 THEN 'Control ' || (path[1]/2 )::text 
    WHEN mod(path[1],3) = 0 THEN 'End ' || ((path[1]/3)) || ' start ' || (path[1]/2 + 1)   
    ELSE 'Start ' || (path[1]/2 + 1)::text END As label
FROM ST_DumpPoints('CIRCULARSTRING(0 0,2 0, 2 1, 2 3, 4 3)'::geometry);

-- the linestring --
SELECT ST_CurveToLine('CIRCULARSTRING(0 0,2
0, 2 1, 2 3, 4 3)'::geometry,100);


-- tag::my_geographies_adding_points[]
CREATE TABLE ch02.my_geogs (
	id serial PRIMARY KEY, 
	name varchar(20),
	my_point geography(POINT)
);
INSERT INTO ch02.my_geogs (name, my_point) 
VALUES 
	('Home',ST_GeogFromText('POINT(0 0)')), 
	('Pizza 1',ST_GeogFromText('POINT(1 1)')),
	('Pizza 2',ST_GeogFromText('POINT(1 -1)'));
-- end::my_geographies_adding_points[]



-- tag::my_geographies_how_far_home_pizza[]
SELECT 
	h.name As house, p.name As pizza, 
	ST_Distance(h.my_point, p.my_point) As dist
FROM 
	(SELECT name, my_point FROM ch02.my_geogs WHERE name = 'Home') As h 
	CROSS JOIN
	(SELECT name, my_point FROM ch02.my_geogs WHERE name LIKE 'Pizza%') As p;
-- end::my_geographies_how_far_home_pizza[]

-- tag::my_geometries_adding_points[]
set search_path=ch02,public;
ALTER TABLE my_geometries ADD COLUMN
  my_point geometry(POINT);
INSERT INTO my_geometries (name,my_point) 
VALUES ('Home',ST_GeomFromText('POINT(0 0)')); 
INSERT INTO my_geometries (name,my_point) 
VALUES ('Pizza 1',ST_GeomFromText('POINT(1 1)')) ;
INSERT INTO my_geometries (name,my_point) 
VALUES ('Pizza 2',ST_GeomFromText('POINT(1 -1)'));
-- end::my_geometries_adding_points[]


-- tag::vw_postgis_reg[]
CREATE OR REPLACE VIEW ch02.vw_pois AS 
SELECT id, name, CAST( ST_Transform(geom,2163) AS geometry(POINT,2163)) As geom
FROM pois;
-- end::vw_postgis_reg[]

-- geometry_columns mangement functions example --
-- tag::code_updategeometrysrid_approach[]
SELECT UpdateGeometrySRID('us_states', 'geom', 4326);
-- end::code_updategeometrysrid_approach[]

-- tag::code_updategeometrysrid_equivalent[]
ALTER TABLE us_states
ALTER COLUMN geom TYPE geometry(MULTIPOLYGON,4326) USING ST_SetSRID(geom,4326);
-- end::code_updategeometrysrid_equivalent[]

-- tag::code_updategeometrysrid_cast[]
ALTER TABLE osm_roads
ALTER COLUMN way TYPE geography(MULTIPOLYGON,4326) USING ST_Transform(way,4326)::geography;
-- end::code_updategeometrysrid_cast[]


-- 3D geometries -- 
-- A Dome -- polyhedral surface z
-- tag::code_polyhedralsurface[]
SELECT ST_GeomFromText(
	'POLYHEDRALSURFACE Z (
		((12 0 10, 8 8 10, 8 10 20, 12 2 20, 12 0 10)),
		((8 8 10, 0 12 10, 0 14 20, 8 10 20, 8 8 10)),
		((0 12 10, -8 8 10, -8 10 20, 0 14 20, 0 12 10))
	)'
);
 
 -- Which can be generated using --
SELECT ST_Extrude(ST_GeomFromText(
	'LINESTRING(12 0 10, 8 8 10, 0 12 10,-8 8 10)'), 
	0, 2, 10
);
-- end::code_polyhedralsurface[]
  
   -- TIN --
-- tag::code_tinz[]
SELECT ST_GeomFromText(
	'TIN Z ( 
		((12 2 20, 8 8 10, 8 10 20, 12 2 20)),
		((12 2 20, 12 0 10, 8 8 10, 12 2 20)),
		((8 10 20, 0 12 10, 0 14 20, 8 10 20)),
		((8 10 20, 8 8 10, 0 12 10, 8 10 20))
	)'
);
-- end::code_tinz[]

-- tag::code_circularstring2[]
ALTER TABLE ch02.my_geometries 
ADD COLUMN my_circular_strings geometry(CIRCULARSTRING);

INSERT INTO ch02.my_geometries(name, my_circular_strings)
VALUES 
	('Circle', 
	ST_GeomFromText('CIRCULARSTRING(0 0, 2 0, 2 2, 0 2, 0 0)')),
	('Half circle', 
	ST_GeomFromText('CIRCULARSTRING(2.5 2.5, 4.5 2.5, 4.5 4.5)')),
	('Several arcs', 
	ST_GeomFromText('CIRCULARSTRING(5 5, 6 6, 4 8, 7 9, 9.5 9.5, 11 12, 12 12)'));
-- end::code_circularstring2[]
   
-- tag::code_compoundcurve[]
ALTER TABLE ch02.my_geometries 
ADD COLUMN my_compound_curves geometry(COMPOUNDCURVE);
INSERT INTO ch02.my_geometries (name, my_compound_curves)
VALUES (
	'Road with curve', 
	ST_GeomFromText(
		'COMPOUNDCURVE(
			(2 2, 2.5 2.5), 
			CIRCULARSTRING(2.5 2.5, 4.5 2.5, 3.5 3.5), 
			(3.5 3.5, 2.5 4.5, 3 5)
		)'
	)
);
-- end::code_compoundcurve[]

-- tag::code_curvepolygon[]
ALTER TABLE ch02.my_geometries 
ADD COLUMN my_curve_polygons geometry(CURVEPOLYGON);

INSERT INTO ch02.my_geometries (name, my_curve_polygons)
VALUES 
	('Solid circle', 
	ST_GeomFromText('CURVEPOLYGON(
		CIRCULARSTRING(0 0, 2 0, 2 2, 0 2, 0 0)
	)')), 
	('Circles with triangle hole', 
	ST_GeomFromText('CURVEPOLYGON(
		CIRCULARSTRING(2.5 2.5, 4.5 2.5, 4.5 3.5, 2.5 4.5, 2.5 2.5), 
		(3.5 3.5, 3.25 2.25, 4.25 3.25, 3.5 3.5)
	)')), 
	('Triangle with arcish hole', 
	ST_GeomFromText('CURVEPOLYGON(
		(-0.5 7, -1 5, 3.5 5.25, -0.5 7), 
		CIRCULARSTRING(0.25 5.5, -0.25 6.5, -0.5 5.75, 0 5.75, 0.25 5.5)
	)'));
-- end::code_curvepolygon[]


-- making rasters --
-- tag::code_create_raster[]
CREATE TABLE ch02.my_rasters (
	rid SERIAL PRIMARY KEY, 
	name varchar(150), 
	rast raster
);

INSERT INTO ch02.my_rasters (name, rast)
SELECT 
	'quad ' || x::text || ' ' || y::text, 
	ST_AddBand( -- <1>
		ST_MakeEmptyRaster(
			90, 45, 
			(x-2) * 90, 
			(2-y) * 45, 
			1, -1, 0, 0, 
			4326
		), -- <2>
		'16BUI'::text, 
		0
	) 
FROM generate_series(0,3) As x CROSS JOIN generate_series(0,3) As y;

--  end::code_create_raster[]  

-- 1 temperature band
-- 2 add 90x45 pixel rasters wgs 84 longlat

--old version --

INSERT INTO ch02.my_rasters (name, rast)
SELECT 
	'quad ' || x::text || ' ' || y::text, 
	ST_AddBand( 
		ST_MakeEmptyRaster(
			90, 60, 
			(x - 3) * 90, 
			90 + (1 - y) * 60, 
			1, -1, 0, 0, 
			4326
		), 
		'16BUI'::text, 
		0
	)
FROM generate_series(1,4) As x CROSS JOIN generate_series(1,3) As y;
--old version --





-- tag::code_raster_addband[]
UPDATE ch02.my_rasters SET rast = ST_AddBand(rast, '8BUI'::text,0);
-- end::code_raster_addband[]

-- tag::code_raster_applyconstraints[]
SELECT AddRasterConstraints('ch02', 'my_rasters'::name, 'rast'::name);
-- end::code_raster_applyconstraints[]

-- Listing burn geometry into raster
-- tag::code_burn_geometry_raster_world[]
UPDATE ch02.my_rasters SET rast =     -- <1>
  ST_AddBand(ST_MapAlgebraExpr(rast, 1, '16BUI', '300 + [rast.y]*' || 0.25::text || '::integer' , NULL), ST_Band(rast,2) )
  WHERE ST_Intersects(ST_MakeEnvelope(-180,-30,180,20,4326), rast );

SELECT ST_Value(rast,ST_SetSRID(ST_Point(1,1),4326))
FROM ch02.my_rasters
WHERE ST_Intersects(ST_SetSRID(ST_Point(1,1),4326), rast );
    
-- end::code_burn_geometry_raster_world[]-

-- #1 - replace existing raster tile if any part 10 degrees of equator
-- #2 - 2 band raster formed from a new band and original band 2
-- #3 - new raster band where our hot area is set to 315 Kelvin, aligned with table tile and extent same as our table tile
-- #4 -- original band 2

-- tag::code_query_raster_columns[]
SELECT 
	r_table_name As tname,r_raster_column As cname, 
	srid,
	scale_x As sx, scale_y As sy,
    blocksize_x As bx, blocksize_y As by,
	same_alignment As sa,
	num_bands As nb, 
	pixel_types As ptypes
FROM raster_columns
WHERE r_table_schema = 'ch02';
-- end::code_query_raster_columns[]

-- visualize --
SELECT  geom, rid::text || ' ' || Box2D(geom)::text As display
FROM (
SELECT rid, rast,  (ST_DumpAsPolygons(rast)).geom
FROM ch02.my_rasters ) As foo;