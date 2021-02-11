# GeoJSON
Notes from ["More than you ever wanted to know about GeoJSON"](https://macwright.com/2015/03/23/geojson-second-bite.html)

### Coordinates
coordinates are the most basic element of geographic data. it's a single number representing a single dimensions: typically the dimensions are longitude and latitude. sometimes there is a coordinate for elevations. "Time is a dimension but usually isn’t represented in a coordinate because it’s too complex to fit in a number." (whoa!)

coordinates are formatted like numbers in JSON: in a simple decimal format.

### Position
a position is an array of coordinates in order

GeoJSON describes an order for coordinates:
```
[longitude, latitude, elevation]
```

take note! longitude/latitude is inverted from how you learned in school.

### Geometry
geometries are shapes. all simple geometries consist of a **type** and a collection of coordinates

#### Points
```
- Point
  - Position
```

With a single position, we can make the simplest geometry: the **point**
```
{ "type": "Point", "coordinates": [0, 0] }
```

Depending on the type, the kind of coordinate collection differs.

#### LineStrings
To represent a **line**, you'll need at least two places to connect:
```
{ "type": "LineString", "coordinates": [[0, 0], [10, 10]] }

- LineString
  - Positions..
```

"These are the two simplest, most carefree kinds of geometry. Points and LineStrings don’t have many geometric rules: a point can lie anywhere in a place, and a line can contain arrangement of points, even if it’s self-crossing. Points and lines are also similar in that they have no area: there is no inside or outside."

#### Polygons
Polygons are where GeoJSON geometries become significantly more complex.  They have an area, so they have insides and outsides. They can also have a **hole**, or a cut-out, in the inside. Like a donut. 
```
{
  "type": "Polygon",
  "coordinates": [
    [
      [0, 0], [10, 10], [10, 0], [0, 0]
    ]
  ]
}
```

This idea of holes in a polygon  introduces a new term: the **LinearRing**. LinearRings are loops of positions.
"LinearRings are either the exterior ring - positions that form the outside edge of the Polygon and define which parts are filled - or interior rings, which define the parts of the Polygon are empty. There can only be one exterior ring, and it’s always the first one."

"There can be any number of interior rings, including zero. Zero interior rings just means that the polygon doesn’t have any holes."

## Features
"Geometries are shapes and nothing more. They’re a central part of GeoJSON, but most data that has something to do with the world isn’t simply a shape, but also has an identity and attributes. Some polygons are the White House, other polygons are the border of Australia, and it’s important to know which is which."

Features are a combination of geometry and properties.
```
{
    "type": "Feature",
    "geometry": {
        "type": "Point",
        "coordinates": [0, 0]
    },
    "properties": {
        "name": "null island"
    }
}
```

The properties attached to a feature can by any kind of JSON object.

USA doesn't have contiguous borders, so how do you create a feature for a single entity that has more than one  contiguous shape? **MultiGeometries** describe a physical entity like this
- MultiPoygon
- MultiLineString
- MultiPoint

It works by nesting the coordinates, like the other geometries 

## FeatureCollection
FeatureCollection is the most common thing you'll see at the top level of GeoJSON files.

A FeatureCollection containing our “null island” example of a Feature looks like:
```
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [0, 0]
      },
      "properties": {
        "name": "null island"
      }
    }
  ]
}
```

FeatureCollection is not much more than an object that has "type": "FeatureCollection" and then an array of Feature objects under the key "features". As the name suggests, the array needs to contain Feature objects only - no raw geometries.

You might ask “why not just permit an array of GeoJSON objects”? FeatureCollections as objects makes a lot of sense in terms of the commonality between different GeoJSON types.

    GeoJSON objects are Objects, not Arrays or primitives
    GeoJSON objects have a "type" property

This is really nifty for implementations: they don’t need to guess about what kind of GeoJSON object they’re looking at - they just read the “type” property.

## Winding
The order in which the coordinates are rendered to a map: clockwise or counterclockwise?

## GeoJSON limitations
- not construct for topology
    - [side trip reading about topology](http://www.geography.hunter.cuny.edu/~jochen/GTECH361/lectures/lecture07/concepts/07%20-%20Topology.htm)
- GeoJSON doesn't have a construct for styling features or specifying popup content like title & description.
- no circle geometry type
- positions don't have attibutes. "If you have a LineString representation of a run, and your GPS watch logged 1,000 different points along that run, along with your heart rate and the duration at that time, there’s no clear answer for how to represent that data. You can store additional data in positions as fourth and fifth coordinates, or in properties as an array with the same length as the coordinate array, but neither option is well-supported by the ecosystem of tools."

## performance
both geojson and leaflet can be the culprit

## misc
- https://github.com/mapbox/simplestyle-spec
- https://github.blog/2014-02-05-diffable-more-customizable-maps/
- https://github.blog/2013-06-13-there-s-a-map-for-that/
- https://geojson.io

repos
- https://github.com/Turfjs/turf
- https://github.com/jazzband/geojson
- https://github.com/tmcw/awesome-geojson
- https://github.com/mapbox/simplestyle-spec

# spatial analysis
- https://github.com/Turfjs/turf
https://docs.mapbox.com/help/how-mapbox-works/geospatial-analysis/
https://docs.mapbox.com/help/tutorials/analysis-with-turf/
