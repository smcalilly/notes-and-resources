# generators
we have a list and a list comprehension that squares each item in the list:
```python
>>> numbers = [2,1,3,4,7,11,18]
>>> squares = [n**2 for n in numbers]
```

we can turn the square brackets `[]` into parens `()`, this will turn our list comprehension into a generator expression.
```python
>>> squares = (n**2 for n in numbers)
>>> squares
<generator object <genexpr> at 0x108131eb0>
```

list comprehensions give us back new lists. generator expressions give us back new generator objects.

a generator object, unlike a list, don't have a length. we can't index it either. 

the only thing we can do with a generator is loop over it.
```python
>>> for n in squares:
...     print(n)
... 
4
1
9
16
49
121
324
```

## why generators?
they are lazy iterables, meaning they don't work til you start looping over them.

when we create the generator object, we haven't computed anything yet. it doesn't contain values like a list. they don't work til they are looped over. if you loop over them a second time, they'll return an empty list (aka the generator is exhausted).

before looping, you can change a value in the list that creates the generator and when you loop over the generator, it will use the changed value.
```python
>>> numbers
[2, 1, 3, 4, 7, 11, 18]
>>> numbers[3] = 5
>>> numbers
[2, 1, 3, 5, 7, 11, 18]
>>> list(squares)
[4, 1, 9, 25, 49, 121, 324]
```

generator objects are lazy iterables and they are single-use iterables. items are *generated* as we loop over a generator (that's what makes them lazy), and these items are *consumed* as we loop over the generator, meaning they aren't stored anywhere.


you don't need to fully exhaust it. you can break out of the loop then pick up where you left off.
```python
>>> numbers = [2, 1, 3, 4, 7, 11, 18]
>>> squares = (n**2 for n in numbers)
>>> for n in squares:
...     print(n)
...     if n > 10:
...         break
...
4
1
9
16
>>> list(squares)
[49, 121, 324]
```

generators generate values as you loop over them. generator expressions are list comprehension-like syntax for creating new generator objects. the only thing you can do with a generator is loop over it. once you've exhausted the generator, you can't use it anymore.

## recap
generator expressions make new generator objects.

a generator is an iterable which doesn't contain or store values. it generates values as you loop over it.

**generators are more memory efficient than lists** (he really buried the lede here...hinted at this but didn't outright say it til now...), because they don't really store memory to hold their values. instead they generate values on the fly as we loop over them.

## resources
- [notes from this guide](https://www.pythonmorsels.com/how-write-generator-expression/)
