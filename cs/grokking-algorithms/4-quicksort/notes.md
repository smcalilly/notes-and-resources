# quicksort

## divide and conquer
- well known recursion technique for solving problems.
- quicksort is a big d&c algo. much faster than selection sort.

### example
you're a farmer with a plot of land. you want to divide the plot evenly into square plots. you want the plots to be as big as possible.

- how do you figure out the largest square size you can use for a plot of land? use the d&c strategy

### d&c algorithm
- recursive algo with two steps:
  1. figure out the base case. this should be the simplest possible case.
  2. divide or decrease your problem until it becomes the base case.

oh i see. go look at the book to review. you basically keep going down until you find the area that's filled up by only squares. easier to draw than write.

it's not a simple algo that you can apply to a problem, instead it's a way to think about a problem.


#### euclidean algorithm
technique for finding the greatest common denominator of two integers.

TODO: [come back here](https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/the-euclidean-algorithm)


### exercises
- you're given an array of numbers
- how do you add all of them recursively?
  - `python3 cs/grokking-algorithms/4-quicksort/sum-recursively.py`

- write out a recursive function to count the number of items in a list
  - `python3 cs/grokking-algorithms/4-quicksort/count.py`

- find the largest number in a list
  - `python3 cs/grokking-algorithms/4-quicksort/max_num.py`

- binary search, recursively
  - `python3 cs/grokking-algorithms/4-quicksort/binary_search.py`

### tips for solving recursively
- figure out how to solve the base case
- then figure out how to reduce the problem to get to the base case
  - for iterating through an array to sum them all, you need to move closer to any empty array with every recursive call
  - decreasing the size of your problem
- !
- when you're writing a recursive function involving an array, the base case is often an empty array or an array with one element. if you're stuck, try that first

## quicksort
quicksort is a sorting algorithm that's much faster than selection sort. it's frequently used in real life.

empty arrays and arrays with just one element will be the base case.

```python
def quicksort(arr):
    if len(arr) < 2:
        return array
```

what about bigger arrays?

you're using divide and conquer, so you want to break down the array until you're at the base case. 
1. pick an element from the array. this element is called the *pivot*.
2. find the elements smaller than the pivot and larger than the pivot. this is called *partitioning*.
  - now you have:
    - a sub-array of all the numbers less than the pivot
    - the pivot
    - a sub-array of all the numbers greater than a pivot
  - the two sub-arrays aren't sorted, they're just partitioned.

#### inductive proofs
- inductive proofs are one way to prove that your algorithm works. each inductive proof has two steps: the base case and the recursive case. if the quicksort works on 1 item in the array, then it will work on 2 items. if it works on 2 items, then it will work on 3 items, etc.

### quicksort code
-  `python3 cs/grokking-algorithms/4-quicksort/quicksort.py`


#### big o notation
quicksort is unique because it's speed depends on the pivot you choose. it's O(n log n) on average.


#### merge sort vs quicksort

#### average case vs worst case