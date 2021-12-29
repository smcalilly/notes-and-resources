given a right triangle, find the length of one side using the other two sides

a^2 + b^2 = c^2

(they should've named this equation something related to the theorem)
```python
from math import sqrt

def length(v):
	return sqrt(v[0]**2 + v[1]**2)

difference = (-3, 1)

distance = length(difference)

print(distance)
3.1622776601683795
```

describes an important geometric relationship between the three sides of a right triangle

for a right triangle with legs `a` and `b`  and [[hypotenuse]] `c` 
a^2 + b^2 = c^2