# transforming vectors and graphics
vector in -> rotate function -> rotated vector out

you can think of the `rotate` function as a machine that takes in a vector and outputs an appropriately transformed vector.

if we apply a 3D analogy of this function to every vector of every polygon defining a 3D shape, we can see the whole shape rotate.

if instead of rotating by 45* once, we rotated by one degree every 45 times, we could generate frames of a movie showing a rotating teapot.

[[linear transformation]]s are a broad class of vector transformations that, like rotations, send vectors lying on a straight line to new vectors that also lie on a straight line.

have numerous applications in math, physics, and data analysis.

## transforming 3D objects
[[composition of functions]]! since each function returns a vertex, we can combine all sort of functions

we can write a general purpose python function that takes two python functions (for vector transformation, for instance) and returns a new function, which is their composition:

```python
def compose(f1, f2):
	def new_function(input):
		return f1(f2(input))
	return new_function
```

this is functional programming and python can do this because functions are first-class objects, meaning functions can be assigned to variables or returned from another function call.

functions as machines with input and output slots.

```python
# reusable function that returns a new list of polygons anytime we want to apply transformations
def polygon_map(transformation, polygons):
	return [
		[transformation(vertex) for vertex in triangle]
		for triangle in polygons
	]

  

# draw_model(polygon_map(scale2, load_triangles()))

  

def scale_by(scalar):
	def new_function(v):
		return scale(scalar, v)
	return new_function

  

draw_model(polygon_map(scale_by(3), load_triangles()))
```

you can picture scale_by as a machine that takes numbers in its input slot and outputs new function machines from its output slot.

write a new translate function that does this:
```python
def translate_by(scalar):
	def new_function(v):
		return add(scalar, v)
	return new_function
```

this is called [[currying]]. currying takes a function that accepts multiple inputs and refactors it to a function that returns another function. the new function essentially remembers the state of the inputs.

the result is a programmatic machine that behaves identically but is invoked differently. `scale_by(s)(v)` gives the same result as `scale(s, v)` for any inputs s and v.

### rotating an object about an axis
we saw how to do 2d rotations in chapter 2. convert the cartesian coordinates to polar coordinates, increase or decrease the angle by the rotation factor, then convert back. this is a 2d trick but it's helpful in 3d becuase all 3d vector rotations are, in a sense, isolated in planes. for example, if a single 3d point rotates around the z-axis, the x and y coordinates change but its z coordinate remains the same.

see the code for examples.

### inventing your own geometric transformations
the only requirement for a 3D vector is that it accepts a single 3D vector as input and returns a new 3D vector as output

stretches vectors by a hard-coded factor of four:
```python
def stretch_x(vector):
	x, y, z = vector
	return (4*x, y, z)
```

can do that with y etc

## linear transformations
along with vectors, [[linear transformation]]s are the other main objects of study in linear algebra. "linear transformations are special transformations where vector arithmetic looks the same before and after the transformation"

### preserving vector arithmetic
the two most important arithmetic operations on vectors are [[vector addition]] and [[scalar multiplication]]

rotations or any other vector transformations that preserve sums and scalar multiples are called linear transformations.

a [[linear transformation]] is a vector transformation *T* that preserves [[vector addition]] and [[scalar multiplication]]. that is, for any input vectors u and v, we have:

*T*(u) + *T*(v) = *T*(u + v)

and for any pair of scalar *s* and a vector *v*, we have:

*T*(sv) = s*T*(v)

### picturing linear transformations
let's look at a counterexample, a vector transformation that's not linear. scalar S(v) that takes a vector v = (x, y) and outputs a vector with both coordinates squared: S(v) = (x^2, y^2). or the sum of z = (2, 3) and v = (1 , -1). the sum is (2, 3) + (1, -1) = (3, 2)

now apply scalar multiplication S to each of these: S(u) = (4, 9), S(v) = (1, 1), and S(u + v) = (9, 4). S(u) + S(v) != S(u + v)

let D(v) be the vector transformation that scales the input vector by a factor of 2. in other words, D(v) = 2v. this does preserve vector sums: if u + v =w, then 2u + 2v = 2w.

likewise, D(v) preserves scalar multiplication. for any scalar S, D(sv) = 2(sv) = S(2v) = sD(v)

how about translation? suppose B(v) translates any input vector v by (7, 0). surprisingly, this is not a linear transformation.

for a transformation to be linear, it must not move the origin. translation by any non-zero vector transforms the origin, which ends up at a different point, so it cannot be linear

other examples of linear transformations include [[reflection]], [[projection]], [[shearing]], and any 3D analogy of the preceding linear transformations

### why linear transformations?
bc they preserve vector sums and scalar multiples, they also preserve a broader class of vector arithmetic operations. the most general operation is called a [[linear combination]].

see the [[linear combination]] note.

[[weighted average]]. any point on the line segment connection u and v is a weighted average of u and v, so it has the form Su + (1 - S)v. a linear transformation T transforms u and v to some new vectors T(u) and T(v). the point on the line segment is transformed to some new point T(Su + (1 - S)v) or ST(u) + (1 -S)T(v). this is a weighted average of T(u) and T(v), so it's a point that lies on the segment connection T(u) and T(v)

because of this, a linear transformation T takes every point on the line segment connection u and v to a point on the line segment connection T(u) and T(v). **this is a key property of linear transformations: they send every existing line segment to a new line segment**. because our 3D models are made up of polygons and polygons are outlined by line segments, linear transformations can be expected preserve the structure of our 3D models to some extent.

### computing linear transformations
in chapters 2 and 3, saw how to break 2D and 3D vectors into components. for instance, (4, 3, 5) can be decomposed as a sum (4, 0, 0) + (0, 3, 0) + (0, 0, 5). this makes it easy to see how far the vector extends in each of three dimensions of space that we're in. we can decompose this even further into a linear combination:

(4, 3, 5) = 4(1, 0, 0) + 3(0, 1, 0) + 5(0, 0, 1)

**any 3D vector can be decomposed into a linear combination of three vectors**. the scalars appearing in this decomposition for a vector *v* are exactly the coordinates of v.

the three vectors (1, 0, 0), (0, 1, 0), and (0, 0, 1) are called the [[standard basis]] for three-dimensional space. denoted as e1, e2, and e3, so we could write the linear combination as (3, 4, 5) = 3e<sub>1</sub> + 4e<sub>2</sub> + 5e<sub>3</sub>. when working in 2d space, we call e<sub>1</sub> = (1, 0) and e<sub>2</sub>  = (0, 1). sor for example, (7, -4) = 7 $\times$ e<sub>1</sub> - 4 $\times$ e<sub>2</sub> 

this change in perspective makes it easy to compute linear transformations. because linear transformations respect linear combinations, all we need to know to compute a linear transformation is how it affects standard basis vectors.

A(e1) = (1, 1, 1), A(e2) = (1, 0, -1) and A(e3) = (0, 1, 1). if v = (-1, 2, 2), what is A(v)? 

first we can expand v as a linear combination of the three standard basis vectors. because v = (-1, 2, 2) = -e<sub>1</sub> + 2e<sub>2</sub> + 2e<sub>3</sub>, we can make the substitution:

A(v) = A(-e<sub>1</sub> + 2e<sub>2</sub> + 2e<sub>3</sub>) = -A(-e<sub>1</sub>) + 2A(e<sub>2</sub>) + 2A(e<sub>3</sub>)

then we can substitue the known values of A(e1) = (1, 1, 1), A(e2) = (1, 0, -1) and A(e3) = (0, 1, 1)

-(1, 1, 1) + 2 $\times$ (1, 0, -1) + 2 $\times$ (0, 1, 1) = (1, 1, -1)

in python applied to the teapot:
```python
Ae1 = (1, 1, 1)
Ae2 = (1, 0, -1)
Ae3 = (0, 1, 1)

def apply_A(v):
	return add(
		scale(v[0], Ae1),
		scale(v[1], Ae2),
		scale(v[2], Ae3)
	)

draw_model(polygon_map(apply_A, load_triangles()))
```

the takeaway here is that a 2D linear transformation T is defined completely by the values of T(e1) and T(e2), that's two vectors or four numbers in total. likewise, a 3D linear transformation T is defined completely by the values of T(e1), T(e2), and T(e3), which are three vectors or nine numbers in total. in any number of dimensions, the behavior of a linear tranformation is specified by a list of vectors or an array-of-arrays of numbers, aka an [[matrix]], which we'll learn how to use in the next chapter.

the identity transformation

## summary
- vector transformations are functions that take vectors as inputs and return vectors as outputs. vector transformations can operate on 2d or 3d vectors.
- to effect a geometric transformation of the model, apply a vector transformation to every vertex of every polygon of a 3d model.
- you can combine existing vector transformations by composition of functions to create new transformations, which are equivalent to apply the existing vector transformations sequentially.
- functional programming is a programming paradigm that ephasizes composing, and otherwise, manipulating functions
- the functional operation of currying turns a function that takes multiple arguments into a function that takes one argument and returns a new function. currying lets you turn existing python functions (like scale and add) into vector transformations
- linear transformations are vector transformations that preserve vector sums and scalar multiples. in particular, points lying on a line segment still line on a line segment after a linear transformation is applied.
- a linear combination is the most general combinationof scalar multiplication and vector addition. every 3d vector is a linear combintion of the 3d standard basis vectors, which are denoted as e1 = (1, 0, 0), e2 = (0, 1, 0), and e3 = (0, 0, 1). likewise, every 2D vector is a linear combination of the 2d standard basis vectors, which are e1 = (1, 0), e2 = (0, 1)
- once you know how a given linear transformation acts on the standard basis vectors, how can determine how it acts on any vector by writing the vector as a linear combination of the standard basis and using the fact that linear combinations are preserved.
	- in 3D, three vectors or nine total numbers specify a linear transformation
	- in 2D, two vectors or four total numbers do the same
	- this last point is critical: linear transformations are both well-behaved and easy-to-compute with because they can be specified with so little data.