given two input vectors, you add their x-coordinates to get the resulting x-coordinate, and then you add their y-coords to get the resulting y-coord. this returns the *vector sum*

(4, 3) + (-1, 1) = (3, 4)

in python:
```python
def add_vector(v1, v2):
	return (v1[0] + v2[0] + v1[1] + v2[1])
```


a different way (refactored from above):
```python
from collections import namedtuple

Point = namedtuple('Point', 'x y')

def add_vector(v1, v2):
	return Point((v1.x + v2.x), v1.y + v2.y)



vector_1 = Point(4, 3)
vector_2 = Point(-1, 1)

summed_vectors = add_vector(vector_1, vector_2)
summed_vectors
```
[thanks for the `Point` class ^](https://realpython.com/python-namedtuple/)

you can refactor the `add_vector` function to add any number of vectors:
```python
def add_vectors(vectors):
    return (sum([v[0] for v in vectors]), sum([v[1] for v in vectors]))

vectors = [(-2, 0), (1.5, 1.5), (4, 1)]

vector_sum = add_vectors(vectors)
vector_sum
```