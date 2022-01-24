from math import *
from teapot import load_triangles
from draw_model import draw_model
from vectors import scale, add, to_polar, to_cartesian

# draw_model(load_triangles())

def scale2(v):
    return scale(2.0, v)

original_triangles = load_triangles()

# scaled_triangles = [
#     [scale2(vertex) for vertex in triangle]
#     for triangle in original_triangles
# ]

# draw_model(scaled_triangles)

# def translateleft(v):
#     return add((-1, 0, 0), v)

# scaled_translated_triangles = [
#     [translateleft(scale2(vertex)) for vertex in triangle]
#     for triangle in original_triangles
# ]

# draw_model(scaled_translated_triangles)

# def scale_then_translateleft(v):
#     return translateleft(scale2(v))

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

# draw_model(polygon_map(scale_by(3), load_triangles()))

def translate_by(scalar):
    def new_function(v):
        return add(scalar, v)
    return new_function

def rotate2d(angle, vector):
    l, a = to_polar(vector)
    return to_cartesian((l, a+angle))

def rotate_z(angle, vector):
    x, y, z = vector
    new_x, new_y = rotate2d(angle, (x, y))
    return new_x, new_y, z

def rotate_z_by(angle):
    print('angle', angle)
    def new_function(v):
        print('v', v)
        return rotate_z(angle, v)
    return new_function

# this saves (pi / 4) as "angle", so when the inner function
# is called, that value is used as the "angle" arg (line 67).
# the curried function is injected into the polygon_map function
# which calls the inner rotate_z function
rotate_zz = rotate_z_by(pi / 4)
print(rotate_zz)

# draw_model(polygon_map(rotate_z_by(pi / 4), load_triangles()))
# draw_model(polygon_map(rotate_zz, load_triangles()))

def rotate_x(angle, vector):
    x, y, z = vector
    new_y, new_z = rotate2d(angle, (y,z))
    return x, new_y, new_z

def rotate_x_by(angle):
    def new_function(v):
        return rotate_x(angle, v)
    return new_function

# draw_model(polygon_map(rotate_x_by(pi / 2), load_triangles()))

# combine the past two examples
# rotated_z = polygon_map(rotate_z_by(pi / 4), load_triangles())
# draw_model(polygon_map(rotate_x_by(pi / 2), rotated_z))

def compose(*args):
    def new_function(input):
        state = input
        
        for f in reversed(args):
            state = f(state)
        return state
    return new_function

Ae1 = (1, 1, 1)
Ae2 = (1, 0, -1)
Ae3 = (0, 1, 1)

def apply_A(v):
	return add(
		scale(v[0], Ae1),
		scale(v[1], Ae2),
		scale(v[2], Ae3)
	)

# draw_model(polygon_map(apply_A, load_triangles()))

def linear_combination(scalars, *vectors):
    scaled = [scale(s, v) for s,v in zip(scalars, vectors)]
    return add(*scaled)
l_c = linear_combination([1, 2, 3], (1, 0,0), (0, 1, 0), (0, 0, 1))
print(l_c)

def transform_standard_basis(transform):
    return transform((1, 0, 0)), transform((0, 1, 0)), transform((0, 0, 1))

s = transform_standard_basis(rotate_x_by(pi / 2))
print(s)