# 3D Space
add a `z` for depth. so we have x, y, z

we can think if 2d space as existing in 3d space. it has the same size and orientation but fixed to a plane where the depth z is zero.

all of the arithmetic operations for [[2D-vectors]] have analogies in 3d, and the geometric effects of each are similar.

### add 3D vectors

we can add any number of 3D vectors together by summing all of their x-coordinates, all of their y-coordinates, and all of their z-coordinates. these sums give us the coordinates of the new vector.

this will sum any number of input vectors, for any dimension:
```python
def add(*vectors):
	by_coordinate = zip(*vectors)
	coordinate_sums = [sum(coords) for coords in by_coordinate]
	return tuple(coordinate_sums)
```

another way:
```python
def add(*vectors):
	return tuple(map(sum, zip(*vectors)))
```

### scalar multiplication in 3D
v = (1, 2, 3)
2 * v = (2, 4, 6)

### subtracting 3D vectors
in 2D, the difference of the two vectors v - w is the vector "from w to v", which is called the displacement. in 3D, the story is the same; in other words v -w is the diplacement from w to v, which is the vector you can can add to w to get v.

### computing lengths and distances
in 2D, we calculated length of a vector with the pythagorean theorem, using the fact that an arrow vector and its components make up a right triangle. like wise, the distance between two points in the plane was just the length of their difference as a vector.

let's try to find the length of vector (4, 3, 12). the x and y components still give us a right triangle lying in the plane where z = 0. this triangle's hypotenuse has length sqrt(4 ** 2 + 3 ** 2) = sqrt(25) = 5. if this were 2D vector, we'd be done.

with that calculation, we can create a new right triangle using the z vector. calculate that. since the 2D hypotenuse is 5 and the z vector is 12, do sqrt(5 ** 2 + 12 ** 2) = 13.

see page 87 to understand this calculation better.

in python:
```python
from math import sqrt

def length(v):
	return sqrt(sum([coord ** 2 for coord in v]))
```

### computing angles and directions
you need 2 angles in 3D, versus 1 angle in 2D.

we think of the first angle without its z-coordinate, but instead if it lived in the x, y plane. ithis angle is made with the x axis and we label it with the greek letter phi $\phi$. the second angle is the one that the vector makes with the z-axis which is labeled with the greek letter theta $\theta$. 

the length of the vector, labled r, along with the angles $\phi$ and $\theta$ can describe any vector in three dimensions. together the three numbers r, rare called [[spherical coordinates]] as opposed to cartesian coordinates x, y, and z. you can calculate spherical coordinates from cartesian coordinates with trig, but we're not gonna do it! 

polar coordinates were usfule bc they allowed us to rotate a collection of plane vectors by simply adding or subtracting from the angle. we were also able to read the angle between two vectors by taking the difference of their angles in polar coordinates. in spherical coordinates, neither of the angles  $\phi$ and $\theta$ lets us immediately decide the angle between two vectors.

in the next section, we'll cover vector products for handling angles and trig in 3D

### dot product
the [[dot product]] takes two vectors and returns a scalar (a number), while the [[cross product]] takes two vectors and returns another vector. both helpus reason about lengths and directions of vectors in 3D. 

vectors with a positive dot product are pointing in similar directions. vectors with a negative dot product point in opposing directions. not all dot products are exactly opposite. perpendicular vectors always have a dot product of zero.

this lets us find two vectors that are perpendicular without doing any trig. if the angle between two vectors is less than 90*, the vectors have a positive dot product. if they are greater than 90*, they have a negative dot product.

### computing the dot product
multiply the cooresponding coordinates and then add the products. (1, 2, -1) * (3, 0, 3), x-coordinate product = 3, y-coord = 0, and z-coord = -3. then sum 3 + 0 + (-3) = 0. these vectors are perpendicular.

the dot product is proportional to each of the lenghts of its input vectors. if you take the dot product of two vectors in the same direction, the dot product is precisely equal to the product of the lengths. (4, 3) has a length of 5 and (8, 6) has a length of 10. the dot product is equal to 5 * 10. 


### measuring angles with the dot product
u * v = |u| * |v| * cos($\theta$), where $\theta$ is the angle between the vectors u and v. this gives us a new way to compute a dot product

u length = 3
v length = 2
angle = 75*

3 * 2 * cos(75*)

but when doing computations with vectors, it's more common to start with coordinates and to compute angles from them. we can combine both of our formulas to recover the angle.

1. compute the dot product and lengths using coordinates
2. solve for the angle

u = (3, 4)
v = (4, 3)

u * v = 24
both lengths = 5

(3, 4) * (4, 3) = 24 = 5 * 5 * cos($\theta$)

24 = 25 * cos($\theta$)
cos($\theta$) = 24/25

using `math.acos` we find that a $\theta$ value of 0.284 radians or 16.3* gives us a cosine of 24/25

this is most helpful in 3D

formulas:

cos($\theta$) = u * v / |u| * |v|

$\theta$ = arccos(u * v / |u| * |v|)

in pythons:
```python
from math import sqrt, acos

def length(v):
	return sqrt(sum([coord ** 2 for coord in v]))

def dot(u, v):
    return sum([coord1 * coord2 for coord1, coord2 in zip(u, v)])

def angle_between(v1, v2):
	return acos(dot(v1, v2) /
				length(v1) * length(v2)
			)
```

this works no matter how many dimensions

## the cross product: measuring oriented area
the [[cross product]] takes two 3D vectors u and v as inputs, and its output u x v is another 3D vector. it has a direction (unlike the dot product)

right-handed and left-handed orientation

the [[right-hand rule]] tells us which perpendicular direction the cross product points toward.

cross product helps us keep track of orientation throughout all of our computations. it obeys the right-hand rule.

### finding the length of the cross product
the length of the cross product is a number that gives us information about the relative position of the input vectors. instead of measuring how aligned two vectors are, it tells us something closer to "how perpendicular they are". more precisely, it tells how big of an area its two inputs span.

the length of the cross product is equal to the area of a parallelogram.

area = |u x v|

area = |u| * |v| * sin($\theta$)

### computing the cross product of 3D vectors
see p. 109 to see the equation

or in python:
```python
def cross(u, v):
	ux, uy, uz = u
	vx, vy, vz = v
	return (uy*vz - uz*vy, uz*vx - ux*vz, ux*vy - uy*vx)
```

it requires the input vectors to have exactly three components.

## rendering a 3D object in 2D
gonna render an octohedron. eight faces, all of which have triangles. like two four side pyramids stacked on top of each other.


## summary
- whereas vectors in 2D have lengths and widths, vectors in 3D also have depths.
- 3D vectors are defined with triples of number called x-, y-, and z-coordinates. they tell us how far from the origin we need to travel in each direction to get to a 3D point.
- as with 2D vectors, 3D vectors can be added, subtracted, and multiplied by scalars. we can find their lengths using a 3D analogy of the [[pythagorean theorem]].
- the dot product is a way to multiply two vectors and get a scalar. it measures how aligned two vectors are, and we can use its value to find the angle between two vectors.
- the cross prodcut is a way to multiply two vectors and get a third vector that is perpendicular to both input vectors. the magnitude of the output of the cross product is the area of the parallelogram spanned by the two input vectors.
- we can represent the surface of any 3D object as a collection of triangles, where each triangle is repsectively defined by three vectors representing its vertices.
- using the cross product, we can decide which direction a triangle is visible from in 3D. this can tell us whether a viewer can see if or how illuminated it is by a give light source. by drawing and shading all of the triangles defining an object's surface, we can make it look 3D.
