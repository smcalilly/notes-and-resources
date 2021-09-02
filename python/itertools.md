# itertools
"itertools has a bunch of neat stuff, including the ability to chain two iterables together without evaluating them until they are needed."

## chain()
takes a series of iterables and returns one iterable. it groups all the iterables together and produces a single iterable as an output.

"The internal working of chain can be implemented" like:
```python
def chain(*iterables):
     for it in iterables:
       for each in it:
           yield each
```
