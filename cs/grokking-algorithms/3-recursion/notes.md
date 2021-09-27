# recursion
there's no performance gain with recursion, but it can make it clearer

### base case vs recursive case
when you write a recursive function, you must tell it when to stop recursing. that's why every recursive function has two parts: the *base case* and the *recursive case*. the base case is when it doesn't call itself, and keeps it going into an infinite loop.

## the stack
- push: add new item to the top
- pop: remove the topmost item and read it

### call stack
the call stack whenever functions are called.

when you call a function from another function, the calling function is paused in a partially completed state

"this stack, used to save the variables for multiple functions, is called the call stack"

using the stack is convenient, but saving all that info can take a lot of memory.