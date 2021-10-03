# greedy algorithms
at each step, pick the locally optimal solution, and in the end, you're left with the globally optimal solution.

one example is the classroom scheduling problem.

the knapsack problem, but it's not always the best solution.

pretty good is enough. sometimes perfect is the enemy of good. sometimes, all you need is an algo that will solve the problem pretty well. and that's where the greedy algo shines, because they're simple to write and usually get pretty close.

## the set-covering problem
you're starting a radio station and want to be heard in every state. you're trying to minimize the number of stations you play on to keep costs low. each state covers a region and there's overlap. how do you figure out the smallest set of stations you can play on to cover all 50 states?
1. list every possible subset of stations. this is called the **power set**. there are 2^n possible subsets.
2. from these, pick the set with the smallest number of stations that covers all 50 states.

the problem is, it takes O(2^n) time. it's possible if you have a small set of stations, but will take forever if you have a lot of stations. 

what do you do?

### approximation algorithms
greedy algorithms to the rescue

1. pick the station that covers the most states that haven't been covered yet. it's ok if the station covers some states that have been covered already.
2. repeat until all the states are covered.

this is called an **approximation algorithm**. when calculating the exact solution will take too much time, an approximation algo will work. they are judged by:
- how fast they are
- how close they are to the optimal solution

greedy algorithms are good because not only are they simple to come up with, but that simplicity means they usually run fast, too. in this case, the greedy algo run O(n^2) times, where n is number of radio stations.

### code implementation
- `python3 cs/grokking-algorithms/8-greedy-algorithms/set-cover.py`

### sets
- set union == "combine both sets"
- set intersection == "find the items that show up in both sets"
- set difference == "subtract the items in one set from the items in the other set"

## NP-complete problems