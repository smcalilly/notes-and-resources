# Lambda Calculus
I can't find my notes from the first time I read this chapter, which is probably a good thing because, if we're being honest, I'm not sure I fully understand everything when I first read it. 

before computers or programming languages, alonzo church came up with a set of rules for working with functions (what he termed "lambdas"). these rules allow you to compute anything that can be computed. you use lambda calculus everyday when you write code.

simple question: how do you compute something? the steps to solving certain problems (aka algorithms) had been known for millennia, but how do you give these algorithms to a machine? is there a limit to what a machine can calculate? are there solutions that machines simply cannot computer?

this led to some important work by Alonzo Church. the following is a summary about the broad topic of lambda calculus, so you're not an expert after reading this chapter.

resources for future study:
- [detailed explanation of Y Combinator and Ω Combinator from Ayaka Nonaka](https://medium.com/@ayanonagon/the-y-combinator-no-not-that-one-7268d8d9c46)
- [jim weirich's keynote on the Y Combinator](https://www.youtube.com/watch?v=FITJMJjASUs)
- [a github repo that has all kinds of Church encoding magic](https://github.com/benji6/church)


## the basics
alonzo church introduced lambda calculus in the 1930s as he was studying the foundations of mathematics. as a programmer, you might recognize the description:
- "the λ-calculus is, at heart, a simple notation for functions and application. the main ideas are applying a function to an argument and forming functions by abstraciton. the syntax of basic λ-calculus is quite sparse, making it an elegant, focused notation for representing functions. functions and arguments are on a par with one another. the result is an intensional theory of functions as sets of ordered pairs. despite its sparse syntax, the expressiveness and flexibility of the λ-calculus make it a cornucopia of logic and mathematics."

a lambda is simply an anonymous function that can thought of as a value. most programming languages have some notion of an anonymous funciton, expression, or lambda. this came from lambda calculus. in fact, lambda calculus is the foundation of what we consider programming today.

lambda calculus is an abstract notation that describes formal mathematical logic. there are no numbers or types, only functions. like modern functional languages, a function in lambda calculus can be treated as a value. by arranging these functions carefully, you can build out some interesting structures. (think, javascript higher order functions)

## rules
the rules are simple:
- there are only functions, nothing else. no data types (strings, numebrs, etc) of any kind.
- you can substitue functions using variables
- you can reduce one function to another through application
- you can combine multiple terms in lambda calculus to create a higher-order function called a **combinator**, which is where the fun begins

a lambda calculus function is sometimes called a "term" or "expression":
```lambda
λ x.x
```
- `λ` denotes a lambda function
- first `x` is the argument to the function
- final part of the expression is the body, which is the other `x` and seperated from the argument by a `.`.

with javascript, it would look like:
```javascript
function thing(x){
  return x
}
```

ES6 syntax:
```javascript
(x => x)
```

this ES6 example is a pure lambda expression in the following ways:
- it takes an argument, `x`, and since we're using a single line, the value `x` is also returned.
- it is a functional **closure**, which means we can set this expression to a variable and invoke it anywhere without worrying about scoping issues.
- lambdas are the same as values

in this way, javascript follows lambda calculus conventions rather closely.

## function application
our first function:
```lambda
λx.x
```

the function takes an argument `x` and returns it. we can apply a value to this function like so:
```lamnda
λx.x (y)
```

this notation means "substitute all occurances of x with y" and is called **function application**. it would be this in javascript:
```javascript
(x => x)(y)
// or
function thing(x){return x}(y)
```

this function `x.x` has a special name: **the identity function**. whatever you pass to it is returned. it's also called the **I Combinator**, which we'll discuss in a bit.

consider this function and application:
```lambda
λx.y (z)
```

the same in javascript:
```javascript
function thing(x){return y}(x)
```

"With this function: `λx.y`, it doesn’t matter what you pass into it, some value `y` will be returned. This is called the constant function as it returns a constant value of `y` no matter what you pass in for `x`."

## bound and free variables
there are rules when you apply a value to a function. in the function `λx.y (z)`, there are two variables: `x` and `y`. 
- the variable `x` is in the function head as the argument and thus is **bound** to this expression.
- the variable `y` is not bound to any lambda function, so it's known as **free**

the difference between the two is very important. i can substitute `x` in this function if i substitute every occurence of the bound variable `x`. so if i wanted to change x to z, for instance, i could:
```lambda
λz.z y
```

this wouldn't change the meaning of the function. if i tried to change `y`, then we would have some trouble. to understand why, we need to dive into substitutions and reductions.

(question): the examples for this concept are confusing. he introduces this idea like: "In this expression we’re dealing with two variables: x and y." i'm not sure which expression he's talking about? the one from the previous section? i tried using the one for the previous section (`λx.y (z)`), but that doesn't match his substitution: `λz.z y`. what am i misunderstanding? i can understand this: `λz.z y`, it would look like this in javascript: `(z => z)(y)`. `y` is applied to the anonymous function, via the `z` argument. `z` can be replaced with `x`, so this expression would do the same thing: `(x => x)(y)`. in lambda calculus: `λx.x (y)`

glad to have worked with javascript and already using some of these ideas without realizing it.

## substitution and reduction
when you apply a value to a function, you substitute that value in the function itself. substitution is *left-applicative*, which means that you start on the left and move to the right as required.

for instance, let's substitute and then reduce this function:
```lambda
λx.x 3
```




