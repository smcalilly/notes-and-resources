# hash tables
O(1) time lookup (aka constant time)

## hash function
a hash function maps strings to numbers.
- it needs to be consistent and always return the same thing based on the input
- it should map different words to different numbers

combine a hash function and an array, and you'll have a hash table. aka hash maps, maps, dictionaries, and associative arrays.

a hash table has keys and values.

## use cases
- create a mapping from one thing to another thing
- look something up
- contacts in your phone
- DNS resolution (maps website name to ip address)
- preventing duplicate entries
- use it as a cache

## collisions
lots of different ways to work around one. if multiple keys map to the same slot, start a linked list at that slot. not the best solution tho. if the linked list gets long, it slows down your hash table. but they won't get too long if you use a good hash function. your keys need to disperse the mapping evenly over the hash, not all in the same place.

to avoid collisions, you need:
- a low load factor
- a good hash function

## performance
average case, hash table lookup takes constant time. in the worst case, a hash table take O(n) time (linear time).

### load factor
load_factor = (number of items in hash table) / (total number of spots)

having a load factor greater than 1 means that you don't have enough slots, you have more items than slots in your array. once the load factor starts to grow, you need to add more slots to your hash table. this is called **resizing**. the rule of thumb is to make an array that's twice the size. resize when your load factor is greater than 0.7. resizing is expensive and you don't want to resize too often

### a good hash function
- a good hash function distributes values evenly in the array.
- a bad hash function groups values together and produces a lot of collisions.

what is a good hash function? this book claims that i'll never have to do this. if i'm really curious, this book recommends i look up the SHA function.