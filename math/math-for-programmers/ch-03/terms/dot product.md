u * v, returns a scalar (a number)

(x, y) * (x, y)

(2, 3) * (4, 5) = 2 * 4 + 3 * 5 = 23

```python
def dot(u, v):
	return sum([coord1 * coord2 for coord1, coord2 in zip(u, v)])
```

