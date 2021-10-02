# breadth first search
BFS uses a graph to find the shortest distance between two things.

you can use it to:
- write a checkers AI that calculates the fewest moves to victory
- write a spell checker
- find the doctor closest to you in your network

this book claims that graph algorithms are some of the most useful algorithms to know.

## shortest-path problem / breadth-first search
you want to ride a bus from point a to point b, with the minimum number of transfers. what's the algo to find the path with the fewest steps?

- can you get there in one step? here is where you can get in one step.
- can you get there in two steps?
- what about three steps?
- here is the route that you can get there in three steps, the shortest. you can also get there in four steps.
- this type of problem is called a *shortest-path problem*. you're always trying to find the shortest something. the algo to solve the shortest-path problem is called *breadth-first search*.

there are two steps:
1. model the problem as a graph
2. solve the problem using breadth-first search.

## graph
- a graph models a set of connections
- each graph is made up of **nodes* and **edges**
  - alex owes ramona money. alex and ramona are nodes. the connection between them is an edge.
- a node can be directly connected to many other nodes
  - these nodes are called its **neighbors**

graphs are a way to model how different things are connected to one another

## bread-first search
uses a graph. it can help answer two types of questions:
1. is there a path from node A to node B?
2. what is the shortest path from node A to node B?

we saw #2 with the bus trip problem. what about number 1?

you are a mango grower. you need somebody to sell them. you go through your friend's list and ask "can this person sell a mango?" this creates your search list. you also search your friends' friends, so you add all of those people to your search list. with this algorithm, you'll search your entire network until you come across a mango seller.

### finding the shortest path
you search the nearest nodes first, before you moveo onto the later nodes. 

### queue
two operations:
1. enqueue
2. dequeue

a queue is FIFO
a stack is LIFO

## implementing the graph
use a hash table! (a dict in python)

```python
bus_stops = {
    'clairmont': ['avondale', 'st. vincents', 'publix'],
    'publix': ['irondale', 'ruffner', 'clairmont']
}
```

- **directed graph**: has arrows, and the relationship follows the direction of the arrows.
- **undirected graph**: doesn't have arrows, and the relationship goes both ways.

## implementing the algorithm
1. keep a queue containing the people to check
2. pop a person off the queue
3. check if this person is a mango seller
4a. yes? you're done
4b. no? add their neighbors to the queue
5. loop
6. if the queue is empty, then there are no mango sellers in your network :( 

`python3 cs/grokking-algorithms/6-breadth-first-search/bfs.py`

### running time
if you search the entire network, then that means that you follow each edge. you also keep track of the searches.

Breadth-first search takes O(number of people + number of edges), and it’s more commonly written as O(V+E) (V for number of vertices, E for number of edges).

### topological sort
if you have a list of tasks and one task is dependent on another, then it's a "topological sort". it's a way to make an ordered list out of a graph.

a tree is a graph where no edges ever point back. like a family tree.