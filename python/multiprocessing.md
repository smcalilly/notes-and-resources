# multiprocessing
- https://docs.python.org/3/library/multiprocessing.html

python's multiprocessing manages processes kind of like threads

here is an example:
```python
from multiprocessing import Pool

def f(x):
    return x*x

if __name__ == '__main__':
    with Pool(5) as p:
        print(p.map(f, [1, 2, 3]))
```

this will print `1, 4, 9`
