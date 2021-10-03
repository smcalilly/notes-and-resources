# dynamic programming

## knapsack problem
greedy algorithm doesn't always come up with the optimal answer. dynamic programming can.

dynamic programming starts by solving subproblems and builds up to solving the big problem.

for the knapsack problem, you start by solving the problem for smaller knapsacks (or "sub-knapsacks") and then working up to solve the original problem.

every dynamic programming algo starts with a grid. the rows are the items and the columns are the knapsack sizes from 1-4 lbs.

on row one is the guitar. at each grid, there's a simple decision: do you steal the guitar or not? the first cell has a capacity of 1lb. the guitar is also 1lb, so it fits in there. this means that the cell is worth $1.5k (the value of the guitar), and contains the guitar. fill up each cell with the guitar.

go to the next row, the stereo. the stereo doesn't fit in the bag, so steal the guitar etc. then it fits in the bag and it's worth more, so steal the stereo instead of the bag.

go to the next row, the laptop. it's worth $2k but weighs 3 pounds. at the 4 pound column, there is 1 lb left over. so you can get the guitar! since you've been tracking that the entire time.

- dynamic programming is useful when you're trying to optimize something given constraints.
- you can use dynamic programming when the problem can be broken into discrete subproblems, and they don't depend on each other.

### longest common substring
fish vs hish example. vs vista

add the value of the top-left neighbor + 1 

### longest common subsequence
fish vs fosh vs fort

a little different than longest common substring

## recap
- dynamic programming is useful when you're trying to optimize something constant
- you can use dynamic programming when the problem can be broken in discrete subproblems
- every dynamic programming solution involves a grid
- values in the cells are usually what you're trying to optimize
- each cell is a subproblem, so think about how you can divide your problem into subproblems
- there's no single formula for calculating a dynamic programming solution