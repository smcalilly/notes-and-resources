# selection sort
memory - storing things, each address is a slot of memory

## arrays and linked lists
using an array means that the items are stored contiguously in memory. but what if there's not contiguous space? you gotta find contiguous space, etc. but what happens when you add more items and run out of contiguous space? linked lists solve this problem.

### linked lists
with linked lists, your items can be anywhere in memory. each item stores the address of the next item in the list. a bunch of random memory addresses are linked together. 

### arrays
what are arrays for? they're good for reading random elements, because you know the addresses of the items. where a linked list need to go in order. in a linked list, you can't access the fifth item without iterating 1-4 to find the next address.

the elements in an array are numbered. the position of an element is called its *index*.

#### inserting into the middle of a list
which is better?
- linked list, because you just change what the previous element points to. with arrays, you gotta shift all the rest of the elements down.

#### deletions
linked lists are better, because you just need to change what the previous element points to.

#### run times
- reading
    - arrays: O(1)
    - linked list: O(n)
- insertion
    - arrays: O(n)
    - linked list: O(1)
- deletion
    - arrays: O(n)
    - linked list: O(1)

#### access
arrays allow *random access*. linked list allow *sequential acccess*

## selection sort
suppose you have a bunch of music on your computer. for each artist, you have a play count. you want to sort this list from most to least played. how do you do this?

one way is by going through the list and finding the most played artist, and adding it to a new list.

this takes O(n<sup>2</sup>) time. not very fast tho. quicksort is faster, we'll learn it later.

### example code
```bash
python3 cs/grokking-algorithms/2-selection-sort/selection-sort.py
```

## recap
- your computer's memory is like a giant set of drawers
- use an array or linked list when you want to store multiple elements
- with an array, all your elements are stored next to each other
- with a linked list, elements are strewn all over the place, and one element stores the address of the next one
- arrays allow fast reads
- linked lists allow fast inserts and deletes
- all elements in the array should be the same type