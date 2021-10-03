# where to go next

## trees
binary search tree allows you to add new items without having to re-sort every time.

average search time: O(log n), worst case: O(n)

binary search tree is a lot faster for insertions and deletions on average.

it needs to be balanced for best performance. the red-black tree balances itself. B-trees are commonly used to store data in databases.

if you're interested in databases or more advanced data structures, learn about:
- B-trees
- Red-black trees
- Heaps
- Splay trees

## inverted indexes
a hash that maps words to places where they appear. commonly used to build search engines

## fourier transform
given a smoothie, the fourier transform will tell you the ingredients in the smoothie. or given a song, the transform can separate it into individual frequencies. 

this one has a lot of use cases. it's good for processing signals, helps you separate the signals in music so you can boost the bass and turn down the treble. or compress music.

here's a good place to learn about it: https://betterexplained.com/articles/an-interactive-guide-to-the-fourier-transform/

## parallel algorithms
to make your algos faster, you need to change them to run in parallel across all of your machine's cores at once.

there's a parallel version of quicksort that will sort an array in O(n) time.

they're hard to design.
- overhead of managing parallelism
- load balancing, need to balance the work across cores so one isn't doing all the hard work

## MapReduce
an popular distributed algorithm, apache hadoop is a popular tool for this.

suppose you have  a table with billions or trillions of rows, and you need to run a complicated sql query. use MapReduce through hadoop.

or suppose you have to process a long list of jobs. each job takes 10 seconds to process, and you need to process 1 million jobs like this. if you can run it across 100 machines, it might be done in a few days.

it uses a `map` function and a `reduce` function.

## bloom filters and HyperLogLog
suppose you're saving urls and don't want to save a url that you already have. use a hash table, but this hash table could become too big.

### bloom filters
bloom filters are probablistic data structures. they give you an answer that could be wrong but is probably correct. instead of a hash, you can ask the bloom filter if you've crawled this url before.

it's probably correct:
- false positives are possible. the bloom filter might say, you've already crawled this site, even though you haven't.
- false negatives are not possible. if the bloom filter says, "you have not crawled this site", then you definitely have not.

bloom filters take up very little space, vs a hash table. 

### HyperLogLog
gives you a probablistic count of how many unique items a visitor has viewed, etc

## the SHA algorithms
given a string, SHA gives you a hash for that string. it creates a unique hash for every string. it's a good way to compare files and make sure you have the same file. you calculate the sha hash for the two files and compare them.

### checking passwords
it's also useful when you want to compare strings without revealing what the strings are. like for passwords, so you don't have to strong the plaintext password, but instead store the SHA hash of it. it's a one-way hash, you can't get the original string from the hash.

### locality-sensitive hashing
with SHA hash, if you change just one character from the string, the hash will be completely different. a locally-sensitive hash will make them only slightly different. SimHash. this allows you to generate hashes and see how similar two strings are. google uses SimHash to detect duplicates when crawling the web. a teacher could use SimHash to see if a student is plagarizing.

## Diffie-Hellman key exchange
how do you encrypt a message so it can be read only by the person you sent it to?

ciphers are easy to break. diffie-hellman solves the problem:
- both parties don't know the cipher, so we don't need to exchange it somehow.
- the encrypted messages are *extremely* hard to decode.

it uses a public key and a private key. the public key can be public. when somebody wants to send you a message, they encrypt it using the public key. an encrypted message can only be decrypted using the private key. as long as you're the only person with the private key, then you can decrypt the message.

diffie-hellman's successor is RSA. if you're interested in cryptography, diffie-hellman is a good place to start.

## linear programming
used to maximize something given constraints. you make shirts and totes. each item takes a certain amount of materials. you make $2/shirt and $3/tote. how many of each do you make to maximize profit, based on material on hand?

linear programming can solve this. it uses the Simplex algorithm. if you're interested in optimization, look up linear programming

