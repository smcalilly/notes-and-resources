# chapter 1 - binary search and big o notation

## binary search
- input is a sorted list of elements
    - if the element is in the list, then binary search returns it. otherwise it returns null
- eliminate half the numbers every time
- search a dictionary of 240k words, takes 18 steps

for any list of *n*, binary search will take log<sub>2</sub>(n)

### logarithms
logs are the inverse of exponentials

log<sub>10</sub>100:
- this asks "how many 10s do we multiply to get 100?" 2, 10 x 10 = 100. 
- log<sub>10</sub>100 = 2

### binary search with python
```bash
python3 cs/grokking-algorithms/1-binary-search/binary-search.py
```

### exercises
what is log<sub>2</sub>(128)?
```python
>>> import math
>>> math.log(128, 2)
7.0
```

what is log<sub>2</sub>(256)?
```python
>>> math.log(256, 2)
8.0
```

## running time
- using a simple search, the search uses **linear time**
  - O(n)
- using binary search, the search uses **logarithmic time**
  - O(log n)

## Big O notation
run times for simple search and binary search don't grow at the same rates.

big O establishes a worst-case run time.

### common Big O run times
- O(log n): known as *log time* - example, binary search
- O(n): known as *linear time* - example, linear search
- O(n * log n) - example, a fast-sorting algorithm, like quicksort
- O(n<sup>2</sup>)
- O(n!): *factorial time* - a really slow algorithm, like the traveling salesperson

there are other runsimes, but these are the most common

### takeaways
- algorithmic speed isn't measured in seconds, but in growth of the number of operations
- instead, we talk about how quickly the run time of an algorithm increases as the size of the input increases
- run time of the algorithms is expressed in Big O notation
- O(log n) is faster than O(n), and it gets a lot faster as the list of items grows