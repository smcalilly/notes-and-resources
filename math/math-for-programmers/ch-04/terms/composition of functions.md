defining new functions by applying two or more existing ones in a specified order.

these take a vertex and return a new vertex, so you can compose them. must be pure functions (todo: fact check that statement)

```python
def scale(scalar,v):
	return tuple(scalar * coord for coord in v)

def scale2(v):
	return scale(2.0, v)

def add(*vectors):
	return tuple(map(sum,zip(*vectors)))

def translate1left(v):
	return add((-1, 0, 0), v)

def scale_then_translate1left(v):
	return translate1left(scale2(v))
```

we can write a general purpose python function that takes two python functions (for vector transformation, for instance) and returns a new function, which is their composition:

```python
def compose(f1, f2):
	def new_function(input):
		return f1(f2(input))
	return new_function
```

instead of definining scale2_then_translateleft as itw own function, we can write:
```python
scale2_then_translate1left = compose(translate1left, scale2)
```