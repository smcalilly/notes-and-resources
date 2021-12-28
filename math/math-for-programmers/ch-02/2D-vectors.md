# part 1 intro - vectors and graphics

[[**linear algebra**]] is the branch of math dealing with computatoins on multi-dimensional data.

a dimension is a geometric concept. linear algebra lets us turn geometric ideas about dimension into things we can compute concretely.

**[[vector]]** is a data point in some multi-dimensional space.

chapter 2, 2D coordinate plane with vecotrs that can be labled by ordered pairs of numbers (x, y). in chapter 3, we'll consider 3D space whose vectors (points) can be labeled by triples of numbers in the form (x, y, z).

**[[linear transformation]]** is a kind of function that takes a vector as input and returns a vector as ooutput, while preserving the geometry (in a special sense) of the vectors involved. chapter 4.

chapter 5 will be **[[matrices]]** which are rectangular arrays of numbers that can represent linear transformations.

chapter 6 will introduce the general concept of **[[vector space]]** and define the concept of dimension more concretely.

chapter 7 we'll learn solving systems of linear equations.

# drawing with 2D vectors
**[[vector mathematics]]** - 2D, 3D, 4D (physics with time), and more vectors (typical in data science)

vectors are objects that live in multi-dimensional space.

## picturing 2D vectors

flat. 2D space is referred to as a [[plane]]. object living in a 2D plane has two dimensions of height and width but no third dimension of depth.

you can describe locations in 2D by two pieces of info: vertical and horizontal positions. to describe the location of points in the plane, you need a reference point. we call that special reference point the [[origin]]

[[two-dimensional vector]] is a point in the [[plane]] relative to the [[origin]]. you can think of a vector as a straight arrow in the plane; any arrow can be placed to start at the origin and it indicates a particular point.

we'll use both arrows and points to represent vectors in this chpater and beyond. points are useful to work with because we can build more interesting drawings out of them.

[[axes]] two perpendicular lines that make up the [[plane]]. they intersect at the origin. horizontal line is the x-axis and the vertical line is the y-axis...

4, 6 = x- and y-coordinates of the point. this makes up the vector! this is enough to know exactly what we're talking about!!!

we write coordinates as an [[ordered pair]] (aka a [[tuple]]), with x coordinate first and y coordinate second.

we can describe a vector in three ways:
1. an ordered pair of numbers (x and y coordinates)
2. a point in the plane relative to the origin (visually on the graph)
3. an arrow of a specific length in a specific direction


### 2D drawing in python
an image on a screen is 2D space. pixels on the screen are the available points in that plane.

python has turtle and pillow libraries for this. we're gonna use matlotlib

wait am i supposed to write my own code? they are just importing some custom code they wrote and then executing it in the juptyer notebook. 

## plane vector arithmetic
vectors have their own kind of arithmetic, we can combine vectors with operations to make new vectors. but with vectors, we can visualize the results. operations from vector arithmetic all accomplish useful geometric transformations, not just algebraic ones.

**[[vector addition]]**: give two input vectors, you add their x-coordinates to get the resulting x-coordinate, and then you add their y-coords to get the resulting y-coord. this returns the *vector sum*. 

adding, you traverse the arrows, sometimes called *tip to tail addition*. (whoaa cool that is best understood by looking at the plot on page 33.)

when we talk about arrows, we really mean "a specific distance in a specific direction". if you walk one distance in one direction and another distance in another direction, the vector sum tells you the overall distance and direction you traveled (within the plane...bc how tf does that work? looking at this chart on p34, makes a triangle, which would mean more distance....? oh okay i get it, the total distance traveled by x and y isn't the actual distance traveled. that illustration is kinda confusing, it's not measuring the trianle like the geometric way with the length of the triangle , don't remember the proper term, maybe they will tell me later.)

adding a vector has the effect of moving or translating an existing point or collection of points. if we add the vector (-1.5, -2.5) to every vector of `dino_vectors`, we get a new list of vectors, each of which is 1.5 units left and 2.5 units down from one of the original vectors

this is useful for moving the dinosaur in a 2D computer game.

### vector components and lengths
sometimes it's useful to take a vector we already have and decompose it as a sum of smaller vectors. "walk four blocks east and three blocks north" makes more sense that "go 800 meters northeast". similarly, it can be useful to think of vectors as a sum of a vector pointing in the x direction and a vector pointing the y direction. (this is what was tripping me up early, i was thinking of the "distance traveled" like this based on the illustration)

the two vectors (4, 0), aka "four blocks east", and (0, 3) "three blocks north", are called the **x and y components** respectively. you would have to walk a total of 7 units to get there.

the *length* of a vector is the length of the arrow that represents it, aka the distance from the origin to the point that represents it. in the nyc block example, this could be the distance between two intersections "as the crow flies", aka the 800 meters northeast directive instead of the 4 blocks, 3 blocks. aka vectors can lie diagonally and we need to calculate their lenght.

remember the [[pythagorean theorem]]? for a right triangle, the pythagorean theorem says that the quare of the length of the longest side is the sum of squares of the lenghts of the other two sides. the longest side is called the *[[hypotenuse]]* and it's length is denoted by *c* in the memorable formula `a^2 + b^2 = c^2`, where *a* and *b* are the lengths of the other two sides. with a = 4 and b = 3, we can find c as the square root of 4^2 + 3^2. 

breaking a vector into components is handy bc it always gives us a right triangle. if we know the lenghts of the components, we can compute the length of the hypotenuse, which is the length of the vector. (what about if it's not a right triangle?)

we can translate this forumla into a `length` formula in python, which takes a 2D vector and returns its floating-point length:
```python
from math import sqrt

def length(v):
	return sqrt(v[0]**2 + v[1]**2)
```

### multiplying vectors by numbers
instead of `v + v + v + v + v` you can multiply... `v * 5`. add `v` to itself ad infinitum. "you can keep stacking arrows tip-to-tail as long as you want"

the operation of multiplying a vector by a number is called [[scalar multiplication]]. when working with vectors, the numbers [[scalars]] are known as the number by which the vectors are mulitplied ("we execute any scalar multiplication on a vector by multiplying each coordinate of the vector by the scalar"). the effect of scalar multiplication scales the target vector by the given factor. it doesn't matter if the scalar is a whole number, we can easiy draw a vector that is 2.5 times the length of another.

in our triangle example, this scales both components at the same rate. in other words, it keeps the scale of the triangle. "scalar multiplication of a vector scales both componets by the same factor". 

works with positive and negative numbers. intuitively. `-v * 1` and `v * 1` would produce what you expect. this is called the *opposite vector*. see p. 39 for demonstration.

on the number line, there are only two direction froms zero: positive and negative. in the plane, there are many directions (infinitely!). so we can't say that one of `v` and `-v` is positive while the other is negative. what we can say is that for any vector `v`, the opposite vector `-v` will have the same length, but it will point in the opposite direction !!!

with this in mind, we can define **[[vector subtraction]]**. for numbers, `x - y` == `x + (-y)`.  

subtracting w from v, or adding -w to v. this is sometimes called the **[[displacement]]** from w to v.

in other words, `v = (-1, 3)` and `w = (2, 2)`. the difference for v - w is `(-3, 1)`.

with that, you can use th pythagorean theorem to find the distance:
```python
difference = (-3, 1)

l = length(difference)

print(l)
3.1622776601683795
```

the [[displacement]] is a vector and the distance is a scalar. the distance alone isn't enough to get from w to v, since there are several points

distance is the length of the difference of two input vectors (using the displacement)

## angles and trigonometry in the plane
we've been using two "rulers" (the x and y axes) to measure vectors in the plane. instead of these rules, we can use a ruler and a protactor.

vector = (4, 3)

has a length of 5 units and points in a direction approximately 37* counterclockwise from the positive half of the x-axis. this gives us a new pair of numbers (5, 37*) that, like our original coordinates, uniquely specify the vector. these numbers are called the **[[polar coordinates]]** and are good as describing points in the plane as the ones we've been doing so far (aka [[cartesian coordinates]])

sometimes it's easier to use cartesian coordinates, like when we're adding vectors. polar coordinates are more useful when we want to look at vectors rotated by some angle.¸

supposed we have a pair of polar coordinates. how can we find the cartesian coordinates for this vector geometrically?

116.57* -- this angle goes up two units every time you go up one unit to the left. (see p. 53). this is a nice round ratio of -2. they aren't always whole numbers, but every angle does give us a constant ratio. this ratio is called the **[[tangent]]** of the angle and the tangent function is written as *tan*. tangent function is atrionometric function bc it helps us measure triangles. python has a built-in tangent function.

tangent doesn't find the cartesian coordinates, only their ratio. for that, **[[sine]]** and **[[cosine]]** are helpful. tangent on an angle gives the vetical distance covered divided by the horizontal distance. by comparision, the sine and cosine give us the vertical and horizontal dsitance covered relative to the overal distance.

given the angle 37*, we saw the point (4, 3) lies at a distance of 5 units from the origin of this angle. for every 5 units you travel at 37*, you cover approximately 3 vertical units. therefore:

- `sin(37*) ~= 3 / 5`
- `cos(37*) ~= 4 / 5`

this is a general strategy for converting a vector in polar coordinates to cooresponding cartesian coordinates. if you know the sine and consine of angle theta and a distance *r* traveled in that direction, the cartesian coordines are given (r * *cos($\theta$), r * sin($\theta$))

### radians and trigonometry in python
let's build a function that takes a pair of polar coodinates (a length and an angle) and outputs a pair of cartesian coordinates (lenghs of x and y components).

python's built-in trig functions don't use degrees and neither do most mathematicians. they use *[[radians]]* to measure angles

45* = $\pi$ / 4 (radians)

### from components back to angles
given a pair of cartesian coordinates like (-2, 3), we know how to find the length with the pythagorean theorem. in this case, it's the square root of 13, which is the frist of the two polar coordinates we're looking for. the second is the angle, which we can call $\theta$. 

need a function that took sin($\theta$) and returned the angle. `math.asin` makes a good attempt. this is an implementation of the *inverse trigonometric function* called **arcsine**.

but that's not right because there are multiple angles that can have the same sine. try **arccosine**. that produces the correct result, but same problem for multiple angles with the same sine.

use the `math.atan2` function.

trigonometric functions are tricky to do in reverse; multiple different inputs can produce the same output, so an output can't be traced back to a unique point.