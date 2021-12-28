given a triangle, find the length of one side using the other two sides

a^2 + b^2 = c^2

```python
from math import sqrt

def length(v):
	return sqrt(v[0]**2 + v[1]**2)

difference = (-3, 1)

distance = length(difference)

print(distance)
3.1622776601683795
```