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

## apply vs map vs starmap
[see this stackoverflow discussion](https://stackoverflow.com/questions/8533318/multiprocessing-pool-when-to-use-apply-apply-async-or-map/59663852#59663852)

# multi-threading vs multi-processing
https://towardsdatascience.com/parallelism-with-python-part-1-196f0458ca14
> TL;DR: Parallelise a CPU-bound task with multiprocessing, and a I/O-bound task with multithreading

### thread
thread is a separate flow of execution. when you have a pool of worker threads, the will be executing close-to concurrency. the thread will share a common data space, so the global interpreter lock helps limit one python thread to run at a time to avoid inconsistent changes in shared memory. this helps python use non thread safe C operations. threads lock the caller thread when they need to use the CPU for computation. **this means that threads are less efficient for CPU-bound tasks and better used for I/)-bound tasks** (like networking or database operations, etc)

### process
process can be understood as a separate python process that has forked from the parent process and has its own python interpreter (q: kinda like how bash works?). so a process has its own GIL and won't lock other processes out when executing on a CPU core.
> The price for avoiding the GIL bottleneck is to have a larger memory overhead as a copy of the address space, or copy-on-write if supported is needed for every process. Because of that, processes are usually more preferable when conducting CPU-bound tasks e.g. matrix manipulations.
