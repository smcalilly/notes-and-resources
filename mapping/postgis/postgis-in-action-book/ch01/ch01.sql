CREATE DATABASE postgis_in_action;
CREATE SCHEMA postgis;
GRANT USAGE ON schema postgis to public;
CREATE EXTENSION postgis SCHEMA postgis;
ALTER DATABASE postgis_in_action SET search_path=public,postgis,contrib;

CREATE SCHEMA ch01;

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

CREATE TABLE ch01.restaurants
(
    id serial primary key,
    franchise char(3) NOT NULL,
    geom geometry(point, 2163) -- this is the spatial geometry column
);

CREATE INDEX ix_code_restaurants_geom
  ON ch01.restaurants USING gist(geom);

ALTER TABLE ch01.restaurants
  ADD CONSTRAINT fk_restaurants_lu_franchises
  FOREIGN KEY (franchise)
  REFERENCES ch01.lu_franchises (id)
  ON UPDATE CASCADE ON DELETE RESTRICT;

CREATE INDEX fi_restaurants_franchises
  ON ch01.restaurants (franchise);

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

CREATE TABLE ch01.restaurants_staging (
    franchise text, lat double precision, lon double precision);

\copy ch01.restaurants_staging FROM '/home/sam/code/notes-and-resources/mapping/postgis/restaurants.csv' DELIMITER as ',';

INSERT INTO ch01.restaurants (franchise, geom)
SELECT franchise,
  ST_Transform(
      ST_SetSRID(ST_Point(lon, lat), 4326), 2163) AS geom
FROM ch01.restaurants_staging;