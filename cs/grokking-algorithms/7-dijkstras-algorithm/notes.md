# dijkstra's algorithm
last chapter, we found the shortest path. it's the shortest by number of segments, but it doesn't factor in travel time. breadth-first search finds the path with the fewest segments. but what if you want the fastest path? that's what dijkstra's algorithm does.

four steps:
1. find the "cheapest" node. this is the node you can get to in the least amount of time.
2. update the costs of the neighbors of this node.
3. repeat until you've done this for every node in the graph.
4. calculate the final path

step 1:
- you're standing at the start, looking at two nodes. how long does it take to get to each node?
  - node B is the shortest node

step 2:
- calculate how long it takes to get to all of node b's neighbors by following an edge from B.
- hey! you just found a shorter path to node A
- update your times

step 3:
- repeat

you've run the algo for every node. at this point, you know:
- it takes 2 minutes to get to node B
- it takes 5 minutes to get to node A
- it takes 6 minutes to get to the finish

in dijkstra's algo, you assign a number or weight to each segment. then find the path with the smallest total weight.

## terminology
with dijkstra's algorithm, each edge has a number associated with it. these are called **weight**. a graph with weights is called a **weighted graph**. a graph without weights is called an **unweighted graph**.

graphs can also have **cycles**. it means you can start at a node and end up back at the starting node. an undirected graph means that both nodes point at each other. that's a cycle. dijkstra's algorithm works only on a graph with no cycles, or graphs with a positive weight cycle.

## trading for a piano
rama is trying to trade his way from a music book to a piano.

make a table of the cost for each node. the cost of a node is how expensive it will get. you'll keep updating the table as the algo goes on. to calculate the final path, you also need a parent column on this table.

1. find the cheapest node. a poster for $0.
2. figure out what it takes to get to its neighbors. this is the cost.
3. repeat with the next cheapest node. in this case, it's the LP at $5. it's cheaper to get from the LP to the drums and bass guitar, so you update those nodes with the LP as the parent. the bass guitar is the next cheapest node. update its neighbors. now you have a price for the piano, by trading the bass for piano. so you set the bass as the parent. then do it for the drumset. in this case, rama can get the piano even cheaper by trading the drumset, rather than the bass. so the cheapest set of trades will cost rama $35.

now you need to figure out the path. you know that the shortest path costs $35, but how do you figure out the path. to start, look at the parent for piano. the drums. by following the path backwards, you have the complete path.

the shortest path doesn't have to be about physical distance. it can be about minimizing something. for rama, it was minimizing money spent.

## negative weight edges
what if there is a trade where rama would get paid some money for a trade?

you can't use dijkstra's alogrithm if you have negative-weight edges. they break the algorithm.

todo: come back to this to understand better. if you want to find the shortest path in a graph with negative-weight edges, use the **Bellman-Ford algorithm**.

## implementation