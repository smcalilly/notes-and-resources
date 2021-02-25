# the imposter's handbook

## complexity theory
- you think about complexity in terms of time as you scale the inputs that go into the algorithm that you're using to solve the problem

### P time
```
T = 2x
```
polynomial equation = an expression consisting of variables and coefficients which only employs the operations of addition, subtraction, multiplication, and non-negative integer exponents

when the complexity of an algorithm scales according to a polynomial equation, mathematicians say it scales in "P time", where P stands for polynomial.
- these algorithms are the simpliest and often the most boring to work with
- things like sorting, searching, zipping, and enumerating all happen in P time

complexity theory isn't concerned with the algorithms, it focuses on the problems themselves and how hard it is to solve
- P is a complexity class that describes the set of all problems solvable in P time, things like sorting and searching arrays, arranging your sock drawer, etc
	- in other words, simple problems
	- less interesting and not what programmers want to spend their time on
	- it's boring. 99% of the time, programmers aren't working on problems in the P class. programmers have more complex problems in their own category

### hard problems (exp)
factorial process, or n!, where n is the number of people involved
the problem is "exponentially complex", aka it is solvable in Exp time

exponential time problems are solvable in:
```
T = 2^n
```
where T is time, n are the inputs

exponential time is a very very very long time.
but just because a problem is in Exp doesn't mean it will always take a long time to solve, this is just a classification of complexity
almost every problem we can think or care about solving is in Exp


### all solvable problems (r)
R represents all of the problems that are solvable in finite time. in oteher words, any problem that we can solve is classified in R.

### infinitely complex problems beyond R
what are some?
- the halting problem -- NP-Hard

### Determinism, Nondeterminism, and magical guesses
- deterministically - we execute a routine and get a result. based on that result, we'll execute another and another until we arrive at an answer
- nondeterministicallt - execute a routine a get a result and maybe execute some more steps. don't know which next steps from that series will be executed - it will be decided at that time. keep doing this until we arrive at the answer. when we do have an answer, there is no way of determining how we got there. think of it as a series of lucky guesses or random changes to figure out the answer to a problem

back to the example of friends deciding on which restaurant to eat at
- used a nondeterministic process - took an exponentially complex problem and solved it in P time using a nondeterministic process

these problems are classified as NP: problems solvable in P tmie given an nondeterminstic algorithm. NP can be thought of as a mythical time frame, bc we don't know if a nondeterministic algorithm is possible. if it is possible, then we can say that a given problem is solvable in **nondeterministic polynomial time**

a problem is classified in nondeterministic polynomial time (NP), if it is:
- solvable in exponential time (Exp)
- verifiable in polynonmial time (P)
- also solvable in polynomial time by nondeterministic methods

"NP is where the action. NP problems are what brains enjoy the most"

### does P=NP ?
