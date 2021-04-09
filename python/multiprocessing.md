# multiprocessing
- https://docs.python.org/3/library/multiprocessing.html

python's multiprocessing manages processes kind of like threads

## example
```python
from multiprocessing import Pool

def f(x):
    return x*x

if __name__ == '__main__':
    with Pool(5) as p:
        print(p.map(f, [1, 2, 3]))
```

this will print `1, 4, 9`.


## Pool
from the Python docs: 
> One can create a pool of processes which will carry out tasks submitted to it with the Pool class.  

> `class Pool`: A process pool object which controls a pool of worker processes to which jobs can be submitted. It supports asynchronous results with timeouts and callbacks and has a parallel map implementation.
```python
class Pool(object):
    '''
    Class which supports an async version of applying functions to arguments.
    '''
```

## map
[in the intro example](#example), map is applying the `[1, 2, 3]` iterable to the `f` function. from the source code:
```python
def map(self, func, iterable, chunksize=None):
        '''
        Apply `func` to each element in `iterable`, collecting the results
        in a list that is returned.
        '''
        return self._map_async(func, iterable, mapstar, chunksize).get()
```

## apply
use apply if you want multiprocessing for a function without an iterable:
```python
p = ThreadPool(processes=10)
p.apply(function_to_call)
p.close()
```

"use `apply_async` if you want a non-blocking call," [said stackoverflow user noxdafox](https://stackoverflow.com/questions/43565035/python-multiprocessing-pool-how-to-use-with-no-iterable#answer-43565080)
