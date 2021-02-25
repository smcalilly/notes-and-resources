# the imposter's handbook

## complexity theory
you think about complexity in terms of time as you scale the inputs that go into the algorithm that you're using to solve the problem

### P time
```
T = 2x
```
- **polynomial equation**: an expression consisting of variables and coefficients which only employs the operations of addition, subtraction, multiplication, and non-negative integer exponents

when the complexity of an algorithm scales according to a polynomial equation, mathematicians say it scales in "P time", where `P` stands for polynomial.
- these algorithms are the simpliest and often the most boring to work with
- things like sorting, searching, zipping, and enumerating all happen in `P` time

complexity theory isn't concerned with the algorithms, it focuses on the problems themselves and how hard it is to solve.
- `P` is a complexity class that describes the set of all problems solvable in `P` time. things like sorting and searching arrays, arranging your sock drawer, etc
	- in other words, simple problems
	- less interesting and not what programmers want to spend their time on
	- it's boring. 99% of the time, programmers aren't working on problems in the P class. programmers have more complex problems in their own category

### hard problems (`exp`)
**factorial process**, or `n!`, where `n` is the number of people involved. the problem is "exponentially complex", aka it is solvable in `Exp` time.

exponential time problems are solvable in:
```
T = 2^n
```
where `T` is time, `n` are the inputs

exponential time is a very very very long time. but just because a problem is in `Exp` doesn't mean it will always take a long time to solve, this is just a classification of complexity. almost every problem we can think or care about solving is in `Exp`.


### all solvable problems (`r`)
`R` represents all of the problems that are solvable in finite time. in other words, any problem that we can solve is classified in `R`.

### infinitely complex problems beyond R
what are some?
- the halting problem -- `NP-Hard`

### Determinism, Nondeterminism, and magical guesses

#### deterministically
we execute a routine and get a result. based on that result, we'll execute another and another until we arrive at an answer.

#### nondeterministically
execute a routine to get a result and maybe execute some more steps. don't know which next steps from that series will be executed - it will be decided at that time. keep doing this until we arrive at the answer. when we do have an answer, there is no way of determining how we got there. think of it as a series of lucky guesses or random changes to figure out the answer to a problem.

back to the example of friends deciding on which restaurant to eat at
- used a nondeterministic process - took an exponentially complex problem and solved it in `P` time using a nondeterministic process

these problems are classified as `NP`: problems solvable in `P` time given an nondeterminstic algorithm. `NP` can be thought of as a mythical time frame, bc we don't know if a nondeterministic algorithm is possible. if it is possible, then we can say that a given problem is solvable in **nondeterministic polynomial time**

a problem is classified in nondeterministic polynomial time (`NP`), if it is:
- solvable in exponential time (`Exp`)
- verifiable in polynonmial time (`P`)
- also solvable in polynomial time by nondeterministic methods

"NP is where the action. NP problems are what brains enjoy the most"

### does P=NP ?
some folks think that it's a matter of time before we have a computer chip or alogrithm capable of nondeterministic processing. others think it's dumb.

if a nondeterministic algorithm is ever developed that can solve these problems, then all of the problems in `NP` suddenly become solvable in `P` time. put in math: `P = NP`. if such an algo could never exist, then `P != NP`. we can't make either claim because we don't know the answer.

### reductions and NP
you can look at a problem a different way and it might be classified differently. if you look at optimization for the author's "pub problem", then it will always be `Exp`. if you reduce the problem to a decision problem, then the problem is classifiable in `NP`. strange, because it's the same problem.

there are two classifications for such an issue:
1. `NP-Hard`: problems that can be reduced to other problems in `NP`, but are not within `NP` themselves.
2. `NP-Complete`: decision problems classifiable in `NP`

decision problems are almost always `NP-Comple` because of the ability to verify the answer to the problem. combinatorial problems are `NP-Hard`.

#### halting problem
back to the halting problem. it's beyond `R`, it is, however, a simple decision problem: will this program halt? because of that, other problems in `NP` can be reduced to it, and that's all you need for a classification of `NP-Hard`.

### NP-Complete and decisions
one of the main goals of turning a complex problem into a decision problem is the idea of verification. with our inital combinatorial pub selection problem, we can only verify that we have indeed gone to the optimal pub for our group by going through every iteration of the decision process for each person and each pub.

the decision problem, however, is very easy to verify, as we did above.

#### Cook-Levin Theorem
these problems were formalized by Leonid Levin and Stephen Cook in the early 1970s. this theorem states that any problem in `NP` can be reduced to what's known as "The Boolean Satisfiability Problem (SAT)":
- in CS, the Boolean Satisfiability Problem ... is the problem of determining if there exists an interpretation that satisfies a given boolean formula. in other words, it asks whether the variables of a given boolean formula can be consistently replaced by the values of True or False in such a way that the formula evaluates to True.

think, massive decision tree, a flow chart with lots of branches, those are variations of SAT.

### classic NP-complete problems
richard karp's "Reducibility Among Combinatorial Problems" shoed that you can reduce a number of `NP` problems to `SAT` in polynomial time. he came up with a list called ["Karp's 21 NP-Complete Problems"](https://en.wikipedia.org/wiki/Karp%27s_21_NP-complete_problems). the knapsack problem is one example.

#### knapsack
combinatorial optimization problem that centers on packing a bag for a weekend.

#### clique
first formulated in 1935 and has to do with graphs and graph theory:
- consider a social network, where the graph's vertices represent people, and the graph's edges represent mutual acquaintance. then a clique represents a subset of people who all know each other, and algos for finding cliques can be used to discover these groups of mutual friends.

#### bin packing
variation of knapsack and once again a combinatorial optimazation problem. think, how many books can you pack into a cardboard box to ship to a customer? we can reduce the problem to a decision problem by iteratiing over bin configurations and asking if the current configuration is optimal. this reduction turns the combinatorial problem into a decision problem, which would classify it as a `NP-Complete`.

#### traveling salesman
classic `NP-Hard` problem of trying to figure out the cheapest way to send a salesman on a trip. once again, a combinatorial optimization problem, which we can recognize as `NP-Hard`. you can reduce this in `P` time to an `NP-Complete` decision problem by simply enumerating through every valid path and asking: "is there a path that's shorter?"

### approximations and laziness
algorithms exist which "solve" these in `P` time. these are called approximations and are very useful if you can tolerate their inexact nature.

for traveling salesman, you can start in LA and to the next nearest city, like San Francisco. when you get there, you'll see that Reno is the next nearest, so you go there. this approach is called "nearest neighbor" and is classified as a "greedy algorithm", which means you do what suits your current position and value on the graph. nearest neighbor usually returns a path within 25% of the shortest one, on average. what that work for your? for many companies, it just might.

### in the real world
author wants to share a story about getting fired. but first, let's recap what we know:
- simple, rather boring problems can be solved in a short amount of time; what mathematicians would call `P` time.
- more difficult problems, such as a group of people trying to decide on the optimal location for a pint and some food, are more complex and solvable in exponential time, or `Exp`.
- some problems are so complex that they can't be solved in all the time we possibly have (`R`, or "finite time"), and are simply undecidable. for instance, Turing's Halting Problem
- there are special subclasses of problems that are of great interest to us, specifically: exponentially complex problems that we can solve in `P` time with a nondeterministic lucky guyess. these problems are called `NP`. we can further divide this complexity class into decision problems that we can quickly verify (`NP-Complete`), and more complicated problems that are in `Exp`, but that other problems in `NP` can be reduced to in `P` time (`NP-Hard`). (that last sentence is verbatim and confusing)

he got fired because of poor communication. he claims that if he knew more about complexity, then he could've talked to the client and explained to them how they're asking for something really hard.
